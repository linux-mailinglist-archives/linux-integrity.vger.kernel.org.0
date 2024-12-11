Return-Path: <linux-integrity+bounces-4358-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 279669ED6C6
	for <lists+linux-integrity@lfdr.de>; Wed, 11 Dec 2024 20:48:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3390618842DC
	for <lists+linux-integrity@lfdr.de>; Wed, 11 Dec 2024 19:48:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E31C1C148;
	Wed, 11 Dec 2024 19:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="VFhr7b21";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="g96QiO/i";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="VFhr7b21";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="g96QiO/i"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CE262594BD
	for <linux-integrity@vger.kernel.org>; Wed, 11 Dec 2024 19:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733946527; cv=none; b=edA5PpWsRWN1oex5mGmVaTBYcUscl3Gv8hdyEEHaxcASJ8UyvrwrkJtyl5CTjzOttgLGYSyN1+vy2ZQXIWBRLIEO9KamB1G+ZNXM2XqI661ZyXEn8Jyl6eNF2jfw7P/xlA+YBT/ELoPSnW3eAMXcOe7285AqVjYDcveVwk/+lXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733946527; c=relaxed/simple;
	bh=7QhcgsMNKSBy+5YhIhNAk6lN5H9vJRSuR5P0iHOIwZU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KWenN5QmrDuJ9hDpIvJwf7q8+t7crvSQM1gBJSHw1qXB4knjnVlm6Dgb3s//kGLCBsQ4VLZT5qLtlUe/5Lj3iIQ+OWQebLmyHXWmwEclJ4GQsIP2uplRcZNQu4gESDOi0u8NMgCq/xXrqoiHSDQajZOlgzTBk5YlCaQ5i5zQohI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=VFhr7b21; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=g96QiO/i; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=VFhr7b21; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=g96QiO/i; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 2B2CB1F38D;
	Wed, 11 Dec 2024 19:48:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1733946524;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0fOS5FQnchX46ZLxJOMD+J4hxGukjoz1kSqwjBh0yOo=;
	b=VFhr7b21tA8H1Qe49VcAoQqTQL/Sl9s5NF7XmFObhTo6rClK7rfuB+BjquNnzIXCdWdZ/r
	UFF/Ux3LGAS9GSWAawoshwOr2hx/mZ+9JMVEDAWiGq/DQ7uUQFQeZGONvFqDRDiTfwExqe
	6CQgSAsqTZrpPAemQszq9eIk8+RX88k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1733946524;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0fOS5FQnchX46ZLxJOMD+J4hxGukjoz1kSqwjBh0yOo=;
	b=g96QiO/i23+2y677l9vCbT6rdtE0QaXK60DWRtqYs8ZX8UaNbCCpLEd+JSjURYdnfE1hHd
	Y1lY5YfPoW29HhDw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1733946524;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0fOS5FQnchX46ZLxJOMD+J4hxGukjoz1kSqwjBh0yOo=;
	b=VFhr7b21tA8H1Qe49VcAoQqTQL/Sl9s5NF7XmFObhTo6rClK7rfuB+BjquNnzIXCdWdZ/r
	UFF/Ux3LGAS9GSWAawoshwOr2hx/mZ+9JMVEDAWiGq/DQ7uUQFQeZGONvFqDRDiTfwExqe
	6CQgSAsqTZrpPAemQszq9eIk8+RX88k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1733946524;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0fOS5FQnchX46ZLxJOMD+J4hxGukjoz1kSqwjBh0yOo=;
	b=g96QiO/i23+2y677l9vCbT6rdtE0QaXK60DWRtqYs8ZX8UaNbCCpLEd+JSjURYdnfE1hHd
	Y1lY5YfPoW29HhDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 19C0F1344A;
	Wed, 11 Dec 2024 19:48:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id I+AlA5vsWWd3EwAAD6G6ig
	(envelope-from <pvorel@suse.cz>); Wed, 11 Dec 2024 19:48:43 +0000
Date: Wed, 11 Dec 2024 20:48:36 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: ltp@lists.linux.it, linux-integrity@vger.kernel.org,
	Roberto Sassu <roberto.sassu@huaweicloud.com>
Subject: Re: [PATCH 2/3] ima_setup.sh: Allow to load predefined policy
Message-ID: <20241211194836.GE443680@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20241126173830.98960-1-pvorel@suse.cz>
 <20241126173830.98960-3-pvorel@suse.cz>
 <710315f59b9378d76d226e209fee698f6bc11c06.camel@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <710315f59b9378d76d226e209fee698f6bc11c06.camel@linux.ibm.com>
X-Spam-Score: -7.50
X-Spamd-Result: default: False [-7.50 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	HAS_REPLYTO(0.30)[pvorel@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
	MIME_GOOD(-0.10)[text/plain];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	REPLYTO_EQ_FROM(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

Hi Mimi, all,

> On Tue, 2024-11-26 at 18:38 +0100, Petr Vorel wrote:
> > environment variable LTP_IMA_LOAD_POLICY=1 tries to load example policy
> > if available. This should be used only if tooling running LTP tests
> > allows to reboot afterwards (because policy may be writable only once,
> > e.g. missing CONFIG_IMA_WRITE_POLICY=y, or policies can influence each
> > other).

> Thanks, Petr.  Allowing the policy to be updated only if permitted is a good
> idea.  Even with the LTP_IMA_LOAD_POLICY=1 environment variable, the policy
> might not be loaded.  For example, when secure boot is enabled and the kernel is
> configured with CONFIG_IMA_ARCH_POLICY enabled, an "appraise func=POLICY_CHECK
> appraise_type=imasig" rule is loaded, requiring the IMA policy itself to be
> signed.

Yes, it's an attempt, which can fail for various reasons. I'll add this example
of failure to load the policy to the commit message and to the docs.

I'd like to detect if policy got updated to avoid wasting time with SUT reboot
when policy was not updated. But this probably will not be always possible
(e.g. (CONFIG_IMA_READ_POLICY not set).

> On failure to load a policy, the ima_conditionals.sh and ima_policy.sh tests say
> "TINFO: SELinux enabled in enforcing mode, this may affect test results".  We
> should stop blaming SELinux. :)

This info was added for LTP shell tests, which got often affected by
SELinux/Apparmor. Because IMA is written in LTP shell API it gets this.
Error message is printed on TBROK, TFAIL, TWARN. Is this the only part where you
would like to avoid the message? Or do you want to remove SELinux/Apparmor
warning from all IMA tests?

Kind regards,
Petr

> thanks,

> Mimi


