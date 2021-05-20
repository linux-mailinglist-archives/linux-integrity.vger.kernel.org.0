Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C82DE38B44C
	for <lists+linux-integrity@lfdr.de>; Thu, 20 May 2021 18:34:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231566AbhETQfX (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 20 May 2021 12:35:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:35634 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231354AbhETQfW (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 20 May 2021 12:35:22 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CF7CE61019;
        Thu, 20 May 2021 16:34:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621528441;
        bh=TvE839XGTfNdzX55ui/8Y/X6ItchS3tDQWpwAo6ko3Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=g3Ggt+l2pbFCV00QXfMZuwkUi7v1myn0KUqph2UqddROC2p3GHOhaC4EYGS2YXXUq
         PT+3/lV9ZRE9gB/tfWXC4/0/Dy+bcQ21/b3T1WKcywunNOozDfB3xuL/0ZRe2so1Ih
         zKYzb5R4SGPEdh3wBRi2e1G56OQc+DuWT/TEhNzPSro5cVyZWn0XXaD0ACIh1dWI68
         6IOlDhlc71ByNdnfb+aalpO3FwaYjfaqkRKYVwvf2YDT29+zWAboEqQwRzibuk9tUN
         5NIRg+MUbJ92w4oVvB8FmVchWzWmfIpWcR/lIwMRxemjoyPgglPvgTlZHheB7K/b0Z
         jz2Cv89JKeh5Q==
Date:   Thu, 20 May 2021 19:33:58 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Tian Tao <tiantao6@hisilicon.com>
Cc:     peterhuewe@gmx.de, linux-integrity@vger.kernel.org
Subject: Re: [PATCH v3] char: tpm: move to use request_irq by IRQF_NO_AUTOEN
 flag
Message-ID: <YKaPdtwAG+IgAZZO@kernel.org>
References: <1621406999-16816-1-git-send-email-tiantao6@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1621406999-16816-1-git-send-email-tiantao6@hisilicon.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, May 19, 2021 at 02:49:59PM +0800, Tian Tao wrote:
> disable_irq() after request_irq() still has a time gap in which
> interrupts can come. request_irq() with IRQF_NO_AUTOEN flag will
> disable IRQ auto-enable because of requesting.
> 
> Link: https://lore.kernel.org/patchwork/patch/1388765/
> Signed-off-by: Tian Tao <tiantao6@hisilicon.com>
> ---
> v2: add the Link.
> v3: put sob last.
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

How does this differ from

https://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git/commit/?id=da2f0c7b46171175ab54da248752b1139c42fee4
?

/Jarkko
