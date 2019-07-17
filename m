Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 05B6B6BFF3
	for <lists+linux-integrity@lfdr.de>; Wed, 17 Jul 2019 18:56:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727165AbfGQQ4a (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 17 Jul 2019 12:56:30 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:36411 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725993AbfGQQ4a (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 17 Jul 2019 12:56:30 -0400
Received: by mail-qt1-f196.google.com with SMTP id z4so24114669qtc.3
        for <linux-integrity@vger.kernel.org>; Wed, 17 Jul 2019 09:56:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=QcInXotQ5qsw+1+WXypTirM8EJYiEcw74M2cq2C1BZA=;
        b=lpavGjnPo1hHDkW9yU+PQPuRd9g79J2rnn775EOqecp/E1H80GmxBv7zsyFgl7zqSF
         CwZbO/YUJ1IzTYjYvI/CCUFXklngf8LmrGn/UxySNb5+B2Q0e2m1D2znPRNGWUT3HVV+
         sBk9m+kcsu0J4D+Wp6DIzoOGE3k2HDnZlC99OVSg0autLjZORtGHOnN38DK0Hpa83iHf
         p/NYRH4VPV2ZuJvefvlDHgpkzNZMQNRoSN9vu8Mo5Vq9vX60m4cZYxjNqRvHipqbLi/r
         dZUj+jrw//TI13G2tWXIeWq2EG71XJmJDTuAWKRw+WsSGwPavMh1RYPOL2grgdHxh3Qm
         H+7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QcInXotQ5qsw+1+WXypTirM8EJYiEcw74M2cq2C1BZA=;
        b=EBsTyrn+80rw6gx9OBzhPto3MPcoTwyoVIX8IkKaMcUo5DfSukHeAeqFWhaIotQlaU
         P1zCdSQ7zzw//g8gv11po6eTcqRGFtUPlW3DEJHmrp53jSoIkWNuf0AgEifmsEgMsUht
         lQPgpzbF1thiUiP3LiSL5DbhST84O6L0PjyCRB5psqIBMgN25upN8mUFoxiuCP+GrBnW
         prhOk5+J3fkB71r+pNul3nhu1WBdX7caLL0HgHqFqBt4xwQ1skqS6244DFni5So401Hs
         6YAXsmejCBpp4S32QEd1dO735KQX0XkHYKM2Cv9T09MihFAyyNB7yDy5glmG2fN+2qXL
         SzZw==
X-Gm-Message-State: APjAAAW+NkCjWIwaG7GwvaFmMm9tOQNOv019ZQmcHK2pSCSx94RR334N
        m6iHWVCGbQNjhIhwdaXPl/EF6g==
X-Google-Smtp-Source: APXvYqxpwG1Bvv1520YBf2tL1JaayZnBwTA/J3DOP+KaSibW7CRgvwcS6WoIOmaL8BnkncqN6xkchg==
X-Received: by 2002:ac8:7251:: with SMTP id l17mr28600631qtp.277.1563382589666;
        Wed, 17 Jul 2019 09:56:29 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id r40sm13549614qtr.57.2019.07.17.09.56.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 17 Jul 2019 09:56:29 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hnnEC-0000cU-Pl; Wed, 17 Jul 2019 13:56:28 -0300
Date:   Wed, 17 Jul 2019 13:56:28 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Alexander Steffen <Alexander.Steffen@infineon.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Andrey Pronin <apronin@chromium.org>,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-integrity@vger.kernel.org,
        Duncan Laurie <dlaurie@chromium.org>,
        Guenter Roeck <groeck@chromium.org>
Subject: Re: [PATCH v2 5/6] tpm: add driver for cr50 on SPI
Message-ID: <20190717165628.GJ12119@ziepe.ca>
References: <20190716224518.62556-1-swboyd@chromium.org>
 <20190716224518.62556-6-swboyd@chromium.org>
 <f824e3ab-ae2f-8c2f-549a-16569b10966e@infineon.com>
 <20190717122558.GF12119@ziepe.ca>
 <5d2f51a7.1c69fb81.6495.fbe8@mx.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5d2f51a7.1c69fb81.6495.fbe8@mx.google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Jul 17, 2019 at 09:49:42AM -0700, Stephen Boyd wrote:
> Quoting Jason Gunthorpe (2019-07-17 05:25:58)
> > On Wed, Jul 17, 2019 at 02:00:06PM +0200, Alexander Steffen wrote:
> > > On 17.07.2019 00:45, Stephen Boyd wrote:
> > > > diff --git a/drivers/char/tpm/Kconfig b/drivers/char/tpm/Kconfig
> > > > index 88a3c06fc153..b7028bfa6f87 100644
> > > > +++ b/drivers/char/tpm/Kconfig
> > > > @@ -114,6 +114,22 @@ config TCG_ATMEL
> > > >       will be accessible from within Linux.  To compile this driver
> > > >       as a module, choose M here; the module will be called tpm_atmel.
> > > > +config TCG_CR50
> > > > +   bool
> > > > +   ---help---
> > > > +     Common routines shared by drivers for Cr50-based devices.
> > > > +
> > > 
> > > Is it a common pattern to add config options that are not useful on their
> > > own? When would I ever enable TCG_CR50 without also enabling TCG_CR50_SPI?
> > > Why can't you just use TCG_CR50_SPI for everything?
> > 
> > This is an internal kconfig symbol, it isn't seen by the user, which
> > is a pretty normal pattern.
> > 
> > But I don't think the help should be included (since it cannot be
> > seen), and I'm pretty sure it should be a tristate
> 
> Good point. I'll fix it.
> 
> > 
> > But overall, it might be better to just double link the little helper:
> > 
> > obj-$(CONFIG_TCG_CR50_SPI) += cr50.o cr50_spi.o
> > obj-$(CONFIG_TCG_CR50_I2C) += cr50.o cr50_i2c.o
> > 
> > As we don't actually ever expect to load both modules into the same
> > system
> > 
> 
> Sometimes we have both drivers built-in. To maintain the tiny space
> savings I'd prefer to just leave this as helpless and tristate.

If it is builtin you only get one copy of cr50.o anyhow. The only
differences is for modules, then the two modules will both be a bit
bigger instead of a 3rd module being created

Jason
