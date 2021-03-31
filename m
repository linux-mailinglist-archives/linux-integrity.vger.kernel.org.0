Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32288350AC7
	for <lists+linux-integrity@lfdr.de>; Thu,  1 Apr 2021 01:30:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231180AbhCaX3x (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 31 Mar 2021 19:29:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:60914 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231620AbhCaX3Y (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 31 Mar 2021 19:29:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B823561057;
        Wed, 31 Mar 2021 23:29:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617233364;
        bh=JebS+wdY/3yB7SUptLSmC/sUwEFAeCuSulf8NIrcDyQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SqAPqz6e3245+08kGeFKcOh4uuGzFMATtNMfF4K+fHHKK7c7Kr+hRXR7G5pE/6bur
         2AAhu97AchtYopAQpd7v7t2dSKJTgqspLKJRtje04wwY93yNMFxsjnLLuH5Xcqpsgt
         nyRnchFKt0uVCzAAvKVXFwXjrBOpmBf/FDijVMKj9WrZ/0YQN9ZCkdgdJWHYQrVK4H
         MOASZSPhGjhT7gUrSqEj93YYqJfnZyk7dLb96c51Z0+LSQEdo+Z0tKmT1sgeUNuwQS
         wJz/irzAboWWXhLW4rxkSOn3T6RvUYPi5Ube+yGfNcneWYDq80ONpPMu8sds8946YL
         5ceiA4W9mVfcQ==
Date:   Thu, 1 Apr 2021 02:29:22 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Ahmad Fatoum <a.fatoum@pengutronix.de>
Cc:     David Gstir <david@sigma-star.at>,
        Sumit Garg <sumit.garg@linaro.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Horia =?utf-8?Q?Geant=C4=83?= <horia.geanta@nxp.com>,
        Jonathan Corbet <corbet@lwn.net>,
        David Howells <dhowells@redhat.com>,
        James Bottomley <jejb@linux.ibm.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Aymen Sghaier <aymen.sghaier@nxp.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Udit Agarwal <udit.agarwal@nxp.com>,
        Jan Luebbe <j.luebbe@pengutronix.de>,
        Franck Lenormand <franck.lenormand@nxp.com>,
        "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>
Subject: Re: [PATCH v1 3/3] KEYS: trusted: Introduce support for NXP
 CAAM-based trusted keys
Message-ID: <YGUF0sArOSy2gdpS@kernel.org>
References: <01e6e13d-2968-0aa5-c4c8-7458b7bde462@nxp.com>
 <45a9e159-2dcb-85bf-02bd-2993d50b5748@pengutronix.de>
 <f9c0087d299be1b9b91b242f41ac6ef7b9ee3ef7.camel@linux.ibm.com>
 <63dd7d4b-4729-9e03-cd8f-956b94eab0d9@pengutronix.de>
 <CAFA6WYOw_mQwOUN=onhzb7zCTyYDBrcx0E7C3LRk6nPLAVCWEQ@mail.gmail.com>
 <557b92d2-f3b8-d136-7431-419429f0e059@pengutronix.de>
 <CAFA6WYNE44=Y7Erfc-xNtOrf7TkJjh+odmYH5vzhEHR6KqBfeQ@mail.gmail.com>
 <6F812C20-7585-4718-997E-0306C4118468@sigma-star.at>
 <YGDpA4yPWmTWEyx+@kernel.org>
 <1171de9c-97b9-3936-707b-16ec34cf94d5@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1171de9c-97b9-3936-707b-16ec34cf94d5@pengutronix.de>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Mar 29, 2021 at 12:11:24PM +0200, Ahmad Fatoum wrote:
> Hello Jarkko,
> 
> On 28.03.21 22:37, Jarkko Sakkinen wrote:
> > On Sat, Mar 27, 2021 at 01:41:24PM +0100, David Gstir wrote:
> >> Generally speaking, I’d say trusting the CAAM RNG and trusting in it’s
> >> other features are two separate things. However, reading through the CAAM
> >> key blob spec I’ve got here, CAAM key blob keys (the keys that secure a blob’s
> >> content) are generated using its internal RNG. So I’d save if the CAAM RNG
> >> is insecure, so are generated key blobs. Maybe somebody with more insight
> >> into the CAAM internals can verify that, but I don’t see any point in using
> >> the kernel’s RNG as long as we let CAAM generate the key blob keys for us.
> > 
> > Here's my long'ish analysis. Please read it to the end if by ever means
> > possible, and apologies, I usually try to keep usually my comms short, but
> > this requires some more meat than the usual.
> 
> Thanks for the write-up!
> 
> > The Bad News
> > ============
> > 
> > Now that we add multiple hardware trust sources for trusted keys, will
> > there ever be a scenario where a trusted key is originally sealed with a
> > backing hardware A, unsealed, and resealed with hardware B?
> > 
> > The hardware and vendor neutral way to generate the key material would be
> > unconditionally always just the kernel RNG.
> > 
> > CAAM is actually worse than TCG because it's not even a standards body, if
> > I got it right. Not a lot but at least a tiny fraction.
> 
> CAAM is how NXP calls the crypto accelerator built into some of its SoCs.
> 
> > This brings an open item in TEE patches: trusted_tee_get_random() is an
> > issue in generating kernel material. I would rather replace that with
> > kernel RNG *for now*, because the same open question applies also to ARM
> > TEE. It's also a single company controlled backing technology.
> > 
> > By all practical means, I do trust ARM TEE in my personal life but this is
> > not important.
> > 
> > CAAM *and* TEE backends break the golden rule of putting as little trust as
> > possible to anything, even not anything weird is clear at sight, as
> > security is essentially a game of known unknowns and unknown unknowns.
> 
> Agreed.
> 
> > The GOOD News
> > =============
> > 
> > So there's actually option (C) that also fixes the TPM trustd keys issue:
> > 
> > Add a new kernel patch, which:
> > 
> > 1. Adds the use of kernel RNG as a boot option.
> > 2. If this boot option is not active, the subsystem will print a warning
> >    to klog denoting this.
> > 3. Default is of course vendor RNG given the bad design issue in the TPM
> >    trusted keys, but the warning in klog will help to address it at least
> >    a bit.
> 
> Why should the TPM backend's choice influence later backends? We could add
> a new option for key creation time, e.g.:
> 
>    keyctl add trusted kmk "new keylen rng=kernel" @s
> 
> The default would be rng=vendor if available with a fallback to rng=kernel,
> which should always be available.

It matters a lot because it is existing ABI - for better or worse.

I think a new option is a bad idea, because it cannot easily enforced.
Kernel command-line on the other hand can be even signed.

/Jarkko
