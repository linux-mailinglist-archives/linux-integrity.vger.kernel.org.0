Return-Path: <linux-integrity+bounces-6201-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 61668AB6B23
	for <lists+linux-integrity@lfdr.de>; Wed, 14 May 2025 14:12:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29CAC4C2EED
	for <lists+linux-integrity@lfdr.de>; Wed, 14 May 2025 12:11:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACE9A1EB36;
	Wed, 14 May 2025 12:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="mjLPrrgL";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="NaRt2/Uz";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="mjLPrrgL";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="NaRt2/Uz"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B768227587A
	for <linux-integrity@vger.kernel.org>; Wed, 14 May 2025 12:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747224650; cv=none; b=WVyPmau95cuLRRzPlecNQPjOL60VsLLvN9UG/PR1cEChQTks6+i8Yiti2WVthu5fqlf0xEkESa/da6Jtv8DQj0s+Cnd3qmsrgLFaW5nb5u7hjEySDMCwiYx3WjoP8y2V+rxolA0JclnAZ41vhOGw7a3KnXvIoT6qUN/xhh8oEyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747224650; c=relaxed/simple;
	bh=ujFU64lUnTiA1/QHpshqazoqqgK3H8Ez9VWMW+ljgu0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EeR4hsTs42Rm1HirnxlVDqkjLfjJ3+kpLsrCwi6lbG3ejEiJnNqYx3L543wFGS3DIHKMBUO6G9IY1h1d5wOsu20QxpwAGIKtji1Xn9NxadGEMl8lW8viddOImiOinyZMgKXn52x1uCPk8rFwZHuKhYS/ndfcOPprQC1P3wxVOCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=mjLPrrgL; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=NaRt2/Uz; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=mjLPrrgL; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=NaRt2/Uz; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from kitsune.suse.cz (unknown [10.100.12.127])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D16A01F745;
	Wed, 14 May 2025 12:10:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1747224646; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Lw+353Ca7lhmfXTfDio3C8efnVDU+1woQnWA/apBzB8=;
	b=mjLPrrgLHlt+uXShOhyDAy/FpSMJaFSOUxmUDhtG0J+v+vjkmPwq8pne0bvJ6B3jc+qlyy
	sqQfahb1UcC1AhI1m7QWS6vVEw4L4w1TnfObHfxFK3ETV/HxGA+uQ2lHc5w0In8WYnxt5p
	YKV03EDbyAXtyulGCNjI2/F0H2psbOo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1747224646;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Lw+353Ca7lhmfXTfDio3C8efnVDU+1woQnWA/apBzB8=;
	b=NaRt2/UziOA672AmZIuYg6dQ8m4AL5lbhAgC6p8eP2LKvjGiSmon2085un6zbIEa/hdMjz
	nqbocSZWw+QOYtAQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1747224646; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Lw+353Ca7lhmfXTfDio3C8efnVDU+1woQnWA/apBzB8=;
	b=mjLPrrgLHlt+uXShOhyDAy/FpSMJaFSOUxmUDhtG0J+v+vjkmPwq8pne0bvJ6B3jc+qlyy
	sqQfahb1UcC1AhI1m7QWS6vVEw4L4w1TnfObHfxFK3ETV/HxGA+uQ2lHc5w0In8WYnxt5p
	YKV03EDbyAXtyulGCNjI2/F0H2psbOo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1747224646;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Lw+353Ca7lhmfXTfDio3C8efnVDU+1woQnWA/apBzB8=;
	b=NaRt2/UziOA672AmZIuYg6dQ8m4AL5lbhAgC6p8eP2LKvjGiSmon2085un6zbIEa/hdMjz
	nqbocSZWw+QOYtAQ==
Date: Wed, 14 May 2025 14:10:45 +0200
From: Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jonathan McDowell <noodles@earth.li>,
	Paul Menzel <pmenzel@molgen.mpg.de>
Subject: Re: [PATCH v3] tpm: tis: Double the timeout B to 4s
Message-ID: <aCSIRS1fq_b9sByn@kitsune.suse.cz>
References: <4e4640bd-0313-4594-9667-82340ed9368a@molgen.mpg.de>
 <20250404082325.13876-1-msuchanek@suse.de>
 <Z--d7Obw2UEk8Pve@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z--d7Obw2UEk8Pve@kernel.org>
X-Spam-Flag: NO
X-Spam-Score: -4.30
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_SEVEN(0.00)[7];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_ZERO(0.00)[0];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmx.de];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[gmx.de,ziepe.ca,vger.kernel.org,earth.li,molgen.mpg.de];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email]

Hello,

On Fri, Apr 04, 2025 at 11:53:00AM +0300, Jarkko Sakkinen wrote:
> On Fri, Apr 04, 2025 at 10:23:14AM +0200, Michal Suchanek wrote:
> > With some Infineon chips the timeouts in tpm_tis_send_data (both B and
> > C) can reach up to about 2250 ms.
> > 
> > Timeout C is retried since
> > commit de9e33df7762 ("tpm, tpm_tis: Workaround failed command reception on Infineon devices")
> > 
> > Timeout B still needs to be extended.
> > 
> > The problem is most commonly encountered with context related operation
> > such as load context/save context. These are issued directly by the
> > kernel, and there is no retry logic for them.
> > 
> > When a filesystem is set up to use the TPM for unlocking the boot fails,
> > and restarting the userspace service is ineffective. This is likely
> > because ignoring a load context/save context result puts the real TPM
> > state and the TPM state expected by the kernel out of sync.
> > 
> > Chips known to be affected:
> > tpm_tis IFX1522:00: 2.0 TPM (device-id 0x1D, rev-id 54)
> > Description: SLB9672
> > Firmware Revision: 15.22
> > 
> > tpm_tis MSFT0101:00: 2.0 TPM (device-id 0x1B, rev-id 22)
> > Firmware Revision: 7.83
> > 
> > tpm_tis MSFT0101:00: 2.0 TPM (device-id 0x1A, rev-id 16)
> > Firmware Revision: 5.63
> > 
> > Link: https://lore.kernel.org/linux-integrity/Z5pI07m0Muapyu9w@kitsune.suse.cz/
> > Signed-off-by: Michal Suchanek <msuchanek@suse.de>
> > ---
> > v2: Only extend timeout B
> > v3: Update commit message
> > ---
> >  drivers/char/tpm/tpm_tis_core.h | 2 +-
> >  include/linux/tpm.h             | 2 +-
> >  2 files changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/char/tpm/tpm_tis_core.h b/drivers/char/tpm/tpm_tis_core.h
> > index 970d02c337c7..6c3aa480396b 100644
> > --- a/drivers/char/tpm/tpm_tis_core.h
> > +++ b/drivers/char/tpm/tpm_tis_core.h
> > @@ -54,7 +54,7 @@ enum tis_int_flags {
> >  enum tis_defaults {
> >  	TIS_MEM_LEN = 0x5000,
> >  	TIS_SHORT_TIMEOUT = 750,	/* ms */
> > -	TIS_LONG_TIMEOUT = 2000,	/* 2 sec */
> > +	TIS_LONG_TIMEOUT = 4000,	/* 4 secs */
> >  	TIS_TIMEOUT_MIN_ATML = 14700,	/* usecs */
> >  	TIS_TIMEOUT_MAX_ATML = 15000,	/* usecs */
> >  };
> > diff --git a/include/linux/tpm.h b/include/linux/tpm.h
> > index 6c3125300c00..3db0b6a87d45 100644
> > --- a/include/linux/tpm.h
> > +++ b/include/linux/tpm.h
> > @@ -224,7 +224,7 @@ enum tpm2_const {
> >  
> >  enum tpm2_timeouts {
> >  	TPM2_TIMEOUT_A          =    750,
> > -	TPM2_TIMEOUT_B          =   2000,
> > +	TPM2_TIMEOUT_B          =   4000,
> >  	TPM2_TIMEOUT_C          =    200,
> >  	TPM2_TIMEOUT_D          =     30,
> >  	TPM2_DURATION_SHORT     =     20,
> > -- 
> > 2.47.1
> > 
> > 
> 
> Cc: stable@vger.kernel.org # v6.1+
> 
> Probably best that I'll piggyback a patch set for stable with the two
> fixes, in order to cause least noise. I need to do this *after* an
> ack'd PR to -rc2.

While there is talk about stable this does not seem to be applied
anywhere I could find. Is that expected?

Thanks

Michal

> 
> Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
> 
> BR, Jarkko

