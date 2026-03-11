Return-Path: <linux-integrity+bounces-8976-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GLVxKqJssWlVvAIAu9opvQ
	(envelope-from <linux-integrity+bounces-8976-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Wed, 11 Mar 2026 14:22:42 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B09E26462C
	for <lists+linux-integrity@lfdr.de>; Wed, 11 Mar 2026 14:22:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EC0A631B1E88
	for <lists+linux-integrity@lfdr.de>; Wed, 11 Mar 2026 13:19:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57EF030DED1;
	Wed, 11 Mar 2026 13:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="HQsb0mto"
X-Original-To: linux-integrity@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2206298CA3;
	Wed, 11 Mar 2026 13:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773235146; cv=none; b=LebxM1EtPRUiXEUQCPRUNnt8AQyDhItksg4/JBupduR7wxm782FHag5rZyN1Lh3MUCYBGiWoRl2KX4fPlyFYEeYdAG0JpIL+8PjA4T0h7Zd7CehPxDMQW9KUJt/yHePSqHXGKgtuAs28bWpxvFfAVOFncxNMwVO/AFhr+NPzU2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773235146; c=relaxed/simple;
	bh=yORSnb4FKH66tX09G1qK8g0oY/Uo2rIpyvZkEjNDm84=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R5nnth5HYYP2Hm+EDAUv+LHfZzN0uASaW/pJw+KxG6wdxYA/wfRzr2z4xESFYy8EO/Sd5dXW62CGpBS9Rnc35jgsk2q5gE7ijSzr1N521qQouONrQ1LFixXQCyUK833xq88JsbbckXcRf4dgw75xxNUvmwMi4mP6VGoUGpREX+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=HQsb0mto; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1773235142;
	bh=yORSnb4FKH66tX09G1qK8g0oY/Uo2rIpyvZkEjNDm84=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HQsb0mtoTbwEGco/L3lRbJ0WTajceIyEQmoKsZbs3ijP9DIl6uMUH7DyCJEKEf4Nm
	 owAHusHX0qnegQ4fOa4IysSRsA4AurPsIoJqlTnoeOwj3DxmUIvbEJueidEPMQxkvz
	 Uowp8NlWKsfgXCHMDcyu0Ko9Yx9jg/4i7nHbYH8o=
Date: Wed, 11 Mar 2026 14:19:02 +0100
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
Subject: Re: [PATCH v4 15/17] module: Introduce hash-based integrity checking
Message-ID: <5726fc65-7d24-4353-b341-81b785f2575c@t-8ch.de>
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
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260311011218.GA212983@quark>
X-Rspamd-Queue-Id: 4B09E26462C
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
	TAGGED_FROM(0.00)[bounces-8976-lists,linux-integrity=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[weissschuh.net:dkim,t-8ch.de:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On 2026-03-10 18:12:18-0700, Eric Biggers wrote:
> On Tue, Jan 13, 2026 at 01:28:59PM +0100, Thomas Weißschuh wrote:
> > The current signature-based module integrity checking has some drawbacks
> > in combination with reproducible builds. Either the module signing key
> > is generated at build time, which makes the build unreproducible, or a
> > static signing key is used, which precludes rebuilds by third parties
> > and makes the whole build and packaging process much more complicated.
> 
> I think this actually undersells the feature.

(...)

> So I think this is how module authentication should have been done
> originally, and I'm glad to see this is finally being fixed.

Thanks, that is nice to hear.

> > +struct module_hashes_proof {
> > +	__be32 pos;
> > +	u8 hash_sigs[][MODULE_HASHES_HASH_SIZE];
> > +} __packed;
> 
> Is the choice of big endian for consistency with struct
> module_signature?  Little endian is the usual choice in new code.

Yes, it's for consistency. But I am fine with either way. Given that
this is essentially an internal ABI, we could always change it later.

> > diff --git a/include/linux/module_signature.h b/include/linux/module_signature.h
> > index a45ce3b24403..3b510651830d 100644
> > --- a/include/linux/module_signature.h
> > +++ b/include/linux/module_signature.h
> > @@ -18,6 +18,7 @@ enum pkey_id_type {
> >  	PKEY_ID_PGP,		/* OpenPGP generated key ID */
> >  	PKEY_ID_X509,		/* X.509 arbitrary subjectKeyIdentifier */
> >  	PKEY_ID_PKCS7,		/* Signature in PKCS#7 message */
> > +	PKEY_ID_MERKLE,		/* Merkle proof for modules */
> 
> I recommend making the hash algorithm explicit:
> 
>         PKEY_ID_MERKLE_SHA256,	/* SHA-256 merkle proof for modules */
> 
> While I wouldn't encourage the addition of another hash algorithm
> (specifying one good algorithm for now is absolutely the right choice),
> if someone ever does need to add another one, we'd want them to be
> guided to simply introduce a new value of this enum rather than hack it
> in some other way.

The idea here was that this will only ever be used for module built as
part of the kernel build. So the actual implementation could change freely
without affecting anything.

But I don't have hard feelings about it.

> > +static void hash_entry(const void *left, const void *right, void *out)
> 
> Byte arrays should use u8 instead of void

Ack.

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

Ack.

>     #define MAX_HASH_SIZE 32

IMO it shouldn't even mention 'MAX', as there is only one hash
algorithm.

(...)

> > +{
> > +	fprintf(stderr,
> > +		"Usage: scripts/modules-merkle-tree <root definition>\n");
> > +	exit(2);
> 
> This should show both parameters, <root hash> <new suffix>

Ack.

> But they probably should be flipped to put the output second.

Ack.

> Though, is <new suffix> needed at all?  It looks like it doesn't
> actually affect the output.

It will be required for compatibility with INSTALL_MOD_STRIP,
two patches later. I'll move this code into the later patch.

> > +	hash_evp = EVP_get_digestbyname("sha256");
> 
> EVP_sha256()

(...)

Ack to all other remarks.


Thomas

