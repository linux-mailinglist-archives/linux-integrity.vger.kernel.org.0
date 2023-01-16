Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B514966B76E
	for <lists+linux-integrity@lfdr.de>; Mon, 16 Jan 2023 07:29:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231899AbjAPG3b (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 16 Jan 2023 01:29:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231945AbjAPG3b (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 16 Jan 2023 01:29:31 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 743C772A7
        for <linux-integrity@vger.kernel.org>; Sun, 15 Jan 2023 22:29:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 068D8B80D07
        for <linux-integrity@vger.kernel.org>; Mon, 16 Jan 2023 06:29:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96305C433EF;
        Mon, 16 Jan 2023 06:29:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673850566;
        bh=3fkGLFITT/9ueg40m6oVB478xf95f6lWzXP3mMKVQ+E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=h4DybbaUOBHY/JLGOx7f7b6VOT0RDRxBsKE00g6Oc6R8sw+/TPuirGmi54lC7G08Q
         8BZ4WpYy0yN8LyO4t2wqRIIDT64u/q+4jpOpr5sF3HffsGFiBEkqnTrzLpvyK1I46r
         VopgzrmZm4V1YarWTe02UzLLMpe535+W7VDbyiPIhjJkAdFzOHsoNfbC/pBSwAxND7
         t8XuHdIdF27bgGRsowpyxIUAWL53J1YISokdDdC9L0llpsXat94RunZotEYt0bGKJX
         4FEDVv8pOa/fM0Sft/9sLSrvHdvK1UJIN96Ek/s7sOHjWTdgbjDRlwmvZ1RUMnt6Ei
         R1QkYrfx+B/WA==
Date:   Mon, 16 Jan 2023 08:29:16 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Matthew Garrett <mjg59@srcf.ucam.org>
Cc:     peterhuewe@gmx.de, jgg@ziepe.ca, linux-integrity@vger.kernel.org
Subject: Re: [PATCH V2] tpm_crb: Add support for CRB devices based on Pluton
Message-ID: <Y8TuvGs+lfFJBPcX@kernel.org>
References: <20221231091432.40365-1-mjg59@srcf.ucam.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221231091432.40365-1-mjg59@srcf.ucam.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Sat, Dec 31, 2022 at 01:14:32AM -0800, Matthew Garrett wrote:
> Pluton is an integrated security processor present in some recent Ryzen
> parts. If it's enabled, it presents two devices - an MSFT0101 ACPI device
> that's broadly an implementation of a Command Response Buffer TPM2, and
> an MSFT0200 ACPI device whose functionality I haven't examined in detail
> yet. This patch only attempts to add support for the TPM device.
> 
> There's a few things that need to be handled here. The first is that the
> TPM2 ACPI table uses a previously undefined start method identifier. The
> table format appears to include 16 bytes of startup data, which corresponds
> to one 64-bit address for a start message and one 64-bit address for a
> completion response. The second is that the ACPI tables on the Thinkpad Z13
> I'm testing this on don't define any memory windows in _CRS (or, more
> accurately, there are two empty memory windows). This check doesn't seem
> strictly necessary, so I've skipped that.
> 
> Finally, it seems like chip needs to be explicitly asked to transition into
> ready status on every command. Failing to do this means that if two commands
> are sent in succession without an idle/ready transition in between,
> everything will appear to work fine but the response is simply the original
> command. I'm working without any docs here, so I'm not sure if this is
> actually the required behaviour or if I'm missing something somewhere else,
> but doing this results in the chip working reliably.
> 
> Signed-off-by: Matthew Garrett <mjg59@srcf.ucam.org>

I'm applying this with these minor adjustments:

diff --git a/drivers/char/tpm/tpm_crb.c b/drivers/char/tpm/tpm_crb.c
index 1d7b27d57974..d43a0d7b97a8 100644
--- a/drivers/char/tpm/tpm_crb.c
+++ b/drivers/char/tpm/tpm_crb.c
@@ -181,7 +181,6 @@ static int __crb_go_idle(struct device *dev, struct crb_priv *priv)
        iowrite32(CRB_CTRL_REQ_GO_IDLE, &priv->regs_t->ctrl_req);
 
        rc = crb_try_pluton_doorbell(priv, true);
-
        if (rc)
                return rc;
 
@@ -231,7 +230,6 @@ static int __crb_cmd_ready(struct device *dev, struct crb_priv *priv)
        iowrite32(CRB_CTRL_REQ_CMD_READY, &priv->regs_t->ctrl_req);
 
        rc = crb_try_pluton_doorbell(priv, true);
-
        if (rc)
                return rc;
 
@@ -442,9 +440,7 @@ static int crb_send(struct tpm_chip *chip, u8 *buf, size_t len)
        if (rc)
                return rc;
 
-       rc = crb_try_pluton_doorbell(priv, false);
-
-       return rc;
+       return crb_try_pluton_doorbell(priv, false);
 }

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko
