Return-Path: <linux-integrity+bounces-7376-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B1915BBD74B
	for <lists+linux-integrity@lfdr.de>; Mon, 06 Oct 2025 11:35:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E2AFD4E29FE
	for <lists+linux-integrity@lfdr.de>; Mon,  6 Oct 2025 09:35:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5943F1EA7C6;
	Mon,  6 Oct 2025 09:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="MuR8qeLz";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="C+LvNU6Z";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="MuR8qeLz";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="C+LvNU6Z"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C53E1EA7CB
	for <linux-integrity@vger.kernel.org>; Mon,  6 Oct 2025 09:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759743343; cv=none; b=Ud7bf+cU7zTbUHNw8CW11zPZ/4HdNOtzT19XUl1YVD25sHvEGPwxjuj+7YBsxEa0uW8x3hNGWSgej4tMDORont9BuvQqlRxH34edxdI3wkbM4aMFDmkYxL3wtu83KxFG/g9/1oVxn21WXm1kh/JZu8NbaCH4bJVqNbOjjItKcls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759743343; c=relaxed/simple;
	bh=MIKGvbg7G2meU14KSmH35tkTzGrasWbNJ/rdqPPFnkM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hhFeGuxfcGB+adx14GuycF5UHaQpqTaI2qGQzzcOiKKZyiKzpjWTbYcl7/JqbwNg7Ku0J4DHLhVyuHHlGRYhwo9W330qQuxxPDK4l1fxWInkJsS1iObaIW2pjNQLbdUKhiPbLYV25+kKAEzq4kBqJg9qhw2Cr464JqGv/RI72uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=MuR8qeLz; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=C+LvNU6Z; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=MuR8qeLz; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=C+LvNU6Z; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 814AB1F7DE;
	Mon,  6 Oct 2025 09:35:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1759743339;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MIKGvbg7G2meU14KSmH35tkTzGrasWbNJ/rdqPPFnkM=;
	b=MuR8qeLzx/k+M3urYrvkqVZprq3RG4WU2XRSL7W6WFvBYWv3Z8bJ2bG3E2sO+WcMGrkQf4
	rWbx+y3+LxBcjEfsI7oPHhdKGfaYXK+AdL8D5GhP8mLi8mh0HBiUqcptftP+nPqdCnG6y6
	ufFoeH/fmux4lvMch1MwpuOv13Wh66A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1759743339;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MIKGvbg7G2meU14KSmH35tkTzGrasWbNJ/rdqPPFnkM=;
	b=C+LvNU6Zk/GAl+9ljhy2UvDxGFr/zLXt4Tc6awd/oWFneELrA3Sq/L0CJB8T7bqVJ1usOA
	jQNjNHnwjWw9PgDg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=MuR8qeLz;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=C+LvNU6Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1759743339;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MIKGvbg7G2meU14KSmH35tkTzGrasWbNJ/rdqPPFnkM=;
	b=MuR8qeLzx/k+M3urYrvkqVZprq3RG4WU2XRSL7W6WFvBYWv3Z8bJ2bG3E2sO+WcMGrkQf4
	rWbx+y3+LxBcjEfsI7oPHhdKGfaYXK+AdL8D5GhP8mLi8mh0HBiUqcptftP+nPqdCnG6y6
	ufFoeH/fmux4lvMch1MwpuOv13Wh66A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1759743339;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MIKGvbg7G2meU14KSmH35tkTzGrasWbNJ/rdqPPFnkM=;
	b=C+LvNU6Zk/GAl+9ljhy2UvDxGFr/zLXt4Tc6awd/oWFneELrA3Sq/L0CJB8T7bqVJ1usOA
	jQNjNHnwjWw9PgDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5ACD413700;
	Mon,  6 Oct 2025 09:35:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id uSFvFGuN42i/QQAAD6G6ig
	(envelope-from <pvorel@suse.cz>); Mon, 06 Oct 2025 09:35:39 +0000
Date: Mon, 6 Oct 2025 11:35:38 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Cc: ltp@lists.linux.it, linux-integrity@vger.kernel.org
Subject: Re: [LTP] [PATCH 0/4] ima_{conditionals,measurements}.sh enhancements
Message-ID: <20251006093538.GA66983@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20251002083701.315334-1-pvorel@suse.cz>
 <DDB27AD5V8CC.HACBLFITNI9R@suse.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DDB27AD5V8CC.HACBLFITNI9R@suse.com>
X-Spamd-Result: default: False [-3.71 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	HAS_REPLYTO(0.30)[pvorel@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:replyto,suse.cz:dkim];
	ARC_NA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	REPLYTO_EQ_FROM(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: 814AB1F7DE
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.71

Hi Andrea,

...
> What about creating a tool simulating sudo? I thought that was our main
> goal. Using 'su' is ok, but this forces us to create a new user all the
> times we execute a new suite, while our new sudo implementation would
> create and destroy the user only for the specific session.

Jan suggested to implement it [1] ("changes uid/git based on parameters and
executes whatever we give it"). I'll move the discussion under that thread so
that we have it on single place.

Kind regards,
Petr

[1] https://lore.kernel.org/ltp/CAASaF6yjdrLLVnehESx1TjsrB_z48nmN_2i585GPfkG3Vvg15Q@mail.gmail.com/

> - Andrea

