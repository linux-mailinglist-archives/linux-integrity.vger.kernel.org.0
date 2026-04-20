Return-Path: <linux-integrity+bounces-9244-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sP0WHTwD5mmBqQEAu9opvQ
	(envelope-from <linux-integrity+bounces-9244-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Mon, 20 Apr 2026 12:43:08 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 182D44296E9
	for <lists+linux-integrity@lfdr.de>; Mon, 20 Apr 2026 12:43:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2E5A0300D37A
	for <lists+linux-integrity@lfdr.de>; Mon, 20 Apr 2026 10:43:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29359388E60;
	Mon, 20 Apr 2026 10:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eauCaia5"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03A93352F88;
	Mon, 20 Apr 2026 10:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776681785; cv=none; b=U45R3dSLUxVEuEpsriojmUa9G6tn/76yz1GQXM31VVJWAAOh5dYgdR7p/vNR2Aiu/aesxs/71C2ALOZ4mFkq2E+f6jbzdNAzv545c9NwZQczHpWe0xCvJ0miczienDZFTa97KJZbKMIt+v5pbC/vvEdOa9oKlszN1rjBLwYQDDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776681785; c=relaxed/simple;
	bh=43OQtBHiVkQsJoic6eZI0ym41gkflG3en7sho3mS/20=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jPO4ZRwRKEU/BnYlh+PyDy1Q67MOtFcIERvcclpViQfVHuGM7jsVe0lgpQQiciq6z9CWP6DR9LoAjMCIOHimN2oBfyFke+IVu37dihfZ4PxlrABa5q0pZjBaK6feRg9P0J/ue7zqAglKplogFUM4xRX2VMxQ+BRb+xFSyAtF95g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eauCaia5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45AB8C2BCB6;
	Mon, 20 Apr 2026 10:43:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776681784;
	bh=43OQtBHiVkQsJoic6eZI0ym41gkflG3en7sho3mS/20=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eauCaia5/Nr2OPkY+4AmlYEHWvbrTWhhvEBDuGYqc7NKZKvX03liCJyAx1blwZfKq
	 IvcJJEX3RpNZvWWKfPzdUD4GSWVRTjXuSqT+XlSdj0mlyQ7cfrBqcTHqrHKuuxVBgh
	 knzLPcoWvt0p8hxz4SJDXRoIk9GW+VtT259VBvmAIilXGJMu6/l50CM4eC/o9E57vn
	 0QXsskS8zWoJdJJDwZC2WSU9lve+W/uKAOchydEBm+3iTt1UqkDy1jdJN94KOsW2RT
	 N5u+IphGQ6physppwYDS4MVQq0kQWEX7buddrqkhgK034fzzgirgwNvLoRLELc7DA1
	 qVAmvcFe1TCcQ==
Date: Mon, 20 Apr 2026 11:42:56 +0100
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
	catalin.marinas@arm.com, sebastianene@google.com
Subject: Re: [RFC PATCH 4/4] firmware: arm_ffa: check pkvm initailised when
 initailise ffa driver
Message-ID: <aeYDMEgWdt8F9jWb@willie-the-truck>
References: <20260417175759.3191279-1-yeoreum.yun@arm.com>
 <20260417175759.3191279-5-yeoreum.yun@arm.com>
 <87se8sbozv.wl-maz@kernel.org>
 <aeNeNjfO7i128TIP@e129823.arm.com>
 <87pl3vb5bm.wl-maz@kernel.org>
 <aeS4rAeVQ0yJIPYw@e129823.arm.com>
 <aeXp7WSqpXNytNPG@willie-the-truck>
 <aeXxCe4hdizdQbFD@e129823.arm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aeXxCe4hdizdQbFD@e129823.arm.com>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-9244-lists,linux-integrity=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,lists.infradead.org,lists.linux.dev,paul-moore.com,namei.org,hallyn.com,linux.ibm.com,huawei.com,gmail.com,oracle.com,gmx.de,ziepe.ca,arm.com,google.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[will@kernel.org,linux-integrity@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-integrity];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 182D44296E9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

[+Seb for the pKVM FFA bits]

On Mon, Apr 20, 2026 at 10:25:29AM +0100, Yeoreum Yun wrote:
> > On Sun, Apr 19, 2026 at 12:12:44PM +0100, Yeoreum Yun wrote:
> > > > On Sat, 18 Apr 2026 11:34:30 +0100,
> > > > Yeoreum Yun <yeoreum.yun@arm.com> wrote:
> > > > >
> > > > > > > @@ -2035,6 +2037,16 @@ static int __init ffa_init(void)
> > > > > > >  	u32 buf_sz;
> > > > > > >  	size_t rxtx_bufsz = SZ_4K;
> > > > > > >
> > > > > > > +	/*
> > > > > > > +	 * When pKVM is enabled, the FF-A driver must be initialized
> > > > > > > +	 * after pKVM initialization. Otherwise, pKVM cannot negotiate
> > > > > > > +	 * the FF-A version or obtain RX/TX buffer information,
> > > > > > > +	 * which leads to failures in FF-A calls.
> > > > > > > +	 */
> > > > > > > +	if (IS_ENABLED(CONFIG_KVM) && is_protected_kvm_enabled() &&
> > > > > > > +	    !is_kvm_arm_initialised())
> > > > > > > +		return -EPROBE_DEFER;
> > > > > > > +
> > > > > >
> > > > > > That's still fundamentally wrong: pkvm is not ready until
> > > > > > finalize_pkvm() has finished, and that's not indicated by
> > > > > > is_kvm_arm_initialised().
> > > > >
> > > > > Thanks. I miss the TSC bit set in here.
> > > >
> > > > That's the least of the problems. None of the infrastructure is in
> > > > place at this stage...
> > > >
> > > > > IMHO, I'd like to make an new state check function --
> > > > > is_pkvm_arm_initialised() so that ff-a driver to know whether
> > > > > pkvm is initialised.
> > > >
> > > > Doesn't sound great, TBH.
> > > >
> > > > > or any other suggestion?
> > > >
> > > > Instead of adding more esoteric predicates, I'd rather you build on an
> > > > existing infrastructure. You have a dependency on KVM, use something
> > > > that is designed to enforce dependencies. Device links spring to mind
> > > > as something designed for that.
> > > >
> > > > Can you look into enabling this for KVM? If that's possible, then it
> > > > should be easy enough to delay the actual KVM registration after pKVM
> > > > is finalised.
> > >
> > > or what about some event notifier? Just like:
> >
> > This seems a bit over-engineered to me. Why don't you just split the
> > FF-A initialisation into two steps: an early part which does the version
> > negotiation and then a later part which can fit in with whatever
> > dependencies you have on the TPM?
> 
> Sorry, I may have misunderstood your suggestion and
> I might be in missing your point.
> 
> But, The issue here is that FFA_VERSION, FFA_RXTX_MAP, and
> FFA_PARTITION_INFO_GET, which are invoked from ffa_init()
> as part of early initialisation, must be trapped by pKVM.
> 
> In other words, even the early part of the initialization,
> including version negotiation, needs to happen after pKVM
> is initialized.
> 
> Because of this dependency, simply splitting the FF-A
> initialization into two phases within the driver does not
> seem sufficient, as it still requires knowing when pKVM
> has been initialized.
> 
> Am I missing something?

Ah sorry, I mixed up the ordering of 'module_init' vs 'rootfs_initcall'
and thought you wanted to probe the version earlier. But then I'm still
confused because, prior to 0e0546eabcd6 ("firmware: arm_ffa: Change
initcall level of ffa_init() to rootfs_initcall"), ffa_init() was a
'device_initcall' which is still called earlier than finalize_pkvm().

Will

