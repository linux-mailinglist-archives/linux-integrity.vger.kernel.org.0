Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63233309050
	for <lists+linux-integrity@lfdr.de>; Fri, 29 Jan 2021 23:54:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231897AbhA2Wuq (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 29 Jan 2021 17:50:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:60864 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231623AbhA2Wuo (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 29 Jan 2021 17:50:44 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2256064DE2;
        Fri, 29 Jan 2021 22:50:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611960603;
        bh=zXm0xZuG9OSEEtoZN5Qt00ROf9jG6ey6+nY9VvgoWrQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BMhpzb8CfhxkKEC+gxSq0Iymiz08WhyWdMB/VeM+OjVsUzv2kWCo0vcIB1ek8bjhx
         GJ+sYPdaRMf/0+Qat0fJVOXMJduukJglLfh90+YidwqmkPByeSM1YFxO3jqmhK+PoX
         dJpuAviGp2pB6NpDNMgSn6Cj14pEhFMUOEZNtUwki1djvXgUVf7ImF0PsXSHSr4988
         I5u/pTevihPaETPn60QJ5fWPi4zihIy4mu3yuAAW+XqZ9Tyi8WUgRf/wzV3k6JL3Le
         /4AhjbGCupsZ37h+xEJG2JJN0f8KHeZbOSzt8sCDBfrCVWJgmPoVqRotm1Ya2dpVON
         MkYdA584TmyEw==
Date:   Sat, 30 Jan 2021 00:49:58 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Lukasz Majczak <lma@semihalf.com>, Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        Radoslaw Biernacki <rad@semihalf.com>,
        Marcin Wojtas <mw@semihalf.com>,
        Alex Levin <levinale@google.com>
Subject: Re: [PATCH] tpm_tis: Add missing start/stop_tpm_chip calls
Message-ID: <YBSRFsTNjadQMndD@kernel.org>
References: <20210123014247.989368-1-lma@semihalf.com>
 <20210125171846.GA31929@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210125171846.GA31929@roeck-us.net>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Jan 25, 2021 at 09:18:46AM -0800, Guenter Roeck wrote:
> Hi Lukasz,
> 
> On Sat, Jan 23, 2021 at 02:42:47AM +0100, Lukasz Majczak wrote:
> > There is a missing call to start_tpm_chip before the call to
> > the tpm_get_timeouts() and tpm_tis_probe_irq_single(). As the current
> > approach maight work for tpm2, it fails for tpm1.x - in that case
> > call to tpm_get_timeouts() or tpm_tis_probe_irq_single() tries to
> > transmit TPM commands on a disabled chip what what doesn't succeed
> 
> s/what what/what/

s/maight/might/

Also, would be nice to have the capatalization of acronyms correct
and consistent. E.g. tpm1.x should be rather written as "TPM 1.x
chips".

It's also incorrect to state that something fails for TPM 1.x chips,
unless you can somehow make a sense that every single TPM 1.x at wild
fails, which probably is not true.

> > and in turn causes tpm_tis_core_init() to fail.
> > Tested on Samsung Chromebook Pro (Caroline).

Anyone can tell me what does Caroline mean anyway?

> > 
> > Signed-off-by: Lukasz Majczak <lma@semihalf.com>
> > ---
> >  drivers/char/tpm/tpm_tis_core.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> > 
> > diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
> > index 92c51c6cfd1b..ff0e5fe46a9d 100644
> > --- a/drivers/char/tpm/tpm_tis_core.c
> > +++ b/drivers/char/tpm/tpm_tis_core.c
> > @@ -1063,12 +1063,16 @@ int tpm_tis_core_init(struct device *dev, struct tpm_tis_data *priv, int irq,
> >  	init_waitqueue_head(&priv->read_queue);
> >  	init_waitqueue_head(&priv->int_queue);
> >  	if (irq != -1) {
> > +		rc = tpm_chip_start(chip);
> 
> Unless I am missing something, the underlying problem seems to be
> the calls to tpm1_getcap(). From other code calling this function,
> it looks like it may only require tpm_clk_enable() to work.

I don't claim to be bus expert but afaik CLKRUN is used with to power
on/off clock, when using LPC bus.

Also, TPM interface specification speaks about CLKRUN in the section
6.3 "TPM LPC Hardware Protocol".

> With that in mind, would it possibly be better to call tpm_clk_enable()
> and tpm_clk_disable() around the calls to tpm1_getcap(), ie in
> tpm1_get_timeouts() and in tpm_tis_gen_interrupt() ?
> 
> This would avoid the unnecessary calls to tpm_chip_start() and
> tpm_chip_stop() for tpm2 chips.

Not enough information about hardware and no klog. Cannot make much
conclusions with the information available.

> Thanks,
> Guenter

Off-topic: I noticed some dumb code in tpm_tis_core.c:

	if (chip->ops->clk_enable != NULL)
		chip->ops->clk_enable(chip, false);

These should be definitely changed as:

       tpm_tis_clkrun_enable(chip, false);

->clk_enable() should be only used in tpm-interface.c.

Not a bug, just really stupid code (and harder to trace).

/Jarkko
