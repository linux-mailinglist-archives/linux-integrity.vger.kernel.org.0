Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D8362A9FBC
	for <lists+linux-integrity@lfdr.de>; Fri,  6 Nov 2020 23:09:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728562AbgKFWHk (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 6 Nov 2020 17:07:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:36506 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728558AbgKFWHj (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 6 Nov 2020 17:07:39 -0500
Received: from kernel.org (83-245-197-237.elisa-laajakaista.fi [83.245.197.237])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A1C1B206B2;
        Fri,  6 Nov 2020 22:07:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604700459;
        bh=VgpU2jUhr2UaCzJioOQkSHQaCJPagXIt7Li6mxE05xg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tODVIiiqTw41fKXiHCLnLSw6CVxynXvfBjGSefpYBqWe2Kcyox1Ru0mak+BoK/zJN
         OaXW2peJu+5F7OK+MRI6x30xjzr3I/ef1cSv1TfjpVTXygNnSYFiSZs6E2zHPralOC
         k6qdepN5/zVFvsaISPU0qVkLPJd1jMZmoWGD4SYI=
Date:   Sat, 7 Nov 2020 00:07:33 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     James Bottomley <James.Bottomley@hansenpartnership.com>
Cc:     Jerry Snitselaar <jsnitsel@redhat.com>,
        linux-integrity@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Peter Huewe <peterhuewe@gmx.de>
Subject: Re: [PATCH v2 4/5] tpm_tis: fix IRQ probing
Message-ID: <20201106220733.GC55146@kernel.org>
References: <20201001180925.13808-1-James.Bottomley@HansenPartnership.com>
 <20201001180925.13808-5-James.Bottomley@HansenPartnership.com>
 <87zh4hg4wg.fsf@redhat.com>
 <20201024121718.GC32960@kernel.org>
 <20201030124335.GD522355@kernel.org>
 <20201106153204.GA13531@kernel.org>
 <7e5806c2b12a75f51643599dd388a2b587839ecb.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7e5806c2b12a75f51643599dd388a2b587839ecb.camel@HansenPartnership.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, Nov 06, 2020 at 08:21:44AM -0800, James Bottomley wrote:
> On Fri, 2020-11-06 at 17:32 +0200, Jarkko Sakkinen wrote:
> > On Fri, Oct 30, 2020 at 02:43:35PM +0200, Jarkko Sakkinen wrote:
> > > On Sat, Oct 24, 2020 at 03:17:18PM +0300, Jarkko Sakkinen wrote:
> > > > On Mon, Oct 19, 2020 at 04:41:35PM -0700, Jerry Snitselaar wrote:
> > > > > James Bottomley @ 2020-10-01 11:09 MST:
> > > > > 
> > > > > > There are two problems with our current interrupt probing:
> > > > > > firstly the TPM_CHIP_FLAG_IRQ never gets set initially, so a
> > > > > > check for interrupts is never done.  Fix this by setting the
> > > > > > flag before we generate and interrupt for probing.  Secondly
> > > > > > our IRQ setup may be ineffective on a TPM without legacy
> > > > > > access cycles becuase according to the TPM Interface
> > > > > > Specification the interrupt registers are only
> > > > > > writeable in the current locality, so issue a
> > > > > > request_locality before setting up the interrupts.
> > > > > > 
> > > > > > Signed-off-by: James Bottomley <
> > > > > > James.Bottomley@HansenPartnership.com>
> > > > > > 
> > > > > > ---
> > > > > > 
> > > > > > v2: improved description
> > > > > > ---
> > > > > >  drivers/char/tpm/tpm_tis_core.c | 14 ++++++++++++++
> > > > > >  1 file changed, 14 insertions(+)
> > > > > > 
> > > > > > diff --git a/drivers/char/tpm/tpm_tis_core.c
> > > > > > b/drivers/char/tpm/tpm_tis_core.c
> > > > > > index 0c07da8cd680..12b657ed3a39 100644
> > > > > > --- a/drivers/char/tpm/tpm_tis_core.c
> > > > > > +++ b/drivers/char/tpm/tpm_tis_core.c
> > > > > > @@ -809,6 +809,19 @@ static int
> > > > > > tpm_tis_probe_irq_single(struct tpm_chip *chip,
> > > > > >  	}
> > > > > >  	priv->irq = irq;
> > > > > >  
> > > > > > +	/*
> > > > > > +	 * note writes to the interrupt registers are only
> > > > > > effective
> > > > > > +	 * when the TPM is in the active locality, so we have
> > > > > > to
> > > > > > +	 * request the locality here to get the interrupt set
> > > > > > up.
> > > > > > +	 * This request has no corresponding release, because
> > > > > > the
> > > > > > +	 * locality will be relinquished at the end of the tpm
> > > > > > command
> > > > > > +	 * that probes the interrupts
> > > > > > +	 */
> > > > > > +	if (request_locality(chip, 0) != 0) {
> > > > > > +		dev_err(&chip->dev, "failed to gain locality
> > > > > > for irq probe\n");
> > > > > > +		return -EBUSY;
> > > > > > +	}
> > > > 
> > > > Appreciate the comment a lot, but s/note/Note/
> > > 
> > > I tested this with:
> > > 
> > > - 
> > > https://ark.intel.com/content/www/us/en/ark/products/84861/intel-nuc-kit-nuc5i5myhe.html
> > >   dTPM 1.2
> > > - 
> > > https://ark.intel.com/content/www/us/en/ark/products/74483/intel-nuc-kit-dc53427hye.html
> > >   dTPM 2.0
> > > 
> > > I did not get "TPM interrupt not working, polling instead" to klog.
> > > But I neither see tpm0 in /proc/interrupts. What I'm doing wrong?
> > 
> > With dTPM2 NUC, I ended up get this when I just pass 'irq=0' to
> > tpm_tis_core_init():
> > 
> > [    0.584421] tpm_tis MSFT0101:00: 2.0 TPM (device-id 0x1A, rev-id
> > 16)
> > [    0.680417] genirq: Flags mismatch irq 7. 00000008 (tpm0) vs.
> > 00040088 (INT3432:00)
> > [    0.680448] tpm tpm0: Unable to request irq: 7 for probe
> > [    0.704416] genirq: Flags mismatch irq 9. 00000000 (tpm0) vs.
> > 00000080 (acpi)
> > [    0.704444] tpm tpm0: Unable to request irq: 9 for probe
> 
> Well this looks normal: you forced the tis subsystem to probe for an
> IRQ even though ACPI says there isn't one and it didn't find one ... so
> ACPI was actually right (for once).
> 
> James

True. I wanted to give quick feedback with the results, did not have
time to analyze at that point. Can you do one more round with remarks
fixed that I mentioned (if I recall right they were only about comments
and commit messages, code itself is in great condition), and you can add
my tested-by to each commit?

I'll put this then to my next rc request so that we get this to 5.10.

/Jarkko
