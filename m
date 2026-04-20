Return-Path: <linux-integrity+bounces-9241-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mDm1D/Hq5WnxpAEAu9opvQ
	(envelope-from <linux-integrity+bounces-9241-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Mon, 20 Apr 2026 10:59:29 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DBF16428977
	for <lists+linux-integrity@lfdr.de>; Mon, 20 Apr 2026 10:59:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AF7EC304A9E7
	for <lists+linux-integrity@lfdr.de>; Mon, 20 Apr 2026 08:55:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E04B038B7D5;
	Mon, 20 Apr 2026 08:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aMYjgzS6"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6A6B388393;
	Mon, 20 Apr 2026 08:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776675316; cv=none; b=qPCmrlOl5DWKkshQPmk1sIpXjorjfo10RZXFKlRMHgedpKsASE+aNGrVfx/QXTTMGkz/2+KChdfLPFu5RU3gxxLbuBdHjJUdLxfJ7wWDhSwZhaefYwd6aJyVehzVeexbh0wH8Z38os6ut3XJjgCQY9bsL9wXTqpcyyt2UnF72w4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776675316; c=relaxed/simple;
	bh=O5qEzAlW1XZCYge9c/pa7CeB6wV9ZdCNQTkECJw9vIM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k52haAFAozx/vFQ0IKcMrC9OohOKiNOqZlfpaK4S3jnhDoO3FO7b3cbfZfFoWYOAr/4XfMJ5lM/z6MGA5eB9npBWxbsi8QlLSPYS3+4xfaLmE3DLAenpQaAglMuI7uk4nXHB8uHMmWrHO9ly/7QgQwtNuJB75dmwTi4cgYCX+qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aMYjgzS6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3136CC19425;
	Mon, 20 Apr 2026 08:55:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776675316;
	bh=O5qEzAlW1XZCYge9c/pa7CeB6wV9ZdCNQTkECJw9vIM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aMYjgzS6ZqypodZLc5FGiz/NHxqDQXP5Kez4CJHNExX767+MBxlUDZlzqmsvKpWh5
	 YdhE4rJTK+WFMAWQTPYRQXXB2C0/8c1NvRLwZezaY5LP/oLF2X3qb3gXOb4o72zqoy
	 T46CAHEkGLlMZzkTu2vqLEvlB4w1evnQUZl3b9Eu6vkXVlOFRyd+NwnjuCwXhPz+Qa
	 sTWm7gYGy4AAFx7MftHJX38DTdx1xjm+Zs8f1cY85PeyBfAfCTbyAqTLFCRqUVWe2t
	 xROkg/I/FRv7jow6EHFweKn+OVy+1GN7dHDsc0OqJGM2B7YGS7i266au38JBxvDI9u
	 bbMWic9XHg+Nw==
Date: Mon, 20 Apr 2026 09:55:09 +0100
From: Will Deacon <will@kernel.org>
To: Yeoreum Yun <yeoreum.yun@arm.com>
Cc: Marc Zyngier <maz@kernel.org>, linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
	paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
	zohar@linux.ibm.com, roberto.sassu@huawei.com,
	dmitry.kasatkin@gmail.com, eric.snowberg@oracle.com,
	peterhuewe@gmx.de, jarkko@kernel.org, jgg@ziepe.ca,
	sudeep.holla@kernel.org, oupton@kernel.org, joey.gouly@arm.com,
	suzuki.poulose@arm.com, yuzenghui@huawei.com,
	catalin.marinas@arm.com
Subject: Re: [RFC PATCH 4/4] firmware: arm_ffa: check pkvm initailised when
 initailise ffa driver
Message-ID: <aeXp7WSqpXNytNPG@willie-the-truck>
References: <20260417175759.3191279-1-yeoreum.yun@arm.com>
 <20260417175759.3191279-5-yeoreum.yun@arm.com>
 <87se8sbozv.wl-maz@kernel.org>
 <aeNeNjfO7i128TIP@e129823.arm.com>
 <87pl3vb5bm.wl-maz@kernel.org>
 <aeS4rAeVQ0yJIPYw@e129823.arm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aeS4rAeVQ0yJIPYw@e129823.arm.com>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9241-lists,linux-integrity=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,lists.infradead.org,lists.linux.dev,paul-moore.com,namei.org,hallyn.com,linux.ibm.com,huawei.com,gmail.com,oracle.com,gmx.de,ziepe.ca,arm.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[will@kernel.org,linux-integrity@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-integrity];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,arm.com:email]
X-Rspamd-Queue-Id: DBF16428977
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, Apr 19, 2026 at 12:12:44PM +0100, Yeoreum Yun wrote:
> Hi Marc,
> 
> > On Sat, 18 Apr 2026 11:34:30 +0100,
> > Yeoreum Yun <yeoreum.yun@arm.com> wrote:
> > >
> > > > > @@ -2035,6 +2037,16 @@ static int __init ffa_init(void)
> > > > >  	u32 buf_sz;
> > > > >  	size_t rxtx_bufsz = SZ_4K;
> > > > >
> > > > > +	/*
> > > > > +	 * When pKVM is enabled, the FF-A driver must be initialized
> > > > > +	 * after pKVM initialization. Otherwise, pKVM cannot negotiate
> > > > > +	 * the FF-A version or obtain RX/TX buffer information,
> > > > > +	 * which leads to failures in FF-A calls.
> > > > > +	 */
> > > > > +	if (IS_ENABLED(CONFIG_KVM) && is_protected_kvm_enabled() &&
> > > > > +	    !is_kvm_arm_initialised())
> > > > > +		return -EPROBE_DEFER;
> > > > > +
> > > >
> > > > That's still fundamentally wrong: pkvm is not ready until
> > > > finalize_pkvm() has finished, and that's not indicated by
> > > > is_kvm_arm_initialised().
> > >
> > > Thanks. I miss the TSC bit set in here.
> >
> > That's the least of the problems. None of the infrastructure is in
> > place at this stage...
> >
> > > IMHO, I'd like to make an new state check function --
> > > is_pkvm_arm_initialised() so that ff-a driver to know whether
> > > pkvm is initialised.
> >
> > Doesn't sound great, TBH.
> >
> > > or any other suggestion?
> >
> > Instead of adding more esoteric predicates, I'd rather you build on an
> > existing infrastructure. You have a dependency on KVM, use something
> > that is designed to enforce dependencies. Device links spring to mind
> > as something designed for that.
> >
> > Can you look into enabling this for KVM? If that's possible, then it
> > should be easy enough to delay the actual KVM registration after pKVM
> > is finalised.
> 
> or what about some event notifier? Just like:

This seems a bit over-engineered to me. Why don't you just split the
FF-A initialisation into two steps: an early part which does the version
negotiation and then a later part which can fit in with whatever
dependencies you have on the TPM?

Will

