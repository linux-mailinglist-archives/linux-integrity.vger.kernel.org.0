Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2D3A395519
	for <lists+linux-integrity@lfdr.de>; Mon, 31 May 2021 07:37:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229970AbhEaFi4 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 31 May 2021 01:38:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:44696 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229730AbhEaFix (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 31 May 2021 01:38:53 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9DD34611CA;
        Mon, 31 May 2021 05:37:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622439434;
        bh=Xk7KB8bqBJGO9yFxA7+ENOERrjqJLV60+NJ0AYWxhSw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=amqNNZpKIRt4Mpyn/25hKKDwTtjcJ2R0fLj6lRYntk0C71N8h0E/FKNKqlozoVR8Y
         6OvaLqNKx11GZaR6mG8oHueSkO1zRdS2Omg6s8o3Wg6Bvl6gxK9VRBvLNDTfDsYyh5
         Q/6w0QlusZxqo1hQx/Ub1PeXs4w8SVyZt91thd4gKahtb1xsugPzPz30ely7vrT+6C
         5bBILWNigb3kENPKvtap5k67w4glZ+e62zQmtbIJ1tSBFFVWuhY1V5up6jpDnTX0wH
         MASbO5U1ecVZs5DfTzZo7qUCOLXSwqmF/u7wMVDSTQj+xs+W1QCubwTDqY0LnPjWsd
         lIJbnGsoOa7Lw==
Date:   Mon, 31 May 2021 08:37:11 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Alexander Wellbrock <a.wellbrock@mailbox.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Peter Huewe <peterhuewe@gmx.de>,
        Peter Robinson <pbrobinson@gmail.com>,
        linux-integrity@vger.kernel.org
Subject: Re: [PATCH] tpm_tis_spi: add missing SPI device ID entries
Message-ID: <20210531053711.hmt4xm2g726d6ime@kernel.org>
References: <20210527152352.3835076-1-javierm@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210527152352.3835076-1-javierm@redhat.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, May 27, 2021 at 05:23:52PM +0200, Javier Martinez Canillas wrote:
> The SPI core always reports a "MODALIAS=spi:<foo>", even if the device was
> registered via OF. This means that this module won't auto-load if a DT has
> for example has a node with a compatible "infineon,slb9670" string.
> 
> In that case kmod will expect a "MODALIAS=of:N*T*Cinfineon,slb9670" uevent
> but instead will get a "MODALIAS=spi:slb9670", which is not present in the
> kernel module aliases:
> 
> $ modinfo drivers/char/tpm/tpm_tis_spi.ko | grep alias
> alias:          of:N*T*Cgoogle,cr50C*
> alias:          of:N*T*Cgoogle,cr50
> alias:          of:N*T*Ctcg,tpm_tis-spiC*
> alias:          of:N*T*Ctcg,tpm_tis-spi
> alias:          of:N*T*Cinfineon,slb9670C*
> alias:          of:N*T*Cinfineon,slb9670
> alias:          of:N*T*Cst,st33htpm-spiC*
> alias:          of:N*T*Cst,st33htpm-spi
> alias:          spi:cr50
> alias:          spi:tpm_tis_spi
> alias:          acpi*:SMO0768:*
> 
> To workaround this issue, add in the SPI device ID table all the entries
> that are present in the OF device ID table.
> 
> Reported-by: Alexander Wellbrock <a.wellbrock@mailbox.org>
> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
> ---
> 
>  drivers/char/tpm/tpm_tis_spi_main.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/char/tpm/tpm_tis_spi_main.c b/drivers/char/tpm/tpm_tis_spi_main.c
> index 3856f6ebcb3..de4209003a4 100644
> --- a/drivers/char/tpm/tpm_tis_spi_main.c
> +++ b/drivers/char/tpm/tpm_tis_spi_main.c
> @@ -260,6 +260,8 @@ static int tpm_tis_spi_remove(struct spi_device *dev)
>  }
>  
>  static const struct spi_device_id tpm_tis_spi_id[] = {
> +	{ "st33htpm-spi", (unsigned long)tpm_tis_spi_probe },
> +	{ "slb9670", (unsigned long)tpm_tis_spi_probe },
>  	{ "tpm_tis_spi", (unsigned long)tpm_tis_spi_probe },
>  	{ "cr50", (unsigned long)cr50_spi_probe },
>  	{}
> -- 
> 2.31.1
> 
> 

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

/Jarkko
