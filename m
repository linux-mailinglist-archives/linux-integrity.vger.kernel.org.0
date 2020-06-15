Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 279B61FA0AC
	for <lists+linux-integrity@lfdr.de>; Mon, 15 Jun 2020 21:43:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730130AbgFOTmG (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 15 Jun 2020 15:42:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729976AbgFOTmE (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 15 Jun 2020 15:42:04 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBE94C08C5C3
        for <linux-integrity@vger.kernel.org>; Mon, 15 Jun 2020 12:42:04 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id s23so8264525pfh.7
        for <linux-integrity@vger.kernel.org>; Mon, 15 Jun 2020 12:42:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=X7oayQXpFfH0qIjE8VVUrPkwWu99Q4aIM1+mSE7oCdc=;
        b=GvKdKsG5vYoiC0bs5kCKstHpSmpj5wIhuX/OrXD0Ui/Zyge4QxOk2QGL+cy9dVZgmw
         8B1dQ0YxSxCR7clLs8wRRBQWLL/FBni5rHsz7mnDa3Ev/+eszYj46f4aoPQiMUv+ztlg
         iybuggTVnBUQ0xbX3O3kvrRtJma9bnUvdZKqE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=X7oayQXpFfH0qIjE8VVUrPkwWu99Q4aIM1+mSE7oCdc=;
        b=hf1koRqYKm9uhxiHHW8EnXSt5vlfyl1BEusBYduVIIKxDCiRyiQHQ78O8RHaV2M41N
         sAlo/jsDS3JhFpA9f95JxZgOcBAIEwVQBVMM2O1CQGwJbX+QAhVAjdZiFcrM0r4qc5Hg
         VxiDbb5RrafAUhph9vWZteul6AQRkyY8/02Xn4eQGfDUx4dKiGqiOJnvIIV87fGYiVch
         nyGVfqR7P6ZUY3/1eUYinu2VkrADO9UNrKWTsg6tQ8Y4oCrsJjKQm8EkNElAdLACWRYE
         e9AW9D82ZRAN6EE5H4uLFvP1x3SdlTKcV+4ZyWKYjZoSuGbubGgSsyxuj1a0S/voEZG6
         0anw==
X-Gm-Message-State: AOAM531/j6zTdZGHsA2pyGhb6nM5tw1IvIrNej/3zqo/8PqfUOGwxcof
        Bqyqb1NRL83D4uAfXbajDw/6mA==
X-Google-Smtp-Source: ABdhPJyaRouhqc/ghZX+9irNnLivPsZzJLNg8UnQV3mWCvhlvAflqL4KDExRQJW17pTQhC4wP1W6Cw==
X-Received: by 2002:a63:ef11:: with SMTP id u17mr21921402pgh.249.1592250124122;
        Mon, 15 Jun 2020 12:42:04 -0700 (PDT)
Received: from lbrmn-lnxub113.broadcom.net ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id gq8sm293663pjb.14.2020.06.15.12.42.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2020 12:42:03 -0700 (PDT)
From:   Scott Branden <scott.branden@broadcom.com>
To:     Luis Chamberlain <mcgrof@kernel.org>,
        Wolfram Sang <wsa@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Brown <david.brown@linaro.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Shuah Khan <shuah@kernel.org>, bjorn.andersson@linaro.org,
        Shuah Khan <skhan@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        Olof Johansson <olof@lixom.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Colin Ian King <colin.king@canonical.com>,
        Kees Cook <keescook@chromium.org>,
        Takashi Iwai <tiwai@suse.de>, linux-kselftest@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Scott Branden <scott.branden@broadcom.com>
Subject: [PATCH v9 1/8] fs: introduce kernel_pread_file* support
Date:   Mon, 15 Jun 2020 12:41:44 -0700
Message-Id: <20200615194151.7011-2-scott.branden@broadcom.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200615194151.7011-1-scott.branden@broadcom.com>
References: <20200615194151.7011-1-scott.branden@broadcom.com>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Add kernel_pread_file* support to kernel to allow for partial read
of files with an offset into the file.

Signed-off-by: Scott Branden <scott.branden@broadcom.com>
---
 fs/exec.c          | 93 ++++++++++++++++++++++++++++++++++------------
 include/linux/fs.h | 15 ++++++++
 2 files changed, 85 insertions(+), 23 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index 7b7cbb180785..c557b4b31d0f 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -927,10 +927,14 @@ struct file *open_exec(const char *name)
 }
 EXPORT_SYMBOL(open_exec);
 
-int kernel_read_file(struct file *file, void **buf, loff_t *size,
-		     loff_t max_size, enum kernel_read_file_id id)
-{
-	loff_t i_size, pos;
+int kernel_pread_file(struct file *file, void **buf, loff_t *size,
+		      loff_t max_size, loff_t pos,
+		      enum kernel_read_file_id id)
+{
+	loff_t alloc_size;
+	loff_t buf_pos;
+	loff_t read_end;
+	loff_t i_size;
 	ssize_t bytes = 0;
 	int ret;
 
@@ -950,21 +954,32 @@ int kernel_read_file(struct file *file, void **buf, loff_t *size,
 		ret = -EINVAL;
 		goto out;
 	}
-	if (i_size > SIZE_MAX || (max_size > 0 && i_size > max_size)) {
+
+	/* Default read to end of file */
+	read_end = i_size;
+
+	/* Allow reading partial portion of file */
+	if ((id == READING_FIRMWARE_PARTIAL_READ) &&
+	    (i_size > (pos + max_size)))
+		read_end = pos + max_size;
+
+	alloc_size = read_end - pos;
+	if (i_size > SIZE_MAX || (max_size > 0 && alloc_size > max_size)) {
 		ret = -EFBIG;
 		goto out;
 	}
 
-	if (id != READING_FIRMWARE_PREALLOC_BUFFER)
-		*buf = vmalloc(i_size);
+	if ((id != READING_FIRMWARE_PARTIAL_READ) &&
+	    (id != READING_FIRMWARE_PREALLOC_BUFFER))
+		*buf = vmalloc(alloc_size);
 	if (!*buf) {
 		ret = -ENOMEM;
 		goto out;
 	}
 
-	pos = 0;
-	while (pos < i_size) {
-		bytes = kernel_read(file, *buf + pos, i_size - pos, &pos);
+	buf_pos = 0;
+	while (pos < read_end) {
+		bytes = kernel_read(file, *buf + buf_pos, read_end - pos, &pos);
 		if (bytes < 0) {
 			ret = bytes;
 			goto out_free;
@@ -972,20 +987,23 @@ int kernel_read_file(struct file *file, void **buf, loff_t *size,
 
 		if (bytes == 0)
 			break;
+
+		buf_pos += bytes;
 	}
 
-	if (pos != i_size) {
+	if (pos != read_end) {
 		ret = -EIO;
 		goto out_free;
 	}
 
-	ret = security_kernel_post_read_file(file, *buf, i_size, id);
+	ret = security_kernel_post_read_file(file, *buf, alloc_size, id);
 	if (!ret)
 		*size = pos;
 
 out_free:
 	if (ret < 0) {
-		if (id != READING_FIRMWARE_PREALLOC_BUFFER) {
+		if ((id != READING_FIRMWARE_PARTIAL_READ) &&
+		    (id != READING_FIRMWARE_PREALLOC_BUFFER)) {
 			vfree(*buf);
 			*buf = NULL;
 		}
@@ -995,10 +1013,18 @@ int kernel_read_file(struct file *file, void **buf, loff_t *size,
 	allow_write_access(file);
 	return ret;
 }
+
+int kernel_read_file(struct file *file, void **buf, loff_t *size,
+		     loff_t max_size, enum kernel_read_file_id id)
+{
+	return kernel_pread_file(file, buf, size, max_size, 0, id);
+}
 EXPORT_SYMBOL_GPL(kernel_read_file);
 
-int kernel_read_file_from_path(const char *path, void **buf, loff_t *size,
-			       loff_t max_size, enum kernel_read_file_id id)
+int kernel_pread_file_from_path(const char *path, void **buf,
+				loff_t *size,
+				loff_t max_size, loff_t pos,
+				enum kernel_read_file_id id)
 {
 	struct file *file;
 	int ret;
@@ -1010,15 +1036,22 @@ int kernel_read_file_from_path(const char *path, void **buf, loff_t *size,
 	if (IS_ERR(file))
 		return PTR_ERR(file);
 
-	ret = kernel_read_file(file, buf, size, max_size, id);
+	ret = kernel_pread_file(file, buf, size, max_size, pos, id);
 	fput(file);
 	return ret;
 }
+
+int kernel_read_file_from_path(const char *path, void **buf, loff_t *size,
+			       loff_t max_size, enum kernel_read_file_id id)
+{
+	return kernel_pread_file_from_path(path, buf, size, max_size, 0, id);
+}
 EXPORT_SYMBOL_GPL(kernel_read_file_from_path);
 
-int kernel_read_file_from_path_initns(const char *path, void **buf,
-				      loff_t *size, loff_t max_size,
-				      enum kernel_read_file_id id)
+int kernel_pread_file_from_path_initns(const char *path, void **buf,
+				       loff_t *size,
+				       loff_t max_size, loff_t pos,
+				       enum kernel_read_file_id id)
 {
 	struct file *file;
 	struct path root;
@@ -1036,14 +1069,22 @@ int kernel_read_file_from_path_initns(const char *path, void **buf,
 	if (IS_ERR(file))
 		return PTR_ERR(file);
 
-	ret = kernel_read_file(file, buf, size, max_size, id);
+	ret = kernel_pread_file(file, buf, size, max_size, pos, id);
 	fput(file);
 	return ret;
 }
+
+int kernel_read_file_from_path_initns(const char *path, void **buf,
+				      loff_t *size, loff_t max_size,
+				      enum kernel_read_file_id id)
+{
+	return kernel_pread_file_from_path_initns(path, buf, size, max_size, 0, id);
+}
 EXPORT_SYMBOL_GPL(kernel_read_file_from_path_initns);
 
-int kernel_read_file_from_fd(int fd, void **buf, loff_t *size, loff_t max_size,
-			     enum kernel_read_file_id id)
+int kernel_pread_file_from_fd(int fd, void **buf, loff_t *size,
+			      loff_t max_size, loff_t pos,
+			      enum kernel_read_file_id id)
 {
 	struct fd f = fdget(fd);
 	int ret = -EBADF;
@@ -1051,11 +1092,17 @@ int kernel_read_file_from_fd(int fd, void **buf, loff_t *size, loff_t max_size,
 	if (!f.file)
 		goto out;
 
-	ret = kernel_read_file(f.file, buf, size, max_size, id);
+	ret = kernel_pread_file(f.file, buf, size, max_size, pos, id);
 out:
 	fdput(f);
 	return ret;
 }
+
+int kernel_read_file_from_fd(int fd, void **buf, loff_t *size, loff_t max_size,
+			     enum kernel_read_file_id id)
+{
+	return kernel_pread_file_from_fd(fd, buf, size, max_size, 0, id);
+}
 EXPORT_SYMBOL_GPL(kernel_read_file_from_fd);
 
 #if defined(CONFIG_HAVE_AOUT) || defined(CONFIG_BINFMT_FLAT) || \
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 6931c469040b..3ac1d213577a 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3012,6 +3012,7 @@ extern int do_pipe_flags(int *, int);
 #define __kernel_read_file_id(id) \
 	id(UNKNOWN, unknown)		\
 	id(FIRMWARE, firmware)		\
+	id(FIRMWARE_PARTIAL_READ, firmware)	\
 	id(FIRMWARE_PREALLOC_BUFFER, firmware)	\
 	id(FIRMWARE_EFI_EMBEDDED, firmware)	\
 	id(MODULE, kernel-module)		\
@@ -3040,12 +3041,26 @@ static inline const char *kernel_read_file_id_str(enum kernel_read_file_id id)
 	return kernel_read_file_str[id];
 }
 
+int kernel_pread_file(struct file *file, void **buf, loff_t *size,
+		      loff_t pos, loff_t max_size,
+		      enum kernel_read_file_id id);
 extern int kernel_read_file(struct file *, void **, loff_t *, loff_t,
 			    enum kernel_read_file_id);
+int kernel_pread_file_from_path(const char *path, void **buf,
+				loff_t *size, loff_t pos,
+				loff_t max_size,
+				enum kernel_read_file_id id);
 extern int kernel_read_file_from_path(const char *, void **, loff_t *, loff_t,
 				      enum kernel_read_file_id);
+int kernel_pread_file_from_path_initns(const char *path, void **buf,
+				       loff_t *size, loff_t pos,
+				       loff_t max_size,
+				       enum kernel_read_file_id id);
 extern int kernel_read_file_from_path_initns(const char *, void **, loff_t *, loff_t,
 					     enum kernel_read_file_id);
+int kernel_pread_file_from_fd(int fd, void **buf, loff_t *size,
+			      loff_t pos, loff_t max_size,
+			      enum kernel_read_file_id id);
 extern int kernel_read_file_from_fd(int, void **, loff_t *, loff_t,
 				    enum kernel_read_file_id);
 extern ssize_t kernel_read(struct file *, void *, size_t, loff_t *);
-- 
2.17.1

