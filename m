Return-Path: <linux-integrity+bounces-9242-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cA7mDlzx5WnCpQEAu9opvQ
	(envelope-from <linux-integrity+bounces-9242-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Mon, 20 Apr 2026 11:26:52 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A8537428D3C
	for <lists+linux-integrity@lfdr.de>; Mon, 20 Apr 2026 11:26:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8938E302AF22
	for <lists+linux-integrity@lfdr.de>; Mon, 20 Apr 2026 09:25:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1645438C40C;
	Mon, 20 Apr 2026 09:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="ALpasPjh"
X-Original-To: linux-integrity@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B4E53876DF;
	Mon, 20 Apr 2026 09:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776677137; cv=none; b=BkFD+FZNvIYlRZCL4ENa5f9PVLgvi/GKYs6kRWAkgaUy4nmGiiIJq1AYhLTrfThWAv8GAyiLjnTgAu6ida03YTqInQSHhMo+yNwmg+tiYzPhUD4SGw3EuHFyEHX7xnZpvMYIXeXLxI/+vw1aYZMPpphByyR20HH4yanJ3xKESe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776677137; c=relaxed/simple;
	bh=5ZWOZ1Awo1Bodvdr+l3B4AZiQ8qH26M35oYmXaAHUv0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=npuT0b6Mw54kNdbFTIk+MEdtlqA8rHQ94GaA3q4gvLLJOM+ugjhxxmghTuG6v0s+wDrXRu1HiwdovVDCw22xtsjwKQUB++Yg0vuZYyuzpKGkebBYDprWMIMtryYTpH0kApHY2Lr3FlOJiwUpx+jq8y3sqjWVVlW8u18QqcmAACQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=ALpasPjh; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 379641516;
	Mon, 20 Apr 2026 02:25:29 -0700 (PDT)
Received: from e129823.arm.com (e129823.arm.com [10.1.197.6])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2E7313F99C;
	Mon, 20 Apr 2026 02:25:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1776677134; bh=5ZWOZ1Awo1Bodvdr+l3B4AZiQ8qH26M35oYmXaAHUv0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ALpasPjhjV0gqvchFfs1EAe5rRLULKlsXeKfj1ATfwQzp6WzWZBQ2aDCGEfGSUc/S
	 gfOkngkAPTDcdZXjxUJ+xg2Mkt9V6Mr9y4V/XHG8VDq1z2SX3vxMXhrE/ivNyQ/Xje
	 TfHXgMa5noXysyjM7r2CEjXb2pGzRzI4e0MVq8CQ=
Date: Mon, 20 Apr 2026 10:25:29 +0100
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: Will Deacon <will@kernel.org>
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
Message-ID: <aeXxCe4hdizdQbFD@e129823.arm.com>
References: <20260417175759.3191279-1-yeoreum.yun@arm.com>
 <20260417175759.3191279-5-yeoreum.yun@arm.com>
 <87se8sbozv.wl-maz@kernel.org>
 <aeNeNjfO7i128TIP@e129823.arm.com>
 <87pl3vb5bm.wl-maz@kernel.org>
 <aeS4rAeVQ0yJIPYw@e129823.arm.com>
 <aeXp7WSqpXNytNPG@willie-the-truck>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aeXp7WSqpXNytNPG@willie-the-truck>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[arm.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[arm.com:s=foss];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,lists.infradead.org,lists.linux.dev,paul-moore.com,namei.org,hallyn.com,linux.ibm.com,huawei.com,gmail.com,oracle.com,gmx.de,ziepe.ca,arm.com];
	TAGGED_FROM(0.00)[bounces-9242-lists,linux-integrity=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[arm.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yeoreum.yun@arm.com,linux-integrity@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-integrity];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,arm.com:dkim,arm.com:email]
X-Rspamd-Queue-Id: A8537428D3C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Will,

> On Sun, Apr 19, 2026 at 12:12:44PM +0100, Yeoreum Yun wrote:
> > Hi Marc,
> >
> > > On Sat, 18 Apr 2026 11:34:30 +0100,
> > > Yeoreum Yun <yeoreum.yun@arm.com> wrote:
> > > >
> > > > > > @@ -2035,6 +2037,16 @@ static int __init ffa_init(void)
> > > > > >  	u32 buf_sz;
> > > > > >  	size_t rxtx_bufsz = SZ_4K;
> > > > > >
> > > > > > +	/*
> > > > > > +	 * When pKVM is enabled, the FF-A driver must be initialized
> > > > > > +	 * after pKVM initialization. Otherwise, pKVM cannot negotiate
> > > > > > +	 * the FF-A version or obtain RX/TX buffer information,
> > > > > > +	 * which leads to failures in FF-A calls.
> > > > > > +	 */
> > > > > > +	if (IS_ENABLED(CONFIG_KVM) && is_protected_kvm_enabled() &&
> > > > > > +	    !is_kvm_arm_initialised())
> > > > > > +		return -EPROBE_DEFER;
> > > > > > +
> > > > >
> > > > > That's still fundamentally wrong: pkvm is not ready until
> > > > > finalize_pkvm() has finished, and that's not indicated by
> > > > > is_kvm_arm_initialised().
> > > >
> > > > Thanks. I miss the TSC bit set in here.
> > >
> > > That's the least of the problems. None of the infrastructure is in
> > > place at this stage...
> > >
> > > > IMHO, I'd like to make an new state check function --
> > > > is_pkvm_arm_initialised() so that ff-a driver to know whether
> > > > pkvm is initialised.
> > >
> > > Doesn't sound great, TBH.
> > >
> > > > or any other suggestion?
> > >
> > > Instead of adding more esoteric predicates, I'd rather you build on an
> > > existing infrastructure. You have a dependency on KVM, use something
> > > that is designed to enforce dependencies. Device links spring to mind
> > > as something designed for that.
> > >
> > > Can you look into enabling this for KVM? If that's possible, then it
> > > should be easy enough to delay the actual KVM registration after pKVM
> > > is finalised.
> >
> > or what about some event notifier? Just like:
>
> This seems a bit over-engineered to me. Why don't you just split the
> FF-A initialisation into two steps: an early part which does the version
> negotiation and then a later part which can fit in with whatever
> dependencies you have on the TPM?

Sorry, I may have misunderstood your suggestion and
I might be in missing your point.

But, The issue here is that FFA_VERSION, FFA_RXTX_MAP, and
FFA_PARTITION_INFO_GET, which are invoked from ffa_init()
as part of early initialisation, must be trapped by pKVM.

In other words, even the early part of the initialization,
including version negotiation, needs to happen after pKVM
is initialized.

Because of this dependency, simply splitting the FF-A
initialization into two phases within the driver does not
seem sufficient, as it still requires knowing when pKVM
has been initialized.

Am I missing something?

--
Sincerely,
Yeoreum Yun

