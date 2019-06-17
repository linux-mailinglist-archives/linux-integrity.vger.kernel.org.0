Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 42CA548C18
	for <lists+linux-integrity@lfdr.de>; Mon, 17 Jun 2019 20:38:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728058AbfFQSiB (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 17 Jun 2019 14:38:01 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:38925 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728093AbfFQShy (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 17 Jun 2019 14:37:54 -0400
Received: by mail-pf1-f195.google.com with SMTP id j2so6144767pfe.6;
        Mon, 17 Jun 2019 11:37:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0IvJHoD0x6Z/N31hvvGGVGsE7+bjH2MX+F9HjOeromU=;
        b=K5VvM6EmSXz4ivm9/g8rYxPjDUFNZ/MoANmdQz6nC6nVbOHQxg+YZICcrWb79YUyC4
         FzbK4ZNp/MysCu1npO9XtWZmOU/+NYIWOEMtTlGxa2a0FKPRTKCw078iZCMH7EzHB0Xk
         fkb3PgqvTY0PNnVMbcRq64VpoFmEOiERWC8gSM4/I+sWtbhr6Gzvwa+PeLhcYm1Lacua
         nJH7jXumZ9/poiqaNiqLVS+J9A3nRPByY7+g+LvMqXJb2aOn6fze8Nlxg4INXE8klrFc
         RSPpJ5WYXIDGI16i5wEdIkoXF/yvU465EB6eGt9sdchxK6acao9YXhtCytzwtWJZk/dj
         jvrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0IvJHoD0x6Z/N31hvvGGVGsE7+bjH2MX+F9HjOeromU=;
        b=BGT4L2TORZH1o3oatiFSJWdYKBIOP+m8KQUdW0G3Lp72+q24o51AfLYW+OAf/uMdn2
         nCOnURhvjOjhdBPMnQEVguNpki0nonDI9CUOCqfDwNwq8EXlnxCgrAbyraRsiVXsB1CM
         XO8STCUSd/G/4BF1I2bP8P3WEqsZjnEmONwtuqOmwJ3xh+Sbj1MnPnxHZHxM0V2Hy523
         OCMaRf6dKmK24/Ae3su4fpVDjc678FYqwN7+Q3vu5AO3fdNspAdEISvv9CiilclNFn1Q
         RUPTO63+9lUTefscHchUYD2UfXbKbYmY82Y7FBMuEb5Vm9WWVjMMMWvFFIV46VNbLbld
         AvRQ==
X-Gm-Message-State: APjAAAXEsXCVz1ZdUonsz1kCdwsOCsmFLgVoqp0ifwDx6a7o3p1PQTvf
        Lplbj6Y1pi1kmNzEEAPkJq/a2VBH
X-Google-Smtp-Source: APXvYqymGKsAdhabgMr/sqOOF6zIueU9f78kTBHqULt5aG6vZq7ms3evfhAYLVKm3KISQRYexflmPQ==
X-Received: by 2002:a17:90a:c503:: with SMTP id k3mr252796pjt.46.1560796673717;
        Mon, 17 Jun 2019 11:37:53 -0700 (PDT)
Received: from localhost.localdomain ([167.220.56.169])
        by smtp.gmail.com with ESMTPSA id f17sm13104817pgv.16.2019.06.17.11.37.52
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 17 Jun 2019 11:37:52 -0700 (PDT)
From:   Prakhar Srivastava <prsriva02@gmail.com>
To:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     zohar@linux.ibm.com, roberto.sassu@huawei.com,
        Prakhar Srivastava <prsriva02@gmail.com>
Subject: [PATCH V9 3/3] KEXEC:Call ima_kexec_cmdline to measure the boot command line args
Date:   Mon, 17 Jun 2019 11:37:38 -0700
Message-Id: <20190617183738.14484-4-prsriva02@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190617183738.14484-1-prsriva02@gmail.com>
References: <20190617183738.14484-1-prsriva02@gmail.com>
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

