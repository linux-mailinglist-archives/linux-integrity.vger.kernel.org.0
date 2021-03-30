Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B073C34E224
	for <lists+linux-integrity@lfdr.de>; Tue, 30 Mar 2021 09:27:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231225AbhC3H1F (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 30 Mar 2021 03:27:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230323AbhC3H0z (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 30 Mar 2021 03:26:55 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E3DCC0613DA
        for <linux-integrity@vger.kernel.org>; Tue, 30 Mar 2021 00:26:54 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id w28so1314888lfn.2
        for <linux-integrity@vger.kernel.org>; Tue, 30 Mar 2021 00:26:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=af4hT6RKaQH4UftQDbKN5QPOjXiK86/wlCCe+4hZGdc=;
        b=NUla3ScpKv1xeAWa3oYor1HqrS/QBdHFVbD97Gy2NLtpj6f7l2kc1YuVycA+6xgDsi
         9l7wkk1VeogBBuKyQgr52c9E9XztS56+62DQeXZEzEP9oeFxv1R4pBjtUE5YXoqeUmDR
         ygTmKi3BM6um384QWqUj1HKRFKr64dVReOWoSQ/bOlimMNzeyk8RRDcabaNIj7rZs7CH
         04Rj9WUsZ3jLmC/of9MwmcFN+nNvknx0r5TBXUfW+EsQ459b+GxjLJbw48HFQLRgf2nR
         0j/rJpyVkw6WltmcEO5Sa5tf3UaXGLTHPOoHlWyOe9aVBQi78oClX+hFcLSfXjnPyKj2
         d5HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=af4hT6RKaQH4UftQDbKN5QPOjXiK86/wlCCe+4hZGdc=;
        b=P9c7FPwtgYohREUQKcxcAVwAYBHbVeOeJRzF4UASjRd9qA9lZbdm6rY8wpXl0I5wsz
         tkmSjX5TI0u+LtrULWqdld8eDKmwLMAIE+JuxgOAVWVyPwOj6uObNm3BWZTYLkiBNaLW
         Vb7iPqhEwbMpZkdS+S0evlDkJSHYq70Ar54VKKmChW98/ZJMs6VINtrnpd2/2pP4uKrH
         Tl4fjbmac5TTFecf4Ntt0f3ZNc67iSBUwY5thTvPmW5J9l3f+KkfK2LpueyNPlod9xpB
         dB4WjGLOFHPdhTLPK5TYhZMsNf+FB9IBq3MIqhpnn3UxWa7Hr6oaYIRa0hUBNyUQ5UUT
         gdpQ==
X-Gm-Message-State: AOAM533gyVvhgmOKKuefrhcRqqNSXe1kJdI+clNuuVr2D+buA8uN2/XL
        Vy9Apuflbv9ksxb2pPvqkp4HUib9Ava+VltKjgwiAg==
X-Google-Smtp-Source: ABdhPJyXpKWyx5s4QOhIBteYopgz9DFHpopC0zHy2O9Ezg9gQDp3fJSR7hC5ck8fwafksnrhlZdfctLsahIPzGz4fGU=
X-Received: by 2002:ac2:5970:: with SMTP id h16mr18009743lfp.108.1617089212472;
 Tue, 30 Mar 2021 00:26:52 -0700 (PDT)
MIME-Version: 1.0
References: <cover.56fff82362af6228372ea82e6bd7e586e23f0966.1615914058.git-series.a.fatoum@pengutronix.de>
 <319e558e1bd19b80ad6447c167a2c3942bdafea2.1615914058.git-series.a.fatoum@pengutronix.de>
 <01e6e13d-2968-0aa5-c4c8-7458b7bde462@nxp.com> <45a9e159-2dcb-85bf-02bd-2993d50b5748@pengutronix.de>
 <f9c0087d299be1b9b91b242f41ac6ef7b9ee3ef7.camel@linux.ibm.com>
 <63dd7d4b-4729-9e03-cd8f-956b94eab0d9@pengutronix.de> <CAFA6WYOw_mQwOUN=onhzb7zCTyYDBrcx0E7C3LRk6nPLAVCWEQ@mail.gmail.com>
 <557b92d2-f3b8-d136-7431-419429f0e059@pengutronix.de> <CAFA6WYNE44=Y7Erfc-xNtOrf7TkJjh+odmYH5vzhEHR6KqBfeQ@mail.gmail.com>
 <6F812C20-7585-4718-997E-0306C4118468@sigma-star.at> <YGDpA4yPWmTWEyx+@kernel.org>
In-Reply-To: <YGDpA4yPWmTWEyx+@kernel.org>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Tue, 30 Mar 2021 12:56:41 +0530
Message-ID: <CAFA6WYPGuyg+OEYU2+FS-uom29yj4AyN5VLwm6MYpX97D0Uy0w@mail.gmail.com>
Subject: Re: [PATCH v1 3/3] KEYS: trusted: Introduce support for NXP
 CAAM-based trusted keys
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     David Gstir <david@sigma-star.at>,
        Ahmad Fatoum <a.fatoum@pengutronix.de>,
        Mimi Zohar <zohar@linux.ibm.com>,
        =?UTF-8?Q?Horia_Geant=C4=83?= <horia.geanta@nxp.com>,
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, 29 Mar 2021 at 01:07, Jarkko Sakkinen <jarkko@kernel.org> wrote:
>
> On Sat, Mar 27, 2021 at 01:41:24PM +0100, David Gstir wrote:
> > Hi!
> >
> > > On 25.03.2021, at 06:26, Sumit Garg <sumit.garg@linaro.org> wrote:
> > >
> > > On Wed, 24 Mar 2021 at 19:37, Ahmad Fatoum <a.fatoum@pengutronix.de> =
wrote:
> > >>
> > >> Hello Sumit,
> > >>
> > >> On 24.03.21 11:47, Sumit Garg wrote:
> > >>> On Wed, 24 Mar 2021 at 14:56, Ahmad Fatoum <a.fatoum@pengutronix.de=
> wrote:
> > >>>>
> > >>>> Hello Mimi,
> > >>>>
> > >>>> On 23.03.21 19:07, Mimi Zohar wrote:
> > >>>>> On Tue, 2021-03-23 at 17:35 +0100, Ahmad Fatoum wrote:
> > >>>>>> On 21.03.21 21:48, Horia Geant=C4=83 wrote:
> > >>>>>>> caam has random number generation capabilities, so it's worth u=
sing that
> > >>>>>>> by implementing .get_random.
> > >>>>>>
> > >>>>>> If the CAAM HWRNG is already seeding the kernel RNG, why not use=
 the kernel's?
> > >>>>>>
> > >>>>>> Makes for less code duplication IMO.
> > >>>>>
> > >>>>> Using kernel RNG, in general, for trusted keys has been discussed
> > >>>>> before.   Please refer to Dave Safford's detailed explanation for=
 not
> > >>>>> using it [1].
> > >>>>
> > >>>> The argument seems to boil down to:
> > >>>>
> > >>>> - TPM RNG are known to be of good quality
> > >>>> - Trusted keys always used it so far
> > >>>>
> > >>>> Both are fine by me for TPMs, but the CAAM backend is new code and=
 neither point
> > >>>> really applies.
> > >>>>
> > >>>> get_random_bytes_wait is already used for generating key material =
elsewhere.
> > >>>> Why shouldn't new trusted key backends be able to do the same thin=
g?
> > >>>>
> > >>>
> > >>> Please refer to documented trusted keys behaviour here [1]. New
> > >>> trusted key backends should align to this behaviour and in your cas=
e
> > >>> CAAM offers HWRNG so we should be better using that.
> > >>
> > >> Why is it better?
> > >>
> > >> Can you explain what benefit a CAAM user would have if the trusted k=
ey
> > >> randomness comes directly out of the CAAM instead of indirectly from
> > >> the kernel entropy pool that is seeded by it?
> > >
> > > IMO, user trust in case of trusted keys comes from trusted keys
> > > backend which is CAAM here. If a user doesn't trust that CAAM would
> > > act as a reliable source for RNG then CAAM shouldn't be used as a
> > > trust source in the first place.
> > >
> > > And I think building user's trust for kernel RNG implementation with
> > > multiple entropy contributions is pretty difficult when compared with
> > > CAAM HWRNG implementation.
> >
> > Generally speaking, I=E2=80=99d say trusting the CAAM RNG and trusting =
in it=E2=80=99s
> > other features are two separate things. However, reading through the CA=
AM
> > key blob spec I=E2=80=99ve got here, CAAM key blob keys (the keys that =
secure a blob=E2=80=99s
> > content) are generated using its internal RNG. So I=E2=80=99d save if t=
he CAAM RNG
> > is insecure, so are generated key blobs. Maybe somebody with more insig=
ht
> > into the CAAM internals can verify that, but I don=E2=80=99t see any po=
int in using
> > the kernel=E2=80=99s RNG as long as we let CAAM generate the key blob k=
eys for us.
>
> Here's my long'ish analysis. Please read it to the end if by ever means
> possible, and apologies, I usually try to keep usually my comms short, bu=
t
> this requires some more meat than the usual.
>
> The Bad News
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> Now that we add multiple hardware trust sources for trusted keys, will
> there ever be a scenario where a trusted key is originally sealed with a
> backing hardware A, unsealed, and resealed with hardware B?
>
> The hardware and vendor neutral way to generate the key material would be
> unconditionally always just the kernel RNG.
>
> CAAM is actually worse than TCG because it's not even a standards body, i=
f
> I got it right. Not a lot but at least a tiny fraction.
>
> This brings an open item in TEE patches: trusted_tee_get_random() is an
> issue in generating kernel material. I would rather replace that with
> kernel RNG *for now*, because the same open question applies also to ARM
> TEE. It's also a single company controlled backing technology.
>
> By all practical means, I do trust ARM TEE in my personal life but this i=
s
> not important.
>
> CAAM *and* TEE backends break the golden rule of putting as little trust =
as
> possible to anything, even not anything weird is clear at sight, as
> security is essentially a game of known unknowns and unknown unknowns.
>
> Unfortunately, TPM trusted keys started this bad security practice, and
> obviously it cannot be fixed without breaking uapi backwards compatibilit=
y.
>
> This leaves me exactly two rational options:
>
> A. Add a patch to remove trusted_tee_get_random() and use kernel RNG
>    instead.
> B. Drop the whole TEE patch set up until I have good reasons to believe
>    that it's the best possible idea ever to use TEE RNG.
>
> Doing does (A) does not disclude of doing (B) later on, if someone some
> day sends a patch with sound reasoning.
>
> It's also good to understand that when some day a vendor D, other than TC=
G,
> CAAM or ARM, comes up, we need to go again this lenghty and messy
> discussion. Now this already puts an already accepted patch set into a
> risk, because by being a responsible maintainer I would have legit reason=
s
> just simply to drop it.
>
> OK, but....
>
> The GOOD News
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> So there's actually option (C) that also fixes the TPM trustd keys issue:
>
> Add a new kernel patch, which:
>
> 1. Adds the use of kernel RNG as a boot option.
> 2. If this boot option is not active, the subsystem will print a warning
>    to klog denoting this.
> 3. Default is of course vendor RNG given the bad design issue in the TPM
>    trusted keys, but the warning in klog will help to address it at least
>    a bit.
> 4. Document all this to Documentation/security/keys/trusted-encrypted.rst=
.
>
> I'd prefer the choice between A, B and C be concluded rather sooner than
> later.

Option (C) sounds reasonable to me but I would rather prefer an info
message rather than warning as otherwise it would reflect that we are
enforcing kernel RNG choice for a user to trust upon.

-Sumit

>
> /Jarkko
