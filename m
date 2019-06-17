Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A424148C04
	for <lists+linux-integrity@lfdr.de>; Mon, 17 Jun 2019 20:36:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726776AbfFQSf4 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 17 Jun 2019 14:35:56 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:41397 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726121AbfFQSfz (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 17 Jun 2019 14:35:55 -0400
Received: by mail-pl1-f194.google.com with SMTP id m7so858148pls.8;
        Mon, 17 Jun 2019 11:35:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0IvJHoD0x6Z/N31hvvGGVGsE7+bjH2MX+F9HjOeromU=;
        b=OExWykqYB1XFOJ0uAdfVjaD7+Rm+ptb+DGzRrFHXrfqUpNWmT+gyfF49bfYgfui6Gg
         XgnxapiU1/pFppenKXF78Tu7baKT6rjno8xgPl58yrOR65sg1dst3gH8VSsDKA/fhM9g
         Isxo4e0gzq+QSCl1q2FCeidJ5Ap8TyDOff9CzQzp5cu1gUWXogVIAKzBfTxNm8ycDqVJ
         Wkj+iZe5wWKcb8IBJ6e1EvNehilkjWeMnCX9UFmw7k7UdUjXefP2Yz0hgoscpcim8r6o
         W0OF8+PdpHRKyy5E2/VxK7rb5Fxq5MPaO6FA0PuTD6FFcV4G1VpWUFCZv6UIj/7e14Tv
         rvTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0IvJHoD0x6Z/N31hvvGGVGsE7+bjH2MX+F9HjOeromU=;
        b=oz5QlQom1uknXgqzEIa1usPwjH6qkJL1Pa0R+oJpAQYpBLj8WHPK4lUxaoD7OGzYb5
         rfMQcenJrjdvGMwjJr8Orcqy+CkC33O/F1AlNRfXvycZ/SP3+P59BmeqDz/WSQ58o+9t
         QWIM5ZGcNZKy/bAz7RuG8zEP/086tqHwJaGyC39sZ1Kw8sYWdjBO3Wzrl7e5CAZvE3Md
         jgLP+StlrjauGOjGH+eAFnB1RYCfPeqfynpQ/wpELpYjf9xFvc136SIhalPovdi63Hco
         PICyRnnbN6vQ0xr+e2vG7hAshBog+Ib9oZ7EUGfPi5FHtrREoDhm+qarAedibNkwG71q
         RAbA==
X-Gm-Message-State: APjAAAW11g3MwFFTkqCwWt50/KVZeya7C5MwOW+dA5GdeDqwV4C+uGLJ
        11Ad70ASsEbGgpS8NADl58ESXXD3
X-Google-Smtp-Source: APXvYqzQntCtPL7/RfEPKtQ1u4ORO2tP31brIoKS1bdz/vxC7dsrRsL18sLgrnNiWQCGWGBm1k+E5Q==
X-Received: by 2002:a17:902:6a4:: with SMTP id 33mr3796492plh.338.1560796554726;
        Mon, 17 Jun 2019 11:35:54 -0700 (PDT)
Received: from localhost.localdomain ([167.220.56.169])
        by smtp.gmail.com with ESMTPSA id f186sm16552946pfb.5.2019.06.17.11.35.53
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 17 Jun 2019 11:35:54 -0700 (PDT)
From:   Prakhar Srivastava <prsriva02@gmail.com>
To:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     zohar@linux.ibm.com, roberto.sassu@huawei.com,
        Prakhar Srivastava <prsriva02@gmail.com>
Subject: [PATCH 3/3] KEXEC:Call ima_kexec_cmdline to measure the boot command line args
Date:   Mon, 17 Jun 2019 11:35:07 -0700
Message-Id: <20190617183507.14160-4-prsriva02@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190617183507.14160-1-prsriva02@gmail.com>
References: <20190617183507.14160-1-prsriva02@gmail.com>
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

