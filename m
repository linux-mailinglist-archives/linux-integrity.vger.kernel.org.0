Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84DAB7BA904
	for <lists+linux-integrity@lfdr.de>; Thu,  5 Oct 2023 20:26:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229598AbjJES0P (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 5 Oct 2023 14:26:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231179AbjJES0O (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 5 Oct 2023 14:26:14 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F0C26AB
        for <linux-integrity@vger.kernel.org>; Thu,  5 Oct 2023 11:26:13 -0700 (PDT)
Received: from tushar-HP-Pavilion-Laptop-15-eg0xxx.lan (unknown [50.46.228.62])
        by linux.microsoft.com (Postfix) with ESMTPSA id 4FD0220B74C5;
        Thu,  5 Oct 2023 11:26:13 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 4FD0220B74C5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1696530373;
        bh=Udqv0jaboMhxWHknI6g5+GDLvPqkVFywTKuSTdC2gbc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LqSMC7bERhS0/N9DffbA9GM3BY+SW1tOE0W+Jh2x5uqnVbKTyjgIlB8ngOwdezyxc
         05WBHartxAG3n2JcJcb1tcSE44PT/HLgJLdRVwqlRLdkRSonltLyrengvISLxTUMXq
         GQLsQf09S+iFLhmHqu/NN8s7Dv/zDE6kxL+QPpRI=
From:   Tushar Sugandhi <tusharsu@linux.microsoft.com>
To:     zohar@linux.ibm.com, ebiederm@xmission.com, noodles@fb.com,
        bauermann@kolabnow.com, kexec@lists.infradead.org,
        linux-integrity@vger.kernel.org
Cc:     code@tyhicks.com, nramas@linux.microsoft.com, paul@paul-moore.com
Subject: [PATCH v2 4/7] kexec: update kexec_file_load syscall to call ima_kexec_post_load
Date:   Thu,  5 Oct 2023 11:25:59 -0700
Message-Id: <20231005182602.634615-5-tusharsu@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231005182602.634615-1-tusharsu@linux.microsoft.com>
References: <20231005182602.634615-1-tusharsu@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-17.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

The kexec_file_load() syscall is used to load a new Kernel for kexec.
The syscall needs to be updated to call ima_kexec_post_load(),
which was implemented in a previous patch.  ima_kexec_post_load() should
take care of mapping the IMA log buffer segment into the next Kernel. It
should also register a reboot notifier which would call a function to
dump the IMA measurements into IMA log buffer segment during kexec soft
reboot.

Modify the kexec_file_load() syscall to call ima_kexec_post_load() after
the image has been loaded and prepared for kexec.  This ensures that the
IMA measurement list will be available to the next Kernel after a kexec
soft reboot.  This also ensures the measurements taken in the window
between kexec 'load' and 'execute' are captured and passed to the next
Kernel.

Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
---
 kernel/kexec_file.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index f989f5f1933b..617dbbb6e46d 100644
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
@@ -399,6 +404,9 @@ SYSCALL_DEFINE5(kexec_file_load, int, kernel_fd, int, initrd_fd,
 
 	kimage_terminate(image);
 
+	if (!(flags & KEXEC_FILE_ON_CRASH))
+		kimage_file_post_load(image);
+
 	ret = machine_kexec_post_load(image);
 	if (ret)
 		goto out;
-- 
2.25.1

