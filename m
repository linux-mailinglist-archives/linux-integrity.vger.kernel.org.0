Return-Path: <linux-integrity+bounces-8403-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iFw2MIHtgGleCAMAu9opvQ
	(envelope-from <linux-integrity+bounces-8403-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Mon, 02 Feb 2026 19:31:29 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AC58D031D
	for <lists+linux-integrity@lfdr.de>; Mon, 02 Feb 2026 19:31:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AFACC300C031
	for <lists+linux-integrity@lfdr.de>; Mon,  2 Feb 2026 18:31:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC6F72E92D2;
	Mon,  2 Feb 2026 18:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jQdWElel"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5F031F94F;
	Mon,  2 Feb 2026 18:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770057059; cv=none; b=XbVMF7IGpsoFuXWx3kMatg2+L1HLC25HNYowl2cpPrrev8tAwC2Np+M0yHkrsGxwMBeFE2hNIpccisJIRl5K8biIlRmYpy7pkoraVIaI7uiorw+OPvBo/Q0wQsw9e0yUD6JkT4tjVo7Vs9Kut5SavmHKb3N3X6x3byH70vgZfi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770057059; c=relaxed/simple;
	bh=ba2/NLTkOhnfOM6fqK9CoYWWEtF7emjNfwqBUh4yBbA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WlZvBDx8HYpi8XkBOMm5jmOygl9VuQ3Jy1jnN8kSX1BII/Kq1xAAmyMCrDQz2ZZCeW+S9QpfaIcLtik81ABYW4Ob7+JGFDo30c6EUC38InJIxsBvnXI3yDCgj4YfyIctCEgL0ugRjatdgXB1q+yHaK6k9rHudaR0B/ZrpsFu5yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jQdWElel; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3D3BC116C6;
	Mon,  2 Feb 2026 18:30:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770057059;
	bh=ba2/NLTkOhnfOM6fqK9CoYWWEtF7emjNfwqBUh4yBbA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jQdWElelgsDi9Lay4j/hwJ03E13C+lgoT6EceyxP+5cYY6I6m7jHMoK+qOMfJiv86
	 yQ3WpDDf9fgEhNukaSob3J6pFaTB/P4DCFJjyfM4Qjn/hK2D2RuxK//YXd1Is1nThp
	 MMNKlgqT+Agvdn6PA3w3ZXA54il9ecGPcwQbfeIQVC1mCBJEN7XENg1MdrliWyx+hh
	 BKgNv5CkNux1m/VqvUXQanwkHaGSibh10BbGrK26dHOS6DSO2GQpycuZCHpDaFERCb
	 c/7E10hAvVtHrmBU33vel+eacqEbofbWdplYFbOlibC/SQaxmPqR8fKJZItMGwz9/Y
	 /D38Ipq7pYTIQ==
Date: Mon, 2 Feb 2026 10:30:55 -0800
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
Message-ID: <20260202183055.GB2036@quark>
References: <20260201201218.GA15755@quark>
 <20260131073636.65494-1-mcaju95@gmail.com>
 <20260113-module-hashes-v4-0-0b932db9b56b@weissschuh.net>
 <2316630.1769965788@warthog.procyon.org.uk>
 <2339369.1770024079@warthog.procyon.org.uk>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2339369.1770024079@warthog.procyon.org.uk>
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
	TAGGED_FROM(0.00)[bounces-8403-lists,linux-integrity=lfdr.de];
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
X-Rspamd-Queue-Id: 6AC58D031D
X-Rspamd-Action: no action

On Mon, Feb 02, 2026 at 09:21:19AM +0000, David Howells wrote:
> Eric Biggers <ebiggers@kernel.org> wrote:
> 
> > With that being the case, why is there still effort being put into
> > adding more features to module signing?  I would think efforts should be
> > focused on hash-based module authentication, i.e. this patchset.
> 
> Because it's not just signing of modules

Module signing is indeed about the signing of modules.

> and it's not just modules built with the kernel.

Could you give more details on this use case and why it needs
signatures, as opposed to e.g. loading an additional Merkle tree root
into the kernel to add to the set of allowed modules?

> Also a hash table just of module hashes built into the core
> kernel image will increase the size of the kernel by around a third of a meg
> (on Fedora 43 and assuming SHA512) with uncompressible data.

This patchset already optimizes it to use Merkle tree proofs instead.
While I'm a bit skeptical of the complexity myself (and distros
shouldn't be shipping such an excessively large number of modules in the
first place), if it's indeed needed it's already been solved.  It's
still much simpler than the PKCS#7 signature mess.

- Eric

