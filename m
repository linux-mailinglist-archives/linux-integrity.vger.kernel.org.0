Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D32216C0F9
	for <lists+linux-integrity@lfdr.de>; Wed, 17 Jul 2019 20:31:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388641AbfGQSaz (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 17 Jul 2019 14:30:55 -0400
Received: from mail-yb1-f196.google.com ([209.85.219.196]:41546 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389001AbfGQSay (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 17 Jul 2019 14:30:54 -0400
Received: by mail-yb1-f196.google.com with SMTP id x188so5477637yba.8
        for <linux-integrity@vger.kernel.org>; Wed, 17 Jul 2019 11:30:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jPbLjCPiukGzfv9R+wh5ohwWe1rNevMdJywRbomHOx4=;
        b=M+uzGO6fQ/CMTI1Il9QcFoHxa6eM4ezURly5vVITUcaslnhew6+OR5+JSQXmFamV3y
         2/mzPhHBCFCtUuwlAGSHj6L1WFlAteND+qMX2fE5pqAT/oM+kmgSIHiiN+Lop8u04TQj
         9TFAY6WFKTz09qnT3CcAylyUcMHJtniGv/M09Z/XwufzVjxl13ueDDfxgeMXinMHpklv
         mq90btak5ZyYZQLbCeEPOpuHaz5j9DvB4iLWViVLlwms1oyeIJleDIauV53gZBcGW4V8
         ab1UtO3jSYscVBq/MnqPkA8vOP/Nb4/7YTYLjQXXStdhcp8IUx1z2P383EDoPcBYAEva
         UP5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jPbLjCPiukGzfv9R+wh5ohwWe1rNevMdJywRbomHOx4=;
        b=OxuhDjGEanzCe7nNPPZ+5W9o6uzz7URBk6heKWNutS91pC5Pfu1mV6763Gcurep9s0
         M14q0HV8DY0LKsdWzdADvtlAUwpONrSnaI+sbDJUW2k9hVkHiOinKkchEBBIcbOXf98C
         hxZD8WvFQyE7axpSd7Tzy0iYMMINiMd7sY8o+ni9f3e3gcfeynbfORJXwa3ex6FbRsw6
         Y5wM5xpZZR76J3DzDsT/gLEJmmsdtseUbuLueJLiBnqzC55+C7nqbtwzmY+51GoqfFLK
         +Q7B87jron6QNvmcIdyYYZsuUtxsgmmmsoe3BpKa0PcjJcfQlUB3p1S2gJOhvXOLS1ed
         +8fA==
X-Gm-Message-State: APjAAAUGydu4IEF0jRP+vtRXIkGBJVIeRrRHuEt+cChguiTkMuNBlcPL
        8mLnYxrZ4qtHTVk3jvIuyWXx7DFPsut1bwxBHTwVsw==
X-Google-Smtp-Source: APXvYqxHDm/BVXAHW+g+yJHBAd9A4J3Au6omNUsWJeXSLPTWdz0ELdvuwmJz+UB46bvtz9xHfXZE3OKy6aTOLhUOBu8=
X-Received: by 2002:a25:9d82:: with SMTP id v2mr24759988ybp.226.1563388253765;
 Wed, 17 Jul 2019 11:30:53 -0700 (PDT)
MIME-Version: 1.0
References: <20190716224518.62556-1-swboyd@chromium.org> <20190716224518.62556-6-swboyd@chromium.org>
 <f824e3ab-ae2f-8c2f-549a-16569b10966e@infineon.com> <20190717122558.GF12119@ziepe.ca>
 <5d2f51a7.1c69fb81.6495.fbe8@mx.google.com> <20190717165628.GJ12119@ziepe.ca>
 <5d2f5570.1c69fb81.f3832.3c3f@mx.google.com> <20190717171216.GK12119@ziepe.ca>
 <5d2f594d.1c69fb81.baadd.d81d@mx.google.com> <20190717172544.GL12119@ziepe.ca>
 <5d2f671b.1c69fb81.59c84.dec9@mx.google.com>
In-Reply-To: <5d2f671b.1c69fb81.59c84.dec9@mx.google.com>
From:   Guenter Roeck <groeck@google.com>
Date:   Wed, 17 Jul 2019 11:30:42 -0700
Message-ID: <CABXOdTfh5iz3FnkRxZ=ggPNvmegz4_1gRaEPAq-9V=eNcEJPmw@mail.gmail.com>
Subject: Re: [PATCH v2 5/6] tpm: add driver for cr50 on SPI
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>,
        Alexander Steffen <Alexander.Steffen@infineon.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Andrey Pronin <apronin@chromium.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-integrity@vger.kernel.org,
        Duncan Laurie <dlaurie@chromium.org>,
        Guenter Roeck <groeck@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Jul 17, 2019 at 11:21 AM Stephen Boyd <swboyd@chromium.org> wrote:
>
> Quoting Jason Gunthorpe (2019-07-17 10:25:44)
> > On Wed, Jul 17, 2019 at 10:22:20AM -0700, Stephen Boyd wrote:
> > > Quoting Jason Gunthorpe (2019-07-17 10:12:16)
> > > > On Wed, Jul 17, 2019 at 10:05:52AM -0700, Stephen Boyd wrote:
> > > > >
> > > > > Yes. The space savings comes from having the extra module 'cr50.ko' that
> > > > > holds almost nothing at all when the two drivers are modules.
> > > >
> > > > I'm not sure it is an actual savings, there is alot of minimum
> > > > overhead and alignment to have a module in the first place.
> > > >
> > >
> > > Yeah. I'm pretty sure that's why it's a bool and not a tristate for this
> > > symbol. A module has overhead that is not necessary for these little
> > > helpers.
> >
> > Linking driver stuff like that to the kernel is pretty hacky, IMHO
> >
>
> So combine lines?
>
>         obj-$(CONFIG_...) += cr50.o cr50_spi.o
>
> Sounds great.
>

Please keep in mind that cr50.c exports symbols. If cr50.o is added to
two modules, those symbols will subsequently available from both
modules. To avoid that, you might want to consider removing the
EXPORT_SYMBOL() declarations from cr50.c.

I don't know what happens if those two modules are both built into the
kernel (as happens, for example, with allyesconfig). Does the linker
try to load cr50.o twice, resulting in duplicate symbols ?

Guenter
