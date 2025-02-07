Return-Path: <linux-integrity+bounces-4741-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D2FC5A2BFA7
	for <lists+linux-integrity@lfdr.de>; Fri,  7 Feb 2025 10:41:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5EDEF3A3CAB
	for <lists+linux-integrity@lfdr.de>; Fri,  7 Feb 2025 09:41:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF0B21DE4EA;
	Fri,  7 Feb 2025 09:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="zGrAwp/n";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="dz4iC7/d";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="zGrAwp/n";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="dz4iC7/d"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EA131DE4E3
	for <linux-integrity@vger.kernel.org>; Fri,  7 Feb 2025 09:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738921221; cv=none; b=MMFAMQK/PrKer1YYNBc6J36BNQl8apJg2xGH6m2BIZwZRmJ/PBQqDx+6KtAXPepw4d5qb3WdzuJPEJyBZeoJpDgC444gsFSvMoU6ob4GLtNSVVw8O0pzjZSXw/bwZE8ha3w3oneHCTT10bhzY/EQZ0CvTHBQZlDMy3kBwtNeA4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738921221; c=relaxed/simple;
	bh=Al5GJ3BssY4yqrZQ57NXSyCHLRK2RG5MHKr7m0MumrI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H5oO1PNQ87A4HTuKHu3RJ+V0SZPEiUQXeNZFFJt1B/EXOQayhsoIEi6k1/4lHsuFPl/fmfEMT5pPgh4h8t5u/ViMo2znxBVS7+50UKJG3rNYVN52JeD6NAs2b0U4rvmo+Ony5fpvD2/qrNp3gLZqiv29edWklf8P3KfHPG13zqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=zGrAwp/n; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=dz4iC7/d; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=zGrAwp/n; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=dz4iC7/d; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from kitsune.suse.cz (unknown [10.100.12.127])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B3E5521167;
	Fri,  7 Feb 2025 09:40:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1738921217; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ij6aa8t2urxJdsMrVjpg3VfLa0EzlwewVdDxbMiXy2I=;
	b=zGrAwp/nV49a8vtbsKp8+AQXaU1qyGXtD6q4m019zXxsITH+66gm5cFSDdVFFZ8CrvQeQG
	XA+9UVMNa55b85ON7Zry+oPak4HpVs3Zz0Nxnzs3+dUAjHtAWuRyJGFEUW5GbQCZyfsbDY
	UQHELugWeUdYJ53HkVQJjcrr6aMqjgs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1738921217;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ij6aa8t2urxJdsMrVjpg3VfLa0EzlwewVdDxbMiXy2I=;
	b=dz4iC7/d2SRanFQmtXZbRsITRscdDwufvpbk48CDxT7zcKAobHqW2phuwAe2cXcXpYPUsT
	HN8fvtkCufuDhHDg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1738921217; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ij6aa8t2urxJdsMrVjpg3VfLa0EzlwewVdDxbMiXy2I=;
	b=zGrAwp/nV49a8vtbsKp8+AQXaU1qyGXtD6q4m019zXxsITH+66gm5cFSDdVFFZ8CrvQeQG
	XA+9UVMNa55b85ON7Zry+oPak4HpVs3Zz0Nxnzs3+dUAjHtAWuRyJGFEUW5GbQCZyfsbDY
	UQHELugWeUdYJ53HkVQJjcrr6aMqjgs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1738921217;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ij6aa8t2urxJdsMrVjpg3VfLa0EzlwewVdDxbMiXy2I=;
	b=dz4iC7/d2SRanFQmtXZbRsITRscdDwufvpbk48CDxT7zcKAobHqW2phuwAe2cXcXpYPUsT
	HN8fvtkCufuDhHDg==
Date: Fri, 7 Feb 2025 10:40:16 +0100
From: Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To: Jonathan McDowell <noodles@earth.li>
Cc: Jarkko Sakkinen <jarkko@kernel.org>, linux-integrity@vger.kernel.org
Subject: Re: TPM operation times out (very rarely)
Message-ID: <Z6XVAEfLIVDuwSLn@kitsune.suse.cz>
References: <Z5yLYVBn6inIH8cG@kitsune.suse.cz>
 <D7G6P7W7AY65.257WPBC8I3HAF@kernel.org>
 <Z5zJ7R6vDU4h9iDk@kitsune.suse.cz>
 <D7GFCNGDK7S6.1X0KPPHF1TXBO@kernel.org>
 <Z50IKdYe42_n2B0b@kitsune.suse.cz>
 <D7GIBDO5KJMD.118CQO10LJ79Y@kernel.org>
 <Z6Nm7Y8TFF8YG56Z@kitsune.suse.cz>
 <Z6N10NQY75hpX0Ed@earth.li>
 <Z6UdFCdqCNZ8VGOL@kernel.org>
 <Z6XRuFnEXeQI_rEZ@earth.li>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z6XRuFnEXeQI_rEZ@earth.li>
X-Spam-Score: -4.30
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_ZERO(0.00)[0];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCPT_COUNT_THREE(0.00)[3]
X-Spam-Flag: NO
X-Spam-Level: 

On Fri, Feb 07, 2025 at 09:26:16AM +0000, Jonathan McDowell wrote:
> On Thu, Feb 06, 2025 at 10:35:32PM +0200, Jarkko Sakkinen wrote:
> > On Wed, Feb 05, 2025 at 02:29:36PM +0000, Jonathan McDowell wrote:
> > > Interesting. TPM2_CC_CONTEXT_LOAD (353) / TPM2_CC_FLUSH_CONTEXT (357) /
> > > TPM2_CC_CONTEXT_SAVE (354) I kinda expect to maybe take a bit longer,
> > > but TPM2_CC_GET_RANDOM (379) is a little surprising.
> > 
> > The whole arithmetic with timeout_a/b/c is mostly gibberish and could
> > be replaced with a single "max" constant without issues (just set it
> > large enough).
> > 
> > They could be all be replaced with let's say 3s timeout in a constant.
> 
> This appears to have come up before:
> 
> https://lore.kernel.org/linux-integrity/358e89ed2b766d51b5f57abf31ab7a925ac63379.1552348123.git.calvinowens@fb.com/
> 
> That patch was deemed overly complex and it was suggested to split it
> up; I can't find any indication that was ever done which I guess is why
> the discussion died off.

Also it comes before TPM_LONG_LONG, it sounds like that would still be
special.

> 
> > > > Failure is observed with another chip type as well:
> > > > 
> > > > localhost kernel: tpm_tis MSFT0101:00: 2.0 TPM (device-id 0x1B, rev-id
> > > > 22)
> > > > 
> > > > TPM Device
> > > >         Vendor ID: IFX
> > > >         Specification Version: 2.0
> > > >         Firmware Revision: 7.83
> > > >         Description: TPM 2.0, ManufacturerID: IFX , Firmware Version: 7.83.3358.0
> > > >         Characteristics:
> > > >                 Family configurable via firmware update
> > > >                 Family configurable via OEM proprietary mechanism
> > > >         OEM-specific Information: 0x00000000
> > > 
> > > That looks like an SLB9670, not running the latest firmware (7.85). I
> > > think that might have the errata I've been trying to work around; my
> > > current patch in testing (with logging to see how effective it is):
> > > 
> > > commit d8c680ec34e7f42f731e7d64605a670fb7b3b4d1
> > > Author: Jonathan McDowell <noodles@meta.com>
> > > Date:   Mon Aug 19 09:22:46 2024 -0700
> > > 
> > >     tpm: Workaround failed command reception on Infineon devices
> > >     
> > >     Some Infineon devices have a issue where the status register will get
> > >     stuck with a quick REQUEST_USE / COMMAND_READY sequence. The work around
> > >     is to retry the command submission. Add appropriate logic to do this in
> > >     the send path.
> > >     
> > > diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
> > > index fdef214b9f6b..561d6801e299 100644
> > > --- a/drivers/char/tpm/tpm_tis_core.c
> > > +++ b/drivers/char/tpm/tpm_tis_core.c
> > > @@ -464,7 +464,12 @@ static int tpm_tis_send_data(struct tpm_chip *chip, const u8 *buf, size_t len)
> > >  
> > >  		if (wait_for_tpm_stat(chip, TPM_STS_VALID, chip->timeout_c,
> > >  					&priv->int_queue, false) < 0) {
> > > -			rc = -ETIME;
> > > +			if (test_bit(TPM_TIS_STATUS_WORKAROUND, &priv->flags)) {
> > > +				dev_err(&chip->dev, "Timed out waiting for status valid in send, retrying\n");
> > > +				rc = -EAGAIN;
> > 
> > 
> > I'm not sure why wait_for_tpm_stat() return value is ignored but it
> > should not be like that. E.g. it can return -ERESTARTSYS. Probably
> > would be better to check all the call sites for it that they do
> > same thing.
> > 
> > I.e. rc = wait_for_tpm_stat(...);
> > 
> > /* ... */
> 
> So just to clarify, this more recent patch is working around a situation
> where the status register gets stuck and needs a complete retry of the
> command send - it's an Infineon errata, not something that would be
> fixed with a longer timeout.
> 
> We see what looks like Michal's issue with timeouts as well, I just
> haven't made the step of instrumenting it all the way he has.

And I haven't seen the issue that needs re-sending the command so far.

Maybe it happens even less frequently than the excessive processing
time.

Fully restarting the syscall would fix both issues but manual restart of
the userspace task reportedly did not work so I have my doubts that
this method with returning from the syscall would be effective.

Thanks

Michal

