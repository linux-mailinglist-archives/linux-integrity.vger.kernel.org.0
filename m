Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 450EC280ADB
	for <lists+linux-integrity@lfdr.de>; Fri,  2 Oct 2020 01:04:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387465AbgJAXEb (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 1 Oct 2020 19:04:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:45342 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387510AbgJAXE3 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 1 Oct 2020 19:04:29 -0400
Received: from localhost (83-245-197-237.elisa-laajakaista.fi [83.245.197.237])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 652792075F;
        Thu,  1 Oct 2020 23:04:28 +0000 (UTC)
Date:   Fri, 2 Oct 2020 02:04:26 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     Nayna <nayna@linux.vnet.ibm.com>, Hao Wu <hao.wu@rubrik.com>,
        peterhuewe@gmx.de, jgg@ziepe.ca, arnd@arndb.de,
        gregkh@linuxfoundation.org, Hamza Attak <hamza@hpe.com>,
        why2jjj.linux@gmail.com, zohar@linux.vnet.ibm.com,
        linux-integrity@vger.kernel.org,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        Ken Goldman <kgold@linux.ibm.com>,
        Seungyeop Han <seungyeop.han@rubrik.com>,
        Shrihari Kalkar <shrihari.kalkar@rubrik.com>,
        Anish Jhaveri <anish.jhaveri@rubrik.com>
Subject: Re: [PATCH] Fix Atmel TPM crash caused by too frequent queries
Message-ID: <20201001230426.GA26517@linux.intel.com>
References: <20200930021637.GF808399@linux.intel.com>
 <a97706be196e2e02ca815b3011d3731684905737.camel@HansenPartnership.com>
 <20200930153715.GC52739@linux.intel.com>
 <95aafaa1e3037cb7b99ae0e76c02a419d366a407.camel@HansenPartnership.com>
 <20200930210956.GC65339@linux.intel.com>
 <6e7b54c268d25a86f8f969bcc01729eaadef6530.camel@HansenPartnership.com>
 <20201001015051.GA5971@linux.intel.com>
 <1aed1b0734435959d5e53b8a4b3c18558243e6b8.camel@HansenPartnership.com>
 <19de5527-2d56-6a07-3ce7-ba216b208090@linux.vnet.ibm.com>
 <38e165055bae62d4e97f702c05e3a76ccdeeac0f.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <38e165055bae62d4e97f702c05e3a76ccdeeac0f.camel@HansenPartnership.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Oct 01, 2020 at 11:32:59AM -0700, James Bottomley wrote:
> On Thu, 2020-10-01 at 14:15 -0400, Nayna wrote:
> > On 10/1/20 12:53 AM, James Bottomley wrote:
> > > On Thu, 2020-10-01 at 04:50 +0300, Jarkko Sakkinen wrote:
> > > > On Wed, Sep 30, 2020 at 03:31:20PM -0700, James Bottomley wrote:
> > > > > On Thu, 2020-10-01 at 00:09 +0300, Jarkko Sakkinen wrote:
> [...]
> > > > > > I also wonder if we could adjust the frequency dynamically.
> > > > > > I.e. start with optimistic value and lower it until finding
> > > > > > the sweet spot.
> > > > >  
> > > > > The problem is the way this crashes: the TPM seems to be
> > > > > unrecoverable. If it were recoverable without a hard reset of
> > > > > the entire machine, we could certainly play around with it.  I
> > > > > can try alternative mechanisms to see if anything's viable, but
> > > > > to all intents and purposes, it looks like my TPM simply stops
> > > > > responding to the TIS interface.
> > > >  
> > > > A quickly scraped idea probably with some holes in it but I was
> > > > thinking something like
> > > > 
> > > > 1. Initially set slow value for latency, this could be the
> > > > original 15 ms.
> > > > 2. Use this to read TPM_PT_VENDOR_STRING_*.
> > > > 3. Lookup based vendor string from a fixup table a latency that
> > > > works
> > > >     (the fallback latency could be the existing latency).
> > >  
> > > Well, yes, that was sort of what I was thinking of doing for the
> > > Atmel ... except I was thinking of using the TIS VID (16 byte
> > > assigned vendor ID) which means we can get the information to set
> > > the timeout before we have to do any TPM operations.
> > 
> > I wonder if the timeout issue exists for all TPM commands for the
> > same manufacturer.  For example, does the ATMEL TPM also crash when 
> > extending  PCRs ?
> > 
> > In addition to defining a per TPM vendor based lookup table for
> > timeout, would it be a good idea to also define a Kconfig/boot param
> > option to allow timeout setting.  This will enable to set the timeout
> > based on the specific use.
> 
> I don't think we need go that far (yet).  The timing change has been in
> upstream since:
> 
> commit 424eaf910c329ab06ad03a527ef45dcf6a328f00
> Author: Nayna Jain <nayna@linux.vnet.ibm.com>
> Date:   Wed May 16 01:51:25 2018 -0400
> 
>     tpm: reduce polling time to usecs for even finer granularity
>  
> Which was in the released kernel 4.18: over two years ago.  In all that
> time we've discovered two problems: mine which looks to be an artifact
> of an experimental upgrade process in a new nuvoton and the Atmel. 
> That means pretty much every other TPM simply works with the existing
> timings
> 
> > I was also thinking how will we decide the lookup table values for
> > each vendor ?
> 
> I wasn't thinking we would.  I was thinking I'd do a simple exception
> for the Atmel and nothing else.  I don't think my Nuvoton is in any way
> characteristic.  Indeed my pluggable TPM rainbow bridge system works
> just fine with a Nuvoton and the current timings.
> 
> We can add additional exceptions if they actually turn up.

I'd add a table and fallback.

/Jarkko
