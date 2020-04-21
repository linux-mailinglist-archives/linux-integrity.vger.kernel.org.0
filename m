Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96E381B311F
	for <lists+linux-integrity@lfdr.de>; Tue, 21 Apr 2020 22:23:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726050AbgDUUX6 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 21 Apr 2020 16:23:58 -0400
Received: from mga18.intel.com ([134.134.136.126]:6521 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725930AbgDUUX6 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 21 Apr 2020 16:23:58 -0400
IronPort-SDR: 3v/ulzJBOLUXj5m8CILk78bFXFqomuOtSGKWleIu1GJXIhlxMivVs1JyP2HAtbB2nNJW268eOb
 3+pB5DL3ArjQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2020 13:23:58 -0700
IronPort-SDR: GWahByy9ja+RBrFUn9mAhUPSyOveTPRw52A6Osiki9rOOeU66d33nPt2WCB6EigIn6kSGTtBo1
 RCB0F5aJ3kpg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,411,1580803200"; 
   d="scan'208";a="245778611"
Received: from mnchalux-mobl2.gar.corp.intel.com (HELO localhost) ([10.252.44.234])
  by fmsmga007.fm.intel.com with ESMTP; 21 Apr 2020 13:23:56 -0700
Date:   Tue, 21 Apr 2020 23:23:55 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     zohar@linux.ibm.com, Omar Sandoval <osandov@osandov.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-integrity@vger.kernel.org
Subject: Re: [PATCH] tpm_tis: work around status register bug in
 STMicroelectronics TPM
Message-ID: <20200421202355.GC46589@linux.intel.com>
References: <6c55d7c1fb84e5bf2ace9f05ec816ef67bd873e1.1586990595.git.osandov@fb.com>
 <1586994699.3931.18.camel@HansenPartnership.com>
 <20200416001605.GA673482@vader>
 <20200416002442.GB673482@vader>
 <1587060171.15329.7.camel@HansenPartnership.com>
 <20200417235527.GB85230@linux.intel.com>
 <1587168748.5867.2.camel@HansenPartnership.com>
 <20200420204641.GA14637@linux.intel.com>
 <1587421686.3493.2.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1587421686.3493.2.camel@HansenPartnership.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Apr 20, 2020 at 03:28:06PM -0700, James Bottomley wrote:
> On Mon, 2020-04-20 at 23:46 +0300, Jarkko Sakkinen wrote:
> > On Fri, Apr 17, 2020 at 05:12:28PM -0700, James Bottomley wrote:
> > > On Sat, 2020-04-18 at 02:55 +0300, Jarkko Sakkinen wrote:
> > > > On Thu, Apr 16, 2020 at 11:02:51AM -0700, James Bottomley wrote:
> > > > > On Wed, 2020-04-15 at 17:24 -0700, Omar Sandoval wrote:
> > > > > > On Wed, Apr 15, 2020 at 05:16:05PM -0700, Omar Sandoval
> > > > > > wrote:
> > > > > > > On Wed, Apr 15, 2020 at 04:51:39PM -0700, James Bottomley
> > > > > > > wrote:
> > > > > > > > On Wed, 2020-04-15 at 15:45 -0700, Omar Sandoval wrote:
> > > > > > > > > From: Omar Sandoval <osandov@fb.com>
> > > > > > > > > 
> > > > > > > > > We've encountered a particular model of
> > > > > > > > > STMicroelectronics
> > > > > > > > > TPM
> > > > > > > > > that transiently returns a bad value in the status
> > > > > > > > > register.
> > > > > > > > > This causes the kernel to believe that the TPM is ready
> > > > > > > > > to
> > > > > > > > > receive a command when it actually isn't, which in turn
> > > > > > > > > causes
> > > > > > > > > the send to time out in get_burstcount(). In testing,
> > > > > > > > > reading
> > > > > > > > > the status register one extra time convinces the TPM to
> > > > > > > > > return
> > > > > > > > > a valid value.
> > > > > > > > 
> > > > > > > > Interesting, I've got a very early upgradeable nuvoton
> > > > > > > > that seems to be behaving like this.
> > > > > > > 
> > > > > > > I'll attach the userspace reproducer I used to figure this
> > > > > > > out. I'd be interested to see if it times out on your TPM,
> > > > > > > too. Note that it bangs on /dev/mem and assumes that the
> > > > > > > MMIO address is 0xfed40000. That seems to be the hard-
> > > > > > > coded 
> > > > > > > address for x86 in the kernel, but just to be safe you
> > > > > > > might want to check `grep MSFT0101 /proc/iomem`.
> > > > > > 
> > > > > > Forgot to attach it, of course...
> > > > > 
> > > > > 
> > > > > Thanks!  You facebook guys run with interesting kernel options
> > > > > ... I eventually had to disable CONFIG_STRICT_DEVMEM and
> > > > > rebuild my kernel to get it to run.
> > > > > 
> > > > > However, the bad news is that this isn't my problem, it seems
> > > > > to be more timeout related  I get the same symptoms: logs full
> > > > > of
> > > > > 
> > > > > [14570.626594] tpm tpm0: tpm_try_transmit: tpm_send: error -62
> > > > > 
> > > > > and the TPM won't recover until the box is reset.  To get my
> > > > > TPM to be usable, I have to fiddle our default timeouts like
> > > > > this:
> > > > > 
> > > > > --- a/drivers/char/tpm/tpm.h
> > > > > +++ b/drivers/char/tpm/tpm.h
> > > > > @@ -41,8 +41,8 @@ enum tpm_timeout {
> > > > >         TPM_TIMEOUT_RETRY = 100, /* msecs */
> > > > >         TPM_TIMEOUT_RANGE_US = 300,     /* usecs */
> > > > >         TPM_TIMEOUT_POLL = 1,   /* msecs */
> > > > > -       TPM_TIMEOUT_USECS_MIN = 100,      /* usecs */
> > > > > -       TPM_TIMEOUT_USECS_MAX = 500      /* usecs */
> > > > > +       TPM_TIMEOUT_USECS_MIN = 750,      /* usecs */
> > > > > +       TPM_TIMEOUT_USECS_MAX = 1000,      /* usecs */
> > > > >  };
> > > > > 
> > > > > But I think the problem is unique to my nuvoton because there
> > > > > haven't been any other reports of problems like this ... and
> > > > > with these timeouts my system functions normally in spite of me
> > > > > being a heavy TPM user.
> > > > 
> > > > What downsides there would be to increase these a bit?
> > > 
> > > PCR writes would take longer meaning IMA initialization would
> > > become slower.
> > 
> > Does it matter?
> 
> Not if you're the one telling Mimi ... and I'm at least 1 mile from the
> blast radius.
> 
> But more seriously: Nayna Jain did a series of patches improving the
> time it takes to poll the TPM for operations precisely because the TPM
> PCR extend was going so slowly:
> 
> https://lore.kernel.org/linux-integrity/20180516055125.5685-1-nayna@linux.vnet.ibm.com/
> 
> I also reported the issue shortly after that patch was integrated, but
> everyone seemed to think it was just a problem with my TPM chip (it's
> an early Nuvoton field upgraded to 2.0):
> 
> https://lore.kernel.org/linux-integrity/1531328689.3260.8.camel@HansenPartnership.com/

What if we make it dynamic? I.e. if the init code gets -ETIME, then
increase the timeouts?

/Jarkko
