Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECD7A2A2221
	for <lists+linux-integrity@lfdr.de>; Sun,  1 Nov 2020 23:27:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727527AbgKAW0r (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 1 Nov 2020 17:26:47 -0500
Received: from linux.microsoft.com ([13.77.154.182]:42038 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727422AbgKAW0j (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 1 Nov 2020 17:26:39 -0500
Received: from tusharsu-Ubuntu.lan (c-71-197-163-6.hsd1.wa.comcast.net [71.197.163.6])
        by linux.microsoft.com (Postfix) with ESMTPSA id 127BC20BE4BC;
        Sun,  1 Nov 2020 14:26:38 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 127BC20BE4BC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1604269598;
        bh=L8AL5FjMDMUnNs/DDSqfOFY2BRGZgyBH0y0jAa33F1s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=B2Pic/YU9QHqQeoKLw9Yx6m8tX1tSnmXhBxZYZgsEBMI9b0XigbYMhLgieM9vY1Zp
         m3PgawnXMAyCAS6VeXXFfdELSasTmqu9x/ErHr1FTS4yekzHhaqnIu3hyhI8On0wfu
         rt0XP65TRa2jrLc+Wcl3vGPyiWQBTBvXMuWl3a98=
From:   Tushar Sugandhi <tusharsu@linux.microsoft.com>
To:     zohar@linux.ibm.com, stephen.smalley.work@gmail.com,
        casey@schaufler-ca.com, agk@redhat.com, snitzer@redhat.com,
        gmazyland@gmail.com, paul@paul-moore.com
Cc:     tyhicks@linux.microsoft.com, sashal@kernel.org, jmorris@namei.org,
        nramas@linux.microsoft.com, linux-integrity@vger.kernel.org,
        selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dm-devel@redhat.com
Subject: [PATCH v5 5/7] IMA: validate supported kernel data sources before measurement
Date:   Sun,  1 Nov 2020 14:26:24 -0800
Message-Id: <20201101222626.6111-6-tusharsu@linux.microsoft.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201101222626.6111-1-tusharsu@linux.microsoft.com>
References: <20201101222626.6111-1-tusharsu@linux.microsoft.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Currently, IMA does not restrict random data sources from measuring
their data using ima_measure_critical_data(). Any kernel data source can
call the function, and it's data will get measured as long as the input
event_data_source is part of the IMA policy - CRITICAL_DATA+data_sources.

To ensure that only data from supported sources are measured, the kernel
subsystem name needs to be added to a compile-time list of supported
sources (an "allowed list of components"). IMA then validates the input
parameter - "event_data_source" passed to ima_measure_critical_data()
against this allowed list at run-time.

This compile-time list must be updated when kernel subsystems are
updated to measure their data using IMA.

Provide an infrastructure for kernel data sources to be added to
IMA's supported data sources list at compile-time. Update
ima_measure_critical_data() to validate, at run-time, that the data
source is supported before measuring the data coming from that source.

Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
---
 security/integrity/ima/ima.h      | 29 +++++++++++++++++++++++++++++
 security/integrity/ima/ima_main.c | 12 ++++++++++++
 2 files changed, 41 insertions(+)

diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index c1acf88e1b5d..4a35db010d91 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -228,6 +228,35 @@ extern const char *const func_tokens[];
 
 struct modsig;
 
+#define __ima_supported_kernel_data_sources(source)	\
+	source(MIN_SOURCE, min_source)			\
+	source(MAX_SOURCE, max_source)
+
+#define __ima_enum_stringify(ENUM, str) (#str),
+
+enum ima_supported_kernel_data_sources {
+	__ima_supported_kernel_data_sources(__ima_hook_enumify)
+};
+
+static const char * const ima_supported_kernel_data_sources_str[] = {
+	__ima_supported_kernel_data_sources(__ima_enum_stringify)
+};
+
+static inline bool ima_kernel_data_source_is_supported(const char *source)
+{
+	int i;
+
+	if (!source)
+		return false;
+
+	for (i = MIN_SOURCE + 1; i < MAX_SOURCE; i++) {
+		if (!strcmp(ima_supported_kernel_data_sources_str[i], source))
+			return true;
+	}
+
+	return false;
+}
+
 #ifdef CONFIG_IMA_QUEUE_EARLY_BOOT_KEYS
 /*
  * To track keys that need to be measured.
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index 6e1b11dcba53..091c2e58f3c7 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -937,6 +937,12 @@ void ima_kexec_cmdline(int kernel_fd, const void *buf, int size)
  * A given kernel subsystem (event_data_source) may send
  * data (buf) to be measured when the data or the subsystem state changes.
  * The state/data change can be described by event_name.
+ * Before the first use of this function by a given kernel subsystem,
+ * the subsystem name (event_data_source) must be added to the
+ * compile-time list of data sources being measured -
+ * i.e. __ima_supported_kernel_data_sources.
+ * Otherwise, IMA will not measure any data for that event_data_source
+ * at run-time.
  * Examples of critical data (buf) could be kernel in-memory r/o structures,
  * hash of the memory structures, or data that represents subsystem
  * state change.
@@ -954,6 +960,12 @@ void ima_measure_critical_data(const char *event_data_source,
 		return;
 	}
 
+	if (!ima_kernel_data_source_is_supported(event_data_source)) {
+		pr_err("measuring data source %s is not permitted",
+		       event_data_source);
+		return;
+	}
+
 	process_buffer_measurement(NULL, buf, buf_len, event_name,
 				   CRITICAL_DATA, 0, event_data_source,
 				   measure_buf_hash);
-- 
2.17.1

