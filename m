Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A995027B2B3
	for <lists+linux-integrity@lfdr.de>; Mon, 28 Sep 2020 19:07:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726477AbgI1RH0 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 28 Sep 2020 13:07:26 -0400
Received: from mga11.intel.com ([192.55.52.93]:52877 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726348AbgI1RH0 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 28 Sep 2020 13:07:26 -0400
IronPort-SDR: wU9ISrNAVV46kRB/KOzDDbjyKaExKCAQyKZMQx89tOoUKFEFobjtXr3pKwBsLYTL9rV1wOwcfH
 qrhew7qB0pxQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9758"; a="159369951"
X-IronPort-AV: E=Sophos;i="5.77,313,1596524400"; 
   d="scan'208";a="159369951"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2020 10:07:24 -0700
IronPort-SDR: Tn7UtLy47/D2wRpwNuC5Cb6bbFmR7H5rTRhTjlTvQg0caq+KLhLDwOAHWkOAUJCJjvumZSMDvX
 ZHE5SfAhF6aw==
X-IronPort-AV: E=Sophos;i="5.77,313,1596524400"; 
   d="scan'208";a="488665188"
Received: from evinhugx-mobl1.ger.corp.intel.com (HELO localhost) ([10.252.44.118])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2020 10:07:23 -0700
Date:   Mon, 28 Sep 2020 20:07:20 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     linux-integrity@vger.kernel.org
Subject: Re: [PATCH] tpm: only export stand alone version of flush context
 command
Message-ID: <20200928170720.GA119268@linux.intel.com>
References: <e63012add04eee75d67d15f55fe4f6b68fb1d6ed.camel@HansenPartnership.com>
 <20200928001138.GE5283@linux.intel.com>
 <4b5a58aedb596937618dd7d8fecda9743371d101.camel@HansenPartnership.com>
 <20200928112046.GA14051@linux.intel.com>
 <3f369592267e8f502f435584b9220e81263eae2c.camel@HansenPartnership.com>
 <20200928163114.GC92669@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200928163114.GC92669@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Sep 28, 2020 at 07:31:18PM +0300, Jarkko Sakkinen wrote:
> > Well, um, that's precisely what this function originally did when it
> > was inside drivers/char/tpm.  You told the guy who did the move into
> > security/keys/trusted-keys to convert everything to use tpm_send which
> > encapsulates the get/put operation, which is why we now have the flush
> > bug.  If you really want it done like this, then I'd recommend moving
> > everything back to drivers/char/tpm so we don't have to do a global
> > exposure of a load of tpm internal functions (i.e. move them from
> > drivers/char/tmp.h to include/linux/tpm.h and do an export on them).
> 
> My BuildRoot test image did not include the patch. I was wondering why I
> did not bump into deadlock with the fix candidate :-/ Forgot export
> LINUX_OVERRIDE_SRCDIR.
> 
> But you are absolutely correct, thanks for recalling. I made a mistake
> there.
> 
> I do disagree though that this should be moved back to drivers/char/tpm,
> as also TPM 1.x code lives in trusted-keys. It is good to have API for
> doing sequences TPM commands and keep the core in drivers/char/tpm.
> 
> If you look at tpm_send() it is in essence just simply locking TPM and
> and calling tpm_transmit_cmd(). And tpm_transmit_cmd() is already an
> exported symbol. It only needs to be declared in include/linux/tpm.h.
> 
> I'd suggest that I refine my series to call tpm_transmit_cmd() and we
> have a fairly clean solution where the load sequence is atomic.

I see that it is perfectly fine to make tpm_transmit_cmd() globally
callable. It is already used by tpm_vtpm_proxy and does have clear
semantics.

The way you use it is just:

1. tpm_try_get_ops
2. Use tpm_transmit_cmd() N times.
3. tpm_put_ops

If we moved TPM 2.x trusted keys code back to drivers/char/tpm,for the
sake of consistency the same would have to be done for TPM 1.2 code. I'd
rather fix the regression and be done with it.

Or if reverted like that, also asym_tpm.c code should also live inside
the TPM driver directory.

All this work with tpm_buf and the locking functions makes most sense if
it gives ability for callers to build their own TPM commands

I'm right now building test image with v3 of my fixes (this time
properly included to the kernel image). I also uploaded the (untested)
patches over here:

https://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git/log/?h=trusted-fix

/Jarkko
