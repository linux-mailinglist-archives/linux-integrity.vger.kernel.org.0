Return-Path: <linux-integrity+bounces-8971-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CloqD+3CsGlwmwIAu9opvQ
	(envelope-from <linux-integrity+bounces-8971-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Wed, 11 Mar 2026 02:18:37 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CA88A25A4C9
	for <lists+linux-integrity@lfdr.de>; Wed, 11 Mar 2026 02:18:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 297883052628
	for <lists+linux-integrity@lfdr.de>; Wed, 11 Mar 2026 01:18:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E4B532D45B;
	Wed, 11 Mar 2026 01:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rNElMcZ/"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 060F123EAB2;
	Wed, 11 Mar 2026 01:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773191912; cv=none; b=aQyI+uQ1IdWoIvXgh6k13glNR2Ard7EsPppG7cwZzgb3Vs7f++VaPdjPqQy4NtUgwQ/ip5Lfps9JNkgyj2T8P4QR54VU3WYCWpKXs0o1iiesiOfk7ysdTo3l9++6z75erhJsBNidzcbrjuZM7JGNzarQwKJFiQ+bC1+eyQHAeCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773191912; c=relaxed/simple;
	bh=3MN5J7gHtT0iB6q2hgPDZbQjxnI7iGXFyfIUNXZZ6RE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YyZKuo+wkwTW6d73zxGVR/PpmvWswd9InpeZA95HQ0juxOYReiUBP6S2XFdAqMHc6F5s8bVnX1DMFyVjmjMmrlc72Xme/2seTRUp3kiRmGB1xGW+G1uUIF2llCWbYVJYDbaBjR5n9EVHMBnO8w7fSIXARY5Xj0UCu/KskDRiiIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rNElMcZ/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F8A1C2BC87;
	Wed, 11 Mar 2026 01:18:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773191911;
	bh=3MN5J7gHtT0iB6q2hgPDZbQjxnI7iGXFyfIUNXZZ6RE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rNElMcZ/oiqPMT/syzmk66cskejh79Cstrn6kGqi34MlnfQgHH3oXRf/b6pp8t3cr
	 eQZBKlG0YUGoy6qvmNbm9VSkZGe89hTvf9S3KYoOuY87OOonsgjldShGI0h9JswIlT
	 kIOBDzzz/9diVIPAtmu4HqB2KW3ucNm2B01I2HzMecC5r//hLXyMPoEUZgtUpWOt2j
	 KXJZwBeOS1svS+9hOO3uappOtHNYbprQqULxT4smEtsN26/95gWugNwpPQ2af8mWew
	 HQDisRYaMYMTxu22UqX8vhhY8Jz4kxSYTeCzDitiCkuKPat1c3I4xcTuhQyrmL0xyi
	 Kp8gn9th2s7Mg==
Date: Tue, 10 Mar 2026 18:18:28 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Petr Pavlu <petr.pavlu@suse.com>
Cc: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
	Nathan Chancellor <nathan@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>, Luis Chamberlain <mcgrof@kernel.org>,
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
Message-ID: <20260311011828.GB212983@quark>
References: <20260113-module-hashes-v4-0-0b932db9b56b@weissschuh.net>
 <20260113-module-hashes-v4-15-0b932db9b56b@weissschuh.net>
 <fab2af64-e396-45f9-8876-feff4002e04b@suse.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fab2af64-e396-45f9-8876-feff4002e04b@suse.com>
X-Rspamd-Queue-Id: CA88A25A4C9
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
	TAGGED_FROM(0.00)[bounces-8971-lists,linux-integrity=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[41];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[weissschuh.net,kernel.org,arndb.de,google.com,samsung.com,paul-moore.com,namei.org,hallyn.com,lwn.net,linux.ibm.com,ellerman.id.au,gmail.com,huawei.com,oracle.com,linux.dev,atomlin.com,oss.cyber.gouv.fr,proxmox.com,bzzt.net,mapreri.org,archlinux.org,heusel.eu,linutronix.de,vger.kernel.org,lists.ozlabs.org];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Tue, Feb 03, 2026 at 01:19:20PM +0100, Petr Pavlu wrote:
> > +static unsigned int get_pow2(unsigned int val)
> > +{
> > +	return 31 - __builtin_clz(val);
> > +}
> > +
> > +static unsigned int roundup_pow2(unsigned int val)
> > +{
> > +	return 1 << (get_pow2(val - 1) + 1);
> > +}
> > +
> > +static unsigned int log2_roundup(unsigned int val)
> > +{
> > +	return get_pow2(roundup_pow2(val));
> > +}
> 
> In the edge case when the kernel is built with only one module, the code
> calls log2_roundup(1) -> roundup_pow2(1) -> get_pow2(0) ->
> __builtin_clz(0). The return value of __builtin_clz() is undefined if
> the input is zero.

A suggestion:

        static unsigned int log2_roundup(unsigned int val)
        {
                if (val <= 1)
                        return 0;
                return 32 - __builtin_clz(val - 1);
        }

- Eric

