Return-Path: <linux-integrity+bounces-9464-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oKN6Lbzy+ml1UgMAu9opvQ
	(envelope-from <linux-integrity+bounces-9464-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Wed, 06 May 2026 09:50:20 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 196124D7700
	for <lists+linux-integrity@lfdr.de>; Wed, 06 May 2026 09:50:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DA2FD3034B26
	for <lists+linux-integrity@lfdr.de>; Wed,  6 May 2026 07:49:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 390983DEFE6;
	Wed,  6 May 2026 07:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="i4aNvl5v"
X-Original-To: linux-integrity@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C5983DE433;
	Wed,  6 May 2026 07:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778053769; cv=none; b=sG0isivMXHEj80Jn3YFTu6ceJT1Miiznt8ln9BFIKO2LCRrzFGWz3N3QCwBJIHDuwPLZYCT56R0ReeqBRbmvJepOcc+i24J5WB3XC8ty4/lJHLgPrYfOx2L+7K69u5l1Lilqmpuxtu/+UwBgmMPBQcWr3m+MWeQXesbVOBqJsy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778053769; c=relaxed/simple;
	bh=KYnY7cZLCn3yUntUGYtEU90OG8jzwZlgNRSgNLo5+Ag=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JAHMMK9+uYUuffHXXMmijr54G8Hiv1WhqUN0L/jsBfqu3ShhCNH56G4O91D0gpEbSmPiNAx7pepF/4PFqi5ZTNeol7/9JuHB8oYRuI07DLRP++pz93i91TzsZvSFx5m2+LCX2ZZr1y4iLhW245WeNPPjNxSgkxMtEDBR0OBrWoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=i4aNvl5v; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 916FC1A9A;
	Wed,  6 May 2026 00:49:21 -0700 (PDT)
Received: from e129823.arm.com (e129823.arm.com [10.1.197.6])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 457723F7B4;
	Wed,  6 May 2026 00:49:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1778053766; bh=KYnY7cZLCn3yUntUGYtEU90OG8jzwZlgNRSgNLo5+Ag=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=i4aNvl5vftIV5T7ycw01h/G/dLS2cPEqU5WqMO4ENkXkyF2JobHhJwjokr9Cuwp7a
	 OD4UEZSDjySjDGXWQpsC2oyTI2hAvAG1Jn4rBPuvEffLxhSAb2X0cxwqy/S1Ll6UMr
	 1CBk8NBYdqmzpeC8EhbUfunmh42k3ejJe/TqOpmY=
Date: Wed, 6 May 2026 08:49:20 +0100
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
Message-ID: <afrygFx4OoCbbr+a@e129823.arm.com>
References: <20260505095409.1948371-1-yeoreum.yun@arm.com>
 <20260505095409.1948371-3-yeoreum.yun@arm.com>
 <20260505-super-gecko-of-argument-655030@sudeepholla>
 <afoHizU8NgFWzvYW@e129823.arm.com>
 <20260505-adaptable-mussel-of-virtuosity-2751db@sudeepholla>
 <afohuFhVBIyUFEMT@e129823.arm.com>
 <20260506-warm-deer-of-energy-522bfa@sudeepholla>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260506-warm-deer-of-energy-522bfa@sudeepholla>
X-Rspamd-Queue-Id: 196124D7700
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[arm.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[arm.com:s=foss];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.infradead.org,lists.linux.dev,kernel.org,linux.ibm.com,huawei.com,gmail.com,oracle.com,paul-moore.com,namei.org,hallyn.com,arm.com];
	TAGGED_FROM(0.00)[bounces-9464-lists,linux-integrity=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[arm.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,arm.com:dkim,e129823.arm.com:mid]

Hi,

> On Tue, May 05, 2026 at 05:58:32PM +0100, Yeoreum Yun wrote:
> > Hi Sudeep,
> > 
> > > On Tue, May 05, 2026 at 04:06:51PM +0100, Yeoreum Yun wrote:
> > > > Hi Sudeep,
> > > > 
> > > > > On Tue, May 05, 2026 at 10:54:08AM +0100, Yeoreum Yun wrote:
> > > > > > When pKVM is enabled, the FF-A driver must be initialised after pKVM.
> > > > > > Otherwise, pKVM cannot negotiate the FF-A version or obtain the RX/TX
> > > > > > buffer information, leading to failures in FF-A calls.
> > > > > > 
> > > > > > Currently, pKVM initialisation completes at device_initcall_sync,
> > > > > > while ffa_init() runs at the device_initcall level.
> > > > > > 
> > > > > > So far, linker deployes kvm_arm_init() before ffa_init(), and SMCs can
> > > > > > still be trapped even before finalise_pkvm() is invoked.
> > > > > > As a result, this issue has not been observed.
> > > > > > 
> > > > > > However, relying on above stuff is fragile.
> > > > > > Therefore, when pKVM is enabled, the FF-A infrastructure should be
> > > > > > initialised only after pKVM initialisation has been fully finalised.
> > > > > > 
> > > > > > To achieve this, introduce an ffa_root_dev ("arm-ffa") and
> > > > > > a corresponding driver to defer initialisation of the FF-A infrastructure
> > > > > > until pKVM initialisation is complete, and to defer probing of all FF-A devices until then
> > > > > > when pKVM is enabled.
> > > > > > 
> > > > > 
> > > > > I don't like this whole ffa root device design.
> > > > > Two question for now:
> > > > > 1. Can FF-A be a module on systems with pKVM which removes the need for all
> > > > >    this dance done here ?
> > > > 
> > > > But this means we reduce the other feature e.x) IMA with TPM over
> > > > FF-A and pKVM feature. Since IMA must be a built-in, we couldn't avoid
> > > > to build FF-A driver with built-in.
> > > > 
> > > > > 2. If it is a requirement to have this built-in, I prefer to add a probe
> > > > >    and defer it instead of this root ffa device.
> > > > 
> > > > But, How? anyway all of FF-A device & driver couldn't be probed unless
> > > > FF-A initialisation is finished and How can we trigger FF-A initailise
> > > > after pKVM finish its initialisation?
> > > > 
> > > > The problem is ff-a intiailisation happens before pKVM finish its
> > > > initailasation and to do defer probe, it should use dd-model and
> > > > As we discussed in other thread, notifier couldn't be a soluation.
> > > > 
> > > > Could you let me share other way I'm missing?
> > > > 
> > > 
> > > Will something like below work ?
> > 
> > It might work and when I write the code I thougt about whether to
> > use add platform device but I didn't find why this is better than
> > to create root device of FF-A (anyway creating a simple platform device
> > for FF-A seems similar to create root device)
> 
> First, you tried to force the FF-A core to be treated as an FF-A device, then
> added several bus-code changes to handle it as a "special root" device while
> skipping all FF-A device functionality. Please consider the purpose of
> creating it as an FF-A device if additional code is then required to bypass
> the functionality it provides.

Okay. I'll do with platform device then.

> 
> > If you don't mind why it would be better than to create FF-A root
> > device in FF-A bus?
> > 
> > > If we add DT bindings, then we can add
> > > of_match_table and drop the platform device creation. Also we can adjust
> > > the parent device the way you have done by a simple change(not done in
> > > this untested/not compiled change).
> > 
> > Might for a DT, but do we need to platform device creation for ACPI case
> > anyway?
> > 
> >
> 
> Just acpi_match_table instead of of_match_table.

I mean like DT node, it seems to add some "FF-A" device for this.
Anyway, right now as your suggestion, let me respin with platform device
again.

-- 
Sincerely,
Yeoreum Yun

