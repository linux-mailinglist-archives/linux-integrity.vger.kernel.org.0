Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1CB11F805D
	for <lists+linux-integrity@lfdr.de>; Sat, 13 Jun 2020 04:41:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726404AbgFMClh (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 12 Jun 2020 22:41:37 -0400
Received: from linux.microsoft.com ([13.77.154.182]:54106 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726397AbgFMClh (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 12 Jun 2020 22:41:37 -0400
Received: from localhost.localdomain (c-73-42-176-67.hsd1.wa.comcast.net [73.42.176.67])
        by linux.microsoft.com (Postfix) with ESMTPSA id 783EF20B4781;
        Fri, 12 Jun 2020 19:41:36 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 783EF20B4781
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1592016096;
        bh=h/7e7zImKiPAs9gLjjN0MWOthBgeaRk9JTCgA2PStTY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TsbozQNPeiFK7RNK/QjbJhy9+Sw4DCK3i1rNYqVyO9gH5Pnm/R+fiNzWpAZFesotY
         X0SJaSzez0aBKNTXipAEHX7UbI90sNLdSNcyTATW0PbizY75B2OvQZ48hnS1rPSPxp
         3BAUF/TZdi39bQ9iR/Tb0Oy+nVS0LMIjDcjD0nMo=
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
To:     zohar@linux.ibm.com, stephen.smalley@gmail.com,
        casey@schaufler-ca.com
Cc:     jmorris@namei.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/5] IMA: Define an IMA hook to measure LSM data
Date:   Fri, 12 Jun 2020 19:41:27 -0700
Message-Id: <20200613024130.3356-3-nramas@linux.microsoft.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200613024130.3356-1-nramas@linux.microsoft.com>
References: <20200613024130.3356-1-nramas@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

LSM requires an IMA hook to be defined by the IMA subsystem to measure
the data gathered from the security modules.

Define a new IMA hook, namely ima_lsm_state(), that the LSM will call
to measure the data gathered from the security modules.

Sample IMA log entry for LSM measurement:

10 47eed9... ima-buf sha256:402f6b... lsm-state:selinux 656e61626c65643d313b656e666f7263696e673d30

Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
---
 include/linux/ima.h               |  4 ++++
 security/integrity/ima/ima_main.c | 30 ++++++++++++++++++++++++++++++
 2 files changed, 34 insertions(+)

diff --git a/include/linux/ima.h b/include/linux/ima.h
index 9164e1534ec9..56681a648b3d 100644
--- a/include/linux/ima.h
+++ b/include/linux/ima.h
@@ -26,6 +26,7 @@ extern int ima_post_read_file(struct file *file, void *buf, loff_t size,
 extern void ima_post_path_mknod(struct dentry *dentry);
 extern int ima_file_hash(struct file *file, char *buf, size_t buf_size);
 extern void ima_kexec_cmdline(const void *buf, int size);
+extern void ima_lsm_state(const char *lsm_name, const void *buf, int size);
 
 #ifdef CONFIG_IMA_KEXEC
 extern void ima_add_kexec_buffer(struct kimage *image);
@@ -104,6 +105,9 @@ static inline int ima_file_hash(struct file *file, char *buf, size_t buf_size)
 }
 
 static inline void ima_kexec_cmdline(const void *buf, int size) {}
+
+static inline void ima_lsm_state(const char *lsm_name,
+				 const void *buf, int size) {}
 #endif /* CONFIG_IMA */
 
 #ifndef CONFIG_IMA_KEXEC
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index c1583d98c5e5..34be962054fb 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -827,6 +827,36 @@ void ima_kexec_cmdline(const void *buf, int size)
 					   KEXEC_CMDLINE, 0, NULL);
 }
 
+/**
+ * ima_lsm_state - measure LSM specific state
+ * @lsm_name: Name of the LSM
+ * @buf: pointer to buffer containing LSM specific state
+ * @size: Number of bytes in buf
+ *
+ * Buffers can only be measured, not appraised.
+ */
+void ima_lsm_state(const char *lsm_name, const void *buf, int size)
+{
+	const char *eventname = "lsm-state:";
+	char *lsmstatestring;
+	int lsmstatelen;
+
+	if (!lsm_name || !buf || !size)
+		return;
+
+	lsmstatelen = strlen(eventname) + strlen(lsm_name) + 1;
+	lsmstatestring = kzalloc(lsmstatelen, GFP_KERNEL);
+	if (!lsmstatestring)
+		return;
+
+	strcpy(lsmstatestring, eventname);
+	strcat(lsmstatestring, lsm_name);
+
+	process_buffer_measurement(buf, size, lsmstatestring,
+				   LSM_STATE, 0, NULL);
+	kfree(lsmstatestring);
+}
+
 static int __init init_ima(void)
 {
 	int error;
-- 
2.27.0

