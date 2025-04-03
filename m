Return-Path: <linux-integrity+bounces-5577-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EE447A7A235
	for <lists+linux-integrity@lfdr.de>; Thu,  3 Apr 2025 13:56:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2491173A31
	for <lists+linux-integrity@lfdr.de>; Thu,  3 Apr 2025 11:56:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ED7624BD1F;
	Thu,  3 Apr 2025 11:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="uyGdJNwD";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="OvTY1j+b";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="uyGdJNwD";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="OvTY1j+b"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E91224A042
	for <linux-integrity@vger.kernel.org>; Thu,  3 Apr 2025 11:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743681402; cv=none; b=sHy8kd3Ky/7SsQkYkyqhaEkz8n7tA61JtPZokUX9l/IxLXmB1ERuUd0GQxepQqoiugi79NVwy73NSJBEYLh+zJ82KXrgrAq0JeluBSm663CVDNGaAzkTklnyi34CePAyaszPYQJJufPXYAHtSBrR0zFVEtxP85Je8zcn04HBpUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743681402; c=relaxed/simple;
	bh=uE6TUg9SSfwfWTxS9UVB8fh1ZwpK7mmeuo86i1UfxV0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UoiNXrxNK/BV4YGAMDlfTpauG3IEf13FQGmHlMBYykqM90extJ0SBDLcatFSCMXE/atQq8Pb+/e2yWqOo6JrfWYBOVa4ZhNjT634DB6N1xRlA/UOgDxqOgX96r99HaJr+655ZwJgDgKoMXvN+Et6EFQsMo2jpSaRgjULt3HpmTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=uyGdJNwD; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=OvTY1j+b; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=uyGdJNwD; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=OvTY1j+b; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from kitsune.suse.cz (unknown [10.100.12.127])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 92C81210F4;
	Thu,  3 Apr 2025 11:56:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1743681398; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AyRZRinSYopgeFvRSMWDxmUB4Jb3pKVY5jc2GB5OZjc=;
	b=uyGdJNwDqvl+8Xw3NRx25OJ63BcJCvzCpk02rxCWndo7OOm5qtNhkA+Vm6qd1kqv+1ZKSM
	VFAz2GjvAK+Qkibw+PGlboQwTw0/QgELIW/nGa6JRAA7X11vYUmpW/3usXn4NPhkX0Dg2q
	R5bP/DRmLGqDwqyjk6XcRoSq/okv/wE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1743681398;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AyRZRinSYopgeFvRSMWDxmUB4Jb3pKVY5jc2GB5OZjc=;
	b=OvTY1j+b8mGbw+I2NDsWy3DvdwdJtkiYRzYwXucIifCTyx9obAJ0efb/tgtFdAhPc4Qn63
	k/oAUSAlUPVb5eAQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1743681398; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AyRZRinSYopgeFvRSMWDxmUB4Jb3pKVY5jc2GB5OZjc=;
	b=uyGdJNwDqvl+8Xw3NRx25OJ63BcJCvzCpk02rxCWndo7OOm5qtNhkA+Vm6qd1kqv+1ZKSM
	VFAz2GjvAK+Qkibw+PGlboQwTw0/QgELIW/nGa6JRAA7X11vYUmpW/3usXn4NPhkX0Dg2q
	R5bP/DRmLGqDwqyjk6XcRoSq/okv/wE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1743681398;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AyRZRinSYopgeFvRSMWDxmUB4Jb3pKVY5jc2GB5OZjc=;
	b=OvTY1j+b8mGbw+I2NDsWy3DvdwdJtkiYRzYwXucIifCTyx9obAJ0efb/tgtFdAhPc4Qn63
	k/oAUSAlUPVb5eAQ==
Date: Thu, 3 Apr 2025 13:56:37 +0200
From: Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To: Jonathan McDowell <noodles@earth.li>
Cc: Peter Huewe <peterhuewe@gmx.de>, Jarkko Sakkinen <jarkko@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>, linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tpm: tis: Increase the default for timeouts B and C
Message-ID: <Z-53dR25MT8OUDhW@kitsune.suse.cz>
References: <20250402172134.7751-1-msuchanek@suse.de>
 <Z-13xOebA3LvQQ-8@earth.li>
 <Z-2ZC2Ew2EtNAW6-@kitsune.suse.cz>
 <Z-5qVBjeRfEdRAP5@earth.li>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z-5qVBjeRfEdRAP5@earth.li>
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_ZERO(0.00)[0];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmx.de];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FREEMAIL_CC(0.00)[gmx.de,kernel.org,ziepe.ca,vger.kernel.org];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6]
X-Spam-Score: -4.30
X-Spam-Flag: NO

On Thu, Apr 03, 2025 at 12:00:36PM +0100, Jonathan McDowell wrote:
> On Wed, Apr 02, 2025 at 10:07:39PM +0200, Michal Suchánek wrote:
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
> > 
> > Yes, that's problematic. Is it possible to detect the errata by anything
> > other than waiting for the timeout to expire?
> 
> Not that I'm aware of, nor have seen in my experimentation. It's a "stuck"
> status, so the timeout is how it's detected.
> 
> OOI, have you tried back porting the fixes that are in mainline for 6.15 to
> your frankenkernel? I _think_ the errata fix might end up resolving at least
> the timeout for valid for you, as a side effect? We're currently rolling
> them out across our fleet, but I don't have enough runtime yet to be sure
> they've sorted all the timeout instances we see.

When was that merged?

The change I see is that sometimes EAGAIN is returned instead of ETIME
but based on the previous discussion this is unlikely to help.

Thanks

Michal

> 
> J.
> 
> -- 
> /-\                             | He's weird? It's ok, I'm fluent in
> |@/  Debian GNU/Linux Developer |               weird.
> \-                              |

