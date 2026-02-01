Return-Path: <linux-integrity+bounces-8398-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iIn8Lauzf2kTwQIAu9opvQ
	(envelope-from <linux-integrity+bounces-8398-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Sun, 01 Feb 2026 21:12:27 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 57E2AC722B
	for <lists+linux-integrity@lfdr.de>; Sun, 01 Feb 2026 21:12:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8253E300679C
	for <lists+linux-integrity@lfdr.de>; Sun,  1 Feb 2026 20:12:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA780285C98;
	Sun,  1 Feb 2026 20:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fIdRv4hA"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF2593EBF3D;
	Sun,  1 Feb 2026 20:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769976741; cv=none; b=K8/eBNqSfORujjE1J59hBqZDDVtTS1TSevbQ9k6BFkRlbC8GniuGuKRkWgyvqZ7nTaU63bNpZQM5WlP5TMraC+PBlo7JtubuSikcz5leRpOhynsBqiEerZE7FLCwyrhr4b5e5R++hKnYl0DggthH2tMbGUj55JtU53hHVWt6fRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769976741; c=relaxed/simple;
	bh=P4abRiJNT2o7A1KauWPFd1QUCJK6AwkuNkuWQv1rej0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zx9Tlg40LZ+a8kzTJwkNKuyvvLGrUcq2d2mwYQtonwCTNW8kdTnLvO32gNdO9r0WjyHm+zo/+LBZ5SGOpWfzQ82GaRtYg4DYg3bC45oDvOw32tjGf1Ue/y3pg6Ca/M8mhCobWF+5YiqX4Y/C/l/xqhcomTz2Kn4Y7/Edp42ADFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fIdRv4hA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4C67C4CEF7;
	Sun,  1 Feb 2026 20:12:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769976741;
	bh=P4abRiJNT2o7A1KauWPFd1QUCJK6AwkuNkuWQv1rej0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fIdRv4hA/DqSiqBclAtFK4XfUk/ksYnebA0yhghX5vLyndIRXaysGZ5MMbgL4vwkI
	 8QvBVSpULQqoJhdyvj1t+Bug4HEuYNCYZpbs71huOoJbBE+HauLZ7LOEuhZ05cJQV/
	 94Y42B9l4Ik8l7KwDFKgbh0MP9IX/WqJ6i2FNecab++SmyJy3Bh3nn+Acqzrq+Njoe
	 CsZ/nV1JY55rWf1JPQfvoOd6i0Xj135qyfTL+vl7JOttvuSTevqqFRtknPLvL8LLVJ
	 cQaAEOaE5VWFnmDFi97q9n93wpKJXVcB/h7Fay/vhGI+7dszWX9t1U+EoJG9mhwgBV
	 dAMVUoFltx0rw==
Date: Sun, 1 Feb 2026 12:12:18 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: =?us-ascii?B?PT9VVEYtOD9xP01paGFpLURyb3NpPTIwQz1DMz1BMmp1Pz0=?= <mcaju95@gmail.com>,
	linux@weissschuh.net, arnd@arndb.de, arnout@bzzt.net,
	atomlin@atomlin.com, bigeasy@linutronix.de, chleroy@kernel.org,
	christian@heusel.eu, corbet@lwn.net, coxu@redhat.com,
	da.gomez@kernel.org, da.gomez@samsung.com,
	dmitry.kasatkin@gmail.com, eric.snowberg@oracle.com,
	f.gruenbichler@proxmox.com, jmorris@namei.org, kpcyrd@archlinux.org,
	linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-integrity@vger.kernel.org, linux-kbuild@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, lkp@intel.com, maddy@linux.ibm.com,
	mattia@mapreri.org, mcgrof@kernel.org, mpe@ellerman.id.au,
	nathan@kernel.org, naveen@kernel.org,
	nicolas.bouchinet@oss.cyber.gouv.fr, nicolas.schier@linux.dev,
	npiggin@gmail.com, nsc@kernel.org, paul@paul-moore.com,
	petr.pavlu@suse.com, roberto.sassu@huawei.com,
	samitolvanen@google.com, serge@hallyn.com, xiujianfeng@huawei.com,
	zohar@linux.ibm.com
Subject: Re: [PATCH v4 00/17] module: Introduce hash-based integrity checking
Message-ID: <20260201201218.GA15755@quark>
References: <20260131073636.65494-1-mcaju95@gmail.com>
 <20260113-module-hashes-v4-0-0b932db9b56b@weissschuh.net>
 <2316630.1769965788@warthog.procyon.org.uk>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2316630.1769965788@warthog.procyon.org.uk>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	CC_EXCESS_BASE64(1.50)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8398-lists,linux-integrity=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[44];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,weissschuh.net,arndb.de,bzzt.net,atomlin.com,linutronix.de,kernel.org,heusel.eu,lwn.net,redhat.com,samsung.com,oracle.com,proxmox.com,namei.org,archlinux.org,vger.kernel.org,lists.ozlabs.org,intel.com,linux.ibm.com,mapreri.org,ellerman.id.au,oss.cyber.gouv.fr,linux.dev,paul-moore.com,suse.com,huawei.com,google.com,hallyn.com];
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
X-Rspamd-Queue-Id: 57E2AC722B
X-Rspamd-Action: no action

On Sun, Feb 01, 2026 at 05:09:48PM +0000, David Howells wrote:
> Mihai-Drosi Câju <mcaju95@gmail.com> wrote:
> 
> > > The current signature-based module integrity checking has some drawbacks
> > in combination with reproducible builds. Either the module signing key
> > is generated at build time, which makes the build unreproducible, or a
> > static signing key is used, which precludes rebuilds by third parties
> > and makes the whole build and packaging process much more complicated.
> 
> There is another issue too: If you have a static private key that you use to
> sign modules (and probably other things), someone will likely give you a GPL
> request to get it.
> 
> One advantage of using a transient key every build and deleting it after is
> that no one has the key.
> 
> One other thing to remember: security is *meant* to get in the way.  That's
> the whole point of it.
> 
> However, IANAL.
> 
> David

It sounds like hash-based module authentication is just better, then.
If the full set of authentic modules is known at kernel build time, then
signatures are unnecessary to verify their authenticity: a list of
hashes built into the kernel image is perfectly sufficient.

(This patchset actually gets a little fancy and makes it a Merkle tree
root.  But it could be simplified to just a list of hashes.)

With that being the case, why is there still effort being put into
adding more features to module signing?  I would think efforts should be
focused on hash-based module authentication, i.e. this patchset.

- Eric

