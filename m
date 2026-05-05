Return-Path: <linux-integrity+bounces-9447-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CHcmCrvZ+WnNEgMAu9opvQ
	(envelope-from <linux-integrity+bounces-9447-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Tue, 05 May 2026 13:51:23 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8082F4CD000
	for <lists+linux-integrity@lfdr.de>; Tue, 05 May 2026 13:51:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 077C8307A034
	for <lists+linux-integrity@lfdr.de>; Tue,  5 May 2026 11:33:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F7DA38D6B8;
	Tue,  5 May 2026 11:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="PgllxUh/"
X-Original-To: linux-integrity@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 725743246E8;
	Tue,  5 May 2026 11:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777980817; cv=none; b=WB1osZk++vbpS4SOm4XyJQ82GACUkeYCYyYXVAYOlPCcC1i9NKgIE+LiB+dd+c3qGHiZJKhBW+7dqSNDb/bNUdjrLfu/AEd27JXdRKypwqygHVhICQcUewq5xeJCYTDaaGznMXpnVO6pAG+w66Td3i/0VzpEz9/H5BXWG+T58oQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777980817; c=relaxed/simple;
	bh=+DyxopJqusF4nqX/vk76jN9/BMcxqhGKLl2pzrxql/o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=la+UxRiFqw0cS0Di+GpEi5bYtZEcVOFh00xHPZ0jFtSkQ6svkNAJXUdmCtpC+nRKiQGMhlYt5gyfZGUdosukTLvaGwmdj/aVwPYHc3loqTZa3BubK/yLcM8HzDfVDUHdtBtaI5WbhXBk9W5MlEjsXSr+NFop8VNUeiv0YWWbWVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=PgllxUh/; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 72A3C28FA;
	Tue,  5 May 2026 04:33:29 -0700 (PDT)
Received: from e129823.arm.com (e129823.arm.com [10.1.197.6])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 153CD3F836;
	Tue,  5 May 2026 04:33:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1777980814; bh=+DyxopJqusF4nqX/vk76jN9/BMcxqhGKLl2pzrxql/o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PgllxUh/+rurhDG4ZVlwOUR1EM62YW/bBUT1vPkk63CPw+4peA3MGi7r9FWwhkxdL
	 csld+6LN4XrOrnBZAEG1WbKfU9RqC983hgOWrbsOs6u5R1rcsp1oQnVKqpRIZPX4/7
	 Wrz6e8KbA3Y/ywZQtIDwzL+0NQ9iz/5L/asRAqhU=
Date: Tue, 5 May 2026 12:33:28 +0100
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
Message-ID: <afnViPP84393BvTI@e129823.arm.com>
References: <20260505095409.1948371-1-yeoreum.yun@arm.com>
 <8942c12e-6315-493e-98c5-d55f4e6341f4@arm.com>
 <afnLpG4osopTzpip@e129823.arm.com>
 <afnRptWilWr7nABJ@e129823.arm.com>
 <9dd2b09b-cfb1-40e5-9fdd-1e004ad784c0@arm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9dd2b09b-cfb1-40e5-9fdd-1e004ad784c0@arm.com>
X-Rspamd-Queue-Id: 8082F4CD000
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[arm.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[arm.com:s=foss];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.infradead.org,lists.linux.dev,kernel.org,linux.ibm.com,huawei.com,gmail.com,oracle.com,paul-moore.com,namei.org,hallyn.com,arm.com];
	TAGGED_FROM(0.00)[bounces-9447-lists,linux-integrity=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[arm.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[arm.com:dkim,e129823.arm.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

> Hi Levi,
> 
> On 5/5/26 12:16, Yeoreum Yun wrote:
> >> Hi Ben,
> >>
> >>> Hi Levi,
> >>>
> >>> On 5/5/26 10:54, Yeoreum Yun wrote:
> >>>> This patch is split out from the patchset [0] --
> >>>> fix FF-A call failure with pKVM when the FF-A driver is built-in,
> >>>> specifically the IMA-related part.
> >>>>
> >>>> When pKVM is enabled, the FF-A driver must be initialised after pKVM.
> >>>> Otherwise, pKVM cannot negotiate the FF-A version or obtain the RX/TX
> >>>> buffer information, leading to failures in FF-A calls.
> >>>>
> >>>> Currently, pKVM initialisation completes at device_initcall_sync,
> >>>> while ffa_init() runs at the device_initcall level.
> >>>>
> >>>> So far, linker deployes kvm_arm_init() before ffa_init(), and SMCs can
> >>>> still be trapped even before finalise_pkvm() is invoked.
> >>>> As a result, this issue has not been observed.
> >>>>
> >>>> However, relying on above stuff is fragile.
> >>>> Therefore, when pKVM is enabled, the FF-A infrastructure should be
> >>>> initialised only after pKVM initialisation has been fully finalised.
> >>>>
> >>>> To achieve this, introduce an ffa_root_dev ("arm-ffa") and
> >>>> a corresponding driver to defer initialisation of the FF-A infrastructure
> >>>> until pKVM initialisation is complete, and to defer probing of all FF-A devices until then
> >>>> when pKVM is enabled.
> >>>>
> >>>> This patch is based on v7.1-rc2
> >>>>
> >>>> Question:
> >>>>
> >>>> FF-A initialisation can occur at late_initcall. Because it may be deferred,
> >>>> some FF-A requests cannot be serviced at that stage.
> >>>> A typical example is the EFI runtime variable service using DIRECT_MSG_REQ.
> >>>>
> >>>> Depending on the platform, the EFI runtime variable service runs with StandaloneMm
> >>>> and uses FF-A DIRECT_REQ. However, when pKVM is enabled, FF-A initialisation
> >>>> may be deferred to late_initcall. In this case, load_uefi_certs()
> >>>> can fail if it is invoked before the FF-A driver is initialised
> >>>> via deferred_probe_initcall().
> >>>>
> >>>> Moving load_uefi_certs() to late_initcall_sync, as in the third patch,
> >>>> seems not to have any problem since late_initcall and
> >>>> late_initcall_sync are both of do_basic_setup() and it's before loading
> >>>> init process. However, it is still unclear whether
> >>>> it would be better to allow DIRECT_MSG_REQ in kvm_host_ffa_handler()
> >>>
> >>> The spec doesn't allow this. Looking at DEN0077A 1.2 REL0:
> >>>
> >>> Section 13.2.2 says:
> >>>
> >>> "If they are compatible, it enables them to determine which Framework functionalities can be used. Hence, negotiation of
> >>> the version must happen before an invocation of any other FF-A ABI."
> >>>
> >>> and a bit further down
> >>>
> >>> "Once the caller invokes any FF-A ABI other than FFA_VERSION, the version negotiation phase is complete."
> >>>
> >>> I would have thought that an SP would only go into the waiting state once the version negotiation is done.
> >>
> >> I mean the negotiation between hypervisor and ff-a driver.
> >> actually the version negotiation is done with SPMC in
> >> hyp_ffa_init() but the negotiaion between hypervisor and ff-a driver
> >> just choose the lower version between version requested from ff-a driver
> >> and negotiated version with hypervisor and SPMC.
> > 
> > Sorry. re-parse the word, not choose "re-negotiate" when
> > FF-A driver request lowever version.
> > 
> >>
> >> So, the version negotiation is already done with SPMC
> >> but with FF-A driver with hypervisor is not yet.
> >> However, DIRECT_MSG_REQ has supported from v1.0 
> >> In this situation, is there any reason not to send DIRECT_REQ_MSG?
> > 
> > IOW, question is that some of ff-a request can be allowed
> > before version negotiation with FF-A driver but
> > using negotiated version via hyp_ffa_init() first or not.
> 
> I don't think so. Isn't it more a continuation of the negotiation rather than a re-negotiation?

Might be. However, in the case I mentioned, I’m asking because
it’s somewhat unusual in that the FF-A request occurs without an “FF-A driver.”

If the FF-A request goes through the FF-A driver, then as you said,
it can reasonably be considered a continuation of the negotiation.
But in this case, I was wondering whether it would be acceptable to
introduce additional exception handling for situations
where an FF-A request occurs without the FF-A driver.

From that perspective, even if the FF-A request does not go through
the FF-A driver, it would ultimately still have to wait until
the FF-A driver initialization is complete.

So my question was whether certain operations could be handled
as exceptions in such cases.

Thanks.

-- 
Sincerely,
Yeoreum Yun

