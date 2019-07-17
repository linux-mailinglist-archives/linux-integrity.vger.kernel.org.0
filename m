Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 635C86C112
	for <lists+linux-integrity@lfdr.de>; Wed, 17 Jul 2019 20:36:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388725AbfGQSgs (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 17 Jul 2019 14:36:48 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:39913 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727446AbfGQSgs (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 17 Jul 2019 14:36:48 -0400
Received: by mail-qt1-f196.google.com with SMTP id l9so24417210qtu.6
        for <linux-integrity@vger.kernel.org>; Wed, 17 Jul 2019 11:36:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=SSKZa6Us7cCnh0Xx6N0rrk3Uo1FNKkBPCZAzeKIzLoM=;
        b=dy15OmpyuVkVLIL85AO3BUY2xBLXfKYWfW9PVnw411iTqoykNswF8yx5hKFHfIZtz8
         9WwURoA145HAEF3JL+33oS7bLB4BhMp9GSr5+gtia9HSRgzfouP0DuJsDl3vGYr6479p
         DMcpUI2iqztNCKp7dXHSQfJonLthM0ssJy+bqYqUxfmJ7oC+YbNwKAM2IU/jnDSdKp3t
         iZ4Oy3vW3orUKrMfjJP7k7Is/CyVeB3jlczhj11jdvkwCzU0phq0bbkUULkq1DkD3pcu
         ya/rM2uz/JHPHfcIgtlVmaEVeLEwY/TTxhzljsfYOiFp6cA8Pc6e2hMyGZYc/OB0ZzXW
         fIvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=SSKZa6Us7cCnh0Xx6N0rrk3Uo1FNKkBPCZAzeKIzLoM=;
        b=UzhH50j8uNXME+8dF7+u39XsgwSCITenCgbF0ls5iUvcryH+vOTpPRKVF1vWxdXToi
         mqrHkXR+nuDpkkynjkjOwxAZgYZu4bnnW3lmRH5wd5BhG2RX1whuQt0oC9zGWAImTXNk
         hA+ybCT/h6TnrPrwqFsD+fMtCyhUAKob0CNtAZZDoQCV5LlVDb8vcX+3N00lZ7Lt2s4a
         YXXaUnWvVrYLISwMo6cV9opbzePjAWi7TwnH4M5YhgCTCQL3YTJn3+KQQu7P9ZR3cT2x
         wb9NuA1d+MrXRXt+JKWeLYDmysnKZaB4IPvyyl18nhxVA0kJGlE3P95uSNMefkeApaMY
         baew==
X-Gm-Message-State: APjAAAVXcMsBDLtVpJVX0ot3klXkRsqJRfbD2F0ZgfD3HtLcURCzarwW
        18U3pVHyjB8o7Uqk7hwigK0Vsg==
X-Google-Smtp-Source: APXvYqzntA3lbzPxuz197IzATj+vlzc/f3fvk57/e3CZjIw28/6w10ef2ol2px+7J/NIHW1NaDh8RQ==
X-Received: by 2002:a0c:ae24:: with SMTP id y33mr29988815qvc.106.1563388606713;
        Wed, 17 Jul 2019 11:36:46 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id 47sm14978551qtw.90.2019.07.17.11.36.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 17 Jul 2019 11:36:46 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hnonF-00068G-Dr; Wed, 17 Jul 2019 15:36:45 -0300
Date:   Wed, 17 Jul 2019 15:36:45 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Guenter Roeck <groeck@google.com>
Cc:     Stephen Boyd <swboyd@chromium.org>,
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
Subject: Re: [PATCH v2 5/6] tpm: add driver for cr50 on SPI
Message-ID: <20190717183645.GM12119@ziepe.ca>
References: <f824e3ab-ae2f-8c2f-549a-16569b10966e@infineon.com>
 <20190717122558.GF12119@ziepe.ca>
 <5d2f51a7.1c69fb81.6495.fbe8@mx.google.com>
 <20190717165628.GJ12119@ziepe.ca>
 <5d2f5570.1c69fb81.f3832.3c3f@mx.google.com>
 <20190717171216.GK12119@ziepe.ca>
 <5d2f594d.1c69fb81.baadd.d81d@mx.google.com>
 <20190717172544.GL12119@ziepe.ca>
 <5d2f671b.1c69fb81.59c84.dec9@mx.google.com>
 <CABXOdTfh5iz3FnkRxZ=ggPNvmegz4_1gRaEPAq-9V=eNcEJPmw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABXOdTfh5iz3FnkRxZ=ggPNvmegz4_1gRaEPAq-9V=eNcEJPmw@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Jul 17, 2019 at 11:30:42AM -0700, Guenter Roeck wrote:
> On Wed, Jul 17, 2019 at 11:21 AM Stephen Boyd <swboyd@chromium.org> wrote:
> >
> > Quoting Jason Gunthorpe (2019-07-17 10:25:44)
> > > On Wed, Jul 17, 2019 at 10:22:20AM -0700, Stephen Boyd wrote:
> > > > Quoting Jason Gunthorpe (2019-07-17 10:12:16)
> > > > > On Wed, Jul 17, 2019 at 10:05:52AM -0700, Stephen Boyd wrote:
> > > > > >
> > > > > > Yes. The space savings comes from having the extra module 'cr50.ko' that
> > > > > > holds almost nothing at all when the two drivers are modules.
> > > > >
> > > > > I'm not sure it is an actual savings, there is alot of minimum
> > > > > overhead and alignment to have a module in the first place.
> > > > >
> > > >
> > > > Yeah. I'm pretty sure that's why it's a bool and not a tristate for this
> > > > symbol. A module has overhead that is not necessary for these little
> > > > helpers.
> > >
> > > Linking driver stuff like that to the kernel is pretty hacky, IMHO
> > >
> >
> > So combine lines?
> >
> >         obj-$(CONFIG_...) += cr50.o cr50_spi.o
> >
> > Sounds great.
> >
> 
> Please keep in mind that cr50.c exports symbols. If cr50.o is added to
> two modules, those symbols will subsequently available from both
> modules. To avoid that, you might want to consider removing the
> EXPORT_SYMBOL() declarations from cr50.c.

Yep

> I don't know what happens if those two modules are both built into the
> kernel (as happens, for example, with allyesconfig). Does the linker
> try to load cr50.o twice, resulting in duplicate symbols ?

Hum. Looks like it uses --whole-archive here and would probably
break? Maybe not, hns recently sent a patch doing this, but maybe they
never tested it too.

Jason
