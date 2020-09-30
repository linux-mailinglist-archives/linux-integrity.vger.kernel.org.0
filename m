Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9DF827DDD1
	for <lists+linux-integrity@lfdr.de>; Wed, 30 Sep 2020 03:38:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729395AbgI3BiB (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 29 Sep 2020 21:38:01 -0400
Received: from mga18.intel.com ([134.134.136.126]:11154 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726689AbgI3BiA (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 29 Sep 2020 21:38:00 -0400
IronPort-SDR: iXLPaGT8T4whbV/pbrv9Rt3wjFaTddNEk85a3Kz0+WNqU8kTI1+/lmkrFej1hWANf4TZ3GmolA
 yYA7gMGYxFNQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9759"; a="150111163"
X-IronPort-AV: E=Sophos;i="5.77,320,1596524400"; 
   d="scan'208";a="150111163"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2020 18:37:59 -0700
IronPort-SDR: lfdkOOMSmIu4SxUiYlgqgpCaMYARQtb+r+JCHiGWh6FrKlfD+fV+dxk5HQdWT47TYELhsAaUAq
 veY9hC666NLg==
X-IronPort-AV: E=Sophos;i="5.77,320,1596524400"; 
   d="scan'208";a="494697200"
Received: from jwilliam-mobl.ger.corp.intel.com (HELO localhost) ([10.252.47.189])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2020 18:37:56 -0700
Date:   Wed, 30 Sep 2020 04:37:54 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, linux-integrity@vger.kernel.org,
        Peter Huewe <peterhuewe@gmx.de>
Subject: Re: [PATCH] tpm_tis: Add a check for invalid status
Message-ID: <20200930013754.GB808399@linux.intel.com>
References: <9bad3da0c31ae2620aaae0d75748c3387afa3d47.camel@HansenPartnership.com>
 <20200928183351.GA587339@ziepe.ca>
 <f0dcade667d226e982db89389fd0d86368c67ba9.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f0dcade667d226e982db89389fd0d86368c67ba9.camel@HansenPartnership.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Sep 28, 2020 at 02:15:33PM -0700, James Bottomley wrote:
> On Mon, 2020-09-28 at 15:33 -0300, Jason Gunthorpe wrote:
> > On Mon, Sep 28, 2020 at 11:00:12AM -0700, James Bottomley wrote:
> > > Some TIS based TPMs can return 0xff to status reads if the locality
> > > hasn't been properly requested.  Detect this condition by checking
> > > the bits that the TIS spec specifies must return zero are clear and
> > > return zero in that case.  Also drop a warning so the problem can
> > > be identified in the calling path and fixed (usually a missing
> > > try_get_ops()).
> > > 
> > > Signed-off-by: James Bottomley <
> > > James.Bottomley@HansenPartnership.com>
> > > 
> > > This is the patch I've been using to catch and kill all the points
> > > in the stack where we're not properly using get/put ops on the tpm
> > > chip.
> > 
> > If this is a problem add a lockdep on ops_sem in various places too?
> 
> It's not really possible because of the init issue with checking the
> interrupt.  That originally had no locking at all (it doesn't need any
> because the TPM device isn't publicly exposed at the point the check is
> done).  If the patch to add get/put around the tpm2_get_tpm_pt is
> acceptable, then perhaps we could because I think that's the last
> unguarded use of tpm_tis_status.
> 
> James

I think this sanity check would not hurt at all.

We should also improve the testing coverage. E.g. there is zero coverage
for trusted keys. It can easily lead weird conclusions if there is no
common test to run.

I touched that over here:

https://lore.kernel.org/linux-integrity/20200929225841.GA805025@linux.intel.com/

Anyway, I will apply this for sure.

Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

/Jarkko
