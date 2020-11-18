Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0F712B8659
	for <lists+linux-integrity@lfdr.de>; Wed, 18 Nov 2020 22:14:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726651AbgKRVLu (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 18 Nov 2020 16:11:50 -0500
Received: from mga18.intel.com ([134.134.136.126]:19676 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726098AbgKRVLt (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 18 Nov 2020 16:11:49 -0500
IronPort-SDR: TyM7TzmnVR1Ukz2+eFGxeB2k2lENJ4fFqPh9Xcns+PsXk/plZLwBx6U9AmYIHKzf7B2rwN1BE9
 Mg4W35MREePw==
X-IronPort-AV: E=McAfee;i="6000,8403,9809"; a="158959666"
X-IronPort-AV: E=Sophos;i="5.77,488,1596524400"; 
   d="scan'208";a="158959666"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2020 13:11:48 -0800
IronPort-SDR: 4ug92vCsHAXxSDZWy6XQfcE0r+Zr+Dm1Rvm9l1P3AkFhlRiYI1h20keOppD2MhHIEGFflYI2dL
 98dL9lM3jv9A==
X-IronPort-AV: E=Sophos;i="5.77,488,1596524400"; 
   d="scan'208";a="544710250"
Received: from stephanh-mobl.ger.corp.intel.com (HELO linux.intel.com) ([10.252.53.212])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2020 13:11:41 -0800
Date:   Wed, 18 Nov 2020 23:11:34 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Hao Wu <hao.wu@rubrik.com>
Cc:     James Bottomley <James.Bottomley@hansenpartnership.com>,
        Nayna <nayna@linux.vnet.ibm.com>, peterhuewe@gmx.de,
        jgg@ziepe.ca, arnd@arndb.de, gregkh@linuxfoundation.org,
        Hamza Attak <hamza@hpe.com>, why2jjj.linux@gmail.com,
        zohar@linux.vnet.ibm.com, linux-integrity@vger.kernel.org,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        Ken Goldman <kgold@linux.ibm.com>,
        Seungyeop Han <seungyeop.han@rubrik.com>,
        Shrihari Kalkar <shrihari.kalkar@rubrik.com>,
        Anish Jhaveri <anish.jhaveri@rubrik.com>
Subject: Re: [PATCH] Fix Atmel TPM crash caused by too frequent queries
Message-ID: <20201118211134.GA5034@linux.intel.com>
References: <6e7b54c268d25a86f8f969bcc01729eaadef6530.camel@HansenPartnership.com>
 <20201001015051.GA5971@linux.intel.com>
 <1aed1b0734435959d5e53b8a4b3c18558243e6b8.camel@HansenPartnership.com>
 <19de5527-2d56-6a07-3ce7-ba216b208090@linux.vnet.ibm.com>
 <38e165055bae62d4e97f702c05e3a76ccdeeac0f.camel@HansenPartnership.com>
 <20201001230426.GA26517@linux.intel.com>
 <FCA90A49-CCE3-4DDF-A876-230C42744D2A@rubrik.com>
 <20201018050951.GL68722@linux.intel.com>
 <53B75B06-FD89-4B00-BC3F-46C5B28DC201@rubrik.com>
 <9E249567-4901-4FA4-BA89-EF6DE51F7E7A@rubrik.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9E249567-4901-4FA4-BA89-EF6DE51F7E7A@rubrik.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, Nov 13, 2020 at 08:39:28PM -0800, Hao Wu wrote:
> > On Oct 17, 2020, at 10:20 PM, Hao Wu <hao.wu@rubrik.com> wrote:
> > 
> >> On Oct 17, 2020, at 10:09 PM, Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com> wrote:
> >> 
> >> On Fri, Oct 16, 2020 at 11:11:37PM -0700, Hao Wu wrote:
> >>>> On Oct 1, 2020, at 4:04 PM, Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com> wrote:
> >>>> 
> >>>> On Thu, Oct 01, 2020 at 11:32:59AM -0700, James Bottomley wrote:
> >>>>> On Thu, 2020-10-01 at 14:15 -0400, Nayna wrote:
> >>>>>> On 10/1/20 12:53 AM, James Bottomley wrote:
> >>>>>>> On Thu, 2020-10-01 at 04:50 +0300, Jarkko Sakkinen wrote:
> >>>>>>>> On Wed, Sep 30, 2020 at 03:31:20PM -0700, James Bottomley wrote:
> >>>>>>>>> On Thu, 2020-10-01 at 00:09 +0300, Jarkko Sakkinen wrote:
> >>>>> [...]
> >>>>>>>>>> I also wonder if we could adjust the frequency dynamically.
> >>>>>>>>>> I.e. start with optimistic value and lower it until finding
> >>>>>>>>>> the sweet spot.
> >>>>>>>>> 
> >>>>>>>>> The problem is the way this crashes: the TPM seems to be
> >>>>>>>>> unrecoverable. If it were recoverable without a hard reset of
> >>>>>>>>> the entire machine, we could certainly play around with it.  I
> >>>>>>>>> can try alternative mechanisms to see if anything's viable, but
> >>>>>>>>> to all intents and purposes, it looks like my TPM simply stops
> >>>>>>>>> responding to the TIS interface.
> >>>>>>>> 
> >>>>>>>> A quickly scraped idea probably with some holes in it but I was
> >>>>>>>> thinking something like
> >>>>>>>> 
> >>>>>>>> 1. Initially set slow value for latency, this could be the
> >>>>>>>> original 15 ms.
> >>>>>>>> 2. Use this to read TPM_PT_VENDOR_STRING_*.
> >>>>>>>> 3. Lookup based vendor string from a fixup table a latency that
> >>>>>>>> works
> >>>>>>>>  (the fallback latency could be the existing latency).
> >>>>>>> 
> >>>>>>> Well, yes, that was sort of what I was thinking of doing for the
> >>>>>>> Atmel ... except I was thinking of using the TIS VID (16 byte
> >>>>>>> assigned vendor ID) which means we can get the information to set
> >>>>>>> the timeout before we have to do any TPM operations.
> >>>>>> 
> >>>>>> I wonder if the timeout issue exists for all TPM commands for the
> >>>>>> same manufacturer.  For example, does the ATMEL TPM also crash when 
> >>>>>> extending  PCRs ?
> >>>>>> 
> >>>>>> In addition to defining a per TPM vendor based lookup table for
> >>>>>> timeout, would it be a good idea to also define a Kconfig/boot param
> >>>>>> option to allow timeout setting.  This will enable to set the timeout
> >>>>>> based on the specific use.
> >>>>> 
> >>>>> I don't think we need go that far (yet).  The timing change has been in
> >>>>> upstream since:
> >>>>> 
> >>>>> commit 424eaf910c329ab06ad03a527ef45dcf6a328f00
> >>>>> Author: Nayna Jain <nayna@linux.vnet.ibm.com>
> >>>>> Date:   Wed May 16 01:51:25 2018 -0400
> >>>>> 
> >>>>>  tpm: reduce polling time to usecs for even finer granularity
> >>>>> 
> >>>>> Which was in the released kernel 4.18: over two years ago.  In all that
> >>>>> time we've discovered two problems: mine which looks to be an artifact
> >>>>> of an experimental upgrade process in a new nuvoton and the Atmel. 
> >>>>> That means pretty much every other TPM simply works with the existing
> >>>>> timings
> >>>>> 
> >>>>>> I was also thinking how will we decide the lookup table values for
> >>>>>> each vendor ?
> >>>>> 
> >>>>> I wasn't thinking we would.  I was thinking I'd do a simple exception
> >>>>> for the Atmel and nothing else.  I don't think my Nuvoton is in any way
> >>>>> characteristic.  Indeed my pluggable TPM rainbow bridge system works
> >>>>> just fine with a Nuvoton and the current timings.
> >>>>> 
> >>>>> We can add additional exceptions if they actually turn up.
> >>>> 
> >>>> I'd add a table and fallback.
> >>>> 
> >>> 
> >>> Hi folks,
> >>> 
> >>> I want to follow up this a bit and check whether we reached a consensus 
> >>> on how to fix the timeout issue for Atmel chip.
> >>> 
> >>> Should we revert the changes or introduce the lookup table for chips.
> >>> 
> >>> Is there anything I can help from Rubrik side.
> >>> 
> >>> Thanks
> >>> Hao
> >> 
> >> There is nothing to revert as the previous was not applied but I'm
> >> of course ready to review any new attempts.
> >> 
> > 
> > Hi Jarkko,
> > 
> > By “revert” I meant we revert the timeout value changes by applying
> > the patch I proposed, as the timeout value discussed does cause issues.
> > 
> > Why don’t we apply the patch and improve the perf in the way of not
> > breaking TPMs ? 
> > 
> > Hao
> 
> Hi Jarkko and folks,
> 
> It’s being a while since our last discussion. I want to push a fix in the upstream for ateml chip. 
> It looks like we currently have following choices:
> 1.  generic fix for all vendors: have a lookup table for sleep time of wait_for_tpm_stat 
>   (i.e. TPM_TIMEOUT_WAIT_STAT in my proposed patch) 
> 2.  quick fix for the regression: change the sleep time of wait_for_tpm_stat back to 15ms.
>   It is the current proposed patch
> 3. Fix regression by making exception for ateml chip.  
> 
> Should we reach consensus on which one we want to pursue before dig
> into implementation of the patch? In my opinion, I prefer to fix the
> regression with 2, and then pursue 1 as long-term solution. 3 is
> hacky.

What does option 1 fix for *all* vendors?

> Let me know what do you guys think
> 
> Hao

/Jarkko
