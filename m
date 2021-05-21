Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B3B938C11F
	for <lists+linux-integrity@lfdr.de>; Fri, 21 May 2021 09:56:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233756AbhEUH6C (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 21 May 2021 03:58:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231301AbhEUH6B (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 21 May 2021 03:58:01 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBA65C061574
        for <linux-integrity@vger.kernel.org>; Fri, 21 May 2021 00:56:37 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id i17so20046908wrq.11
        for <linux-integrity@vger.kernel.org>; Fri, 21 May 2021 00:56:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=ZBzGJGY3Lfdn2lNHI2teoZpXLD66Uih3j/hx8ThIHi4=;
        b=DYK4allmsvbOxhLePej2gQFrRaKHJlch3k0v7mM00MGfmxSAWTMg/3INJhD+1Rc3tU
         9mOKiKUjmwPEf4GRDSP8kNtQuJDR5Y+ZpoiZMFHtiReax+43X/DrDH7OYo0+/5D7/STR
         uRRZGHQQgnENF2IGZZW38nUi3XD0QEUGfclsvQs5VCyM5/Kb9GX/SnyiQU+Y6BIvzFQf
         GX0L5Sgxj9RvgHFJFANgnVk4UYQvTAYi5z4Q5wXF1c4tRGb1sqe9ZeDJ0vXhwCiuZvQK
         yYqwZDP6IcXMQDVHvaLwSV915BV14jdKWLHO0eqPTq1w1tXxRe249C+gWXeC+7JSej3I
         vO8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=ZBzGJGY3Lfdn2lNHI2teoZpXLD66Uih3j/hx8ThIHi4=;
        b=AjP5u3TgtymFJctkVn4NZ/JTE/TdvUysG+Vxtzkd2PntPLiTCDohBOXstQgj4V5mwM
         TJnTGiCvJUigPub5uoQoAP+BdiqLlu6OzVv2EK5RerazPbwS16+fUa2NgVs+9s1M3aK3
         UFvk9UfzcMs5YmfUxMTJUj2z9YXkTweLoh4h95YFwWzM5w3hNb4ZmQQTE4a/gXIveTUE
         0Rk75UYbr8gjqIEZcl2IrU0ysQCzwwt1arBgdwR+xJ7aZ4OAaBuR2QaJ/Edqhx8PPDOq
         Nw/ceEohNvd99DcOKWZv+6ZuIJYDMkF6lXDPMxhhSLaREOOt9SHcDlAJcss50y/vJugg
         qGbA==
X-Gm-Message-State: AOAM532VM7XZOSZEFocYRMU6IDxG4PYZtJaTxfqUa/SebOY4ap6plGkV
        ZWgjXWMZUqWiq2slEujnID2zVg==
X-Google-Smtp-Source: ABdhPJwx8/gIMGjk4t/5kik01FomXtSQYBs+juxRo4HxzZoCKemokseJo7KzkcOXTh/L7jhS9L6uHA==
X-Received: by 2002:adf:f109:: with SMTP id r9mr8360005wro.251.1621583796406;
        Fri, 21 May 2021 00:56:36 -0700 (PDT)
Received: from dell ([91.110.221.215])
        by smtp.gmail.com with ESMTPSA id g11sm1133714wri.59.2021.05.21.00.56.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 May 2021 00:56:35 -0700 (PDT)
Date:   Fri, 21 May 2021 08:56:33 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
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
Message-ID: <20210521075633.GB2549456@dell>
References: <20210520121347.3467794-1-lee.jones@linaro.org>
 <CAK8P3a0VujuG8eU_CEVSvzbk4nAJz8fStedM5eMUrLAr9EJxDQ@mail.gmail.com>
 <20210521072236.GX2549456@dell>
 <YKdkZdvN+uu6lu0g@kroah.com>
 <YKdk2NYHysgTGlRt@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YKdk2NYHysgTGlRt@kroah.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, 21 May 2021, Greg Kroah-Hartman wrote:

> On Fri, May 21, 2021 at 09:42:29AM +0200, Greg Kroah-Hartman wrote:
> > On Fri, May 21, 2021 at 08:22:36AM +0100, Lee Jones wrote:
> > > On Thu, 20 May 2021, Arnd Bergmann wrote:
> > > 
> > > > On Thu, May 20, 2021 at 2:13 PM Lee Jones <lee.jones@linaro.org> wrote:
> > > > >
> > > > > This set is part of a larger effort attempting to clean-up W=1
> > > > > kernel builds, which are currently overwhelmingly riddled with
> > > > > niggly little warnings.
> > > > >
> > > > > Lee Jones (16):
> > > > >   char: pcmcia: cm4000_cs: Remove unused variable 'tmp'
> > > > >   char: pcmcia: cm4040_cs: Remove unused variable 'uc'
> > > > >   char: random: Include header containing our prototypes
> > > > >   char: pcmcia: synclink_cs: Fix a bunch of kernel-doc issues
> > > > >   char: pcmcia: synclink_cs: Fix a bunch of kernel-doc issues
> > > > >   char: applicom: Remove 3 unused variables 'ret' and 2 instances of
> > > > >     'byte_reset_it'
> > > > >   char: tpm: tpm1-cmd: Fix a couple of misnamed functions
> > > > >   char: tpm: tpm_ftpm_tee: Fix a couple of kernel-doc misdemeanours
> > > > >   char: agp: backend: Demote some non-conformant kernel-doc headers
> > > > >   char: agp: frontend: Include header file containing our prototypes
> > > > >   char: agp: via-agp: Remove unused variable 'current_size'
> > > > >   char: hpet: Remove unused variable 'm'
> > > > >   char: agp: generic: Place braces around optimised out function in if()
> > > > >   char: agp: uninorth-agp: Remove unused variable 'size'
> > > > >   char: hw_random: pseries-rng: Demote non-conformant kernel-doc header
> > > > >   char: mem: Provide local prototype for non-static function
> > > > 
> > > > Thanks a lot!
> > > > 
> > > > I've looked all the patches now and commented on patches 6 and 16.
> > > > With my comments addressed
> > > > 
> > > > Reviewed-by: Arnd Bergmann <arnd@arndb.de>
> > > 
> > > Thanks Arnd.
> > > 
> > > Would it be possible for the remaining 14 patches to be taken in
> > > please?  I will work on the 2 Arnd commented on in due course and
> > > resubmit them independently.
> > 
> > Yes, I can queue them up, thanks.
> 
> Wait, I can take the ones for code that I maintain, not for others.
> drivers/char/ is "fun" in that some subdirs have active
> trees/maintainers that are not me and Arnd so they go to Linus through
> other ways.  I'll queue up the ones that I am "allowed" to and you will
> get the emails from that.

Understood, thanks.

Hopefully the other maintainers will be as on the ball as you are.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
