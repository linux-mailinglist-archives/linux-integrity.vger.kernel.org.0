Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC707564B52
	for <lists+linux-integrity@lfdr.de>; Mon,  4 Jul 2022 03:53:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233032AbiGDBwj (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 3 Jul 2022 21:52:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230122AbiGDBwi (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 3 Jul 2022 21:52:38 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2B1582630
        for <linux-integrity@vger.kernel.org>; Sun,  3 Jul 2022 18:52:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656899557;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MT59o1vyNl28UvpV0L18f4IgJU3gRlDgKTViOwYZmyQ=;
        b=fzHjmVSFSjMaYZjxHKjdl6ckw+dXnzD8IvQmtuoJx/Tb1XnXEwiemhBW00uU50pGbyozc+
        e3S1rOQE/W9/y3u6eW5d/UT9vIlJq4sLfJfdb1+hJRS/V57wSFDrjJInz4nZiujrR+cLZq
        qllx1xcTcZusLQKhZNwQwsdAvGQH7RA=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-390-vNIeu2AxNxGEPL55_4Jgpg-1; Sun, 03 Jul 2022 21:52:33 -0400
X-MC-Unique: vNIeu2AxNxGEPL55_4Jgpg-1
Received: by mail-pj1-f72.google.com with SMTP id mh7-20020a17090b4ac700b001ef88609386so729018pjb.9
        for <linux-integrity@vger.kernel.org>; Sun, 03 Jul 2022 18:52:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MT59o1vyNl28UvpV0L18f4IgJU3gRlDgKTViOwYZmyQ=;
        b=j6ZvMlrxlv4+O2NI8s6/DSDx+2weXR8+2Zrvprp1nALOcZmjewuFNKoX8rN/NphSou
         4fIsBMMGMWnM3t4IVDN0PAdsL2YrRggIiBKmHScHjmagDiqqj8WLlha4u8XHr0SnNGXV
         NyuhiB9JVD7l96v0lL/yA1ud9nw4oZKP20yw6zaHSPmaokD5l26AxvU+XRhVPYeW0xxG
         93NYuVMgOpYBetMJI2gDTftdokz2AjDDDbmAOfNSKVaNQccKru+L01Wz5MraJfAAFvy9
         MfEYjxaiYm6cbS1HKou1ATgvqL3TLsm89JLHquuxfag2Ggh7z+dc9MnrktzY9WLp11mv
         P6tw==
X-Gm-Message-State: AJIora8c0UHLiq9ayb4adS0/pVoBzjSDo3KgWm05sEdJLmCSd2eR3P5I
        uHLrZf7TSf7mqsN9WVvOlhV8NIB+A4LpSjiL2bT4yL5oHEhs9ATpX/JE5QquwmD194QCPhaK2RZ
        dzRpcjtME/1EuuW9vh6IhLu4D+c9o
X-Received: by 2002:a05:6a00:134b:b0:525:b7cc:30b5 with SMTP id k11-20020a056a00134b00b00525b7cc30b5mr34248660pfu.32.1656899551988;
        Sun, 03 Jul 2022 18:52:31 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1swtT1/ZGRM402/NNr6/11axGlFQ3W8t6/TrZaLKS4HwWEg/bXgrfKUGlU7DvgjIxWMijELOQ==
X-Received: by 2002:a05:6a00:134b:b0:525:b7cc:30b5 with SMTP id k11-20020a056a00134b00b00525b7cc30b5mr34248637pfu.32.1656899551714;
        Sun, 03 Jul 2022 18:52:31 -0700 (PDT)
Received: from localhost ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id v6-20020a1709029a0600b0015edc07dcf3sm19697225plp.21.2022.07.03.18.52.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Jul 2022 18:52:31 -0700 (PDT)
From:   Coiby Xu <coxu@redhat.com>
To:     kexec@lists.infradead.org, linux-integrity@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        linux-arm-kernel@lists.infradead.org,
        Michal Suchanek <msuchanek@suse.de>,
        Baoquan He <bhe@redhat.com>, Dave Young <dyoung@redhat.com>,
        Will Deacon <will@kernel.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Chun-Yi Lee <jlee@suse.com>, stable@vger.kernel.org,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v9 1/4] kexec: clean up arch_kexec_kernel_verify_sig
Date:   Mon,  4 Jul 2022 09:51:58 +0800
Message-Id: <20220704015201.59744-2-coxu@redhat.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220704015201.59744-1-coxu@redhat.com>
References: <20220704015201.59744-1-coxu@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Currently there is no arch-specific implementation of
arch_kexec_kernel_verify_sig. Even if we want to add an implementation
for an architecture in the future, we can simply use "(struct
kexec_file_ops*)->verify_sig". So clean it up.

Note this patch is dependent by later patches so it should backported to
the stable tree as well.

Cc: stable@vger.kernel.org
Suggested-by: Eric W. Biederman <ebiederm@xmission.com>
Reviewed-by: Michal Suchanek <msuchanek@suse.de>
Acked-by: Baoquan He <bhe@redhat.com>
Signed-off-by: Coiby Xu <coxu@redhat.com>
---
 include/linux/kexec.h |  4 ----
 kernel/kexec_file.c   | 34 +++++++++++++---------------------
 2 files changed, 13 insertions(+), 25 deletions(-)

diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index ce6536f1d269..e3125fae1599 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -194,10 +194,6 @@ int arch_kexec_kernel_image_probe(struct kimage *image, void *buf,
 				  unsigned long buf_len);
 void *arch_kexec_kernel_image_load(struct kimage *image);
 int arch_kimage_file_post_load_cleanup(struct kimage *image);
-#ifdef CONFIG_KEXEC_SIG
-int arch_kexec_kernel_verify_sig(struct kimage *image, void *buf,
-				 unsigned long buf_len);
-#endif
 int arch_kexec_locate_mem_hole(struct kexec_buf *kbuf);
 
 extern int kexec_add_buffer(struct kexec_buf *kbuf);
diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index 145321a5e798..c7cbadc754a1 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -89,25 +89,6 @@ int __weak arch_kimage_file_post_load_cleanup(struct kimage *image)
 	return kexec_image_post_load_cleanup_default(image);
 }
 
-#ifdef CONFIG_KEXEC_SIG
-static int kexec_image_verify_sig_default(struct kimage *image, void *buf,
-					  unsigned long buf_len)
-{
-	if (!image->fops || !image->fops->verify_sig) {
-		pr_debug("kernel loader does not support signature verification.\n");
-		return -EKEYREJECTED;
-	}
-
-	return image->fops->verify_sig(buf, buf_len);
-}
-
-int __weak arch_kexec_kernel_verify_sig(struct kimage *image, void *buf,
-					unsigned long buf_len)
-{
-	return kexec_image_verify_sig_default(image, buf, buf_len);
-}
-#endif
-
 /*
  * Free up memory used by kernel, initrd, and command line. This is temporary
  * memory allocation which is not needed any more after these buffers have
@@ -150,13 +131,24 @@ void kimage_file_post_load_cleanup(struct kimage *image)
 }
 
 #ifdef CONFIG_KEXEC_SIG
+static int kexec_image_verify_sig(struct kimage *image, void *buf,
+		unsigned long buf_len)
+{
+	if (!image->fops || !image->fops->verify_sig) {
+		pr_debug("kernel loader does not support signature verification.\n");
+		return -EKEYREJECTED;
+	}
+
+	return image->fops->verify_sig(buf, buf_len);
+}
+
 static int
 kimage_validate_signature(struct kimage *image)
 {
 	int ret;
 
-	ret = arch_kexec_kernel_verify_sig(image, image->kernel_buf,
-					   image->kernel_buf_len);
+	ret = kexec_image_verify_sig(image, image->kernel_buf,
+				     image->kernel_buf_len);
 	if (ret) {
 
 		if (IS_ENABLED(CONFIG_KEXEC_SIG_FORCE)) {
-- 
2.35.3

