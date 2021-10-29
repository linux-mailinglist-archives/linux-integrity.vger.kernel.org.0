Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD0AC43F527
	for <lists+linux-integrity@lfdr.de>; Fri, 29 Oct 2021 05:03:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231617AbhJ2DFx (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 28 Oct 2021 23:05:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:47382 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231592AbhJ2DFw (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 28 Oct 2021 23:05:52 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7562560F9B;
        Fri, 29 Oct 2021 03:03:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635476605;
        bh=iZ0TXxRQgHIIrzGf58q8Kc8qwqllK6lXj+07bj2wNQE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XHb9I3XdjdSbABtdYNCfaczuXx/BrMpBXmrXz6LWSfRBHFxoXirz7jvcruP8p/7RB
         7TD5z3U0Ygl9RbkmgvLVEBNI68GxdMN6MXJ9ajCs+8k6oKBSu3PT0ocLm6tzD24WN7
         apVU9vF+SBibWHJ/x0RZ9sN5xOXW5a31ABi+WwqZszKIFfjIAehhobHhp9e4CViA33
         JYOkLLklHEDA6atLaP0kyTiawg0nMOXhlwRBMTqE1SJ/IXuyIaH5dU+uUL55KbeIdR
         vm59irubxAePF8TZUge+9O2J43pPwHae0iq6Xuys2wSVP2RCoYR6LIVd05dcEuk6kx
         Fl1trWln84hoQ==
Date:   Fri, 29 Oct 2021 06:03:22 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     linux-integrity@vger.kernel.org, apronin@chromium.org,
        peterhuewe@gmx.de, jgg@ziepe.ca
Subject: Re: [PATCH] tpm: tpm_tis_spi_cr50: Add default RNG quality
Message-ID: <YXtkejWpeU6D4s1z@iki.fi>
References: <20211027120233.2489258-1-angelogioacchino.delregno@collabora.com>
 <YXpHjUefFqmqrUbW@iki.fi>
 <e42ab3e1-6d07-c7bd-8d70-53f17a1228bc@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e42ab3e1-6d07-c7bd-8d70-53f17a1228bc@collabora.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Oct 28, 2021 at 10:55:56AM +0200, AngeloGioacchino Del Regno wrote:
> Il 28/10/21 08:47, Jarkko Sakkinen ha scritto:
> > On Wed, Oct 27, 2021 at 02:02:33PM +0200, AngeloGioacchino Del Regno wrote:
> > > To allow this device to fill the kernel's entropy pool at boot,
> > > setup a default quality for the hwrng found in Cr50.
> > > 
> > > After some testing with rngtest and dieharder it was, in short,
> > > discovered that the RNG produces fair quality randomness, giving
> > > around 99.93% successes in rngtest FIPS140-2.
> > > 
> > > Notably, though, when testing with dieharder it was noticed that
> > > the p-values distribution wasn't uniform in all the cases, so a
> > > conservative quality value was chosen.
> > > 
> > > Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> > > ---
> > >   drivers/char/tpm/tpm_tis_spi_cr50.c | 1 +
> > >   1 file changed, 1 insertion(+)
> > > 
> > > diff --git a/drivers/char/tpm/tpm_tis_spi_cr50.c b/drivers/char/tpm/tpm_tis_spi_cr50.c
> > > index ea759af25634..d6195fb58036 100644
> > > --- a/drivers/char/tpm/tpm_tis_spi_cr50.c
> > > +++ b/drivers/char/tpm/tpm_tis_spi_cr50.c
> > > @@ -264,6 +264,7 @@ int cr50_spi_probe(struct spi_device *spi)
> > >   	phy = &cr50_phy->spi_phy;
> > >   	phy->flow_control = cr50_spi_flow_control;
> > >   	phy->wake_after = jiffies;
> > > +	phy->priv.rng_quality = 700;
> > 
> > How did you end up exactly to this number ('700')?
> > 
> > /Jarkko
> > 
> 
> As for what I've seen with rngtest, the number should be much higher, but
> dieharder gave 3 WEAK results over 114, which isn't optimal. As also explained
> in the commit message, the p-values distribution also wasn't uniform in all
> of the cases, so I've applied an arbitrary penalty to the calculated values.
> 
> In any case, that's how it went:
> 
> The dieharder results were averaged, then normalized (0-1000) and re-averaged
> with the rngtest result (where the result was given a score of 99.93% of 1000,
> so 999.3), then aggregated together and averaged again.
> An arbitrary penalty of -100 was applied due to the retrieved value, which
> brings us finally to 700.

Please, add this to the commit message for reference.

In addition, please use a named constant instead of magic number, e.g.

/* Default quality for hwrng. */
#define TPM_CR50_DEFAULT_RNG_QUALITY            700

> Regards,
> - Angelo

/Jarkko
