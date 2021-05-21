Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A319938C0D8
	for <lists+linux-integrity@lfdr.de>; Fri, 21 May 2021 09:42:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233174AbhEUHny (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 21 May 2021 03:43:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:34720 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232255AbhEUHny (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 21 May 2021 03:43:54 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 493D761163;
        Fri, 21 May 2021 07:42:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1621582951;
        bh=cnSCVJ7/n3My2yNLmHEPhkdhOVoAxhx7WZMlAs//3PA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hu+Rh4Hf52BJ4jFmOSPsfQxgKn3SMltfq6bu3pu6JJXJAonQZFaKt6RWkAEotk3yB
         HPDhmwRSkaC6rmeSoQKGv89CmYJdQ7O0gvnIVQRkw4Y3kUwNcnPtr9VRWlx0RWUbMJ
         EMtB2LF/XHn3wJtnaiV+QhzKvTBu+xzBeT7Ioibs=
Date:   Fri, 21 May 2021 09:42:29 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Bob Picco <robert.picco@hp.com>,
        Clemens Ladisch <clemens@ladisch.de>,
        "C. Scott Ananian" <cananian@alumni.princeton.edu>,
        "cs.c" <support.linux@omnikey.com>,
        Dave Safford <safford@watson.ibm.com>,
        David Airlie <airlied@linux.ie>,
        David Woodhouse <dwmw2@infradead.org>,
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
Message-ID: <YKdkZdvN+uu6lu0g@kroah.com>
References: <20210520121347.3467794-1-lee.jones@linaro.org>
 <CAK8P3a0VujuG8eU_CEVSvzbk4nAJz8fStedM5eMUrLAr9EJxDQ@mail.gmail.com>
 <20210521072236.GX2549456@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210521072236.GX2549456@dell>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, May 21, 2021 at 08:22:36AM +0100, Lee Jones wrote:
> On Thu, 20 May 2021, Arnd Bergmann wrote:
> 
> > On Thu, May 20, 2021 at 2:13 PM Lee Jones <lee.jones@linaro.org> wrote:
> > >
> > > This set is part of a larger effort attempting to clean-up W=1
> > > kernel builds, which are currently overwhelmingly riddled with
> > > niggly little warnings.
> > >
> > > Lee Jones (16):
> > >   char: pcmcia: cm4000_cs: Remove unused variable 'tmp'
> > >   char: pcmcia: cm4040_cs: Remove unused variable 'uc'
> > >   char: random: Include header containing our prototypes
> > >   char: pcmcia: synclink_cs: Fix a bunch of kernel-doc issues
> > >   char: pcmcia: synclink_cs: Fix a bunch of kernel-doc issues
> > >   char: applicom: Remove 3 unused variables 'ret' and 2 instances of
> > >     'byte_reset_it'
> > >   char: tpm: tpm1-cmd: Fix a couple of misnamed functions
> > >   char: tpm: tpm_ftpm_tee: Fix a couple of kernel-doc misdemeanours
> > >   char: agp: backend: Demote some non-conformant kernel-doc headers
> > >   char: agp: frontend: Include header file containing our prototypes
> > >   char: agp: via-agp: Remove unused variable 'current_size'
> > >   char: hpet: Remove unused variable 'm'
> > >   char: agp: generic: Place braces around optimised out function in if()
> > >   char: agp: uninorth-agp: Remove unused variable 'size'
> > >   char: hw_random: pseries-rng: Demote non-conformant kernel-doc header
> > >   char: mem: Provide local prototype for non-static function
> > 
> > Thanks a lot!
> > 
> > I've looked all the patches now and commented on patches 6 and 16.
> > With my comments addressed
> > 
> > Reviewed-by: Arnd Bergmann <arnd@arndb.de>
> 
> Thanks Arnd.
> 
> Would it be possible for the remaining 14 patches to be taken in
> please?  I will work on the 2 Arnd commented on in due course and
> resubmit them independently.

Yes, I can queue them up, thanks.

greg k-h
