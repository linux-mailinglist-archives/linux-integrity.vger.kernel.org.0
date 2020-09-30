Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF3BB27DDD7
	for <lists+linux-integrity@lfdr.de>; Wed, 30 Sep 2020 03:40:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729205AbgI3BkV (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 29 Sep 2020 21:40:21 -0400
Received: from mga01.intel.com ([192.55.52.88]:48864 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726689AbgI3BkV (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 29 Sep 2020 21:40:21 -0400
IronPort-SDR: Qn/O/V1ZasXIgt4XsKG3Rv9dRz8o37/ftZjdHl6Kcq974AIURNCBMPCD36iQQKGBwIuRkULBf8
 KQLGfI+3KEEA==
X-IronPort-AV: E=McAfee;i="6000,8403,9759"; a="180491941"
X-IronPort-AV: E=Sophos;i="5.77,320,1596524400"; 
   d="scan'208";a="180491941"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2020 18:40:20 -0700
IronPort-SDR: YBIXJiqL10a0BBmm47Abr6/fhIkuMOaQF1faavkromk149HAMMkAnIxIvqBSYN6iUaiBKsbUar
 U5BsdT92mXDg==
X-IronPort-AV: E=Sophos;i="5.77,320,1596524400"; 
   d="scan'208";a="457480643"
Received: from xinpan-mobl.ger.corp.intel.com (HELO localhost) ([10.249.35.239])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2020 18:40:18 -0700
Date:   Wed, 30 Sep 2020 04:40:15 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, linux-integrity@vger.kernel.org,
        Peter Huewe <peterhuewe@gmx.de>
Subject: Re: [PATCH] tpm_tis: Add a check for invalid status
Message-ID: <20200930014004.GC808399@linux.intel.com>
References: <9bad3da0c31ae2620aaae0d75748c3387afa3d47.camel@HansenPartnership.com>
 <20200928183351.GA587339@ziepe.ca>
 <f0dcade667d226e982db89389fd0d86368c67ba9.camel@HansenPartnership.com>
 <20200930013754.GB808399@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200930013754.GB808399@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Sep 30, 2020 at 04:37:58AM +0300, Jarkko Sakkinen wrote:
> On Mon, Sep 28, 2020 at 02:15:33PM -0700, James Bottomley wrote:
> > On Mon, 2020-09-28 at 15:33 -0300, Jason Gunthorpe wrote:
> > > On Mon, Sep 28, 2020 at 11:00:12AM -0700, James Bottomley wrote:
> > > > Some TIS based TPMs can return 0xff to status reads if the locality
> > > > hasn't been properly requested.  Detect this condition by checking
> > > > the bits that the TIS spec specifies must return zero are clear and
> > > > return zero in that case.  Also drop a warning so the problem can
> > > > be identified in the calling path and fixed (usually a missing
> > > > try_get_ops()).
> > > > 
> > > > Signed-off-by: James Bottomley <
> > > > James.Bottomley@HansenPartnership.com>
> > > > 
> > > > This is the patch I've been using to catch and kill all the points
> > > > in the stack where we're not properly using get/put ops on the tpm
> > > > chip.
> > > 
> > > If this is a problem add a lockdep on ops_sem in various places too?
> > 
> > It's not really possible because of the init issue with checking the
> > interrupt.  That originally had no locking at all (it doesn't need any
> > because the TPM device isn't publicly exposed at the point the check is
> > done).  If the patch to add get/put around the tpm2_get_tpm_pt is
> > acceptable, then perhaps we could because I think that's the last
> > unguarded use of tpm_tis_status.
> > 
> > James
> 
> I think this sanity check would not hurt at all.
> 
> We should also improve the testing coverage. E.g. there is zero coverage
> for trusted keys. It can easily lead weird conclusions if there is no
> common test to run.
> 
> I touched that over here:
> 
> https://lore.kernel.org/linux-integrity/20200929225841.GA805025@linux.intel.com/
> 
> Anyway, I will apply this for sure.
> 
> Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

Has been applied.

/Jarkko
