Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C023A38852D
	for <lists+linux-integrity@lfdr.de>; Wed, 19 May 2021 05:18:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237841AbhESDTu (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 18 May 2021 23:19:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:54176 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237833AbhESDTu (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 18 May 2021 23:19:50 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3F3BD61007;
        Wed, 19 May 2021 03:18:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621394311;
        bh=xjjUV3S1WoEiCRvObT5OzB+1MJD+iYItuOkfSorQlEA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cipMk0k7vOY/6Z/Zfpss861Xcojkxp6hvT4j91VKMah2z5tCqlgyAAEYEDUjY7qA/
         A0EYgRGqlMlxLH3B9MHaivwrGboVYirHIhobiRQEKmSTy4pOHlKDcMsNY7EFOjNTP3
         KTrMXJpbV25IrBFPJ5++b32zothZ2JAtqoSH8X0s22HTNGH+mVOwFa8hGZWuj8KGmx
         NIwLsqjAlbJqy/4YghVUknNHelq6dh3Rj1tQiOttT1EpAi/FH/tvrpUC1vsIF06o/I
         yW21UdMcYm/vLFc7ZBFWk9dH9+PYF69ShdSX89me6FXsACcs69AP11fRsx/OcLt40K
         9nJmUYniNXAkg==
Date:   Wed, 19 May 2021 06:18:29 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Tian Tao <tiantao6@hisilicon.com>
Cc:     peterhuewe@gmx.de, linux-integrity@vger.kernel.org
Subject: Re: [RESEND PATCH v2 1/1] char: tpm: move to use request_irq by
 IRQF_NO_AUTOEN flag
Message-ID: <YKSDhZ0nm8FAS4u7@kernel.org>
References: <1621214324-55965-1-git-send-email-tiantao6@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1621214324-55965-1-git-send-email-tiantao6@hisilicon.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, May 17, 2021 at 09:18:44AM +0800, Tian Tao wrote:
> disable_irq() after request_irq() still has a time gap in which
> interrupts can come. request_irq() with IRQF_NO_AUTOEN flag will
> disable IRQ auto-enable because of requesting.
> 
> Signed-off-by: Tian Tao <tiantao6@hisilicon.com>
> Link: https://lore.kernel.org/patchwork/patch/1388765/

Nit: please put your sob last.

Thanks for putting that link.

> v2: add the Link.

Nit: this should be just before diffstat.

> ---
>  drivers/char/tpm/tpm_tis_i2c_cr50.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm_tis_i2c_cr50.c b/drivers/char/tpm/tpm_tis_i2c_cr50.c
> index f19c227..44dde2f 100644
> --- a/drivers/char/tpm/tpm_tis_i2c_cr50.c
> +++ b/drivers/char/tpm/tpm_tis_i2c_cr50.c
> @@ -706,14 +706,14 @@ static int tpm_cr50_i2c_probe(struct i2c_client *client,
>  
>  	if (client->irq > 0) {
>  		rc = devm_request_irq(dev, client->irq, tpm_cr50_i2c_int_handler,
> -				      IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
> +				      IRQF_TRIGGER_FALLING | IRQF_ONESHOT |
> +				      IRQF_NO_AUTOEN,
>  				      dev->driver->name, chip);
>  		if (rc < 0) {
>  			dev_err(dev, "Failed to probe IRQ %d\n", client->irq);
>  			return rc;
>  		}
>  
> -		disable_irq(client->irq);
>  		priv->irq = client->irq;
>  	} else {
>  		dev_warn(dev, "No IRQ, will use %ums delay for TPM ready\n",
> -- 
> 2.7.4
> 
> 

Despite the nits I mangled the comit message and applied:

https://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git/commit/?id=f5e8131daa18c7f560dae294badfba7e15abdaee

Thank you.

/Jarkko
