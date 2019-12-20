Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 80F0A1280B3
	for <lists+linux-integrity@lfdr.de>; Fri, 20 Dec 2019 17:31:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727422AbfLTQbm (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 20 Dec 2019 11:31:42 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44163 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727233AbfLTQbm (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 20 Dec 2019 11:31:42 -0500
Received: by mail-wr1-f66.google.com with SMTP id q10so9993071wrm.11
        for <linux-integrity@vger.kernel.org>; Fri, 20 Dec 2019 08:31:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JEPKTWFBgqyz+hVI4T+K0RwVC4SXQz3XQWTyqv52qe8=;
        b=W5IZsAhYOcgC9qWUZYKC01gRCHi+E98qMCuJ/gpkCo6A1zL/IlfRHzDjgbgPxE32VK
         Lj18G/l5Tmlan2jDE+DlrH3dYb0dLa0PyZvI0Yny3B0a14NKr7NBKVoBIs7ldxNFnYBk
         4A9x3WSvrnyIiB+NFpEEfVCPUEA0cPNQjfP24=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JEPKTWFBgqyz+hVI4T+K0RwVC4SXQz3XQWTyqv52qe8=;
        b=YeL0KHE2XNeZxajJEF1BqdLsjdnK/dFJFeUk3kGCnaAgAZzeQdCsiFYPOfyQ6jJU7a
         SwkTWlPbRbvVcqh2SoUttmaSKnfBWdzR+sUVbJr+zzMSOfdH1WNHqO4pGLNdfgkif252
         YzZxoou0JYsC6//BrBq8E0sZW4iDhdn9rCBULklhUeoV0G+0Ebo7Dk1aaa9CkQem4iJN
         KM0TOtI+ETCKvPeU3BcXmojEFjQCV5n4GKfKDy3J4QVUIatGvEjvQ0wslAFqP3Yed7NP
         tspM4YPDKBk3cryHo0nCatq5yentekiwTRQkbUBmSRrlWuCLbi+/BR98zTFm0DSXJmNE
         TPRA==
X-Gm-Message-State: APjAAAUdbNoTaV4I4kH552aEtb3GFRtLEmno786MrGf84OtHsuq0v7Y8
        sFQRxRGGrPfzaGa7BuXkXO5nBIJh4SO8hA==
X-Google-Smtp-Source: APXvYqxkB5aC2co8k3B6rs6cg84QwN9ShYX3gqM097SYUJJnoBCgbMFZMv+ot6jikLHHu88ZU05y+Q==
X-Received: by 2002:adf:ea0f:: with SMTP id q15mr15795873wrm.324.1576859499726;
        Fri, 20 Dec 2019 08:31:39 -0800 (PST)
Received: from revest.zrh.corp.google.com ([2a00:79e0:42:204:51d1:d96e:f72e:c8c0])
        by smtp.gmail.com with ESMTPSA id e6sm10165522wru.44.2019.12.20.08.31.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Dec 2019 08:31:39 -0800 (PST)
From:   Florent Revest <revest@chromium.org>
To:     linux-integrity@vger.kernel.org
Cc:     kpsingh@chromium.org, mjg59@google.com, zohar@linux.ibm.com,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Florent Revest <revest@google.com>
Subject: [PATCH] ima: add the ability to query ima for the hash of a given file.
Date:   Fri, 20 Dec 2019 17:31:36 +0100
Message-Id: <20191220163136.25010-1-revest@chromium.org>
X-Mailer: git-send-email 2.24.1.735.g03f4e72817-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Florent Revest <revest@google.com>

This allows other parts of the kernel (perhaps a stacked LSM allowing
system monitoring, eg. the proposed KRSI LSM [1]) to retrieve the hash
of a given file from IMA if it's present in the iint cache.

It's true that the existence of the hash means that it's also in the
audit logs or in /sys/kernel/security/ima/ascii_runtime_measurements,
but it can be difficult to pull that information out for every
subsequent exec.  This is especially true if a given host has been up
for a long time and the file was first measured a long time ago.

This is based on Peter Moody's patch:
 https://sourceforge.net/p/linux-ima/mailman/message/33036180/

[1] https://lkml.org/lkml/2019/9/10/393

Signed-off-by: Florent Revest <revest@google.com>
---
 include/linux/ima.h               |  6 +++++
 security/integrity/ima/ima_main.c | 41 +++++++++++++++++++++++++++++++
 2 files changed, 47 insertions(+)

diff --git a/include/linux/ima.h b/include/linux/ima.h
index 6d904754d858..d621c65ba9a5 100644
--- a/include/linux/ima.h
+++ b/include/linux/ima.h
@@ -23,6 +23,7 @@ extern int ima_read_file(struct file *file, enum kernel_read_file_id id);
 extern int ima_post_read_file(struct file *file, void *buf, loff_t size,
 			      enum kernel_read_file_id id);
 extern void ima_post_path_mknod(struct dentry *dentry);
+extern int ima_file_hash(struct file *file, char *buf, size_t buf_size);
 extern void ima_kexec_cmdline(const void *buf, int size);
 
 #ifdef CONFIG_IMA_KEXEC
@@ -91,6 +92,11 @@ static inline void ima_post_path_mknod(struct dentry *dentry)
 	return;
 }
 
+static inline int ima_file_hash(struct file *file, char *buf, size_t buf_size)
+{
+	return -EOPNOTSUPP;
+}
+
 static inline void ima_kexec_cmdline(const void *buf, int size) {}
 #endif /* CONFIG_IMA */
 
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index d7e987baf127..f054ddf4364e 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -445,6 +445,47 @@ int ima_file_check(struct file *file, int mask)
 }
 EXPORT_SYMBOL_GPL(ima_file_check);
 
+/**
+ * ima_file_hash - return the stored measurement if a file has been hashed.
+ * @file: pointer to the file
+ * @buf: buffer in which to store the hash
+ * @buf_size: length of the buffer
+ *
+ * On success, output the hash into buf and return the hash algorithm (as
+ * defined in the enum hash_algo).
+ * If the hash is larger than buf, then only size bytes will be copied. It
+ * generally just makes sense to pass a buffer capable of holding the largest
+ * possible hash: IMA_MAX_DIGEST_SIZE
+ *
+ * If IMA is disabled or if no measurement is available, return -EOPNOTSUPP.
+ * If the parameters are incorrect, return -EINVAL.
+ */
+int ima_file_hash(struct file *file, char *buf, size_t buf_size)
+{
+	struct inode *inode;
+	struct integrity_iint_cache *iint;
+	size_t copied_size;
+
+	if (!file || !buf)
+		return -EINVAL;
+
+	if (!ima_policy_flag)
+		return -EOPNOTSUPP;
+
+	inode = file_inode(file);
+	iint = integrity_iint_find(inode);
+	if (!iint)
+		return -EOPNOTSUPP;
+
+	mutex_lock(&iint->mutex);
+	copied_size = min_t(size_t, iint->ima_hash->length, buf_size);
+	memcpy(buf, iint->ima_hash->digest, copied_size);
+	mutex_unlock(&iint->mutex);
+
+	return iint->ima_hash->algo;
+}
+EXPORT_SYMBOL_GPL(ima_file_hash);
+
 /**
  * ima_post_create_tmpfile - mark newly created tmpfile as new
  * @file : newly created tmpfile
-- 
2.24.1.735.g03f4e72817-goog

