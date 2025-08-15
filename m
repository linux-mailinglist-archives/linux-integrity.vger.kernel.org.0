Return-Path: <linux-integrity+bounces-6856-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79E45B27FAE
	for <lists+linux-integrity@lfdr.de>; Fri, 15 Aug 2025 14:04:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE8F63BCD1B
	for <lists+linux-integrity@lfdr.de>; Fri, 15 Aug 2025 12:04:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A817423E320;
	Fri, 15 Aug 2025 12:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cQpSX9sh"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DE551E9B37;
	Fri, 15 Aug 2025 12:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755259448; cv=none; b=OScmu8ow8XJPChO/rs+8Tb0zjDWfIwnFVBNzMtSjdIlaEC+zsU5xxgBWVei39ER3VssW3ErGA6HtZ2Cd9cpgErPwha+xP4Lw0uGzi7LT4AakKH1cKfBcv+5h58LXP/g0XBdTbf5ymnbHewXL0YHYPmPee4l9hRNsXsscqTjBoLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755259448; c=relaxed/simple;
	bh=HZeCyCbCW8BPc1UqJ/9xLPYFm/CNn5koe8rojNXfI4Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RQUSFSHfcDrcafQn+eSk3Zok9nk4HL+yv8OvACgNVpIP2kbvj3bBNtFEh2OripO51XfMZuElkvFMmJWTTJN00DK5jYPXzZNbKHjrQOc2MB2S8uyxKCaK0Hx58ZlFMqabQwHufzXr0IEboTQeR90q+pSCA1kURgnsv6zzCX3E3FM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cQpSX9sh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C551C4CEEB;
	Fri, 15 Aug 2025 12:04:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755259448;
	bh=HZeCyCbCW8BPc1UqJ/9xLPYFm/CNn5koe8rojNXfI4Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cQpSX9shqX50rgSFEZ4/cxfqQuGRDcQAzWYTFrGCpxMYNKy4N9qDjIy7JMihJD/jN
	 X+ATwPMHuoKyTJSNSYYu3iFFewu285ZPxiLftQ9p+XxuFdfxWs0bJFHeyYte6IUi9i
	 DucVMwyzdvubPvQJpr61jkxEz8RN9MfCfUm9bJRN3SK1+RntfR4tInrYC7RXumg3Q2
	 yTPGV3pgtYe0nKEz45Jl7PI7TCMHlYUkZ3dOYiOGGPtFjO+3PmnnLl7TB4CO9iL0l9
	 ip+dC0K9XAjw43zqkkHq9wg+CFzKsfW5p8h7g2z0bpJUGsTJd8YuCjm/hAY7T3zTIy
	 G8FJ7uNNIuixA==
Date: Fri, 15 Aug 2025 15:04:04 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Chris Fenner <cfenn@google.com>
Cc: Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tpm: Disable TCG_TPM2_HMAC by default
Message-ID: <aJ8iNLwlf4PAC0h1@kernel.org>
References: <20250814162252.3504279-1-cfenn@google.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250814162252.3504279-1-cfenn@google.com>

On Thu, Aug 14, 2025 at 09:22:52AM -0700, Chris Fenner wrote:
> This change disables the TCG_TPM2_HMAC feature by default to resolve
> some driver initialization failures (with certain TPMs) and performance
> regressions (with all TPMs). See "Security remarks" below for why this
> does not meaningfully downgrade security.
> 
> When the TCG_TPM2_HMAC feature fails to initialize the "null key" (see
> tpm-security.rst), it will cause tpm_tis_core_init to bail out early and
> skip device registration, causing all userspace requests to /dev/tpm0 to
> return ENODEV ("No such device").
> 
> TCG_TPM2_HMAC depends on the following being implemented in the TPM:
> 
> - TPM_RH_NULL
> - TPM2_CreatePrimary
> - TPM2_ContextSave
> - ECDH-P256
> - AES-128-CFB
> 
> While the majority of TPMs in the ecosystem conform to the PC Client
> Platform TPM Profile, which currently mandates most of these, not all
> versions of that profile did, and not all other TPM profiles (e.g.,
> Mobile, Automotive, Server) will. The TPM 2.0 specification itself is a
> "Library" specification and does not mandate any particular commands
> (and very few features) in order to maximize flexibility for
> implementors.
> 
> The TPM driver should not break userspace for a TPM that conforms to an
> atypical profile, therefore this change makes TCG_TPM2_HMAC disabled by
> default. It also adds a remark about what will happen if this feature is
> enabled and used with a non-supporting TPM to the Kconfig.
> 
> Some real-world public examples of problems posed by this feature:
> 
> TPMs that do not support the feature result in broken userspace starting
> from 6.10:
> 
> https://wiki.archlinux.org/title/Trusted_Platform_Module\
> 
> Significant (around 200%) boot up latency due to all the added TPM
> private key operations:
> 
> https://bugs.launchpad.net/ubuntu/+source/linux/+bug/2080322
> 
> Security remarks:
> 
> tpm-security.rst describes the threat model of the TPM2_HMAC feature,
> wherein an active interposer adversary on the TPM (e.g., SPI) bus
> tampers with TPM commands and/or responses to interfere with the booting
> or running system. The TPM2_HMAC feature uses something called "salted
> sessions" to establish per-request keys that can be used to protect TPM
> traffic.
> 
> Because the kernel does not have a priori knowledge of a cryptographic
> identity for the correct TPM for the system, and because the kernel does
> not have any cryptographic identity of its own with which to
> authenticate itself to the TPM, the session is established using a
> one-sided, unauthenticated key establishment protocol, wherein the
> kernel asks the TPM for the so-called "null key" and uses it to
> establish the shared session secret.
> 
> This poses a serious problem for the threat model of the TCG_TPM2_HMAC
> feature, which it resolves by asserting that userspace will attest to
> the "null key" using the EK after boot and compare it to the contents of
> /sys/class/tpm/tpm0/null_name, exposed by the TPM driver. However, this
> creates a trust cycle: we do not trust userspace to perform this action
> correctly, because we do not trust that kernel correctly measured
> userspace, because nobody has checked the null key yet. An implicitly
> trusted remote attestation verifier also cannot be relied upon to do
> this check, because it has no way of knowing for certain which key the
> kernel actually used to establish the TPM sessions during the boot.

All we care here is actually the external verifier scenario because most
of this type of crypto where software must attest breaks without that,
including all confidential computing technologies.

It's true that in the current form the whole feature is at most defense
in depth. It could be e.g. extended with persistent keys and productized
more in the future (e.g., trusted keys were mostly useless for multiple
years).

I'd personally would like to keep it on at least on my own laptop and
there's a risk that there's a group of people who would either:

1. want to have that small amount defense in depth.
2. want to refine the feature.

It's by practical means already "relaxed" but outcomes are objectively
plain wrong (as you stated) so I'd take a bit more conservative approach
on changing the mainline and propose three state option:

1. off: fully turn off
2. relaxed: mark just a info or at most marning to klog that hmac
   encryption is not enable. Keep timeout short as ECC generation
   does not take long (if it is working) (at least according to
   my tests). It should also address the lack of TPM2_ContextSave.
   We really should probe that anyhow in the driver init and
   disable also /dev/tpmrm0 accordingly.
3. strict: enforce. This is good to have albeit now not really
   useful

The 'relaxed' is of course default.

BR, Jarkko

 

