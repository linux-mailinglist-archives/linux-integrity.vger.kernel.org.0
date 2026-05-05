Return-Path: <linux-integrity+bounces-9452-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MKi+E8Yh+mlvKAMAu9opvQ
	(envelope-from <linux-integrity+bounces-9452-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Tue, 05 May 2026 18:58:46 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 5047E4D1B45
	for <lists+linux-integrity@lfdr.de>; Tue, 05 May 2026 18:58:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0343E30093AF
	for <lists+linux-integrity@lfdr.de>; Tue,  5 May 2026 16:58:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD70248A2D1;
	Tue,  5 May 2026 16:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="nLgLnVYO"
X-Original-To: linux-integrity@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9A2248B396;
	Tue,  5 May 2026 16:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778000320; cv=none; b=WCWtx10mHpRimLIykc4fw22Rb6CI6muYXfEg+fcIad2OtS6sULyrxsnbti/3HcMBCIbRVGfeLFub3F3mfuJTkMPwc/VUCX2fhD5XVyNvP81D91QxqSiq/8Bx1+KgjIKGTrS5wMmPSEz1vndAbc8htAEN2qgV4BAB4e+7BICcI9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778000320; c=relaxed/simple;
	bh=9xUjfWBXQK3kA5OtT8eXeiuUBiWwoUARr66KkE65Yh8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c7fVugr3c25CwDFISoB/3VATgPt/Q1zyjnf2iWHNGS8VmSYF+iegxayQViKg8JsXyPmLLPi2Kv0rufZa8iqipQu6S3oH4W9LAFTzczSFPygyhUDlQf2DxVY1QmLwjunKoWl/CVwK0kDAglA0JgUVtgqfQhSqaC2dOQ4D/GKzKi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=nLgLnVYO; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AF02E16A3;
	Tue,  5 May 2026 09:58:32 -0700 (PDT)
Received: from e129823.arm.com (e129823.arm.com [10.1.197.6])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0ED0A3F763;
	Tue,  5 May 2026 09:58:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1778000318; bh=9xUjfWBXQK3kA5OtT8eXeiuUBiWwoUARr66KkE65Yh8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nLgLnVYOsjxIJTwsn/GimU+4NLyfhbyvdJeRBi5Op17jL3sAOE+7yrHRHqj7N2b63
	 J6VlbBxgjpz+Ysus4mJqzftTkwpEjFcSh5OEkwzvl3FXMvKHeXxWHpFxYMLYQwdS0X
	 Pp2mjC9MCgBnOl1poiGjXoMPYG1Ua2sWXtUNv59w=
Date: Tue, 5 May 2026 17:58:32 +0100
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: Sudeep Holla <sudeep.holla@kernel.org>
Cc: linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
	jarkko@kernel.org, zohar@linux.ibm.com, roberto.sassu@huawei.com,
	dmitry.kasatkin@gmail.com, eric.snowberg@oracle.com,
	paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
	maz@kernel.org, oupton@kernel.org, joey.gouly@arm.com,
	suzuki.poulose@arm.com, yuzenghui@huawei.com,
	catalin.marinas@arm.com, will@kernel.org
Subject: Re: [RFC PATCH 2/3] firmware: arm_ffa: initialise ff-a after
 finalising pKVM initialisation
Message-ID: <afohuFhVBIyUFEMT@e129823.arm.com>
References: <20260505095409.1948371-1-yeoreum.yun@arm.com>
 <20260505095409.1948371-3-yeoreum.yun@arm.com>
 <20260505-super-gecko-of-argument-655030@sudeepholla>
 <afoHizU8NgFWzvYW@e129823.arm.com>
 <20260505-adaptable-mussel-of-virtuosity-2751db@sudeepholla>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260505-adaptable-mussel-of-virtuosity-2751db@sudeepholla>
X-Rspamd-Queue-Id: 5047E4D1B45
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[arm.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[arm.com:s=foss];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.infradead.org,lists.linux.dev,kernel.org,linux.ibm.com,huawei.com,gmail.com,oracle.com,paul-moore.com,namei.org,hallyn.com,arm.com];
	TAGGED_FROM(0.00)[bounces-9452-lists,linux-integrity=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[arm.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,arm.com:dkim]

Hi Sudeep,

> On Tue, May 05, 2026 at 04:06:51PM +0100, Yeoreum Yun wrote:
> > Hi Sudeep,
> > 
> > > On Tue, May 05, 2026 at 10:54:08AM +0100, Yeoreum Yun wrote:
> > > > When pKVM is enabled, the FF-A driver must be initialised after pKVM.
> > > > Otherwise, pKVM cannot negotiate the FF-A version or obtain the RX/TX
> > > > buffer information, leading to failures in FF-A calls.
> > > > 
> > > > Currently, pKVM initialisation completes at device_initcall_sync,
> > > > while ffa_init() runs at the device_initcall level.
> > > > 
> > > > So far, linker deployes kvm_arm_init() before ffa_init(), and SMCs can
> > > > still be trapped even before finalise_pkvm() is invoked.
> > > > As a result, this issue has not been observed.
> > > > 
> > > > However, relying on above stuff is fragile.
> > > > Therefore, when pKVM is enabled, the FF-A infrastructure should be
> > > > initialised only after pKVM initialisation has been fully finalised.
> > > > 
> > > > To achieve this, introduce an ffa_root_dev ("arm-ffa") and
> > > > a corresponding driver to defer initialisation of the FF-A infrastructure
> > > > until pKVM initialisation is complete, and to defer probing of all FF-A devices until then
> > > > when pKVM is enabled.
> > > > 
> > > 
> > > I don't like this whole ffa root device design.
> > > Two question for now:
> > > 1. Can FF-A be a module on systems with pKVM which removes the need for all
> > >    this dance done here ?
> > 
> > But this means we reduce the other feature e.x) IMA with TPM over
> > FF-A and pKVM feature. Since IMA must be a built-in, we couldn't avoid
> > to build FF-A driver with built-in.
> > 
> > > 2. If it is a requirement to have this built-in, I prefer to add a probe
> > >    and defer it instead of this root ffa device.
> > 
> > But, How? anyway all of FF-A device & driver couldn't be probed unless
> > FF-A initialisation is finished and How can we trigger FF-A initailise
> > after pKVM finish its initialisation?
> > 
> > The problem is ff-a intiailisation happens before pKVM finish its
> > initailasation and to do defer probe, it should use dd-model and
> > As we discussed in other thread, notifier couldn't be a soluation.
> > 
> > Could you let me share other way I'm missing?
> > 
> 
> Will something like below work ?

It might work and when I write the code I thougt about whether to
use add platform device but I didn't find why this is better than
to create root device of FF-A (anyway creating a simple platform device
for FF-A seems similar to create root device)
If you don't mind why it would be better than to create FF-A root
device in FF-A bus?

> If we add DT bindings, then we can add
> of_match_table and drop the platform device creation. Also we can adjust
> the parent device the way you have done by a simple change(not done in
> this untested/not compiled change).

Might for a DT, but do we need to platform device creation for ACPI case
anyway?


[...]

-- 
Sincerely,
Yeoreum Yun

