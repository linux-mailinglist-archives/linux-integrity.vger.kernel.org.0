Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F21A82A05AA
	for <lists+linux-integrity@lfdr.de>; Fri, 30 Oct 2020 13:43:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726536AbgJ3Mnl (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 30 Oct 2020 08:43:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:56696 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726513AbgJ3Mnl (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 30 Oct 2020 08:43:41 -0400
Received: from kernel.org (83-245-197-237.elisa-laajakaista.fi [83.245.197.237])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6334A221EB;
        Fri, 30 Oct 2020 12:43:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604061820;
        bh=7lAxEhQrhJbso4MW6ti4aK3YXNMKdjk1481K/O+7EL8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LM5Qelkh+m0aFYlc4OQamim8NR4Vsknz9fSg7XenM/WmoqcS8OOFvBjZ/9v80aoqs
         zZUypReGD6hAPYs279frgoGqdDXAhzFuR3HdmrSlHHiTg6cR4fPrl/wCZtCYWIIpyh
         eQeXH4VMcimKrAzYZsePZfsDBofwMuFs8W9AaPZQ=
Date:   Fri, 30 Oct 2020 14:43:35 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Jerry Snitselaar <jsnitsel@redhat.com>
Cc:     James Bottomley <James.Bottomley@hansenpartnership.com>,
        linux-integrity@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Peter Huewe <peterhuewe@gmx.de>
Subject: Re: [PATCH v2 4/5] tpm_tis: fix IRQ probing
Message-ID: <20201030124335.GD522355@kernel.org>
References: <20201001180925.13808-1-James.Bottomley@HansenPartnership.com>
 <20201001180925.13808-5-James.Bottomley@HansenPartnership.com>
 <87zh4hg4wg.fsf@redhat.com>
 <20201024121718.GC32960@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201024121718.GC32960@kernel.org>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Sat, Oct 24, 2020 at 03:17:18PM +0300, Jarkko Sakkinen wrote:
> On Mon, Oct 19, 2020 at 04:41:35PM -0700, Jerry Snitselaar wrote:
> > 
> > James Bottomley @ 2020-10-01 11:09 MST:
> > 
> > > There are two problems with our current interrupt probing: firstly the
> > > TPM_CHIP_FLAG_IRQ never gets set initially, so a check for interrupts
> > > is never done.  Fix this by setting the flag before we generate and
> > > interrupt for probing.  Secondly our IRQ setup may be ineffective on a
> > > TPM without legacy access cycles becuase according to the TPM
> > > Interface Specification the interrupt registers are only writeable in
> > > the current locality, so issue a request_locality before setting up
> > > the interrupts.
> > >
> > > Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
> > >
> > > ---
> > >
> > > v2: improved description
> > > ---
> > >  drivers/char/tpm/tpm_tis_core.c | 14 ++++++++++++++
> > >  1 file changed, 14 insertions(+)
> > >
> > > diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
> > > index 0c07da8cd680..12b657ed3a39 100644
> > > --- a/drivers/char/tpm/tpm_tis_core.c
> > > +++ b/drivers/char/tpm/tpm_tis_core.c
> > > @@ -809,6 +809,19 @@ static int tpm_tis_probe_irq_single(struct tpm_chip *chip,
> > >  	}
> > >  	priv->irq = irq;
> > >  
> > > +	/*
> > > +	 * note writes to the interrupt registers are only effective
> > > +	 * when the TPM is in the active locality, so we have to
> > > +	 * request the locality here to get the interrupt set up.
> > > +	 * This request has no corresponding release, because the
> > > +	 * locality will be relinquished at the end of the tpm command
> > > +	 * that probes the interrupts
> > > +	 */
> > > +	if (request_locality(chip, 0) != 0) {
> > > +		dev_err(&chip->dev, "failed to gain locality for irq probe\n");
> > > +		return -EBUSY;
> > > +	}
> 
> Appreciate the comment a lot, but s/note/Note/

I tested this with:

- https://ark.intel.com/content/www/us/en/ark/products/84861/intel-nuc-kit-nuc5i5myhe.html
  dTPM 1.2
- https://ark.intel.com/content/www/us/en/ark/products/74483/intel-nuc-kit-dc53427hye.html
  dTPM 2.0

I did not get "TPM interrupt not working, polling instead" to klog.
But I neither see tpm0 in /proc/interrupts. What I'm doing wrong?

/Jarkko
