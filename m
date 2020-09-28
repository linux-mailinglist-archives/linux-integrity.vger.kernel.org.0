Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B65A027B1E8
	for <lists+linux-integrity@lfdr.de>; Mon, 28 Sep 2020 18:31:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726344AbgI1QbT (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 28 Sep 2020 12:31:19 -0400
Received: from mga17.intel.com ([192.55.52.151]:7279 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726420AbgI1QbT (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 28 Sep 2020 12:31:19 -0400
IronPort-SDR: FFw32fLlbUQwOkRNLr1fAvuM4mvTEXyFWbUSYWh5a+0t549Ir5iBkzgAXSgB39lPBHdPru7DGF
 gzMLrLfWNJ1A==
X-IronPort-AV: E=McAfee;i="6000,8403,9758"; a="142040579"
X-IronPort-AV: E=Sophos;i="5.77,313,1596524400"; 
   d="scan'208";a="142040579"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2020 09:31:18 -0700
IronPort-SDR: +jy7XHIwlZ7PTs8v3KBiP4XcMnv2hKruxPrTbpo59bfYFOF8NmUh77geeZl7d6Xq/13RsX/pHv
 s3dgP6As1PKA==
X-IronPort-AV: E=Sophos;i="5.77,313,1596524400"; 
   d="scan'208";a="488645586"
Received: from gboudouk-mobl2.ger.corp.intel.com (HELO localhost) ([10.249.33.127])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2020 09:31:16 -0700
Date:   Mon, 28 Sep 2020 19:31:14 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     linux-integrity@vger.kernel.org
Subject: Re: [PATCH] tpm: only export stand alone version of flush context
 command
Message-ID: <20200928163114.GC92669@linux.intel.com>
References: <e63012add04eee75d67d15f55fe4f6b68fb1d6ed.camel@HansenPartnership.com>
 <20200928001138.GE5283@linux.intel.com>
 <4b5a58aedb596937618dd7d8fecda9743371d101.camel@HansenPartnership.com>
 <20200928112046.GA14051@linux.intel.com>
 <3f369592267e8f502f435584b9220e81263eae2c.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3f369592267e8f502f435584b9220e81263eae2c.camel@HansenPartnership.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Sep 28, 2020 at 07:50:31AM -0700, James Bottomley wrote:
> On Mon, 2020-09-28 at 14:20 +0300, Jarkko Sakkinen wrote:
> > On Sun, Sep 27, 2020 at 06:03:37PM -0700, James Bottomley wrote:
> > > On Mon, 2020-09-28 at 03:11 +0300, Jarkko Sakkinen wrote:
> > > > On Sun, Sep 27, 2020 at 04:17:40PM -0700, James Bottomley wrote:
> [...]
> > > > > +EXPORT_SYMBOL_GPL(tpm2_flush_context_cmd);
> > > > 
> > > > Otherwise fine but please rename the existing function as
> > > > __tpm2_flush_context() and exported as tpm2_flush_context().
> > > 
> > > If I do this it churns the code base more: we have one external
> > > consumer and four internal ones, so now each of the internal ones
> > > would have to become __tpm_flush_context().  We also have
> > > precedence for the xxx_cmd form with tpm2_unseal_cmd,
> > > tpm2_load_cmd.
> > 
> > There are no internals version of aforementioned functions, but in
> > the sense of common convention for such that encapsulate a single TPM
> > command and nothing more or less, your argument make sense.
> 
> By internal, I mean use within the tpm core that doesn't require
> get/put ops ... there are four of them.
> 
> > But it is somewhat common pattern to prefix internal/unlocked version
> > with two underscores. So summarizing this I think that the best names
> > would be __tpm2_flush_context_cmd() and tpm2_flush_context_cmd().
> > 
> > But now that I looked at your patch, I remembered the reason why the
> > function in question does not take ops, albeit I'm not fully in the
> > page why this was not properly implemented in trusted_tpm2.c.
> > 
> > The principal idea was that the client, e.g. trusted keys would take
> > the ops and execute series of commands and then return ops.
> > Otherwise, there is a probel in atomicity, i.e. someone could race
> > between unseal and flush.
> > 
> > int tpm2_unseal_trusted(struct tpm_chip *chip,
> > 			struct trusted_key_payload *payload,
> > 			struct trusted_key_options *options)
> > {
> > 	u32 blob_handle;
> > 	int rc;
> > 
> > 	rc = tpm_try_get_ops(chip);
> > 	if (rc)
> > 		goto out;
> > 
> > 	rc = tpm2_load_cmd(chip, payload, options, &blob_handle);
> > 	if (rc)
> > 		goto out;
> > 
> > 	rc = tpm2_unseal_cmd(chip, payload, options, blob_handle);
> > 	tpm2_flush_context(chip, blob_handle);
> > 
> > out:
> > 	tpm_put_ops(chip);
> > 	return rc;
> > }
> > 
> > In addition to this fix, I think we should put a note to kdoc of each
> > exported function that please grab the ops before using.
> 
> Well, um, that's precisely what this function originally did when it
> was inside drivers/char/tpm.  You told the guy who did the move into
> security/keys/trusted-keys to convert everything to use tpm_send which
> encapsulates the get/put operation, which is why we now have the flush
> bug.  If you really want it done like this, then I'd recommend moving
> everything back to drivers/char/tpm so we don't have to do a global
> exposure of a load of tpm internal functions (i.e. move them from
> drivers/char/tmp.h to include/linux/tpm.h and do an export on them).

My BuildRoot test image did not include the patch. I was wondering why I
did not bump into deadlock with the fix candidate :-/ Forgot export
LINUX_OVERRIDE_SRCDIR.

But you are absolutely correct, thanks for recalling. I made a mistake
there.

I do disagree though that this should be moved back to drivers/char/tpm,
as also TPM 1.x code lives in trusted-keys. It is good to have API for
doing sequences TPM commands and keep the core in drivers/char/tpm.

If you look at tpm_send() it is in essence just simply locking TPM and
and calling tpm_transmit_cmd(). And tpm_transmit_cmd() is already an
exported symbol. It only needs to be declared in include/linux/tpm.h.

I'd suggest that I refine my series to call tpm_transmit_cmd() and we
have a fairly clean solution where the load sequence is atomic.

/Jarkko>
