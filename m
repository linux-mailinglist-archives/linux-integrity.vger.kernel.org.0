Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75C9638C0E7
	for <lists+linux-integrity@lfdr.de>; Fri, 21 May 2021 09:44:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236209AbhEUHpt (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 21 May 2021 03:45:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:36972 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232255AbhEUHpt (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 21 May 2021 03:45:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 56AE661363;
        Fri, 21 May 2021 07:44:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1621583066;
        bh=mXV8OpDIuWhiYxm7jw4lgmPE1yATq9yZoBRDO3DllP4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BgC8YbFKM9zLIvLHPfzYCIfa3pjrxnBwtlp/D+4gG+oVrbYL1EBgreKdhK5e5xsom
         Sgh9pV0LB91AHkeIMoqwoikprgzEfAsJsdqrRISb8BIu2D76PWLgicr3l76fmgqwC7
         zpb/8JcPZ7c+mSbWXARyMkJtZC5lU55qjBAgdUbc=
Date:   Fri, 21 May 2021 09:44:24 +0200
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
Message-ID: <YKdk2NYHysgTGlRt@kroah.com>
References: <20210520121347.3467794-1-lee.jones@linaro.org>
 <CAK8P3a0VujuG8eU_CEVSvzbk4nAJz8fStedM5eMUrLAr9EJxDQ@mail.gmail.com>
 <20210521072236.GX2549456@dell>
 <YKdkZdvN+uu6lu0g@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YKdkZdvN+uu6lu0g@kroah.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, May 21, 2021 at 09:42:29AM +0200, Greg Kroah-Hartman wrote:
> On Fri, May 21, 2021 at 08:22:36AM +0100, Lee Jones wrote:
> > On Thu, 20 May 2021, Arnd Bergmann wrote:
> > 
> > > On Thu, May 20, 2021 at 2:13 PM Lee Jones <lee.jones@linaro.org> wrote:
> > > >
> > > > This set is part of a larger effort attempting to clean-up W=1
> > > > kernel builds, which are currently overwhelmingly riddled with
> > > > niggly little warnings.
> > > >
> > > > Lee Jones (16):
> > > >   char: pcmcia: cm4000_cs: Remove unused variable 'tmp'
> > > >   char: pcmcia: cm4040_cs: Remove unused variable 'uc'
> > > >   char: random: Include header containing our prototypes
> > > >   char: pcmcia: synclink_cs: Fix a bunch of kernel-doc issues
> > > >   char: pcmcia: synclink_cs: Fix a bunch of kernel-doc issues
> > > >   char: applicom: Remove 3 unused variables 'ret' and 2 instances of
> > > >     'byte_reset_it'
> > > >   char: tpm: tpm1-cmd: Fix a couple of misnamed functions
> > > >   char: tpm: tpm_ftpm_tee: Fix a couple of kernel-doc misdemeanours
> > > >   char: agp: backend: Demote some non-conformant kernel-doc headers
> > > >   char: agp: frontend: Include header file containing our prototypes
> > > >   char: agp: via-agp: Remove unused variable 'current_size'
> > > >   char: hpet: Remove unused variable 'm'
> > > >   char: agp: generic: Place braces around optimised out function in if()
> > > >   char: agp: uninorth-agp: Remove unused variable 'size'
> > > >   char: hw_random: pseries-rng: Demote non-conformant kernel-doc header
> > > >   char: mem: Provide local prototype for non-static function
> > > 
> > > Thanks a lot!
> > > 
> > > I've looked all the patches now and commented on patches 6 and 16.
> > > With my comments addressed
> > > 
> > > Reviewed-by: Arnd Bergmann <arnd@arndb.de>
> > 
> > Thanks Arnd.
> > 
> > Would it be possible for the remaining 14 patches to be taken in
> > please?  I will work on the 2 Arnd commented on in due course and
> > resubmit them independently.
> 
> Yes, I can queue them up, thanks.

Wait, I can take the ones for code that I maintain, not for others.
drivers/char/ is "fun" in that some subdirs have active
trees/maintainers that are not me and Arnd so they go to Linus through
other ways.  I'll queue up the ones that I am "allowed" to and you will
get the emails from that.

thanks,

greg k-h
