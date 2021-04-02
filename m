Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25080352547
	for <lists+linux-integrity@lfdr.de>; Fri,  2 Apr 2021 03:58:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233870AbhDBB6V (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 1 Apr 2021 21:58:21 -0400
Received: from mail.hallyn.com ([178.63.66.53]:40296 "EHLO mail.hallyn.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233258AbhDBB6U (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 1 Apr 2021 21:58:20 -0400
X-Greylist: delayed 505 seconds by postgrey-1.27 at vger.kernel.org; Thu, 01 Apr 2021 21:58:18 EDT
Received: by mail.hallyn.com (Postfix, from userid 1001)
        id F246D774; Thu,  1 Apr 2021 20:49:50 -0500 (CDT)
Date:   Thu, 1 Apr 2021 20:49:50 -0500
From:   "Serge E. Hallyn" <serge@hallyn.com>
To:     James Bottomley <jejb@linux.ibm.com>
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        Ahmad Fatoum <a.fatoum@pengutronix.de>,
        Horia =?utf-8?Q?Geant=C4=83?= <horia.geanta@nxp.com>,
        Jonathan Corbet <corbet@lwn.net>,
        David Howells <dhowells@redhat.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Aymen Sghaier <aymen.sghaier@nxp.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Udit Agarwal <udit.agarwal@nxp.com>,
        Jan Luebbe <j.luebbe@pengutronix.de>,
        David Gstir <david@sigma-star.at>,
        Franck Lenormand <franck.lenormand@nxp.com>,
        Sumit Garg <sumit.garg@linaro.org>,
        "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>
Subject: Re: [PATCH v1 3/3] KEYS: trusted: Introduce support for NXP
 CAAM-based trusted keys
Message-ID: <20210402014950.GA6897@mail.hallyn.com>
References: <cover.56fff82362af6228372ea82e6bd7e586e23f0966.1615914058.git-series.a.fatoum@pengutronix.de>
 <319e558e1bd19b80ad6447c167a2c3942bdafea2.1615914058.git-series.a.fatoum@pengutronix.de>
 <01e6e13d-2968-0aa5-c4c8-7458b7bde462@nxp.com>
 <45a9e159-2dcb-85bf-02bd-2993d50b5748@pengutronix.de>
 <f9c0087d299be1b9b91b242f41ac6ef7b9ee3ef7.camel@linux.ibm.com>
 <9ba89168d8c4f1e3d6797a0b3713e152ac6388fd.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9ba89168d8c4f1e3d6797a0b3713e152ac6388fd.camel@linux.ibm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Mar 24, 2021 at 09:14:02AM -0700, James Bottomley wrote:
> On Tue, 2021-03-23 at 14:07 -0400, Mimi Zohar wrote:
> > On Tue, 2021-03-23 at 17:35 +0100, Ahmad Fatoum wrote:
> > > Hello Horia,
> > > 
> > > On 21.03.21 21:48, Horia Geantă wrote:
> > > > On 3/16/2021 7:02 PM, Ahmad Fatoum wrote:
> > > > [...]
> > > > > +struct trusted_key_ops caam_trusted_key_ops = {
> > > > > +	.migratable = 0, /* non-migratable */
> > > > > +	.init = trusted_caam_init,
> > > > > +	.seal = trusted_caam_seal,
> > > > > +	.unseal = trusted_caam_unseal,
> > > > > +	.exit = trusted_caam_exit,
> > > > > +};
> > > > caam has random number generation capabilities, so it's worth
> > > > using that
> > > > by implementing .get_random.
> > > 
> > > If the CAAM HWRNG is already seeding the kernel RNG, why not use
> > > the kernel's?
> > > 
> > > Makes for less code duplication IMO.
> > 
> > Using kernel RNG, in general, for trusted keys has been discussed
> > before.   Please refer to Dave Safford's detailed explanation for not
> > using it [1].
> > 
> > thanks,
> > 
> > Mimi
> > 
> > [1] 
> > https://lore.kernel.org/linux-integrity/BCA04D5D9A3B764C9B7405BBA4D4A3C035F2A38B@ALPMBAPA12.e2k.ad.ge.com/
> 
> I still don't think relying on one source of randomness to be
> cryptographically secure is a good idea.  The fear of bugs in the
> kernel entropy pool is reasonable, but since it's widely used they're
> unlikely to persist very long.

I'm not sure I agree - remember
https://www.schneier.com/blog/archives/2008/05/random_number_b.html ?  You'd
surely expect that to have been found quickly.

>   Studies have shown that some TPMs
> (notably the chinese manufactured ones) have suspicious failures in
> their RNGs:
> 
> https://www.researchgate.net/publication/45934562_Benchmarking_the_True_Random_Number_Generator_of_TPM_Chips
> 
> And most cryptograhpers recommend using a TPM for entropy mixing rather
> than directly:
> 
> https://blog.cryptographyengineering.com/category/rngs/
> 
> The TPMFail paper also shows that in spite of NIST certification
> things can go wrong with a TPM:
> 
> https://tpm.fail/

In this thread I've seen argument over "which is better" and "which is user api",
but noone's mentioned fips.  Unfortunately, so long as kernel rng refuses to be
fips-friendly (cf https://lkml.org/lkml/2020/9/21/157), making CAAM based trusted
keys depend on kernel rng would make them impossible to use in fips certified
applications without a forked kernel.

So I definitely am in favor of a config or kernel command line option to drive
which rng to use.
