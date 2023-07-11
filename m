Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAED874E52D
	for <lists+linux-integrity@lfdr.de>; Tue, 11 Jul 2023 05:17:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230161AbjGKDRF (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 10 Jul 2023 23:17:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbjGKDRE (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 10 Jul 2023 23:17:04 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91D1EE56
        for <linux-integrity@vger.kernel.org>; Mon, 10 Jul 2023 20:16:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689045376;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=fXhj7EzANXxG2zR22cPkd+LCDvsMw/4Z29S4c6txddw=;
        b=GbbFDT9pMIGhkhP/CKNTCvEA52857SvX5YaW5PnYE1kbhMtYE/HVSPzY1a5R1SYJVfCTrt
        OieZzDJ4C7dZSbLQhjr7s8SfdAtwAeT9p43UDUOO52lrfOtVOj5XvZJBPMqzx/YE02GRwN
        VVPMp3UsMrhSbP5v7340cfMAMoH1JBM=
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com
 [209.85.161.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-457-MFX3dEytPkSrvV7wP-cO0g-1; Mon, 10 Jul 2023 23:16:15 -0400
X-MC-Unique: MFX3dEytPkSrvV7wP-cO0g-1
Received: by mail-oo1-f71.google.com with SMTP id 006d021491bc7-56662adc40bso4205253eaf.1
        for <linux-integrity@vger.kernel.org>; Mon, 10 Jul 2023 20:16:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689045374; x=1691637374;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fXhj7EzANXxG2zR22cPkd+LCDvsMw/4Z29S4c6txddw=;
        b=d3T8Z4fH/7hqnwqywjA8mzRAyJ25JiiyAi61cN7na3u5sei71vMYa2ON+ve36RuuFs
         nvfO90VOG4PO+Txe6fU9GWLtFF4v83qPonSEoxk1NbHFMYZ4uOKnCmeYflGDMfreR9y5
         AyB/dXTQxcFN8X8uEyPtVgRrkUDjY8zRj164LfcS2lMHVvRVBCKa8cKqG/cLXXIt7tux
         pNBZcEM1utol+muTc9RGcn33Ocp7Ae4D2nLgvrlYeo+2Uq2IO/8nuNBZR1PPO0HOvB8/
         /fElMITUMllaCmaCkmarYl7NdFXpxhqrqiTuRUVJ1bVB0nGAK2THE731+yhH93Efy7lb
         0SYw==
X-Gm-Message-State: ABy/qLZXz6bxPnWI6sKB9NjlH0wHU1Yesk4uUYqqad/vUUBALlEjbc90
        leghZpYeV29ViccwnwJlmfcduoUgdkA9PG9MBuZmf+flGDi3kLOuhCS9pC3TtP3A6gsYndqrQzT
        vAPRIRk+Juc80l6R2nEOXweDoBnNRai5ZoYPYL32L3QR9iyaJ4rR8FCzuXY9qe6ZCdrvg4hGvnJ
        cb6P18NDoTJW0I
X-Received: by 2002:a05:6808:190b:b0:3a3:aedd:6b21 with SMTP id bf11-20020a056808190b00b003a3aedd6b21mr18778778oib.39.1689045374403;
        Mon, 10 Jul 2023 20:16:14 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFxYZvl0B8mwmdXFaSoLskIzmhRC10jfKsKeBAMSMVBzej0sbUxtdM0TFtWtEyJ4k8kWK+yIg==
X-Received: by 2002:a05:6808:190b:b0:3a3:aedd:6b21 with SMTP id bf11-20020a056808190b00b003a3aedd6b21mr18778752oib.39.1689045373985;
        Mon, 10 Jul 2023 20:16:13 -0700 (PDT)
Received: from localhost ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id s4-20020aa78284000000b0066883d75932sm488806pfm.204.2023.07.10.20.16.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jul 2023 20:16:13 -0700 (PDT)
From:   Coiby Xu <coxu@redhat.com>
To:     linux-integrity@vger.kernel.org
Cc:     Eric Biederman <ebiederm@xmission.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        kexec@lists.infradead.org (open list:KEXEC),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] kexec_file: ima: allow loading a kernel with its IMA signature verified
Date:   Tue, 11 Jul 2023 11:16:03 +0800
Message-ID: <20230711031604.717124-1-coxu@redhat.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

When IMA has verified the signature of the kernel image, kexec'ing this
kernel should be allowed.

Fixes: af16df54b89d ("ima: force signature verification when CONFIG_KEXEC_SIG is configured")
Signed-off-by: Coiby Xu <coxu@redhat.com>
---
 kernel/kexec_file.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index 881ba0d1714c..96fce001fbc0 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -162,6 +162,13 @@ kimage_validate_signature(struct kimage *image)
 	ret = kexec_image_verify_sig(image, image->kernel_buf,
 				     image->kernel_buf_len);
 	if (ret) {
+		/*
+		 * If the kernel image already has its IMA signature verified, permit it.
+		 */
+		if (ima_appraise_signature(READING_KEXEC_IMAGE)) {
+			pr_notice("The kernel image already has its IMA signature verified.\n");
+			return 0;
+		}
 
 		if (sig_enforce) {
 			pr_notice("Enforced kernel signature verification failed (%d).\n", ret);
@@ -169,12 +176,9 @@ kimage_validate_signature(struct kimage *image)
 		}
 
 		/*
-		 * If IMA is guaranteed to appraise a signature on the kexec
-		 * image, permit it even if the kernel is otherwise locked
-		 * down.
+		 * When both IMA and KEXEC_SIG fail in lockdown mode, reject it.
 		 */
-		if (!ima_appraise_signature(READING_KEXEC_IMAGE) &&
-		    security_locked_down(LOCKDOWN_KEXEC))
+		if (security_locked_down(LOCKDOWN_KEXEC))
 			return -EPERM;
 
 		pr_debug("kernel signature verification failed (%d).\n", ret);
-- 
2.41.0

