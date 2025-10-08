Return-Path: <linux-integrity+bounces-7396-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C95C0BC3532
	for <lists+linux-integrity@lfdr.de>; Wed, 08 Oct 2025 06:38:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B156F19E0D6C
	for <lists+linux-integrity@lfdr.de>; Wed,  8 Oct 2025 04:39:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85FA519E98D;
	Wed,  8 Oct 2025 04:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="zSHhXcz+";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="GddHVa5A";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="zSHhXcz+";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="GddHVa5A"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE50A2BE7C0
	for <linux-integrity@vger.kernel.org>; Wed,  8 Oct 2025 04:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759898321; cv=none; b=ceN2LGyBtwB7jVctUeE0MIFFCK13XPcJhO0El8gC655biaf8haEUaAklKkQhr4Fuzm/hL/vylHjoBfYRFzMCHertcorBaCiCV9Uke6myeJlyv03pStB+Lpyu9s9nYvNrwV3DMRExLDKUWdcfQSbmAzFuGPjivMIAtE97is80UrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759898321; c=relaxed/simple;
	bh=MwlZCgNalTvBOtmda8JxTwmqvgNtwAAbO7QLaV5b9XQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FZgf+MFyCGwtDBYDDEVVOEAweisxTVnzUQLO3YEZZr6iTBazDjkA8ajhrS1lJxLBoUizZkc3y031wJAdcj/wFJELQrNag4SXsgaRQuSEga+cb4ylVbj5t8acnLo4OR5nMtDfaAaFJ072tLwjSYsNQnJoa5YEnDRPd54eTfuRqMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=zSHhXcz+; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=GddHVa5A; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=zSHhXcz+; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=GddHVa5A; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 982E91F38F;
	Wed,  8 Oct 2025 04:38:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1759898317;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MwlZCgNalTvBOtmda8JxTwmqvgNtwAAbO7QLaV5b9XQ=;
	b=zSHhXcz+gBlWWqLaLUC6vRw2OGeQGnjLp+aw4/OB8JVSFOmTPDBP9XRTvux8UeUMOE1yNi
	UYRee7+ICsQV57g0QVW+n6YJ997jMhRn67L7z7hqBjaa4unWFuo9whDrbTktn/ZLOmMyRn
	HBejcEtbldcI3PTEpxQM2c075xlhip8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1759898317;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MwlZCgNalTvBOtmda8JxTwmqvgNtwAAbO7QLaV5b9XQ=;
	b=GddHVa5AdIU4QiUJkkv53LLVVWOuZrLdD/4qKP4MM1aY5bKXpxgrrXPOx5DanDaz8X7Npq
	wmJObv7/2wbCvmCA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=zSHhXcz+;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=GddHVa5A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1759898317;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MwlZCgNalTvBOtmda8JxTwmqvgNtwAAbO7QLaV5b9XQ=;
	b=zSHhXcz+gBlWWqLaLUC6vRw2OGeQGnjLp+aw4/OB8JVSFOmTPDBP9XRTvux8UeUMOE1yNi
	UYRee7+ICsQV57g0QVW+n6YJ997jMhRn67L7z7hqBjaa4unWFuo9whDrbTktn/ZLOmMyRn
	HBejcEtbldcI3PTEpxQM2c075xlhip8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1759898317;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MwlZCgNalTvBOtmda8JxTwmqvgNtwAAbO7QLaV5b9XQ=;
	b=GddHVa5AdIU4QiUJkkv53LLVVWOuZrLdD/4qKP4MM1aY5bKXpxgrrXPOx5DanDaz8X7Npq
	wmJObv7/2wbCvmCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7B33A13693;
	Wed,  8 Oct 2025 04:38:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id /VItHc3q5WhlKAAAD6G6ig
	(envelope-from <pvorel@suse.cz>); Wed, 08 Oct 2025 04:38:37 +0000
Date: Wed, 8 Oct 2025 06:38:36 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Cc: ltp@lists.linux.it, linux-integrity@vger.kernel.org
Subject: Re: [LTP] [PATCH 2/4] ima_conditionals.sh: Split test by request
Message-ID: <20251008043836.GA178062@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20251002083701.315334-1-pvorel@suse.cz>
 <20251002083701.315334-3-pvorel@suse.cz>
 <DDB27F9FQ4B3.11FGF9PVV0DAE@suse.com>
 <20251006112136.GA82874@pevik>
 <DDB7LLBEXIQM.2KSWEVEFU0TVS@suse.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DDB7LLBEXIQM.2KSWEVEFU0TVS@suse.com>
X-Spamd-Result: default: False [-3.71 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	HAS_REPLYTO(0.30)[pvorel@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:replyto,suse.cz:dkim];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:replyto,suse.cz:dkim];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	ARC_NA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	REPLYTO_EQ_FROM(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: 982E91F38F
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.71

> > verify_measurement() writes into /sys/kernel/security/ima/policy which on
> > kernels without CONFIG_IMA_WRITE_POLICY requires SUT reboot. Because LTP does
> > not support any reboot, this needs to be handled after test finishes. That's why
> > I separated the tests. This helps to cover more than the first test case out of
> > four.

> Now I see, this is clearly a corner case given by LTP limitations. I
> think we should probably start to think about reboot flag then. Once the
> PR for the new SUT will be implemented in kirk, it's time to work on
> this.

I would not wait for this as this is a long term project (on both LTP side and
IMA tests being converted into shell API at least). Once there is this
functionality implemented the split can be reverted.

Kind regards,
Petr

