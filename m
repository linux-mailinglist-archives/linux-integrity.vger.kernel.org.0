Return-Path: <linux-integrity+bounces-8968-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ENGzFfGUsGkukgIAu9opvQ
	(envelope-from <linux-integrity+bounces-8968-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Tue, 10 Mar 2026 23:02:25 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E6779258A3C
	for <lists+linux-integrity@lfdr.de>; Tue, 10 Mar 2026 23:02:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 059B9304C608
	for <lists+linux-integrity@lfdr.de>; Tue, 10 Mar 2026 22:01:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FE753EE1DE;
	Tue, 10 Mar 2026 22:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GGvggPvE"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE11B3DDDA5;
	Tue, 10 Mar 2026 22:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773180110; cv=none; b=NSXwqva+yCyl+WMjxz7QNXh7bN+F3YHGFoarpNlv5xnEBeqbmLZLxg+ZeiIUVNWFZjHb2nfJe7xmbEZR0piDtUkmOESsluS1Z/6ubBi2/6YerohRwnuyOwm2nJmzF7GF7g0o+HmBd/tIFJHadEhyhbrIwPvmOxeVlmmrf0C7GCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773180110; c=relaxed/simple;
	bh=MQ1Kvit/YkYohJNLQgbKJcXEUW5nvFuzEgTtw+akafs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TH2no4X3iIaIDNtIpsog9rI+uOX9+0Sm0DlTVQZSgZLDmflcDOnbhPiq2fdRB2DfnGY3w5WKgwSy1NJhEyJKBrYQoiR01rKxOFS8ZkiYaGDD6QKOFla9azPUwUXNcVNvD9NdO1GmGf4pEuFFZxC4d63y9gyVGjkZlLZ+vb69aHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GGvggPvE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD1DCC19423;
	Tue, 10 Mar 2026 22:01:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773180109;
	bh=MQ1Kvit/YkYohJNLQgbKJcXEUW5nvFuzEgTtw+akafs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GGvggPvEmh8XiT63QPC7GMfLJo3hx6rmMAuG7zISFhuq9WZUmJwKJ6lnHofnDW73M
	 fn4s0miKrWTlQXpk0PkYvqybGd3Jf0YCgESE1zy9MtCrmEiLqmKVCaYucy6TxqYqwB
	 BOB7v2LEpB45L8U9lQleD0cW9W4ubqGsSgWy8nbzzrvG+zSJw8tYKEb/kgLtaRcY+N
	 4hsy8XsNJdw/bEnLdt3hyxs75ovJPGPB7Id6RxfkWivV/tO9xFsAjqy7CE7DfgNWfG
	 8zy17wQsgLHX6Yq3zfYn2MlzN8Hfqpqroo9tU98OnhnV3H/T/ApraCEXGcHecfuK2r
	 uHijp/5FckWHg==
Date: Tue, 10 Mar 2026 15:01:46 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc: Nathan Chancellor <nathan@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Luis Chamberlain <mcgrof@kernel.org>,
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
	Fabian =?iso-8859-1?Q?Gr=FCnbichler?= <f.gruenbichler@proxmox.com>,
	Arnout Engelen <arnout@bzzt.net>,
	Mattia Rizzolo <mattia@mapreri.org>, kpcyrd <kpcyrd@archlinux.org>,
	Christian Heusel <christian@heusel.eu>,
	=?iso-8859-1?Q?C=E2ju?= Mihai-Drosi <mcaju95@gmail.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-modules@vger.kernel.org,
	linux-security-module@vger.kernel.org, linux-doc@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-integrity@vger.kernel.org
Subject: Re: [PATCH v4 09/17] module: Make module loading policy usable
 without MODULE_SIG
Message-ID: <20260310220146.GE120274@quark>
References: <20260113-module-hashes-v4-0-0b932db9b56b@weissschuh.net>
 <20260113-module-hashes-v4-9-0b932db9b56b@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260113-module-hashes-v4-9-0b932db9b56b@weissschuh.net>
X-Rspamd-Queue-Id: E6779258A3C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8968-lists,linux-integrity=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[41];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,arndb.de,suse.com,google.com,samsung.com,paul-moore.com,namei.org,hallyn.com,lwn.net,linux.ibm.com,ellerman.id.au,gmail.com,huawei.com,oracle.com,linux.dev,atomlin.com,oss.cyber.gouv.fr,proxmox.com,bzzt.net,mapreri.org,archlinux.org,heusel.eu,linutronix.de,vger.kernel.org,lists.ozlabs.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ebiggers@kernel.org,linux-integrity@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-integrity];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,weissschuh.net:email]
X-Rspamd-Action: no action

On Tue, Jan 13, 2026 at 01:28:53PM +0100, Thomas Weiﬂschuh wrote:
> The loading policy functionality will also be used by the hash-based
> module validation. Split it out from CONFIG_MODULE_SIG so it is usable
> by both.
> 
> Signed-off-by: Thomas Weiﬂschuh <linux@weissschuh.net>
> ---
>  include/linux/module.h  |  8 ++++----
>  kernel/module/Kconfig   |  5 ++++-
>  kernel/module/main.c    | 26 +++++++++++++++++++++++++-
>  kernel/module/signing.c | 21 ---------------------
>  4 files changed, 33 insertions(+), 27 deletions(-)
> 
> diff --git a/include/linux/module.h b/include/linux/module.h
> index f288ca5cd95b..f9601cba47cd 100644
> --- a/include/linux/module.h
> +++ b/include/linux/module.h
> @@ -444,7 +444,7 @@ struct module {
>  	const u32 *gpl_crcs;
>  	bool using_gplonly_symbols;
>  
> -#ifdef CONFIG_MODULE_SIG
> +#ifdef CONFIG_MODULE_SIG_POLICY
>  	/* Signature was verified. */
>  	bool sig_ok;
>  #endif
[...]
> +config MODULE_SIG_POLICY
> +	def_bool MODULE_SIG

Maybe MODULE_AUTH_POLICY?  Hash-based module authentication does not use
signatures.

This issue appears elsewhere in the code too.  There are lots of places
that still refer to module signatures or "sigs", when really module
authentication is meant.

I'm not sure how far you want to go with the renaming, but it's
something to think about.  It's confusing to use the term "signature" to
mean something that is not a signature.

- Eric

