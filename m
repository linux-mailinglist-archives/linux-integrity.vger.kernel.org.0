Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B205E3518BC
	for <lists+linux-integrity@lfdr.de>; Thu,  1 Apr 2021 19:49:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236776AbhDARrW (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 1 Apr 2021 13:47:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234458AbhDARmp (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 1 Apr 2021 13:42:45 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5C22C05BD15
        for <linux-integrity@vger.kernel.org>; Thu,  1 Apr 2021 05:55:16 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id u10so2133599lju.7
        for <linux-integrity@vger.kernel.org>; Thu, 01 Apr 2021 05:55:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VIk1VyBFqF5fVZFBu0yexXHYaS9Jn30Rld7o2bVbBwk=;
        b=Apd+UzHEAEi98S6OdfucHkNROZU7jCgX5/KNygYU3cVOLmi2PHXIN8LRL/INjJMZT2
         +T7sbpkA1dHoI5hc7fww5ba5aE2TjM8dwGwwufSllGQiwylrGI0cS488JL/xNibDw5Cu
         2+eknYxHVIfteXbHDfVGnwtETKC61+6Ys9Q59Y5+NreZIXf3O8ek1f6nwiPeAZ31FLYx
         JP07cdx8Lht2U45g70INCV2MprWQgxaOUq4Y3uGF3LwH7J/nRfQOjuLD03XeTBhbnZ3w
         3kGM/AEkbnuu9X/oEc2B9w4enaBqVfgrhZYb3ySlCRAGSvA6qD8rW+w9ga1FZsJLnIXC
         z8Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VIk1VyBFqF5fVZFBu0yexXHYaS9Jn30Rld7o2bVbBwk=;
        b=cprygHjROCdR3Rc21SaHr2He/B/pMjKzlPsASg2uRelNy+KTLXVr2T5kXVGw4ef0Bq
         gmgFH7n5vOtLCuyu455KFlmi91G71ahVON3KoT0UrZcemmRwaEF52D63jGFcRISOqTkJ
         iMrSUAyYGT2vgF01kknmmvx86RZRcHs+KtVUODuMSB23OXjHKa8TDesRoAMAG9y2THaI
         lC15dmnYfyoPYj4ygADRMe9zzDKH1Nqd5ym48jfcTKQUkkRg1hRULpxTfQBxochEJfLT
         ee6wRgJRMgyXQfc1EfR3cFWvjGARL85UtAI+EwFlNwu+7zG7Y5ScSHojNwuJLVR5iiaP
         XgkQ==
X-Gm-Message-State: AOAM533qCAYjdc6JmAjCGb2s3ib8vipczIJ7Cfvrgopl5vNndnKCtn7q
        rmgVvhzCOGd1NaRipWLPOcfCHutwFhyehNfq4uJfxg==
X-Google-Smtp-Source: ABdhPJzxwz2LDe0yIeonE1iDSI5e5lDG4mIYMjWxL+WfT+GgrPcNFOKL6OGonaimUeBpqxqGZ9SE9Ng/p3VJVcrOnEs=
X-Received: by 2002:a2e:8e33:: with SMTP id r19mr5136316ljk.40.1617281715310;
 Thu, 01 Apr 2021 05:55:15 -0700 (PDT)
MIME-Version: 1.0
References: <cover.56fff82362af6228372ea82e6bd7e586e23f0966.1615914058.git-series.a.fatoum@pengutronix.de>
 <CAFLxGvzWLje+_HFeb+hKNch4U1f5uypVUOuP=QrEPn_JNM+scg@mail.gmail.com>
 <ca2a7c17-3ed0-e52f-2e2f-c0f8bbe10323@pengutronix.de> <CAFLxGvwNomKOo3mQLMxYGDA8T8zN=Szpo2q5jrp4D1CaMHydWA@mail.gmail.com>
In-Reply-To: <CAFLxGvwNomKOo3mQLMxYGDA8T8zN=Szpo2q5jrp4D1CaMHydWA@mail.gmail.com>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Thu, 1 Apr 2021 18:25:03 +0530
Message-ID: <CAFA6WYO29o73nSg4ikU9cyaOr0kpaXFJpcGLGmFLgjKQWchcEg@mail.gmail.com>
Subject: Re: [PATCH v1 0/3] KEYS: trusted: Introduce support for NXP
 CAAM-based trusted keys
To:     Richard Weinberger <richard.weinberger@gmail.com>
Cc:     Ahmad Fatoum <a.fatoum@pengutronix.de>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        =?UTF-8?Q?Horia_Geant=C4=83?= <horia.geanta@nxp.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Aymen Sghaier <aymen.sghaier@nxp.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        James Bottomley <jejb@linux.ibm.com>, kernel@pengutronix.de,
        David Howells <dhowells@redhat.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Steffen Trumtrar <s.trumtrar@pengutronix.de>,
        Udit Agarwal <udit.agarwal@nxp.com>,
        Jan Luebbe <j.luebbe@pengutronix.de>,
        David Gstir <david@sigma-star.at>,
        Franck LENORMAND <franck.lenormand@nxp.com>,
        linux-integrity@vger.kernel.org,
        "open list:ASYMMETRIC KEYS" <keyrings@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        LSM <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Richard,

On Wed, 31 Mar 2021 at 03:34, Richard Weinberger
<richard.weinberger@gmail.com> wrote:
>
> Ahmad,
>
> On Wed, Mar 17, 2021 at 3:08 PM Ahmad Fatoum <a.fatoum@pengutronix.de> wrote:
> >     keyctl add trusted $KEYNAME "load $(cat ~/kmk.blob)" @s
>
> Is there a reason why we can't pass the desired backend name in the
> trusted key parameters?
> e.g.
> keyctl add trusted $KEYNAME "backendtype caam load $(cat ~/kmk.blob)" @s
>

IIUC, this would require support for multiple trusted keys backends at
runtime but currently the trusted keys subsystem only supports a
single backend which is selected via kernel module parameter during
boot.

So the trusted keys framework needs to evolve to support multiple
trust sources at runtime but I would like to understand the use-cases
first. IMO, selecting the best trust source available on a platform
for trusted keys should be a one time operation, so why do we need to
have other backends available at runtime as well?

-Sumit

> --
> Thanks,
> //richard
