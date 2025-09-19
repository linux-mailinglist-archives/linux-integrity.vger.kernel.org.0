Return-Path: <linux-integrity+bounces-7184-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5C67B87D51
	for <lists+linux-integrity@lfdr.de>; Fri, 19 Sep 2025 05:49:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6716D7C649B
	for <lists+linux-integrity@lfdr.de>; Fri, 19 Sep 2025 03:49:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F1B625A35F;
	Fri, 19 Sep 2025 03:49:40 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail.hallyn.com (mail.hallyn.com [178.63.66.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A71BD21FF45;
	Fri, 19 Sep 2025 03:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.63.66.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758253779; cv=none; b=cOY5JYjEwDpvfeZ5BC4p1gWR/i5kHux+FRACiRQ0lpml2k7L8CYT95ic49klpJEH8J1VI6VoNAhDOXj/5xy/kikkeQz5F17by2nJAEW++nmmwf9N9Q/uyVqiCo/qPnQHof39/Ld4LRQHqP0VjDe32m1ZdrU69EC7nhtiv4e+o8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758253779; c=relaxed/simple;
	bh=ZKwhkrmf78fE1drA6uOaBAgJGNVlmr5uJlAnb2EaGhY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B9sjTdsF4eq6SUx5sjUjX3zN8SdetRFqf26uDCMKYZRnmTNnaZO2BBX1z83nNXUNOCCEekCrj3oiG5QNfm1FVMUq8P6ZcbQ5gi9CNVquGsAoLhCsY8Rp2dBco+9eC2HAFzZmy3cAzeHDebd206JB3m9t4kq+DWigRVm54Fzdwk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hallyn.com; spf=pass smtp.mailfrom=mail.hallyn.com; arc=none smtp.client-ip=178.63.66.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hallyn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.hallyn.com
Received: by mail.hallyn.com (Postfix, from userid 1001)
	id CC80C499; Thu, 18 Sep 2025 22:49:28 -0500 (CDT)
Date: Thu, 18 Sep 2025 22:49:28 -0500
From: "Serge E. Hallyn" <serge@hallyn.com>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: linux-integrity@vger.kernel.org,
	=?iso-8859-1?Q?Fr=E9d=E9ric?= Jouen <fjouen@sealsq.com>,
	Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	David Howells <dhowells@redhat.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:KEYS-TRUSTED" <keyrings@vger.kernel.org>,
	"open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>
Subject: Re: [PATCH v2] tpm: use a map for tpm2_calc_ordinal_duration()
Message-ID: <aMzSyCQks3NlMhPI@mail.hallyn.com>
References: <20250918193019.4018706-1-jarkko@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250918193019.4018706-1-jarkko@kernel.org>

On Thu, Sep 18, 2025 at 10:30:18PM +0300, Jarkko Sakkinen wrote:
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

fwiw (which shouldn't be much) looks good to me, but two questions,
one here and one below.

First, it looks like in the existing code it is possible for a tpm2
chip to set its own timeouts and then set the TPM_CHIP_FLAG_HAVE_TIMEOUTS
flag to avoid using the defaults, but I don't see anything using that
in-tree.  Is it possible that there are out of tree drivers that will be
sabotaged here?  Or am I misunderstanding that completely?

> ---
> v2:
> - Add the missing msec_to_jiffies() calls.
> - Drop redundant stuff.
> ---
>  drivers/char/tpm/tpm-interface.c |   2 +-
>  drivers/char/tpm/tpm.h           |   2 +-
>  drivers/char/tpm/tpm2-cmd.c      | 127 ++++++++-----------------------
>  include/linux/tpm.h              |   5 +-
>  4 files changed, 37 insertions(+), 99 deletions(-)
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
> index 524d802ede26..7d77f6fbc152 100644
> --- a/drivers/char/tpm/tpm2-cmd.c
> +++ b/drivers/char/tpm/tpm2-cmd.c
> @@ -28,120 +28,57 @@ static struct tpm2_hash tpm2_hash_map[] = {
>  
>  int tpm2_get_timeouts(struct tpm_chip *chip)
>  {
> -	/* Fixed timeouts for TPM2 */
>  	chip->timeout_a = msecs_to_jiffies(TPM2_TIMEOUT_A);
>  	chip->timeout_b = msecs_to_jiffies(TPM2_TIMEOUT_B);
>  	chip->timeout_c = msecs_to_jiffies(TPM2_TIMEOUT_C);
>  	chip->timeout_d = msecs_to_jiffies(TPM2_TIMEOUT_D);
> -
> -	/* PTP spec timeouts */
> -	chip->duration[TPM_SHORT] = msecs_to_jiffies(TPM2_DURATION_SHORT);
> -	chip->duration[TPM_MEDIUM] = msecs_to_jiffies(TPM2_DURATION_MEDIUM);
> -	chip->duration[TPM_LONG] = msecs_to_jiffies(TPM2_DURATION_LONG);
> -
> -	/* Key creation commands long timeouts */
> -	chip->duration[TPM_LONG_LONG] =
> -		msecs_to_jiffies(TPM2_DURATION_LONG_LONG);
> -
>  	chip->flags |= TPM_CHIP_FLAG_HAVE_TIMEOUTS;
> -
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

I assume you intended to increase TPM2_CC_SELF_TEST from 2000 to 3000
here?  But it's not mentioned in the commit, so making sure...

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
> +			return msecs_to_jiffies(tpm2_ordinal_duration_map[i].duration);
>  
> -	if (index != TPM_UNDEFINED)
> -		return chip->duration[index];
> -	else
> -		return msecs_to_jiffies(TPM2_DURATION_DEFAULT);
> +	return msecs_to_jiffies(TPM2_DURATION_DEFAULT);
>  }
>  
> -
>  struct tpm2_pcr_read_out {
>  	__be32	update_cnt;
>  	__be32	pcr_selects_cnt;
> diff --git a/include/linux/tpm.h b/include/linux/tpm.h
> index b0e9eb5ef022..dc0338a783f3 100644
> --- a/include/linux/tpm.h
> +++ b/include/linux/tpm.h
> @@ -228,10 +228,11 @@ enum tpm2_timeouts {
>  	TPM2_TIMEOUT_B          =   4000,
>  	TPM2_TIMEOUT_C          =    200,
>  	TPM2_TIMEOUT_D          =     30,
> +};
> +
> +enum tpm2_durations {
>  	TPM2_DURATION_SHORT     =     20,
> -	TPM2_DURATION_MEDIUM    =    750,
>  	TPM2_DURATION_LONG      =   2000,
> -	TPM2_DURATION_LONG_LONG = 300000,
>  	TPM2_DURATION_DEFAULT   = 120000,
>  };
>  
> -- 
> 2.39.5

