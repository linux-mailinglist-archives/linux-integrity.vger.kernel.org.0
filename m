Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 557B5293187
	for <lists+linux-integrity@lfdr.de>; Tue, 20 Oct 2020 00:54:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388706AbgJSWyo (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 19 Oct 2020 18:54:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388705AbgJSWyn (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 19 Oct 2020 18:54:43 -0400
X-Greylist: delayed 99664 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 19 Oct 2020 15:54:43 PDT
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [IPv6:2607:fcd0:100:8a00::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6492C0613CE
        for <linux-integrity@vger.kernel.org>; Mon, 19 Oct 2020 15:54:43 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 72B1912818D2;
        Mon, 19 Oct 2020 15:54:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1603148082;
        bh=uTDGqc1IL393bCCcxoT3tjo2J6Ow/cuKZRK/KqS5ahQ=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=VOe2IAWxNHlDWp+QwGXjKaLUk1ke1mexKmtuSf7qqlRDWPLSuWa0/HPLzftx4A2vA
         gqiAGnpjktaDDvf+Lr3VMcfqnhPDOPXv+2BmZHxU0KHJQS9Lx2/a2YD9NK8PJACW+7
         +0rgWLpjwRV7RnlxY27PXgx/wyrwTKR1CXARpTvQ=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 4V8vpjiBRmBn; Mon, 19 Oct 2020 15:54:42 -0700 (PDT)
Received: from jarvis.int.hansenpartnership.com (unknown [IPv6:2601:600:8280:66d1::527])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 04D3512818A5;
        Mon, 19 Oct 2020 15:54:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1603148082;
        bh=uTDGqc1IL393bCCcxoT3tjo2J6Ow/cuKZRK/KqS5ahQ=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=VOe2IAWxNHlDWp+QwGXjKaLUk1ke1mexKmtuSf7qqlRDWPLSuWa0/HPLzftx4A2vA
         gqiAGnpjktaDDvf+Lr3VMcfqnhPDOPXv+2BmZHxU0KHJQS9Lx2/a2YD9NK8PJACW+7
         +0rgWLpjwRV7RnlxY27PXgx/wyrwTKR1CXARpTvQ=
Message-ID: <3793c0c226d4d7c66452c161973c24e0118ebbba.camel@HansenPartnership.com>
Subject: Re: [PATCH v2 5/5] Revert "tpm: Revert "tpm_tis_core: Turn on the
 TPM before probing IRQ's""
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Jerry Snitselaar <jsnitsel@redhat.com>
Cc:     linux-integrity@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Peter Huewe <peterhuewe@gmx.de>
Date:   Mon, 19 Oct 2020 15:54:41 -0700
In-Reply-To: <87blgyge2x.fsf@redhat.com>
References: <20201001180925.13808-1-James.Bottomley@HansenPartnership.com>
         <20201001180925.13808-6-James.Bottomley@HansenPartnership.com>
         <87blgyge2x.fsf@redhat.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, 2020-10-19 at 13:23 -0700, Jerry Snitselaar wrote:
> James Bottomley @ 2020-10-01 11:09 MST:
> 
> > Revert the patch aa4a63dd9816 which stops interrupt probing from
> > working, now that it should be safe to allow interrupt probing on
> > all
> > systems without incurring interrupt storms.
> > 
> > Signed-off-by: James Bottomley <
> > James.Bottomley@HansenPartnership.com>
> > ---
> >  drivers/char/tpm/tpm_tis_core.c | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/drivers/char/tpm/tpm_tis_core.c
> > b/drivers/char/tpm/tpm_tis_core.c
> > index 12b657ed3a39..23b60583928b 100644
> > --- a/drivers/char/tpm/tpm_tis_core.c
> > +++ b/drivers/char/tpm/tpm_tis_core.c
> > @@ -1117,6 +1117,7 @@ int tpm_tis_core_init(struct device *dev,
> > struct tpm_tis_data *priv, int irq,
> >  			goto out_err;
> >  		}
> >  
> > +		tpm_chip_start(chip);
> >  		if (irq) {
> >  			tpm_tis_probe_irq_single(chip, IRQF_SHARED,
> > irq);
> >  			if (!(chip->flags & TPM_CHIP_FLAG_IRQ)) {
> > @@ -1128,6 +1129,7 @@ int tpm_tis_core_init(struct device *dev,
> > struct tpm_tis_data *priv, int irq,
> >  		} else {
> >  			tpm_tis_probe_irq(chip);
> >  		}
> > +		tpm_chip_stop(chip);
> >  	}
> >  
> >  	rc = tpm_chip_register(chip);
> 
> I know this is a revert, but should there be a commit on top of this
> to move the tpm_chip_start above the tpm_get_timeouts right before
> this?

Not for tpm 2: tpm2_get_timeouts doesn't actually query the device.  I
think this may be required for TPM 1.2 since it does send a
capabilities, but I don't actually know if any TPM 1.2 systems have the
ineffective locality problem this fix addresses (I don't have one to
check) ... I'm guessing not otherwise we'd have had bug reports about
TPM 1.2 failing to get the timeouts (it dumps an error message to the
logs).

James


