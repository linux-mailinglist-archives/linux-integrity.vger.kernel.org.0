Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F2A43B7A7C
	for <lists+linux-integrity@lfdr.de>; Wed, 30 Jun 2021 00:41:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235427AbhF2Wna (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 29 Jun 2021 18:43:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235149AbhF2Wna (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 29 Jun 2021 18:43:30 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3A3AC061760;
        Tue, 29 Jun 2021 15:41:01 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id x16so571716pfa.13;
        Tue, 29 Jun 2021 15:41:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=P+tvoezemK7sRfCs8ijjTjFf88uwIw3vayGLLc42vlI=;
        b=SIfctPZHI0xI5w5+zG5kXj3dKKDp2neIvQdMyhAIrxHZXJeLEsrh0xzaDiku+igNwJ
         SjlGSRLIyEs5ZY/qGXYqtYEpj6QBL0s4+BGoDiXJhSoxm8jghFxx8ET+DlyOzg08EigO
         Jw+jFzIdtl8qZtM8kobz/M5oQ8pwTqWaNgFYwWWSYAhcIxfwvrds68VEUP2LWaKdpi9p
         uE1FLvgQLkswsNkfS7vAoNPkdjUUosPotUUFAqn0hkBhpGP49VO7Eo+y52hlQtvt24R6
         5Sx7nguXSiGxnqN+hZLt05msZgmxDPdLOxxsDj1XhMj5H3/6k7qhU2GJYgOhOHne1pcJ
         z1Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=P+tvoezemK7sRfCs8ijjTjFf88uwIw3vayGLLc42vlI=;
        b=C3Ovujr7d3evmi9uduV/g07evZujxIheNOxZKWQ699dPMVXgVFn2GtltdruKY/qqs7
         Hlh4ClIIZCAuaITGc4hzuGdkehIsqubgY3oWcbJQB0un+CT8czTlLtAxs8DfizKX5Evg
         EkRlOAreDaX5qZphYzLIEKvnEFSMexUu1DRQN+vxi/6o35Tt13VBzREMu5kPI1D/HINF
         nghJ2y/detaWdF45g07NRy27TDonoAYCL1BNCZYKz7HVzKXoorGTRrSIHRZzrprOSNxQ
         EwwWt/Woh6r5aNBiHHLpIDC6E3pMysRUJ8ZjnQYsELXsO0oeaZe75SXM/maNpWxh2LB1
         66qw==
X-Gm-Message-State: AOAM532EcdrVqZaXOtfpE/WSkf1B1xyX+jmkooYrGMDo9lj3DMqqxtBu
        LUBci141Uu3KfOejs8ogZjqUsfekK5YsGijs6KM=
X-Google-Smtp-Source: ABdhPJxIl8Vocc3Fb9/z6Xj8wolKdcTBXZA1v0f0l4OzmpcqdqRIIrAGt9qZj79bYAaxmwTKdGIhxyX3PrjKOPIhmrQ=
X-Received: by 2002:a63:7d5:: with SMTP id 204mr4414226pgh.309.1625006461498;
 Tue, 29 Jun 2021 15:41:01 -0700 (PDT)
MIME-Version: 1.0
References: <20210629135050.GA1373@raspberrypi> <fe6c853842425e675024731525e0f244da368e8e.camel@linux.ibm.com>
In-Reply-To: <fe6c853842425e675024731525e0f244da368e8e.camel@linux.ibm.com>
From:   Austin Kim <austindh.kim@gmail.com>
Date:   Wed, 30 Jun 2021 07:40:50 +0900
Message-ID: <CADLLry5D9T_icTSGOggb=3vJqYq9Qvq-WEhmfgJMCSGuPV0AAg@mail.gmail.com>
Subject: Re: [PATCH] IMA: remove -Wmissing-prototypes warning
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     dmitry.kasatkin@gmail.com, James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        =?UTF-8?B?6rmA64+Z7ZiE?= <austin.kim@lge.com>,
        Petko Manolov <petkan@mip-labs.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

2021=EB=85=84 6=EC=9B=94 29=EC=9D=BC (=ED=99=94) =EC=98=A4=ED=9B=84 11:30, =
Mimi Zohar <zohar@linux.ibm.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> [Cc: Petko Manolov <petkan@mip-labs.com>]
>
> Hi Austin,
>
> On Tue, 2021-06-29 at 14:50 +0100, Austin Kim wrote:
> > From: Austin Kim <austin.kim@lge.com>
> >
> > With W=3D1 build, the compiler throws warning message as below:
> >
> >    security/integrity/ima/ima_mok.c:24:12: warning:
> >    no previous prototype for =E2=80=98ima_mok_init=E2=80=99 [-Wmissing-=
prototypes]
> >        __init int ima_mok_init(void)
> >
> > Silence the warning by adding static keyword to ima_mok_init().
> >
> > Signed-off-by: Austin Kim <austin.kim@lge.com>
> > ---
> >  security/integrity/ima/ima_mok.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/security/integrity/ima/ima_mok.c b/security/integrity/ima/=
ima_mok.c
> > index 1e5c01916173..95cc31525c57 100644
> > --- a/security/integrity/ima/ima_mok.c
> > +++ b/security/integrity/ima/ima_mok.c
> > @@ -21,7 +21,7 @@ struct key *ima_blacklist_keyring;
> >  /*
> >   * Allocate the IMA blacklist keyring
> >   */
> > -__init int ima_mok_init(void)
> > +static __init int ima_mok_init(void)
> >  {
> >       struct key_restriction *restriction;
> >
>
> Thank you for the patch, which does fix the warning.   The .ima_mok
> keyring was removed a while ago.  With all the recent work on the
> system blacklist, I'm wondering if anyone is still using the IMA
> blacklist keyring or whether it should be removed as well.

Oh! Thanks for information.

>
> thanks,
>
> Mimi
>
