Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4136538C0A4
	for <lists+linux-integrity@lfdr.de>; Fri, 21 May 2021 09:23:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235729AbhEUHY0 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 21 May 2021 03:24:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230427AbhEUHYQ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 21 May 2021 03:24:16 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1273EC061763
        for <linux-integrity@vger.kernel.org>; Fri, 21 May 2021 00:22:41 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id u133so10532107wmg.1
        for <linux-integrity@vger.kernel.org>; Fri, 21 May 2021 00:22:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=Ue4q25tfYI5RxLcBXPlMjiSrTwgCV0DfcVN25afL2bA=;
        b=zxBkF2RpmykF6ze5xWEoQ0Sr0EVVAWgufL4N4uYCEfvvr/9dBYRwNyhiILH7xolYIM
         mUMpEc0xXBJpplnd2Ws45Umks7zwOxUWKpLSks7U3bsdswos3yo/TMqCb97EECv4oO9i
         nPR3MbzV+M8Ol9Hmhi9U7j556tKkgEURhOKEJ/ZmzIh4muKbO6krDSxmt3Mv2RYCjfFw
         SNhb3NzpB5FQ50Ylct/Z3K/asq2FOTFjZf9FGqtQMB038gZT8Vu7p5RSiGdzGms2OD8X
         yPYCJ7kZe/aC4GAdyvCUeySQ3fymFp3DS+oe58blNwY5pF5JgI3E7v419huXJyQo0bbH
         XGvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Ue4q25tfYI5RxLcBXPlMjiSrTwgCV0DfcVN25afL2bA=;
        b=snFsHl7w2p1SP6VPLBRlzxJoWHfbIWeyha7RuYzBGvNtAtEkKvgbBUH9YaAMNNmcRs
         1pYopCY/mFxHglUJGpZGTGDCNrk7EK53nalgfqvHAGHkXv/tc+NaDbeyF09El+cxphrZ
         zpvQ26YCtGzPnoMaqNy9Yegm9ivJcUwlW0HcNXVx5ZPQ4yyA6RRshrU4/LyvjiVPqcBO
         AHFp+SBRmXJAKo1VQfrHMovfm5i2X7A/Ju6vzChZd6JWSkWcOuBhov5iXeKsIPIZfpYd
         Bbkb05oVBh//YzdDl/xp9+E57pu7BVLtuszZReDwNT4my8QbhyTXTKrLMHHMB4wFYfxd
         Yrjg==
X-Gm-Message-State: AOAM5314BDtEBTeRdaQ7Z2cw/qrUm3k/KSMRAP+5eA1uvZnVEAr83s5G
        zqwyUWFXJe6g3bFjXzms0gwfZA==
X-Google-Smtp-Source: ABdhPJzAs4JWDKxcLcuodJXaj7alnXNl7eWaJK+ZI+9Sb3ggP4ft8Mue6yj3TwDmFJ/1VFJt4AdOjA==
X-Received: by 2002:a1c:2985:: with SMTP id p127mr7390963wmp.165.1621581759653;
        Fri, 21 May 2021 00:22:39 -0700 (PDT)
Received: from dell ([91.110.221.215])
        by smtp.gmail.com with ESMTPSA id c15sm1041514wro.21.2021.05.21.00.22.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 May 2021 00:22:39 -0700 (PDT)
Date:   Fri, 21 May 2021 08:22:36 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Arnd Bergmann <arnd@arndb.de>
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
        Theodore Ts'o <tytso@mit.edu>,
        Thirupathaiah Annapureddy <thiruan@microsoft.com>,
        Tyrel Datwyler <tyreld@linux.ibm.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <uwe@kleine-koenig.org>,
        van Doorn <leendert@watson.ibm.com>
Subject: Re: [PATCH 00/16] Rid W=1 warnings from Char
Message-ID: <20210521072236.GX2549456@dell>
References: <20210520121347.3467794-1-lee.jones@linaro.org>
 <CAK8P3a0VujuG8eU_CEVSvzbk4nAJz8fStedM5eMUrLAr9EJxDQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAK8P3a0VujuG8eU_CEVSvzbk4nAJz8fStedM5eMUrLAr9EJxDQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 20 May 2021, Arnd Bergmann wrote:

> On Thu, May 20, 2021 at 2:13 PM Lee Jones <lee.jones@linaro.org> wrote:
> >
> > This set is part of a larger effort attempting to clean-up W=1
> > kernel builds, which are currently overwhelmingly riddled with
> > niggly little warnings.
> >
> > Lee Jones (16):
> >   char: pcmcia: cm4000_cs: Remove unused variable 'tmp'
> >   char: pcmcia: cm4040_cs: Remove unused variable 'uc'
> >   char: random: Include header containing our prototypes
> >   char: pcmcia: synclink_cs: Fix a bunch of kernel-doc issues
> >   char: pcmcia: synclink_cs: Fix a bunch of kernel-doc issues
> >   char: applicom: Remove 3 unused variables 'ret' and 2 instances of
> >     'byte_reset_it'
> >   char: tpm: tpm1-cmd: Fix a couple of misnamed functions
> >   char: tpm: tpm_ftpm_tee: Fix a couple of kernel-doc misdemeanours
> >   char: agp: backend: Demote some non-conformant kernel-doc headers
> >   char: agp: frontend: Include header file containing our prototypes
> >   char: agp: via-agp: Remove unused variable 'current_size'
> >   char: hpet: Remove unused variable 'm'
> >   char: agp: generic: Place braces around optimised out function in if()
> >   char: agp: uninorth-agp: Remove unused variable 'size'
> >   char: hw_random: pseries-rng: Demote non-conformant kernel-doc header
> >   char: mem: Provide local prototype for non-static function
> 
> Thanks a lot!
> 
> I've looked all the patches now and commented on patches 6 and 16.
> With my comments addressed
> 
> Reviewed-by: Arnd Bergmann <arnd@arndb.de>

Thanks Arnd.

Would it be possible for the remaining 14 patches to be taken in
please?  I will work on the 2 Arnd commented on in due course and
resubmit them independently.

TIA.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
