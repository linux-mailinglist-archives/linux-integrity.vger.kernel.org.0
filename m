Return-Path: <linux-integrity+bounces-4324-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A6F89EB095
	for <lists+linux-integrity@lfdr.de>; Tue, 10 Dec 2024 13:16:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7421160484
	for <lists+linux-integrity@lfdr.de>; Tue, 10 Dec 2024 12:16:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB08538FB9;
	Tue, 10 Dec 2024 12:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="EBvYyTJf";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="9ezIFBoi";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="EBvYyTJf";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="9ezIFBoi"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1B7F23DE9A
	for <linux-integrity@vger.kernel.org>; Tue, 10 Dec 2024 12:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733832961; cv=none; b=dffAIM5Pa9nh08z5m9zxX5QKSk0s5r8fhZGtXS47i6iwF4xc/cR1pZ8WmCEhp7xPG2xjcIqSvruMXeRCCkrzALHzBWEI2kkFYhlEbnYapTshKYqtMWfsCDZ5abntXfA3tLUyXkhrQn3nv3g9a3neCUOVm/krctMRfBEgVcfsfDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733832961; c=relaxed/simple;
	bh=L21jWoRbmi0e42sYdFOWfMC0AcfQdd4Skgf8igINVOM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JaIAtOIDuuPF4Xvgz+yghIMKGd+/zttkRc9IpbVfWXp/Ww7sN98J9R5iRQ4QxwlG3ofTJrSDOQ8aVrcOkwgmtysgSxmtBFhDrYnJyLNkuUanzadRhAkV1a6aDnaUO9/VEzjuMx6sDBTLwSd5qt8Q3nUpSrU4gPz1ssKdmyB3NaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=EBvYyTJf; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=9ezIFBoi; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=EBvYyTJf; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=9ezIFBoi; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 2A8A41F395;
	Tue, 10 Dec 2024 12:15:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1733832943; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SE6sdXUp92kVfdcqD0HbHop14JEM9SC7p8+h4bTSQYU=;
	b=EBvYyTJfA0y8sZhkYbLdcodT+WHTzXrbyn/0cL+gt++Ql6a1SjPx9Vjsrr7ox+tz34CEvd
	95M4ctqePZnDJmL07BaTV0IsywmxRob35mYi54xfnU1Jfcv6grnd94IJCPBx/SsvV1uUtO
	k0R6Ib6pFimiPj2MzUqHWIHE9quPAlQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1733832943;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SE6sdXUp92kVfdcqD0HbHop14JEM9SC7p8+h4bTSQYU=;
	b=9ezIFBoiZnSOOB61abzJwWZ5/YOqySEmY4bzPpy0p2pQlgRyH/t9hc0olcQUELJmNKdruK
	gLaPC5mmHj19egDw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=EBvYyTJf;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=9ezIFBoi
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1733832943; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SE6sdXUp92kVfdcqD0HbHop14JEM9SC7p8+h4bTSQYU=;
	b=EBvYyTJfA0y8sZhkYbLdcodT+WHTzXrbyn/0cL+gt++Ql6a1SjPx9Vjsrr7ox+tz34CEvd
	95M4ctqePZnDJmL07BaTV0IsywmxRob35mYi54xfnU1Jfcv6grnd94IJCPBx/SsvV1uUtO
	k0R6Ib6pFimiPj2MzUqHWIHE9quPAlQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1733832943;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SE6sdXUp92kVfdcqD0HbHop14JEM9SC7p8+h4bTSQYU=;
	b=9ezIFBoiZnSOOB61abzJwWZ5/YOqySEmY4bzPpy0p2pQlgRyH/t9hc0olcQUELJmNKdruK
	gLaPC5mmHj19egDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0DC8613A15;
	Tue, 10 Dec 2024 12:15:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 7UUDA+8wWGekaAAAD6G6ig
	(envelope-from <chrubis@suse.cz>); Tue, 10 Dec 2024 12:15:43 +0000
Date: Tue, 10 Dec 2024 13:15:58 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Xiubo Li <xiubli@redhat.com>
Cc: ltp@lists.linux.it, linux-integrity@vger.kernel.org
Subject: Re: [LTP] [PATCH] doc: correct the build steps for
 open_posix_testsuite
Message-ID: <Z1gw_mNXF7KIzklK@yuki.lan>
References: <20241119101357.951813-1-xiubli@redhat.com>
 <Z0mXHSnqmstCIMrF@yuki.lan>
 <a32c6381-8779-4dc5-878b-a46bff6454d6@redhat.com>
 <Z02PZRGzw5qM3z0w@yuki.lan>
 <2779c1f7-28fd-415f-a016-da3aa077659b@redhat.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2779c1f7-28fd-415f-a016-da3aa077659b@redhat.com>
X-Rspamd-Queue-Id: 2A8A41F395
X-Spam-Level: 
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email];
	URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:dkim,suse.cz:email,yuki.lan:mid];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.51
X-Spam-Flag: NO

Hi!
> > The top level configure script configures the open posix testsuite, but
> > you have to pass the --with-open-posix-testsuite flag to it.
> >
> > Or you can run the open posix configure from the open posix directory.
> >
> Yeah, this looks better.
> 
> Does it make sense to fix the doc about this ? If so I will send the V3.

Yes please (and sorry for the delayed response).

-- 
Cyril Hrubis
chrubis@suse.cz

