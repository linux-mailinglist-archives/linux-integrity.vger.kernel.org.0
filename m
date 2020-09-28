Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C557927ADBD
	for <lists+linux-integrity@lfdr.de>; Mon, 28 Sep 2020 14:28:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726328AbgI1M2d (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 28 Sep 2020 08:28:33 -0400
Received: from mga05.intel.com ([192.55.52.43]:44191 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726291AbgI1M2d (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 28 Sep 2020 08:28:33 -0400
IronPort-SDR: 781BTOcpo1JgJ090R5EUfQr9T9fPL5QyMh5slP4TWY2h/WKFKGM8SUaHMysf4K8GVLk93kJ5T3
 or88CTX1FSxg==
X-IronPort-AV: E=McAfee;i="6000,8403,9757"; a="246724957"
X-IronPort-AV: E=Sophos;i="5.77,313,1596524400"; 
   d="scan'208";a="246724957"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2020 05:28:32 -0700
IronPort-SDR: Oup9yfMRi+YMRu9SB7hJ3Gx0i0KdGutbuDHGGozKcxpcBYTVzjAvPykFp5++Tb4BR0xjPMZmjZ
 QVgCL7A0ICXQ==
X-IronPort-AV: E=Sophos;i="5.77,313,1596524400"; 
   d="scan'208";a="488559032"
Received: from memara-mobl.ger.corp.intel.com (HELO localhost) ([10.252.49.157])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2020 05:28:31 -0700
Date:   Mon, 28 Sep 2020 15:28:32 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     linux-integrity@vger.kernel.org
Subject: Re: [PATCH] tpm: only export stand alone version of flush context
 command
Message-ID: <20200928122832.GA28949@linux.intel.com>
References: <e63012add04eee75d67d15f55fe4f6b68fb1d6ed.camel@HansenPartnership.com>
 <20200928001138.GE5283@linux.intel.com>
 <4b5a58aedb596937618dd7d8fecda9743371d101.camel@HansenPartnership.com>
 <20200928112046.GA14051@linux.intel.com>
 <20200928113405.GA17717@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200928113405.GA17717@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Sep 28, 2020 at 02:34:05PM +0300, Jarkko Sakkinen wrote:
> On Mon, Sep 28, 2020 at 02:20:50PM +0300, Jarkko Sakkinen wrote:
> > On Sun, Sep 27, 2020 at 06:03:37PM -0700, James Bottomley wrote:
> > > On Mon, 2020-09-28 at 03:11 +0300, Jarkko Sakkinen wrote:
> > > > On Sun, Sep 27, 2020 at 04:17:40PM -0700, James Bottomley wrote:
> > > > > Remove the currently exported version of flush context, which is
> > > > > designed for tpm core internal use only and substitute a corrected
> > > > > version that does the necessary tpm ops get/put.  This fixes a bug
> > > > > with trusted keys in that some TIS TPMs are unable to flush the
> > > > > loaded secret because the status register isn't reading correctly.
> > > > > 
> > > > > Fixes: 45477b3fe3d1 ("security: keys: trusted: fix lost handle
> > > > > flush")
> > > > > Signed-off-by: James Bottomley <
> > > > > James.Bottomley@HansenPartnership.com>
> > > > > ---
> > > > >  drivers/char/tpm/tpm.h                    |  1 +
> > > > >  drivers/char/tpm/tpm2-cmd.c               | 23
> > > > > ++++++++++++++++++++++-
> > > > >  include/linux/tpm.h                       |  2 +-
> > > > >  security/keys/trusted-keys/trusted_tpm2.c |  2 +-
> > > > >  4 files changed, 25 insertions(+), 3 deletions(-)
> > > > > 
> > > > > diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
> > > > > index 21ac88d4076c..cba09be7ce23 100644
> > > > > --- a/drivers/char/tpm/tpm.h
> > > > > +++ b/drivers/char/tpm/tpm.h
> > > > > @@ -240,6 +240,7 @@ int tpm2_prepare_space(struct tpm_chip *chip,
> > > > > struct tpm_space *space, u8 *cmd,
> > > > >  		       size_t cmdsiz);
> > > > >  int tpm2_commit_space(struct tpm_chip *chip, struct tpm_space
> > > > > *space, void *buf,
> > > > >  		      size_t *bufsiz);
> > > > > +void tpm2_flush_context(struct tpm_chip *chip, u32 handle);
> > > > >  
> > > > >  void tpm_bios_log_setup(struct tpm_chip *chip);
> > > > >  void tpm_bios_log_teardown(struct tpm_chip *chip);
> > > > > diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-
> > > > > cmd.c
> > > > > index 9b84158c5a9e..d5aaea72d578 100644
> > > > > --- a/drivers/char/tpm/tpm2-cmd.c
> > > > > +++ b/drivers/char/tpm/tpm2-cmd.c
> > > > > @@ -362,7 +362,28 @@ void tpm2_flush_context(struct tpm_chip *chip,
> > > > > u32 handle)
> > > > >  	tpm_transmit_cmd(chip, &buf, 0, "flushing context");
> > > > >  	tpm_buf_destroy(&buf);
> > > > >  }
> > > > > -EXPORT_SYMBOL_GPL(tpm2_flush_context);
> > > > > +
> > > > > +/**
> > > > > + * tpm2_flush_context_cmd() - execute a TPM2_FlushContext command
> > > > > + * @chip:	TPM chip to use
> > > > > + * @handle:	context handle
> > > > > + *
> > > > > + * This version of the command is designed to be used outside the
> > > > > + * TPM core so acquires and releases the tpm ops.
> > > > > + */
> > > > > +void tpm2_flush_context_cmd(struct tpm_chip *chip, u32 handle)
> > > > > +{
> > > > > +	int rc;
> > > > > +
> > > > > +	rc = tpm_try_get_ops(chip);
> > > > > +	if (rc) {
> > > > > +		dev_err(&chip->dev, "Failed to acquire tpm ops for
> > > > > flush\n");
> > > > > +		return;
> > > > > +	}
> > > > > +	tpm2_flush_context(chip, handle);
> > > > > +	tpm_put_ops(chip);
> > > > > +}
> > > > > +EXPORT_SYMBOL_GPL(tpm2_flush_context_cmd);
> > > > 
> > > > Otherwise fine but please rename the existing function as
> > > > __tpm2_flush_context() and exported as tpm2_flush_context().
> > > 
> > > If I do this it churns the code base more: we have one external
> > > consumer and four internal ones, so now each of the internal ones would
> > > have to become __tpm_flush_context().  We also have precedence for the
> > > xxx_cmd form with tpm2_unseal_cmd, tpm2_load_cmd.
> > 
> > There are no internals version of aforementioned functions, but in the
> > sense of common convention for such that encapsulate a single TPM
> > command and nothing more or less, your argument make sense.
> > 
> > But it is somewhat common pattern to prefix internal/unlocked version
> > with two underscores. So summarizing this I think that the best names
> > would be __tpm2_flush_context_cmd() and tpm2_flush_context_cmd().
> > 
> > But now that I looked at your patch, I remembered the reason why the
> > function in question does not take ops, albeit I'm not fully in the
> > page why this was not properly implemented in trusted_tpm2.c.
> > 
> > The principal idea was that the client, e.g. trusted keys would take
> > the ops and execute series of commands and then return ops. Otherwise,
> > there is a probel in atomicity, i.e. someone could race between unseal
> > and flush.
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
> I'll find the correct fixes tag. Your commit that is in the fixes tag
> did not causue this regression.

I'll provide a fix for this. The regression popped up in:

  2e19e10131a0 ("KEYS: trusted: Move TPM2 trusted keys code")

While I started to fix this, I also found a regression originating from:

  41ab999c80f1 ("tpm: Move tpm_get_random api into the TPM device driver")

I.e. the return value of tpm_get_random() is not handled correctly. That
has been there for a while...

/Jarkko
