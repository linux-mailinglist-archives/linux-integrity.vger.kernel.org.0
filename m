Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5EB775023B
	for <lists+linux-integrity@lfdr.de>; Mon, 24 Jun 2019 08:25:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727682AbfFXGYx (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 24 Jun 2019 02:24:53 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:46314 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727266AbfFXGYx (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 24 Jun 2019 02:24:53 -0400
Received: by mail-pg1-f194.google.com with SMTP id v9so6512131pgr.13;
        Sun, 23 Jun 2019 23:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0IvJHoD0x6Z/N31hvvGGVGsE7+bjH2MX+F9HjOeromU=;
        b=NZyt9A/FB82vZiEifdr4Gx0xRekMuZIHBVLc2U4ciy49oyXnteKcbU3xAWpZIH2Oi0
         QqUJZ+arQh/RT94jLsK6IWOt4GUGUOl4w1VMPgcoxBf14CzYX6lJk+ZOXkdCGqc+EG6w
         TFi44c4Dd8PW752R9KlLakLU49Wz9A2M/qfAG8wALOpUyS8gGbt2FyWyal3iRntzcWco
         ApVGW8Sy6mQeBzPTpyejshIpszTRZzop41iqenSASYj/tKxS5cI2BrtMuutB0zvoc5bI
         Bpz+yoZ5CbAZwxdqiz2Np+SzSIRNXE2EJ8lzuDwyFG+HDB0VhGxZwcbpPfjRvXukzUPy
         goMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0IvJHoD0x6Z/N31hvvGGVGsE7+bjH2MX+F9HjOeromU=;
        b=DKzuBrCv82+ZPM/15q+iML71BkEdnTvwOHBNzlJgsR6E0T9O6I76K8RRjHQ4XXtH2V
         /Ds9EvUhXYn3AZ5fd36p16T7lA4HUaVMxsSFbOR2gtTe+KvxgdE6o4dFSLQWMqOt2yWH
         r4UpxTujwVS0du+Dz837f12YxAignvVsvwQ/lFbVoVr+uAhgtrPRISDt6axVVUPMcCcv
         IVLhdRVs0hISuau7bLZpLx+EHo2hZYthqcbsvhwe/vbDLET2aRYJRDcwiEViHrJBx2gE
         LTPWhQAqRXfhLul2FLg902FFA2ueoh+cshXWTE87H0dN69NHhc1RQsXVwjrCbQbL246T
         +d5w==
X-Gm-Message-State: APjAAAXIZbg/qNiMrd3rQ79GDUawYCgD+I4ugxtnBFC+RM+w75bKzhzH
        z41oMw2wlFzch2oOZUWDd9byb0MD
X-Google-Smtp-Source: APXvYqxTzWCohtq7uhbcpUGfCJQdaCRM5/dDC1t+UWjKV1bWOZDk0wItx04vbN7k1hGgnsy6X7/wDA==
X-Received: by 2002:a63:4641:: with SMTP id v1mr25070516pgk.347.1561357492003;
        Sun, 23 Jun 2019 23:24:52 -0700 (PDT)
Received: from prsriva-ThinkPad-P50s.hsd1.wa.comcast.net ([2601:602:9c01:c794:e00a:1dbc:5f62:b8ea])
        by smtp.gmail.com with ESMTPSA id 191sm2641620pfu.177.2019.06.23.23.24.51
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 23 Jun 2019 23:24:51 -0700 (PDT)
From:   Prakhar Srivastava <prsriva02@gmail.com>
To:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     zohar@linux.ibm.com, roberto.sassu@huawei.com, vgoyal@redhat.com,
        Prakhar Srivastava <prsriva02@gmail.com>
Subject: [PATCH V10 3/3] KEXEC: Call ima_kexec_cmdline to measure the boot command line args
Date:   Sun, 23 Jun 2019 23:23:31 -0700
Message-Id: <20190624062331.388-4-prsriva02@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190624062331.388-1-prsriva02@gmail.com>
References: <20190624062331.388-1-prsriva02@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

During soft reboot(kexec_file_load) boot command line
arguments are not measured.

Call ima hook ima_kexec_cmdline to measure the boot command line
arguments into IMA measurement list.

- call ima_kexec_cmdline from kexec_file_load.
- move the call ima_add_kexec_buffer after the cmdline
args have been measured.

Signed-off-by: Prakhar Srivastava <prsriva02@gmail.com>
Reviewed-by: James Morris <jamorris@linux.microsoft.com>
Acked-by: Dave Young <dyoung@redhat.com>
---
 kernel/kexec_file.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index 072b6ee55e3f..b0c724e5d86c 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -198,9 +198,6 @@ kimage_file_prepare_segments(struct kimage *image, int kernel_fd, int initrd_fd,
 		return ret;
 	image->kernel_buf_len = size;
 
-	/* IMA needs to pass the measurement list to the next kernel. */
-	ima_add_kexec_buffer(image);
-
 	/* Call arch image probe handlers */
 	ret = arch_kexec_kernel_image_probe(image, image->kernel_buf,
 					    image->kernel_buf_len);
@@ -241,8 +238,14 @@ kimage_file_prepare_segments(struct kimage *image, int kernel_fd, int initrd_fd,
 			ret = -EINVAL;
 			goto out;
 		}
+
+		ima_kexec_cmdline(image->cmdline_buf,
+				  image->cmdline_buf_len - 1);
 	}
 
+	/* IMA needs to pass the measurement list to the next kernel. */
+	ima_add_kexec_buffer(image);
+
 	/* Call arch image load handlers */
 	ldata = arch_kexec_kernel_image_load(image);
 
-- 
2.19.1

