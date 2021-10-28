Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8122343DB7C
	for <lists+linux-integrity@lfdr.de>; Thu, 28 Oct 2021 08:47:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229626AbhJ1GuK (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 28 Oct 2021 02:50:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:39904 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229586AbhJ1GuK (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 28 Oct 2021 02:50:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 369C260296;
        Thu, 28 Oct 2021 06:47:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635403663;
        bh=wRNwPg2chSsOMTnkRK+Oc+1M7gfaT3Gp1P+G/u0kwIA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DIBuS6jM9K5pPRUfYJO8mlvfgmPJDbgfjHo6gDEvgB0e0NakDu01YqPDtcqhAf+i6
         B93tbBoBaU+wsLx5hPMymf7r5mZyUpCriV001uAalkkf1s6SagyKyzuG4NWYijLQx8
         iI4VWFbwdxFOJto0d6VUIDIv9Qsl2YPEyN2FGxTortTjfn1kOzuaTr5bdpVraDAPHP
         68wWmc7J/CmKSxwsCcpZ67GtRxd7HgcUKw68/+X+u0CEL/2Wf50mCIdc0dXNI6vX4t
         QLHW2hp+HVpC0ya68P6pqFgts7Npjs1GpmHnNnrfnzWB7SxaZxLKcv7zY03wRhQZ+E
         dVbcU7A0Al1Gw==
Date:   Thu, 28 Oct 2021 09:47:41 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     linux-integrity@vger.kernel.org, apronin@chromium.org,
        peterhuewe@gmx.de, jgg@ziepe.ca
Subject: Re: [PATCH] tpm: tpm_tis_spi_cr50: Add default RNG quality
Message-ID: <YXpHjUefFqmqrUbW@iki.fi>
References: <20211027120233.2489258-1-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211027120233.2489258-1-angelogioacchino.delregno@collabora.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Oct 27, 2021 at 02:02:33PM +0200, AngeloGioacchino Del Regno wrote:
> To allow this device to fill the kernel's entropy pool at boot,
> setup a default quality for the hwrng found in Cr50.
> 
> After some testing with rngtest and dieharder it was, in short,
> discovered that the RNG produces fair quality randomness, giving
> around 99.93% successes in rngtest FIPS140-2.
> 
> Notably, though, when testing with dieharder it was noticed that
> the p-values distribution wasn't uniform in all the cases, so a
> conservative quality value was chosen.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  drivers/char/tpm/tpm_tis_spi_cr50.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/char/tpm/tpm_tis_spi_cr50.c b/drivers/char/tpm/tpm_tis_spi_cr50.c
> index ea759af25634..d6195fb58036 100644
> --- a/drivers/char/tpm/tpm_tis_spi_cr50.c
> +++ b/drivers/char/tpm/tpm_tis_spi_cr50.c
> @@ -264,6 +264,7 @@ int cr50_spi_probe(struct spi_device *spi)
>  	phy = &cr50_phy->spi_phy;
>  	phy->flow_control = cr50_spi_flow_control;
>  	phy->wake_after = jiffies;
> +	phy->priv.rng_quality = 700;

How did you end up exactly to this number ('700')?

/Jarkko
