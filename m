Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E52E8541017
	for <lists+linux-integrity@lfdr.de>; Tue,  7 Jun 2022 21:18:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350973AbiFGTSR (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 7 Jun 2022 15:18:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355942AbiFGTRr (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 7 Jun 2022 15:17:47 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62A2B47573;
        Tue,  7 Jun 2022 11:08:00 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id k4so6619139qth.8;
        Tue, 07 Jun 2022 11:08:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:subject:from:to:cc:date:content-transfer-encoding
         :user-agent:mime-version;
        bh=vKR0cSCCmBP1D6WayZKCpy0s8vY4JyUCRmxpMEIEI00=;
        b=b43JnklWo4Oo+Ct6vD+finWX5yg0ZTzlGB3tAqvpQBEN5+5lF76sCKFf5G+mY/pJIw
         nCKEc50oVMqiE9thfMJNkhAlehCWR53Vpr+wxD7IByxnF3vCMuschCy5vCeQnCkabUz4
         WHsSb1NkZfxOtojGkN/X+/khJ64QiFkhttT7XFJyauvugNwEaU6kv/kt2wLbiXM63W+A
         oLe8sw+/D3tbC7+KidjG9MR4LuQZza2J8Pu6oMGOYKvKFsvOr3G+vRQ+0ihkC4YwDEEh
         nWusMgflFqnXuTHk9zMR5gm8u6xVViF9U5k5AkIt4pxgjkzPQ2iXUWRxi5uOeo7gnHoU
         e7Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date
         :content-transfer-encoding:user-agent:mime-version;
        bh=vKR0cSCCmBP1D6WayZKCpy0s8vY4JyUCRmxpMEIEI00=;
        b=rjUntFnaMvM4JxT5GM0wrCcxxUp+O/sCENe2bvUJSOAqtgUa5acjgbQgM7OHnXb0UP
         KPF7AmoeOtiyy+1D/DuGGyw8lkTtnCybKcUuSRhrncnS38WFfXdAzWrHcYNXulndiYar
         nPdILMAJjpNtMzrh2v1YYdCjIlq2snS0kZLYEvJ00OSd9ZlDDYWfOUWI58OaNIY3Nzo1
         Wn+DaLhuEMM2DIA8r5DI+7hHYg4tzoEOJ0EVJJ/esL+yARqodDX3m5tgogv4t7ZYohQh
         XBzoIyyMTdAEc3oHsL1rY7VlXPeNa8JzaOx2r/dr7FlBHWcwtt9GrLLmtSrvL3zvyqmt
         QI6A==
X-Gm-Message-State: AOAM530YXlhFNCYBB4Ws/QxchlPZJpLUjiYL+EjEjEzmTU4aJ5Ae6+CM
        GSTvMv1S9NmL2/ZssOd89ls/G8cmXztCnGwu
X-Google-Smtp-Source: ABdhPJxwNUOzz15qQgSmRRrdY9Lo6MJZ75+8upjPT/tj2PHco4Ec/gQKRUfX9z1FJ1D8jEVjy9TZlw==
X-Received: by 2002:a05:622a:1905:b0:304:fdb6:a8b6 with SMTP id w5-20020a05622a190500b00304fdb6a8b6mr2618191qtc.645.1654625278378;
        Tue, 07 Jun 2022 11:07:58 -0700 (PDT)
Received: from localhost.localdomain (pool-96-250-49-75.nycmny.fios.verizon.net. [96.250.49.75])
        by smtp.gmail.com with ESMTPSA id e2-20020ac80642000000b002f905347586sm11833999qth.14.2022.06.07.11.07.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jun 2022 11:07:57 -0700 (PDT)
Message-ID: <141492344ae13c9842626e696685316ee340d717.camel@gmail.com>
Subject: [PATCH v2] KEYS: trusted: tpm2: Fix migratable logic
From:   david.safford@gmail.com
To:     Jarkko Sakkinen <jarkko@kernel.org>,
        Ahmad Fatoum <a.fatoum@pengutronix.de>,
        James Bottomley <jejb@linux.ibm.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        David Howells <dhowells@redhat.com>,
        James Morris <jmorris@namei.org>,
        "SergeE.Hallyn" <serge@hallyn.com>
Cc:     linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 07 Jun 2022 14:07:57 -0400
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
trusted keys have the FIXED_TPM and FIXED_PARENT attributes
set, and non-migratable keys don't. This is backwards, and
also causes creation to fail when creating a migratable key
under a migratable parent. (The TPM thinks you are trying to
seal a non-migratable blob under a migratable parent.)

The following simple patch fixes the logic, and has been
tested for all four combinations of migratable and non-migratable
trusted keys and parent storage keys. With this logic, you will
get a proper failure if you try to create a non-migratable
trusted key under a migratable parent storage key, and all other
combinations work correctly.

Fixes: e5fb5d2c5a03 ("security: keys: trusted: Make sealed key properly int=
eroperable")
Signed-off-by: David Safford <david.safford@gmail.com>
---
Changelog:
 * v2:
   * added Signed-off-by, Fixes, proper Subject and distribution
.
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

 	/* policy */
--
2.36.1
