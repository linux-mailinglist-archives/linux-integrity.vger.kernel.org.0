Return-Path: <linux-integrity+bounces-9462-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oOMXGZ/u+mlGUgMAu9opvQ
	(envelope-from <linux-integrity+bounces-9462-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Wed, 06 May 2026 09:32:47 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DEA84D743A
	for <lists+linux-integrity@lfdr.de>; Wed, 06 May 2026 09:32:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8F85730125CC
	for <lists+linux-integrity@lfdr.de>; Wed,  6 May 2026 07:27:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7212E37C0FD;
	Wed,  6 May 2026 07:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m3N3qBT6"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E2B837C0F5;
	Wed,  6 May 2026 07:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778052456; cv=none; b=J09ZZ4DaOpIlYt+MU/71AScW6fBRvqyEc0HSgC8qcWtxyfJC5Q/zLJD+9/0CCSkAiex1/2KeSn0Yv3g/aQzTWl+mqo0EAGBdUNLFQgKO1hPz9UuhhwXR8sHYOPLqKXfwsSI17s4OLAZ5yt1o8H0HY/sSaDger7CFGzMTkKyrfeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778052456; c=relaxed/simple;
	bh=DO5Il5qSJuFEpe8fEuN08Kr/jSvHBd9ZgBnBkCm9u2Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ldd/p9fGQYDVPWbuo/3BlZMaCGZcYr7JlNAKgXYpyzWcW7CQgSA9jRVHS1QmX9fHZPKc1djIi6iih9gKJq4o0Hw7uKSGlHeRAjc29Fnk1v42uBUtUIkgNjPcyvGJuRfgglnFx1GYvmbg4Iq4e1uf3zB6iXIAtOq6sDAUYCNRTow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m3N3qBT6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26C9DC2BCB8;
	Wed,  6 May 2026 07:27:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778052455;
	bh=DO5Il5qSJuFEpe8fEuN08Kr/jSvHBd9ZgBnBkCm9u2Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=m3N3qBT69i21fIlYlmZ+v5gffaItiVQXQqBPFenOURqKYQQOdC2dVCpEQwkDv8mVg
	 Yp/Z89J6qJ67WvEg6XSFLrs9ipTMg+JQLooVT6HghUhiBnznPNdvorplRAPt/4OErs
	 Ca/a/1vIs+cmeFYT4PDryIeV0+16kYr5wlx9aYwdl+PvFr3urYiCbj3vsyOd2e/gpI
	 iAu2yCNMHeKW+PR8tviByaK3PKNDK3UsvNq+5VTYbU+CzWEPYUgM1WmbhKrshymXmU
	 KmofsrfvLHfFQ2tD8QndrcwbRzu1MZfhECeOwUA5DB8JmFiowt8A1ER/W2dbdfcfSL
	 hHyqqVRPcJk0Q==
Date: Wed, 6 May 2026 08:27:29 +0100
From: Sudeep Holla <sudeep.holla@kernel.org>
To: Yeoreum Yun <yeoreum.yun@arm.com>
Cc: linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	Sudeep Holla <sudeep.holla@kernel.org>,
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
	jarkko@kernel.org, zohar@linux.ibm.com, roberto.sassu@huawei.com,
	dmitry.kasatkin@gmail.com, eric.snowberg@oracle.com,
	paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
	maz@kernel.org, oupton@kernel.org, joey.gouly@arm.com,
	suzuki.poulose@arm.com, yuzenghui@huawei.com,
	catalin.marinas@arm.com, will@kernel.org
Subject: Re: [RFC PATCH 2/3] firmware: arm_ffa: initialise ff-a after
 finalising pKVM initialisation
Message-ID: <20260506-warm-deer-of-energy-522bfa@sudeepholla>
References: <20260505095409.1948371-1-yeoreum.yun@arm.com>
 <20260505095409.1948371-3-yeoreum.yun@arm.com>
 <20260505-super-gecko-of-argument-655030@sudeepholla>
 <afoHizU8NgFWzvYW@e129823.arm.com>
 <20260505-adaptable-mussel-of-virtuosity-2751db@sudeepholla>
 <afohuFhVBIyUFEMT@e129823.arm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <afohuFhVBIyUFEMT@e129823.arm.com>
X-Rspamd-Queue-Id: 0DEA84D743A
X-Rspamd-Action: no action
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
	TAGGED_FROM(0.00)[bounces-9462-lists,linux-integrity=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,lists.infradead.org,lists.linux.dev,linux.ibm.com,huawei.com,gmail.com,oracle.com,paul-moore.com,namei.org,hallyn.com,arm.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sudeep.holla@kernel.org,linux-integrity@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-integrity];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

On Tue, May 05, 2026 at 05:58:32PM +0100, Yeoreum Yun wrote:
> Hi Sudeep,
> 
> > On Tue, May 05, 2026 at 04:06:51PM +0100, Yeoreum Yun wrote:
> > > Hi Sudeep,
> > > 
> > > > On Tue, May 05, 2026 at 10:54:08AM +0100, Yeoreum Yun wrote:
> > > > > When pKVM is enabled, the FF-A driver must be initialised after pKVM.
> > > > > Otherwise, pKVM cannot negotiate the FF-A version or obtain the RX/TX
> > > > > buffer information, leading to failures in FF-A calls.
> > > > > 
> > > > > Currently, pKVM initialisation completes at device_initcall_sync,
> > > > > while ffa_init() runs at the device_initcall level.
> > > > > 
> > > > > So far, linker deployes kvm_arm_init() before ffa_init(), and SMCs can
> > > > > still be trapped even before finalise_pkvm() is invoked.
> > > > > As a result, this issue has not been observed.
> > > > > 
> > > > > However, relying on above stuff is fragile.
> > > > > Therefore, when pKVM is enabled, the FF-A infrastructure should be
> > > > > initialised only after pKVM initialisation has been fully finalised.
> > > > > 
> > > > > To achieve this, introduce an ffa_root_dev ("arm-ffa") and
> > > > > a corresponding driver to defer initialisation of the FF-A infrastructure
> > > > > until pKVM initialisation is complete, and to defer probing of all FF-A devices until then
> > > > > when pKVM is enabled.
> > > > > 
> > > > 
> > > > I don't like this whole ffa root device design.
> > > > Two question for now:
> > > > 1. Can FF-A be a module on systems with pKVM which removes the need for all
> > > >    this dance done here ?
> > > 
> > > But this means we reduce the other feature e.x) IMA with TPM over
> > > FF-A and pKVM feature. Since IMA must be a built-in, we couldn't avoid
> > > to build FF-A driver with built-in.
> > > 
> > > > 2. If it is a requirement to have this built-in, I prefer to add a probe
> > > >    and defer it instead of this root ffa device.
> > > 
> > > But, How? anyway all of FF-A device & driver couldn't be probed unless
> > > FF-A initialisation is finished and How can we trigger FF-A initailise
> > > after pKVM finish its initialisation?
> > > 
> > > The problem is ff-a intiailisation happens before pKVM finish its
> > > initailasation and to do defer probe, it should use dd-model and
> > > As we discussed in other thread, notifier couldn't be a soluation.
> > > 
> > > Could you let me share other way I'm missing?
> > > 
> > 
> > Will something like below work ?
> 
> It might work and when I write the code I thougt about whether to
> use add platform device but I didn't find why this is better than
> to create root device of FF-A (anyway creating a simple platform device
> for FF-A seems similar to create root device)

First, you tried to force the FF-A core to be treated as an FF-A device, then
added several bus-code changes to handle it as a "special root" device while
skipping all FF-A device functionality. Please consider the purpose of
creating it as an FF-A device if additional code is then required to bypass
the functionality it provides.

> If you don't mind why it would be better than to create FF-A root
> device in FF-A bus?
> 
> > If we add DT bindings, then we can add
> > of_match_table and drop the platform device creation. Also we can adjust
> > the parent device the way you have done by a simple change(not done in
> > this untested/not compiled change).
> 
> Might for a DT, but do we need to platform device creation for ACPI case
> anyway?
> 
>

Just acpi_match_table instead of of_match_table.

-- 
Regards,
Sudeep

