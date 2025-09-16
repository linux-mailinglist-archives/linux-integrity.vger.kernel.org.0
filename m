Return-Path: <linux-integrity+bounces-7103-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 580B6B59DE6
	for <lists+linux-integrity@lfdr.de>; Tue, 16 Sep 2025 18:41:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 889721621C7
	for <lists+linux-integrity@lfdr.de>; Tue, 16 Sep 2025 16:41:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E878127A124;
	Tue, 16 Sep 2025 16:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="CxWwmcYS";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="30cVzvZ4";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="sDpQEn4k";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="o8MlFga7"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C12F231E89A
	for <linux-integrity@vger.kernel.org>; Tue, 16 Sep 2025 16:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758040869; cv=none; b=crPFurRV+89IUnbOnOJPypn85Fgil4GiZHaMh4hrN0tQnEzRz3MOd93I5hNq3p2bfWgNddW9vOPFv2WXLCAtGPsYUxNsZm+180i5s0b/96Nr87j/Ngik60qnyqXcnTso+SJSArq5OWvE+Bh8Ch9k2RYfeh8su0tpAWMlaq96IQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758040869; c=relaxed/simple;
	bh=ygHRKU4+NyJNpxxxSeziFUbD7M5KcN1tEmTyd/ZM9MI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bFJBkz+knOgQH/UgQocIhLPQtdKrDRRyyKWQthUpE+NYhxBKWQjik+jGA8lPFEOiiXGISzVekGb3nqiBx37RpjG7ih76ndU4+ow5fjdK1eP5ew6EYPzlpq19H6gVyej+9UQIWf5q5Jx80ObS/hyrTtXSGWseKpiD/8TpTJRtuWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=CxWwmcYS; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=30cVzvZ4; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=sDpQEn4k; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=o8MlFga7; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C7402227A8;
	Tue, 16 Sep 2025 16:41:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1758040866;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=60UJXs00+JFtBJRSqpPgQp+TkYv/DrUkYHiS5ruLArA=;
	b=CxWwmcYS7wlahKqWtAyC9iOMvNJUPSh3MbRUHtaoUaIjgeLvJL2uBugKlPNbaghkSg47AZ
	9KF2bHvKfDzHrZBQ4JGb7p3XTlhIE78YDg43Zat7bLOLrX8TIqqPL6QN5OL1VaHm/SsJmn
	wfmiKn68hd11h85QDG6wXXh+cd3pU1k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1758040866;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=60UJXs00+JFtBJRSqpPgQp+TkYv/DrUkYHiS5ruLArA=;
	b=30cVzvZ4VHDffz+r8fP5OLTryRTOhw82RaYp2j5U3v84RtEfAjtpPedmnqxd1T6nttNy25
	lV5rccHc6rYiDkCw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=sDpQEn4k;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=o8MlFga7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1758040865;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=60UJXs00+JFtBJRSqpPgQp+TkYv/DrUkYHiS5ruLArA=;
	b=sDpQEn4kvhvn4mgSO/dqWXZEY4il0SMEJuyYXwigha+uDLlTl4ZqiOySmF8hP0SapcOHIF
	vfuoJpSPicXZ4qbKVL6MJlB8cO7kGmER9iyMVT7QSL4mCfTGRQMyc4NzItFC5/iVcS8wLw
	Qcm4iIBI/+03TgGmqn3SKqUNuD7sktE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1758040865;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=60UJXs00+JFtBJRSqpPgQp+TkYv/DrUkYHiS5ruLArA=;
	b=o8MlFga7R7VpBFvW4tzLykyYcQnCtaE4yIZCS8d8OqLwWEwNBBlgowA+92WsTq+vV0fIy2
	t3wc5yj+XUq5w5Aw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C634813A63;
	Tue, 16 Sep 2025 16:41:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id KOvTLiCTyWhqVQAAD6G6ig
	(envelope-from <pvorel@suse.cz>); Tue, 16 Sep 2025 16:41:04 +0000
Date: Tue, 16 Sep 2025 18:41:02 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: ltp@lists.linux.it, linux-integrity@vger.kernel.org,
	selinux@vger.kernel.org, Cyril Hrubis <chrubis@suse.cz>,
	Coiby Xu <coxu@redhat.com>, Li Wang <liwang@redhat.com>
Subject: Re: [PATCH 2/2] ima_{conditionals,policy}: Handle policy required to
 be signed
Message-ID: <20250916164102.GA284778@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20250912073210.47637-1-pvorel@suse.cz>
 <20250912073210.47637-3-pvorel@suse.cz>
 <b8723148a39083cab0b43f9c7fa5ce18d696f99d.camel@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b8723148a39083cab0b43f9c7fa5ce18d696f99d.camel@linux.ibm.com>
X-Spamd-Result: default: False [-3.71 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	HAS_REPLYTO(0.30)[pvorel@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:replyto,suse.cz:dkim,suse.cz:email,suse.de:url];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	REPLYTO_EQ_FROM(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: C7402227A8
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.71

Hi Mimi,

[ Cc Li, although I have no idea if Fedora even runs LTP IMA tests ]

> On Fri, 2025-09-12 at 09:32 +0200, Petr Vorel wrote:
> > Since kernel 6.6 policy needs to be signed on enabled UEFI secure boot.
> > Skip testing in that case.

> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=56dc986a6b20b

> > This fixes errors:

> >     ima_policy 2 TINFO: verify that policy file is not opened concurrently and able to loaded multiple times
> >     ima_policy 2 TFAIL: problem loading or extending policy (may require policy to be signed)
> >     https://openqa.suse.de/tests/18723792#step/ima_conditionals/6

> >     ima_conditionals 1 TINFO: verify measuring user files when requested via uid
> >     echo: write error: Permission denied
> >     ima_conditionals 1 TBROK: echo measure uid=65534 > /sys/kernel/security/ima/policy failed

> > Ideally there would be test which check that unsigned policy cannot be
> > written.

> > Signed-off-by: Petr Vorel <pvorel@suse.cz>

> Thanks, Petr.

> Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>

Thanks for your review, merged!

> At some point, consider adding support for signing policy rules, if the
> private/public keypair is provided.

I'm not against it, but I'm not sure if I find time for this (as usual patches
are welcome). If I understand the docs [1] [2] it depends on
CONFIG_SYSTEM_TRUSTED_KEYS, right?

Fedora builds with CONFIG_SYSTEM_TRUSTED_KEYS="certs/rhel.pem", but ship config
with CONFIG_SYSTEM_TRUSTED_KEYS="" ("We are resetting this value to facilitate
local builds" - makes perfectly sense), other distros (at least openSUSE
Tumbleweed and Debian) build with CONFIG_SYSTEM_TRUSTED_KEYS="".

I doubt that Fedora private key will be exposed for testing. Therefore this
feature is IMHO useful for mainline testing, but not for distro testing, right?
But again, I'm not against merging the patch (if anybody is willing to implement
it).

Kind regards,
Petr

[1] https://ima-doc.readthedocs.io/en/latest/ima-utilities.html#build-kernel-with-ima-ca-key-on-keyring
[2] https://ima-doc.readthedocs.io/en/latest/ima-utilities.html#ima-ca-key-and-certificate

> Mimi

