Return-Path: <linux-integrity+bounces-8975-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UG+tJGtnsWnsugIAu9opvQ
	(envelope-from <linux-integrity+bounces-8975-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Wed, 11 Mar 2026 14:00:27 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D09A264090
	for <lists+linux-integrity@lfdr.de>; Wed, 11 Mar 2026 14:00:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 354AE3051460
	for <lists+linux-integrity@lfdr.de>; Wed, 11 Mar 2026 12:59:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AD7E2C21C3;
	Wed, 11 Mar 2026 12:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="CEiZ87VU"
X-Original-To: linux-integrity@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D786F282F33;
	Wed, 11 Mar 2026 12:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773233988; cv=none; b=d9TZzf7rQ8MZyPX18HJXDpQNImKYPWX3gs+BpMJEZ/8iI11S5FyQhJtiwT8J7SmmgRuJkjPMXqMNamRin8BrSzraw3FfzyhwhpWAHLJoSSmn423sNz9p45WdJTq6MqDfzOQwyZiaajqhXTQAEFEy8iGmRmdrIdAKuia1lSrKXG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773233988; c=relaxed/simple;
	bh=6iMI2XFYcGmArDxHVD1cNM01BLfDHO/WY4pBP+fXMLQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q/tUwcikpTcsHHrNFI2YjlVjMZf7OFMN1SvomY7jJJTBql9fvZJxaVb4e539PQc8NNeMWPBf7WBXIvG/BnzBYuCUdvwqxrCZXcX1weDt2z0WQMHJQPVu34UK+FkeJPXaVC88e43Hq+awh3yVWXfadqTJCWogSUGRat4H4U0MrGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=CEiZ87VU; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1773233984;
	bh=6iMI2XFYcGmArDxHVD1cNM01BLfDHO/WY4pBP+fXMLQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CEiZ87VUhKkkjxvvSxzMolbjRXZkdgJY0Rzic3nGaTRS6rUPbCgJmnQ+/+MVDz77B
	 T0VB914Hs6kRIOMVG/+6qkbqwiEQ6Ju+JDASONipQYTCXd3FloBmK2xVggCqy7Xgzr
	 wkmrvsN0vaq/eTWXkiLVV77iXHXn2bYLd9icP6MQ=
Date: Wed, 11 Mar 2026 13:59:44 +0100
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Eric Biggers <ebiggers@kernel.org>
Cc: Nathan Chancellor <nathan@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
	Sami Tolvanen <samitolvanen@google.com>, Daniel Gomez <da.gomez@samsung.com>, 
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Jonathan Corbet <corbet@lwn.net>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, Naveen N Rao <naveen@kernel.org>, 
	Mimi Zohar <zohar@linux.ibm.com>, Roberto Sassu <roberto.sassu@huawei.com>, 
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, Eric Snowberg <eric.snowberg@oracle.com>, 
	Nicolas Schier <nicolas.schier@linux.dev>, Daniel Gomez <da.gomez@kernel.org>, 
	Aaron Tomlin <atomlin@atomlin.com>, "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
	Nicolas Schier <nsc@kernel.org>, Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>, 
	Xiu Jianfeng <xiujianfeng@huawei.com>, Fabian =?utf-8?Q?Gr=C3=BCnbichler?= <f.gruenbichler@proxmox.com>, 
	Arnout Engelen <arnout@bzzt.net>, Mattia Rizzolo <mattia@mapreri.org>, 
	kpcyrd <kpcyrd@archlinux.org>, Christian Heusel <christian@heusel.eu>, 
	=?utf-8?B?Q8OianU=?= Mihai-Drosi <mcaju95@gmail.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, 
	linux-modules@vger.kernel.org, linux-security-module@vger.kernel.org, linux-doc@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-integrity@vger.kernel.org
Subject: Re: [PATCH v4 09/17] module: Make module loading policy usable
 without MODULE_SIG
Message-ID: <2f702140-32cf-40aa-80fb-3650145a2adf@t-8ch.de>
References: <20260113-module-hashes-v4-0-0b932db9b56b@weissschuh.net>
 <20260113-module-hashes-v4-9-0b932db9b56b@weissschuh.net>
 <20260310220146.GE120274@quark>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260310220146.GE120274@quark>
X-Rspamd-Queue-Id: 3D09A264090
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[weissschuh.net,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[weissschuh.net:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8975-lists,linux-integrity=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[41];
	FREEMAIL_CC(0.00)[kernel.org,arndb.de,suse.com,google.com,samsung.com,paul-moore.com,namei.org,hallyn.com,lwn.net,linux.ibm.com,ellerman.id.au,gmail.com,huawei.com,oracle.com,linux.dev,atomlin.com,oss.cyber.gouv.fr,proxmox.com,bzzt.net,mapreri.org,archlinux.org,heusel.eu,linutronix.de,vger.kernel.org,lists.ozlabs.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linux@weissschuh.net,linux-integrity@vger.kernel.org];
	DKIM_TRACE(0.00)[weissschuh.net:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-integrity];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,weissschuh.net:dkim,weissschuh.net:email,t-8ch.de:mid]
X-Rspamd-Action: no action

On 2026-03-10 15:01:46-0700, Eric Biggers wrote:
> On Tue, Jan 13, 2026 at 01:28:53PM +0100, Thomas Weißschuh wrote:
> > The loading policy functionality will also be used by the hash-based
> > module validation. Split it out from CONFIG_MODULE_SIG so it is usable
> > by both.
> > 
> > Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
> > ---
> >  include/linux/module.h  |  8 ++++----
> >  kernel/module/Kconfig   |  5 ++++-
> >  kernel/module/main.c    | 26 +++++++++++++++++++++++++-
> >  kernel/module/signing.c | 21 ---------------------
> >  4 files changed, 33 insertions(+), 27 deletions(-)
> > 
> > diff --git a/include/linux/module.h b/include/linux/module.h
> > index f288ca5cd95b..f9601cba47cd 100644
> > --- a/include/linux/module.h
> > +++ b/include/linux/module.h
> > @@ -444,7 +444,7 @@ struct module {
> >  	const u32 *gpl_crcs;
> >  	bool using_gplonly_symbols;
> >  
> > -#ifdef CONFIG_MODULE_SIG
> > +#ifdef CONFIG_MODULE_SIG_POLICY
> >  	/* Signature was verified. */
> >  	bool sig_ok;
> >  #endif
> [...]
> > +config MODULE_SIG_POLICY
> > +	def_bool MODULE_SIG
> 
> Maybe MODULE_AUTH_POLICY?  Hash-based module authentication does not use
> signatures.
> 
> This issue appears elsewhere in the code too.  There are lots of places
> that still refer to module signatures or "sigs", when really module
> authentication is meant.
> 
> I'm not sure how far you want to go with the renaming, but it's
> something to think about.  It's confusing to use the term "signature" to
> mean something that is not a signature.

Ack. "authentication" is much better, I'll use that.


Thomas

