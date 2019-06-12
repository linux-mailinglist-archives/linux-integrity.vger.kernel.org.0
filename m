Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1DA19448D8
	for <lists+linux-integrity@lfdr.de>; Thu, 13 Jun 2019 19:12:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729675AbfFMRLj (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 13 Jun 2019 13:11:39 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:41238 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729099AbfFLWQI (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 12 Jun 2019 18:16:08 -0400
Received: by mail-pg1-f195.google.com with SMTP id 83so9673787pgg.8;
        Wed, 12 Jun 2019 15:16:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+ORNFrPEzZ/qL561J2uCpcfx53+w6rVCIUyixIdCf1s=;
        b=NlY+q/VlevbZyQRc2yuSDOQNjD550KzBxr28rtqrzftham1P0Oup/8EROt0GXj3Uvb
         pCty4kL3SoPjepd/ub0Y/7NdBKWJCDkCl6stIEIV4jBqCuhfc5K7iI1s0AE7szqtmrkc
         2jFjDt4peuZtcBrm7vIBnfXE5St6vtB63/L2VIdJQeGa+qpGriOQFicI2C5QWvHV3iLi
         Wf5XPaoRy1y5J9JMR+G13wo8Y+L8C9P5EeNR0o3UQ7hDXi0oSf4iIQCfEiIMq6IWl4ac
         j382YP2mqIyrkLKYBzk0NreC3fRhRGOTejd108FbV9D4zmQFBQPkKVUKVBGKcksUbB3P
         vq5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+ORNFrPEzZ/qL561J2uCpcfx53+w6rVCIUyixIdCf1s=;
        b=PMLNPXqRTYBkL9Gz8ehqUqUWX3Tg1OeUeBS260e/dDg5uyc46QCq05EjRR+/6rZobW
         2gNlCT2X/4RCY0WrA8Jk6rI2mUUYpWf896iX2hUU9vSMrYoXJxttw+iT9PWmsQfF4JW5
         xR0MOY69L1WDvUgrWkxh5QqhJZ4hGcO8+J50M095nwKL27JRlsU9HjKl7r96iJ2m5hlG
         vmaadsmTwtI65WAa+khA3ycYJZ4g6kEy0H9w53q4qyq2ZSXYxuhhirw3hGPHcVeBx1oK
         is0WmurQREFSYeKAEoXv2udxg+E4J/s3Dtfgx8o1we4smQ3p3npfnHZwIixX6BHRBJAS
         P+5A==
X-Gm-Message-State: APjAAAW2vUSeiPb/bsPsefJFod3gIcWISe5qxTdtIcl4YYciK+W5fkwQ
        gi5Xip56UuucMpsCfOBm0cOdgI04
X-Google-Smtp-Source: APXvYqwSYW/yGY1koyjtWfBEpc795qoM7U3dxAr/0Q841JlWYux1B1pAKe80OF3a2waotr55BFazig==
X-Received: by 2002:a63:5009:: with SMTP id e9mr26649762pgb.396.1560377767345;
        Wed, 12 Jun 2019 15:16:07 -0700 (PDT)
Received: from localhost.localdomain ([167.220.56.169])
        by smtp.gmail.com with ESMTPSA id f7sm506517pfd.43.2019.06.12.15.16.06
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 12 Jun 2019 15:16:06 -0700 (PDT)
From:   Prakhar Srivastava <prsriva02@gmail.com>
To:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     zohar@linux.ibm.com, roberto.sassu@huawei.com, vgoyal@redhat.com,
        Prakhar Srivastava <prsriva02@gmail.com>
Subject: [PATCH V8 3/3] Call ima_kexec_cmdline to measure the cmdline args
Date:   Wed, 12 Jun 2019 15:15:49 -0700
Message-Id: <20190612221549.28399-4-prsriva02@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190612221549.28399-1-prsriva02@gmail.com>
References: <20190612221549.28399-1-prsriva02@gmail.com>
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
added in "Define a new IMA hook to measure the boot command
line arguments"
to measure the boot cmdline args into the ima log.

- call ima_kexec_cmdline from kexec_file_load.
- move the call ima_add_kexec_buffer after the cmdline
args have been measured.

Signed-off-by: Prakhar Srivastava <prsriva02@gmail.com>
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

