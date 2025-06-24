Return-Path: <linux-integrity+bounces-6502-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 953EBAE7322
	for <lists+linux-integrity@lfdr.de>; Wed, 25 Jun 2025 01:29:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D777168ED9
	for <lists+linux-integrity@lfdr.de>; Tue, 24 Jun 2025 23:29:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A80CE13C81B;
	Tue, 24 Jun 2025 23:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ch5fOtcr"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EA13307496;
	Tue, 24 Jun 2025 23:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750807748; cv=none; b=IG4BxvTdhEZoKBRwUDtpFUiqxmEnlslJToUAOL38HwLcgti3N8UY3ZeZaqQgZKhxEAHld6C9d5Gpct2+nn7V5VhXactzBmvnP3N5pURNc2aZmOXF/QdMr0SlsxP7zZTaq2jvkoJ7L1jvRd9f1WNCBV7IGgOwXIGTpCpNxquQjWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750807748; c=relaxed/simple;
	bh=PqyAtI8+FqX4t197/rnCaW4yfc0U9GL7ohSipMR5UL4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OO5qAs9gF/AyeP+Yms6+tjGe0rm5HW9TFamKE5T3fQEQ/rHzh3kQBsMuSE+FhGHLef4aC5IKMAGT8FdJc1AzY4Vd7mpY76UumLjgs33TNKw7OdCBukljBBJrKs0QVN6OR1vfbqj2DlvCznEkz1D+fz8ctRYJzI4vWlXcIFYwRhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ch5fOtcr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAC45C4CEE3;
	Tue, 24 Jun 2025 23:29:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750807748;
	bh=PqyAtI8+FqX4t197/rnCaW4yfc0U9GL7ohSipMR5UL4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ch5fOtcrbuGHpgMIfznlKR/7PXVy1rdVA+MqOQUrCkWeGivP8wHm/AnkMqGCjXpow
	 AYN10ajfS41HTxuck9gTlZMEHwtR2F1kVWyfN5h0M88PPBxA+445S0Ls5gjJgg2uwQ
	 laOhMDqvJGU9Q8kTT8LOkedBa+SHdhgJJYpMtCsImA52sQWjURIvqBaTazi35XOXmT
	 4ynj0c259FqHnpH6cwAq1BPavT0EQ131TlubCItpDoUTzrG+5yIlK/K8Yy3/iRdA/N
	 oxZlOUIZOqGWogm/iyTpqdPU/Fqky1MrAwGdhv+T7PSwvmdpgkypKj91xzLg7FMuYg
	 u7ql87d2XTvmg==
Date: Wed, 25 Jun 2025 02:29:04 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Yeoreum Yun <yeoreum.yun@arm.com>
Cc: sudeep.holla@arm.com, peterhuewe@gmx.de, jgg@ziepe.ca,
	stuart.yoder@arm.com, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org
Subject: Re: [PATCH v4 1/2] firmware: arm_ffa: Change initcall level of
 ffa_init() to rootfs_initcall
Message-ID: <aFs0wHrcQPFFmZYz@kernel.org>
References: <20250618102302.2379029-1-yeoreum.yun@arm.com>
 <20250618102302.2379029-2-yeoreum.yun@arm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250618102302.2379029-2-yeoreum.yun@arm.com>

On Wed, Jun 18, 2025 at 11:23:01AM +0100, Yeoreum Yun wrote:
> The Linux IMA (Integrity Measurement Architecture) subsystem used for secure
> boot, file integrity, or remote attestation cannot be a loadable module
> for few reasons listed below:
> 
>  o Boot-Time Integrity: IMA’s main role is to measure and appraise files
>    before they are used. This includes measuring critical system files during
>    early boot (e.g., init, init scripts, login binaries). If IMA were a module,
>    it would be loaded too late to cover those.
> 
>  o TPM Dependency: IMA integrates tightly with the TPM to record measurements
>    into PCRs. The TPM must be initialized early (ideally before init_ima()),
>    which aligns with IMA being built-in.
> 
>  o Security Model: IMA is part of a Trusted Computing Base (TCB). Making it a
>    module would weaken the security model, as a potentially compromised system
>    could delay or tamper with its initialization.
> 
> IMA must be built-in to ensure it starts measuring from the earliest possible
> point in boot which inturn implies TPM must be initialised and ready to use
> before IMA.
> 
> To enable integration of tpm_event_log with the IMA subsystem, the TPM drivers
> (tpm_crb and tpm_crb_ffa) also needs to be built-in. However with FF-A driver
> also being initialised at device initcall level, it can lead to an
> initialization order issue where:
>  - crb_acpi_driver_init() may run before tpm_crb_ffa_driver()_init and ffa_init()
>  - As a result, probing the TPM device via CRB over FFA is deferred
>  - ima_init() (called as a late initcall) runs before deferred probe completes,
>    IMA fails to find the TPM and logs the below error:
> 
>    |  ima: No TPM chip found, activating TPM-bypass!
> 
> Eventually it fails to generate boot_aggregate with PCR values.
> 
> Because of the above stated dependency, the ffa driver needs to initialised
> before tpm_crb_ffa module to ensure IMA finds the TPM successfully when
> present.
> 
> Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
> ---
>  drivers/firmware/arm_ffa/driver.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/firmware/arm_ffa/driver.c b/drivers/firmware/arm_ffa/driver.c
> index fe55613a8ea9..1a690b8186df 100644
> --- a/drivers/firmware/arm_ffa/driver.c
> +++ b/drivers/firmware/arm_ffa/driver.c
> @@ -2058,7 +2058,7 @@ static int __init ffa_init(void)
>  	kfree(drv_info);
>  	return ret;
>  }
> -module_init(ffa_init);
> +rootfs_initcall(ffa_init);
>  
>  static void __exit ffa_exit(void)
>  {
> -- 
> LEVI:{C3F47F37-75D8-414A-A8BA-3980EC8A46D7}
> 

Acked-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko

