Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CF2F3795EC
	for <lists+linux-integrity@lfdr.de>; Mon, 10 May 2021 19:29:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233351AbhEJRat (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 10 May 2021 13:30:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:55792 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233158AbhEJR37 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 10 May 2021 13:29:59 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 84D97616EC;
        Mon, 10 May 2021 17:28:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620667734;
        bh=xOe1QreTP19+KelIqRjqIiZNVtAR4OqvHDt3/h1wnPA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cpml7j173mWgDF6KDrdaKjSZ4X7SZHoFiSoRL8DA2PKbj3VztCmwL9sBXo7hFdP9h
         5l5BQp0NGmsToHje7lieUDD5LqXKnh1tndi6j8A+UPxuvAsFlfgoF+aq8dsZRXYXAo
         8JKjG2w6O8c9XChOy+4t9E/BTOTKPg++y16jyIBYB7aHhXa76SnpjBm6wnAqZaKok/
         Gqaqe2zozSEmo8SIn7KXQZZOuwgaHH3U2l1XkqTVXSvLxAl7LYw1QlBiTlN8cQ08OC
         9EJE0ca6e4zo5c08SHPYujQmd3s93ZoXloHc2QBfqMiVO9PJN8Pjqi3lYbwwfGc0S/
         gbHSkL7ijaBhQ==
Date:   Mon, 10 May 2021 20:28:51 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Hao Wu <hao.wu@rubrik.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        peterhuewe@gmx.de, jgg@ziepe.ca, Nayna <nayna@linux.vnet.ibm.com>,
        arnd@arndb.de, gregkh@linuxfoundation.org,
        Hamza Attak <hamza@hpe.com>, why2jjj.linux@gmail.com,
        zohar@linux.vnet.ibm.com, linux-integrity@vger.kernel.org,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        Ken Goldman <kgold@linux.ibm.com>,
        Seungyeop Han <seungyeop.han@rubrik.com>,
        Shrihari Kalkar <shrihari.kalkar@rubrik.com>,
        Anish Jhaveri <anish.jhaveri@rubrik.com>
Subject: Re: [PATCH] Fix Atmel TPM crash caused by too frequent queries
Message-ID: <YJltU2jdvT9K5zzV@kernel.org>
References: <38e165055bae62d4e97f702c05e3a76ccdeeac0f.camel@HansenPartnership.com>
 <20201001230426.GA26517@linux.intel.com>
 <FCA90A49-CCE3-4DDF-A876-230C42744D2A@rubrik.com>
 <20201018050951.GL68722@linux.intel.com>
 <53B75B06-FD89-4B00-BC3F-46C5B28DC201@rubrik.com>
 <9E249567-4901-4FA4-BA89-EF6DE51F7E7A@rubrik.com>
 <20201118211134.GA5034@linux.intel.com>
 <B55FCFAC-BFBD-4568-AB2F-45DD7BE10D6D@rubrik.com>
 <12157F1B-93CC-4991-813D-B78A608D1C4F@rubrik.com>
 <5d51e7ef87b4a622e1d64c3ff14f267328a0ee5e.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5d51e7ef87b4a622e1d64c3ff14f267328a0ee5e.camel@linux.ibm.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Sun, May 09, 2021 at 10:17:01PM -0400, Mimi Zohar wrote:
> [Cc'ing Jarkko Sakkinen <jarkko@kernel.org>]
> 
> On Sat, 2021-05-08 at 23:31 -0700, Hao Wu wrote:
> > > On May 8, 2021, at 11:18 PM, Hao Wu <hao.wu@rubrik.com> wrote:
> > > 
> > >> On Nov 18, 2020, at 1:11 PM, Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com> wrote:
> > >> 
> > >> On Fri, Nov 13, 2020 at 08:39:28PM -0800, Hao Wu wrote:
> > >>>> On Oct 17, 2020, at 10:20 PM, Hao Wu <hao.wu@rubrik.com> wrote:
> > >>>> 
> > >>>>> On Oct 17, 2020, at 10:09 PM, Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com> wrote:
> > >>>>> 
> > >>>>> On Fri, Oct 16, 2020 at 11:11:37PM -0700, Hao Wu wrote:
> > >>>>>>> On Oct 1, 2020, at 4:04 PM, Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com> wrote:
> > >>>>>>> 
> > >>>>>>> On Thu, Oct 01, 2020 at 11:32:59AM -0700, James Bottomley wrote:
> > >>>>>>>> On Thu, 2020-10-01 at 14:15 -0400, Nayna wrote:
> > >>>>>>>>> On 10/1/20 12:53 AM, James Bottomley wrote:
> > >>>>>>>>>> On Thu, 2020-10-01 at 04:50 +0300, Jarkko Sakkinen wrote:
> > >>>>>>>>>>> On Wed, Sep 30, 2020 at 03:31:20PM -0700, James Bottomley wrote:
> > >>>>>>>>>>>> On Thu, 2020-10-01 at 00:09 +0300, Jarkko Sakkinen wrote:
> > >>>>>>>> [...]
> > >>>>>>>>>>>>> I also wonder if we could adjust the frequency dynamically.
> > >>>>>>>>>>>>> I.e. start with optimistic value and lower it until finding
> > >>>>>>>>>>>>> the sweet spot.
> > >>>>>>>>>>>> 
> > >>>>>>>>>>>> The problem is the way this crashes: the TPM seems to be
> > >>>>>>>>>>>> unrecoverable. If it were recoverable without a hard reset of
> > >>>>>>>>>>>> the entire machine, we could certainly play around with it.  I
> > >>>>>>>>>>>> can try alternative mechanisms to see if anything's viable, but
> > >>>>>>>>>>>> to all intents and purposes, it looks like my TPM simply stops
> > >>>>>>>>>>>> responding to the TIS interface.
> > >>>>>>>>>>> 
> > >>>>>>>>>>> A quickly scraped idea probably with some holes in it but I was
> > >>>>>>>>>>> thinking something like
> > >>>>>>>>>>> 
> > >>>>>>>>>>> 1. Initially set slow value for latency, this could be the
> > >>>>>>>>>>> original 15 ms.
> > >>>>>>>>>>> 2. Use this to read TPM_PT_VENDOR_STRING_*.
> > >>>>>>>>>>> 3. Lookup based vendor string from a fixup table a latency that
> > >>>>>>>>>>> works
> > >>>>>>>>>>> (the fallback latency could be the existing latency).
> > >>>>>>>>>> 
> > >>>>>>>>>> Well, yes, that was sort of what I was thinking of doing for the
> > >>>>>>>>>> Atmel ... except I was thinking of using the TIS VID (16 byte
> > >>>>>>>>>> assigned vendor ID) which means we can get the information to set
> > >>>>>>>>>> the timeout before we have to do any TPM operations.
> > >>>>>>>>> 
> > >>>>>>>>> I wonder if the timeout issue exists for all TPM commands for the
> > >>>>>>>>> same manufacturer.  For example, does the ATMEL TPM also crash when 
> > >>>>>>>>> extending  PCRs ?
> > >>>>>>>>> 
> > >>>>>>>>> In addition to defining a per TPM vendor based lookup table for
> > >>>>>>>>> timeout, would it be a good idea to also define a Kconfig/boot param
> > >>>>>>>>> option to allow timeout setting.  This will enable to set the timeout
> > >>>>>>>>> based on the specific use.
> > >>>>>>>> 
> > >>>>>>>> I don't think we need go that far (yet).  The timing change has been in
> > >>>>>>>> upstream since:
> > >>>>>>>> 
> > >>>>>>>> commit 424eaf910c329ab06ad03a527ef45dcf6a328f00
> > >>>>>>>> Author: Nayna Jain <nayna@linux.vnet.ibm.com>
> > >>>>>>>> Date:   Wed May 16 01:51:25 2018 -0400
> > >>>>>>>> 
> > >>>>>>>> tpm: reduce polling time to usecs for even finer granularity
> > >>>>>>>> 
> > >>>>>>>> Which was in the released kernel 4.18: over two years ago.  In all that
> > >>>>>>>> time we've discovered two problems: mine which looks to be an artifact
> > >>>>>>>> of an experimental upgrade process in a new nuvoton and the Atmel. 
> > >>>>>>>> That means pretty much every other TPM simply works with the existing
> > >>>>>>>> timings
> > >>>>>>>> 
> > >>>>>>>>> I was also thinking how will we decide the lookup table values for
> > >>>>>>>>> each vendor ?
> > >>>>>>>> 
> > >>>>>>>> I wasn't thinking we would.  I was thinking I'd do a simple exception
> > >>>>>>>> for the Atmel and nothing else.  I don't think my Nuvoton is in any way
> > >>>>>>>> characteristic.  Indeed my pluggable TPM rainbow bridge system works
> > >>>>>>>> just fine with a Nuvoton and the current timings.
> > >>>>>>>> 
> > >>>>>>>> We can add additional exceptions if they actually turn up.
> > >>>>>>> 
> > >>>>>>> I'd add a table and fallback.
> > >>>>>>> 
> > >>>>>> 
> > >>>>>> Hi folks,
> > >>>>>> 
> > >>>>>> I want to follow up this a bit and check whether we reached a consensus 
> > >>>>>> on how to fix the timeout issue for Atmel chip.
> > >>>>>> 
> > >>>>>> Should we revert the changes or introduce the lookup table for chips.
> > >>>>>> 
> > >>>>>> Is there anything I can help from Rubrik side.
> > >>>>>> 
> > >>>>>> Thanks
> > >>>>>> Hao
> > >>>>> 
> > >>>>> There is nothing to revert as the previous was not applied but I'm
> > >>>>> of course ready to review any new attempts.
> > >>>>> 
> > >>>> 
> > >>>> Hi Jarkko,
> > >>>> 
> > >>>> By “revert” I meant we revert the timeout value changes by applying
> > >>>> the patch I proposed, as the timeout value discussed does cause issues.
> > >>>> 
> > >>>> Why don’t we apply the patch and improve the perf in the way of not
> > >>>> breaking TPMs ? 
> > >>>> 
> > >>>> Hao
> > >>> 
> > >>> Hi Jarkko and folks,
> > >>> 
> > >>> It’s being a while since our last discussion. I want to push a fix in the upstream for ateml chip. 
> > >>> It looks like we currently have following choices:
> > >>> 1.  generic fix for all vendors: have a lookup table for sleep time of wait_for_tpm_stat 
> > >>> (i.e. TPM_TIMEOUT_WAIT_STAT in my proposed patch) 
> > >>> 2.  quick fix for the regression: change the sleep time of wait_for_tpm_stat back to 15ms.
> > >>> It is the current proposed patch
> > >>> 3. Fix regression by making exception for ateml chip.  
> > >>> 
> > >>> Should we reach consensus on which one we want to pursue before dig
> > >>> into implementation of the patch? In my opinion, I prefer to fix the
> > >>> regression with 2, and then pursue 1 as long-term solution. 3 is
> > >>> hacky.
> > >> 
> > >> What does option 1 fix for *all* vendors?
> > >> 
> > >>> Let me know what do you guys think
> > >>> 
> > >>> Hao
> > >> 
> > >> /Jarkko
> > > 
> > > Hi Jarkko and folks,
> > > 
> > > It has been a while again. In my previous message I answered Jarkko’s question about the option 1.
> > > Jarkko, let me know if it is clear to you or you have further questions and suggestions on next to do.
> > > Somehow I couldn’t found the last message I sent but it is in 
> > > https://patchwork.kernel.org/project/linux-integrity/patch/20200926223150.109645-1-hao.wu@rubrik.com/
> > > 
> > > In high-level, the option 1 is to add a timing lookup table for each manufacture, hence we can
> > > configure timing for each chip respectively. Then we don’t need to worry about fixing ATMEL
> > > timing may cause performance degradation for other chips.
> > > 
> > > I do want to push the fix in TPM driver, which is likely to be hit going forward again when people are doing
> > > refactoring without testing chips from all manufacturing.
> > > 
> > > Let me know how should I push this forward.
> > > 
> > > Thanks
> > > Hao
> > > 
> > It looks like Jarkko’s email address (jarkko.sakkinen@linux.intel.com) is unreachable now,
> > can other TPM maintainer / reviewer help make a call and unblock this ? 
> 
> A while ago Jarkko asked everyone to use his kernel.org address.

Hao, I cannot really say that much about patch that does not exist.

The whole consesus thing based on a plan is just semantically wrong
way to look at things. If you have an idea for a patch, make your
own choice and just send the patch.

/Jarkko
