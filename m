Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6FDC813581
	for <lists+linux-integrity@lfdr.de>; Sat,  4 May 2019 00:26:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726862AbfECWZd (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 3 May 2019 18:25:33 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:45803 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726584AbfECWZd (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 3 May 2019 18:25:33 -0400
Received: by mail-pg1-f194.google.com with SMTP id i21so3350081pgi.12;
        Fri, 03 May 2019 15:25:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6gv710NSkDAzQhiL4/sod+kpIyd9jem9gPAv5bYZQfg=;
        b=YVTbcFJorVl79ZUDMSEDOvyuPc0skNIYQiZkpjwwnLkumtyPTWj3IjndIofVX+eKUY
         MZB8ieAbzcuM+hWQgSPj4wlCWHS8mS2Eb26reNYIqQFlZkM6e/Wmpl+VsbSqOJ5d4YmC
         ofsc3DNbAmlY02M4bDlut3tHuvK6371mc2A6y81g45mrx+ZY0mKjsG5hXutokmkTeMg6
         Odxn8bSpEgQIBgRtj9r272PmcZDfZJFD+Ak43ceNLItpWG8cGeYbwDSSqadGdUVvWj+E
         EFhRKl034OOaIRj7o9VnNrRZtG2ySFTZoUZsIRLjsaCM5yHVJvbi16DWBEo0OVLTQwsu
         8oHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6gv710NSkDAzQhiL4/sod+kpIyd9jem9gPAv5bYZQfg=;
        b=QSxhDBTJDmFouB8RKHMRhKzwBiT5qIWJa5btzn0ABKG3ClFy7MKJHBR+RR/x6eOCEz
         N9OSpcxgGQ6YShgzmer9Et+VGpMiV62ZoNvPwsSOv+8z3DuHPebEIIJz0KIVNLywJCvZ
         xQ/6eTXRSzgKP9fQSqV74l7pO2k8JeFB4gWPd7Qa7KYQXXZ7wfJtcRFD1GwTMC2WamvY
         +LmeJreiI/9HbM5CGmtpi8q0ng4nHzvGAJlltk19oNNZN6zlBQnuV3bOg9xTC272j6tP
         PqAVUXOoHqRTx9wHx0a5Dm5jic6jXE+qB91kiVkyc6beLXC+8770fne4Z6oZ4SwiqT9w
         bwPA==
X-Gm-Message-State: APjAAAVQscKLCNMQZ/0czbB7pF4BSWoTlTSgGJ5Lx2nE8Ouy8gG6y1/q
        QD3MNrn3XCPrV3XYWobocPAh3oAccKs=
X-Google-Smtp-Source: APXvYqxDkZh+slC+4Z+87hPeHKLlOYmeOQyy5/4NoOJTg9Uxezh8X+J2vT6ijOrAEHRHYj7g5rXtkA==
X-Received: by 2002:a62:a503:: with SMTP id v3mr14698626pfm.32.1556922332291;
        Fri, 03 May 2019 15:25:32 -0700 (PDT)
Received: from prsriva-linux.corp.microsoft.com ([2001:4898:80e8:b:3170:1a6b:a13a:7ff])
        by smtp.gmail.com with ESMTPSA id j22sm4314337pfi.139.2019.05.03.15.25.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 May 2019 15:25:31 -0700 (PDT)
From:   Prakhar Srivastava <prsriva02@gmail.com>
X-Google-Original-From: Prakhar Srivastava
To:     linux-integrity@vger.kernel.org,
        linux-secuirty-module@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     zohar@linux.ibm.com, ebiederm@xmission.com, vgoyal@redhat.com,
        nayna@linux.ibm.com, nramas@microsoft.com, prsriva@microsoft.com,
        Prakhar Srivastava <prsriva02@gmail.com>
Subject: [PATCH 3/5 v4] add kexec_cmdline used to ima
Date:   Fri,  3 May 2019 15:25:21 -0700
Message-Id: <20190503222523.6294-4-prsriva02@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190503222523.6294-1-prsriva02@gmail.com>
References: <20190503222523.6294-1-prsriva02@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Prakhar Srivastava <prsriva02@gmail.com>

prepend the kernel file name to the cmdline args
to avoid conflicrts in case of multiple kexec.
Pass the new generated buffer to ima for measurmenet.

Signed-off-by: Prakhar Srivastava <prsriva02@gmail.com>
---
 kernel/kexec_core.c | 57 +++++++++++++++++++++++++++++++++++++++++++++
 kernel/kexec_file.c | 14 +++++++++++
 2 files changed, 71 insertions(+)

diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index d7140447be75..4667f03d406e 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -1213,3 +1213,60 @@ void __weak arch_kexec_protect_crashkres(void)
 
 void __weak arch_kexec_unprotect_crashkres(void)
 {}
+
+/**
+ * kexec_cmdline_prepend_img_name - prepare the buffer with cmdline
+ * that needs to be measured
+ * @outbuf - out buffer that contains the formated string
+ * @kernel_fd - the file identifier for the kerenel image
+ * @cmdline_ptr - ptr to the cmdline buffer
+ * @cmdline_len - len of the buffer.
+ *
+ * This generates a buffer in the format Kerenelfilename::cmdline
+ *
+ * On success return 0.
+ * On failure return -EINVAL.
+ */
+int kexec_cmdline_prepend_img_name(char **outbuf, int kernel_fd,
+				const char *cmdline_ptr,
+				unsigned long cmdline_len)
+{
+	int ret = -EINVAL;
+	struct fd f = {};
+	int size = 0;
+	char *buf = NULL;
+	char delimiter[] = "::";
+
+	if (!outbuf || !cmdline_ptr)
+		goto out;
+
+	f = fdget(kernel_fd);
+	if (!f.file)
+		goto out;
+
+	size = (f.file->f_path.dentry->d_name.len + cmdline_len - 1+
+			ARRAY_SIZE(delimiter)) - 1;
+
+	buf = kzalloc(size, GFP_KERNEL);
+	if (!buf)
+		goto out;
+
+	memcpy(buf, f.file->f_path.dentry->d_name.name,
+		f.file->f_path.dentry->d_name.len);
+	memcpy(buf + f.file->f_path.dentry->d_name.len,
+		delimiter, ARRAY_SIZE(delimiter) - 1);
+	memcpy(buf + f.file->f_path.dentry->d_name.len +
+		ARRAY_SIZE(delimiter) - 1,
+		cmdline_ptr, cmdline_len - 1);
+
+	*outbuf = buf;
+	ret = size;
+
+	pr_debug("kexec cmdline buff: %s\n", buf);
+
+out:
+	if (f.file)
+		fdput(f);
+
+	return ret;
+}
diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index f1d0e00a3971..d287e139085c 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -191,6 +191,8 @@ kimage_file_prepare_segments(struct kimage *image, int kernel_fd, int initrd_fd,
 	int ret = 0;
 	void *ldata;
 	loff_t size;
+	char *buff_to_measure = NULL;
+	int buff_to_measure_size = 0;
 
 	ret = kernel_read_file_from_fd(kernel_fd, &image->kernel_buf,
 				       &size, INT_MAX, READING_KEXEC_IMAGE);
@@ -241,6 +243,16 @@ kimage_file_prepare_segments(struct kimage *image, int kernel_fd, int initrd_fd,
 			ret = -EINVAL;
 			goto out;
 		}
+
+		/* IMA measures the cmdline args passed to the next kernel*/
+		buff_to_measure_size =
+			kexec_cmdline_prepend_img_name(&buff_to_measure,
+			kernel_fd, image->cmdline_buf, image->cmdline_buf_len);
+
+		ima_buffer_check(buff_to_measure, buff_to_measure_size,
+					"kexec_cmdline");
+
+
 	}
 
 	/* Call arch image load handlers */
@@ -253,7 +265,9 @@ kimage_file_prepare_segments(struct kimage *image, int kernel_fd, int initrd_fd,
 
 	image->image_loader_data = ldata;
 out:
+
 	/* In case of error, free up all allocated memory in this function */
+	kfree(buff_to_measure);
 	if (ret)
 		kimage_file_post_load_cleanup(image);
 	return ret;
-- 
2.20.1

