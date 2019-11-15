Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 80D9CFE82B
	for <lists+linux-integrity@lfdr.de>; Fri, 15 Nov 2019 23:40:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726983AbfKOWkd (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 15 Nov 2019 17:40:33 -0500
Received: from mga01.intel.com ([192.55.52.88]:32679 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726953AbfKOWkc (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 15 Nov 2019 17:40:32 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Nov 2019 14:40:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,309,1569308400"; 
   d="scan'208";a="203699427"
Received: from bpgilles-mobl1.ger.corp.intel.com (HELO localhost) ([10.251.95.141])
  by fmsmga007.fm.intel.com with ESMTP; 15 Nov 2019 14:40:26 -0800
Date:   Sat, 16 Nov 2019 00:40:25 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Jerry Snitselaar <jsnitsel@redhat.com>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        Peter Huewe <peterhuewe@gmx.de>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        linux-stable@vger.kernel.org,
        Christian Bundy <christianbundy@fraction.io>
Subject: Re: [PATCH] tpm_tis: turn on TPM before calling tpm_get_timeouts
Message-ID: <20191115224025.GA29389@linux.intel.com>
References: <20191111233418.17676-1-jsnitsel@redhat.com>
 <20191112200328.GA11213@linux.intel.com>
 <CALzcddtMiSzhgZv5R6xqb1Amyk7cdY4mJdYDS86KRxH4wR_EGA@mail.gmail.com>
 <20191112202623.GB5584@ziepe.ca>
 <CALzcddtse-4bKWaA0+ns-gVKGyQzMrYWS4n1rFpbbhKLb83z7g@mail.gmail.com>
 <20191114165357.GA11107@linux.intel.com>
 <20191114165629.GC26068@ziepe.ca>
 <20191115174329.GA22029@linux.intel.com>
 <20191115183621.GD4055@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191115183621.GD4055@ziepe.ca>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, Nov 15, 2019 at 02:36:21PM -0400, Jason Gunthorpe wrote:
> On Fri, Nov 15, 2019 at 07:43:29PM +0200, Jarkko Sakkinen wrote:
> > On Thu, Nov 14, 2019 at 12:56:29PM -0400, Jason Gunthorpe wrote:
> > > On Thu, Nov 14, 2019 at 06:55:06PM +0200, Jarkko Sakkinen wrote:
> > > > > Would it function with the timeout values set at the beginning of
> > > > > tpm_tis_core_init (max values)?
> > > > 
> > > > tpm_get_timeouts() should be replaced with:
> > > > 
> > > > if (tpm_chip_start()) {
> > > > 	dev_err(dev, "Could not get TPM timeouts and durations\n");
> > > > 	rc = -ENODEV;
> > > > 	goto out_err;
> > > > }
> > > > 
> > > > tpm_stop_chip(chip);
> > > > 
> > > > tpm_get_timeouts() is called by tpm_auto_startup(). Also the function
> > > > should be moved to tpm_chip.c and converted to a static function so
> > > > that it won't be called from random cal sites like above.
> > > 
> > > Careful, the design here was to allow a driver to do only
> > > get_timeouts, then additional setup work, then do auto_startup()
> > > 
> > > Forcing a driver to do auto_startup too early may not be good.
> > 
> > All drivers always do it anyway because all drivers always call
> > tpm_chip_register().
> 
> But chip_register is after the driver has done it's setup and after it
> may have called get_timeouts
> 
> auto_setup should not be moved to before chip_register()

I do not see any sense calling from get_timeouts() from call sites
in the same initialization flow.

/Jarkko
