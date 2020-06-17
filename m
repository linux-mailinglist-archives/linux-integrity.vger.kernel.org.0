Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 590471FC4B7
	for <lists+linux-integrity@lfdr.de>; Wed, 17 Jun 2020 05:32:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726703AbgFQDcF (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 16 Jun 2020 23:32:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726815AbgFQDcE (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 16 Jun 2020 23:32:04 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5727AC0613EE
        for <linux-integrity@vger.kernel.org>; Tue, 16 Jun 2020 20:32:04 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id 35so312634ple.0
        for <linux-integrity@vger.kernel.org>; Tue, 16 Jun 2020 20:32:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=/o4IaVPf0kzNBvpVEC0K3iVjen4MlWNK8mBVtZ2/Gqc=;
        b=Ivs1F45qH3c+ZDDTi7pDlv6+jOmzu0/svSfTOo1nZyggQCCuWdijtsq2Uc9MWZcckm
         pwzXI7NeC2AzoYDpebR2pNF/ri4Nedfrl+CjFlF3R019czlltUAzFgRazzjB/Pav7mEG
         mr0QvmuAIu2FWfF7TvX771NdIPUH34RusBlbM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=/o4IaVPf0kzNBvpVEC0K3iVjen4MlWNK8mBVtZ2/Gqc=;
        b=s8lux7g442bhjhnoemI7SuFvpuviVlwykOXwaMjBdzX+DPceyD3AJ5jwlkOBYv0Kxk
         wvQP4KlVo/tD4s5WMprqcVJNhXwO8CRhOvZwS3cszavbkEklCYVWe3LTrABd1qnN6VpF
         ujZfQ0UiDt2Gfo7FG82f8tMAKthjpinbUXp0M/HVYf2kMJy060IrCaR0e60g24OWGM4m
         ZTccQ3kusDHPjZTLd6sqBSgj5eCi9Fwd2Cj7PUMHadMr03bosp5Ogyq5SoOnviIHOgRs
         ZrKqYKCIYmJf4rYTY3Ighr3xvuEISogl7Qdlw/97QyWsLZx4/1y1PMXO8iCXt0ZQtdQd
         qxoQ==
X-Gm-Message-State: AOAM533qiWZysu61A/aRjPWhSAm+ni6uaOwvWlfVAVKc8HdF7ycBZF6F
        PGvmk5ix2tOTGBClM2CXx9JMnQ==
X-Google-Smtp-Source: ABdhPJzwFt5BXhU2PeAqSlbGRJ3FqJoDtzea7QNVzQ8cOqmoFOce0D6XcbILs/9MsHCyEN1geYZoUg==
X-Received: by 2002:a17:90b:1013:: with SMTP id gm19mr5895967pjb.231.1592364723583;
        Tue, 16 Jun 2020 20:32:03 -0700 (PDT)
Received: from lbrmn-lnxub113.broadcom.net ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id b14sm17937159pft.23.2020.06.16.20.32.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2020 20:32:02 -0700 (PDT)
From:   Scott Branden <scott.branden@broadcom.com>
To:     Christoph Hellwig <hch@lst.de>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Eric Biederman <ebiederm@xmission.com>,
        Jessica Yu <jeyu@kernel.org>
Cc:     BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        kexec@lists.infradead.org, linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org, selinux@vger.kernel.org,
        Scott Branden <scott.branden@broadcom.com>
Subject: [PATCH] fs: move kernel_read_file* to its own include file
Date:   Tue, 16 Jun 2020 20:31:52 -0700
Message-Id: <20200617033152.16883-1-scott.branden@broadcom.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Move kernel_read_file* to it own kernel_read_file.h include file.

Suggested-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Scott Branden <scott.branden@broadcom.com>
---
 drivers/base/firmware_loader/main.c |  1 +
 fs/exec.c                           |  1 +
 include/linux/fs.h                  | 39 ----------------------
 include/linux/ima.h                 |  1 +
 include/linux/kernel_read_file.h    | 52 +++++++++++++++++++++++++++++
 include/linux/security.h            |  1 +
 kernel/kexec_file.c                 |  1 +
 kernel/module.c                     |  1 +
 security/integrity/digsig.c         |  1 +
 security/integrity/ima/ima_fs.c     |  1 +
 security/integrity/ima/ima_main.c   |  1 +
 security/integrity/ima/ima_policy.c |  1 +
 security/loadpin/loadpin.c          |  1 +
 security/security.c                 |  1 +
 security/selinux/hooks.c            |  1 +
 15 files changed, 65 insertions(+), 39 deletions(-)
 create mode 100644 include/linux/kernel_read_file.h

diff --git a/drivers/base/firmware_loader/main.c b/drivers/base/firmware_loader/main.c
index ca871b13524e..136933f1bd6e 100644
--- a/drivers/base/firmware_loader/main.c
+++ b/drivers/base/firmware_loader/main.c
@@ -12,6 +12,7 @@
 
 #include <linux/capability.h>
 #include <linux/device.h>
+#include <linux/kernel_read_file.h>
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/timer.h>
diff --git a/fs/exec.c b/fs/exec.c
index 7b7cbb180785..4ea87db5e4d5 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -23,6 +23,7 @@
  * formats.
  */
 
+#include <linux/kernel_read_file.h>
 #include <linux/slab.h>
 #include <linux/file.h>
 #include <linux/fdtable.h>
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 2e675c075694..09427d393954 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3012,45 +3012,6 @@ static inline void i_readcount_inc(struct inode *inode)
 #endif
 extern int do_pipe_flags(int *, int);
 
-#define __kernel_read_file_id(id) \
-	id(UNKNOWN, unknown)		\
-	id(FIRMWARE, firmware)		\
-	id(FIRMWARE_PREALLOC_BUFFER, firmware)	\
-	id(FIRMWARE_EFI_EMBEDDED, firmware)	\
-	id(MODULE, kernel-module)		\
-	id(KEXEC_IMAGE, kexec-image)		\
-	id(KEXEC_INITRAMFS, kexec-initramfs)	\
-	id(POLICY, security-policy)		\
-	id(X509_CERTIFICATE, x509-certificate)	\
-	id(MAX_ID, )
-
-#define __fid_enumify(ENUM, dummy) READING_ ## ENUM,
-#define __fid_stringify(dummy, str) #str,
-
-enum kernel_read_file_id {
-	__kernel_read_file_id(__fid_enumify)
-};
-
-static const char * const kernel_read_file_str[] = {
-	__kernel_read_file_id(__fid_stringify)
-};
-
-static inline const char *kernel_read_file_id_str(enum kernel_read_file_id id)
-{
-	if ((unsigned)id >= READING_MAX_ID)
-		return kernel_read_file_str[READING_UNKNOWN];
-
-	return kernel_read_file_str[id];
-}
-
-extern int kernel_read_file(struct file *, void **, loff_t *, loff_t,
-			    enum kernel_read_file_id);
-extern int kernel_read_file_from_path(const char *, void **, loff_t *, loff_t,
-				      enum kernel_read_file_id);
-extern int kernel_read_file_from_path_initns(const char *, void **, loff_t *, loff_t,
-					     enum kernel_read_file_id);
-extern int kernel_read_file_from_fd(int, void **, loff_t *, loff_t,
-				    enum kernel_read_file_id);
 extern ssize_t kernel_read(struct file *, void *, size_t, loff_t *);
 extern ssize_t kernel_write(struct file *, const void *, size_t, loff_t *);
 extern ssize_t __kernel_write(struct file *, const void *, size_t, loff_t *);
diff --git a/include/linux/ima.h b/include/linux/ima.h
index 9164e1534ec9..148636bfcc8f 100644
--- a/include/linux/ima.h
+++ b/include/linux/ima.h
@@ -7,6 +7,7 @@
 #ifndef _LINUX_IMA_H
 #define _LINUX_IMA_H
 
+#include <linux/kernel_read_file.h>
 #include <linux/fs.h>
 #include <linux/security.h>
 #include <linux/kexec.h>
diff --git a/include/linux/kernel_read_file.h b/include/linux/kernel_read_file.h
new file mode 100644
index 000000000000..53f5ca41519a
--- /dev/null
+++ b/include/linux/kernel_read_file.h
@@ -0,0 +1,52 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_KERNEL_READ_FILE_H
+#define _LINUX_KERNEL_READ_FILE_H
+
+#include <linux/file.h>
+#include <linux/types.h>
+
+#define __kernel_read_file_id(id) \
+	id(UNKNOWN, unknown)		\
+	id(FIRMWARE, firmware)		\
+	id(FIRMWARE_PREALLOC_BUFFER, firmware)	\
+	id(FIRMWARE_EFI_EMBEDDED, firmware)	\
+	id(MODULE, kernel-module)		\
+	id(KEXEC_IMAGE, kexec-image)		\
+	id(KEXEC_INITRAMFS, kexec-initramfs)	\
+	id(POLICY, security-policy)		\
+	id(X509_CERTIFICATE, x509-certificate)	\
+	id(MAX_ID, )
+
+#define __fid_enumify(ENUM, dummy) READING_ ## ENUM,
+#define __fid_stringify(dummy, str) #str,
+
+enum kernel_read_file_id {
+	__kernel_read_file_id(__fid_enumify)
+};
+
+static const char * const kernel_read_file_str[] = {
+	__kernel_read_file_id(__fid_stringify)
+};
+
+static inline const char *kernel_read_file_id_str(enum kernel_read_file_id id)
+{
+	if ((unsigned int)id >= READING_MAX_ID)
+		return kernel_read_file_str[READING_UNKNOWN];
+
+	return kernel_read_file_str[id];
+}
+
+int kernel_read_file(struct file *file,
+		     void **buf, loff_t *size, loff_t max_size,
+		     enum kernel_read_file_id id);
+int kernel_read_file_from_path(const char *path,
+			       void **buf, loff_t *size, loff_t max_size,
+			       enum kernel_read_file_id id);
+int kernel_read_file_from_path_initns(const char *path,
+				      void **buf, loff_t *size, loff_t max_size,
+				      enum kernel_read_file_id id);
+int kernel_read_file_from_fd(int fd,
+			     void **buf, loff_t *size, loff_t max_size,
+			     enum kernel_read_file_id id);
+
+#endif /* _LINUX_KERNEL_READ_FILE_H */
diff --git a/include/linux/security.h b/include/linux/security.h
index 2797e7f6418e..fc1c6af331bd 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -23,6 +23,7 @@
 #ifndef __LINUX_SECURITY_H
 #define __LINUX_SECURITY_H
 
+#include <linux/kernel_read_file.h>
 #include <linux/key.h>
 #include <linux/capability.h>
 #include <linux/fs.h>
diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index bb05fd52de85..54efafc31d34 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -24,6 +24,7 @@
 #include <linux/elf.h>
 #include <linux/elfcore.h>
 #include <linux/kernel.h>
+#include <linux/kernel_read_file.h>
 #include <linux/syscalls.h>
 #include <linux/vmalloc.h>
 #include "kexec_internal.h"
diff --git a/kernel/module.c b/kernel/module.c
index e8a198588f26..6ed67699531f 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -18,6 +18,7 @@
 #include <linux/fs.h>
 #include <linux/sysfs.h>
 #include <linux/kernel.h>
+#include <linux/kernel_read_file.h>
 #include <linux/slab.h>
 #include <linux/vmalloc.h>
 #include <linux/elf.h>
diff --git a/security/integrity/digsig.c b/security/integrity/digsig.c
index e9cbadade74b..d09602aab7bd 100644
--- a/security/integrity/digsig.c
+++ b/security/integrity/digsig.c
@@ -10,6 +10,7 @@
 #include <linux/sched.h>
 #include <linux/slab.h>
 #include <linux/cred.h>
+#include <linux/kernel_read_file.h>
 #include <linux/key-type.h>
 #include <linux/digsig.h>
 #include <linux/vmalloc.h>
diff --git a/security/integrity/ima/ima_fs.c b/security/integrity/ima/ima_fs.c
index e3fcad871861..57ecbf285fc7 100644
--- a/security/integrity/ima/ima_fs.c
+++ b/security/integrity/ima/ima_fs.c
@@ -13,6 +13,7 @@
  */
 
 #include <linux/fcntl.h>
+#include <linux/kernel_read_file.h>
 #include <linux/slab.h>
 #include <linux/init.h>
 #include <linux/seq_file.h>
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index c1583d98c5e5..15f29fed6d9f 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -18,6 +18,7 @@
 #include <linux/module.h>
 #include <linux/file.h>
 #include <linux/binfmts.h>
+#include <linux/kernel_read_file.h>
 #include <linux/mount.h>
 #include <linux/mman.h>
 #include <linux/slab.h>
diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index e493063a3c34..f8390f6081f0 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -9,6 +9,7 @@
 
 #include <linux/init.h>
 #include <linux/list.h>
+#include <linux/kernel_read_file.h>
 #include <linux/fs.h>
 #include <linux/security.h>
 #include <linux/magic.h>
diff --git a/security/loadpin/loadpin.c b/security/loadpin/loadpin.c
index ee5cb944f4ad..81bc95127f92 100644
--- a/security/loadpin/loadpin.c
+++ b/security/loadpin/loadpin.c
@@ -11,6 +11,7 @@
 
 #include <linux/module.h>
 #include <linux/fs.h>
+#include <linux/kernel_read_file.h>
 #include <linux/lsm_hooks.h>
 #include <linux/mount.h>
 #include <linux/path.h>
diff --git a/security/security.c b/security/security.c
index 2bb912496232..8983cdc07ebb 100644
--- a/security/security.c
+++ b/security/security.c
@@ -16,6 +16,7 @@
 #include <linux/export.h>
 #include <linux/init.h>
 #include <linux/kernel.h>
+#include <linux/kernel_read_file.h>
 #include <linux/lsm_hooks.h>
 #include <linux/integrity.h>
 #include <linux/ima.h>
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index efa6108b1ce9..5de45010fb1a 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -24,6 +24,7 @@
 #include <linux/init.h>
 #include <linux/kd.h>
 #include <linux/kernel.h>
+#include <linux/kernel_read_file.h>
 #include <linux/tracehook.h>
 #include <linux/errno.h>
 #include <linux/sched/signal.h>
-- 
2.17.1

