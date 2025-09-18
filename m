Return-Path: <linux-integrity+bounces-7179-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 66E55B86A49
	for <lists+linux-integrity@lfdr.de>; Thu, 18 Sep 2025 21:15:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC74418956B5
	for <lists+linux-integrity@lfdr.de>; Thu, 18 Sep 2025 19:15:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21AE02C17B3;
	Thu, 18 Sep 2025 19:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="edoe2CdQ"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3F1E1B424F;
	Thu, 18 Sep 2025 19:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758222895; cv=none; b=hA2qcdQI6OEhTYs3CKTUNYUaXVq8P55idMfNMYIkepfET+Bai2KUY/gA9jBjq0hjSx9O4fXHTCXIAoboQ0bhGhrNlpciUFl3ipFixQrnGptzlXT9Jlq0HK65zRwUbUM7UPuSZc8kz33hujnczJ/+Kp6HAPShKLTxT7m5CfU2Wnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758222895; c=relaxed/simple;
	bh=phUptnMVhO51RdGakCtNaq3B0t64kIgqJTxycLBFygE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mskE6cwd3Hsbzi9pS32ffDbJuV7mTJB0lYZyWzwFQNhvCUpuVnO6yyacYXGn6RUMk4SV/dZGJHW3Vac5Dxrt68BemTWn2GmC2nXFC9rXiwmvaFLPrr2kvOn1d7M5K/4y8zqf2RXdmwRkfBhgtabsRNw1gqNCYd+RdbAJoIggJUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=edoe2CdQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61115C4CEE7;
	Thu, 18 Sep 2025 19:14:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758222894;
	bh=phUptnMVhO51RdGakCtNaq3B0t64kIgqJTxycLBFygE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=edoe2CdQzDviYw0AT2viFM5LM1f5bZwStAXvHdfJ3l4h163aeKCiI7BT/TGWTJ4GI
	 jXxnd4q7JozjnBPxaU1t5ivklFo1b6lw4orb2wf03IYBqBhQQext0O7vo8ScUIrdav
	 rctoNpPKjll3ifbBIjK+F+U9a2s9aZ64LLXLaM/r1Wr5DzjY/wK7N1U60SfGsolM5s
	 EBYw/oGdHFGF9FvhNYLR+Qxsgb0UCP9kMVWJMiPe2Lm6vFiUVdOSAS/N/wIO++JCXb
	 xCFKnD5Q5osTxi7oBrkLDg7aAmbz+v2/q6MecKOedGZuH2vL4CEPYXIrAKw5hz8St7
	 vmMOU8tUS1cGw==
Date: Thu, 18 Sep 2025 22:14:50 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: linux-integrity@vger.kernel.org
Cc: =?iso-8859-1?Q?Fr=E9d=E9ric?= Jouen <fjouen@sealsq.com>,
	Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	David Howells <dhowells@redhat.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:KEYS-TRUSTED" <keyrings@vger.kernel.org>,
	"open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>
Subject: Re: [PATCH] tpm: use a map for tpm2_calc_ordinal_duration()
Message-ID: <aMxaKleVR8i6s9vX@kernel.org>
References: <20250918185730.3529317-1-jarkko@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250918185730.3529317-1-jarkko@kernel.org>

On Thu, Sep 18, 2025 at 09:57:30PM +0300, Jarkko Sakkinen wrote:
> The current shenanigans for duration calculation introduce too much
> complexity for a trivial problem, and further the code is hard to patch and
> maintain.
> 
> Address these issues with a flat look-up table, which is easy to understand
> and patch. If leaf driver specific patching is required in future, it is
> easy enough to make a copy of this table during driver initialization and
> add the chip parameter back.
> 
> 'chip->duration' is retained for TPM 1.x.
> 
> As the first entry for this new behavior address TCG spec update mentioned
> in this issue:
> 
> https://github.com/raspberrypi/linux/issues/7054
> 
> Therefore, for TPM_SelfTest the duration is set to 3000 ms.
> 
> This does not categorize a as bug, given that this is introduced to the
> spec after the feature was originally made.
> 
> Cc: Frédéric Jouen <fjouen@sealsq.com>
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> ---
>  drivers/char/tpm/tpm-interface.c |   2 +-
>  drivers/char/tpm/tpm.h           |   2 +-
>  drivers/char/tpm/tpm2-cmd.c      | 115 +++++++++----------------------
>  3 files changed, 34 insertions(+), 85 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
> index b71725827743..c9f173001d0e 100644
> --- a/drivers/char/tpm/tpm-interface.c
> +++ b/drivers/char/tpm/tpm-interface.c
> @@ -52,7 +52,7 @@ MODULE_PARM_DESC(suspend_pcr,
>  unsigned long tpm_calc_ordinal_duration(struct tpm_chip *chip, u32 ordinal)
>  {
>  	if (chip->flags & TPM_CHIP_FLAG_TPM2)
> -		return tpm2_calc_ordinal_duration(chip, ordinal);
> +		return tpm2_calc_ordinal_duration(ordinal);
>  	else
>  		return tpm1_calc_ordinal_duration(chip, ordinal);
>  }
> diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
> index 7bb87fa5f7a1..2726bd38e5ac 100644
> --- a/drivers/char/tpm/tpm.h
> +++ b/drivers/char/tpm/tpm.h
> @@ -299,7 +299,7 @@ ssize_t tpm2_get_tpm_pt(struct tpm_chip *chip, u32 property_id,
>  ssize_t tpm2_get_pcr_allocation(struct tpm_chip *chip);
>  int tpm2_auto_startup(struct tpm_chip *chip);
>  void tpm2_shutdown(struct tpm_chip *chip, u16 shutdown_type);
> -unsigned long tpm2_calc_ordinal_duration(struct tpm_chip *chip, u32 ordinal);
> +unsigned long tpm2_calc_ordinal_duration(u32 ordinal);
>  int tpm2_probe(struct tpm_chip *chip);
>  int tpm2_get_cc_attrs_tbl(struct tpm_chip *chip);
>  int tpm2_find_cc(struct tpm_chip *chip, u32 cc);
> diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
> index 524d802ede26..29c0d6a8ec20 100644
> --- a/drivers/char/tpm/tpm2-cmd.c
> +++ b/drivers/char/tpm/tpm2-cmd.c
> @@ -48,100 +48,49 @@ int tpm2_get_timeouts(struct tpm_chip *chip)
>  	return 0;
>  }
>  
> -/**
> - * tpm2_ordinal_duration_index() - returns an index to the chip duration table
> - * @ordinal: TPM command ordinal.
> - *
> - * The function returns an index to the chip duration table
> - * (enum tpm_duration), that describes the maximum amount of
> - * time the chip could take to return the result for a  particular ordinal.
> - *
> - * The values of the MEDIUM, and LONG durations are taken
> - * from the PC Client Profile (PTP) specification (750, 2000 msec)
> - *
> - * LONG_LONG is for commands that generates keys which empirically takes
> - * a longer time on some systems.
> - *
> - * Return:
> - * * TPM_MEDIUM
> - * * TPM_LONG
> - * * TPM_LONG_LONG
> - * * TPM_UNDEFINED
> +/*
> + * Contains the maximum durations in milliseconds for TPM2 commands.
>   */
> -static u8 tpm2_ordinal_duration_index(u32 ordinal)
> -{
> -	switch (ordinal) {
> -	/* Startup */
> -	case TPM2_CC_STARTUP:                 /* 144 */
> -		return TPM_MEDIUM;
> -
> -	case TPM2_CC_SELF_TEST:               /* 143 */
> -		return TPM_LONG;
> -
> -	case TPM2_CC_GET_RANDOM:              /* 17B */
> -		return TPM_LONG;
> -
> -	case TPM2_CC_SEQUENCE_UPDATE:         /* 15C */
> -		return TPM_MEDIUM;
> -	case TPM2_CC_SEQUENCE_COMPLETE:       /* 13E */
> -		return TPM_MEDIUM;
> -	case TPM2_CC_EVENT_SEQUENCE_COMPLETE: /* 185 */
> -		return TPM_MEDIUM;
> -	case TPM2_CC_HASH_SEQUENCE_START:     /* 186 */
> -		return TPM_MEDIUM;
> -
> -	case TPM2_CC_VERIFY_SIGNATURE:        /* 177 */
> -		return TPM_LONG_LONG;
> -
> -	case TPM2_CC_PCR_EXTEND:              /* 182 */
> -		return TPM_MEDIUM;
> -
> -	case TPM2_CC_HIERARCHY_CONTROL:       /* 121 */
> -		return TPM_LONG;
> -	case TPM2_CC_HIERARCHY_CHANGE_AUTH:   /* 129 */
> -		return TPM_LONG;
> -
> -	case TPM2_CC_GET_CAPABILITY:          /* 17A */
> -		return TPM_MEDIUM;
> -
> -	case TPM2_CC_NV_READ:                 /* 14E */
> -		return TPM_LONG;
> -
> -	case TPM2_CC_CREATE_PRIMARY:          /* 131 */
> -		return TPM_LONG_LONG;
> -	case TPM2_CC_CREATE:                  /* 153 */
> -		return TPM_LONG_LONG;
> -	case TPM2_CC_CREATE_LOADED:           /* 191 */
> -		return TPM_LONG_LONG;
> -
> -	default:
> -		return TPM_UNDEFINED;
> -	}
> -}
> +static const struct {
> +	unsigned long ordinal;
> +	unsigned long duration;
> +} tpm2_ordinal_duration_map[] = {
> +	{TPM2_CC_STARTUP, 750},
> +	{TPM2_CC_SELF_TEST, 3000},
> +	{TPM2_CC_GET_RANDOM, 2000},
> +	{TPM2_CC_SEQUENCE_UPDATE, 750},
> +	{TPM2_CC_SEQUENCE_COMPLETE, 750},
> +	{TPM2_CC_EVENT_SEQUENCE_COMPLETE, 750},
> +	{TPM2_CC_HASH_SEQUENCE_START, 750},
> +	{TPM2_CC_VERIFY_SIGNATURE, 30000},
> +	{TPM2_CC_PCR_EXTEND, 750},
> +	{TPM2_CC_HIERARCHY_CONTROL, 2000},
> +	{TPM2_CC_HIERARCHY_CHANGE_AUTH, 2000},
> +	{TPM2_CC_GET_CAPABILITY, 750},
> +	{TPM2_CC_NV_READ, 2000},
> +	{TPM2_CC_CREATE_PRIMARY, 30000},
> +	{TPM2_CC_CREATE, 30000},
> +	{TPM2_CC_CREATE_LOADED, 30000},
> +};
>  
>  /**
> - * tpm2_calc_ordinal_duration() - calculate the maximum command duration
> - * @chip:    TPM chip to use.
> + * tpm2_calc_ordinal_duration() - Calculate the maximum command duration
>   * @ordinal: TPM command ordinal.
>   *
> - * The function returns the maximum amount of time the chip could take
> - * to return the result for a particular ordinal in jiffies.
> - *
> - * Return: A maximal duration time for an ordinal in jiffies.
> + * Returns the maximum amount of time the chip is expected by kernel to
> + * take in jiffies.
>   */
> -unsigned long tpm2_calc_ordinal_duration(struct tpm_chip *chip, u32 ordinal)
> +unsigned long tpm2_calc_ordinal_duration(u32 ordinal)
>  {
> -	unsigned int index;
> +	int i;
>  
> -	index = tpm2_ordinal_duration_index(ordinal);
> +	for (i = 0; i < ARRAY_SIZE(tpm2_ordinal_duration_map); i++)
> +		if (ordinal == tpm2_ordinal_duration_map[i].ordinal)
> +			return tpm2_ordinal_duration_map[i].duration;
>  
> -	if (index != TPM_UNDEFINED)
> -		return chip->duration[index];
> -	else
> -		return msecs_to_jiffies(TPM2_DURATION_DEFAULT);
> +	return TPM2_DURATION_DEFAULT;

Ouch, I'm fully acknowledged that msecs_to_jiffies() is missing from the patch.

I'll post +1 so that it is testable.

>  }
>  
> -
>  struct tpm2_pcr_read_out {
>  	__be32	update_cnt;
>  	__be32	pcr_selects_cnt;
> -- 
> 2.39.5
> 
> 

BR, Jarkko

