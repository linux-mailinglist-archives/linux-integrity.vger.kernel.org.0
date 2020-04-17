Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DF7D1AE8CC
	for <lists+linux-integrity@lfdr.de>; Sat, 18 Apr 2020 01:58:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726639AbgDQXzq (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 17 Apr 2020 19:55:46 -0400
Received: from mga18.intel.com ([134.134.136.126]:11627 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726619AbgDQXza (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 17 Apr 2020 19:55:30 -0400
IronPort-SDR: YGV7UFjQpCvqc3+ZDqUhhHSW45SZo9mg3znXiYG2qkl2sduxpRgr5BjfmwKAzaOnGU78qsQnDm
 0SknHrML0D/A==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2020 16:55:29 -0700
IronPort-SDR: K+5T/j6lCyL3btQnzW68O2Iqs4TXn3eFAnpZCr8tKO1QjUM1aCD0CU6tWHhCETRxgaDTvIhNe9
 0PnAPM3mpUNw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,395,1580803200"; 
   d="scan'208";a="272580943"
Received: from zhiwang1-mobl5.ger.corp.intel.com (HELO localhost) ([10.252.42.90])
  by orsmga002.jf.intel.com with ESMTP; 17 Apr 2020 16:55:27 -0700
Date:   Sat, 18 Apr 2020 02:55:27 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     Omar Sandoval <osandov@osandov.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-integrity@vger.kernel.org
Subject: Re: [PATCH] tpm_tis: work around status register bug in
 STMicroelectronics TPM
Message-ID: <20200417235527.GB85230@linux.intel.com>
References: <6c55d7c1fb84e5bf2ace9f05ec816ef67bd873e1.1586990595.git.osandov@fb.com>
 <1586994699.3931.18.camel@HansenPartnership.com>
 <20200416001605.GA673482@vader>
 <20200416002442.GB673482@vader>
 <1587060171.15329.7.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1587060171.15329.7.camel@HansenPartnership.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Apr 16, 2020 at 11:02:51AM -0700, James Bottomley wrote:
> On Wed, 2020-04-15 at 17:24 -0700, Omar Sandoval wrote:
> > On Wed, Apr 15, 2020 at 05:16:05PM -0700, Omar Sandoval wrote:
> > > On Wed, Apr 15, 2020 at 04:51:39PM -0700, James Bottomley wrote:
> > > > On Wed, 2020-04-15 at 15:45 -0700, Omar Sandoval wrote:
> > > > > From: Omar Sandoval <osandov@fb.com>
> > > > > 
> > > > > We've encountered a particular model of STMicroelectronics TPM
> > > > > that transiently returns a bad value in the status register.
> > > > > This causes the kernel to believe that the TPM is ready to
> > > > > receive a command when it actually isn't, which in turn causes
> > > > > the send to time out in get_burstcount(). In testing, reading
> > > > > the status register one extra time convinces the TPM to return
> > > > > a valid value.
> > > > 
> > > > Interesting, I've got a very early upgradeable nuvoton that seems
> > > > to be behaving like this.
> > > 
> > > I'll attach the userspace reproducer I used to figure this out. I'd
> > > be interested to see if it times out on your TPM, too. Note that it
> > > bangs on /dev/mem and assumes that the MMIO address is 0xfed40000.
> > > That seems to be the hard-coded address for x86 in the kernel, but
> > > just to be safe you might want to check `grep MSFT0101
> > > /proc/iomem`.
> > 
> > Forgot to attach it, of course...
> 
> 
> Thanks!  You facebook guys run with interesting kernel options ... I
> eventually had to disable CONFIG_STRICT_DEVMEM and rebuild my kernel to
> get it to run.
> 
> However, the bad news is that this isn't my problem, it seems to be
> more timeout related  I get the same symptoms: logs full of
> 
> [14570.626594] tpm tpm0: tpm_try_transmit: tpm_send: error -62
> 
> and the TPM won't recover until the box is reset.  To get my TPM to be
> usable, I have to fiddle our default timeouts like this:
> 
> --- a/drivers/char/tpm/tpm.h
> +++ b/drivers/char/tpm/tpm.h
> @@ -41,8 +41,8 @@ enum tpm_timeout {
>         TPM_TIMEOUT_RETRY = 100, /* msecs */
>         TPM_TIMEOUT_RANGE_US = 300,     /* usecs */
>         TPM_TIMEOUT_POLL = 1,   /* msecs */
> -       TPM_TIMEOUT_USECS_MIN = 100,      /* usecs */
> -       TPM_TIMEOUT_USECS_MAX = 500      /* usecs */
> +       TPM_TIMEOUT_USECS_MIN = 750,      /* usecs */
> +       TPM_TIMEOUT_USECS_MAX = 1000,      /* usecs */
>  };
> 
> But I think the problem is unique to my nuvoton because there haven't
> been any other reports of problems like this ... and with these
> timeouts my system functions normally in spite of me being a heavy TPM
> user.

What downsides there would be to increase these a bit?

/Jarkko
