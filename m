Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45F022A995D
	for <lists+linux-integrity@lfdr.de>; Fri,  6 Nov 2020 17:21:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726320AbgKFQVq (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 6 Nov 2020 11:21:46 -0500
Received: from bedivere.hansenpartnership.com ([96.44.175.130]:49974 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726010AbgKFQVq (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 6 Nov 2020 11:21:46 -0500
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 700ED1280206;
        Fri,  6 Nov 2020 08:21:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1604679705;
        bh=T3uDUhC7NL9cyZzziTWbyfLPzhjrOgbVM/wkSp7kLeo=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=C/cdTtgZNdNpHf9TH5TsMwBfCMNFuQ1ULL34AMCNWUqvWuYCfm4NyOpKBuPE0t+az
         KgmgQdZry2bHHRIz0gkpjEwnpCq/ejHVBgoPcfegFBwdOf08zcIWnFOryqpHY55wbp
         OBXxy+CdtDS+FpCp36uFWH6YLeVLqPuU7ZRsanvs=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id bN8vLQDHM6p1; Fri,  6 Nov 2020 08:21:45 -0800 (PST)
Received: from jarvis.int.hansenpartnership.com (unknown [IPv6:2601:600:8280:66d1::527])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id E2D8D12801C2;
        Fri,  6 Nov 2020 08:21:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1604679705;
        bh=T3uDUhC7NL9cyZzziTWbyfLPzhjrOgbVM/wkSp7kLeo=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=C/cdTtgZNdNpHf9TH5TsMwBfCMNFuQ1ULL34AMCNWUqvWuYCfm4NyOpKBuPE0t+az
         KgmgQdZry2bHHRIz0gkpjEwnpCq/ejHVBgoPcfegFBwdOf08zcIWnFOryqpHY55wbp
         OBXxy+CdtDS+FpCp36uFWH6YLeVLqPuU7ZRsanvs=
Message-ID: <7e5806c2b12a75f51643599dd388a2b587839ecb.camel@HansenPartnership.com>
Subject: Re: [PATCH v2 4/5] tpm_tis: fix IRQ probing
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Jarkko Sakkinen <jarkko@kernel.org>,
        Jerry Snitselaar <jsnitsel@redhat.com>
Cc:     linux-integrity@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Peter Huewe <peterhuewe@gmx.de>
Date:   Fri, 06 Nov 2020 08:21:44 -0800
In-Reply-To: <20201106153204.GA13531@kernel.org>
References: <20201001180925.13808-1-James.Bottomley@HansenPartnership.com>
         <20201001180925.13808-5-James.Bottomley@HansenPartnership.com>
         <87zh4hg4wg.fsf@redhat.com> <20201024121718.GC32960@kernel.org>
         <20201030124335.GD522355@kernel.org> <20201106153204.GA13531@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, 2020-11-06 at 17:32 +0200, Jarkko Sakkinen wrote:
> On Fri, Oct 30, 2020 at 02:43:35PM +0200, Jarkko Sakkinen wrote:
> > On Sat, Oct 24, 2020 at 03:17:18PM +0300, Jarkko Sakkinen wrote:
> > > On Mon, Oct 19, 2020 at 04:41:35PM -0700, Jerry Snitselaar wrote:
> > > > James Bottomley @ 2020-10-01 11:09 MST:
> > > > 
> > > > > There are two problems with our current interrupt probing:
> > > > > firstly the TPM_CHIP_FLAG_IRQ never gets set initially, so a
> > > > > check for interrupts is never done.  Fix this by setting the
> > > > > flag before we generate and interrupt for probing.  Secondly
> > > > > our IRQ setup may be ineffective on a TPM without legacy
> > > > > access cycles becuase according to the TPM Interface
> > > > > Specification the interrupt registers are only
> > > > > writeable in the current locality, so issue a
> > > > > request_locality before setting up the interrupts.
> > > > > 
> > > > > Signed-off-by: James Bottomley <
> > > > > James.Bottomley@HansenPartnership.com>
> > > > > 
> > > > > ---
> > > > > 
> > > > > v2: improved description
> > > > > ---
> > > > >  drivers/char/tpm/tpm_tis_core.c | 14 ++++++++++++++
> > > > >  1 file changed, 14 insertions(+)
> > > > > 
> > > > > diff --git a/drivers/char/tpm/tpm_tis_core.c
> > > > > b/drivers/char/tpm/tpm_tis_core.c
> > > > > index 0c07da8cd680..12b657ed3a39 100644
> > > > > --- a/drivers/char/tpm/tpm_tis_core.c
> > > > > +++ b/drivers/char/tpm/tpm_tis_core.c
> > > > > @@ -809,6 +809,19 @@ static int
> > > > > tpm_tis_probe_irq_single(struct tpm_chip *chip,
> > > > >  	}
> > > > >  	priv->irq = irq;
> > > > >  
> > > > > +	/*
> > > > > +	 * note writes to the interrupt registers are only
> > > > > effective
> > > > > +	 * when the TPM is in the active locality, so we have
> > > > > to
> > > > > +	 * request the locality here to get the interrupt set
> > > > > up.
> > > > > +	 * This request has no corresponding release, because
> > > > > the
> > > > > +	 * locality will be relinquished at the end of the tpm
> > > > > command
> > > > > +	 * that probes the interrupts
> > > > > +	 */
> > > > > +	if (request_locality(chip, 0) != 0) {
> > > > > +		dev_err(&chip->dev, "failed to gain locality
> > > > > for irq probe\n");
> > > > > +		return -EBUSY;
> > > > > +	}
> > > 
> > > Appreciate the comment a lot, but s/note/Note/
> > 
> > I tested this with:
> > 
> > - 
> > https://ark.intel.com/content/www/us/en/ark/products/84861/intel-nuc-kit-nuc5i5myhe.html
> >   dTPM 1.2
> > - 
> > https://ark.intel.com/content/www/us/en/ark/products/74483/intel-nuc-kit-dc53427hye.html
> >   dTPM 2.0
> > 
> > I did not get "TPM interrupt not working, polling instead" to klog.
> > But I neither see tpm0 in /proc/interrupts. What I'm doing wrong?
> 
> With dTPM2 NUC, I ended up get this when I just pass 'irq=0' to
> tpm_tis_core_init():
> 
> [    0.584421] tpm_tis MSFT0101:00: 2.0 TPM (device-id 0x1A, rev-id
> 16)
> [    0.680417] genirq: Flags mismatch irq 7. 00000008 (tpm0) vs.
> 00040088 (INT3432:00)
> [    0.680448] tpm tpm0: Unable to request irq: 7 for probe
> [    0.704416] genirq: Flags mismatch irq 9. 00000000 (tpm0) vs.
> 00000080 (acpi)
> [    0.704444] tpm tpm0: Unable to request irq: 9 for probe

Well this looks normal: you forced the tis subsystem to probe for an
IRQ even though ACPI says there isn't one and it didn't find one ... so
ACPI was actually right (for once).

James


