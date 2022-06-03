Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1709553CAAD
	for <lists+linux-integrity@lfdr.de>; Fri,  3 Jun 2022 15:29:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244631AbiFCN3A (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 3 Jun 2022 09:29:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238620AbiFCN27 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 3 Jun 2022 09:28:59 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AB9A25EB2
        for <linux-integrity@vger.kernel.org>; Fri,  3 Jun 2022 06:28:59 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id x7so5499309qta.6
        for <linux-integrity@vger.kernel.org>; Fri, 03 Jun 2022 06:28:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:subject:from:to:cc:date:content-transfer-encoding
         :user-agent:mime-version;
        bh=gioCFJFyfX3Y+KuZpA0N/9893mHiQmos9qji8S38pcw=;
        b=CzSmJL7F1oGlPk2HNEDOpIUDJx5aU1NUwI7mDymrwcXeh/ArS38FL6a+C+vSZsJn9c
         Qq5k71uzFIaEZJwJulriNpmAObRQkJSK3Z/SNBc8RFl89Pr2M9Vv++VZ4RLIXjRiz3aY
         iKZkWOkbfKia0fwIRyEhEBY6j9TNvvUiPRy8Yohiao2ETTM2IEcPjq1pephijT36Wdsz
         VSUIFkpd39NU3Vb6L7/9bHqzhxfXo5nXnbZKWCzvpt/9ro4akbZoogpnVSzS17LID6R0
         nf/EZzB75K07d/6iyRw5EXLUNvPxp0Mu8SVswiPCEa/3chf+bmfY/HihEyG5OCnMfiMY
         eIbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date
         :content-transfer-encoding:user-agent:mime-version;
        bh=gioCFJFyfX3Y+KuZpA0N/9893mHiQmos9qji8S38pcw=;
        b=BiSVflQQ39OQcIIY4vr0B29jsC+4k2IOn54QJvrc8Uc6YzR5RaHVRgd07BqdL2I3GM
         g+7ePmEOFDhsX50B53jhdy8ET8lADvG7tyutLZZv5RLopCCmyEBLVLWTr70hZDi9KCKV
         fGL7v8/5ZUvFAzTfbXtkIMf6eU6raW7QRwRrWteqiptCdntR8SNkeWLaGpJKygI6ErLA
         4lLMmmg4jmAlJOFvUR61IqhjpUs3hRPQwGFu14O4lcc6t3xUdRvrJZiXWcrkFVl6L+R1
         cuWd2S+jD4hjA0w4yk9/ffEmcRpnKQxUsvllE3qbllue+keXcv/OZkOvDTyIjWcSyBCt
         o5DQ==
X-Gm-Message-State: AOAM5314qbbqAHJnzkFvhTcvEj60u72WRKB1OegBZ1GUF3z+GcboMKLU
        UvDj9t9/i5KovMvDaImvKoPawASA7KI5NGTz
X-Google-Smtp-Source: ABdhPJxz7xvkrDFOTZyrwuTNtnmYjTfB5XZbSjpZiQ09wmq57er8drs6kuH3WpfDb1iUF625wxWOMA==
X-Received: by 2002:a05:622a:246:b0:2f3:d514:7ac with SMTP id c6-20020a05622a024600b002f3d51407acmr7354692qtx.688.1654262937883;
        Fri, 03 Jun 2022 06:28:57 -0700 (PDT)
Received: from localhost.localdomain (pool-96-250-49-75.nycmny.fios.verizon.net. [96.250.49.75])
        by smtp.gmail.com with ESMTPSA id az35-20020a05620a172300b006a68867a243sm2526718qkb.90.2022.06.03.06.28.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jun 2022 06:28:57 -0700 (PDT)
Message-ID: <874177b3b34b10679829dbf011e5bde7f37a4c9c.camel@gmail.com>
Subject: [PATCH] trusted-keys-fix-migratable-logic
From:   david.safford@gmail.com
To:     linux-integrity@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        James Bottomley <jejb@linux.ibm.com>
Date:   Fri, 03 Jun 2022 09:28:56 -0400
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.1 (3.44.1-1.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

When creating (sealing) a new trusted key, migratable
trusted keys have the FIXED_TPM and FIXED_PERM attributes
set, and non-migratable keys don't. This is backwards, and
also causes creation to fail when creating a migratable key
under a migratable parent. (The TPM thinks you are trying to
seal a non-migratable blob under a migratable parent.)

The following simple patch fixes the logic, and has been
tested for all four combinations of migratable and non-migratable
trusted keys and parent storage keys. With this logic, you will
get a proper failure if you try to create a non-migratable=20
trusted key under a migratable parent storage key, and all other
combinations work correctly.

david safford
---
 security/keys/trusted-keys/trusted_tpm2.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/security/keys/trusted-keys/trusted_tpm2.c b/security/keys/trus=
ted-keys/trusted_tpm2.c
index 0165da386289..2b2c8eb258d5 100644
--- a/security/keys/trusted-keys/trusted_tpm2.c
+++ b/security/keys/trusted-keys/trusted_tpm2.c
@@ -283,8 +283,8 @@ int tpm2_seal_trusted(struct tpm_chip *chip,
 	/* key properties */
 	flags =3D 0;
 	flags |=3D options->policydigest_len ? 0 : TPM2_OA_USER_WITH_AUTH;
-	flags |=3D payload->migratable ? (TPM2_OA_FIXED_TPM |
-					TPM2_OA_FIXED_PARENT) : 0;
+	flags |=3D payload->migratable ? 0 : (TPM2_OA_FIXED_TPM |
+					    TPM2_OA_FIXED_PARENT);
 	tpm_buf_append_u32(&buf, flags);
=20
 	/* policy */
--=20
2.36.1
