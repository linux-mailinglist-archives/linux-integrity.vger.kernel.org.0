Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F41A7574F73
	for <lists+linux-integrity@lfdr.de>; Thu, 14 Jul 2022 15:41:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239845AbiGNNlV (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 14 Jul 2022 09:41:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239855AbiGNNlS (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 14 Jul 2022 09:41:18 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 315C461134
        for <linux-integrity@vger.kernel.org>; Thu, 14 Jul 2022 06:41:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657806075;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nYaKoPGAE5GuTNjUTcyk/8OnPeCKT4Q4LTaKkZkFBRE=;
        b=O5dwcZTI5mWOpWSwLYnm1Z5jyiBxXT+9VdrzK2lAjzhq76GDMCwSVnO4X+/Gb13KChbSUC
        g3GQU6oMJsLxCCdw/S0Rg5Zt3fgTW4CH8xcKXD5sZH2ASGPd1p82YvAwUOfN2qyOv8+9aE
        MdTI+lUu8hRaNu1j+eiQzyr0yF7MH8w=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-461-VntgiyF_NfuWTYOSJjbnbw-1; Thu, 14 Jul 2022 09:41:03 -0400
X-MC-Unique: VntgiyF_NfuWTYOSJjbnbw-1
Received: by mail-pf1-f197.google.com with SMTP id b11-20020aa7810b000000b0052aeb125cb3so1231739pfi.11
        for <linux-integrity@vger.kernel.org>; Thu, 14 Jul 2022 06:41:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nYaKoPGAE5GuTNjUTcyk/8OnPeCKT4Q4LTaKkZkFBRE=;
        b=545OH4D49CgIfq9H3pUAHbl6Ye8YCxJMogUYKBX95Jf4gNLMWfoEXHJGGEKKBkqvuf
         wKQ2ld8INFiBPvIjb+SJXot+z/0Qb+xnLLxMnAVWpmYQD5948eKtKLd1fLlEr21jAKXS
         vFHqJ7PrTZ2B/GSAMGii2QW5OeFfGYtlVrLLyjxQPpdLQpXMx310asvghdEoD1olZIwG
         XjedG9YdEMYfuZ/a66plrEAs86RsDR9HmegbGnn5O4COoG3mc+AjCvUxRkGjutiJmGTA
         suEgOz7Ta13ddtepsXJ+uHPFGWrqCGk2m878yU7lBwox/HBvR8kyixbGclylZM4og9aR
         QhGQ==
X-Gm-Message-State: AJIora8DHubKUtyYzH25Bd4aRwRilARoNvbQbEN8JPXzifeE8rve5S1I
        ujXb6/WMTWhTRnlEVYAFLRelx+FT8Ngo0mDXrWDkqkYRIRVt5/B7sBVhX1R3emtmEdueLqDkkE3
        PUAmx8R5UWKDUE6VjVVRQxKN7f5bV
X-Received: by 2002:a17:90b:3c07:b0:1f0:eab4:79e4 with SMTP id pb7-20020a17090b3c0700b001f0eab479e4mr1116953pjb.186.1657806062496;
        Thu, 14 Jul 2022 06:41:02 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1sPB4AJHTz7fd94myeXuSf8getkOgYveQhJicFIsXMd+oF8xCeEgRFuBRRxo5JHCdTOoHv9uw==
X-Received: by 2002:a17:90b:3c07:b0:1f0:eab4:79e4 with SMTP id pb7-20020a17090b3c0700b001f0eab479e4mr1116928pjb.186.1657806062264;
        Thu, 14 Jul 2022 06:41:02 -0700 (PDT)
Received: from localhost ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id j31-20020a63fc1f000000b00419ab8f8d2csm1342551pgi.20.2022.07.14.06.41.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jul 2022 06:41:01 -0700 (PDT)
From:   Coiby Xu <coxu@redhat.com>
To:     kexec@lists.infradead.org, linux-integrity@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        linux-arm-kernel@lists.infradead.org,
        Michal Suchanek <msuchanek@suse.de>,
        Baoquan He <bhe@redhat.com>, Dave Young <dyoung@redhat.com>,
        Will Deacon <will@kernel.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Chun-Yi Lee <jlee@suse.com>, stable@vger.kernel.org,
        keyrings@vger.kernel.org, linux-security-module@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        James Morse <james.morse@arm.com>,
        AKASHI Takahiro <takahiro.akashi@linaro.org>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v10 3/4] arm64: kexec_file: use more system keyrings to verify kernel image signature
Date:   Thu, 14 Jul 2022 21:40:26 +0800
Message-Id: <20220714134027.394370-4-coxu@redhat.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220714134027.394370-1-coxu@redhat.com>
References: <20220714134027.394370-1-coxu@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Currently, when loading a kernel image via the kexec_file_load() system
call, arm64 can only use the .builtin_trusted_keys keyring to verify
a signature whereas x86 can use three more keyrings i.e.
.secondary_trusted_keys, .machine and .platform keyrings. For example,
one resulting problem is kexec'ing a kernel image  would be rejected
with the error "Lockdown: kexec: kexec of unsigned images is restricted;
see man kernel_lockdown.7".

This patch set enables arm64 to make use of the same keyrings as x86 to
verify the signature kexec'ed kernel image.

Fixes: 732b7b93d849 ("arm64: kexec_file: add kernel signature verification support")
Cc: stable@vger.kernel.org # 105e10e2cf1c: kexec_file: drop weak attribute from functions
Cc: stable@vger.kernel.org # 34d5960af253: kexec: clean up arch_kexec_kernel_verify_sig
Cc: stable@vger.kernel.org # 83b7bb2d49ae: kexec, KEYS: make the code in bzImage64_verify_sig generic
Acked-by: Baoquan He <bhe@redhat.com>
Cc: kexec@lists.infradead.org
Cc: keyrings@vger.kernel.org
Cc: linux-security-module@vger.kernel.org
Co-developed-by: Michal Suchanek <msuchanek@suse.de>
Signed-off-by: Michal Suchanek <msuchanek@suse.de>
Acked-by: Will Deacon <will@kernel.org>
Signed-off-by: Coiby Xu <coxu@redhat.com>
---
 arch/arm64/kernel/kexec_image.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/arch/arm64/kernel/kexec_image.c b/arch/arm64/kernel/kexec_image.c
index 9ec34690e255..5ed6a585f21f 100644
--- a/arch/arm64/kernel/kexec_image.c
+++ b/arch/arm64/kernel/kexec_image.c
@@ -14,7 +14,6 @@
 #include <linux/kexec.h>
 #include <linux/pe.h>
 #include <linux/string.h>
-#include <linux/verification.h>
 #include <asm/byteorder.h>
 #include <asm/cpufeature.h>
 #include <asm/image.h>
@@ -130,18 +129,10 @@ static void *image_load(struct kimage *image,
 	return NULL;
 }
 
-#ifdef CONFIG_KEXEC_IMAGE_VERIFY_SIG
-static int image_verify_sig(const char *kernel, unsigned long kernel_len)
-{
-	return verify_pefile_signature(kernel, kernel_len, NULL,
-				       VERIFYING_KEXEC_PE_SIGNATURE);
-}
-#endif
-
 const struct kexec_file_ops kexec_image_ops = {
 	.probe = image_probe,
 	.load = image_load,
 #ifdef CONFIG_KEXEC_IMAGE_VERIFY_SIG
-	.verify_sig = image_verify_sig,
+	.verify_sig = kexec_kernel_verify_pe_sig,
 #endif
 };
-- 
2.35.3

