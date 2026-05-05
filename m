Return-Path: <linux-integrity+bounces-9444-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kFVmJwjM+Wn3EAMAu9opvQ
	(envelope-from <linux-integrity+bounces-9444-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Tue, 05 May 2026 12:52:56 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 45F254CBE67
	for <lists+linux-integrity@lfdr.de>; Tue, 05 May 2026 12:52:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6C0503027431
	for <lists+linux-integrity@lfdr.de>; Tue,  5 May 2026 10:51:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76D73382F26;
	Tue,  5 May 2026 10:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="kziGBvU3"
X-Original-To: linux-integrity@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7660E3803C4;
	Tue,  5 May 2026 10:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777978285; cv=none; b=saBbUXGdSbtZkzf+GuAOuSi7IXfsV2A3Vt8HInq0tpDeo0nDZjMWaWfU9DeCsBAVUvEQvNdGcoTTJuhWJaDMXH34YDnt1ZI+065rCH8H0Wnlz0zl83yyqdB2LIOV7Y5s9kvE23yBlKLKENJ9fr3B5ensLy9BPUTxSqeWoRSYzpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777978285; c=relaxed/simple;
	bh=yZGdbNWnv9AoNALmOOSMNuAEp4erSnU4LfuZqIJ1ueY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HQ70JdMin2OKxbbdLHqhlpqLdDWDUP5urtg1yivFO/MKVs+c21XR/lXKa89ZMl1rOsV2lCnJGHKH+v/bnnqFfGW02gWJGsIzh3LnXmn+bW+WynVqV2Or2SrvEvIrAnyrqq4mu7uC8kKFWw2cKxgjJpNMZCDHWUIkC08/XfpUrXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=kziGBvU3; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 48921293B;
	Tue,  5 May 2026 03:51:17 -0700 (PDT)
Received: from e129823.arm.com (e129823.arm.com [10.1.197.6])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 616003F763;
	Tue,  5 May 2026 03:51:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1777978282; bh=yZGdbNWnv9AoNALmOOSMNuAEp4erSnU4LfuZqIJ1ueY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kziGBvU37OCRkjSk94kK2RNrvOTI7j03WaTu6gqQKEYis1J9WqfWuFXKEQJJXQ3Pm
	 f3Zcu2a1JWetSs8y/sR5hkYbTl2r17K+YEucmsp1K+ITQlE3tCjIacm9n5SXGQ/Cxg
	 qGjQ/dVMccsdc4nV7gwWQ+Ox028n1F5B3j4bRdRY=
Date: Tue, 5 May 2026 11:51:16 +0100
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: Ben Horgan <ben.horgan@arm.com>
Cc: linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
	jarkko@kernel.org, zohar@linux.ibm.com, roberto.sassu@huawei.com,
	dmitry.kasatkin@gmail.com, eric.snowberg@oracle.com,
	paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
	maz@kernel.org, oupton@kernel.org, joey.gouly@arm.com,
	suzuki.poulose@arm.com, yuzenghui@huawei.com,
	catalin.marinas@arm.com, will@kernel.org, sudeep.holla@kernel.org
Subject: Re: [RFC PATCH 0/3] initalise ff-a after finalising pKVM
Message-ID: <afnLpG4osopTzpip@e129823.arm.com>
References: <20260505095409.1948371-1-yeoreum.yun@arm.com>
 <8942c12e-6315-493e-98c5-d55f4e6341f4@arm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8942c12e-6315-493e-98c5-d55f4e6341f4@arm.com>
X-Rspamd-Queue-Id: 45F254CBE67
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[arm.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[arm.com:s=foss];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.infradead.org,lists.linux.dev,kernel.org,linux.ibm.com,huawei.com,gmail.com,oracle.com,paul-moore.com,namei.org,hallyn.com,arm.com];
	TAGGED_FROM(0.00)[bounces-9444-lists,linux-integrity=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[arm.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yeoreum.yun@arm.com,linux-integrity@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-integrity];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[arm.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,e129823.arm.com:mid]

Hi Ben,

> Hi Levi,
> 
> On 5/5/26 10:54, Yeoreum Yun wrote:
> > This patch is split out from the patchset [0] --
> > fix FF-A call failure with pKVM when the FF-A driver is built-in,
> > specifically the IMA-related part.
> > 
> > When pKVM is enabled, the FF-A driver must be initialised after pKVM.
> > Otherwise, pKVM cannot negotiate the FF-A version or obtain the RX/TX
> > buffer information, leading to failures in FF-A calls.
> > 
> > Currently, pKVM initialisation completes at device_initcall_sync,
> > while ffa_init() runs at the device_initcall level.
> > 
> > So far, linker deployes kvm_arm_init() before ffa_init(), and SMCs can
> > still be trapped even before finalise_pkvm() is invoked.
> > As a result, this issue has not been observed.
> > 
> > However, relying on above stuff is fragile.
> > Therefore, when pKVM is enabled, the FF-A infrastructure should be
> > initialised only after pKVM initialisation has been fully finalised.
> > 
> > To achieve this, introduce an ffa_root_dev ("arm-ffa") and
> > a corresponding driver to defer initialisation of the FF-A infrastructure
> > until pKVM initialisation is complete, and to defer probing of all FF-A devices until then
> > when pKVM is enabled.
> > 
> > This patch is based on v7.1-rc2
> > 
> > Question:
> > 
> > FF-A initialisation can occur at late_initcall. Because it may be deferred,
> > some FF-A requests cannot be serviced at that stage.
> > A typical example is the EFI runtime variable service using DIRECT_MSG_REQ.
> > 
> > Depending on the platform, the EFI runtime variable service runs with StandaloneMm
> > and uses FF-A DIRECT_REQ. However, when pKVM is enabled, FF-A initialisation
> > may be deferred to late_initcall. In this case, load_uefi_certs()
> > can fail if it is invoked before the FF-A driver is initialised
> > via deferred_probe_initcall().
> > 
> > Moving load_uefi_certs() to late_initcall_sync, as in the third patch,
> > seems not to have any problem since late_initcall and
> > late_initcall_sync are both of do_basic_setup() and it's before loading
> > init process. However, it is still unclear whether
> > it would be better to allow DIRECT_MSG_REQ in kvm_host_ffa_handler()
> 
> The spec doesn't allow this. Looking at DEN0077A 1.2 REL0:
> 
> Section 13.2.2 says:
> 
> "If they are compatible, it enables them to determine which Framework functionalities can be used. Hence, negotiation of
> the version must happen before an invocation of any other FF-A ABI."
> 
> and a bit further down
> 
> "Once the caller invokes any FF-A ABI other than FFA_VERSION, the version negotiation phase is complete."
> 
> I would have thought that an SP would only go into the waiting state once the version negotiation is done.

I mean the negotiation between hypervisor and ff-a driver.
actually the version negotiation is done with SPMC in
hyp_ffa_init() but the negotiaion between hypervisor and ff-a driver
just choose the lower version between version requested from ff-a driver
and negotiated version with hypervisor and SPMC.

So, the version negotiation is already done with SPMC
but with FF-A driver with hypervisor is not yet.
However, DIRECT_MSG_REQ has supported from v1.0 
In this situation, is there any reason not to send DIRECT_REQ_MSG?

> 
> > even before FF-A version negotiation since handler’s purpose seems to hook
> > certain memory operations, and DIRECT_MSG_REQ has been available
> > since FF-A specification v1.0.
> > 
> > Any feedback or alternative suggestions would be appreciated!
> > 
> > Link: https://lore.kernel.org/all/20260422162449.1814615-1-yeoreum.yun@arm.com/ [0]
> > 
> > Yeoreum Yun (3):
> >   arm64: KVM: defer kvm_init() to finalise_pkvm() when pKVM is enabled
> >   firmware: arm_ffa: initialise ff-a after finalising pKVM
> >     initialisation
> >   security: integrity: call load_uefi_certs() at late_initcall_sync
> > 
> >  arch/arm64/kvm/arm.c                          |   8 +-
> >  arch/arm64/kvm/pkvm.c                         |  15 ++-
> >  drivers/firmware/arm_ffa/bus.c                | 125 +++++++++++++++++-
> >  drivers/firmware/arm_ffa/common.h             |  13 +-
> >  drivers/firmware/arm_ffa/driver.c             |  21 ++-
> >  drivers/firmware/arm_ffa/smccc.c              |   2 +-
> >  security/integrity/platform_certs/load_uefi.c |   2 +-
> >  7 files changed, 166 insertions(+), 20 deletions(-)
> > 
> > 
> > base-commit: 7fd2df204f342fc17d1a0bfcd474b24232fb0f32
> 

-- 
Sincerely,
Yeoreum Yun

