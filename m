Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B64BA138E07
	for <lists+linux-integrity@lfdr.de>; Mon, 13 Jan 2020 10:43:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726127AbgAMJnW (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 13 Jan 2020 04:43:22 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:39907 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726163AbgAMJnV (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 13 Jan 2020 04:43:21 -0500
Received: by mail-wm1-f65.google.com with SMTP id 20so8808904wmj.4
        for <linux-integrity@vger.kernel.org>; Mon, 13 Jan 2020 01:43:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PHx6WmDbUjJ36Jl+g3c5bGGBL+IPquArbpNqxaiK16s=;
        b=EfnB1nq4V68FEsTjQCUQnWpZE9rQyBa/cUPWKvQou1+R2njQCVYQzJbBt1ZPRu1rAe
         wY+lQNDa01pAkV0/0BAX3kRz187MIvZdfkqw3tk8tZzczQwXgbjSa0GpVYhJmh5zp6cG
         2XIrvqlhqgnReKjnEqvDRvXR7EsmpHi/NFzwE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PHx6WmDbUjJ36Jl+g3c5bGGBL+IPquArbpNqxaiK16s=;
        b=De3ff4IliNqiR1WW2YZ99gVxuRwbkzC8WKFlylcfuqY9e3eIBK/1/EUoebIz+3+YBl
         AO4b8kai9gSC9poguSFZuRQKgW51kUZRS2VWQbjikAL3oc2hHchwxpiOG+WumtgjlpsX
         hVCygxeC9gtUmqI5PfU0pR1nBr/pa8wGONFNFbf6dYJiY/2H1gu6hlaUB2JXL0PvyKAr
         FHFofpfQ1HEVj92GsQAIHGYx3amtryMoV3THH9+MlWTQEftMp63TxuMAOf0AKMLU/Zve
         NG0KB1B5g2UcsDY77uzzxpI21YFevpP3YioAVzT0RN7F5/v8fwdzeh2ZLJSf7EqSgTxu
         GwwA==
X-Gm-Message-State: APjAAAXTEvet3f5+MkX68ieC+cYO6Y71er9OCRH950HEhT6uZU5A9iN0
        VUODb5eWv0Zr7YRM8dH8/J2ARiljGD28Oq9R
X-Google-Smtp-Source: APXvYqyDB1HygQVzeq7b71coPvKzhzZ5OHSFXJXnQ+tWJRnTwXMu3t3bcqlFiLsONGC54SCkJyIWnQ==
X-Received: by 2002:a1c:f30e:: with SMTP id q14mr18991444wmq.65.1578908599336;
        Mon, 13 Jan 2020 01:43:19 -0800 (PST)
Received: from revest.zrh.corp.google.com ([2a00:79e0:42:204:51d1:d96e:f72e:c8c0])
        by smtp.gmail.com with ESMTPSA id m126sm13919276wmf.7.2020.01.13.01.43.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2020 01:43:18 -0800 (PST)
From:   Florent Revest <revest@chromium.org>
To:     linux-integrity@vger.kernel.org
Cc:     kpsingh@chromium.org, mjg59@google.com, zohar@linux.ibm.com,
        nramas@linux.microsoft.com, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Florent Revest <revest@google.com>
Subject: [PATCH v3] ima: add the ability to query the cached hash of a given file
Date:   Mon, 13 Jan 2020 10:42:44 +0100
Message-Id: <20200113094244.26678-1-revest@chromium.org>
X-Mailer: git-send-email 2.25.0.rc1.283.g88dfdc4193-goog
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
subsequent exec. This is especially true if a given host has been up
for a long time and the file was first measured a long time ago.

It should be kept in mind that this function gives access to cached
entries which can be removed, for instance on security_inode_free().

This is based on Peter Moody's patch:
 https://sourceforge.net/p/linux-ima/mailman/message/33036180/

[1] https://lkml.org/lkml/2019/9/10/393

Signed-off-by: Florent Revest <revest@google.com>
---
 include/linux/ima.h               |  6 ++++
 security/integrity/ima/ima_main.c | 49 +++++++++++++++++++++++++++++++
 2 files changed, 55 insertions(+)

diff --git a/include/linux/ima.h b/include/linux/ima.h
index f4644c54f648..1659217e9b60 100644
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
index 2272c3255c7d..9fe949c6a530 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -445,6 +445,55 @@ int ima_file_check(struct file *file, int mask)
 }
 EXPORT_SYMBOL_GPL(ima_file_check);
 
+/**
+ * ima_file_hash - return the stored measurement if a file has been hashed and
+ * is in the iint cache.
+ * @file: pointer to the file
+ * @buf: buffer in which to store the hash
+ * @buf_size: length of the buffer
+ *
+ * On success, return the hash algorithm (as defined in the enum hash_algo).
+ * If buf is not NULL, this function also outputs the hash into buf.
+ * If the hash is larger than buf_size, then only buf_size bytes will be copied.
+ * It generally just makes sense to pass a buffer capable of holding the largest
+ * possible hash: IMA_MAX_DIGEST_SIZE.
+ * The file hash returned is based on the entire file, including the appended
+ * signature.
+ *
+ * If IMA is disabled or if no measurement is available, return -EOPNOTSUPP.
+ * If the parameters are incorrect, return -EINVAL.
+ */
+int ima_file_hash(struct file *file, char *buf, size_t buf_size)
+{
+	struct inode *inode;
+	struct integrity_iint_cache *iint;
+	int hash_algo;
+
+	if (!file)
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
+	if (buf) {
+		size_t copied_size;
+
+		copied_size = min_t(size_t, iint->ima_hash->length, buf_size);
+		memcpy(buf, iint->ima_hash->digest, copied_size);
+	}
+	hash_algo = iint->ima_hash->algo;
+	mutex_unlock(&iint->mutex);
+
+	return hash_algo;
+}
+EXPORT_SYMBOL_GPL(ima_file_hash);
+
 /**
  * ima_post_create_tmpfile - mark newly created tmpfile as new
  * @file : newly created tmpfile
-- 
2.25.0.rc1.283.g88dfdc4193-goog

