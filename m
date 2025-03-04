Return-Path: <linux-integrity+bounces-5055-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D835A4D6F0
	for <lists+linux-integrity@lfdr.de>; Tue,  4 Mar 2025 09:49:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BF3616B857
	for <lists+linux-integrity@lfdr.de>; Tue,  4 Mar 2025 08:49:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 837471FA164;
	Tue,  4 Mar 2025 08:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="QMPnQFIX";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="CeMc+iC0";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="QMPnQFIX";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="CeMc+iC0"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0406329A9
	for <linux-integrity@vger.kernel.org>; Tue,  4 Mar 2025 08:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741078155; cv=none; b=D09KQqdv6D8bKqSGO4ipnJ2Wwk9HIfO2rWeROnN09KLYxmec6pcQWuadA0dFP0e/XXDk37iED9BcJulJqbzm1lPSZU83Dh+D8FuGwY1MTAYhEiinI8zguaGTaoXlfudh57SvZogNZ8GC+QHMPZj7Xex7m/Wvo3vMLnKirmotSxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741078155; c=relaxed/simple;
	bh=rYKJHHkuNux5rqR8KF7XVLyx9vSFFJw0lH67xodEyDg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JBbDGKANAY1tMZutGnt+ePLOXGDvpKhhQz6phMyuS8rXa7LdkP6Uhs6sbYcdmjEozauln78OVH810f6GHQ1PjqfailWWMbJM84ryQf4S5QoFtwl32IMLDTMDfPmfnV3k0ZwCaDube2x8JhX+8v7qNKrMVp5LFoBIeNtRLMyd+qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=QMPnQFIX; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=CeMc+iC0; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=QMPnQFIX; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=CeMc+iC0; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 118111F387;
	Tue,  4 Mar 2025 08:49:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1741078152;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rYKJHHkuNux5rqR8KF7XVLyx9vSFFJw0lH67xodEyDg=;
	b=QMPnQFIXFuOWUU9KHyb+zwB0ORLwuLk+W5p/F/QAp/z2frxXxEkOkPV5XtXlX/bvI/azhl
	AJbnp4j5NeAg5WRImnmk5OWBahr5952YBfkou6NY0JbfwA6LxrOMbvewXHvdDNGuWtgF2o
	5TOiETmG+bDvYiCgEp1H3KIcz/BcorM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1741078152;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rYKJHHkuNux5rqR8KF7XVLyx9vSFFJw0lH67xodEyDg=;
	b=CeMc+iC0hjat2NnRW/VCrbW90KHwuLaRMnfNq5OZIgLyeF7Opd/lP85k8pcfFmNJzdYvtD
	TlFqcuawwpgtpDDQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1741078152;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rYKJHHkuNux5rqR8KF7XVLyx9vSFFJw0lH67xodEyDg=;
	b=QMPnQFIXFuOWUU9KHyb+zwB0ORLwuLk+W5p/F/QAp/z2frxXxEkOkPV5XtXlX/bvI/azhl
	AJbnp4j5NeAg5WRImnmk5OWBahr5952YBfkou6NY0JbfwA6LxrOMbvewXHvdDNGuWtgF2o
	5TOiETmG+bDvYiCgEp1H3KIcz/BcorM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1741078152;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rYKJHHkuNux5rqR8KF7XVLyx9vSFFJw0lH67xodEyDg=;
	b=CeMc+iC0hjat2NnRW/VCrbW90KHwuLaRMnfNq5OZIgLyeF7Opd/lP85k8pcfFmNJzdYvtD
	TlFqcuawwpgtpDDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DA61C1393C;
	Tue,  4 Mar 2025 08:49:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ISA2NIe+xmdfQAAAD6G6ig
	(envelope-from <pvorel@suse.cz>); Tue, 04 Mar 2025 08:49:11 +0000
Date: Tue, 4 Mar 2025 09:49:10 +0100
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Cc: Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org
Subject: Re: [PATCH] ima_selinux.sh: Require ima_policy=critical_data kernel
 cmdline
Message-ID: <20250304084910.GB59205@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20250224105925.2865777-1-pvorel@suse.cz>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250224105925.2865777-1-pvorel@suse.cz>
X-Spam-Score: -3.50
X-Spamd-Result: default: False [-3.50 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	HAS_REPLYTO(0.30)[pvorel@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:replyto];
	REPLYTO_EQ_FROM(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

Hi all,

> Test requires not only func=CRITICAL_DATA IMA policy content but also
> ima_policy=critical_data kernel cmdline. Without cmdline no measures are
> done.

FYI merged.

Kind regards,
Petr

> https://ima-doc.readthedocs.io/en/latest/ima-policy.html#ima-policy-critical-data
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=fdd1ffe8a812

