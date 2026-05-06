Return-Path: <linux-integrity+bounces-9465-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4NXIHLby+ml1UgMAu9opvQ
	(envelope-from <linux-integrity+bounces-9465-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Wed, 06 May 2026 09:50:14 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AD944D76F0
	for <lists+linux-integrity@lfdr.de>; Wed, 06 May 2026 09:50:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 564163016791
	for <lists+linux-integrity@lfdr.de>; Wed,  6 May 2026 07:50:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 036433DEFE6;
	Wed,  6 May 2026 07:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BmiFgJDc"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D342C37A498;
	Wed,  6 May 2026 07:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778053809; cv=none; b=lJYa4rrHxmJbIY2Igrn7o6IKtQEtQU0pGNCuZJTsFkKRN3e2K0HogU3bdpbEpYexpM60Vj7rI1yvdU6+KSzrm5SqOF8EEzPkIdhL0rGs7hxVgtN4GqRTm9wK3ZThI4TC6ndG55mcyyZfUCBDopoZik+0ciqR2iijGZcHG+YStBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778053809; c=relaxed/simple;
	bh=FaaXScUXPb4sIbB5rQFiyH9iXewmrp5Aw7s3e5Jdplc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JEtq07N3aFuFiMeBwn8Jb5ZmyyxRV8DbvwQFqtlW2qVTHC+A5b7/Wh7AnxshOV3OZITKoA+/CS7I0dp+NEMZsZfvSD0E16IMbnUIjb6lfEFX9/wHkrsXx55ferwLYxgW2ZFkF7IjwvFJTbUvRyt81pOsoaNihNsxM7KE7L95bD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BmiFgJDc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8D6EC2BCB8;
	Wed,  6 May 2026 07:50:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778053809;
	bh=FaaXScUXPb4sIbB5rQFiyH9iXewmrp5Aw7s3e5Jdplc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BmiFgJDcmg4CFoejvO8C4n0h0pBRtvpbW6SbUDtVBlt4iL5637qI0NCzi0kkfnCjE
	 9gNNmNLicDpjIxyC6mfUBnabIACOGJZvremJt+8XdDWJ/6U8DIvWoMA/V9D4akqysa
	 zP7gNn5sD7lAoaJMYUr2qKZernYXvuf2eBHpp97tpVIEcItJ5HXXlWXCtNiG426gPt
	 aBsW2kk7x3xSmlQWxO9qiM1oLB+K8DAdATVHBbnxhK9TyjCpE6vctvt0nXGc7wGiIs
	 IZltuRhARE/qRNcq+mqaOCwfY4IlLpN5lr0TPizRXpGRAHsbpaHMXw50XAsGUfmjOH
	 bx4AYlC42FPbw==
Date: Wed, 6 May 2026 08:50:03 +0100
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
Subject: Re: [RFC PATCH 1/3] arm64: KVM: defer kvm_init() to finalise_pkvm()
 when pKVM is enabled
Message-ID: <20260506-spirited-impartial-sparrow-66efae@sudeepholla>
References: <20260505095409.1948371-1-yeoreum.yun@arm.com>
 <20260505095409.1948371-2-yeoreum.yun@arm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260505095409.1948371-2-yeoreum.yun@arm.com>
X-Rspamd-Queue-Id: 1AD944D76F0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9465-lists,linux-integrity=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,arm.com:email]

On Tue, May 05, 2026 at 10:54:07AM +0100, Yeoreum Yun wrote:
> This patch is a preparatory change to address dependency issues
> between the FF-A driver and pKVM.
> 
> kvm_init() should be invoked from finalise_pkvm(),
> as this is the point where pKVM initialisation is finalised and
> the system transitions into the protected mode.
> 
> Deferring kvm_init() ensures that KVM is initialised only after pKVM has
> fully established its protected environment.
> 
> Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
> ---
>  arch/arm64/kvm/arm.c  |  8 +++++---
>  arch/arm64/kvm/pkvm.c | 15 ++++++++++++++-
>  2 files changed, 19 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
> index 8bb2c7422cc8..663b1d447a9b 100644
> --- a/arch/arm64/kvm/arm.c
> +++ b/arch/arm64/kvm/arm.c
> @@ -3025,9 +3025,11 @@ static __init int kvm_arm_init(void)
>  	 * FIXME: Do something reasonable if kvm_init() fails after pKVM
>  	 * hypervisor protection is finalized.
>  	 */
> -	err = kvm_init(sizeof(struct kvm_vcpu), 0, THIS_MODULE);
> -	if (err)
> -		goto out_subs;
> +	if (!is_protected_kvm_enabled()) {
> +		err = kvm_init(sizeof(struct kvm_vcpu), 0, THIS_MODULE);
> +		if (err)
> +			goto out_subs;
> +	}
>  
>  	/*
>  	 * This should be called after initialization is done and failure isn't
> diff --git a/arch/arm64/kvm/pkvm.c b/arch/arm64/kvm/pkvm.c
> index 053e4f733e4b..48b06d384570 100644
> --- a/arch/arm64/kvm/pkvm.c
> +++ b/arch/arm64/kvm/pkvm.c
> @@ -17,6 +17,7 @@
>  #include "hyp_constants.h"
>  
>  DEFINE_STATIC_KEY_FALSE(kvm_protected_mode_initialized);
> +EXPORT_SYMBOL_GPL(kvm_protected_mode_initialized);
>

I am not sure if this is needed when FF-A is built as module. If others
are OK with it, I am fine. But I am thinking if we need to use this in
FF-A driver which can be built-in or a module, we can add
IS_BUILTIN(CONFIG_ARM_FFA_*)

-- 
Regards,
Sudeep

