Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 794F3EC45
	for <lists+linux-integrity@lfdr.de>; Mon, 29 Apr 2019 23:48:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729566AbfD2Vr5 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 29 Apr 2019 17:47:57 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:39936 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729547AbfD2Vrz (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 29 Apr 2019 17:47:55 -0400
Received: by mail-pf1-f194.google.com with SMTP id u17so2021215pfn.7;
        Mon, 29 Apr 2019 14:47:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nd7JRPdbxLvL5XXnPZM+72KofBK2uSh5hpjE7bcFdgY=;
        b=bZ/gtSH+gxqoFVBYFfUd2ne+p44W/nuKmlpzG+3HYwGUUzWg/SPfDxZeM8SiI9xLnF
         2yyjoo/iN0SAO+CZmH5v8h2oi/NKx+KN7boi0wT7wSR5e0VKtFhKh6olqT7FPXxRmYwt
         QZNgNl1AcwZsVD0mffHlfH9aajI/TSxcaactBGIPM0TxZbw9IPVJogWGxznY+a9eclDR
         N7tSSeR2gt0oMi1dKJKA6dRRAAq/Sv1lDiE3KKQrZECL3krmUkpjv8KCK1rkJAqAjSqE
         3MG7bZCsKec+QSo7vToJecaqOIEzV0P8QbAcEtCx7215of6O7nuza9F7Y+nKtWkSzkpK
         G7SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nd7JRPdbxLvL5XXnPZM+72KofBK2uSh5hpjE7bcFdgY=;
        b=hrFldYzA7xe8fRX4SxCHqp5mxhIJGrci1D+xenmcfFi0FYdjLVBd2P335FoWFaGJPV
         EEcsqEK6lHDtrJoBL08RaNfsaSSKQInF0+VPgPuth+8RNSUXLu0B8YNzFQRivLTloUht
         DaIdmNowxteNX2+5cg8JUTnh+QU0ddMD8aZBt2iV7sC4EeEzn+RzrDyr1GgVT50xeEXx
         mQtOSsFKRsVF78lBbvEpd0PKu5If3x0S6xnOkZaD4cHdHcPstn4evwTT5CQpk5yf4O27
         lnLVPANxuLVlISM7DfAVTU7pEVG6SxlrEZHNfVP2mjFhfKzK/Bho+81ny8LxbBv22PmH
         +BFg==
X-Gm-Message-State: APjAAAX+7Krp8d8ymE4SY6vvQgekmajaueE9QO92o434OAo0z3z2qrYK
        YNmk846Xtckq/1obP1zSXPdteROLL4s=
X-Google-Smtp-Source: APXvYqz+MGLAt3wcL3q6Kg4W7BpC2bxOqj9J6P1Qy+96vUlknY44oAiGYyCdegZ73v/nig13kExsZg==
X-Received: by 2002:a62:6842:: with SMTP id d63mr43365032pfc.9.1556574474038;
        Mon, 29 Apr 2019 14:47:54 -0700 (PDT)
Received: from prsriva-linux.corp.microsoft.com ([2001:4898:80e8:9:445d:9822:2ddb:fb8c])
        by smtp.gmail.com with ESMTPSA id f66sm1941623pfg.55.2019.04.29.14.47.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Apr 2019 14:47:53 -0700 (PDT)
From:   Prakhar Srivastava <prsriva02@gmail.com>
X-Google-Original-From: Prakhar Srivastava
To:     linux-integrity@vger.kernel.org,
        linux-secuirty-module@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     zohar@linux.ibm.com, ebiederm@xmission.com, vgoyal@redhat.com,
        nayna@linux.ibm.com, Prakhar Srivastava <prsriva02@gmail.com>
Subject: [PATCH v3 3/4] add kexec_cmdline used to ima
Date:   Mon, 29 Apr 2019 14:47:42 -0700
Message-Id: <20190429214743.4625-4-prsriva02@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190429214743.4625-1-prsriva02@gmail.com>
References: <20190429214743.4625-1-prsriva02@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Prakhar Srivastava <prsriva02@gmail.com>

prepend the kernel file name to kexec_cmdline 
before measuring the buffer.

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
2.19.1

