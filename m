Return-Path: <linux-integrity+bounces-4728-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C8A3CA28B9E
	for <lists+linux-integrity@lfdr.de>; Wed,  5 Feb 2025 14:26:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 961F01886522
	for <lists+linux-integrity@lfdr.de>; Wed,  5 Feb 2025 13:26:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B44E370831;
	Wed,  5 Feb 2025 13:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="aPbxCZOX";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="16pfRKiX";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="aPbxCZOX";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="16pfRKiX"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3669A32
	for <linux-integrity@vger.kernel.org>; Wed,  5 Feb 2025 13:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738761970; cv=none; b=tGIDZ6MMr9iu2Hir8feQ/dKhll9fsIRLj/p0DXqUh944eSY2HOHU1FbOg8Zl0c59GoyKAGUNrXHY40kvFRJLrwy3MqN+DASyxMeiuatdKCKte8SLTkQJAWC2u4U6rOvCe2445ermLImyKfB1UIdNOjhlA9vS+00cKXnL8krz+Mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738761970; c=relaxed/simple;
	bh=EFPN7rRoPrLm/BiyxpiC8cuVLZRDjNI8fzKohurBH3E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DGk399Km0WpP0bAo+6SofEtBTyk0Os54veXWbNMw2EJbO9GTmvXjiFcyDmGEoZpvCni78du0o2sHN5sbgkB22WQ3TxbijJQ9uegRp52R0W/LzB2ZKaTS/8ixiqxgB9Pk11MKQufm5zbiU1go5S5MXwDCVK0Up7cHOL95kQuOUHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=aPbxCZOX; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=16pfRKiX; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=aPbxCZOX; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=16pfRKiX; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from kitsune.suse.cz (unknown [10.100.12.127])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 108CA21228;
	Wed,  5 Feb 2025 13:26:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1738761967; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F1r/FQAP6Pe8ht4PsC5jntysDwhAMNIDPYkPMgRuu6k=;
	b=aPbxCZOXdGcbbf3DooRR1Fpc/1+WQWue/0NiIW4dTZJuLyJqQdrLTjx47p1uWUNtmfcJcW
	We+cEjL3yPZf0uQxwtCTuxfZr7jmrMv0HjKjth4w0b3uQz0wANcTftKkokAgQXgpoFFflR
	PA57ALJqml6sT4ro9Mo7x5YHnVAmfSI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1738761967;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F1r/FQAP6Pe8ht4PsC5jntysDwhAMNIDPYkPMgRuu6k=;
	b=16pfRKiX4ZOtORpMi2DI4BUpW0vCyLA4yW8rkgwSXTZ4CIs0YYh3HOlQEQqlhkLF2Gknxh
	AmYqx7SX+e1xmmBg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1738761967; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F1r/FQAP6Pe8ht4PsC5jntysDwhAMNIDPYkPMgRuu6k=;
	b=aPbxCZOXdGcbbf3DooRR1Fpc/1+WQWue/0NiIW4dTZJuLyJqQdrLTjx47p1uWUNtmfcJcW
	We+cEjL3yPZf0uQxwtCTuxfZr7jmrMv0HjKjth4w0b3uQz0wANcTftKkokAgQXgpoFFflR
	PA57ALJqml6sT4ro9Mo7x5YHnVAmfSI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1738761967;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F1r/FQAP6Pe8ht4PsC5jntysDwhAMNIDPYkPMgRuu6k=;
	b=16pfRKiX4ZOtORpMi2DI4BUpW0vCyLA4yW8rkgwSXTZ4CIs0YYh3HOlQEQqlhkLF2Gknxh
	AmYqx7SX+e1xmmBg==
Date: Wed, 5 Feb 2025 14:26:05 +0100
From: Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Jonathan McDowell <noodles@earth.li>, linux-integrity@vger.kernel.org
Subject: Re: TPM operation times out (very rarely)
Message-ID: <Z6Nm7Y8TFF8YG56Z@kitsune.suse.cz>
References: <Z5pI07m0Muapyu9w@kitsune.suse.cz>
 <Z5pRKcZKc3FUzP8Q@earth.li>
 <D7FSS837QLNR.5XOU66J6FBTU@kernel.org>
 <Z5yLYVBn6inIH8cG@kitsune.suse.cz>
 <D7G6P7W7AY65.257WPBC8I3HAF@kernel.org>
 <Z5zJ7R6vDU4h9iDk@kitsune.suse.cz>
 <D7GFCNGDK7S6.1X0KPPHF1TXBO@kernel.org>
 <Z50IKdYe42_n2B0b@kitsune.suse.cz>
 <D7GIBDO5KJMD.118CQO10LJ79Y@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <D7GIBDO5KJMD.118CQO10LJ79Y@kernel.org>
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.996];
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

On Fri, Jan 31, 2025 at 09:31:30PM +0200, Jarkko Sakkinen wrote:
> On Fri Jan 31, 2025 at 7:28 PM EET, Michal Suchánek wrote:
> > On Fri, Jan 31, 2025 at 07:12:06PM +0200, Jarkko Sakkinen wrote:
> > > On Fri Jan 31, 2025 at 3:02 PM EET, Michal Suchánek wrote:
> > > > It looks like the timeout_b is used exclusively as the ready timeout *),
> > > > with various sources of the value depending on chip type.
> > > >
> > > > Then increasing it should not cause any problem other than the kernel
> > > > waiting longer when the TPM chip is really stuck.
> > > >
> > > > * There is one instance of use of timeout_b for TPM_STS_VALID in
> > > > st33zp24_pm_resume.
> > > 
> > > Possible for you to give a shot for patch and try it out for a while?
> > > I'm fine with 2x, or even 4x in this case.
> >
> > I will see what I can do. It will definitely take a while.
> >
> > How would you like to multiply it?
> >
> > At the sime the timeout_b is assigned, or at the time it's used?
> >
> > Any specific patch that you have in mind?
> 
> I'll think about this a bit and send a patch with RFC tag. Might take
> to late next week.

The ready timeout is not the only one exceeded:

> Jan 29 19:01:55 localhost kernel: tpm tpm0: tpm_tis_send_data: 357: ready: Timed out (2232 of 2000 ms)
> Jan 29 19:01:55 localhost kernel: tpm tpm0: tpm_tis_send_data: 357: ready: Took (2232 of 2000 ms)
> Jan 30 09:08:20 localhost kernel: tpm tpm0: tpm_tis_send_data: 353: ready: Timed out (2228 of 2000 ms)
> Jan 30 09:08:20 localhost kernel: tpm tpm0: tpm_tis_send_data: 353: ready: Took (2228 of 2000 ms)
> Jan 30 14:26:16 localhost kernel: tpm tpm0: tpm_tis_send_data: 353: stat: Timed out (540 of 200 ms)
> Jan 30 14:26:16 localhost kernel: tpm tpm0: tpm_tis_send_data: 353: stat: Took (540 of 200 ms)
> Jan 30 23:25:13 localhost kernel: tpm tpm0: tpm_tis_send_data: 354: stat: Timed out (2224 of 200 ms)
> Jan 30 23:25:13 localhost kernel: tpm tpm0: tpm_tis_send_data: 354: stat: Took (2224 of 200 ms)
> Feb 01 05:25:33 localhost kernel: tpm tpm0: tpm_tis_send_data: 357: ready: Timed out (2228 of 2000 ms)
> Feb 01 05:25:33 localhost kernel: tpm tpm0: tpm_tis_send_data: 357: ready: Took (2228 of 2000 ms)
> Feb 01 07:02:53 localhost kernel: tpm tpm0: tpm_tis_send_data: 353: stat: Timed out (556 of 200 ms)
> Feb 01 07:02:53 localhost kernel: tpm tpm0: tpm_tis_send_data: 353: stat: Took (556 of 200 ms)
> Feb 01 09:26:22 localhost kernel: tpm tpm0: tpm_tis_send_data: 353: stat: Timed out (540 of 200 ms)
> Feb 01 09:26:22 localhost kernel: tpm tpm0: tpm_tis_send_data: 353: stat: Took (540 of 200 ms)
> Feb 02 02:45:35 localhost kernel: tpm tpm0: tpm_tis_send_data: 379: stat: Timed out (272 of 200 ms)
> Feb 02 02:45:35 localhost kernel: tpm tpm0: tpm_tis_send_data: 379: stat: Took (272 of 200 ms)
> Feb 02 03:40:04 localhost kernel: tpm tpm0: tpm_tis_send_data: 353: stat: Timed out (536 of 200 ms)
> Feb 02 03:40:04 localhost kernel: tpm tpm0: tpm_tis_send_data: 353: stat: Took (536 of 200 ms)
> Feb 02 04:09:50 localhost kernel: tpm tpm0: tpm_tis_send_data: 357: ready: Timed out (2236 of 2000 ms)
> Feb 02 04:09:50 localhost kernel: tpm tpm0: tpm_tis_send_data: 357: ready: Took (2236 of 2000 ms)
> Feb 02 09:57:41 localhost kernel: tpm tpm0: tpm_tis_send_data: 353: stat: Timed out (540 of 200 ms)
> Feb 02 09:57:41 localhost kernel: tpm tpm0: tpm_tis_send_data: 353: stat: Took (540 of 200 ms)
> Feb 02 10:59:00 localhost kernel: tpm tpm0: tpm_tis_send_data: 353: stat: Timed out (536 of 200 ms)
> Feb 02 10:59:00 localhost kernel: tpm tpm0: tpm_tis_send_data: 353: stat: Took (536 of 200 ms)
> Feb 03 03:58:09 localhost kernel: tpm tpm0: tpm_tis_send_data: 354: stat: Timed out (540 of 200 ms)
> Feb 03 03:58:09 localhost kernel: tpm tpm0: tpm_tis_send_data: 354: stat: Took (540 of 200 ms)

While the ready timeout is quite consistently exceeded by around 230ms
so far the stat timeout a few lines lower is less consistent.

Failure is observed with another chip type as well:

localhost kernel: tpm_tis MSFT0101:00: 2.0 TPM (device-id 0x1B, rev-id
22)

TPM Device
        Vendor ID: IFX
        Specification Version: 2.0
        Firmware Revision: 7.83
        Description: TPM 2.0, ManufacturerID: IFX , Firmware Version: 7.83.3358.0
        Characteristics:
                Family configurable via firmware update
                Family configurable via OEM proprietary mechanism
        OEM-specific Information: 0x00000000

Thanks

Michal

