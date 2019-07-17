Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 31B3F6C019
	for <lists+linux-integrity@lfdr.de>; Wed, 17 Jul 2019 19:12:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728096AbfGQRMS (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 17 Jul 2019 13:12:18 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:35060 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727372AbfGQRMS (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 17 Jul 2019 13:12:18 -0400
Received: by mail-qt1-f194.google.com with SMTP id d23so24159813qto.2
        for <linux-integrity@vger.kernel.org>; Wed, 17 Jul 2019 10:12:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=uAyGJcxa2faLDz1zX3L+P9YEdREk6KdL2GiO7sRiFjw=;
        b=Trvb+2uNj8vUbkEDC3SxTfLCURptQdoVKewLFrm6bk4jdt1cokRy738aVJ4XYmbgD+
         92Rez/4Po6ykm+mwW4H9lcRVbz/bdZLJ2r5ndntgzbvpotRndpSTq7cVWnGV5YSMnx2X
         STt4ARBuT9edfepQWgh456AuI6rUiua8N9b43Owwed484efiXh53kNaWGNyPOuqc7Myb
         lGG38nU4hDH1vKxu5NTcYG6GknjLZbHAMd3n+ULBpgxK6V/Zd0Jds/jJTMUKGQRfv8aV
         54sYco2Vagjp8d238KCbmTo/Ura8lLPnGyAiR5M3anbFENJLsArucdJau+g9y2oVsAU9
         Izww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=uAyGJcxa2faLDz1zX3L+P9YEdREk6KdL2GiO7sRiFjw=;
        b=Dwjgz/wW/PbZ0bqDjccealhFbYOVhkt9oKLbaMChTt+aA2sw+t4wPPnvw/354DR9Dz
         hKqCA10B8Rhchw1pdusQS57Yxx8plA4N7ddAqKzddg22zOd+1+nafl4oiFDAWaW05EwX
         MD2Or/TdiheXCFzZCdRvQKsNLhtSRxl7YYgkWdziY9sJRVcgz4hcL4OVSow/TcH9EN1S
         pj2lqBiseIwvc0Jz+ZmElhYMIe0DzrxQQfY11IaJgxHRX/785uyn2vy6tvqFtCeDod5R
         RyRfUK1V0JHOAzQoeis6uSnkNaUYGy4LzahlYCA/RzTKVu7+uUAn+2XccvkR5Pg9ez/p
         KElQ==
X-Gm-Message-State: APjAAAUPJf5SrWSBT0qI4P8pg2LAeE+eJByOTRt3D0gK8KenVOCSRyYZ
        LUeqDUb37jlmbGrarBFMmS2/NXwGKkwQxQ==
X-Google-Smtp-Source: APXvYqxSNZusUeIhA/bqMoyaHlDfaJ2nmzyv/KRTgT11+OmhlLB8ElQiMzjoCvSSZkAdDzdww5gBxg==
X-Received: by 2002:ac8:3233:: with SMTP id x48mr29415342qta.159.1563383537619;
        Wed, 17 Jul 2019 10:12:17 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id s127sm11093085qkd.107.2019.07.17.10.12.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 17 Jul 2019 10:12:17 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hnnTU-0006Lc-Is; Wed, 17 Jul 2019 14:12:16 -0300
Date:   Wed, 17 Jul 2019 14:12:16 -0300
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
Message-ID: <20190717171216.GK12119@ziepe.ca>
References: <20190716224518.62556-1-swboyd@chromium.org>
 <20190716224518.62556-6-swboyd@chromium.org>
 <f824e3ab-ae2f-8c2f-549a-16569b10966e@infineon.com>
 <20190717122558.GF12119@ziepe.ca>
 <5d2f51a7.1c69fb81.6495.fbe8@mx.google.com>
 <20190717165628.GJ12119@ziepe.ca>
 <5d2f5570.1c69fb81.f3832.3c3f@mx.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5d2f5570.1c69fb81.f3832.3c3f@mx.google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Jul 17, 2019 at 10:05:52AM -0700, Stephen Boyd wrote:
> Quoting Jason Gunthorpe (2019-07-17 09:56:28)
> > On Wed, Jul 17, 2019 at 09:49:42AM -0700, Stephen Boyd wrote:
> > > Quoting Jason Gunthorpe (2019-07-17 05:25:58)
> > > > On Wed, Jul 17, 2019 at 02:00:06PM +0200, Alexander Steffen wrote:
> > > > > On 17.07.2019 00:45, Stephen Boyd wrote:
> > > > 
> > > > But overall, it might be better to just double link the little helper:
> > > > 
> > > > obj-$(CONFIG_TCG_CR50_SPI) += cr50.o cr50_spi.o
> > > > obj-$(CONFIG_TCG_CR50_I2C) += cr50.o cr50_i2c.o
> > > > 
> > > > As we don't actually ever expect to load both modules into the same
> > > > system
> > > > 
> > > 
> > > Sometimes we have both drivers built-in. To maintain the tiny space
> > > savings I'd prefer to just leave this as helpless and tristate.
> > 
> > If it is builtin you only get one copy of cr50.o anyhow. The only
> > differences is for modules, then the two modules will both be a bit
> > bigger instead of a 3rd module being created
> > 
> 
> Yes. The space savings comes from having the extra module 'cr50.ko' that
> holds almost nothing at all when the two drivers are modules.

I'm not sure it is an actual savings, there is alot of minimum
overhead and alignment to have a module in the first place.

Jason
 
