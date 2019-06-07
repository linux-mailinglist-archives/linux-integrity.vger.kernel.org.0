Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4ACD13821C
	for <lists+linux-integrity@lfdr.de>; Fri,  7 Jun 2019 02:24:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728261AbfFGAYK (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 6 Jun 2019 20:24:10 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:42128 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728164AbfFGAYJ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 6 Jun 2019 20:24:09 -0400
Received: by mail-pl1-f194.google.com with SMTP id go2so95800plb.9;
        Thu, 06 Jun 2019 17:24:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jdwxKl4wizRzQbk4/KFjYiC+r5p9VBOXnRG4nGLJdyM=;
        b=frlMsdvRlMIKMpedZliCN+HPffi6wAqXgAoTFT8Ks+g5V7zdE7bX8303KGk27gtbes
         KMHRG6XxHla+t/fP27Flq6gQ4Pv6SdLY5U4NbA2c1MIQuZwsttKx6pVpUxn8YO/EGFAX
         9rgGij9qUU0JNksQt5hHOuXHl2Tzi2sluMKkmdzufcam7R2Q213zaozVtY3CHbANb1GT
         HD8d0cfs4kHCjLoETZCpWnSW/UMg8aPu92Aakyfpky0kzUO/hMKQNiwIEr19kzLJRFB0
         2xqVrL6IHVIj7ycebNkSBfparupv7fFgKsy7dpANcDbDMl5NcIgik2M989+cU/l16kd/
         rQQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jdwxKl4wizRzQbk4/KFjYiC+r5p9VBOXnRG4nGLJdyM=;
        b=BeMZK73EAf0eP0xu1pqTrLYwbm4EJ1gP77xlrB5IhYXYm9ADjFNCwEFiTymd939fdA
         mqgRey5PdThzM1LCTHCgl3okYu1AAYsVGn+JuZljUoulV4fz2XTeBciv0Zj+xk7+b7VM
         9hD0/MtiITgymti0YVoPskED46grgrgtuAvUVwKkE7l4KKj7jJCUMMmzHp6HX0h1pOA6
         8WWDtUNw0HzFnwkeB/QAc+uCNuf869Iy/2uvEqSf/O+AYtWcBUODQGXDi0h2/dkeILD3
         zwq+IxUyXFKsWDWc7e4I2o+BSseF+RxOicRY2k090SIN6Bpz6QZbnv3gSI5zuKL3HyjE
         qC8w==
X-Gm-Message-State: APjAAAUtR2jea9/RxYBZgD+0Hb8OXE8iOV7lsMXL4O4i5/ANlTwfG0os
        0PVTzB/ldxoetm32j2WNRPGzH7jT
X-Google-Smtp-Source: APXvYqz/nkScLwgduXSW5wicT5ZRU/9QLcW+qAU40EZc1xQ7j9Og96KOCy6jxVbdHntHKFuBJ50DIA==
X-Received: by 2002:a17:902:f01:: with SMTP id 1mr52664019ply.170.1559867048193;
        Thu, 06 Jun 2019 17:24:08 -0700 (PDT)
Received: from localhost.localdomain ([167.220.98.69])
        by smtp.gmail.com with ESMTPSA id o13sm324179pfh.23.2019.06.06.17.24.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Jun 2019 17:24:07 -0700 (PDT)
From:   Prakhar Srivastava <prsriva02@gmail.com>
To:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     zohar@linux.ibm.com, roberto.sassu@huawei.com, vgoyal@redhat.com,
        Prakhar Srivastava <prsriva02@gmail.com>
Subject: [PATCH v7 3/3] call ima_kexec_cmdline to measure the cmdline args
Date:   Thu,  6 Jun 2019 17:23:30 -0700
Message-Id: <20190607002330.2999-4-prsriva02@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190607002330.2999-1-prsriva02@gmail.com>
References: <20190607002330.2999-1-prsriva02@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

During soft reboot(kexec_file_load) boot cmdline args
are not measured.Thus the new kernel on load boots with
an assumption of cold reboot.

This patch makes a call to the ima hook ima_kexec_cmdline,
added in "Add a new ima hook ima_kexec_cmdline to measure
cmdline args"
to measure the boot cmdline args into the ima log.

- call ima_kexec_cmdline from kexec_file_load.
- move the call ima_add_kexec_buffer after the cmdline
args have been measured.

Signed-off-by: Prakhar Srivastava <prsriva02@gmail.com>
---
 kernel/kexec_file.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index 072b6ee55e3f..ed4727586fc3 100644
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
@@ -241,8 +238,13 @@ kimage_file_prepare_segments(struct kimage *image, int kernel_fd, int initrd_fd,
 			ret = -EINVAL;
 			goto out;
 		}
+
+		ima_kexec_cmdline(image->cmdline_buf, image->cmdline_buf_len - 1);
 	}
 
+	/* IMA needs to pass the measurement list to the next kernel. */
+	ima_add_kexec_buffer(image);
+
 	/* Call arch image load handlers */
 	ldata = arch_kexec_kernel_image_load(image);
 
-- 
2.19.1

