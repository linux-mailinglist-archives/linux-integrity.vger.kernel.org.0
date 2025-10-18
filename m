Return-Path: <linux-integrity+bounces-7497-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2556CBECF00
	for <lists+linux-integrity@lfdr.de>; Sat, 18 Oct 2025 14:06:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B96BC19C2B9C
	for <lists+linux-integrity@lfdr.de>; Sat, 18 Oct 2025 12:07:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EA3F24DCED;
	Sat, 18 Oct 2025 12:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E8bFEcfm"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E66981EE033;
	Sat, 18 Oct 2025 12:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760789201; cv=none; b=SzpppgMV76pZDTMov5di0tZIITres5n1VdOUNld+shuiYpqSlqB9DRnyTvCx+0+Ss3F/F42Kz4/MmgucSZ2dvUgJAvUPrs6xM3EKrVkMaTOJALIwmlOsBt8TPNJ6GplO5kQkLms/OCO/4WL2bqesn9jzBPW5CiAc+iSTFvbKMaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760789201; c=relaxed/simple;
	bh=MU8Do5ebwRc7sGjXYEfAMbTRJAmvXnfsw8vvxe+7bI8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=px/vjLYPrJlNLltoHzEuRHL3wDVP+WHietBEklWZvFwhpeVjgLWylUxOh004bqwvojEQtwi6ie8nWQQkRtlqbpyY9OGNUvfMVQ4HYWaUmTNXYGqxE0UJNljslyVjSSgZgot9cqsV8KdCDut3IGgoh/GE/LVsCmVjGH62ot/smSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E8bFEcfm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11282C4CEFE;
	Sat, 18 Oct 2025 12:06:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760789200;
	bh=MU8Do5ebwRc7sGjXYEfAMbTRJAmvXnfsw8vvxe+7bI8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=E8bFEcfmDdhVSBjYEaQ4jl3ALMi97RgWN+BNQnqO5cmjilFsZWalAslV2iO0+V2Th
	 +WtYgW1UYiwVbtYPFFC5LFVfcmFOdP//FWbRj2y+W6cn5LNyK1OR59vvyLVD6hiAFP
	 eIOysACLOflXSae+7fpWB/YHYFfYplAvpir2wJRvwdnU1cQnv+Qnm7uIH0WdPtbKmA
	 autVx5VNSvXO5loG6enbhkRb0vra29OBJZis0rY8qKeeDNieSBo2CJLuuABzAys2Pm
	 k8uZKQz460KuOxCnvcFiv068YdDYdUBHINKChLNnet4aUtTZ4h1oWxmyj8db0WkrGm
	 YESE6VEV42xRg==
Date: Sat, 18 Oct 2025 15:06:36 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	David Howells <dhowells@redhat.com>, keyrings@vger.kernel.org,
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
	Stuart Yoder <stuart.yoder@arm.com>
Subject: Re: [GIT PULL] TPM DEVICE DRIVER: tpmdd-next-v6.18-rc2
Message-ID: <aPOCzO_kDRojN4wi@kernel.org>
References: <aPOB9lMvnrXLf4ZD@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aPOB9lMvnrXLf4ZD@kernel.org>

On Sat, Oct 18, 2025 at 03:03:39PM +0300, Jarkko Sakkinen wrote:
> The following changes since commit f406055cb18c6e299c4a783fc1effeb16be41803:
> 
>   Merge tag 'arm64-fixes' of git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux (2025-10-17 13:04:21 -1000)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git tags/tpmdd-next-v6.18-rc2
> 
> for you to fetch changes up to dbfdaeb381a49a7bc753d18e2876bc56a15e01cc:
> 
>   tpm_crb: Add idle support for the Arm FF-A start method (2025-10-18 14:33:22 +0300)
> 
> ----------------------------------------------------------------
> Hi,
> 
> If possible, could you still pick this change for v6.18 [1]? The change in
> question  corrects the state transitions for ARM FF-A to match the spec and
> how tpm_crb behaves on other platforms.
> 
> [1] https://lore.kernel.org/linux-integrity/aPN59bwcUrieMACf@kernel.org/
> 
> BR, Jarkko
> 
> ----------------------------------------------------------------
> Stuart Yoder (1):
>       tpm_crb: Add idle support for the Arm FF-A start method
> 
>  drivers/char/tpm/tpm_crb.c | 29 ++++++++++++++++++++---------
>  1 file changed, 20 insertions(+), 9 deletions(-)

I don't have the specific hardware to test this but I did a quick
compilation test:

make CROSS_COMPILE=aarch64-linux-gnu- ARCH=arm64 tinyconfig && ./scripts/config --file .config -e CONFIG_KEYS -e CONFIG_TCG_TPM -e CONFIG_64BIT -e CONFIG_TRUSTED_KEYS -e CONFIG_TTY -e CONFIG_PROCFS -e CONFIG_SYSFS -e CONFIG_TCG_VTPM_PROXY -e CONFIG_EFI -e CONFIG_ACPI -e CONFIG_ARM_FFA_TRANSPORT -e CONFIG_TCG_CRB && yes '' | make CROSS_COMPILE=aarch64-linux-gnu- ARCH=arm64 oldconfig && make CROSS_COMPILE=aarch64-linux-gnu- ARCH=arm64 -j$(nproc)

And in addition with similar features x86 compilation test and run
my smoke tests with swtpm emulating tpm_crb (kselftest, keyring,
trusted keys type of stuff automated).

Those should localize any possible corrateral damage to only FFA,
if any (and not very likely).

BR, Jarkko

