Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 801C8631A58
	for <lists+linux-integrity@lfdr.de>; Mon, 21 Nov 2022 08:31:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229660AbiKUHbo (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 21 Nov 2022 02:31:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229699AbiKUHbm (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 21 Nov 2022 02:31:42 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A418A6DFCF
        for <linux-integrity@vger.kernel.org>; Sun, 20 Nov 2022 23:29:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669015798;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=PzrpIQOcRog587drqyOgalYCERQdLn/ggTvNzPloyBI=;
        b=hKTW+BfQMY55SqBtFY9LYsktEBaAYXmU9RV1DItvZ7eo86DbMHwfQMOCA74GI0RvAT0LGT
        Sg7tnrHM+3ZDEJEkI6ZPmLoguwd5cN5IfDhPIf0bF/M1QQUVBpL2sVbJVnYi3iGT5RHEly
        6PJ2+9bjcaWqSnmgQmIPN8FBFQD9JQA=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-68-m66XR0Z5Nw-zaN_-REuKRw-1; Mon, 21 Nov 2022 02:29:56 -0500
X-MC-Unique: m66XR0Z5Nw-zaN_-REuKRw-1
Received: by mail-pj1-f72.google.com with SMTP id mh8-20020a17090b4ac800b0021348e084a0so11413759pjb.8
        for <linux-integrity@vger.kernel.org>; Sun, 20 Nov 2022 23:29:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PzrpIQOcRog587drqyOgalYCERQdLn/ggTvNzPloyBI=;
        b=nH9N091HE4F2qpn4q3JgIThHNHxO+429ULwEUe+actBD0gvqrXhPkB37ffYbjXNcx3
         oR+iBTtzy64B67FkwPcVKfJ+CyKUtvgB2qi9Ag1LdAPD6eWYDGtEY+ah6pCS8Z1S6kgS
         NEks8A+0YKrxXlXUEo7mqpUXFBvruyl4xBlvIjPRoSo05znkJguYplMr5iTC8DTUWUAW
         KbWRR+ExpdqSeXByla+uCf/KQddAfY5s1uZO1aB6LMTWdodxipi+fVyP0na6WP6RQpVK
         OVdQP58oEVnKeYxZP6f35eLTNY895Gn9rLHexn8tD038vvsJ+AP8/w/33IYg4zG8xSWx
         ItKg==
X-Gm-Message-State: ANoB5pnfVNR09HjjYcfiEUUsZcrbI4A5rDh/lX68jXwW5lADzC2jgNd+
        Sm2CaeuS3hS5pnLeevoEIK8jl/uVrDgLsH3qxS2rWzp/fEDs1qEhYPVHvRfwpa9aHyVljksaHgh
        Owg7C7sBejO9Ag6CZ8y6ISzsShbqB
X-Received: by 2002:a17:902:bcc7:b0:188:f42e:6a90 with SMTP id o7-20020a170902bcc700b00188f42e6a90mr926382pls.127.1669015795847;
        Sun, 20 Nov 2022 23:29:55 -0800 (PST)
X-Google-Smtp-Source: AA0mqf7EcYX61iVqKcEdoBRAEQ94b78zalp2WbshZ4Dz+5rKx3bpryPWxZ9XpTzupJLi96mob2prPA==
X-Received: by 2002:a17:902:bcc7:b0:188:f42e:6a90 with SMTP id o7-20020a170902bcc700b00188f42e6a90mr926361pls.127.1669015795583;
        Sun, 20 Nov 2022 23:29:55 -0800 (PST)
Received: from localhost ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id s16-20020a170902a51000b001869f2120a5sm8886857plq.34.2022.11.20.23.29.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Nov 2022 23:29:54 -0800 (PST)
From:   Coiby Xu <coxu@redhat.com>
To:     kexec@lists.infradead.org
Cc:     Matthew Garrett <mjg59@srcf.ucam.org>, Jiri Bohac <jbohac@suse.cz>,
        David Howells <dhowells@redhat.com>,
        linux-integrity@vger.kernel.org,
        Eric Biederman <ebiederm@xmission.com>,
        James Morris <jmorris@namei.org>,
        Matthew Garrett <mjg59@google.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] lockdown: kexec_file: prevent unsigned kernel image when KEXEC_SIG not enabled
Date:   Mon, 21 Nov 2022 15:29:47 +0800
Message-Id: <20221121072947.836672-1-coxu@redhat.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

A kernel builder may not enable KEXEC_SIG and some architectures like
ppc64 simply don't have KEXEC_SIG. In these cases, unless both
IMA_ARCH_POLICY and secure boot also enabled, lockdown doesn't prevent
unsigned kernel image from being kexec'ed via the kexec_file_load
syscall whereas it could prevent one via the kexec_load syscall. Mandate
signature verification for those cases.

Fixes: 155bdd30af17 ("kexec_file: Restrict at runtime if the kernel is locked down")
Cc: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Jiri Bohac <jbohac@suse.cz>
Cc: David Howells <dhowells@redhat.com>
Cc: kexec@lists.infradead.org
Cc: linux-integrity@vger.kernel.org
Signed-off-by: Coiby Xu <coxu@redhat.com>
---
 kernel/kexec_file.c | 31 +++++++++++++++++++++----------
 1 file changed, 21 insertions(+), 10 deletions(-)

diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index 45637511e0de..04d56b6e6459 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -125,6 +125,20 @@ void kimage_file_post_load_cleanup(struct kimage *image)
 	image->image_loader_data = NULL;
 }
 
+static int mandate_signatute_verification(void)
+{
+	/*
+	 * If IMA is guaranteed to appraise a signature on the kexec
+	 * image, permit it even if the kernel is otherwise locked
+	 * down.
+	 */
+	if (!ima_appraise_signature(READING_KEXEC_IMAGE) &&
+	    security_locked_down(LOCKDOWN_KEXEC))
+		return -EPERM;
+
+	return 0;
+}
+
 #ifdef CONFIG_KEXEC_SIG
 #ifdef CONFIG_SIGNED_PE_FILE_VERIFICATION
 int kexec_kernel_verify_pe_sig(const char *kernel, unsigned long kernel_len)
@@ -168,14 +182,9 @@ kimage_validate_signature(struct kimage *image)
 			return ret;
 		}
 
-		/*
-		 * If IMA is guaranteed to appraise a signature on the kexec
-		 * image, permit it even if the kernel is otherwise locked
-		 * down.
-		 */
-		if (!ima_appraise_signature(READING_KEXEC_IMAGE) &&
-		    security_locked_down(LOCKDOWN_KEXEC))
-			return -EPERM;
+		ret = mandate_signatute_verification();
+		if (ret)
+			return ret;
 
 		pr_debug("kernel signature verification failed (%d).\n", ret);
 	}
@@ -211,10 +220,12 @@ kimage_file_prepare_segments(struct kimage *image, int kernel_fd, int initrd_fd,
 
 #ifdef CONFIG_KEXEC_SIG
 	ret = kimage_validate_signature(image);
-
+#else
+	ret = mandate_signatute_verification();
+#endif
 	if (ret)
 		goto out;
-#endif
+
 	/* It is possible that there no initramfs is being loaded */
 	if (!(flags & KEXEC_FILE_NO_INITRAMFS)) {
 		ret = kernel_read_file_from_fd(initrd_fd, 0, &image->initrd_buf,
-- 
2.38.1

