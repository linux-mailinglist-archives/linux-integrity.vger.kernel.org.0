Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DE97297C3A
	for <lists+linux-integrity@lfdr.de>; Sat, 24 Oct 2020 14:10:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1761234AbgJXMKL (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sat, 24 Oct 2020 08:10:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:57918 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1761233AbgJXMKL (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 24 Oct 2020 08:10:11 -0400
Received: from localhost (83-245-197-237.elisa-laajakaista.fi [83.245.197.237])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9FEB02225F;
        Sat, 24 Oct 2020 12:10:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603541410;
        bh=VrWYZ15hN2vSTfKiyTtAJ+25Fl3HfRiIpDCqeeRzKxw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mlBKpCdmIMgPIs9WRboXl0v9sK9qmvc0xVC7/rbnqfWvQ+A6nMHcrol/0JJ+V2txy
         8DnBFLe46rxRRpQbUK78Q2ZFIG/zVZFUJEZzm/lGwnjmGDfoBRynevSaCa2hitG+U6
         mwmn4KUVwJeNepVzgTK1vDDfin/sVU9qB+A0mCNk=
Date:   Sat, 24 Oct 2020 15:10:07 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Jerry Snitselaar <jsnitsel@redhat.com>
Cc:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        linux-integrity@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Peter Huewe <peterhuewe@gmx.de>
Subject: Re: [PATCH v2 2/5] tpm_tis: Clean up locality release
Message-ID: <20201024121007.GA32960@kernel.org>
References: <20201001180925.13808-1-James.Bottomley@HansenPartnership.com>
 <20201001180925.13808-3-James.Bottomley@HansenPartnership.com>
 <875z75hkk8.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <875z75hkk8.fsf@redhat.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Oct 19, 2020 at 04:17:59PM -0700, Jerry Snitselaar wrote:
> 
> James Bottomley @ 2020-10-01 11:09 MST:
> 
> > The current release locality code seems to be based on the
> > misunderstanding that the TPM interrupts when a locality is released:
> > it doesn't, only when the locality is acquired.
> >
> > Furthermore, there seems to be no point in waiting for the locality to
> > be released.  All it does is penalize the last TPM user.  However, if
> > there's no next TPM user, this is a pointless wait and if there is a
> > next TPM user, they'll pay the penalty waiting for the new locality
> > (or possibly not if it's the same as the old locality).
> >
> > Fix the code by making release_locality as simple write to release
> > with no waiting for completion.
> >
> > Fixes: 33bafe90824b ("tpm_tis: verify locality released before returning from release_locality")
> > Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
> >
> > ---
> >
> > v2: added fixes
> > ---
> >  drivers/char/tpm/tpm_tis_core.c | 47 +--------------------------------
> >  1 file changed, 1 insertion(+), 46 deletions(-)
> >
> > diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
> > index f3ecde8df47d..431919d5f48a 100644
> > --- a/drivers/char/tpm/tpm_tis_core.c
> > +++ b/drivers/char/tpm/tpm_tis_core.c
> > @@ -135,58 +135,13 @@ static bool check_locality(struct tpm_chip *chip, int l)
> >  	return false;
> >  }
> >  
> > -static bool locality_inactive(struct tpm_chip *chip, int l)
> > -{
> > -	struct tpm_tis_data *priv = dev_get_drvdata(&chip->dev);
> > -	int rc;
> > -	u8 access;
> > -
> > -	rc = tpm_tis_read8(priv, TPM_ACCESS(l), &access);
> > -	if (rc < 0)
> > -		return false;
> > -
> > -	if ((access & (TPM_ACCESS_VALID | TPM_ACCESS_ACTIVE_LOCALITY))
> > -	    == TPM_ACCESS_VALID)
> > -		return true;
> > -
> > -	return false;
> > -}
> > -
> >  static int release_locality(struct tpm_chip *chip, int l)
> >  {
> >  	struct tpm_tis_data *priv = dev_get_drvdata(&chip->dev);
> > -	unsigned long stop, timeout;
> > -	long rc;
> >  
> >  	tpm_tis_write8(priv, TPM_ACCESS(l), TPM_ACCESS_ACTIVE_LOCALITY);
> >  
> > -	stop = jiffies + chip->timeout_a;
> > -
> > -	if (chip->flags & TPM_CHIP_FLAG_IRQ) {
> > -again:
> > -		timeout = stop - jiffies;
> > -		if ((long)timeout <= 0)
> > -			return -1;
> > -
> > -		rc = wait_event_interruptible_timeout(priv->int_queue,
> > -						      (locality_inactive(chip, l)),
> > -						      timeout);
> > -
> > -		if (rc > 0)
> > -			return 0;
> > -
> > -		if (rc == -ERESTARTSYS && freezing(current)) {
> > -			clear_thread_flag(TIF_SIGPENDING);
> > -			goto again;
> > -		}
> > -	} else {
> > -		do {
> > -			if (locality_inactive(chip, l))
> > -				return 0;
> > -			tpm_msleep(TPM_TIMEOUT);
> > -		} while (time_before(jiffies, stop));
> > -	}
> > -	return -1;
> > +	return 0;
> >  }
> >  
> >  static int request_locality(struct tpm_chip *chip, int l)
> 
> Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

/Jarkko
