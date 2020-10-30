Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B5C32A0514
	for <lists+linux-integrity@lfdr.de>; Fri, 30 Oct 2020 13:13:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725808AbgJ3MNN (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 30 Oct 2020 08:13:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:46922 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725355AbgJ3MNN (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 30 Oct 2020 08:13:13 -0400
Received: from kernel.org (83-245-197-237.elisa-laajakaista.fi [83.245.197.237])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5D6B4206E9;
        Fri, 30 Oct 2020 12:13:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604059992;
        bh=3aafmMIYaD9wNsBCgEYX3b5JWYI/mztmdku0ITqVSoU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ySpoJq09NPan1KPgJyzgyFfxGNyg5rZQF2KfB1JWA+8vIIK/LkbGyZ/XSRUpLmmEV
         ovNI2Cxsfn26duRJc6TDFcFSBebsk14rVu5/Z2GZdbMyqZFm2QokBiDp9/xwCzyw9U
         AehCOICtBu6pAKozrF3/Mtelz3+PHhyC+iHx4gAw=
Date:   Fri, 30 Oct 2020 14:13:07 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Jerry Snitselaar <jsnitsel@redhat.com>
Cc:     James Bottomley <James.Bottomley@hansenpartnership.com>,
        linux-integrity@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Peter Huewe <peterhuewe@gmx.de>
Subject: Re: [PATCH v2 1/5] tpm_tis: Fix check_locality for correct locality
 acquisition
Message-ID: <20201030121307.GA522355@kernel.org>
References: <20201001180925.13808-1-James.Bottomley@HansenPartnership.com>
 <20201001180925.13808-2-James.Bottomley@HansenPartnership.com>
 <878sc1hkmn.fsf@redhat.com>
 <20201024120744.GA32607@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201024120744.GA32607@kernel.org>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Sat, Oct 24, 2020 at 03:07:44PM +0300, Jarkko Sakkinen wrote:
> On Mon, Oct 19, 2020 at 04:16:32PM -0700, Jerry Snitselaar wrote:
> > 
> > James Bottomley @ 2020-10-01 11:09 MST:
> > 
> > > The TPM TIS specification says the TPM signals the acquisition of
> > > locality when the TMP_ACCESS_REQUEST_USE bit goes to one *and* the
> > > TPM_ACCESS_REQUEST_USE bit goes to zero.  Currently we only check the
> > > former not the latter, so check both.  Adding the check on
> > > TPM_ACCESS_REQUEST_USE should fix the case where the locality is
> > > re-requested before the TPM has released it.  In this case the
> > > locality may get released briefly before it is reacquired, which
> > > causes all sorts of problems. However, with the added check,
> > > TPM_ACCESS_REQUEST_USE should remain 1 until the second request for
> > > the locality is granted.
> > >
> > > Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
> > >
> > > ---
> > >
> > > v2: added this patch
> > > ---
> > >  drivers/char/tpm/tpm_tis_core.c | 3 ++-
> > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
> > > index 92c51c6cfd1b..f3ecde8df47d 100644
> > > --- a/drivers/char/tpm/tpm_tis_core.c
> > > +++ b/drivers/char/tpm/tpm_tis_core.c
> > > @@ -125,7 +125,8 @@ static bool check_locality(struct tpm_chip *chip, int l)
> > >  	if (rc < 0)
> > >  		return false;
> > >  
> > > -	if ((access & (TPM_ACCESS_ACTIVE_LOCALITY | TPM_ACCESS_VALID)) ==
> > > +	if ((access & (TPM_ACCESS_ACTIVE_LOCALITY | TPM_ACCESS_VALID
> > > +		       | TPM_ACCESS_REQUEST_USE)) ==
> > >  	    (TPM_ACCESS_ACTIVE_LOCALITY | TPM_ACCESS_VALID)) {
> > >  		priv->locality = l;
> > >  		return true;
> > 
> > Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>
> 
> Thank you.
> 
> James, few minor remarks.
> 
> Given that the failing commit is in the GIT, just for reference
> 
>   Fixes: 27084efee0c3 ("[PATCH] tpm: driver for next generation TPM chips")
>   Cc: stable@ger.kernel.org
> 
> I want fixes tags for everything that has a legit Git commit, even
> if it spans through all the existing stable kernels. It's valuable
> information to have in the Git log.
> 
> Another thing I noticed is that would be less ugly put everything
> in the same line, as checkpatch requirement have been relaxed.
> 
> Finally, please put a verbose inline comment before the condition.
> tpm_tis driver is complicated enough that it should be better
> documented. After months pass things tend to fade away and wrong
> decisions might be made because of that. You can probably derive
> it from the already nice and verbose commit message, so let's
> take advantage of it.
> 
> About recent debate on patch changelogs. I talked with Dave Hansen
> about this, and he said that in x86 tree, they are the standard, but
> the practice depends per tree.
> 
> After thinking about this, and writing per patch changelogs for the
> next iteration of the SGX patch set, my standing point is that either
> works as it is properly written and maintained.

This can be merged immediately once the remarks have been taken care
of (i.e. do not except tested-by for 1/5).

/Jarkko
