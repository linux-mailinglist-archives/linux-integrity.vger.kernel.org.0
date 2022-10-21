Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D871B6076EF
	for <lists+linux-integrity@lfdr.de>; Fri, 21 Oct 2022 14:33:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229588AbiJUMdT (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 21 Oct 2022 08:33:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbiJUMdS (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 21 Oct 2022 08:33:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 498992608FE
        for <linux-integrity@vger.kernel.org>; Fri, 21 Oct 2022 05:33:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DA56B61E5D
        for <linux-integrity@vger.kernel.org>; Fri, 21 Oct 2022 12:33:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C78C4C433C1;
        Fri, 21 Oct 2022 12:33:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666355596;
        bh=BoSpSYE04FMaRQCRT9lnm8ruur3Cb35hyybiNhg2XGo=;
        h=From:To:Cc:Subject:Date:From;
        b=dhyX5rEygH6mBxNN5r3RUPHFgjQ6tEcoo73UVSm0oOzNwoGR/6E4MgkCLwtf5N7DH
         zv58o3d6MrsRiOcri81k/sDGrGQCUYpbpny/vugTZqvPAc2mBVpeyW7r9NLuCwjde1
         RNZx+/jzWFPncKvEiEJsSzhBr8lWUhslfumnQ12lyPNSwjF6tXpI4UhGLql4w4aF48
         joRZmHkIbQ1i+yYBA6usWVbqXd3U8Lj5CAsUAcbqfzcjfiD/x4TnOJIA0YtvKYo4Xx
         H7tNqcuCCxOrtNu3URsD+3xJBpB09k+dvTDzsxNSjfAXWPPgZI3NQngMFRh/TaPhc0
         OprJo3+t8lC7g==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     peterhuewe@gmx.de
Cc:     jarkko@kernel.org, linux-integrity@vger.kernel.org, jgg@ziepe.ca,
        keescook@chromium.org, samitolvanen@google.com,
        Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH] tpm: Avoid function type cast of put_device()
Date:   Fri, 21 Oct 2022 14:33:09 +0200
Message-Id: <20221021123309.2770740-1-ardb@kernel.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3006; i=ardb@kernel.org; h=from:subject; bh=BoSpSYE04FMaRQCRT9lnm8ruur3Cb35hyybiNhg2XGo=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBjUpGEevhM/EcaKgAYgcl9WbvbbiuXda1yCgI1zaiE ZkYMmdKJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCY1KRhAAKCRDDTyI5ktmPJOQrC/ 9eiuLERJnJU/IqNUKYfsN+ekuv4Pn73DVNwTUM1ubC1QLIns99soqm0uIcJ777io6IZEZ+0g+HtX4E kiX5eCELG36Qlu83SLSYMqKEuTvbanVAYzWWcSNpskNqWZRZ1c0hft9QLfbkQ9sbiRcuIAhGGFgQSU 8HdtWx0WiWoE7wMJJvOi18l4y1Kd4jKECnWuQGmp9M67JsVuPXBm/Cs9pUjITgu3HpVfYzPSqzmYrR 0xVz9L5XcMPiIbngRJIVDwh/1RcI8YWPMMcFktVxP76GuR1dkDdk0B3h0ixIaqPdQ/YKSyBJh6Bwzw jecgqmaH4XjiOyUBpD2pvf1ZeGzIVl3SwwwcJXOOKBltJB0/Lp49QM95hG9GT+lWnMgt6fkMsnPXKR 7hbqlKBimgmGkuQFjziROU2DnSeTXH3jGnU2zXVQH2Emsv+bL/y46YunSXw8Zid4F85gaROGZRlPl1 RsujaEyBbdz0Qf8SrIMoujjp8lrwdSEVFkWiLARsw7vf0=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

The TPM code registers put_device() as a devm cleanup handler, and casts
the reference to the right function pointer type for this to be
permitted by the compiler.

However, under kCFI, this is rejected at runtime, resulting in a splat
like

   CFI failure at devm_action_release+0x24/0x3c (target: put_device+0x0/0x24; expected type: 0xa488ebfc)
   Internal error: Oops - CFI: 0000000000000000 [#1] PREEMPT SMP
   Modules linked in:  ...
   CPU: 20 PID: 454 Comm: systemd-udevd Not tainted 6.1.0-rc1+ #51
   Hardware name: Socionext SynQuacer E-series DeveloperBox, BIOS build #1 Oct  3 2022
   pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
   pc : devm_action_release+0x24/0x3c
   lr : devres_release_all+0xb4/0x114
   sp : ffff800009bb3630
   x29: ffff800009bb3630 x28: 0000000000000000 x27: 0000000000000011
   x26: ffffaa6f9922c0c8 x25: 0000000000000002 x24: 000000000000000f
   x23: ffff800009bb3648 x22: ffff7aefc3be2100 x21: ffff7aefc3be2e00
   x20: 0000000000000005 x19: ffff7aefc1e1ec10 x18: ffff800009af70a8
   x17: 00000000a488ebfc x16: 0000000094ee7df3 x15: 0000000000000000
   x14: 4075c5c2ef7affff x13: e46a91c5c5e2ef42 x12: ffff7aefc2c57540
   x11: 0000000000000001 x10: 0000000000000001 x9 : 0000000100000000
   x8 : ffffaa6fa09b39b4 x7 : 7f7f7f7f7f7f7f7f x6 : 8000000000000000
   x5 : 000000008020000e x4 : ffff7aefc2c57500 x3 : ffff800009bb3648
   x2 : ffff800009bb3648 x1 : ffff7aefc3be2e80 x0 : ffff7aefc3bb7000
   Call trace:
    devm_action_release+0x24/0x3c
    devres_release_all+0xb4/0x114
    really_probe+0xb0/0x49c
    __driver_probe_device+0x114/0x180
    driver_probe_device+0x48/0x1ec
    __driver_attach+0x118/0x284
    bus_for_each_dev+0x94/0xe4
    driver_attach+0x24/0x34
    bus_add_driver+0x10c/0x220
    driver_register+0x78/0x118
    __platform_driver_register+0x24/0x34
    init_module+0x20/0xfe4 [tpm_tis_synquacer]
    do_one_initcall+0xd4/0x248
    do_init_module+0x44/0x28c
    load_module+0x16b4/0x1920

Fix this by going through a helper function of the correct type.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/char/tpm/tpm-chip.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
index 783d65fc71f0..741d8f3e8fb3 100644
--- a/drivers/char/tpm/tpm-chip.c
+++ b/drivers/char/tpm/tpm-chip.c
@@ -373,6 +373,11 @@ struct tpm_chip *tpm_chip_alloc(struct device *pdev,
 }
 EXPORT_SYMBOL_GPL(tpm_chip_alloc);
 
+static void tpm_put_device(void *dev)
+{
+	put_device(dev);
+}
+
 /**
  * tpmm_chip_alloc() - allocate a new struct tpm_chip instance
  * @pdev: parent device to which the chip is associated
@@ -391,7 +396,7 @@ struct tpm_chip *tpmm_chip_alloc(struct device *pdev,
 		return chip;
 
 	rc = devm_add_action_or_reset(pdev,
-				      (void (*)(void *)) put_device,
+				      tpm_put_device,
 				      &chip->dev);
 	if (rc)
 		return ERR_PTR(rc);
-- 
2.35.1

