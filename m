Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6C8946BC3D
	for <lists+linux-integrity@lfdr.de>; Wed, 17 Jul 2019 14:26:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726081AbfGQM0A (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 17 Jul 2019 08:26:00 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:46269 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725873AbfGQM0A (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 17 Jul 2019 08:26:00 -0400
Received: by mail-qk1-f193.google.com with SMTP id r4so17228243qkm.13
        for <linux-integrity@vger.kernel.org>; Wed, 17 Jul 2019 05:26:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=RKZ3PPWFEXzcKJ2h50KgMAEoCEZWAlMCLSPlgytTa0U=;
        b=Q8tZgQ6ne2wtu8Y5dyZx2Dh+zE6bgW4dMvlxoeKXpUJKhA1FoV0KcTXKrU4OsFlOH4
         i5lgd3951e/igkkhMAKad7Rdptebm0BBjX7T0LzTgqFnBnPvAP5JywNOOyEBRIcXHScf
         kjPek6R0K4KQd0Ph2UPHwaVDI0tOpkylT+w61Wz8bfFV4gpE06h7cVmSS+sQn+gS5s4q
         PB6ORi+EHy/clfQxAnygZzL7kiGzJjOvDgPO3lwym0CLdfFkzPOO/xSVenYKArjV6XGr
         qLeloFO6ZloByVvDOZ62EoYQX/daD8Bj5kzb3IrLB4aP/bD5eseVpjtCTCDWPN231iVo
         cUhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RKZ3PPWFEXzcKJ2h50KgMAEoCEZWAlMCLSPlgytTa0U=;
        b=NCotMF3z2VapDBhRTmvV5yxgpfmYuvSQb3DZzHw+LA+FmMz5sd0FRcGSZw5wE52q4H
         LorvJSS3ofBZa8k471FIC9ZlAkj5vPBPLiyEw/M5tNyGibusIa5rC31dLnOb4N9cpN9Q
         UV1QjIf8h86Cdp8vO5tG61taASwnEDOXWmZdNVqTWac3G5RteSbbqj9cO1aw/vqZwxK/
         2Y289E09cPQtRXqxNgxyaP2cnWNFnsVcfpG8wD1oaOnRhqOp+acH0p0Xw4y+tHB2tCYt
         DuGjb+qGVdEWS2TTEaIRoXqCBrclC5ZlU8NWsXp06PvdAJZ1NduCov2kmmI3kaX6ArrT
         SlUw==
X-Gm-Message-State: APjAAAXcIajyIgcDsBi3aM7HG0d1G3KjUuYzNS7NJIcLUfK5cwar+9ya
        Cr5EZompfYLsfUuIHwD4GxWLCQ==
X-Google-Smtp-Source: APXvYqwZBG7sz559LYm14ZgZaWNgptDbja7omCxLQue+lL9VAcSClk9Z0xTEGpcGpyPrll6J39/OOQ==
X-Received: by 2002:a05:620a:15a5:: with SMTP id f5mr25771788qkk.45.1563366359574;
        Wed, 17 Jul 2019 05:25:59 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id y14sm10762015qkb.109.2019.07.17.05.25.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 17 Jul 2019 05:25:58 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hnj0Q-0003nG-3A; Wed, 17 Jul 2019 09:25:58 -0300
Date:   Wed, 17 Jul 2019 09:25:58 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Alexander Steffen <Alexander.Steffen@infineon.com>
Cc:     Stephen Boyd <swboyd@chromium.org>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Andrey Pronin <apronin@chromium.org>,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-integrity@vger.kernel.org,
        Duncan Laurie <dlaurie@chromium.org>,
        Guenter Roeck <groeck@chromium.org>
Subject: Re: [PATCH v2 5/6] tpm: add driver for cr50 on SPI
Message-ID: <20190717122558.GF12119@ziepe.ca>
References: <20190716224518.62556-1-swboyd@chromium.org>
 <20190716224518.62556-6-swboyd@chromium.org>
 <f824e3ab-ae2f-8c2f-549a-16569b10966e@infineon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f824e3ab-ae2f-8c2f-549a-16569b10966e@infineon.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Jul 17, 2019 at 02:00:06PM +0200, Alexander Steffen wrote:
> On 17.07.2019 00:45, Stephen Boyd wrote:
> > From: Andrey Pronin <apronin@chromium.org>
> > 
> > Add TPM2.0 PTP FIFO compatible SPI interface for chips with Cr50
> > firmware. The firmware running on the currently supported H1
> > Secure Microcontroller requires a special driver to handle its
> > specifics:
> >   - need to ensure a certain delay between spi transactions, or else
> >     the chip may miss some part of the next transaction;
> >   - if there is no spi activity for some time, it may go to sleep,
> >     and needs to be waken up before sending further commands;
> >   - access to vendor-specific registers.
> > 
> > Signed-off-by: Andrey Pronin <apronin@chromium.org>
> > [swboyd@chromium.org: Replace boilerplate with SPDX tag, drop
> > suspended bit and remove ifdef checks in cr50.h, push tpm.h
> > include into cr50.c]
> > Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> >   drivers/char/tpm/Kconfig    |  16 ++
> >   drivers/char/tpm/Makefile   |   2 +
> >   drivers/char/tpm/cr50.c     |  33 +++
> >   drivers/char/tpm/cr50.h     |  15 ++
> >   drivers/char/tpm/cr50_spi.c | 450 ++++++++++++++++++++++++++++++++++++
> >   5 files changed, 516 insertions(+)
> >   create mode 100644 drivers/char/tpm/cr50.c
> >   create mode 100644 drivers/char/tpm/cr50.h
> >   create mode 100644 drivers/char/tpm/cr50_spi.c
> > 
> > diff --git a/drivers/char/tpm/Kconfig b/drivers/char/tpm/Kconfig
> > index 88a3c06fc153..b7028bfa6f87 100644
> > +++ b/drivers/char/tpm/Kconfig
> > @@ -114,6 +114,22 @@ config TCG_ATMEL
> >   	  will be accessible from within Linux.  To compile this driver
> >   	  as a module, choose M here; the module will be called tpm_atmel.
> > +config TCG_CR50
> > +	bool
> > +	---help---
> > +	  Common routines shared by drivers for Cr50-based devices.
> > +
> 
> Is it a common pattern to add config options that are not useful on their
> own? When would I ever enable TCG_CR50 without also enabling TCG_CR50_SPI?
> Why can't you just use TCG_CR50_SPI for everything?

This is an internal kconfig symbol, it isn't seen by the user, which
is a pretty normal pattern.

But I don't think the help should be included (since it cannot be
seen), and I'm pretty sure it should be a tristate

But overall, it might be better to just double link the little helper:

obj-$(CONFIG_TCG_CR50_SPI) += cr50.o cr50_spi.o
obj-$(CONFIG_TCG_CR50_I2C) += cr50.o cr50_i2c.o

As we don't actually ever expect to load both modules into the same
system

Jason
