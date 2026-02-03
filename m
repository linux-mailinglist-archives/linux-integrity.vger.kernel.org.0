Return-Path: <linux-integrity+bounces-8424-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2Lj+FWfvgWlAMwMAu9opvQ
	(envelope-from <linux-integrity+bounces-8424-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Tue, 03 Feb 2026 13:51:51 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D9943D95FC
	for <lists+linux-integrity@lfdr.de>; Tue, 03 Feb 2026 13:51:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9A57631044E9
	for <lists+linux-integrity@lfdr.de>; Tue,  3 Feb 2026 12:44:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC86534029C;
	Tue,  3 Feb 2026 12:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="SMXk7Zio"
X-Original-To: linux-integrity@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 733A7284B2F;
	Tue,  3 Feb 2026 12:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770122648; cv=none; b=FLqIo48Jw9DVJ60JHshhYjskeBh0J0es2soX1uqA+6EvmD2sNBZ7xj8uQWpLICnQ46+1SbxE4g2+fXjl9z4Gz36Syit5xr4L0zw7ZNFbnMfIzcVAA4zyzsaGmreWzKu30eJkoUlZ476taCerMc7SAz1e91Jq1iauBSw1gF+6z6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770122648; c=relaxed/simple;
	bh=4xMbDkPtYFnbhn8oi8ogQM7HDBoaOGhwFfB7e0t3td4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cd0b3lnXsbqS7SDpcrPZJMJiNuYgagTxtUhqe8PQ+4MwSovKrJ98d2NMGogFi4qoN2/C3tgC9SyEbv7gAkZZGcyqGJyzsgAQ0p9WJGqClZaj6ApWMeak+p2mp4oI5OFbKsIB8ComIydjkYunb0/pL/NZfnjQjq8fZOuDnwaRuI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=SMXk7Zio; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1770122645;
	bh=4xMbDkPtYFnbhn8oi8ogQM7HDBoaOGhwFfB7e0t3td4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SMXk7Ziop93PtXgUUPvFJrwX+tZphLJn717cY967EJ+dn5c3ytK5Jd3akdSlt7smz
	 LjQYDD5nu7+lEc/AI7bKfPM9nyLwM7tXiMSSwvKs2nPopR1BLCJ2Cgd771dfO3qck8
	 4K58p7AUrndd8U19BhXdA2hDQ2k+wJyqNngf+7xI=
Date: Tue, 3 Feb 2026 13:44:05 +0100
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Petr Pavlu <petr.pavlu@suse.com>
Cc: Nathan Chancellor <nathan@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Luis Chamberlain <mcgrof@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
	Daniel Gomez <da.gomez@samsung.com>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	Jonathan Corbet <corbet@lwn.net>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	Naveen N Rao <naveen@kernel.org>, Mimi Zohar <zohar@linux.ibm.com>, 
	Roberto Sassu <roberto.sassu@huawei.com>, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, 
	Eric Snowberg <eric.snowberg@oracle.com>, Nicolas Schier <nicolas.schier@linux.dev>, 
	Daniel Gomez <da.gomez@kernel.org>, Aaron Tomlin <atomlin@atomlin.com>, 
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Nicolas Schier <nsc@kernel.org>, 
	Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>, Xiu Jianfeng <xiujianfeng@huawei.com>, 
	Fabian =?utf-8?Q?Gr=C3=BCnbichler?= <f.gruenbichler@proxmox.com>, Arnout Engelen <arnout@bzzt.net>, 
	Mattia Rizzolo <mattia@mapreri.org>, kpcyrd <kpcyrd@archlinux.org>, 
	Christian Heusel <christian@heusel.eu>, =?utf-8?B?Q8OianU=?= Mihai-Drosi <mcaju95@gmail.com>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arch@vger.kernel.org, linux-modules@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-doc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-integrity@vger.kernel.org
Subject: Re: [PATCH v4 13/17] module: Report signature type to users
Message-ID: <8d399298-88a6-4c89-a0ed-fed0268b6493@t-8ch.de>
References: <20260113-module-hashes-v4-0-0b932db9b56b@weissschuh.net>
 <20260113-module-hashes-v4-13-0b932db9b56b@weissschuh.net>
 <fd19f9d3-b01c-4cc8-9fd5-642350e7b36b@suse.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fd19f9d3-b01c-4cc8-9fd5-642350e7b36b@suse.com>
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
	TAGGED_FROM(0.00)[bounces-8424-lists,linux-integrity=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[40];
	FREEMAIL_CC(0.00)[kernel.org,arndb.de,google.com,samsung.com,paul-moore.com,namei.org,hallyn.com,lwn.net,linux.ibm.com,ellerman.id.au,gmail.com,huawei.com,oracle.com,linux.dev,atomlin.com,oss.cyber.gouv.fr,proxmox.com,bzzt.net,mapreri.org,archlinux.org,heusel.eu,linutronix.de,vger.kernel.org,lists.ozlabs.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linux@weissschuh.net,linux-integrity@vger.kernel.org];
	DKIM_TRACE(0.00)[weissschuh.net:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-integrity];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[t-8ch.de:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,weissschuh.net:email,weissschuh.net:dkim]
X-Rspamd-Queue-Id: D9943D95FC
X-Rspamd-Action: no action

On 2026-01-29 15:44:31+0100, Petr Pavlu wrote:
> On 1/13/26 1:28 PM, Thomas Weißschuh wrote:
> > The upcoming CONFIG_MODULE_HASHES will introduce a signature type.
> > This needs to be handled by callers differently than PKCS7 signatures.
> > 
> > Report the signature type to the caller and let them verify it.
> > 
> > Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
> > ---
> > [...]
> > diff --git a/kernel/module/main.c b/kernel/module/main.c
> > index d65bc300a78c..2a28a0ece809 100644
> > --- a/kernel/module/main.c
> > +++ b/kernel/module/main.c
> > @@ -3348,19 +3348,24 @@ static int module_integrity_check(struct load_info *info, int flags)
> >  {
> >  	bool mangled_module = flags & (MODULE_INIT_IGNORE_MODVERSIONS |
> >  				       MODULE_INIT_IGNORE_VERMAGIC);
> > +	enum pkey_id_type sig_type;
> >  	size_t sig_len;
> >  	const u8 *sig;
> >  	int err = 0;
> >  
> >  	if (IS_ENABLED(CONFIG_MODULE_SIG_POLICY)) {
> >  		err = mod_split_sig(info->hdr, &info->len, mangled_module,
> > -				    &sig_len, &sig, "module");
> > +				    &sig_type, &sig_len, &sig, "module");
> >  		if (err)
> >  			return err;
> >  	}
> >  
> > -	if (IS_ENABLED(CONFIG_MODULE_SIG))
> > +	if (IS_ENABLED(CONFIG_MODULE_SIG) && sig_type == PKEY_ID_PKCS7) {
> >  		err = module_sig_check(info, sig, sig_len);
> > +	} else {
> > +		pr_err("module: not signed with expected PKCS#7 message\n");
> > +		err = -ENOPKG;
> > +	}
> 
> The new else branch means that if the user chooses not to configure any
> module integrity policy, they will no longer be able to load any
> modules. I think this entire if-else part should be moved under the
> IS_ENABLED(CONFIG_MODULE_SIG_POLICY) block above, as I'm mentioning on
> patch #12.

Ack.

