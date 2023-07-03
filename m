Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CAEE74653B
	for <lists+linux-integrity@lfdr.de>; Mon,  3 Jul 2023 23:57:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231403AbjGCV5Z (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 3 Jul 2023 17:57:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231409AbjGCV5W (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 3 Jul 2023 17:57:22 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 76A65187
        for <linux-integrity@vger.kernel.org>; Mon,  3 Jul 2023 14:57:21 -0700 (PDT)
Received: from tushar-HP-Pavilion-Laptop-15-eg0xxx.lan (c-98-237-170-177.hsd1.wa.comcast.net [98.237.170.177])
        by linux.microsoft.com (Postfix) with ESMTPSA id CF96B208FFDD;
        Mon,  3 Jul 2023 14:57:20 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com CF96B208FFDD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1688421441;
        bh=IA4qVA7yS6tfVuU9PQyqSbjKk9N21XI0y5043nMYdXg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QGLrEABDXJHWi1bi5YE/9tRYciFa8BBH+oONcU85PCku4cyeQ0jqkVCY0h1wIVqcy
         h/KyREwavxt4474a6GxwSENgRdxekCa24hShwYzfX3rdsKmmSLVjku82b3VG5bb+R1
         zupINlJPJ/ih+YJwakHujz/W1kM+TvaSzdCeqgqY=
From:   Tushar Sugandhi <tusharsu@linux.microsoft.com>
To:     zohar@linux.ibm.com, noodles@fb.com, bauermann@kolabnow.com,
        kexec@lists.infradead.org, linux-integrity@vger.kernel.org
Cc:     code@tyhicks.com, nramas@linux.microsoft.com, paul@paul-moore.com
Subject: [PATCH 10/10] kexec: update kexec_file_load syscall to call ima_kexec_post_load
Date:   Mon,  3 Jul 2023 14:57:09 -0700
Message-Id: <20230703215709.1195644-11-tusharsu@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230703215709.1195644-1-tusharsu@linux.microsoft.com>
References: <20230703215709.1195644-1-tusharsu@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

The kexec_file_load syscall is used to load a new kernel for kexec.
The syscall needs to update its function to call ima_kexec_post_load, which
was implemented in a previous patch.  ima_kexec_post_load takes care of
mapping the measurement list for the next kernel and registering a reboot
notifier if it's not already registered.

Modify the kexec_file_load syscall to call ima_kexec_post_load after the
image has been loaded and prepared for kexec.  This ensures that the IMA
measurement list will be available to the next kernel after a kexec reboot.
This also ensures the measurements taken in the window between kexec load
and execute are captured and passed to the next kernel. 

Declare the kimage_file_post_load function in the kernel/kexec_internal.h, 
so it can be properly used in the syscall.

Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
---
 kernel/kexec_file.c     | 7 +++++++
 kernel/kexec_internal.h | 1 +
 2 files changed, 8 insertions(+)

diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index f989f5f1933b..efe28e77280c 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -184,6 +184,11 @@ kimage_validate_signature(struct kimage *image)
 }
 #endif
 
+void kimage_file_post_load(struct kimage *image)
+{
+	ima_kexec_post_load(image);
+}
+
 /*
  * In file mode list of segments is prepared by kernel. Copy relevant
  * data from user space, do error checking, prepare segment list
@@ -399,6 +404,8 @@ SYSCALL_DEFINE5(kexec_file_load, int, kernel_fd, int, initrd_fd,
 
 	kimage_terminate(image);
 
+	kimage_file_post_load(image);
+
 	ret = machine_kexec_post_load(image);
 	if (ret)
 		goto out;
diff --git a/kernel/kexec_internal.h b/kernel/kexec_internal.h
index 74da1409cd14..98dd5fcafaf0 100644
--- a/kernel/kexec_internal.h
+++ b/kernel/kexec_internal.h
@@ -30,6 +30,7 @@ static inline void kexec_unlock(void)
 
 #ifdef CONFIG_KEXEC_FILE
 #include <linux/purgatory.h>
+void kimage_file_post_load(struct kimage *image);
 void kimage_file_post_load_cleanup(struct kimage *image);
 extern char kexec_purgatory[];
 extern size_t kexec_purgatory_size;
-- 
2.25.1

