Return-Path: <linux-integrity+bounces-4739-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AF243A2B38B
	for <lists+linux-integrity@lfdr.de>; Thu,  6 Feb 2025 21:45:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9C42188AB3D
	for <lists+linux-integrity@lfdr.de>; Thu,  6 Feb 2025 20:45:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 841201DC98C;
	Thu,  6 Feb 2025 20:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bRbkb21t"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57DE71DC185;
	Thu,  6 Feb 2025 20:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738874684; cv=none; b=qTe2fQM6QaGte7xsaCXWN8bfmZ5XYIAIoMOntmCNP/RvUuN00FKlD2R0dpWEiCGKb+/wbLa/uc/DdfcrIZ527By5pVN3qkKRGoxAJen0dCWqWC1x5BvfymzgH7NWdXwvIeo11rkGkiNrXEEEH/JPyhYxx0emxjUA5qRTJ6c64y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738874684; c=relaxed/simple;
	bh=ntk1sF+j+9AC331gmFh872rwNxuhPJMIm8QD4kp8s0A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GJLbh5vS9TxaeQb2qXBdtQWmiXDuX3Z6xNzjtzqPVMIZC+CdNI9TlCGNZwYGACOoAUpKu7P1yMo5fTyaA5RDUDks4wd/03+0tWlShiCahTiTUfd03879eEPvLoZtMy10BOVkB2R+K2H1uCbnsOzSmhcx6Zitz1+XFKUskcwlZ4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bRbkb21t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38910C4CEDD;
	Thu,  6 Feb 2025 20:44:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738874681;
	bh=ntk1sF+j+9AC331gmFh872rwNxuhPJMIm8QD4kp8s0A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bRbkb21tjbmTDocG2+T5hr/vp09a93HN7q7LUrT9fBWT/gM05fvs+i9QSFusSyW0V
	 e0mszS9zPSVzZYa8fdAfjuOppus4i2jOHeBU1TrvprC0ihJ3jWRMLovI1mvpsA+LPk
	 IJskQ6e6TNG7bTbPt+JVgZApTwDbuEvGCnJ4aaGUUL48ARWLo3EYei3HsfJZtz7mKt
	 dwBinEpyGiA4CjnMXeAz7qdKqyrHRYq+wHrG+U/B49iHgNfao/ZxFY/Wtcy+zNyazr
	 DOu797WOjHNLDZE/YX66eMFH9KYhTofH7IcMOmyXkxG1qZcFB+waGrJOxb4mOaM2ce
	 E/8maGfssJBYQ==
Date: Thu, 6 Feb 2025 22:44:37 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Cc: Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	Jerry Snitselaar <jsnitsel@redhat.com>,
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
	Mike Seo <mikeseohyungjin@gmail.com>, kernel-dev@igalia.com,
	stable@vger.kernel.org
Subject: Re: [PATCH] tpm: do not start chip while suspended
Message-ID: <Z6UfNcvehCjUakdI@kernel.org>
References: <20250205-tpm-suspend-v1-1-fb89a29c0b69@igalia.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250205-tpm-suspend-v1-1-fb89a29c0b69@igalia.com>

On Wed, Feb 05, 2025 at 09:20:07AM -0300, Thadeu Lima de Souza Cascardo wrote:
> tpm_chip_start may issue IO that should not be done while the chip is
> suspended. In the particular case of I2C, it will issue the following
> warning:

The bug is legit but this description needs some rework:

"Checking TPM_CHIP_FLAG_SUSPENDED after the call to tpm_chip_find_get_ops()
can lead to a spurious tpm_chip_start_call()":

> [35985.503771] i2c i2c-1: Transfer while suspended
> [35985.503796] WARNING: CPU: 0 PID: 74 at drivers/i2c/i2c-core.h:56 __i2c_transfer+0xbe/0x810
> [35985.503802] Modules linked in:
> [35985.503808] CPU: 0 UID: 0 PID: 74 Comm: hwrng Tainted: G        W          6.13.0-next-20250203-00005-gfa0cb5642941 #19 9c3d7f78192f2d38e32010ac9c90fdc71109ef6f
> [35985.503814] Tainted: [W]=WARN
> [35985.503817] Hardware name: Google Morphius/Morphius, BIOS Google_Morphius.13434.858.0 10/26/2023
> [35985.503819] RIP: 0010:__i2c_transfer+0xbe/0x810
> [35985.503825] Code: 30 01 00 00 4c 89 f7 e8 40 fe d8 ff 48 8b 93 80 01 00 00 48 85 d2 75 03 49 8b 16 48 c7 c7 0a fb 7c a7 48 89 c6 e8 32 ad b0 fe <0f> 0b b8 94 ff ff ff e9 33 04 00 00 be 02 00 00 00 83 fd 02 0f 5
> [35985.503828] RSP: 0018:ffffa106c0333d30 EFLAGS: 00010246
> [35985.503833] RAX: 074ba64aa20f7000 RBX: ffff8aa4c1167120 RCX: 0000000000000000
> [35985.503836] RDX: 0000000000000000 RSI: ffffffffa77ab0e4 RDI: 0000000000000001
> [35985.503838] RBP: 0000000000000001 R08: 0000000000000001 R09: 0000000000000000
> [35985.503841] R10: 0000000000000004 R11: 00000001000313d5 R12: ffff8aa4c10f1820
> [35985.503843] R13: ffff8aa4c0e243c0 R14: ffff8aa4c1167250 R15: ffff8aa4c1167120
> [35985.503846] FS:  0000000000000000(0000) GS:ffff8aa4eae00000(0000) knlGS:0000000000000000
> [35985.503849] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [35985.503852] CR2: 00007fab0aaf1000 CR3: 0000000105328000 CR4: 00000000003506f0
> [35985.503855] Call Trace:
> [35985.503859]  <TASK>
> [35985.503863]  ? __warn+0xd4/0x260
> [35985.503868]  ? __i2c_transfer+0xbe/0x810
> [35985.503874]  ? report_bug+0xf3/0x210
> [35985.503882]  ? handle_bug+0x63/0xb0
> [35985.503887]  ? exc_invalid_op+0x16/0x50
> [35985.503892]  ? asm_exc_invalid_op+0x16/0x20
> [35985.503904]  ? __i2c_transfer+0xbe/0x810
> [35985.503913]  tpm_cr50_i2c_transfer_message+0x24/0xf0
> [35985.503920]  tpm_cr50_i2c_read+0x8e/0x120
> [35985.503928]  tpm_cr50_request_locality+0x75/0x170
> [35985.503935]  tpm_chip_start+0x116/0x160

Only put this snippe to the commit message.

> Test for the suspended flag inside tpm_try_get_ops while holding the chip
> tpm_mutex before calling tpm_chip_start. That will also prevent
> tpm_get_random from doing IO while the TPM is suspended.

Remove and:

"Don't move forward with tpm_chip_start() inside tpm_chip_find_get(),
unless TPM_CHIP_FLAG_SUSPENDED is set. Return NULl in the failure
case."

> 
> Fixes: 9265fed6db60 ("tpm: Lock TPM chip in tpm_pm_suspend() first")
> Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
> Cc: stable@vger.kernel.org
> Cc: Jerry Snitselaar <jsnitsel@redhat.com>
> Cc: Mike Seo <mikeseohyungjin@gmail.com>
> Cc: Jarkko Sakkinen <jarkko@kernel.org>
> ---
>  drivers/char/tpm/tpm-chip.c      | 5 +++++
>  drivers/char/tpm/tpm-interface.c | 8 +-------
>  2 files changed, 6 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
> index 7df7abaf3e526bf7e85ac9dfbaa1087a51d2ab7e..6db864696a583bf59c534ec8714900a6be7b5156 100644
> --- a/drivers/char/tpm/tpm-chip.c
> +++ b/drivers/char/tpm/tpm-chip.c
> @@ -168,6 +168,11 @@ int tpm_try_get_ops(struct tpm_chip *chip)
>  		goto out_ops;
>  
>  	mutex_lock(&chip->tpm_mutex);
> +
> +	/* tmp_chip_start may issue IO that is denied while suspended */
> +	if (chip->flags & TPM_CHIP_FLAG_SUSPENDED)
> +		goto out_lock;
> +
>  	rc = tpm_chip_start(chip);
>  	if (rc)
>  		goto out_lock;
> diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
> index b1daa0d7b341b1a4c71a200115f0d29d2e87512d..e6d786ce4e36970428b75d288a066e832c5b2af1 100644
> --- a/drivers/char/tpm/tpm-interface.c
> +++ b/drivers/char/tpm/tpm-interface.c
> @@ -441,22 +441,16 @@ int tpm_get_random(struct tpm_chip *chip, u8 *out, size_t max)
>  	if (!out || max > TPM_MAX_RNG_DATA)
>  		return -EINVAL;
>  
> +	/* NULL will be returned if chip is suspended */

spurious diff, remove

>  	chip = tpm_find_get_ops(chip);
>  	if (!chip)
>  		return -ENODEV;
>  
> -	/* Give back zero bytes, as TPM chip has not yet fully resumed: */
> -	if (chip->flags & TPM_CHIP_FLAG_SUSPENDED) {
> -		rc = 0;
> -		goto out;
> -	}
> -
>  	if (chip->flags & TPM_CHIP_FLAG_TPM2)
>  		rc = tpm2_get_random(chip, out, max);
>  	else
>  		rc = tpm1_get_random(chip, out, max);
>  
> -out:
>  	tpm_put_ops(chip);
>  	return rc;
>  }
> 
> ---
> base-commit: 2014c95afecee3e76ca4a56956a936e23283f05b
> change-id: 20250205-tpm-suspend-b22f745f3124
> 
> Best regards,
> -- 
> Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
> 

BR, Jarkko

