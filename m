Return-Path: <linux-integrity+bounces-5181-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C6C5A56DFB
	for <lists+linux-integrity@lfdr.de>; Fri,  7 Mar 2025 17:40:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30BCE3B7E4D
	for <lists+linux-integrity@lfdr.de>; Fri,  7 Mar 2025 16:38:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A867023E25F;
	Fri,  7 Mar 2025 16:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=earth.li header.i=@earth.li header.b="UHtIc06O"
X-Original-To: linux-integrity@vger.kernel.org
Received: from the.earth.li (the.earth.li [93.93.131.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F4C123E25B;
	Fri,  7 Mar 2025 16:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.93.131.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741365386; cv=none; b=VvrmjOE8Lf6TQfjqgPCwT3IyNYzx3mX9Kb57rgCtLydXJrp2VxYv4FfoZns0UyJ9UX7P3osucHXkQ6OJ58OmJLWXXKin3d9GuXyYHoKxzjeCPp5H30HGB/wIqFMVWY4spIFIEaOyi35sZUKplmUTmWQgvBW7l2nW8/8uXrvc5t4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741365386; c=relaxed/simple;
	bh=r498hqc3k8IbNvDyqnT6t8TEmkwx9aSVtSm88FQLOWA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HEuhz5jJPaC3QJAlPPvhQ1AN6sE8LKgLeUpHX+h1BGraJCpeqZhEvm5SA40mg4colxjVG1dwSFoiJ94qqTI6SwS8yl16VtRPymLjKOM3EBJRavLTECUWG/5h2YG3CB7CvzC1ZFUNzQLUcHnBrS/qvlYdTUhTRn1rONcn0kij4NQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=earth.li; spf=pass smtp.mailfrom=earth.li; dkim=pass (2048-bit key) header.d=earth.li header.i=@earth.li header.b=UHtIc06O; arc=none smtp.client-ip=93.93.131.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=earth.li
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=earth.li
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=earth.li;
	s=the; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:
	Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=VX3FZVvlkaPBR2WEHi1SCf1gBH/UKqgWJH5Ig5wpJpM=; b=UHtIc06OH7aS1gGS6P3gebuMW2
	zhYKRqgWR6Lhf3ZUdGjiMWUXgRaVyC+h4D1CdrvorggSGtG4wlCVw9duaPKe51JnglEc6zYuGj8Fb
	LC5ArjgSRKz5xZAA2+7mv6PVdeqS8r7eeolTE8d+/9scw0bZ9KFT3vMrMRaxpe3AxCjNA/SBcp9Xn
	/yWIoxEK7E4tEhFii3CTNUGvLVYOSgDB71j7E0BQFRySrp/1HG5s6xtl6r15dixLJ70vm2YYAN8Pb
	PvUtomE5bdg93GN/KhdjznJuyRz4SznTN5pbkEfGOwlL1erBRwT8wNJxWBm6nR9xLw4lGAIQHdzbJ
	jRTX30iA==;
Received: from noodles by the.earth.li with local (Exim 4.96)
	(envelope-from <noodles@earth.li>)
	id 1tqagG-00DC2U-05;
	Fri, 07 Mar 2025 16:36:12 +0000
Date: Fri, 7 Mar 2025 16:36:12 +0000
From: Jonathan McDowell <noodles@earth.li>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	Stefan Berger <stefanb@linux.ibm.com>,
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tpm, tpm_tis: Workaround failed command reception on
 Infineon devices
Message-ID: <Z8sgfMmsfn894yLj@earth.li>
References: <Z8lkSKOqBgt78pU2@earth.li>
 <Z8ogT_gERUYstPbK@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z8ogT_gERUYstPbK@kernel.org>

On Fri, Mar 07, 2025 at 12:23:11AM +0200, Jarkko Sakkinen wrote:
> On Thu, Mar 06, 2025 at 09:00:56AM +0000, Jonathan McDowell wrote:
> > From: Jonathan McDowell <noodles@meta.com>
> > 
> > Some Infineon devices have a issue where the status register will get
> > stuck with a quick REQUEST_USE / COMMAND_READY sequence. This is not
> > simply a matter of requiring a longer timeout; the work around is to
> > retry the command submission. Add appropriate logic to do this in the
> > send path.
> > 
> > This is fixed in later firmware revisions, but those are not always
> > available, and cannot generally be easily updated from outside a
> > firmware environment.
> > 
> > Testing has been performed with a simple repeated loop of doing a
> > TPM2_CC_GET_CAPABILITY for TPM_CAP_PROP_MANUFACTURER using the Go code
> > at:
> > 
> >  https://the.earth.li/~noodles/tpm-stuff/timeout-reproducer-simple.go
> > 
> > It can take several hours to reproduce, and millions of operations.
> > 
> > Signed-off-by: Jonathan McDowell <noodles@meta.com>
> > ---
> >  drivers/char/tpm/tpm_tis_core.c | 17 ++++++++++++++---
> >  drivers/char/tpm/tpm_tis_core.h |  1 +
> >  include/linux/tpm.h             |  1 +
> >  3 files changed, 16 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
> > index 167d71747666..e4eae206a353 100644
> > --- a/drivers/char/tpm/tpm_tis_core.c
> > +++ b/drivers/char/tpm/tpm_tis_core.c
> > @@ -464,7 +464,10 @@ static int tpm_tis_send_data(struct tpm_chip *chip, const u8 *buf, size_t len)
> >  
> >  		if (wait_for_tpm_stat(chip, TPM_STS_VALID, chip->timeout_c,
> >  					&priv->int_queue, false) < 0) {
> > -			rc = -ETIME;
> > +			if (test_bit(TPM_TIS_STATUS_WORKAROUND, &priv->flags))
> > +				rc = -EAGAIN;
> > +			else
> > +				rc = -ETIME;
> >  			goto out_err;
> >  		}
> >  		status = tpm_tis_status(chip);
> > @@ -481,7 +484,10 @@ static int tpm_tis_send_data(struct tpm_chip *chip, const u8 *buf, size_t len)
> >  
> >  	if (wait_for_tpm_stat(chip, TPM_STS_VALID, chip->timeout_c,
> >  				&priv->int_queue, false) < 0) {
> > -		rc = -ETIME;
> > +		if (test_bit(TPM_TIS_STATUS_WORKAROUND, &priv->flags))
> > +			rc = -EAGAIN;
> > +		else
> > +			rc = -ETIME;
> 
> I'd encapsulate this inside wait_for_tpm_stat().

I think that gets a bit more complicated; this is an errata in the send 
command path, for a stuck VALID bit, and the fix is to restart the whole 
command send (i.e. we need to kick the TPM with tpm_tis_ready() etc). 
I'm not sure returning EAGAIN in wait_for_tpm_stat() then makes 
tpm_tis_send_data() any simpler.

> >  		goto out_err;
> >  	}
> >  	status = tpm_tis_status(chip);
> > @@ -546,9 +552,11 @@ static int tpm_tis_send_main(struct tpm_chip *chip, const u8 *buf, size_t len)
> >  		if (rc >= 0)
> >  			/* Data transfer done successfully */
> >  			break;
> > -		else if (rc != -EIO)
> > +		else if (rc != EAGAIN && rc != -EIO)
> >  			/* Data transfer failed, not recoverable */
> >  			return rc;
> > +
> > +		usleep_range(priv->timeout_min, priv->timeout_max);
> >  	}
> >  
> >  	/* go and do it */
> > @@ -1144,6 +1152,9 @@ int tpm_tis_core_init(struct device *dev, struct tpm_tis_data *priv, int irq,
> >  		priv->timeout_max = TIS_TIMEOUT_MAX_ATML;
> >  	}
> >  
> > +	if (priv->manufacturer_id == TPM_VID_IFX)
> > +		set_bit(TPM_TIS_STATUS_WORKAROUND, &priv->flags);
> > +
> >  	if (is_bsw()) {
> >  		priv->ilb_base_addr = ioremap(INTEL_LEGACY_BLK_BASE_ADDR,
> >  					ILB_REMAP_SIZE);
> > diff --git a/drivers/char/tpm/tpm_tis_core.h b/drivers/char/tpm/tpm_tis_core.h
> > index 690ad8e9b731..ce97b58dc005 100644
> > --- a/drivers/char/tpm/tpm_tis_core.h
> > +++ b/drivers/char/tpm/tpm_tis_core.h
> > @@ -89,6 +89,7 @@ enum tpm_tis_flags {
> >  	TPM_TIS_INVALID_STATUS		= 1,
> >  	TPM_TIS_DEFAULT_CANCELLATION	= 2,
> >  	TPM_TIS_IRQ_TESTED		= 3,
> > +	TPM_TIS_STATUS_WORKAROUND	= 4,
> 
> TPM_TIS_TIMEOUT_AGAIN or maybe *_REPEAT? The current name does
> not tell anything.

Yeah, TPM_TIS_STATUS_VALID_RETRY is perhaps clearer; it's not a timeout, 
and we're looking to do a retry based on STS_VALID.

> >  };
> >  
> >  struct tpm_tis_data {
> > diff --git a/include/linux/tpm.h b/include/linux/tpm.h
> > index 20a40ade8030..6c3125300c00 100644
> > --- a/include/linux/tpm.h
> > +++ b/include/linux/tpm.h
> > @@ -335,6 +335,7 @@ enum tpm2_cc_attrs {
> >  #define TPM_VID_WINBOND  0x1050
> >  #define TPM_VID_STM      0x104A
> >  #define TPM_VID_ATML     0x1114
> > +#define TPM_VID_IFX      0x15D1
> >  
> >  enum tpm_chip_flags {
> >  	TPM_CHIP_FLAG_BOOTSTRAPPED		= BIT(0),

J.

-- 
... "What's the philosophical difference between a killfile and the
    automoderation?" "A killfile throws away good posts.  Automoderation
    throws away bad posts." -- Jonathan H N Chin to Calle Dybedahl

