Return-Path: <linux-integrity+bounces-5599-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DEFCA7B869
	for <lists+linux-integrity@lfdr.de>; Fri,  4 Apr 2025 09:51:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F30191887722
	for <lists+linux-integrity@lfdr.de>; Fri,  4 Apr 2025 07:51:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB4AB18DB17;
	Fri,  4 Apr 2025 07:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="wGYrtM7R";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="vUOoYzkg";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="O2D5fSKY";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="IGJ15hO3"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 190A018CC10
	for <linux-integrity@vger.kernel.org>; Fri,  4 Apr 2025 07:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743753094; cv=none; b=YH0adHbs80Xnq33xy0uhFdFy0ViTOwqjJOkue5sP4HnAc0Ahs1y4oiRBU8sVXSeUKh3mG0yQo6vTEmpCFX1RF8APyVrPclHyd9n7seJCHRu+8Nv1+TZq4DDb+9lDErz9OmIt9b18mi9LuGRFL0CF4ix/7LkvaOp0QDOzqMZ3atc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743753094; c=relaxed/simple;
	bh=Zh4uhqcuduTxgcL9dONVJoXZiDqjl51elcbsEGaIt6s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k9p5P60ok6lv5c4sCM6oZmiUNmRTFjm/QdZR28eoteoGtb7gm0QZyEuj4t4aiZpZeV6ZksOm+APLfrNW4dJ5gFYFxMTO8s4fyALw5sMWu6i3xnohPYeQ8fCEkzViGs5wO4EB2gMRfp/gR+3G5kF25uFx0cP1GPsbHlBffu3UsCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=wGYrtM7R; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=vUOoYzkg; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=O2D5fSKY; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=IGJ15hO3; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from kitsune.suse.cz (unknown [10.100.12.127])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 259B31F385;
	Fri,  4 Apr 2025 07:51:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1743753091; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7XiP3vnviCbwvK+UOblxl6RNZWICrmoZcIuevnCyY3s=;
	b=wGYrtM7RtH84UBtXkTv0zZI2/QDYOx7Ry+7g5/eaJYSQkDsjoHbVMQtYSiWnRFXJgSCk6M
	Myp80cRS9yZ55HSpyP4h+ebsD8AbpoKitPPIqnXWuXIvbsboKoZR198LABJWUuAWf6mLEa
	mJQVbf9C3/eTGdMT78ILZAaWWH8DV6M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1743753091;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7XiP3vnviCbwvK+UOblxl6RNZWICrmoZcIuevnCyY3s=;
	b=vUOoYzkg1DFq8InRPXqvmQ70jq0DibOS21FoOSqFyTkwDCS/ozo0g00wZ0FLYZvePmucDw
	BVEEAiN6iUQkT5Dw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1743753090; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7XiP3vnviCbwvK+UOblxl6RNZWICrmoZcIuevnCyY3s=;
	b=O2D5fSKYh5cht7wK4E86l49wRBbOwPvpPGc1qdx+SBFrtsciOF0bl1eBkiJcPGxgTYqe6g
	W67Kc5a/7HOtmXdEGdBnyYTXcD8WIAYIOUzhGqZiUqsnRxtZLSkY2KJGlnZC0Wv+ZUj4sC
	YXrHHXEveMyw3dfvl/i4CS12NTWI3aM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1743753090;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7XiP3vnviCbwvK+UOblxl6RNZWICrmoZcIuevnCyY3s=;
	b=IGJ15hO3XyYvA3bGrUO0IpEzb5gAnF/fmgQTdFUD4IpId1EUFHrDv33q1XsdBUkEG2bNSR
	FId9Qp9weIIiwmDw==
Date: Fri, 4 Apr 2025 09:51:29 +0200
From: Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To: Jonathan McDowell <noodles@earth.li>
Cc: Jarkko Sakkinen <jarkko@kernel.org>, Peter Huewe <peterhuewe@gmx.de>,
	Jason Gunthorpe <jgg@ziepe.ca>, linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tpm: tis: Increase the default for timeouts B and C
Message-ID: <Z--PgeuYjRx6zXmG@kitsune.suse.cz>
References: <20250402172134.7751-1-msuchanek@suse.de>
 <Z-13xOebA3LvQQ-8@earth.li>
 <Z-7XQYP7_tXYR2Ik@kernel.org>
 <Z-7y5x3u6wVGFjj-@earth.li>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z-7y5x3u6wVGFjj-@earth.li>
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
	FREEMAIL_CC(0.00)[kernel.org,gmx.de,ziepe.ca,vger.kernel.org];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[kitsune.suse.cz:mid,kitsune.suse.cz:helo]
X-Spam-Flag: NO
X-Spam-Level: 

On Thu, Apr 03, 2025 at 09:43:19PM +0100, Jonathan McDowell wrote:
> On Thu, Apr 03, 2025 at 09:45:21PM +0300, Jarkko Sakkinen wrote:
> > On Wed, Apr 02, 2025 at 06:45:40PM +0100, Jonathan McDowell wrote:
> > > On Wed, Apr 02, 2025 at 07:21:30PM +0200, Michal Suchanek wrote:
> > > > With some Infineon chips the timeouts in tpm_tis_send_data (both B and
> > > > C) can reach up to about 2250 ms.
> > > >
> > > > Extend the timeout duration to accommodate this.
> > > 
> > > The problem here is the bump of timeout_c is going to interact poorly with
> > > the Infineon errata workaround, as now we'll wait 4s instead of 200ms to
> > > detect the stuck status change.
> > > 
> > > (Also shouldn't timeout_c already end up as 750ms, as it's
> > > max(TIS_SHORT_TIMEOUT, TPM2_TIMEOUT_C), and TIS_SHORT_TIMEOUT is 750 vs 200
> > > for TPM2_TIMEOUT_C? That doesn't seem to be borne out by your logs, nor my
> > > results.)
> > 
> > Just noticed that the commit did not end up having fixes etc. tags:
> > 
> > https://web.git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git/commit/?id=de9e33df7762abbfc2a1568291f2c3a3154c6a9d
> > 
> > Should we forward to stable?
> 
> It's a TPM bug rather than a kernel issue, so I don't think there's a valid
> Fixes: for it, but it's certainly stable material in my mind.

In the more general sense of Fixes: indicating where the fix is
applicable it would be any kernel that supports TPM2.

Thanks

Michal

