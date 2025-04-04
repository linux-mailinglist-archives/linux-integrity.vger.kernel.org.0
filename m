Return-Path: <linux-integrity+bounces-5602-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC7B2A7B89B
	for <lists+linux-integrity@lfdr.de>; Fri,  4 Apr 2025 10:12:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6AACC3B730F
	for <lists+linux-integrity@lfdr.de>; Fri,  4 Apr 2025 08:12:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 892E5185B48;
	Fri,  4 Apr 2025 08:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="koyH4ds5";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="M+6OzX/9";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="koyH4ds5";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="M+6OzX/9"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE2481F94C
	for <linux-integrity@vger.kernel.org>; Fri,  4 Apr 2025 08:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743754343; cv=none; b=mGC1VdRaWHLc02/gwMjn4so3+20ghYQckuJzW/b0SU6SFk1XlvuJ+kl2ceXGqnZZU9tE3s4JOFo2zcjGUpeJmjTyn1bO0bQCpB8PfB+nELocMWaMMMWESVAGt6o4bEG8US750CYePoNdHxqve8u7KmTVpMuWoI+8dNQ82iEekuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743754343; c=relaxed/simple;
	bh=Oqr11zIxgNoiHeLb/HURxCJxBg801+6ianelHo9hn8Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IhHuSGMMjPpycMWDoHsdNpNvy4LH4VFXYx03EGidMjxFMhn7l7Jzjl1kIf4cyqeZEkmaGlEAebL0p/V9qJ/6c6E0fzcYwzB2oQbHxOt6iXPNtX0eL/SqqU0cJ1R9v+zvM9PJMKV4Cdpux/lFkVH3/3/N1FpHqdYYMJrFYZ1GQZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=koyH4ds5; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=M+6OzX/9; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=koyH4ds5; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=M+6OzX/9; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from kitsune.suse.cz (unknown [10.100.12.127])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 02D7F1F385;
	Fri,  4 Apr 2025 08:12:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1743754340; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JdWFCM6wgiAszOmmUuM8vJDI4iobRdaUPvcZb1qFO6s=;
	b=koyH4ds5U53+0BpKxVKOR008OolDpPq0VsOpRg/tCzAIGWUDY7Ba4APygsuq8CoNAFUW9l
	k2w6bCZ7WDt7paGo1pmCbrgsdTOl0f/DlxtJSNBsG0IgRIsyORNVJSpYpvqWBCSdqmBA1e
	CTUPIT5E0hbb9P6X6gJxaF0I+nJdwOk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1743754340;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JdWFCM6wgiAszOmmUuM8vJDI4iobRdaUPvcZb1qFO6s=;
	b=M+6OzX/9fGJdOneUh7kbYv+jaIT0Lly0XMHpexdJkesXNRFCAcXpD22CJYjVahR7VQt2vM
	Bpyq4gHmtqvRCMAg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1743754340; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JdWFCM6wgiAszOmmUuM8vJDI4iobRdaUPvcZb1qFO6s=;
	b=koyH4ds5U53+0BpKxVKOR008OolDpPq0VsOpRg/tCzAIGWUDY7Ba4APygsuq8CoNAFUW9l
	k2w6bCZ7WDt7paGo1pmCbrgsdTOl0f/DlxtJSNBsG0IgRIsyORNVJSpYpvqWBCSdqmBA1e
	CTUPIT5E0hbb9P6X6gJxaF0I+nJdwOk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1743754340;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JdWFCM6wgiAszOmmUuM8vJDI4iobRdaUPvcZb1qFO6s=;
	b=M+6OzX/9fGJdOneUh7kbYv+jaIT0Lly0XMHpexdJkesXNRFCAcXpD22CJYjVahR7VQt2vM
	Bpyq4gHmtqvRCMAg==
Date: Fri, 4 Apr 2025 10:12:18 +0200
From: Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jonathan McDowell <noodles@earth.li>
Subject: Re: [PATCH] tpm: tis: Increase the default for timeout B
Message-ID: <Z--UYjUAYehDqOla@kitsune.suse.cz>
References: <Z-6Gau3aCB7B3pB9@earth.li>
 <20250403182519.8412-1-msuchanek@suse.de>
 <Z-7YHkb_2Dpz7GpV@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z-7YHkb_2Dpz7GpV@kernel.org>
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
	FREEMAIL_CC(0.00)[gmx.de,ziepe.ca,vger.kernel.org,earth.li];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,kitsune.suse.cz:mid,kitsune.suse.cz:helo]
X-Spam-Flag: NO
X-Spam-Level: 

On Thu, Apr 03, 2025 at 09:49:02PM +0300, Jarkko Sakkinen wrote:
> On Thu, Apr 03, 2025 at 08:25:05PM +0200, Michal Suchanek wrote:
> > With some Infineon chips the timeouts in tpm_tis_send_data (both B and
> > C) can reach up to about 2250 ms.
> > 
> > Timeout C is retried since
> > commit de9e33df7762 ("tpm, tpm_tis: Workaround failed command reception on Infineon devices")
> > 
> > Timeout B still needs to be extended.
> > 
> > Link: https://lore.kernel.org/linux-integrity/Z5pI07m0Muapyu9w@kitsune.suse.cz/
> > Signed-off-by: Michal Suchanek <msuchanek@suse.de>
> > ---
> > V2: Only extend timeout B
> 
> git format-patch --v2 ;-)
> 
> NP, but use --v3 next time...

Where do you get git with such practical options?

It does not seem to be supported by the upstream version.

Thanks

Michal

> 
> > ---
> >  drivers/char/tpm/tpm_tis_core.h | 2 +-
> >  include/linux/tpm.h             | 2 +-
> >  2 files changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/char/tpm/tpm_tis_core.h b/drivers/char/tpm/tpm_tis_core.h
> > index 970d02c337c7..c272c25eb9d4 100644
> > --- a/drivers/char/tpm/tpm_tis_core.h
> > +++ b/drivers/char/tpm/tpm_tis_core.h
> > @@ -54,7 +54,7 @@ enum tis_int_flags {
> >  enum tis_defaults {
> >  	TIS_MEM_LEN = 0x5000,
> >  	TIS_SHORT_TIMEOUT = 750,	/* ms */
> > -	TIS_LONG_TIMEOUT = 2000,	/* 2 sec */
> > +	TIS_LONG_TIMEOUT = 4000,	/* 4 sec */
> 
> nit: secs (that said, don't care that much)
> 
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
> 
> Have you tested with:
> 
> https://web.git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git/commit/?id=de9e33df7762abbfc2a1568291f2c3a3154c6a9d
> 
> ?
> 
> BR, Jarkko

