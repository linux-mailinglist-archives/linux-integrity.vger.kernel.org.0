Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F27E4351A0C
	for <lists+linux-integrity@lfdr.de>; Thu,  1 Apr 2021 20:04:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236157AbhDAR5v (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 1 Apr 2021 13:57:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236461AbhDARya (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 1 Apr 2021 13:54:30 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BEF6C005717
        for <linux-integrity@vger.kernel.org>; Thu,  1 Apr 2021 07:13:02 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id q29so3057199lfb.4
        for <linux-integrity@vger.kernel.org>; Thu, 01 Apr 2021 07:13:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=4LRc5zlX4dmIqJZC4tRXENYZk181mewXwD7X4GEXkKA=;
        b=Vm+Tjv8EGF4ON3BmePiF+an1PklXoMoLGfZKYRESqwWronVx6WRRZIS+F6TP+Lbfr9
         c2fhhAhZk/8su55Y2QryQk7HxxWzqTdDivxWH4tQoshMJgWi+bZJvhsQdFOJrHT3LogF
         ReLuPuqCYkvLIBoIvAIP0KsgTTMVWftEFB2m1jz11/crEDOHsPcdzNSm0vmeT8TittD3
         wxip5yY2IJe+jJ1e9DNffMb2CBHe+fM+0pjqre0pvnviuVjWpxDowfLaDS073O8T2T1r
         S/Tk43FTwPTMksk0XsjA7dB2lZp93arrwSecLvBVeuX60gZ9hxIPny6zhtsP+UkF+xgk
         B/DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=4LRc5zlX4dmIqJZC4tRXENYZk181mewXwD7X4GEXkKA=;
        b=Jh059z72rmnvI0A2fbMvurVw7JqzMzJR7Tf/aIfb40mSPQog79rQ7HxxFnusI8/oer
         YIuzNvqOww9CPJe6x5EupFX18D9NGN/dFwAyZ4rBGcQgUl+dwlRsEXjkh3ahK6YOy092
         YxuUY5H0vU/JRVq98Kb6DzOQfVfdODF+S1U6/9VbyUSv2Ep60ONe0eI89+PPOKB28Cga
         Qgo1xke5rt+awFc+YK03Do/Ib7MGWKzIqRqlWSTWC7g9ffsqkRPQrMuzJCqTBA9BApLg
         1RTlNAiYL1B93g74hhBLAEOFqGLQOAtz4BGSveayQUQHdKnP1KwbKCS0ns+GghD0Glnc
         wRRQ==
X-Gm-Message-State: AOAM530CiIc5LFGOIsx2/Pv2keIP00H/o6CfNnstnt7hM8oqlgTUMAmH
        bnmuad4Vo3P8p32kZsryskG0blF322xwVYPErXRhog==
X-Google-Smtp-Source: ABdhPJyNTkFv6LNWIK5vqvAiZQLpPg75ghn4iKbcqKm1L+mPpFDnlADouEnrSfxrIbDhgL/PNaz27oq5y6nNZioEwVg=
X-Received: by 2002:ac2:5970:: with SMTP id h16mr5350347lfp.108.1617286380737;
 Thu, 01 Apr 2021 07:13:00 -0700 (PDT)
MIME-Version: 1.0
References: <cover.56fff82362af6228372ea82e6bd7e586e23f0966.1615914058.git-series.a.fatoum@pengutronix.de>
 <CAFLxGvzWLje+_HFeb+hKNch4U1f5uypVUOuP=QrEPn_JNM+scg@mail.gmail.com>
 <ca2a7c17-3ed0-e52f-2e2f-c0f8bbe10323@pengutronix.de> <CAFLxGvwNomKOo3mQLMxYGDA8T8zN=Szpo2q5jrp4D1CaMHydWA@mail.gmail.com>
 <CAFA6WYO29o73nSg4ikU9cyaOr0kpaXFJpcGLGmFLgjKQWchcEg@mail.gmail.com>
 <1666035815.140054.1617283065549.JavaMail.zimbra@nod.at> <ea261e53-8f5d-ac52-f3b9-7f2db4532244@pengutronix.de>
 <CAFA6WYODfsMTiCEyFA2aRGm+UQE0OTe-ui7mMSK-cqUR_YJFTA@mail.gmail.com> <1846277009.140163.1617285566823.JavaMail.zimbra@nod.at>
In-Reply-To: <1846277009.140163.1617285566823.JavaMail.zimbra@nod.at>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Thu, 1 Apr 2021 19:42:49 +0530
Message-ID: <CAFA6WYNjS=1JsAPfh=j8D6HUn9rCEADyZxtWvYWuvbz_FsVbTQ@mail.gmail.com>
Subject: Re: [PATCH v1 0/3] KEYS: trusted: Introduce support for NXP
 CAAM-based trusted keys
To:     Richard Weinberger <richard@nod.at>
Cc:     Ahmad Fatoum <a.fatoum@pengutronix.de>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        horia geanta <horia.geanta@nxp.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        aymen sghaier <aymen.sghaier@nxp.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        davem <davem@davemloft.net>,
        James Bottomley <jejb@linux.ibm.com>,
        kernel <kernel@pengutronix.de>,
        David Howells <dhowells@redhat.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Steffen Trumtrar <s.trumtrar@pengutronix.de>,
        Udit Agarwal <udit.agarwal@nxp.com>,
        Jan Luebbe <j.luebbe@pengutronix.de>,
        david <david@sigma-star.at>,
        Franck Lenormand <franck.lenormand@nxp.com>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        "open list, ASYMMETRIC KEYS" <keyrings@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        LSM <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 1 Apr 2021 at 19:29, Richard Weinberger <richard@nod.at> wrote:
>
> Sumit,
>
> ----- Urspr=C3=BCngliche Mail -----
> > Von: "Sumit Garg" <sumit.garg@linaro.org>
> > In this case why would one prefer to use CAAM when you have standards
> > compliant TPM-Chip which additionally offers sealing to specific PCR
> > (integrity measurement) values.
>
> I don't think we can dictate what good/sane solutions are and which are n=
ot.
> Both CAAM and TPM have pros and cons, I don't see why supporting both is =
a bad idea.

I didn't mean to say that supporting both is a bad idea but rather I
was looking for use-cases where one time selection of the best trust
source (whether it be a TPM or TEE or CAAM etc.) for a platform
wouldn't suffice for user needs.

>
> >> > IMHO allowing only one backend at the same time is a little over sim=
plified.
> >>
> >> It is, but I'd rather leave this until it's actually needed.
> >> What can be done now is adopting a format for the exported keys that w=
ould
> >> make this extension seamless in future.
> >>
> >
> > +1
>
> As long we don't make multiple backends at runtime impossible I'm
> fine and will happily add support for it when needed. :-)
>

You are most welcome to add such support. I will be happy to review it.

-Sumit

> Thanks,
> //richard
