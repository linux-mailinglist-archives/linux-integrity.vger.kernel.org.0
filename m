Return-Path: <linux-integrity+bounces-8265-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 90246D2EEEF
	for <lists+linux-integrity@lfdr.de>; Fri, 16 Jan 2026 10:44:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 570A63073020
	for <lists+linux-integrity@lfdr.de>; Fri, 16 Jan 2026 09:42:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C2C4357A5C;
	Fri, 16 Jan 2026 09:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VPASkmLv"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EBF53587C8
	for <linux-integrity@vger.kernel.org>; Fri, 16 Jan 2026 09:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768556520; cv=none; b=EbHcy5lTmzA9NjWB1ihExSo10Ye92SJyQxtYU3kgdmaUNTAw2Zdb8rESrMr4nj9PtMV35vCJ4+B4tr2jO+TtqdY1ydKd7cJuloq37YI1q7mLeKL88yOuyBeU/oAr99U9Zs4uOMGdKQj7LDAQRfmPve1La64OuSvCSJpmW/SDB5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768556520; c=relaxed/simple;
	bh=/E8pjL1Rg4kjh10yWKXAfqGFi3+btd20CKL87Qc6xYk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d+q6iXRQSExSycFq64PBO8lMCOxTfD+oSZNt9lZTkIATEXakMOfee7n+TnZhsJvwH+Vr0nTJ6V99/42O/J8/0evWB3gcGVL6jiPAtyrciK8B7T1dlHIXSVoSWsMMPPhWYsBFpXHDdMGk/8BOfPLPqQakx/jNpx6/JtmuYmQiWhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VPASkmLv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A5A7C2BCB4
	for <linux-integrity@vger.kernel.org>; Fri, 16 Jan 2026 09:42:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768556520;
	bh=/E8pjL1Rg4kjh10yWKXAfqGFi3+btd20CKL87Qc6xYk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=VPASkmLvCW/t4XmsQcmEBMDBN6Np6o9rMBqRv0awasGACRhWea5bRnd9A+VLI+NCs
	 dIOhMy0sajBtbGyDu9uVrXkjyIivOBJELkA5/q/4uW2MVZdwif+Sp2+i0XqCrTiY5V
	 1KA83r7fBXyaU5DDLzRKsGpWG3+5hmKtEVtCmxu1hgjn3vYeSFlJpj5eVFe/Ievqfl
	 KZgXntrkuNOXkkx9bZH1SNmuZHxxpA2fODGUvnAxdX2bcG0uDEaKicAUoeBrHNqpUs
	 FNslAZOVGw7n8A5D4kGOULTX8nF3IzRI4xn4R3dZbn8JeuL3MTbn5K967B+ogy3rK7
	 zdKB3gNFNNE6A==
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-c2a9a9b43b1so1267801a12.2
        for <linux-integrity@vger.kernel.org>; Fri, 16 Jan 2026 01:42:00 -0800 (PST)
X-Gm-Message-State: AOJu0YxICSeLhbugewvxN4cYsAJKOvhdy1FDqcE+XC0fdECk5R/9/eNA
	qO0FjTeFIOVJfsz6YF7t6pQNYkmv5ttGNZ2fbeiIvDeVbh+lmJ0yw+v3p3JoTLkqqRBK7wyGke+
	yzjCwI9MxtWtI9wfes33yj6EWlyRXyTg=
X-Received: by 2002:a17:90b:3dcc:b0:340:c4dc:4b70 with SMTP id
 98e67ed59e1d1-3527315e60dmr2091280a91.6.1768556519441; Fri, 16 Jan 2026
 01:41:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260115004328.194142-1-coxu@redhat.com> <20260115004328.194142-2-coxu@redhat.com>
In-Reply-To: <20260115004328.194142-2-coxu@redhat.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Fri, 16 Jan 2026 10:41:48 +0100
X-Gmail-Original-Message-ID: <CAMj1kXFXNo1-pMbo-VZrjQ3TYe1tufebrLr_avL12A0nHMSGnA@mail.gmail.com>
X-Gm-Features: AZwV_QjmUt_PmrwfWvkU01-td52KzVOAwQnoeyg_Oar6lj-mB--Ez-fk2UXAfCg
Message-ID: <CAMj1kXFXNo1-pMbo-VZrjQ3TYe1tufebrLr_avL12A0nHMSGnA@mail.gmail.com>
Subject: Re: [PATCH 1/3] integrity: Make arch_ima_get_secureboot integrity-wide
To: Coiby Xu <coxu@redhat.com>
Cc: linux-integrity@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>, 
	Mimi Zohar <zohar@linux.ibm.com>, Roberto Sassu <roberto.sassu@huaweicloud.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
	Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, 
	"maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Roberto Sassu <roberto.sassu@huawei.com>, 
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, Eric Snowberg <eric.snowberg@oracle.com>, 
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Jarkko Sakkinen <jarkko@kernel.org>, 
	"moderated list:ARM64 PORT (AARCH64 ARCHITECTURE)" <linux-arm-kernel@lists.infradead.org>, 
	open list <linux-kernel@vger.kernel.org>, 
	"open list:LINUX FOR POWERPC (32-BIT AND 64-BIT)" <linuxppc-dev@lists.ozlabs.org>, 
	"open list:S390 ARCHITECTURE" <linux-s390@vger.kernel.org>, 
	"open list:EXTENSIBLE FIRMWARE INTERFACE (EFI)" <linux-efi@vger.kernel.org>, 
	"open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>, 
	"open list:KEYS/KEYRINGS_INTEGRITY" <keyrings@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 15 Jan 2026 at 01:43, Coiby Xu <coxu@redhat.com> wrote:
>
> EVM and other LSMs need the ability to query the secure boot status of
> the system, without directly calling the IMA arch_ima_get_secureboot
> function. Refactor the secure boot status check into a general,
> integrity-wide function named arch_integrity_get_secureboot.
>
> Define a new Kconfig option CONFIG_INTEGRITY_SECURE_BOOT, which is
> automatically configured by the supported architectures. The existing
> IMA_SECURE_AND_OR_TRUSTED_BOOT Kconfig loads the architecture specific
> IMA policy based on the refactored secure boot status code.
>
> Reported-and-suggested-by: Mimi Zohar <zohar@linux.ibm.com>
> Suggested-by: Roberto Sassu <roberto.sassu@huaweicloud.com>
> Signed-off-by: Coiby Xu <coxu@redhat.com>
> ---
>  arch/arm64/Kconfig                            |  1 +
>  arch/powerpc/Kconfig                          |  1 +
>  arch/powerpc/kernel/Makefile                  |  2 +-
>  arch/powerpc/kernel/ima_arch.c                |  5 --
>  arch/powerpc/kernel/integrity_sb_arch.c       | 13 +++++
>  arch/s390/Kconfig                             |  1 +
>  arch/s390/kernel/Makefile                     |  1 +
>  arch/s390/kernel/ima_arch.c                   |  6 --
>  arch/s390/kernel/integrity_sb_arch.c          |  9 +++
>  arch/x86/Kconfig                              |  1 +
>  arch/x86/include/asm/efi.h                    |  4 +-
>  arch/x86/platform/efi/efi.c                   |  2 +-
>  include/linux/ima.h                           |  7 +--
>  include/linux/integrity.h                     |  8 +++
>  security/integrity/Kconfig                    |  6 ++
>  security/integrity/Makefile                   |  3 +
>  security/integrity/efi_secureboot.c           | 56 +++++++++++++++++++
>  security/integrity/ima/ima_appraise.c         |  2 +-
>  security/integrity/ima/ima_efi.c              | 47 +---------------
>  security/integrity/ima/ima_main.c             |  4 +-
>  security/integrity/platform_certs/load_uefi.c |  2 +-
>  21 files changed, 111 insertions(+), 70 deletions(-)
>  create mode 100644 arch/powerpc/kernel/integrity_sb_arch.c
>  create mode 100644 arch/s390/kernel/integrity_sb_arch.c
>  create mode 100644 security/integrity/efi_secureboot.c
>
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 93173f0a09c7..4c265b7386bb 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -2427,6 +2427,7 @@ config EFI
>         select EFI_STUB
>         select EFI_GENERIC_STUB
>         imply IMA_SECURE_AND_OR_TRUSTED_BOOT
> +       imply INTEGRITY_SECURE_BOOT

This allows both to be en/disabled individually, which I don't think
is what we want. It also results in more churn across the
arch-specific Kconfigs than needed.

Wouldn't it be better if IMA_SECURE_AND_OR_TRUSTED_BOOT 'select'ed
INTEGRITY_SECURE_BOOT in its Kconfig definition?

