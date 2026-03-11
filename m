Return-Path: <linux-integrity+bounces-8980-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +CQpI0HbsWlPFwAAu9opvQ
	(envelope-from <linux-integrity+bounces-8980-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Wed, 11 Mar 2026 22:14:41 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E69C526A50E
	for <lists+linux-integrity@lfdr.de>; Wed, 11 Mar 2026 22:14:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DD061306779E
	for <lists+linux-integrity@lfdr.de>; Wed, 11 Mar 2026 21:14:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE65B35DA46;
	Wed, 11 Mar 2026 21:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nB1ceOIT"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9943231F9AB;
	Wed, 11 Mar 2026 21:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773263677; cv=none; b=ruTruuBqqZwORMt6erWJEAqBJ/GQbbmkTE/W9A3JxvbQ1D8F/l+BsplEKzP4IbsMYA51PKQV+PkM5tdj3lJKQKjARJa5X7Jk22TmoXod028VCrwhw5kk5BYrzmyyaadg0KL4abx2BhkZqcwhlvdhDmxgu/39FC/1EHCr7D7E/cQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773263677; c=relaxed/simple;
	bh=4AK1rqDz6/A4qjK/w9x6JibTYdqI2D5USa9Uljlor+U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G8Ba+jORxSVzx09M0OAT2/hugqsjaGtZXcbsQvktFn1MG4d1e6XYyP/pMxeq6LPHyU6x0IzprbFX6WZaf7ACKc0jvpzCy+iy0+XnPnCiANChwwp+I2nt06ai4GIQB0jjdGNu/fdhavmooleb3IiBKVw37puQ31G63V8su6bv7ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nB1ceOIT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB722C4CEF7;
	Wed, 11 Mar 2026 21:14:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773263677;
	bh=4AK1rqDz6/A4qjK/w9x6JibTYdqI2D5USa9Uljlor+U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nB1ceOIToPCiG2Ga6fYFvAKYgRMq4rBLUcUJz61ILzyuOdXns1FvKE63ZPdgZQHZl
	 Sb4nNTfsbw0QQI5n6wXKZka0cIrk//AuTKoo0ISRoDGLOBcwr8YHsLLIUfXs3ewVur
	 Y//Sw9zR3uoc7l0O5LZdS/vroMKyuP4eog+uvpPQG9u86rx9FDtkb5kBULGBJiQpKA
	 ykMX0LdNVLH7xwVNGKzNvHSeT8rR69Tat3JUo29pWbE2YUJJsafK9N2xB5JCRpAIUo
	 okDFx5h1iJaRVeUidyBXYGIr+WO3tVsGNN7BB1kj1hqBJl5sHNlsdHbQV7Px/yDwRA
	 t4r5txKCfn75g==
Date: Wed, 11 Mar 2026 21:14:34 +0000
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
Subject: Re: [PATCH v4 15/17] module: Introduce hash-based integrity checking
Message-ID: <20260311211434.GA4173404@google.com>
References: <20260113-module-hashes-v4-0-0b932db9b56b@weissschuh.net>
 <20260113-module-hashes-v4-15-0b932db9b56b@weissschuh.net>
 <20260311011218.GA212983@quark>
 <5726fc65-7d24-4353-b341-81b785f2575c@t-8ch.de>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5726fc65-7d24-4353-b341-81b785f2575c@t-8ch.de>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8980-lists,linux-integrity=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,arndb.de,suse.com,google.com,samsung.com,paul-moore.com,namei.org,hallyn.com,lwn.net,linux.ibm.com,ellerman.id.au,gmail.com,huawei.com,oracle.com,linux.dev,atomlin.com,oss.cyber.gouv.fr,proxmox.com,bzzt.net,mapreri.org,archlinux.org,heusel.eu,linutronix.de,vger.kernel.org,lists.ozlabs.org];
	RCPT_COUNT_TWELVE(0.00)[41];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ebiggers@kernel.org,linux-integrity@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-integrity];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E69C526A50E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Mar 11, 2026 at 02:19:02PM +0100, Thomas Weißschuh wrote:
> > > diff --git a/include/linux/module_signature.h b/include/linux/module_signature.h
> > > index a45ce3b24403..3b510651830d 100644
> > > --- a/include/linux/module_signature.h
> > > +++ b/include/linux/module_signature.h
> > > @@ -18,6 +18,7 @@ enum pkey_id_type {
> > >  	PKEY_ID_PGP,		/* OpenPGP generated key ID */
> > >  	PKEY_ID_X509,		/* X.509 arbitrary subjectKeyIdentifier */
> > >  	PKEY_ID_PKCS7,		/* Signature in PKCS#7 message */
> > > +	PKEY_ID_MERKLE,		/* Merkle proof for modules */
> > 
> > I recommend making the hash algorithm explicit:
> > 
> >         PKEY_ID_MERKLE_SHA256,	/* SHA-256 merkle proof for modules */
> > 
> > While I wouldn't encourage the addition of another hash algorithm
> > (specifying one good algorithm for now is absolutely the right choice),
> > if someone ever does need to add another one, we'd want them to be
> > guided to simply introduce a new value of this enum rather than hack it
> > in some other way.
> 
> The idea here was that this will only ever be used for module built as
> part of the kernel build. So the actual implementation could change freely
> without affecting anything.
> 
> But I don't have hard feelings about it.

Ah, okay.  That's even better then: if someone adds another algorithm it
would simply be a kconfig option.

It seems 'struct module_signature' itself is intended to be a stable
ABI, though.  So I think there's an opportunity for confusion here.  It
might be worth leaving a note somewhere that the format of the
PKEY_ID_MERKLE portion of the struct does not need to be kept stable and
can freely change in each kernel build.

- Eric

