Return-Path: <linux-integrity+bounces-9443-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WDDlN//M+WlHEQMAu9opvQ
	(envelope-from <linux-integrity+bounces-9443-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Tue, 05 May 2026 12:57:03 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8257B4CBFA9
	for <lists+linux-integrity@lfdr.de>; Tue, 05 May 2026 12:57:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CB8573078A0B
	for <lists+linux-integrity@lfdr.de>; Tue,  5 May 2026 10:45:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63E5B37F72B;
	Tue,  5 May 2026 10:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="dTV46SUX"
X-Original-To: linux-integrity@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BFC933D4F8;
	Tue,  5 May 2026 10:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777977907; cv=none; b=COq+b8WTb3EnGQP6RtofX9WLgbZuLTJPZO7XpFvMJe8WmgbDuyl6uw/UVzsOR0XdJUFeF4dHii34+VhQ85Eovz7aiccNsGZpsWQszbwDiEVW73E6TllO3dogmtGoG7nUUqHyZ22H6RUK7YusYewSN+B09Ucy8/JRn7tnoNq1WGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777977907; c=relaxed/simple;
	bh=nXnH+ukVWHiFgFzkGEuGRS3UZnP6EPJC93zYaHByI9k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hBiS/UKAVhdQaEfILf/+6j/8Swcw629oxTTnQRu0WIP9GSULEuQuCSg1fx3bThrGldB3OlXC2I5HuhTy7IGVXClo8lCM2jkGFFZlgm0YULmdrs8F+OmBdI91U2wmGvK3lKcRH6ukhbzfK69XFI/e7nTRPZvlj9dpFv+LvK7Tmrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=dTV46SUX; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6DE2B293B;
	Tue,  5 May 2026 03:44:59 -0700 (PDT)
Received: from [10.1.196.46] (e134344.arm.com [10.1.196.46])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C217D3F763;
	Tue,  5 May 2026 03:45:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1777977904; bh=nXnH+ukVWHiFgFzkGEuGRS3UZnP6EPJC93zYaHByI9k=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=dTV46SUXHzARKB78y1+A9QR0ngcUGXfCnANsGKX4rYYv26v4ipV6zAg1oJhyzy2vg
	 To+WmwyY7GDYttqUYc5PIxwHqzgiS2/JNVABQa8IvnaLEH/COx86dTQEBZMpkG4tuf
	 4LGiN/y9ifQugZWcXHlwY5Ki9Mrp0D8keTFwCKbE=
Message-ID: <8942c12e-6315-493e-98c5-d55f4e6341f4@arm.com>
Date: Tue, 5 May 2026 11:45:00 +0100
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Thunderbird Daily
Subject: Re: [RFC PATCH 0/3] initalise ff-a after finalising pKVM
To: Yeoreum Yun <yeoreum.yun@arm.com>, linux-integrity@vger.kernel.org,
 keyrings@vger.kernel.org, linux-security-module@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 kvmarm@lists.linux.dev
Cc: jarkko@kernel.org, zohar@linux.ibm.com, roberto.sassu@huawei.com,
 dmitry.kasatkin@gmail.com, eric.snowberg@oracle.com, paul@paul-moore.com,
 jmorris@namei.org, serge@hallyn.com, maz@kernel.org, oupton@kernel.org,
 joey.gouly@arm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com,
 catalin.marinas@arm.com, will@kernel.org, sudeep.holla@kernel.org
References: <20260505095409.1948371-1-yeoreum.yun@arm.com>
Content-Language: en-US
From: Ben Horgan <ben.horgan@arm.com>
In-Reply-To: <20260505095409.1948371-1-yeoreum.yun@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 8257B4CBFA9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.65 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[arm.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[arm.com:s=foss];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[23];
	TAGGED_FROM(0.00)[bounces-9443-lists,linux-integrity=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,linux.ibm.com,huawei.com,gmail.com,oracle.com,paul-moore.com,namei.org,hallyn.com,arm.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ben.horgan@arm.com,linux-integrity@vger.kernel.org];
	DKIM_TRACE(0.00)[arm.com:+];
	NEURAL_HAM(-0.00)[-0.997];
	TAGGED_RCPT(0.00)[linux-integrity];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,arm.com:dkim,arm.com:mid]

Hi Levi,

On 5/5/26 10:54, Yeoreum Yun wrote:
> This patch is split out from the patchset [0] --
> fix FF-A call failure with pKVM when the FF-A driver is built-in,
> specifically the IMA-related part.
> 
> When pKVM is enabled, the FF-A driver must be initialised after pKVM.
> Otherwise, pKVM cannot negotiate the FF-A version or obtain the RX/TX
> buffer information, leading to failures in FF-A calls.
> 
> Currently, pKVM initialisation completes at device_initcall_sync,
> while ffa_init() runs at the device_initcall level.
> 
> So far, linker deployes kvm_arm_init() before ffa_init(), and SMCs can
> still be trapped even before finalise_pkvm() is invoked.
> As a result, this issue has not been observed.
> 
> However, relying on above stuff is fragile.
> Therefore, when pKVM is enabled, the FF-A infrastructure should be
> initialised only after pKVM initialisation has been fully finalised.
> 
> To achieve this, introduce an ffa_root_dev ("arm-ffa") and
> a corresponding driver to defer initialisation of the FF-A infrastructure
> until pKVM initialisation is complete, and to defer probing of all FF-A devices until then
> when pKVM is enabled.
> 
> This patch is based on v7.1-rc2
> 
> Question:
> 
> FF-A initialisation can occur at late_initcall. Because it may be deferred,
> some FF-A requests cannot be serviced at that stage.
> A typical example is the EFI runtime variable service using DIRECT_MSG_REQ.
> 
> Depending on the platform, the EFI runtime variable service runs with StandaloneMm
> and uses FF-A DIRECT_REQ. However, when pKVM is enabled, FF-A initialisation
> may be deferred to late_initcall. In this case, load_uefi_certs()
> can fail if it is invoked before the FF-A driver is initialised
> via deferred_probe_initcall().
> 
> Moving load_uefi_certs() to late_initcall_sync, as in the third patch,
> seems not to have any problem since late_initcall and
> late_initcall_sync are both of do_basic_setup() and it's before loading
> init process. However, it is still unclear whether
> it would be better to allow DIRECT_MSG_REQ in kvm_host_ffa_handler()

The spec doesn't allow this. Looking at DEN0077A 1.2 REL0:

Section 13.2.2 says:

"If they are compatible, it enables them to determine which Framework functionalities can be used. Hence, negotiation of
the version must happen before an invocation of any other FF-A ABI."

and a bit further down

"Once the caller invokes any FF-A ABI other than FFA_VERSION, the version negotiation phase is complete."

I would have thought that an SP would only go into the waiting state once the version negotiation is done.

Thanks,

Ben

> even before FF-A version negotiation since handler’s purpose seems to hook
> certain memory operations, and DIRECT_MSG_REQ has been available
> since FF-A specification v1.0.
> 
> Any feedback or alternative suggestions would be appreciated!
> 
> Link: https://lore.kernel.org/all/20260422162449.1814615-1-yeoreum.yun@arm.com/ [0]
> 
> Yeoreum Yun (3):
>   arm64: KVM: defer kvm_init() to finalise_pkvm() when pKVM is enabled
>   firmware: arm_ffa: initialise ff-a after finalising pKVM
>     initialisation
>   security: integrity: call load_uefi_certs() at late_initcall_sync
> 
>  arch/arm64/kvm/arm.c                          |   8 +-
>  arch/arm64/kvm/pkvm.c                         |  15 ++-
>  drivers/firmware/arm_ffa/bus.c                | 125 +++++++++++++++++-
>  drivers/firmware/arm_ffa/common.h             |  13 +-
>  drivers/firmware/arm_ffa/driver.c             |  21 ++-
>  drivers/firmware/arm_ffa/smccc.c              |   2 +-
>  security/integrity/platform_certs/load_uefi.c |   2 +-
>  7 files changed, 166 insertions(+), 20 deletions(-)
> 
> 
> base-commit: 7fd2df204f342fc17d1a0bfcd474b24232fb0f32


