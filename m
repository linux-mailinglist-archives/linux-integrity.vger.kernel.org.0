Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB1AC33FA37
	for <lists+linux-integrity@lfdr.de>; Wed, 17 Mar 2021 21:59:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233360AbhCQU7N (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 17 Mar 2021 16:59:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:48006 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233285AbhCQU6w (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 17 Mar 2021 16:58:52 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 62AA564E6B;
        Wed, 17 Mar 2021 20:58:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616014731;
        bh=Tri/yDWhaSnEHRUx/VsliXjxlkiwKUR/nS5uBkeR4sU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uEiSKOfKusq67RqWh8YzAjTOX/yCrI+ZyE3VMyLTN6sFd0UrWABHqXcEpDBMLB3oi
         fREQgdJu88hHscKK7yQA9OUx3DRIALYD9YJgvgiK9ODNMJ7MI8jOQACmu7xt35YM9z
         GIVzIAiX6za6YR0Dc7uCdVcZVGSCsdmdBnNlpPsPaddZJotGJ+tPOliQbpV398ROta
         hRUb62RCzvCtDLnbyFs8eEISTf9szTz1zn4cZqMaNqmY975PmIxEtvGQdJHXab9yqQ
         XwKtSlLNG84WAe0lmBbbwZKHIO/zjtXmyF2xgAZB3E1FLkGZ+WNnCk3RW2uSRSWJyr
         LCoZv3rkzX29w==
Date:   Wed, 17 Mar 2021 22:58:25 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Tian Tao <tiantao6@hisilicon.com>
Cc:     peterhuewe@gmx.de, jgg@ziepe.ca, linux-integrity@vger.kernel.org
Subject: Re: [PATCH] char: tpm: move to use request_irq by IRQF_NO_AUTOEN flag
Message-ID: <YFJtcUzj6SGRRgq9@kernel.org>
References: <1615971586-21039-1-git-send-email-tiantao6@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1615971586-21039-1-git-send-email-tiantao6@hisilicon.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Mar 17, 2021 at 04:59:46PM +0800, Tian Tao wrote:
> disable_irq() after request_irq() still has a time gap in which
> interrupts can come. request_irq() with IRQF_NO_AUTOEN flag will
> disable IRQ auto-enable because of requesting.
> 
> Signed-off-by: Tian Tao <tiantao6@hisilicon.com>

Is this a new feature?

What would be great is a "Link:" tag to the patch set if it is fairly
recent (i.e. lore.kernel.org link).

/Jarkko

> ---
>  drivers/char/tpm/tpm_tis_i2c_cr50.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm_tis_i2c_cr50.c b/drivers/char/tpm/tpm_tis_i2c_cr50.c
> index ec9a65e..25299e5 100644
> --- a/drivers/char/tpm/tpm_tis_i2c_cr50.c
> +++ b/drivers/char/tpm/tpm_tis_i2c_cr50.c
> @@ -705,14 +705,14 @@ static int tpm_cr50_i2c_probe(struct i2c_client *client,
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
