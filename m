Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26F972D8323
	for <lists+linux-integrity@lfdr.de>; Sat, 12 Dec 2020 01:01:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437573AbgLLAAB (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 11 Dec 2020 19:00:01 -0500
Received: from linux.microsoft.com ([13.77.154.182]:54886 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437540AbgLKX7m (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 11 Dec 2020 18:59:42 -0500
Received: from tusharsu-Ubuntu.lan (c-71-197-163-6.hsd1.wa.comcast.net [71.197.163.6])
        by linux.microsoft.com (Postfix) with ESMTPSA id 7720220B718B;
        Fri, 11 Dec 2020 15:58:22 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 7720220B718B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1607731102;
        bh=MM3ClDqEP+SzUBB8BN8JUnd+31NPdgl7RcDy+xWWqKE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Snfg9emcanInVSinf/C0GEyNw1+SPQgDhpj3YZLDy6krAtcaCsUBtBgCkbRdJMwGf
         czZCS7CL4FcBw5LSERnVFtkR5PqSP1nEujXDPm0pqpvpo3cg897BS+u92tEEC0pX0e
         CIo41ej/gTISk05j1yV1xRBFgU6Iu2XShLSRWIxM=
From:   Tushar Sugandhi <tusharsu@linux.microsoft.com>
To:     zohar@linux.ibm.com, stephen.smalley.work@gmail.com,
        casey@schaufler-ca.com, agk@redhat.com, snitzer@redhat.com,
        gmazyland@gmail.com, paul@paul-moore.com
Cc:     tyhicks@linux.microsoft.com, sashal@kernel.org, jmorris@namei.org,
        nramas@linux.microsoft.com, linux-integrity@vger.kernel.org,
        selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dm-devel@redhat.com
Subject: [PATCH v8 6/8] IMA: extend critical data hook to limit the measurement based on a label
Date:   Fri, 11 Dec 2020 15:58:05 -0800
Message-Id: <20201211235807.30815-7-tusharsu@linux.microsoft.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201211235807.30815-1-tusharsu@linux.microsoft.com>
References: <20201211235807.30815-1-tusharsu@linux.microsoft.com>
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
Reviewed-by: Tyler Hicks <tyhicks@linux.microsoft.com>
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
index dff4bce4fb09..cc828ba00790 100644
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
  * Examples of critical data (@buf) could be various data structures,
  * policies, and states stored in kernel memory that can impact the integrity
@@ -944,15 +948,16 @@ void ima_kexec_cmdline(int kernel_fd, const void *buf, int size)
  *
  * The data (@buf) can only be measured, not appraised.
  */
-void ima_measure_critical_data(const char *event_name,
+void ima_measure_critical_data(const char *event_data_source,
+			       const char *event_name,
 			       const void *buf, int buf_len,
 			       bool measure_buf_hash)
 {
-	if (!event_name || !buf || !buf_len)
+	if (!event_name || !event_data_source || !buf || !buf_len)
 		return;
 
 	process_buffer_measurement(NULL, buf, buf_len, event_name,
-				   CRITICAL_DATA, 0, NULL,
+				   CRITICAL_DATA, 0, event_data_source,
 				   measure_buf_hash);
 }
 
-- 
2.17.1

