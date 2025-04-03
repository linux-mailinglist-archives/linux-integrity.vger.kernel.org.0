Return-Path: <linux-integrity+bounces-5569-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B364A7A012
	for <lists+linux-integrity@lfdr.de>; Thu,  3 Apr 2025 11:33:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DECC91896568
	for <lists+linux-integrity@lfdr.de>; Thu,  3 Apr 2025 09:32:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2CC6245024;
	Thu,  3 Apr 2025 09:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="fJEdpjzE";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="uzzHJS49";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="fJEdpjzE";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="uzzHJS49"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDAA5244186
	for <linux-integrity@vger.kernel.org>; Thu,  3 Apr 2025 09:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743672713; cv=none; b=RShLH0e9MnjAMmSY6eiqFhmo8/0exJJ7hPkIZKpV222NY4d5YaI5tAu+hxEyVqipCYbA1lIHf+/bigx6AQ82UpdjBNL10n/Phrnfn8YnVSW3Mm1AXQws6MaFq9FPA97Z5iAes9z3Jazq2kazJMlUdGHwMm+T2wPFwc5rqoO0ucc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743672713; c=relaxed/simple;
	bh=4gL8+YHacCQsGjgfT+A3Dl7bUf0ULT3DlZLgsy3zTWA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pO0uc1s8h3uo8SWYIaX0K4LFxQZf/F6udSFUMTbubgHD8nk/qv1lz5r4GJj+cRC8/MEBW0FBPshhLMdwh37DSZw0DoD/iZQg3ENMIEZ2b/wPyzIgkjaoC3ns0N/MbTXmfG+liWRSi0+Vg6pLRAoUD87fjGXQaWtGjsGoOfCIlMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=fJEdpjzE; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=uzzHJS49; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=fJEdpjzE; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=uzzHJS49; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from kitsune.suse.cz (unknown [10.100.12.127])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 0804C1F38A;
	Thu,  3 Apr 2025 09:31:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1743672710; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FrDtBuA5lBFITYNZztuKuaEY2YG6Uy6zNAQMxJHFY1c=;
	b=fJEdpjzEsx2PP7W05nAGLBzzV2TgpjMkVYp9HiFPs+oj8BanDKoVUH7lWlz/s/nJpJQofX
	Np74yk27Bk3wBkGdN/XrJik2Ojd0r0wupDrGF6bXlaDn/ZWIpterYPqNF50rfHl27GhfsN
	Z3d3l36vkB06Vi1sPabdqzk+cfWxXCc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1743672710;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FrDtBuA5lBFITYNZztuKuaEY2YG6Uy6zNAQMxJHFY1c=;
	b=uzzHJS49iX85Ohem6jX6UiCMwI0t/YxRno4nhSgizKGV20u/5qz5s+tckAAWl9w2so6e0F
	YuLs5QhEsQkpOUAw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1743672710; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FrDtBuA5lBFITYNZztuKuaEY2YG6Uy6zNAQMxJHFY1c=;
	b=fJEdpjzEsx2PP7W05nAGLBzzV2TgpjMkVYp9HiFPs+oj8BanDKoVUH7lWlz/s/nJpJQofX
	Np74yk27Bk3wBkGdN/XrJik2Ojd0r0wupDrGF6bXlaDn/ZWIpterYPqNF50rfHl27GhfsN
	Z3d3l36vkB06Vi1sPabdqzk+cfWxXCc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1743672710;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FrDtBuA5lBFITYNZztuKuaEY2YG6Uy6zNAQMxJHFY1c=;
	b=uzzHJS49iX85Ohem6jX6UiCMwI0t/YxRno4nhSgizKGV20u/5qz5s+tckAAWl9w2so6e0F
	YuLs5QhEsQkpOUAw==
Date: Thu, 3 Apr 2025 11:31:48 +0200
From: Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To: Jonathan McDowell <noodles@earth.li>
Cc: Peter Huewe <peterhuewe@gmx.de>, Jarkko Sakkinen <jarkko@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>, linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tpm: tis: Increase the default for timeouts B and C
Message-ID: <Z-5VhOpQOeduSUM1@kitsune.suse.cz>
References: <20250402172134.7751-1-msuchanek@suse.de>
 <Z-13xOebA3LvQQ-8@earth.li>
 <Z-2ZC2Ew2EtNAW6-@kitsune.suse.cz>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z-2ZC2Ew2EtNAW6-@kitsune.suse.cz>
X-Spam-Score: -4.30
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
X-Spam-Flag: NO
X-Spam-Level: 

On Wed, Apr 02, 2025 at 10:07:40PM +0200, Michal Suchánek wrote:
> On Wed, Apr 02, 2025 at 06:45:40PM +0100, Jonathan McDowell wrote:
> > On Wed, Apr 02, 2025 at 07:21:30PM +0200, Michal Suchanek wrote:
> > > With some Infineon chips the timeouts in tpm_tis_send_data (both B and
> > > C) can reach up to about 2250 ms.
> > > 
> > > Extend the timeout duration to accommodate this.
> > 
> > The problem here is the bump of timeout_c is going to interact poorly with
> > the Infineon errata workaround, as now we'll wait 4s instead of 200ms to
> > detect the stuck status change.
> 
> Yes, that's problematic. Is it possible to detect the errata by anything
> other than waiting for the timeout to expire?
> 
> > 
> > (Also shouldn't timeout_c already end up as 750ms, as it's
> > max(TIS_SHORT_TIMEOUT, TPM2_TIMEOUT_C), and TIS_SHORT_TIMEOUT is 750 vs 200
> > for TPM2_TIMEOUT_C? That doesn't seem to be borne out by your logs, nor my
> > results.)
> 
> Indeed, it should be 750ms but the logs show 200ms. I do not see
> where it could get reduced, nor any significan difference between the
> mainline code and the kernel I am using in this area.

This would come from

drivers/char/tpm/tpm2-cmd.c:    chip->timeout_c = msecs_to_jiffies(TPM2_TIMEOUT_C);
include/linux/tpm.h:    TPM2_TIMEOUT_C          =    200,

So this would need also adjusting.

Thanks

Michal

> 
> Thanks
> 
> Michal
> 
> > 
> > > Link: https://lore.kernel.org/linux-integrity/Z5pI07m0Muapyu9w@kitsune.suse.cz/
> > > Signed-off-by: Michal Suchanek <msuchanek@suse.de>
> > > ---
> > > An alternative would be to add an entry to vendor_timeout_overrides but
> > > I do not know how to determine the chip IDs to put into this table.
> > > ---
> > > drivers/char/tpm/tpm_tis_core.h | 4 ++--
> > > 1 file changed, 2 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/drivers/char/tpm/tpm_tis_core.h b/drivers/char/tpm/tpm_tis_core.h
> > > index 970d02c337c7..1ff565be2175 100644
> > > --- a/drivers/char/tpm/tpm_tis_core.h
> > > +++ b/drivers/char/tpm/tpm_tis_core.h
> > > @@ -54,7 +54,7 @@ enum tis_int_flags {
> > > enum tis_defaults {
> > > 	TIS_MEM_LEN = 0x5000,
> > > 	TIS_SHORT_TIMEOUT = 750,	/* ms */
> > > -	TIS_LONG_TIMEOUT = 2000,	/* 2 sec */
> > > +	TIS_LONG_TIMEOUT = 4000,	/* 2 sec */
> > > 	TIS_TIMEOUT_MIN_ATML = 14700,	/* usecs */
> > > 	TIS_TIMEOUT_MAX_ATML = 15000,	/* usecs */
> > > };
> > > @@ -64,7 +64,7 @@ enum tis_defaults {
> > >  */
> > > #define TIS_TIMEOUT_A_MAX	max_t(int, TIS_SHORT_TIMEOUT, TPM2_TIMEOUT_A)
> > > #define TIS_TIMEOUT_B_MAX	max_t(int, TIS_LONG_TIMEOUT, TPM2_TIMEOUT_B)
> > > -#define TIS_TIMEOUT_C_MAX	max_t(int, TIS_SHORT_TIMEOUT, TPM2_TIMEOUT_C)
> > > +#define TIS_TIMEOUT_C_MAX	max_t(int, TIS_LONG_TIMEOUT, TPM2_TIMEOUT_C)
> > > #define TIS_TIMEOUT_D_MAX	max_t(int, TIS_SHORT_TIMEOUT, TPM2_TIMEOUT_D)
> > > 
> > > #define	TPM_ACCESS(l)			(0x0000 | ((l) << 12))
> > > -- 
> > > 2.47.1
> > > 
> > 
> > J.
> > 
> > -- 
> > ... "Tom's root boot is the Linux world equivalent of a 'get out of jail
> >     free' card. The man is a *hero*." -- Simon Brooke, ucol.

