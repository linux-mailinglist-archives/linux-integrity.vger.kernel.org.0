Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD3951AB4AA
	for <lists+linux-integrity@lfdr.de>; Thu, 16 Apr 2020 02:17:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730523AbgDPAQO (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 15 Apr 2020 20:16:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729625AbgDPAQJ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 15 Apr 2020 20:16:09 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40B49C061A0C
        for <linux-integrity@vger.kernel.org>; Wed, 15 Apr 2020 17:16:08 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id w11so751553pga.12
        for <linux-integrity@vger.kernel.org>; Wed, 15 Apr 2020 17:16:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=FuE0VGqiZrssOcxKwkEmPbatGpvU/CLW3QDs9pkNdGM=;
        b=zfAeEOtJw5SKrnIbN7LDX4NPJNNlHTzPbJ6h9TMdgxEgJIsxvo/xVcbKhwNkm0BE2l
         GWx8k9A4fdqFeAUIDJ+Ni8ClLJPDyNGMPhet9b2UO3kUgfHB/PK/Ue9uEWKa2I54cTAX
         1iInQ8UtrQT4sev032zFvCVC5a+B02+A0O9GAehXsxs2xMq7nd4HuQMmf+xEyDBkAV8o
         WzO9KuBih3yo8f7GAsNk7BhgrGdmod7KxOPsG7Wy8QiqGg3kzg7rkZWmmzgfnq1k3Spk
         TGqUT9p2tT7Cwo2rzUWxLWx++5ROPr/pI7xmn/HNWmFliVSEW1ZOUT2wCmG77XqIh8Nz
         96yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FuE0VGqiZrssOcxKwkEmPbatGpvU/CLW3QDs9pkNdGM=;
        b=ILHn6y/wU6Gb9ipVvb95Waju19JN8X2bUCywubIRuKSnb04Nk+YBymrlsO36NWmDei
         8jItoFEx+yZYwz2KEgTujJB+7JBn+6xnG+FXPwyBr+zK4uwYN+L3tkzk/DROLv8qJv4s
         izZst7XN22oFw1OOYN0QcR4nGxcHzfj1HNsILlhvFKuDdyylqY6TIgcNHiF1CFOqWlaN
         BAjFPEJcp0xFxgJWjcs4ZwPiFE+sMvR4w5rg+5PBerCa9dnNx0LeAZ+zJlBHgeI2vVXO
         8Nwcd1dU7Ag77OBk9BACoW58HNMMCWNhr+K3uFmeSgakMIq1Dp9sUmBXkLv/ioiIJAta
         c+0A==
X-Gm-Message-State: AGi0PubcGI4NpM9d8Rni9L4TIhcmsINMYU44msAc9UNh8aepbRQqvozV
        Z8o3DiKsDUXdPRdezO/WzvT6ag==
X-Google-Smtp-Source: APiQypJYWDwBvQHXCdJYJvRcZew5fdOqCEoOi+sV5o05d98jvR3Z/KjRIPXn/3kqbI79PqpSwrkNaQ==
X-Received: by 2002:a63:de49:: with SMTP id y9mr12638826pgi.435.1586996167455;
        Wed, 15 Apr 2020 17:16:07 -0700 (PDT)
Received: from vader ([2620:10d:c090:400::5:b0c6])
        by smtp.gmail.com with ESMTPSA id c84sm6677705pfb.153.2020.04.15.17.16.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2020 17:16:06 -0700 (PDT)
Date:   Wed, 15 Apr 2020 17:16:05 -0700
From:   Omar Sandoval <osandov@osandov.com>
To:     James Bottomley <James.Bottomley@hansenpartnership.com>
Cc:     Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-integrity@vger.kernel.org
Subject: Re: [PATCH] tpm_tis: work around status register bug in
 STMicroelectronics TPM
Message-ID: <20200416001605.GA673482@vader>
References: <6c55d7c1fb84e5bf2ace9f05ec816ef67bd873e1.1586990595.git.osandov@fb.com>
 <1586994699.3931.18.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1586994699.3931.18.camel@HansenPartnership.com>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Apr 15, 2020 at 04:51:39PM -0700, James Bottomley wrote:
> On Wed, 2020-04-15 at 15:45 -0700, Omar Sandoval wrote:
> > From: Omar Sandoval <osandov@fb.com>
> > 
> > We've encountered a particular model of STMicroelectronics TPM that
> > transiently returns a bad value in the status register. This causes
> > the kernel to believe that the TPM is ready to receive a command when
> > it actually isn't, which in turn causes the send to time out in
> > get_burstcount(). In testing, reading the status register one extra
> > time convinces the TPM to return a valid value.
> 
> Interesting, I've got a very early upgradeable nuvoton that seems to be
> behaving like this.

I'll attach the userspace reproducer I used to figure this out. I'd be
interested to see if it times out on your TPM, too. Note that it bangs
on /dev/mem and assumes that the MMIO address is 0xfed40000. That seems
to be the hard-coded address for x86 in the kernel, but just to be safe
you might want to check `grep MSFT0101 /proc/iomem`.

> > Signed-off-by: Omar Sandoval <osandov@fb.com>
> > ---
> >  drivers/char/tpm/tpm_tis_core.c | 12 ++++++++++++
> >  1 file changed, 12 insertions(+)
> > 
> > diff --git a/drivers/char/tpm/tpm_tis_core.c
> > b/drivers/char/tpm/tpm_tis_core.c
> > index 27c6ca031e23..277a21027fc7 100644
> > --- a/drivers/char/tpm/tpm_tis_core.c
> > +++ b/drivers/char/tpm/tpm_tis_core.c
> > @@ -238,6 +238,18 @@ static u8 tpm_tis_status(struct tpm_chip *chip)
> >  	rc = tpm_tis_read8(priv, TPM_STS(priv->locality), &status);
> >  	if (rc < 0)
> >  		return 0;
> > +	/*
> > +	 * Some STMicroelectronics TPMs have a bug where the status
> > register is
> > +	 * sometimes bogus (all 1s) if read immediately after the
> > access
> > +	 * register is written to. Bits 0, 1, and 5 are always
> > supposed to read
> > +	 * as 0, so this is clearly invalid. Reading the register a
> > second time
> > +	 * returns a valid value.
> > +	 */
> > +	if (unlikely(status == 0xff)) {
> > +		rc = tpm_tis_read8(priv, TPM_STS(priv->locality),
> > &status);
> > +		if (rc < 0)
> > +			return 0;
> > +	}
> 
> You theorize that your case is fixed by the second read, but what if it
> isn't and the second read also returns 0xff?  Shouldn't we have a line
> here saying
> 
> if (unlikely(status == 0xff))
> 	status = 0;
> 
> So if we get a second 0xff we just pretend the thing isn't ready?

We've been running this workaround in production for awhile and the
hangs haven't happened since, and my userspace reproducer never
witnessed a second 0xff. But it wouldn't hurt, so I can add it anyways.
