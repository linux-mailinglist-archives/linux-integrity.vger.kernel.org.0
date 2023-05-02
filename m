Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF6816F3BBF
	for <lists+linux-integrity@lfdr.de>; Tue,  2 May 2023 03:16:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233380AbjEBBQO (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 1 May 2023 21:16:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233368AbjEBBQN (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 1 May 2023 21:16:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 400243AAB;
        Mon,  1 May 2023 18:16:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6AF1461BCB;
        Tue,  2 May 2023 01:16:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A88AC433EF;
        Tue,  2 May 2023 01:16:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682990170;
        bh=eXbsWUEm5rfH7tVRp1FkbSx71ul691d63mXN77lfDz0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tnImXpIiGPwCS/61hLJyR6mv9N2a6EsMlKFONkoymo3eF1AaqQduOEUH6qFr4B4PJ
         Mmkoxc5/qGkbVyGYX3/b1RAVxpfta6Gk9mNyhV11uswntuML03E6kzPU+OzPmBgwWz
         LwJbFDoWbRyd4MANlemsvKMKgw+ikximDAM5T5oIntgT/0pPllejl0ZKctL/C/ENtn
         laJINLPrVvo4HekZBfUpM7zF8lgcVuB5Rdvz5Z/HaUGY/hqi+3TaIRE4/SQKZkrY1K
         qxRp2noTUaMcyfAVZuqfALNuq+P77qXiDNupX20WnQ2qLC4zwM5SXkR7w2eGXjaWy+
         n3+MNrpbu2S/A==
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jarkko Sakkinen <jarkko@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Jason A . Donenfeld" <Jason@zx2c4.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Jerry Snitselaar <jsnitsel@redhat.com>, stable@vger.kernel.org
Subject: [PATCH v2 1/2] tpm_tis: Use tpm_chip_{start,stop} decoration inside tpm_tis_resume
Date:   Tue,  2 May 2023 04:15:57 +0300
Message-Id: <20230502011558.10743-2-jarkko@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230502011558.10743-1-jarkko@kernel.org>
References: <20230502011558.10743-1-jarkko@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Before sending a TPM command, CLKRUN protocol must be disabled. This is not
done in the case of tpm1_do_selftest() call site inside tpm_tis_resume().

Address this by decorating the calls with tpm_chip_{start,stop}, which
should be always used to arm and disarm the TPM chip for transmission.

Finally, move the call to the main TPM driver callback as the last step
because it should arm the chip by itself, if it needs that type of
functionality.

Cc: stable@vger.kernel.org
Reported-by: Jason A. Donenfeld <Jason@zx2c4.com>
Closes: https://lore.kernel.org/linux-integrity/CS68AWILHXS4.3M36M1EKZLUMS@suppilovahvero/
Fixes: a3fbfae82b4c ("tpm: take TPM chip power gating out of tpm_transmit()")
Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
---
 drivers/char/tpm/tpm_tis_core.c | 43 +++++++++++++++------------------
 1 file changed, 19 insertions(+), 24 deletions(-)

diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
index 02945d53fcef..558144fa707a 100644
--- a/drivers/char/tpm/tpm_tis_core.c
+++ b/drivers/char/tpm/tpm_tis_core.c
@@ -1209,25 +1209,20 @@ static void tpm_tis_reenable_interrupts(struct tpm_chip *chip)
 	u32 intmask;
 	int rc;
 
-	if (chip->ops->clk_enable != NULL)
-		chip->ops->clk_enable(chip, true);
-
-	/* reenable interrupts that device may have lost or
-	 * BIOS/firmware may have disabled
+	/*
+	 * Re-enable interrupts that device may have lost or BIOS/firmware may
+	 * have disabled.
 	 */
 	rc = tpm_tis_write8(priv, TPM_INT_VECTOR(priv->locality), priv->irq);
-	if (rc < 0)
-		goto out;
+	if (rc < 0) {
+		dev_err(&chip->dev, "Setting IRQ failed.\n");
+		return;
+	}
 
 	intmask = priv->int_mask | TPM_GLOBAL_INT_ENABLE;
-
-	tpm_tis_write32(priv, TPM_INT_ENABLE(priv->locality), intmask);
-
-out:
-	if (chip->ops->clk_enable != NULL)
-		chip->ops->clk_enable(chip, false);
-
-	return;
+	rc = tpm_tis_write32(priv, TPM_INT_ENABLE(priv->locality), intmask);
+	if (rc < 0)
+		dev_err(&chip->dev, "Enabling interrupts failed.\n");
 }
 
 int tpm_tis_resume(struct device *dev)
@@ -1235,27 +1230,27 @@ int tpm_tis_resume(struct device *dev)
 	struct tpm_chip *chip = dev_get_drvdata(dev);
 	int ret;
 
-	ret = tpm_tis_request_locality(chip, 0);
-	if (ret < 0)
+	ret = tpm_chip_start(chip);
+	if (ret)
 		return ret;
 
 	if (chip->flags & TPM_CHIP_FLAG_IRQ)
 		tpm_tis_reenable_interrupts(chip);
 
-	ret = tpm_pm_resume(dev);
-	if (ret)
-		goto out;
-
 	/*
 	 * TPM 1.2 requires self-test on resume. This function actually returns
 	 * an error code but for unknown reason it isn't handled.
 	 */
 	if (!(chip->flags & TPM_CHIP_FLAG_TPM2))
 		tpm1_do_selftest(chip);
-out:
-	tpm_tis_relinquish_locality(chip, 0);
 
-	return ret;
+	tpm_chip_stop(chip);
+
+	ret = tpm_pm_resume(dev);
+	if (ret)
+		return ret;
+
+	return 0;
 }
 EXPORT_SYMBOL_GPL(tpm_tis_resume);
 #endif
-- 
2.39.2

