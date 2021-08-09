Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C01A03E4361
	for <lists+linux-integrity@lfdr.de>; Mon,  9 Aug 2021 11:56:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233603AbhHIJ5K (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 9 Aug 2021 05:57:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:50774 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233528AbhHIJ5J (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 9 Aug 2021 05:57:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CCB6660F11;
        Mon,  9 Aug 2021 09:56:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628503009;
        bh=siHqB30+J8sLOp7pEGFo9z0ErNUa2pMXDyohhHMW7U8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kevZHtdJYJPiRj0NYnYLFNKteyuj7hA/3N6StyCDAJnl9mszdPiYnuhSH2mqjlnq4
         WtYS5CV8PlkYUHLSys+qFSJbIJh84/P6OSbhYCAHeckZZuBQ/2NVw3u+GY++pu/xed
         l14Vq78Yr7dxIE2hki8H9zO0jo6NgQmwm3DfgomeezsJZ7yGAhQX1jiFDRnFx457nQ
         +HK/EnQDZW1XX6O5PBu4X/sR1VXruhpIdGGtz2hN4+9EEOKfyQU9DwNffq0QDFghHT
         lxYtXA121HNVgRoIU05N0p2enG/6gtH7nFUgNiY8mxJ814WTgXmO0XJsYoRASpqbnP
         dxaypa2KMthug==
Date:   Mon, 9 Aug 2021 12:56:47 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Ahmad Fatoum <a.fatoum@pengutronix.de>
Cc:     Sumit Garg <sumit.garg@linaro.org>,
        James Bottomley <jejb@linux.ibm.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        David Howells <dhowells@redhat.com>,
        kernel <kernel@pengutronix.de>, James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Horia =?utf-8?Q?Geant=C4=83?= <horia.geanta@nxp.com>,
        Aymen Sghaier <aymen.sghaier@nxp.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Udit Agarwal <udit.agarwal@nxp.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Jan Luebbe <j.luebbe@pengutronix.de>,
        David Gstir <david@sigma-star.at>,
        Richard Weinberger <richard@nod.at>,
        Franck LENORMAND <franck.lenormand@nxp.com>,
        "open list:ASYMMETRIC KEYS" <keyrings@vger.kernel.org>,
        "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" 
        <linux-crypto@vger.kernel.org>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:SECURITY SUBSYSTEM" 
        <linux-security-module@vger.kernel.org>
Subject: Re: [PATCH 2/4] KEYS: trusted: allow trust sources to use kernel RNG
 for key material
Message-ID: <20210809095647.7xcxjeot5gyvmlpj@kernel.org>
References: <cover.9fc9298fd9d63553491871d043a18affc2dbc8a8.1626885907.git-series.a.fatoum@pengutronix.de>
 <7b771da7b09a01c8b4da2ed21f05251ea797b2e8.1626885907.git-series.a.fatoum@pengutronix.de>
 <CAFA6WYOskwZNe5Wb5PTtnSHQBonSXZ48eEex0w9jQ+JW4vG=+w@mail.gmail.com>
 <7537c853-3641-a6d3-91d8-70fea9f01a89@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7537c853-3641-a6d3-91d8-70fea9f01a89@pengutronix.de>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Aug 09, 2021 at 09:52:20AM +0200, Ahmad Fatoum wrote:
> Hello Sumit,
> 
> On 22.07.21 08:31, Sumit Garg wrote:
> > On Wed, 21 Jul 2021 at 22:19, Ahmad Fatoum <a.fatoum@pengutronix.de> wrote:
> >>
> >> The two existing trusted key sources don't make use of the kernel RNG,
> >> but instead let the hardware that does the sealing/unsealing also
> >> generate the random key material. While a previous change offers users
> >> the choice to use the kernel RNG instead for both, new trust sources
> >> may want to unconditionally use the kernel RNG for generating key
> >> material, like it's done elsewhere in the kernel.
> >>
> >> This is especially prudent for hardware that has proven-in-production
> >> HWRNG drivers implemented, as otherwise code would have to be duplicated
> >> only to arrive at a possibly worse result.
> >>
> >> Make this possible by turning struct trusted_key_ops::get_random
> >> into an optional member. If a driver leaves it NULL, kernel RNG
> >> will be used instead.
> >>
> >> Signed-off-by: Ahmad Fatoum <a.fatoum@pengutronix.de>
> >> ---
> >> To: James Bottomley <jejb@linux.ibm.com>
> >> To: Jarkko Sakkinen <jarkko@kernel.org>
> >> To: Mimi Zohar <zohar@linux.ibm.com>
> >> To: David Howells <dhowells@redhat.com>
> >> Cc: James Morris <jmorris@namei.org>
> >> Cc: "Serge E. Hallyn" <serge@hallyn.com>
> >> Cc: "Horia Geantă" <horia.geanta@nxp.com>
> >> Cc: Aymen Sghaier <aymen.sghaier@nxp.com>
> >> Cc: Herbert Xu <herbert@gondor.apana.org.au>
> >> Cc: "David S. Miller" <davem@davemloft.net>
> >> Cc: Udit Agarwal <udit.agarwal@nxp.com>
> >> Cc: Eric Biggers <ebiggers@kernel.org>
> >> Cc: Jan Luebbe <j.luebbe@pengutronix.de>
> >> Cc: David Gstir <david@sigma-star.at>
> >> Cc: Richard Weinberger <richard@nod.at>
> >> Cc: Franck LENORMAND <franck.lenormand@nxp.com>
> >> Cc: Sumit Garg <sumit.garg@linaro.org>
> >> Cc: keyrings@vger.kernel.org
> >> Cc: linux-crypto@vger.kernel.org
> >> Cc: linux-integrity@vger.kernel.org
> >> Cc: linux-kernel@vger.kernel.org
> >> Cc: linux-security-module@vger.kernel.org
> >> ---
> >>  include/keys/trusted-type.h               | 2 +-
> >>  security/keys/trusted-keys/trusted_core.c | 2 +-
> >>  2 files changed, 2 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/include/keys/trusted-type.h b/include/keys/trusted-type.h
> >> index d89fa2579ac0..4eb64548a74f 100644
> >> --- a/include/keys/trusted-type.h
> >> +++ b/include/keys/trusted-type.h
> >> @@ -64,7 +64,7 @@ struct trusted_key_ops {
> >>         /* Unseal a key. */
> >>         int (*unseal)(struct trusted_key_payload *p, char *datablob);
> >>
> >> -       /* Get a randomized key. */
> >> +       /* Optional: Get a randomized key. */
> >>         int (*get_random)(unsigned char *key, size_t key_len);
> >>
> >>         /* Exit key interface. */
> >> diff --git a/security/keys/trusted-keys/trusted_core.c b/security/keys/trusted-keys/trusted_core.c
> >> index 569af9af8df0..d2b7626cde8b 100644
> >> --- a/security/keys/trusted-keys/trusted_core.c
> >> +++ b/security/keys/trusted-keys/trusted_core.c
> >> @@ -334,7 +334,7 @@ static int __init init_trusted(void)
> >>                         continue;
> >>
> >>                 get_random = trusted_key_sources[i].ops->get_random;
> >> -               if (trusted_kernel_rng)
> >> +               if (trusted_kernel_rng || !get_random)
> >>                         get_random = kernel_get_random;
> >>
> > 
> > For ease of understanding, I would prefer to write it as:
> > 
> >                   get_random = trusted_key_sources[i].ops->get_random ?:
> >                                          kernel_get_random;
> >                   if (trusted_kernel_rng)
> >                         get_random = kernel_get_random;
> > 
> > With that:
> > 
> > Acked-by: Sumit Garg <sumit.garg@linaro.org>
> 
> I don't think it improves readability to split up the conditional.
> At least I need to take a second pass over the code to understand
> the second conditional.

Ternary operators are pain to read, unless a super trivial case.

I'd stick to what you did.

/Jarkko
