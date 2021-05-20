Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9890638AF68
	for <lists+linux-integrity@lfdr.de>; Thu, 20 May 2021 14:59:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242438AbhETNAO (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 20 May 2021 09:00:14 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:53953 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243126AbhETM7Q (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 20 May 2021 08:59:16 -0400
Received: from mail-wr1-f51.google.com ([209.85.221.51]) by
 mrelayeu.kundenserver.de (mreue109 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1N5VPg-1lPRVq0GmQ-016uqm; Thu, 20 May 2021 14:57:52 +0200
Received: by mail-wr1-f51.google.com with SMTP id d11so17545188wrw.8;
        Thu, 20 May 2021 05:57:51 -0700 (PDT)
X-Gm-Message-State: AOAM530+yzh3xYPiWG5xSNbtv5b5IgrnFm60ad8exszY0tPIzeEobxKO
        kw42dByODq01ooirNvSZ2rHkOZQcOd2oCyir41k=
X-Google-Smtp-Source: ABdhPJzjF6dsH5HoZqJvsW8Z8vuY/KQcYke0jL+BR2nKnLRzRk59Q8j7MY6u03gtUYt403a0Fz/TtBgmPs8YgE0TcrY=
X-Received: by 2002:a05:6000:18a:: with SMTP id p10mr4175890wrx.99.1621515471669;
 Thu, 20 May 2021 05:57:51 -0700 (PDT)
MIME-Version: 1.0
References: <20210520121347.3467794-1-lee.jones@linaro.org>
In-Reply-To: <20210520121347.3467794-1-lee.jones@linaro.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 20 May 2021 14:56:36 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0VujuG8eU_CEVSvzbk4nAJz8fStedM5eMUrLAr9EJxDQ@mail.gmail.com>
Message-ID: <CAK8P3a0VujuG8eU_CEVSvzbk4nAJz8fStedM5eMUrLAr9EJxDQ@mail.gmail.com>
Subject: Re: [PATCH 00/16] Rid W=1 warnings from Char
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Bob Picco <robert.picco@hp.com>,
        Clemens Ladisch <clemens@ladisch.de>,
        "C. Scott Ananian" <cananian@alumni.princeton.edu>,
        "cs.c" <support.linux@omnikey.com>,
        Dave Safford <safford@watson.ibm.com>,
        David Airlie <airlied@linux.ie>,
        David Woodhouse <dwmw2@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Harald Welte <laforge@gnumonks.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Jerome Glisse <j.glisse@gmail.com>,
        Kanoj Sarcar <kanoj@sgi.com>, Kylene Hall <kjhall@us.ibm.com>,
        Lijun Pan <ljp@linux.ibm.com>,
        "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" 
        <linux-crypto@vger.kernel.org>, linux-integrity@vger.kernel.org,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Matt Mackall <mpm@selenic.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Michael Neuling <mikey@neuling.org>,
        Paul Fulghum <paulkf@microgate.com>,
        Paul Mackerras <paulus@samba.org>,
        Peter Huewe <peterhuewe@gmx.de>,
        Reiner Sailer <sailer@watson.ibm.com>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Thirupathaiah Annapureddy <thiruan@microsoft.com>,
        Tyrel Datwyler <tyreld@linux.ibm.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <uwe@kleine-koenig.org>,
        van Doorn <leendert@watson.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:yvVNwwBycJCIlcrc4BDzcLFDc1s4oGKfJ/oereHaRGVPiNPShLt
 LmFPlyi9rBfchEpG9BFpwl6S2BkePecWMcMGANg828hF8j7GC1t3BCq8kMEyBRWH00cZiLi
 MwnuDW/6Dv25fiBjVzTvPY5VuZfpwF327sAg6NSHoi6CIUOE5efsWATDORoES21ZPGzZmlk
 jknF2Z2lKdDqFgOXhzf6A==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Ihe3XjEbXTo=:6IpCwXHHiTCKoD7LvlI/9N
 Iln0zu5HDMsdj/9n8ymWAHZtAmfhsTubuOrBaucWcZnqI89ca9xDG3/NAp2k1AFXycvz5Fl6U
 iJHC/6fCKPLVaE9DFepdbpFYn4+eH4xa5I69tyJwBpXPVvkYmIDyvd/4SGYVvhnBthUDQQ4hw
 h8ZMOOsEzz2UzOIibwxNxOLohdp3Ou8m46wzwayNQQZqFSD0kiGqYPkiPL6PQYptMR6CTgQTj
 YxNKYiprDaa8Fjay36E41tgH3W62HzCrLr77k5+UYlhR7MPtjkS9wwEMbewG5URRNRf9fSA4l
 zno4e40ghfdFNB6455kWm0RsRtHj9n9pCBi9gAKl5o879z8iKnAwTOz2vBfi/RNgjavTXaWAV
 1UHCc10FpMc27IWIWsxXXsgGwcuQ36Q4UkPG2W+MnfmktU6P5PE1ZqdomBOeM5UlZKyq0QXR4
 DaBfU9vwB6TckUywe1xqn/4sCw8DsIN5oFZ43YbNY9XnWopVDj1Kua0Tv3nTQMHHSZkdy3x2e
 721GSmLd/MUL02OCl3UTm6aFYxC5PYc/YO7kApObryQ+ntqBnS88ovP5/6W1SUeKkzQ8/eiHD
 6Dma10DMNkafG48NowEqxqXdecjbDnIFFIw7UOlKjxf7Dr1tqsu6fmx1KWy25OTLWz67pRGo/
 pCrI=
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, May 20, 2021 at 2:13 PM Lee Jones <lee.jones@linaro.org> wrote:
>
> This set is part of a larger effort attempting to clean-up W=1
> kernel builds, which are currently overwhelmingly riddled with
> niggly little warnings.
>
> Lee Jones (16):
>   char: pcmcia: cm4000_cs: Remove unused variable 'tmp'
>   char: pcmcia: cm4040_cs: Remove unused variable 'uc'
>   char: random: Include header containing our prototypes
>   char: pcmcia: synclink_cs: Fix a bunch of kernel-doc issues
>   char: pcmcia: synclink_cs: Fix a bunch of kernel-doc issues
>   char: applicom: Remove 3 unused variables 'ret' and 2 instances of
>     'byte_reset_it'
>   char: tpm: tpm1-cmd: Fix a couple of misnamed functions
>   char: tpm: tpm_ftpm_tee: Fix a couple of kernel-doc misdemeanours
>   char: agp: backend: Demote some non-conformant kernel-doc headers
>   char: agp: frontend: Include header file containing our prototypes
>   char: agp: via-agp: Remove unused variable 'current_size'
>   char: hpet: Remove unused variable 'm'
>   char: agp: generic: Place braces around optimised out function in if()
>   char: agp: uninorth-agp: Remove unused variable 'size'
>   char: hw_random: pseries-rng: Demote non-conformant kernel-doc header
>   char: mem: Provide local prototype for non-static function

Thanks a lot!

I've looked all the patches now and commented on patches 6 and 16.
With my comments addressed

Reviewed-by: Arnd Bergmann <arnd@arndb.de>

       Arnd
