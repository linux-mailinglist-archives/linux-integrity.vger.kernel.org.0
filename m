Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05E7C2806A5
	for <lists+linux-integrity@lfdr.de>; Thu,  1 Oct 2020 20:33:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732287AbgJASdD (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 1 Oct 2020 14:33:03 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:51194 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730008AbgJASdC (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 1 Oct 2020 14:33:02 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id CBD128EE17F;
        Thu,  1 Oct 2020 11:33:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1601577181;
        bh=6zoD8b1QPdaPN9Y2O+HMMwgiS9FKZoZjnJkvHob+ztw=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=cwI+AzW2YgQuII6vs1wCa9uSNCBmhBH6Lgs7Uvc3Al7Amr8TNf3lQiH91HUGKPiDO
         D5n6mQKrfhS9agFCwwVhe8CNvui0nKUz16VbpOiQz1HMajwn5uFVBasJgaCvCmTZ2N
         w9JzNvk0JquIQqyMutun2/nMarDtb06TzeECNDTg=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 2Fa3ZIV6JSlP; Thu,  1 Oct 2020 11:33:01 -0700 (PDT)
Received: from jarvis (c-73-35-198-56.hsd1.wa.comcast.net [73.35.198.56])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id C77BF8EE0DA;
        Thu,  1 Oct 2020 11:33:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1601577181;
        bh=6zoD8b1QPdaPN9Y2O+HMMwgiS9FKZoZjnJkvHob+ztw=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=cwI+AzW2YgQuII6vs1wCa9uSNCBmhBH6Lgs7Uvc3Al7Amr8TNf3lQiH91HUGKPiDO
         D5n6mQKrfhS9agFCwwVhe8CNvui0nKUz16VbpOiQz1HMajwn5uFVBasJgaCvCmTZ2N
         w9JzNvk0JquIQqyMutun2/nMarDtb06TzeECNDTg=
Message-ID: <38e165055bae62d4e97f702c05e3a76ccdeeac0f.camel@HansenPartnership.com>
Subject: Re: [PATCH] Fix Atmel TPM crash caused by too frequent queries
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Nayna <nayna@linux.vnet.ibm.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     Hao Wu <hao.wu@rubrik.com>, peterhuewe@gmx.de, jgg@ziepe.ca,
        arnd@arndb.de, gregkh@linuxfoundation.org,
        Hamza Attak <hamza@hpe.com>, why2jjj.linux@gmail.com,
        zohar@linux.vnet.ibm.com, linux-integrity@vger.kernel.org,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        Ken Goldman <kgold@linux.ibm.com>,
        Seungyeop Han <seungyeop.han@rubrik.com>,
        Shrihari Kalkar <shrihari.kalkar@rubrik.com>,
        Anish Jhaveri <anish.jhaveri@rubrik.com>
Date:   Thu, 01 Oct 2020 11:32:59 -0700
In-Reply-To: <19de5527-2d56-6a07-3ce7-ba216b208090@linux.vnet.ibm.com>
References: <E6E3C07D-57F4-48F5-B4A9-50868B82E779@rubrik.com>
         <0c896ca8eb0e30d6e75843cfbf2aa627ddc63feb.camel@HansenPartnership.com>
         <246A111F-C72C-4CA2-B439-A6BBE0E85087@rubrik.com>
         <ceb230ea03858f5f6c7d77cfd7adea6e9f864699.camel@HansenPartnership.com>
         <20200930021637.GF808399@linux.intel.com>
         <a97706be196e2e02ca815b3011d3731684905737.camel@HansenPartnership.com>
         <20200930153715.GC52739@linux.intel.com>
         <95aafaa1e3037cb7b99ae0e76c02a419d366a407.camel@HansenPartnership.com>
         <20200930210956.GC65339@linux.intel.com>
         <6e7b54c268d25a86f8f969bcc01729eaadef6530.camel@HansenPartnership.com>
         <20201001015051.GA5971@linux.intel.com>
         <1aed1b0734435959d5e53b8a4b3c18558243e6b8.camel@HansenPartnership.com>
         <19de5527-2d56-6a07-3ce7-ba216b208090@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 2020-10-01 at 14:15 -0400, Nayna wrote:
> On 10/1/20 12:53 AM, James Bottomley wrote:
> > On Thu, 2020-10-01 at 04:50 +0300, Jarkko Sakkinen wrote:
> > > On Wed, Sep 30, 2020 at 03:31:20PM -0700, James Bottomley wrote:
> > > > On Thu, 2020-10-01 at 00:09 +0300, Jarkko Sakkinen wrote:
[...]
> > > > > I also wonder if we could adjust the frequency dynamically.
> > > > > I.e. start with optimistic value and lower it until finding
> > > > > the sweet spot.
> > > >  
> > > > The problem is the way this crashes: the TPM seems to be
> > > > unrecoverable. If it were recoverable without a hard reset of
> > > > the entire machine, we could certainly play around with it.  I
> > > > can try alternative mechanisms to see if anything's viable, but
> > > > to all intents and purposes, it looks like my TPM simply stops
> > > > responding to the TIS interface.
> > >  
> > > A quickly scraped idea probably with some holes in it but I was
> > > thinking something like
> > > 
> > > 1. Initially set slow value for latency, this could be the
> > > original 15 ms.
> > > 2. Use this to read TPM_PT_VENDOR_STRING_*.
> > > 3. Lookup based vendor string from a fixup table a latency that
> > > works
> > >     (the fallback latency could be the existing latency).
> >  
> > Well, yes, that was sort of what I was thinking of doing for the
> > Atmel ... except I was thinking of using the TIS VID (16 byte
> > assigned vendor ID) which means we can get the information to set
> > the timeout before we have to do any TPM operations.
> 
> I wonder if the timeout issue exists for all TPM commands for the
> same manufacturer.  For example, does the ATMEL TPM also crash when 
> extending  PCRs ?
> 
> In addition to defining a per TPM vendor based lookup table for
> timeout, would it be a good idea to also define a Kconfig/boot param
> option to allow timeout setting.  This will enable to set the timeout
> based on the specific use.

I don't think we need go that far (yet).  The timing change has been in
upstream since:

commit 424eaf910c329ab06ad03a527ef45dcf6a328f00
Author: Nayna Jain <nayna@linux.vnet.ibm.com>
Date:   Wed May 16 01:51:25 2018 -0400

    tpm: reduce polling time to usecs for even finer granularity
 
Which was in the released kernel 4.18: over two years ago.  In all that
time we've discovered two problems: mine which looks to be an artifact
of an experimental upgrade process in a new nuvoton and the Atmel. 
That means pretty much every other TPM simply works with the existing
timings

> I was also thinking how will we decide the lookup table values for
> each vendor ?

I wasn't thinking we would.  I was thinking I'd do a simple exception
for the Atmel and nothing else.  I don't think my Nuvoton is in any way
characteristic.  Indeed my pluggable TPM rainbow bridge system works
just fine with a Nuvoton and the current timings.

We can add additional exceptions if they actually turn up.

James


