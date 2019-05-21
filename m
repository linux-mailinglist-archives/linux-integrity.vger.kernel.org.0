Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 44E4A244EA
	for <lists+linux-integrity@lfdr.de>; Tue, 21 May 2019 02:07:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727338AbfEUAG5 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 20 May 2019 20:06:57 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:44202 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727319AbfEUAG4 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 20 May 2019 20:06:56 -0400
Received: by mail-pg1-f195.google.com with SMTP id n2so886247pgp.11;
        Mon, 20 May 2019 17:06:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1yoN/ic+Auw9uJWvyGTewovBaYwnACSuIGV6GIUz8AQ=;
        b=XJDRGlQMlUosJ5Mg5JKUcAqICzEoZ6fnxeJ1mRBakghEeIMs2cHJSh7F1xmFUcSCzT
         8vSLW7x0GHT82mQu5d/K0U/Qc1B9b0ENB7hSLas40ByixsHSjefZrGwZXjWax5d317CV
         IA6oekMu/WPPGvus26xUalii1CK2XqBqINVdZkTC+r/UwIXYSEqYEmSJz5ynxtUi5oNJ
         ZLQYdBr/r6C8dg9wPzPT+oAY6JvKZyW5iCXSrD02JamMSiHagVsidJNDiHbaGxoCvYbk
         6ujGUPqL9Iy9vvrmJEzNIDjWLCXdo0q6RB6TsBODAZF/NDfjMIuGdjAgDF4XbKy2Fg02
         QZgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=1yoN/ic+Auw9uJWvyGTewovBaYwnACSuIGV6GIUz8AQ=;
        b=PN+Ng8SxixTEURAXRnjolPtFL270IFsewO+P0m+JOrFeDqypH2LWbtWZpuFZNn232H
         gaP+5N8wdbn6LoJ5opB+eDR1Sey3XDusSqUOJCndRCYQyAZAE1A/iMwXGIyQ+TpaUORB
         KabOtrDXjTLTIS3zmPdLp0ohGCTV0v1jqrQV3om62UrKbjAopBl5FCcLPECF40d2mNxv
         z6OZ78lt2oA15O/gHwZZZ2PZUxfoEkfLBwldSCeF5nK6AkMNly+h9XJeXeBTMbgyDz1e
         9jLPVgvic7OhEPN3imYCdfz/PqyvIIqVPpYF8qdPywgUI9Aa1g4PKJn+1pOmcmAL4bBj
         VOdA==
X-Gm-Message-State: APjAAAUXYxc04radiAqo9wLc+8lRFSl44PRx7LfrMgUXAVuOmk3nH8re
        GaPf0thPA/VZ9SiOzFWRX5YZdrY+IAt88A==
X-Google-Smtp-Source: APXvYqz5McZmyf02dFOcHsmr8oHPkuNwM1ouhKJ3ecm085qvCV4DpjQW8xBrJ/mXtDpkZ4rlxln7NA==
X-Received: by 2002:a63:40b:: with SMTP id 11mr62107358pge.31.1558397215422;
        Mon, 20 May 2019 17:06:55 -0700 (PDT)
Received: from prsriva-Precision-Tower-5810.corp.microsoft.com ([2001:4898:80e8:1:e5e3:4312:180a:c25e])
        by smtp.gmail.com with ESMTPSA id i16sm5939149pfd.100.2019.05.20.17.06.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 May 2019 17:06:54 -0700 (PDT)
From:   Prakhar Srivastava <prsriva02@gmail.com>
To:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     mjg59@google.com, zohar@linux.ibm.com, roberto.sassu@huawei.com,
        vgoyal@redhat.com, Prakhar Srivastava <prsriva02@gmail.com>
Subject: [PATCH v6 3/3] call ima_kexec_cmdline to measure the cmdline args
Date:   Mon, 20 May 2019 17:06:45 -0700
Message-Id: <20190521000645.16227-4-prsriva02@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190521000645.16227-1-prsriva02@gmail.com>
References: <20190521000645.16227-1-prsriva02@gmail.com>
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
index f1d0e00a3971..fcc04a230925 100644
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
2.17.1

