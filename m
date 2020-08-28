Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B30912552D0
	for <lists+linux-integrity@lfdr.de>; Fri, 28 Aug 2020 03:57:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728364AbgH1B5Y (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 27 Aug 2020 21:57:24 -0400
Received: from linux.microsoft.com ([13.77.154.182]:38500 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728353AbgH1B5V (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 27 Aug 2020 21:57:21 -0400
Received: from tusharsu-Ubuntu.lan (c-71-197-163-6.hsd1.wa.comcast.net [71.197.163.6])
        by linux.microsoft.com (Postfix) with ESMTPSA id 5BEF120C27C5;
        Thu, 27 Aug 2020 18:57:20 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 5BEF120C27C5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1598579840;
        bh=/oNkgUW9zSIuVV9hzhJDu+lqIFChEKC0BuHbXmW5m3Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Cyz/YHC3WltXaOC2W1Hu7dvdzMKlVlrik0OyrAKvc3bYjiBOWarXk/sMLKG5Rg302
         fbDJaPYrLp1qHtc2FhixkEyPt5aRcJ9BDsKfLQZuW7svV2PjA1czuY27qzJ0eRdFwn
         TEcJ+5giT+ILXTcXHTRG3KaEqEnPdHzOp8Y6cqDM=
From:   Tushar Sugandhi <tusharsu@linux.microsoft.com>
To:     zohar@linux.ibm.com, stephen.smalley.work@gmail.com,
        casey@schaufler-ca.com, agk@redhat.com, snitzer@redhat.com,
        gmazyland@gmail.com
Cc:     tyhicks@linux.microsoft.com, sashal@kernel.org, jmorris@namei.org,
        nramas@linux.microsoft.com, linux-integrity@vger.kernel.org,
        selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dm-devel@redhat.com
Subject: [PATCH v3 6/6] IMA: validate supported kernel data sources before measurement
Date:   Thu, 27 Aug 2020 18:57:04 -0700
Message-Id: <20200828015704.6629-7-tusharsu@linux.microsoft.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200828015704.6629-1-tusharsu@linux.microsoft.com>
References: <20200828015704.6629-1-tusharsu@linux.microsoft.com>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Currently, IMA does not restrict random data sources from measuring their
data using ima_measure_critical_data(). Any kernel data source can call
the function, and it's data will get measured as long as the input
event_data_source is part of the IMA policy -
CRITICAL_DATA+critical_kernel_data_sources. This may result in IMA log
getting bloated by random data sources. Supporting random data sources
at run-time may also impact the reliability of the system. 

To ensure that only data from supported sources are measured, the kernel
component needs to be added to a compile-time list of supported sources
(an "allowed list of components") in ima.h. IMA then validates the input
parameter - event_data_source passed to ima_measure_critical_data()
against this allowed list at run-time.

Provide an infrastructure for kernel data sources to be added to
the supported data sources list at compile-time. Update
ima_measure_critical_data() to validate, at run-time, that the data
source is supported before measuring the data.
Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
---
 security/integrity/ima/ima.h      | 29 +++++++++++++++++++++++++++++
 security/integrity/ima/ima_main.c |  3 +++
 2 files changed, 32 insertions(+)

diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index 00b84052c8f1..ecb0a1e7378f 100644
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
index a889bf40cb7e..41be4d1d839e 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -888,6 +888,9 @@ int ima_measure_critical_data(const char *event_name,
 	if (!event_name || !event_data_source || !buf || !buf_len)
 		return -EINVAL;
 
+	if (!ima_kernel_data_source_is_supported(event_data_source))
+		return -EPERM;
+
 	return process_buffer_measurement(NULL, buf, buf_len, event_name,
 					  CRITICAL_DATA, 0, event_data_source,
 					  measure_buf_hash);
-- 
2.17.1

