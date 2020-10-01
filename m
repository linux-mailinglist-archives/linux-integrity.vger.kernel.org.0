Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBE1527F8CA
	for <lists+linux-integrity@lfdr.de>; Thu,  1 Oct 2020 06:54:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725878AbgJAEyK (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 1 Oct 2020 00:54:10 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:41782 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725876AbgJAEyK (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 1 Oct 2020 00:54:10 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 221898EE14D;
        Wed, 30 Sep 2020 21:54:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1601528049;
        bh=ht7BdWYqD2u592SWTDK87ZdNqaOToZJ0x8CvxsHyz6E=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=h9J0R5ztIBNeXWINk9VLsMT1hjpx/R0xahPn8yf/uNn5HnoH9CdAwK5yFZXelp3xF
         K8spfvbc8WZ86BFpUqsdA1azn6x2YJTbwT3JaTrSJohjZwGahklEU9xDawPf1Fp37e
         EWeLEqaR1tCVLDKwPMEnCf0k/HYwhLCbiVEpTQiI=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 9xeZFXv0B92Y; Wed, 30 Sep 2020 21:54:02 -0700 (PDT)
Received: from jarvis (c-73-35-198-56.hsd1.wa.comcast.net [73.35.198.56])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 398C58EE0E2;
        Wed, 30 Sep 2020 21:54:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1601528042;
        bh=ht7BdWYqD2u592SWTDK87ZdNqaOToZJ0x8CvxsHyz6E=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=UkVOuSHwnzCVrmWwOBaA684szW2GNOTJ3KXf99q6aNy8QyIEd4KTWeQoxUO4zbBOA
         suMCs+QHSZ63+Vbcc7ec9aPJFApJK9EGSgpJtn6Kw3DKvBbSrXXWxDL/UWm4JBSqKc
         dA2ehgLWJORIDlLODddjk8dqVcIfvtVIjh2c8r6I=
Message-ID: <1aed1b0734435959d5e53b8a4b3c18558243e6b8.camel@HansenPartnership.com>
Subject: Re: [PATCH] Fix Atmel TPM crash caused by too frequent queries
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     Hao Wu <hao.wu@rubrik.com>, peterhuewe@gmx.de, jgg@ziepe.ca,
        arnd@arndb.de, gregkh@linuxfoundation.org,
        Hamza Attak <hamza@hpe.com>, nayna@linux.vnet.ibm.com,
        why2jjj.linux@gmail.com, zohar@linux.vnet.ibm.com,
        linux-integrity@vger.kernel.org,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        Ken Goldman <kgold@linux.ibm.com>,
        Seungyeop Han <seungyeop.han@rubrik.com>,
        Shrihari Kalkar <shrihari.kalkar@rubrik.com>,
        Anish Jhaveri <anish.jhaveri@rubrik.com>
Date:   Wed, 30 Sep 2020 21:53:53 -0700
In-Reply-To: <20201001015051.GA5971@linux.intel.com>
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
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 2020-10-01 at 04:50 +0300, Jarkko Sakkinen wrote:
> On Wed, Sep 30, 2020 at 03:31:20PM -0700, James Bottomley wrote:
> > On Thu, 2020-10-01 at 00:09 +0300, Jarkko Sakkinen wrote:
> > > On Wed, Sep 30, 2020 at 01:48:15PM -0700, James Bottomley wrote:
> > > > On Wed, 2020-09-30 at 18:37 +0300, Jarkko Sakkinen wrote:
> > > > > On Wed, Sep 30, 2020 at 07:54:58AM -0700, James Bottomley
> > > > > wrote:
> > > > > > On Wed, 2020-09-30 at 05:16 +0300, Jarkko Sakkinen wrote:
> > > > > > > On Mon, Sep 28, 2020 at 03:11:39PM -0700, James Bottomley
> > > > > > > wrote:
> > > > > > > > On Sun, 2020-09-27 at 22:59 -0700, Hao Wu wrote:
> > > > > > > > [...]
> > > > > > > > > > However, there is another possibility: it's
> > > > > > > > > > something to do with the byte read; I notice you
> > > > > > > > > > don't require the same slowdown for the burst count
> > > > > > > > > > read, which actually reads the status register and
> > > > > > > > > > burst count as a read32.  If that really is the
> > > > > > > > > > case, for the atmel would substituting a read32 and
> > > > > > > > > > just throwing the upper bytes away in
> > > > > > > > > > tpm_tis_status() allow us to keep the current
> > > > > > > > > > timings?  I can actually try doing this and see if
> > > > > > > > > > it fixes my nuvoton.
> > > > > > > > > 
> > > > > > > > > If would be helpful if you can find the solution
> > > > > > > > > without reducing performance. I think it is a
> > > > > > > > > separate problem to address though. Maybe not worth
> > > > > > > > > to mix them in the same fix.
> > > > > > > > 
> > > > > > > > Well, if it works, no other fix is needed.
> > > > > > > > 
> > > > > > > > This is what I'm currently trying out on my nuvoton
> > > > > > > > with the timings reverted to being those in the vanilla
> > > > > > > > kernel.  So far it hasn't crashed, but I haven't run it
> > > > > > > > for long enough to be sure yet.
> > > > > > > > 
> > > > > > > > James
> > > > > > > 
> > > > > > > OK, so the bus does not like one byte reads but prefers
> > > > > > > full (32-bit) word reads? I.e. what's the context?
> > > > > > 
> > > > > > It's not supported by anything in the spec just empirical
> > > > > > observation.  However, the spec says the status register is
> > > > > > 24 bits: the upper 16 being the burst count.  When we read
> > > > > > the whole status register, including the burst count, we do
> > > > > > a read32. I observed that the elongated timing was only
> > > > > > added for the read8 code not the read32 which supports the
> > > > > > theory that the former causes the Atmel to crash but the
> > > > > > latter doesn't.  Of course it's always possible that
> > > > > > probabilistically the Atmel is going to crash on the burst
> > > > > > count read, but that's exercised far less than the status
> > > > > > only read.
> > > > > 
> > > > > This paragraph is good enough explanation for me. Can you
> > > > > include it to the final commit as soon as we hear how your
> > > > > fix works for Hao?
> > > > 
> > > > Sure.  I'm afraid I have to report that it didn't work for
> > > > me.  My Nuvoton is definitely annoyed by the frequency of the
> > > > prodding rather than the register width.
> > > 
> > > Sorry, this might have been stated at some point but what type of
> > > bus is it connected with?
> > 
> > It's hard to tell: this is my Dell Laptop, but I'd have to bet LPC.
> > 
> > > Does it help in any way to tune the frequency?
> > 
> > specific memory mapped address and all the conversion to the LPC
> > back end is done by memory read/write operations.  The TPM itself
> > has a clock but doesn't give the TIS interface software control.
> 
> Some TPM's use tpm_tis_spi instead of MMIO.

Yes, but I'm fairly certain mine's not SPI.

> > > I also wonder if we could adjust the frequency dynamically. I.e.
> > > start with optimistic value and lower it until finding the sweet
> > > spot.
> > 
> > The problem is the way this crashes: the TPM seems to be
> > unrecoverable. If it were recoverable without a hard reset of the
> > entire machine, we could certainly play around with it.  I can try
> > alternative mechanisms to see if anything's viable, but to all
> > intents and purposes, it looks like my TPM simply stops responding
> > to the TIS interface.
> 
> A quickly scraped idea probably with some holes in it but I was
> thinking something like
> 
> 1. Initially set slow value for latency, this could be the original
> 15 ms.
> 2. Use this to read TPM_PT_VENDOR_STRING_*.
> 3. Lookup based vendor string from a fixup table a latency that works
>    (the fallback latency could be the existing latency).

Well, yes, that was sort of what I was thinking of doing for the Atmel
... except I was thinking of using the TIS VID (16 byte assigned vendor
ID) which means we can get the information to set the timeout before we
have to do any TPM operations.

> 4. Set the legit latency.

James


