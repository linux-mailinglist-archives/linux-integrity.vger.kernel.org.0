Return-Path: <linux-integrity+bounces-5560-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 87646A79643
	for <lists+linux-integrity@lfdr.de>; Wed,  2 Apr 2025 22:07:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D52616F6A5
	for <lists+linux-integrity@lfdr.de>; Wed,  2 Apr 2025 20:07:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02ABB1EF399;
	Wed,  2 Apr 2025 20:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="0M8f6CAK";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="r41Fkh3m";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="0M8f6CAK";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="r41Fkh3m"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11C6F1EF097
	for <linux-integrity@vger.kernel.org>; Wed,  2 Apr 2025 20:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743624464; cv=none; b=n5Oh5btqVKMwsQsbJYxdSBGrPAghODeEcmeYF5DuLC7nKheDPOLVp/Ahkq14O3yauRrz9y/u0vLnwcYJULIcEsmkmgrvayyemVoawUG9kBjSWJxdmwt/dM3ium76DULXLNEA5KbpdMt5Tqz+uQuSmPuX8cpT6WO77UAG1VFg8E0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743624464; c=relaxed/simple;
	bh=poh+U8UleCOeSwYeg2OLhmlTvH7tkKlO9s0Kva+gGho=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZoqexVJAYuRhYv8fADPYhXJBhVTywo8Tlw3Tt3YlYhqoa4GlOf6ok7gg3seiuFz6k6LEiWH5BS2RuCj0NODZEbtMBV52GiquPuR5Hc9vQG5cHmT+1PsnDsNyDuS2LPDm7DfTuxR7xQ03EAgyasan4Uf6bWeg4IT4FoQWsnTx2c4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=0M8f6CAK; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=r41Fkh3m; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=0M8f6CAK; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=r41Fkh3m; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from kitsune.suse.cz (unknown [10.100.12.127])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 2242E1F385;
	Wed,  2 Apr 2025 20:07:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1743624460; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4i+Fvnqz37OGx7w5VW2ghtTc8cJeR10UxKS3UMJtaRU=;
	b=0M8f6CAKlAV0wm8SXL2AP2ITBuMRrnrmw6iQPHxudPETSh2YNfT2RDryC7w6BoNsdVEmul
	ULjNyePBQgh09KiQkwpOGlWIagsvi0kttQGUQy5ytKqytxhiZzZcHe/m8iqTKbXqj7o25g
	e/7/6qcNLduhr/RbCAV63tAR+V1SMps=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1743624460;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4i+Fvnqz37OGx7w5VW2ghtTc8cJeR10UxKS3UMJtaRU=;
	b=r41Fkh3msYjJV7kOkSA1cy88LQ+b2ZOHmnNx2juVMraBtYiOm2lORIZAabf8c8qagrPR53
	v1dfPDC4UEtplvAg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1743624460; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4i+Fvnqz37OGx7w5VW2ghtTc8cJeR10UxKS3UMJtaRU=;
	b=0M8f6CAKlAV0wm8SXL2AP2ITBuMRrnrmw6iQPHxudPETSh2YNfT2RDryC7w6BoNsdVEmul
	ULjNyePBQgh09KiQkwpOGlWIagsvi0kttQGUQy5ytKqytxhiZzZcHe/m8iqTKbXqj7o25g
	e/7/6qcNLduhr/RbCAV63tAR+V1SMps=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1743624460;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4i+Fvnqz37OGx7w5VW2ghtTc8cJeR10UxKS3UMJtaRU=;
	b=r41Fkh3msYjJV7kOkSA1cy88LQ+b2ZOHmnNx2juVMraBtYiOm2lORIZAabf8c8qagrPR53
	v1dfPDC4UEtplvAg==
Date: Wed, 2 Apr 2025 22:07:39 +0200
From: Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To: Jonathan McDowell <noodles@earth.li>
Cc: Peter Huewe <peterhuewe@gmx.de>, Jarkko Sakkinen <jarkko@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>, linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tpm: tis: Increase the default for timeouts B and C
Message-ID: <Z-2ZC2Ew2EtNAW6-@kitsune.suse.cz>
References: <20250402172134.7751-1-msuchanek@suse.de>
 <Z-13xOebA3LvQQ-8@earth.li>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z-13xOebA3LvQQ-8@earth.li>
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_ZERO(0.00)[0];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmx.de];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[gmx.de,kernel.org,ziepe.ca,vger.kernel.org];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email]
X-Spam-Score: -4.30
X-Spam-Flag: NO

On Wed, Apr 02, 2025 at 06:45:40PM +0100, Jonathan McDowell wrote:
> On Wed, Apr 02, 2025 at 07:21:30PM +0200, Michal Suchanek wrote:
> > With some Infineon chips the timeouts in tpm_tis_send_data (both B and
> > C) can reach up to about 2250 ms.
> > 
> > Extend the timeout duration to accommodate this.
> 
> The problem here is the bump of timeout_c is going to interact poorly with
> the Infineon errata workaround, as now we'll wait 4s instead of 200ms to
> detect the stuck status change.

Yes, that's problematic. Is it possible to detect the errata by anything
other than waiting for the timeout to expire?

> 
> (Also shouldn't timeout_c already end up as 750ms, as it's
> max(TIS_SHORT_TIMEOUT, TPM2_TIMEOUT_C), and TIS_SHORT_TIMEOUT is 750 vs 200
> for TPM2_TIMEOUT_C? That doesn't seem to be borne out by your logs, nor my
> results.)

Indeed, it should be 750ms but the logs show 200ms. I do not see
where it could get reduced, nor any significan difference between the
mainline code and the kernel I am using in this area.

Thanks

Michal

> 
> > Link: https://lore.kernel.org/linux-integrity/Z5pI07m0Muapyu9w@kitsune.suse.cz/
> > Signed-off-by: Michal Suchanek <msuchanek@suse.de>
> > ---
> > An alternative would be to add an entry to vendor_timeout_overrides but
> > I do not know how to determine the chip IDs to put into this table.
> > ---
> > drivers/char/tpm/tpm_tis_core.h | 4 ++--
> > 1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/char/tpm/tpm_tis_core.h b/drivers/char/tpm/tpm_tis_core.h
> > index 970d02c337c7..1ff565be2175 100644
> > --- a/drivers/char/tpm/tpm_tis_core.h
> > +++ b/drivers/char/tpm/tpm_tis_core.h
> > @@ -54,7 +54,7 @@ enum tis_int_flags {
> > enum tis_defaults {
> > 	TIS_MEM_LEN = 0x5000,
> > 	TIS_SHORT_TIMEOUT = 750,	/* ms */
> > -	TIS_LONG_TIMEOUT = 2000,	/* 2 sec */
> > +	TIS_LONG_TIMEOUT = 4000,	/* 2 sec */
> > 	TIS_TIMEOUT_MIN_ATML = 14700,	/* usecs */
> > 	TIS_TIMEOUT_MAX_ATML = 15000,	/* usecs */
> > };
> > @@ -64,7 +64,7 @@ enum tis_defaults {
> >  */
> > #define TIS_TIMEOUT_A_MAX	max_t(int, TIS_SHORT_TIMEOUT, TPM2_TIMEOUT_A)
> > #define TIS_TIMEOUT_B_MAX	max_t(int, TIS_LONG_TIMEOUT, TPM2_TIMEOUT_B)
> > -#define TIS_TIMEOUT_C_MAX	max_t(int, TIS_SHORT_TIMEOUT, TPM2_TIMEOUT_C)
> > +#define TIS_TIMEOUT_C_MAX	max_t(int, TIS_LONG_TIMEOUT, TPM2_TIMEOUT_C)
> > #define TIS_TIMEOUT_D_MAX	max_t(int, TIS_SHORT_TIMEOUT, TPM2_TIMEOUT_D)
> > 
> > #define	TPM_ACCESS(l)			(0x0000 | ((l) << 12))
> > -- 
> > 2.47.1
> > 
> 
> J.
> 
> -- 
> ... "Tom's root boot is the Linux world equivalent of a 'get out of jail
>     free' card. The man is a *hero*." -- Simon Brooke, ucol.

