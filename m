Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2FFFB65FBF
	for <lists+linux-integrity@lfdr.de>; Thu, 11 Jul 2019 20:50:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728583AbfGKSu3 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 11 Jul 2019 14:50:29 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:38084 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726116AbfGKSu3 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 11 Jul 2019 14:50:29 -0400
Received: by mail-qk1-f196.google.com with SMTP id a27so4474705qkk.5
        for <linux-integrity@vger.kernel.org>; Thu, 11 Jul 2019 11:50:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9PX6RK3t0WnK6jRP8vhXNYXeB2ugibNMpHzAf6NYbrk=;
        b=MaaQkqVPfoVn5M2wR4GgBCq9qRWiJQUYO2UvzrHbE9MSHUBuX6DaR+Wr6HxXH94DDj
         PIVg5OVfyu4t3rCyrDDaP4m59/oBr1qy1z0pCYwmAhjni8fRhXNnxllDShzStjiUTvxc
         daEnnohl0uzsyjPVJ64I3kFjFG241mT0vIxetfwF2iNjjRwr/wsFo0y9JCRLTP889Hu6
         1LRxhcTUbtdcfQQsnAq74bZqYXiiUaSBXDQqJ9rf+OYqOINyN9cpD6LMXqK7XdMi3VI9
         yprgXrX2o4rbSkg8nWann0yZAPlyjV1xQhW7gKZ/Yw2uCnmfP8r1ToE36lYXUIL04ICn
         SjsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9PX6RK3t0WnK6jRP8vhXNYXeB2ugibNMpHzAf6NYbrk=;
        b=BmvuTssgq7GSjdcTWBYdRevSaKcR7ZewXh7/tR8FSSL7mao9v8i4U9Zg2h3hMNHuXr
         B9egis7IYOIqC5FcH8kE4UvzNG8oUOprYx8i4hx+tZXmZYpyEDS/om3SNORY/qAYxDtw
         OKmQvh8LELnKyeEoi7EWqtTsoCgqTCMMlZBlE88Jj/F9Wh0iLpR6Oq3OaXXbKK7AqiEM
         PReJtd6F6fT1yy8DTJU0v5QBpc/jluwUy0S181wB3tGrroXpDiAH54wZWLCFOGmHS6ya
         BGXOOR5aHlpxsdfKKtR9usbRvZhRu4/alzjj7bz1Vx0+LHpS/Foq3jrWkHmaEMZi97+y
         DCvA==
X-Gm-Message-State: APjAAAUDi5NOSo/WNnrPwMdfgLOb3Wii668jfHl+N19WrMjq49y+/Dg/
        0ImK9Va86O3hl2wQzoCWtgHBDg==
X-Google-Smtp-Source: APXvYqxOcm1wiOTT42Fu5ONvpftTUgxOKqLnbJrym3WVzQHNcaDaUPRlGTxtQivFKxcw4pmdtHkQGw==
X-Received: by 2002:a37:62ca:: with SMTP id w193mr2754976qkb.363.1562871028107;
        Thu, 11 Jul 2019 11:50:28 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id 18sm2569531qkh.77.2019.07.11.11.50.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 11 Jul 2019 11:50:27 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hle9D-0000bq-9R; Thu, 11 Jul 2019 15:50:27 -0300
Date:   Thu, 11 Jul 2019 15:50:27 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     "Safford, David (GE Global Research, US)" <david.safford@ge.com>
Cc:     "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "jarkko.sakkinen@linux.intel.com" <jarkko.sakkinen@linux.intel.com>,
        "Wiseman, Monty (GE Global Research, US)" <monty.wiseman@ge.com>
Subject: Re: [PATCH] tpm_crb - workaround broken ACPI tables
Message-ID: <20190711185027.GG25807@ziepe.ca>
References: <BCA04D5D9A3B764C9B7405BBA4D4A3C035EF7BC7@ALPMBAPA12.e2k.ad.ge.com>
 <20190711145850.GC25807@ziepe.ca>
 <BCA04D5D9A3B764C9B7405BBA4D4A3C035EF7C56@ALPMBAPA12.e2k.ad.ge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BCA04D5D9A3B764C9B7405BBA4D4A3C035EF7C56@ALPMBAPA12.e2k.ad.ge.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Jul 11, 2019 at 04:44:59PM +0000, Safford, David (GE Global Research, US) wrote:
> > From: Jason Gunthorpe <jgg@ziepe.ca>
> > Sent: Thursday, July 11, 2019 10:59 AM
> > To: Safford, David (GE Global Research, US) <david.safford@ge.com>
> > Cc: linux-integrity@vger.kernel.org; jarkko.sakkinen@linux.intel.com;
> > Wiseman, Monty (GE Global Research, US) <monty.wiseman@ge.com>
> > Subject: EXT: Re: [PATCH] tpm_crb - workaround broken ACPI tables
> > 
> > On Thu, Jul 11, 2019 at 12:29:30PM +0000, Safford, David (GE Global Research,
> > US) wrote:
> > > Most x86 desktops and laptops have firmware TPMs which support the CRB
> > > interface. Unfortunately, the linux tpm_crb driver depends on
> > > perfectly correct ACPI tables, and there are a *lot* of systems out
> > > there with broken tpm_crb entries. (Not one of my five tpm_crb systems
> > > works with the existing driver.) While it is good to encourage vendors
> > > to fix their firmware, many refuse ("It works on Windows"), leaving
> > > users in the lurch.
> > >
> > > This patch adds a kernel parameter "tpm_crb.force=1" that works around
> > > the problem in every case I have tested so far. Basically it does two
> > > things:
> > > 	- it trusts the cmd and resp addresses in the CRB registers
> > > 	- it ignores all alleged IO resource conflicts
> > >
> > > Both workarounds make sense. If there really were an address conflict,
> > > or if the register values really were wrong, the device would not be
> > > working at all. And testing with this patch has shown that in every
> > > case (so far), the problem has been bogus ACPI entries.
> > >
> > > This patch is against the upstream 5.2 kernel.
> > >
> > > Signed-off-by: David Safford <david.safford@ge.com>
> > 
> > I think we need to ask the ioresource and ACPI people how to fix this
> > properly and automatically. Maybe some ACPI quirk or maybe we try to
> > resorve the resoruce and fall back to forcing or something
> > 
> > I don't think t a module parameter is the right answer
> > 
> > Jaason
> 
> I would argue that this is the right place to fix the problem, as only the 
> tpm_crb driver has the semantic knowledge to get the valid addresses
> and sizes from the tpm_crb device registers dynamically.

Linux has had this for a long time, so if it hasn't worked to fix the
BIOS then we need to accept it will not get fixed and move on,
IMHO. People should expect the TPM2 will start automatically without a
module option.

I'm not even sure why this is happening, it could be something the
ACPI side is doing that maybe isn't a good idea.

Jason
