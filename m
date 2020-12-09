Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D95F62D4AB9
	for <lists+linux-integrity@lfdr.de>; Wed,  9 Dec 2020 20:44:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387942AbgLITnz (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 9 Dec 2020 14:43:55 -0500
Received: from linux.microsoft.com ([13.77.154.182]:47628 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387840AbgLITnp (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 9 Dec 2020 14:43:45 -0500
Received: from tusharsu-Ubuntu.lan (c-71-197-163-6.hsd1.wa.comcast.net [71.197.163.6])
        by linux.microsoft.com (Postfix) with ESMTPSA id 0904320B718B;
        Wed,  9 Dec 2020 11:42:26 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 0904320B718B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1607542946;
        bh=a5f+ij0E0tDSy+bJfyUc0/IK+DK1TBFrlmTbWMu4t+0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FD3vrDkDlo6QTkWauiE9QzwtM+mluPQ6yhVNFD7T9OU9ijug1v0jKhU5B8IENxgZK
         e4Yg5U8HpJnQtE/yaVj3LmJ44f4giK57g87WSXqoqjcr2evPDuAr4Utmy7yLFx7JC4
         Rpzd0ypeZLHaLdR6SdaprLtBjpSLXIN8Qo326gNQ=
From:   Tushar Sugandhi <tusharsu@linux.microsoft.com>
To:     zohar@linux.ibm.com, stephen.smalley.work@gmail.com,
        casey@schaufler-ca.com, agk@redhat.com, snitzer@redhat.com,
        gmazyland@gmail.com, paul@paul-moore.com
Cc:     tyhicks@linux.microsoft.com, sashal@kernel.org, jmorris@namei.org,
        nramas@linux.microsoft.com, linux-integrity@vger.kernel.org,
        selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dm-devel@redhat.com
Subject: [PATCH v7 6/8] IMA: extend critical data hook to limit the measurement based on a label
Date:   Wed,  9 Dec 2020 11:42:10 -0800
Message-Id: <20201209194212.5131-7-tusharsu@linux.microsoft.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201209194212.5131-1-tusharsu@linux.microsoft.com>
References: <20201209194212.5131-1-tusharsu@linux.microsoft.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

The IMA hook ima_measure_critical_data() does not support a way to
specify the source of the critical data provider. Thus, the data
measurement cannot be constrained based on the data source label
in the IMA policy.

Extend the IMA hook ima_measure_critical_data() to support passing 
the data source label as an input parameter, so that the policy rule can
be used to limit the measurements based on the label.

Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
---
 include/linux/ima.h               |  6 ++++--
 security/integrity/ima/ima_main.c | 11 ++++++++---
 2 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/include/linux/ima.h b/include/linux/ima.h
index 675f54db6264..6434287a81cd 100644
--- a/include/linux/ima.h
+++ b/include/linux/ima.h
@@ -30,7 +30,8 @@ extern int ima_post_read_file(struct file *file, void *buf, loff_t size,
 extern void ima_post_path_mknod(struct dentry *dentry);
 extern int ima_file_hash(struct file *file, char *buf, size_t buf_size);
 extern void ima_kexec_cmdline(int kernel_fd, const void *buf, int size);
-extern void ima_measure_critical_data(const char *event_name,
+extern void ima_measure_critical_data(const char *event_data_source,
+				      const char *event_name,
 				      const void *buf, int buf_len,
 				      bool measure_buf_hash);
 
@@ -125,7 +126,8 @@ static inline int ima_file_hash(struct file *file, char *buf, size_t buf_size)
 }
 
 static inline void ima_kexec_cmdline(int kernel_fd, const void *buf, int size) {}
-static inline void ima_measure_critical_data(const char *event_name,
+static inline void ima_measure_critical_data(const char *event_data_source,
+					     const char *event_name,
 					     const void *buf, int buf_len,
 					     bool measure_buf_hash) {}
 #endif /* CONFIG_IMA */
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index ae59f4a4dd70..7c633901f441 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -924,6 +924,7 @@ void ima_kexec_cmdline(int kernel_fd, const void *buf, int size)
 
 /**
  * ima_measure_critical_data - measure kernel integrity critical data
+ * @event_data_source: kernel data source being measured
  * @event_name: event name to be used for the buffer entry
  * @buf: pointer to buffer containing data to measure
  * @buf_len: length of buffer(in bytes)
@@ -932,6 +933,9 @@ void ima_kexec_cmdline(int kernel_fd, const void *buf, int size)
  * Measure the kernel subsystem data, critical to the integrity of the kernel,
  * into the IMA log and extend the @pcr.
  *
+ * Use @event_data_source to describe the kernel data source for the buffer
+ * being measured.
+ *
  * Use @event_name to describe the state/buffer data change.
  * Examples of critical data (buf) could be kernel in-memory r/o structures,
  * hash of the memory structures, or data that represents subsystem state
@@ -944,17 +948,18 @@ void ima_kexec_cmdline(int kernel_fd, const void *buf, int size)
  *
  * The data (buf) can only be measured, not appraised.
  */
-void ima_measure_critical_data(const char *event_name,
+void ima_measure_critical_data(const char *event_data_source,
+			       const char *event_name,
 			       const void *buf, int buf_len,
 			       bool measure_buf_hash)
 {
-	if (!event_name || !buf || !buf_len) {
+	if (!event_name || !event_data_source || !buf || !buf_len) {
 		pr_err("Invalid arguments passed to %s().\n", __func__);
 		return;
 	}
 
 	process_buffer_measurement(NULL, buf, buf_len, event_name,
-				   CRITICAL_DATA, 0, NULL,
+				   CRITICAL_DATA, 0, event_data_source,
 				   measure_buf_hash);
 }
 
-- 
2.17.1

