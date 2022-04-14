Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A0C7500CCE
	for <lists+linux-integrity@lfdr.de>; Thu, 14 Apr 2022 14:09:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233679AbiDNMLp (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 14 Apr 2022 08:11:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234983AbiDNMLo (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 14 Apr 2022 08:11:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F806235;
        Thu, 14 Apr 2022 05:09:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AF49261ED4;
        Thu, 14 Apr 2022 12:09:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF515C385A5;
        Thu, 14 Apr 2022 12:09:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649938158;
        bh=atwHJ0bkDcsxVJbvk7ZP9VTCd4SVdFw7iPP+brue9GA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ekW7QBqSklp8hyBM2vYcpQUCWFVmmwoskDqYMjN4BqpZt7Yj+7jNHRGraHvUd67nD
         +L/VTyENwrd3WKXwym71Ge6nHjADagU7+YNSmwGMeC+iVVt7kwPE5tHX6UMwB1PAFM
         QCzNRxrxmhMRmhlqIuda5PmtndVPtf+oeNx5iNYUtZM+mwi/iERHxb4X721JXMiX5v
         X1e3V6Go/NGdM/iVvYcojgc+ZO+ZP5dU57RaS3mC7CZO+QIuxEj7GoTBpplfimpIcJ
         sNcYU4VOZxSh3AFR1BvtT5roR0BNjksyKR+21JtrkapryMB5v/VuUxyAZjUSiNfaTM
         aqH/9HkOCgv6A==
Date:   Thu, 14 Apr 2022 15:08:10 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     "Jes B. Klinke" <jbk@chromium.org>,
        linux-integrity@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>,
        Peter Huewe <peterhuewe@gmx.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tpm: cr50: Add new device/vendor ID 0x504a6666
Message-ID: <YlgOqpe85pe3P/JP@kernel.org>
References: <20220405173741.4023216-1-jbk@chromium.org>
 <6528eec1-0ab1-a5ff-3e30-2e06256dfd04@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6528eec1-0ab1-a5ff-3e30-2e06256dfd04@molgen.mpg.de>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Apr 07, 2022 at 12:21:44PM +0200, Paul Menzel wrote:
> Dear Jes,
> 
> 
> Thank you for your patch.
> 
> Am 05.04.22 um 19:37 schrieb Jes B. Klinke:
> > Accept one additional numerical value of DID:VID for next generation
> > Google TPM, to be used in future Chromebooks.
> 
> Maybe extend:
> 
> … Google TPM with new firmware …
> 
> The TPM with the new firmware has the code name TI50, and going to use the
> same interfaces.
> 
> > This patch touches more lines than may seem necessary, as a result of
> > the need to move the error case to sit after the two recognized cases.
> > 
> > Signed-off-by: Jes B. Klinke <jbk@chromium.org>
> > ---
> > 
> >   drivers/char/tpm/tpm_tis_i2c_cr50.c | 21 +++++++++++++--------
> >   1 file changed, 13 insertions(+), 8 deletions(-)
> > 
> > diff --git a/drivers/char/tpm/tpm_tis_i2c_cr50.c b/drivers/char/tpm/tpm_tis_i2c_cr50.c
> > index f6c0affbb4567..bf54ebd6724b0 100644
> > --- a/drivers/char/tpm/tpm_tis_i2c_cr50.c
> > +++ b/drivers/char/tpm/tpm_tis_i2c_cr50.c
> > @@ -31,6 +31,7 @@
> >   #define TPM_CR50_TIMEOUT_SHORT_MS	2		/* Short timeout during transactions */
> >   #define TPM_CR50_TIMEOUT_NOIRQ_MS	20		/* Timeout for TPM ready without IRQ */
> >   #define TPM_CR50_I2C_DID_VID		0x00281ae0L	/* Device and vendor ID reg value */
> > +#define TPM_TI50_I2C_DID_VID		0x504a6666L	/* Device and vendor ID reg value */
> >   #define TPM_CR50_I2C_MAX_RETRIES	3		/* Max retries due to I2C errors */
> >   #define TPM_CR50_I2C_RETRY_DELAY_LO	55		/* Min usecs between retries on I2C */
> >   #define TPM_CR50_I2C_RETRY_DELAY_HI	65		/* Max usecs between retries on I2C */
> > @@ -742,16 +743,20 @@ static int tpm_cr50_i2c_probe(struct i2c_client *client)
> >   	}
> >   	vendor = le32_to_cpup((__le32 *)buf);
> > -	if (vendor != TPM_CR50_I2C_DID_VID) {
> > -		dev_err(dev, "Vendor ID did not match! ID was %08x\n", vendor);
> > -		tpm_cr50_release_locality(chip, true);
> > -		return -ENODEV;
> > +	if (vendor == TPM_CR50_I2C_DID_VID) {
> > +		dev_info(dev, "cr50 TPM 2.0 (i2c 0x%02x irq %d id 0x%x)\n",
> > +			 client->addr, client->irq, vendor >> 16);
> > +		return tpm_chip_register(chip);
> > +	}
> > +	if (vendor == TPM_TI50_I2C_DID_VID) {
> > +		dev_info(dev, "ti50 TPM 2.0 (i2c 0x%02x irq %d id 0x%x)\n",
> > +			 client->addr, client->irq, vendor >> 16);
> > +		return tpm_chip_register(chip);
> >   	}
> 
> Both branches are quite similar. Can a ternary operator be used?
> 
>     dev_info(dev, "%s TPM 2.0 (i2c 0x%02x irq %d id 0x%x)\n",
>     	 (vendor == TPM_CR50_I2C_DID_VID) ? "cr50" : "ti50", client->addr,
> client->irq, vendor >> 16);
>     return tpm_chip_register(chip);
> 
> and the original flow be left? (A separate variable can also be added.)
> 
> > -	dev_info(dev, "cr50 TPM 2.0 (i2c 0x%02x irq %d id 0x%x)\n",
> > -		 client->addr, client->irq, vendor >> 16);
> > -
> > -	return tpm_chip_register(chip);
> > +	dev_err(dev, "Vendor ID did not match! ID was %08x\n", vendor);
> > +	tpm_cr50_release_locality(chip, true);
> > +	return -ENODEV;
> >   }
> >   /**
> 
> 
> Kind regards,
> 
> Paul

OK, these are legit suggestions. Paul, can you do these changes and add my
reviewed-by for the +1 version?

BR, Jarkko
