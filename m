Return-Path: <linux-integrity+bounces-5470-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 85044A732CA
	for <lists+linux-integrity@lfdr.de>; Thu, 27 Mar 2025 13:58:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12BF53ACCFF
	for <lists+linux-integrity@lfdr.de>; Thu, 27 Mar 2025 12:57:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED58E2101BD;
	Thu, 27 Mar 2025 12:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="RTwDqNfL";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="/6ivKerz";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="b9R5UEEn";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="53XmRAR7"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F09CF14F9F4
	for <linux-integrity@vger.kernel.org>; Thu, 27 Mar 2025 12:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743080273; cv=none; b=LAyqDcBJHqQYWztlMk9Z3cXP+TXU2tIfFLmmcpd59NiSKDGOP+9NC9D7tvE/co08+plwHeyeckvBjDkikL8InIsgr4jno7kiV6phSZ1tg6EuL1VaFCM2vIdJn9Z2GGEJTcX9426k2/DFgD1C2qAa3+AQn7ZVRXrkK3Mk5xvM/hA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743080273; c=relaxed/simple;
	bh=hybkWRZXLFZfzoQQLGtF8TSD3ipp3xROXoClXD4fG4I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZAKDEyUXwCApcQ4ryo9h3XLgr7EMYo+rWxx42ZpVGNWTBJL1ouRlpzjUjq879h6aDp2/bTmTG08MKySA4CoVU716z4YYuW3+xPIvYwlyqRSlBn6jWIqwjAVOdXq51+f3EUbnmY5j3d8lS7pJXynBR6DpFBw9NonDNVMFzWv2InE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=RTwDqNfL; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=/6ivKerz; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=b9R5UEEn; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=53XmRAR7; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from kitsune.suse.cz (unknown [10.100.12.127])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D6A8B2116C;
	Thu, 27 Mar 2025 12:57:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1743080270; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3U8z99LWWqv5z6n0QmJgJpdMz3H6E0bET54Z68ZcmnU=;
	b=RTwDqNfLPyiX4g60eGHrfRzBZ8e0kB7vDqM7x6wnIS3UoCP4YX6fL6ZNt87Jvf2ZKD+HpZ
	4/7wxvia0PCtmzfFF+HR7MgWUBaLXxCvydJNDO7V7XF/zd+oajCLfmQhu39litq10zpU4i
	Sb4hisfb0cTh4yZU3wUzBUV3cw+mJmA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1743080270;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3U8z99LWWqv5z6n0QmJgJpdMz3H6E0bET54Z68ZcmnU=;
	b=/6ivKerz+AXNejPn8lRn64P46/l9bJeNviaqcGBYrG3/3zEZwH6EO7/qauio69b4I4bccA
	u2RTjkwS3ePk72DQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1743080269; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3U8z99LWWqv5z6n0QmJgJpdMz3H6E0bET54Z68ZcmnU=;
	b=b9R5UEEn9JImzY7jpdXHKlpZjmpTUkQ65HNPaV01KshGMV/tsjzKBUuAUQilpXh86PkLcL
	oUdL9MKTHW/OD/0YqM9IevYdXsw9fz/4D51y9cm/Z2lmUep6pccmI6p0LwQc2Wh61PkjxJ
	tShpOUqJEB4JgtcD+sLm13B7nVae28k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1743080269;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3U8z99LWWqv5z6n0QmJgJpdMz3H6E0bET54Z68ZcmnU=;
	b=53XmRAR7sWLUdaevsUDHDal0PMjvQcmQMbFvswGaXzacWW4svrZ8emxN3i9x5OTFS+dTgp
	4pK2fL+bZy3vsfBg==
Date: Thu, 27 Mar 2025 13:57:48 +0100
From: Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To: Jonathan McDowell <noodles@earth.li>
Cc: Jarkko Sakkinen <jarkko@kernel.org>, linux-integrity@vger.kernel.org
Subject: Re: TPM operation times out (very rarely)
Message-ID: <Z-VLTKkB_-PoNAly@kitsune.suse.cz>
References: <Z5pRKcZKc3FUzP8Q@earth.li>
 <D7FSS837QLNR.5XOU66J6FBTU@kernel.org>
 <Z5yLYVBn6inIH8cG@kitsune.suse.cz>
 <D7G6P7W7AY65.257WPBC8I3HAF@kernel.org>
 <Z5zJ7R6vDU4h9iDk@kitsune.suse.cz>
 <D7GFCNGDK7S6.1X0KPPHF1TXBO@kernel.org>
 <Z50IKdYe42_n2B0b@kitsune.suse.cz>
 <D7GIBDO5KJMD.118CQO10LJ79Y@kernel.org>
 <Z6Nm7Y8TFF8YG56Z@kitsune.suse.cz>
 <Z6N10NQY75hpX0Ed@earth.li>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z6N10NQY75hpX0Ed@earth.li>
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
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
X-Spam-Score: -4.30
X-Spam-Flag: NO

Hello,

On Wed, Feb 05, 2025 at 02:29:36PM +0000, Jonathan McDowell wrote:
> On Wed, Feb 05, 2025 at 02:26:05PM +0100, Michal Suchánek wrote:
> > On Fri, Jan 31, 2025 at 09:31:30PM +0200, Jarkko Sakkinen wrote:
> > > On Fri Jan 31, 2025 at 7:28 PM EET, Michal Suchánek wrote:
> > > > On Fri, Jan 31, 2025 at 07:12:06PM +0200, Jarkko Sakkinen wrote:
> > > > > On Fri Jan 31, 2025 at 3:02 PM EET, Michal Suchánek wrote:
> > > > > > It looks like the timeout_b is used exclusively as the ready timeout *),
> > > > > > with various sources of the value depending on chip type.
> > > > > >
> > > > > > Then increasing it should not cause any problem other than the kernel
> > > > > > waiting longer when the TPM chip is really stuck.
> > > > > >
> > > > > > * There is one instance of use of timeout_b for TPM_STS_VALID in
> > > > > > st33zp24_pm_resume.
> > > > > 
> > > > > Possible for you to give a shot for patch and try it out for a while?
> > > > > I'm fine with 2x, or even 4x in this case.
> > > >
> > > > I will see what I can do. It will definitely take a while.
> > > >
> > > > How would you like to multiply it?
> > > >
> > > > At the sime the timeout_b is assigned, or at the time it's used?
> > > >
> > > > Any specific patch that you have in mind?
> > > 
> > > I'll think about this a bit and send a patch with RFC tag. Might take
> > > to late next week.
> > 
> > The ready timeout is not the only one exceeded:
> > 
> > > Jan 29 19:01:55 localhost kernel: tpm tpm0: tpm_tis_send_data: 357: ready: Timed out (2232 of 2000 ms)
> > > Jan 29 19:01:55 localhost kernel: tpm tpm0: tpm_tis_send_data: 357: ready: Took (2232 of 2000 ms)
> > > Jan 30 09:08:20 localhost kernel: tpm tpm0: tpm_tis_send_data: 353: ready: Timed out (2228 of 2000 ms)
> > > Jan 30 09:08:20 localhost kernel: tpm tpm0: tpm_tis_send_data: 353: ready: Took (2228 of 2000 ms)
> > > Jan 30 14:26:16 localhost kernel: tpm tpm0: tpm_tis_send_data: 353: stat: Timed out (540 of 200 ms)
> > > Jan 30 14:26:16 localhost kernel: tpm tpm0: tpm_tis_send_data: 353: stat: Took (540 of 200 ms)
> > > Jan 30 23:25:13 localhost kernel: tpm tpm0: tpm_tis_send_data: 354: stat: Timed out (2224 of 200 ms)
> > > Jan 30 23:25:13 localhost kernel: tpm tpm0: tpm_tis_send_data: 354: stat: Took (2224 of 200 ms)
> > > Feb 01 05:25:33 localhost kernel: tpm tpm0: tpm_tis_send_data: 357: ready: Timed out (2228 of 2000 ms)
> > > Feb 01 05:25:33 localhost kernel: tpm tpm0: tpm_tis_send_data: 357: ready: Took (2228 of 2000 ms)
> > > Feb 01 07:02:53 localhost kernel: tpm tpm0: tpm_tis_send_data: 353: stat: Timed out (556 of 200 ms)
> > > Feb 01 07:02:53 localhost kernel: tpm tpm0: tpm_tis_send_data: 353: stat: Took (556 of 200 ms)
> > > Feb 01 09:26:22 localhost kernel: tpm tpm0: tpm_tis_send_data: 353: stat: Timed out (540 of 200 ms)
> > > Feb 01 09:26:22 localhost kernel: tpm tpm0: tpm_tis_send_data: 353: stat: Took (540 of 200 ms)
> > > Feb 02 02:45:35 localhost kernel: tpm tpm0: tpm_tis_send_data: 379: stat: Timed out (272 of 200 ms)
> > > Feb 02 02:45:35 localhost kernel: tpm tpm0: tpm_tis_send_data: 379: stat: Took (272 of 200 ms)
> > > Feb 02 03:40:04 localhost kernel: tpm tpm0: tpm_tis_send_data: 353: stat: Timed out (536 of 200 ms)
> > > Feb 02 03:40:04 localhost kernel: tpm tpm0: tpm_tis_send_data: 353: stat: Took (536 of 200 ms)
> > > Feb 02 04:09:50 localhost kernel: tpm tpm0: tpm_tis_send_data: 357: ready: Timed out (2236 of 2000 ms)
> > > Feb 02 04:09:50 localhost kernel: tpm tpm0: tpm_tis_send_data: 357: ready: Took (2236 of 2000 ms)
> > > Feb 02 09:57:41 localhost kernel: tpm tpm0: tpm_tis_send_data: 353: stat: Timed out (540 of 200 ms)
> > > Feb 02 09:57:41 localhost kernel: tpm tpm0: tpm_tis_send_data: 353: stat: Took (540 of 200 ms)
> > > Feb 02 10:59:00 localhost kernel: tpm tpm0: tpm_tis_send_data: 353: stat: Timed out (536 of 200 ms)
> > > Feb 02 10:59:00 localhost kernel: tpm tpm0: tpm_tis_send_data: 353: stat: Took (536 of 200 ms)
> > > Feb 03 03:58:09 localhost kernel: tpm tpm0: tpm_tis_send_data: 354: stat: Timed out (540 of 200 ms)
> > > Feb 03 03:58:09 localhost kernel: tpm tpm0: tpm_tis_send_data: 354: stat: Took (540 of 200 ms)

Another new failure:

Mar 25 23:06:20 localhost kernel: tpm tpm0: tpm_tis_send_data: 305: valid: Timed out (212 of 200 ms)
Mar 25 23:06:20 localhost kernel: tpm tpm0: tpm_tis_send_data: 305: valid: Took (212 of 200 ms)

which is CREATE PRIMARY, and happens on

 tpm_tis MSFT0101:00: 2.0 TPM (device-id 0x1A, rev-id 16)

TPM Device
        Vendor ID: 
        Specification Version: 2.0
        Firmware Revision: 5.63
        Description: INFINEON
        Characteristics:
                Family configurable via platform software support
        OEM-specific Information: 0x00000000

With this we have ready timoeout which is 2000ms but the TPM takes
up to 2236ms, stat timeout which is 200ms and the TPM takes up to
2224ms, and valid timeout which is 200 ms and the TPM takes up to 212ms.

Given that I think it makes sense to replace all these timeouts with one
timeout that is something like 4 or 5s.

This does not address the other problem that when the rimeout triggers
on something like LOAD CONTEXT then the kernel and the TPM don't agree
on what the state of the context is.

Thanks

Michal

