Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDA382F9464
	for <lists+linux-integrity@lfdr.de>; Sun, 17 Jan 2021 19:09:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728350AbhAQSJJ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 17 Jan 2021 13:09:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:36464 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728217AbhAQSJG (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 17 Jan 2021 13:09:06 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id DEE56207DE;
        Sun, 17 Jan 2021 18:08:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610906905;
        bh=As+JB9THonuWKdBjY+Axcqii9AVA5+fbThIZjXjBzkE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nc1boJvqYIITidkEzqtimmAAnFbxeHqJYyT2cun0WSeGiECJ7tB7nsGbadKLmcN0k
         zNe2l4I6cxC4co2Yj3LgZUnMX9sbNgiWemuZQnmAhfXIFbdhTMFHWnQg77qzNyUJ3L
         yhx7BaYEqbrVZTXSWOmQCjNq2kvbHvfXPIcetnCCPIusJuFC6TOaBl6RLXTd1HbI9c
         +ExZ/S4cCBrhA/PdO58lo+ZL/Rs2GV1iqH+Phi47Ahx7UYMwKVoUjJu4lmNLcBNA+D
         Q5rYiE4niwMyzpseK/Mm4Q4lS1CvnO0MzU+IfhTRZPy/IQ+rklYqrs/lN17Lhn0O/s
         dRvI662utpgPw==
Date:   Sun, 17 Jan 2021 20:08:20 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Lino Sanfilippo <LinoSanfilippo@gmx.de>
Cc:     peterhuewe@gmx.de, jgg@ziepe.ca, stefanb@linux.vnet.ibm.com,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        p.rosenberger@kunbus.com, Lino Sanfilippo <l.sanfilippo@kunbus.com>
Subject: Re: [PATCH 1/4] tpm: in case of error properly cleanup in
 tpmm_chip_alloc
Message-ID: <YAR9FGbjAArQ0nw3@kernel.org>
References: <1610760161-21982-1-git-send-email-LinoSanfilippo@gmx.de>
 <1610760161-21982-2-git-send-email-LinoSanfilippo@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1610760161-21982-2-git-send-email-LinoSanfilippo@gmx.de>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Sat, Jan 16, 2021 at 02:22:38AM +0100, Lino Sanfilippo wrote:
> From: Lino Sanfilippo <l.sanfilippo@kunbus.com>
> 
> In tpmm_chip_alloc() a resource management action handler is installed to
> release the chip->dev in case of error. This will result in the chip being
> freed if it was the last reference. If the installation of the handler was
> not successful an error is returned to the caller.
> However in this case the chip->dev reference is not put and thus the chip
> is never freed. Fix this by releasing the reference "by hand" in case that
> the action handler installation failed.
> 
> Signed-off-by: Lino Sanfilippo <l.sanfilippo@kunbus.com>
> ---
>  drivers/char/tpm/tpm-chip.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
> index ddaeceb..e242d2e 100644
> --- a/drivers/char/tpm/tpm-chip.c
> +++ b/drivers/char/tpm/tpm-chip.c
> @@ -423,11 +423,15 @@ struct tpm_chip *tpmm_chip_alloc(struct device *pdev,
>  				      (void (*)(void *)) put_device,
>  				      &chip->dev);
>  	if (rc)
> -		return ERR_PTR(rc);
> +		goto put_dev;
>  
>  	dev_set_drvdata(pdev, chip);
>  
>  	return chip;
> +
> +put_dev:
> +	put_device(&chip->dev);
> +	return ERR_PTR(rc);
>  }
>  EXPORT_SYMBOL_GPL(tpmm_chip_alloc);
>  
> -- 
> 2.7.4
> 

NAK

[*] https://elixir.bootlin.com/linux/v5.11-rc3/source/include/linux/device.h#L257

/Jarkko
