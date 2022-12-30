Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAE2365958D
	for <lists+linux-integrity@lfdr.de>; Fri, 30 Dec 2022 07:59:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234534AbiL3G7o (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 30 Dec 2022 01:59:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbiL3G7n (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 30 Dec 2022 01:59:43 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D28E13F05
        for <linux-integrity@vger.kernel.org>; Thu, 29 Dec 2022 22:58:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1672383537;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=i6xNXZW5xcHpX8ctqGmuNcrSYwUwnLYg5NtdNPmfezg=;
        b=Iuj+Sh3UsyujM+7Jx8nm6hp8RFolqpvJ0KEPh6acHr/OsVyZsAYTV5DbBv641UeUgWzTEG
        xjsS7d+WESLIlLUPFLfdwy0DBcZotK8icE6nQ/cOVAZGS/VxuTxQzeCacjW2TpdN4A6eDc
        XQ9kqbTzOUmrCMlQ9Vrs4YAQCtxVuIU=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-274-Pn1QvsbiOWKPnV2Ukul8bQ-1; Fri, 30 Dec 2022 01:58:55 -0500
X-MC-Unique: Pn1QvsbiOWKPnV2Ukul8bQ-1
Received: by mail-pj1-f72.google.com with SMTP id il11-20020a17090b164b00b00219a4366109so15092118pjb.0
        for <linux-integrity@vger.kernel.org>; Thu, 29 Dec 2022 22:58:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i6xNXZW5xcHpX8ctqGmuNcrSYwUwnLYg5NtdNPmfezg=;
        b=anRFN/EPf+dWyVYc7hufqSQ5K9verQKVk0S0Wsm6wbyKFQlYzF1msMfkuu5TzRfy1w
         gc4mUUhTHM7ENqVBvfDHK0C+bJ4Osm7RWT4QSb7w9UXehHb5HbbUejFjg/6uffPzm6LU
         pLtO9vzN8qU3d6GWdtXoBXQhINqb5iIRyWShCF8838rCuoNO0AMqdI+pk3NkkMwfVkjA
         d1tNkFtrPwOzZo65m7MkyF7bgf+YDvC+N61EaaL9o9VXgql+fT4zIzIGYgUF2iroSUS7
         t0Iltm/ZPfRVNZbnCfytMGIedT9E4teHKquNJuMNm9xzb8Vz4hedU0+7r6gc4zY7fa9O
         fCug==
X-Gm-Message-State: AFqh2kr96gMKu6ikJW+JebAkXQESFzhZPIHAIll8C1dfG6VXFcTWfsoZ
        n/qi3viOfQhDMGEgXv1gV/84VBXpHNDxWuTqiyKEKIcR6KiGG/8g6JrMlEf9JBm4MUcMLGp+4g1
        aU/7EipDp+XL4d6pgDyINRGF4EOk4
X-Received: by 2002:a05:6a20:1586:b0:9d:efc0:67 with SMTP id h6-20020a056a20158600b0009defc00067mr47397758pzj.15.1672383534930;
        Thu, 29 Dec 2022 22:58:54 -0800 (PST)
X-Google-Smtp-Source: AMrXdXuS31o499EJ+P0QkGmvXR/8sEY71NzOuPxCXXw9OvVKvODqQywZozPkjeIXEo35ZNQmiVJihw==
X-Received: by 2002:a05:6a20:1586:b0:9d:efc0:67 with SMTP id h6-20020a056a20158600b0009defc00067mr47397736pzj.15.1672383534644;
        Thu, 29 Dec 2022 22:58:54 -0800 (PST)
Received: from localhost ([240e:478:10:2273:12cf:a540:d79b:db49])
        by smtp.gmail.com with ESMTPSA id s5-20020aa78bc5000000b00581e0b5ad8dsm1614157pfd.107.2022.12.29.22.58.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Dec 2022 22:58:54 -0800 (PST)
From:   Coiby Xu <coxu@redhat.com>
To:     kexec@lists.infradead.org
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Jiri Bohac <jbohac@suse.cz>,
        David Howells <dhowells@redhat.com>,
        linux-integrity@vger.kernel.org,
        Eric Biederman <ebiederm@xmission.com>,
        Matthew Garrett <mjg59@google.com>,
        James Morris <jmorris@namei.org>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3 1/2] lockdown: kexec_file: prevent unsigned kernel image when KEXEC_SIG not enabled
Date:   Fri, 30 Dec 2022 14:58:49 +0800
Message-Id: <20221230065850.897967-1-coxu@redhat.com>
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
Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
---
v3
 - add lockdown tests to explain why kexec_file_load failed [Mimi]

v2
 - collect reviewed-by tag from Mimi
 - s/mandate_signatute_verification/mandate_signature_verification [Mimi]
 - return the status of kexec_image_verify_sig correctly when signature
   verification is not mandated
---

 kernel/kexec_file.c | 26 +++++++++++++++++---------
 1 file changed, 17 insertions(+), 9 deletions(-)

diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index dd5983010b7b..2c1054ab21ef 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -125,6 +125,17 @@ void kimage_file_post_load_cleanup(struct kimage *image)
 	image->image_loader_data = NULL;
 }
 
+static bool mandate_signature_verification(void)
+{
+	/*
+	 * If IMA is guaranteed to appraise a signature on the kexec
+	 * image, permit it even if the kernel is otherwise locked
+	 * down.
+	 */
+	return !ima_appraise_signature(READING_KEXEC_IMAGE) &&
+	       security_locked_down(LOCKDOWN_KEXEC);
+}
+
 #ifdef CONFIG_KEXEC_SIG
 #ifdef CONFIG_SIGNED_PE_FILE_VERIFICATION
 int kexec_kernel_verify_pe_sig(const char *kernel, unsigned long kernel_len)
@@ -168,13 +179,7 @@ kimage_validate_signature(struct kimage *image)
 			return ret;
 		}
 
-		/*
-		 * If IMA is guaranteed to appraise a signature on the kexec
-		 * image, permit it even if the kernel is otherwise locked
-		 * down.
-		 */
-		if (!ima_appraise_signature(READING_KEXEC_IMAGE) &&
-		    security_locked_down(LOCKDOWN_KEXEC))
+		if (mandate_signature_verification())
 			return -EPERM;
 
 		pr_debug("kernel signature verification failed (%d).\n", ret);
@@ -211,10 +216,13 @@ kimage_file_prepare_segments(struct kimage *image, int kernel_fd, int initrd_fd,
 
 #ifdef CONFIG_KEXEC_SIG
 	ret = kimage_validate_signature(image);
-
+#else
+	if (mandate_signature_verification())
+		ret = -EPERM;
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

