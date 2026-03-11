Return-Path: <linux-integrity+bounces-8972-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uP9ZG+MssWkBrgIAu9opvQ
	(envelope-from <linux-integrity+bounces-8972-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Wed, 11 Mar 2026 09:50:43 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1685225FB99
	for <lists+linux-integrity@lfdr.de>; Wed, 11 Mar 2026 09:50:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7BBDA302A552
	for <lists+linux-integrity@lfdr.de>; Wed, 11 Mar 2026 08:50:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49FC23C3429;
	Wed, 11 Mar 2026 08:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="o4tcifl1";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LMTIauJ8"
X-Original-To: linux-integrity@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF4543B7775;
	Wed, 11 Mar 2026 08:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773219018; cv=none; b=A5ZRB4C9p5ir5+pLHK4JjV6oaJsiNxZGtPWdvOBzPx0XIoYVHqJLk3QtEbJs0UgXCHXaqu2hroz6GAykHA8Iy408cbuW8LGz1qO931dUbjCAriLyFGPRF+tC6rD8DOvkbUv93UipnaFgDd3rCoPMTRD76PwXbhSM+gDyzcxY62g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773219018; c=relaxed/simple;
	bh=ZjFxYEjK8aozfmve4JoaBaV+xJQhTcTGAjUyYSMn6lQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dkknLweiGRXZL0r0X9Aw7ULotf1kxciKseOAE0aUhy2ZsH2mOf/qpaLACyISXnyrR+vOFLV8EUkR967oU25kjN/LlyWJFVsrZr6VZEyM6BMqBNCIwm7ycQan5LFr3EIjA+LMpkE0staIdLHbCMi+wIxenVqy+A/N9xxucfZn7ME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=o4tcifl1; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LMTIauJ8; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 11 Mar 2026 09:50:08 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1773219010;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Dh2u910Dr9v3m0hVo537X6ofb5vKqJBESKL7gfq66iU=;
	b=o4tcifl1o8jywgLPdg/s+WX7sDPzz+eCAnhiMj3T66TG/Q1htV1GOGeOOud7SVVEX+GX92
	OVl1a0sAtFbXIhn6q8VAYV3nbRQ8ydhQIs0OB6MXRRv1VFkebNYQxNtC6ZpsNfMUc2HPJe
	my1FYPw0ldYH8kKSZm/D/y2nEimFEJIe4djKU6CH2C6et4c58of1WcZakycG05pAwk+5+R
	vRjsqZMlne+14maN+9VGVI5qg7hbBIk6aqyB10RpJcYkoRJbGh9dKeD1rxtrSKP3zP2jcK
	nzJWn+wPTcYCVcLlRx9uC67R6D4rj8jJI+lZcpjDoC0/26vEYJrmilrpcNilQg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1773219010;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Dh2u910Dr9v3m0hVo537X6ofb5vKqJBESKL7gfq66iU=;
	b=LMTIauJ88fFcgqN/jXiJPCLOHnYrJyLVhh0TJD/NNsp9hdkMfEbyqHXmdDHdxxwf8KEeF3
	WVtUAKnV6l5hwHDQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Eric Biggers <ebiggers@kernel.org>
Cc: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	Nathan Chancellor <nathan@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>, Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Daniel Gomez <da.gomez@samsung.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Naveen N Rao <naveen@kernel.org>, Mimi Zohar <zohar@linux.ibm.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
	Eric Snowberg <eric.snowberg@oracle.com>,
	Nicolas Schier <nicolas.schier@linux.dev>,
	Daniel Gomez <da.gomez@kernel.org>,
	Aaron Tomlin <atomlin@atomlin.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Nicolas Schier <nsc@kernel.org>,
	Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>,
	Xiu Jianfeng <xiujianfeng@huawei.com>,
	Fabian =?utf-8?Q?Gr=C3=BCnbichler?= <f.gruenbichler@proxmox.com>,
	Arnout Engelen <arnout@bzzt.net>,
	Mattia Rizzolo <mattia@mapreri.org>, kpcyrd <kpcyrd@archlinux.org>,
	Christian Heusel <christian@heusel.eu>,
	=?utf-8?B?Q8OianU=?= Mihai-Drosi <mcaju95@gmail.com>,
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-modules@vger.kernel.org,
	linux-security-module@vger.kernel.org, linux-doc@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-integrity@vger.kernel.org
Subject: Re: [PATCH v4 15/17] module: Introduce hash-based integrity checking
Message-ID: <20260311085008.TSnh3YR1@linutronix.de>
References: <20260113-module-hashes-v4-0-0b932db9b56b@weissschuh.net>
 <20260113-module-hashes-v4-15-0b932db9b56b@weissschuh.net>
 <20260311011218.GA212983@quark>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260311011218.GA212983@quark>
X-Rspamd-Queue-Id: 1685225FB99
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8972-lists,linux-integrity=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[weissschuh.net,kernel.org,arndb.de,suse.com,google.com,samsung.com,paul-moore.com,namei.org,hallyn.com,lwn.net,linux.ibm.com,ellerman.id.au,gmail.com,huawei.com,oracle.com,linux.dev,atomlin.com,oss.cyber.gouv.fr,proxmox.com,bzzt.net,mapreri.org,archlinux.org,heusel.eu,vger.kernel.org,lists.ozlabs.org];
	RCPT_COUNT_TWELVE(0.00)[41];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bigeasy@linutronix.de,linux-integrity@vger.kernel.org];
	DKIM_TRACE(0.00)[linutronix.de:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-integrity];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

On 2026-03-10 18:12:18 [-0700], Eric Biggers wrote:
> > diff --git a/scripts/modules-merkle-tree.c b/scripts/modules-merkle-tree.c
> [...]
> 
> > +struct file_entry {
> > +	char *name;
> > +	unsigned int pos;
> > +	unsigned char hash[EVP_MAX_MD_SIZE];
> 
> Considering that the hash algorithm is fixed, EVP_MAX_MD_SIZE can be
> replaced with a tighter local definition:
> 
>     #define MAX_HASH_SIZE 32
> 
> > +static struct file_entry *fh_list;
> > +static size_t num_files;
> > +
> > +struct leaf_hash {
> > +	unsigned char hash[EVP_MAX_MD_SIZE];
> > +};
> > +
> > +struct mtree {
> > +	struct leaf_hash **l;
> > +	unsigned int *entries;
> > +	unsigned int levels;
> > +};
> 
> 'struct leaf_hash' is confusing because it's actually used for the
> hashes of internal nodes, not leaf nodes.

You could still consider the internal nodes as leafs.

> Maybe rename it to 'struct hash' and use it for both the hashes and leaf
> nodes and internal nodes.
> 
> Also, clearer naming would improve readability, e.g.:
> 
>     struct merkle_tree {
>             struct hash **level_hashes;
>             unsigned int level_size;
>             unsigned int num_levels;
>     };

but this could improve it, indeed.

> > +	hash_evp = EVP_get_digestbyname("sha256");
> 
> EVP_sha256()

I would suggest to use EVP_MD_fetch() instead.

> > +	hash_size = EVP_MD_get_size(hash_evp);
> 
> The old name 'EVP_MD_size()' would have wider compatibility.

EVP_MD_fetch() and EVP_MD_get_size() are openssl 3.0.0+ and nothing
below 3.0.0 is considered supported (while 3.0.0 is EOL 07 Sep 2026).

Sebastian

