Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7154A2211AA
	for <lists+linux-integrity@lfdr.de>; Wed, 15 Jul 2020 17:51:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727965AbgGOPtn (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 15 Jul 2020 11:49:43 -0400
Received: from linux.microsoft.com ([13.77.154.182]:45906 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725861AbgGOPs7 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 15 Jul 2020 11:48:59 -0400
Received: from localhost.localdomain (c-73-42-176-67.hsd1.wa.comcast.net [73.42.176.67])
        by linux.microsoft.com (Postfix) with ESMTPSA id 1950620B490A;
        Wed, 15 Jul 2020 08:48:59 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 1950620B490A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1594828139;
        bh=uMfFSH8BKWRMGn0Ob/aAF/poLIpxKXFWWoJsEWCn7j0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZSuLFrUnHBxzjh2OaCtB0aYr21EMsCbXlMyT9bf6RaPqfLCJjO0FWqGFrkYnim2n7
         De3aZ7div+JOL9zsH+uCbJrycUUPLkBs+YgXn/x5cEB0x8GkuyF6HWwjkYtahhBbHW
         LGF0xWEZi5uKxeAlimXMnQ7J1p15MfenwD4ZUAqk=
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
To:     zohar@linux.ibm.com, stephen.smalley.work@gmail.com,
        casey@schaufler-ca.com
Cc:     jmorris@namei.org, linux-integrity@vger.kernel.org,
        selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 2/5] IMA: Define an IMA hook to measure LSM data
Date:   Wed, 15 Jul 2020 08:48:50 -0700
Message-Id: <20200715154853.23374-3-nramas@linux.microsoft.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200715154853.23374-1-nramas@linux.microsoft.com>
References: <20200715154853.23374-1-nramas@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

IMA subsystem needs to define an IMA hook that the security modules can
call to measure critical data of the security modules.

Define a new IMA hook, namely ima_lsm_state(), that the security modules
can call to measure data.

Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
---
 include/linux/ima.h               |  4 ++++
 security/integrity/ima/ima_main.c | 17 +++++++++++++++++
 2 files changed, 21 insertions(+)

diff --git a/include/linux/ima.h b/include/linux/ima.h
index 9164e1534ec9..7e2686f4953a 100644
--- a/include/linux/ima.h
+++ b/include/linux/ima.h
@@ -26,6 +26,7 @@ extern int ima_post_read_file(struct file *file, void *buf, loff_t size,
 extern void ima_post_path_mknod(struct dentry *dentry);
 extern int ima_file_hash(struct file *file, char *buf, size_t buf_size);
 extern void ima_kexec_cmdline(const void *buf, int size);
+extern void ima_lsm_state(const char *lsm_event_name, const void *buf, int size);
 
 #ifdef CONFIG_IMA_KEXEC
 extern void ima_add_kexec_buffer(struct kimage *image);
@@ -104,6 +105,9 @@ static inline int ima_file_hash(struct file *file, char *buf, size_t buf_size)
 }
 
 static inline void ima_kexec_cmdline(const void *buf, int size) {}
+
+static inline void ima_lsm_state(const char *lsm_event_name,
+				 const void *buf, int size) {}
 #endif /* CONFIG_IMA */
 
 #ifndef CONFIG_IMA_KEXEC
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index 8351b2fd48e0..04d9a1d35300 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -835,6 +835,23 @@ void ima_kexec_cmdline(const void *buf, int size)
 					   KEXEC_CMDLINE, 0, NULL);
 }
 
+/**
+ * ima_lsm_state - measure LSM specific state
+ * @lsm_event_name: LSM event
+ * @buf: pointer to buffer containing LSM specific state
+ * @size: Number of bytes in buf
+ *
+ * Buffers can only be measured, not appraised.
+ */
+void ima_lsm_state(const char *lsm_event_name, const void *buf, int size)
+{
+	if (!lsm_event_name || !buf || !size)
+		return;
+
+	process_buffer_measurement(buf, size, lsm_event_name,
+				   LSM_STATE, 0, NULL);
+}
+
 static int __init init_ima(void)
 {
 	int error;
-- 
2.27.0

