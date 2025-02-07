Return-Path: <linux-integrity+bounces-4749-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A48CBA2CB78
	for <lists+linux-integrity@lfdr.de>; Fri,  7 Feb 2025 19:39:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 310B416C7E2
	for <lists+linux-integrity@lfdr.de>; Fri,  7 Feb 2025 18:39:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0BC71B0409;
	Fri,  7 Feb 2025 18:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ItAped35"
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEE1D19C558
	for <linux-integrity@vger.kernel.org>; Fri,  7 Feb 2025 18:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738953070; cv=none; b=PlMMLU/ZyjZerHQ61YjX/yRtZPPwWrqL2RnASvW9hgkwCkYkTvUg0TLWU+nPgKdSTtY/BmIn0rq5LBztmVJmWigrFp5iamLNioJ9d6ti2kqrIkP9bfcTovU+vdqgDe6Vu169Go4zqCtpappWDMmoguJXGZQsAL3bX07ndptqvHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738953070; c=relaxed/simple;
	bh=Na1GaVD2WleUIhZHv7ETYMCMGvK53tjoGJNuoSccjUM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dlzuSVtl2A0tXKl7yh8Ssj9QzlyEi9TAq34v9S61FHIICnwWwSOolsNiHLS0o5dZCQp6++SISJo9P5H/XWJH8ss6s2LR6oK5H2txzVHuY4K5rh2G7yjKskz2hWRWkoNxRVhrT+tBFjkAm42eo1T0n6mh/Z0J0CiwWxzGTZfUpWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ItAped35; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738953067;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BN2ZmR2Ydnk53bpnRhCB0qi5vI3BoI4kNFdAP4vjWMQ=;
	b=ItAped35DM6/0QzYPKXbsVX/Fib1XNcJkEChIktwTo5q45hZiiGm7HJGOeSZRxIRMQGSrQ
	7iAcagaaEDEBpr+6NNt2Kj7RxVwH244znGatfNNLTVkbRoOd/izvNzCCbQq+zB4J76BJWn
	O6lrfx5i6e9BIm9p3Xa0v69zQrKOwlQ=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-636-BVPYQs13N42_ntX8o3RMxQ-1; Fri, 07 Feb 2025 13:31:05 -0500
X-MC-Unique: BVPYQs13N42_ntX8o3RMxQ-1
X-Mimecast-MFC-AGG-ID: BVPYQs13N42_ntX8o3RMxQ
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6dd43b16631so24118236d6.2
        for <linux-integrity@vger.kernel.org>; Fri, 07 Feb 2025 10:31:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738953065; x=1739557865;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BN2ZmR2Ydnk53bpnRhCB0qi5vI3BoI4kNFdAP4vjWMQ=;
        b=FPplQKGXC0kRMptEVIL0KF72npfuNVlRZsUYEzK6H6iGHoNh8RAE0AHZVkKe5tABTF
         tFmrRvJQHSRzrFozCZmucOib7XGZZLUqys8LnQHgHnl2703nf8Kk7sXOc94IrYukiGFq
         GzXDOOg/3vCabueY/qo/1h2PCjoOO2oKQMRNcEHoDRmZ1ESuLSwU4PM8vkwkowoDJ6PU
         9cJKsZw1kJa4UZBITR+Bjy/Fh+t+tmKhvtkFQthFr4/47cipkPv5oj7FltO05sUZwQPk
         qTuokPuJ4bSpAh+pio9cReLb3bpoX4xVlSU2O5/qkNmXE6zyKuUr/E3EedjlcSz6HeWN
         AIjw==
X-Forwarded-Encrypted: i=1; AJvYcCW5Weh2tA07Sfkj2eUq05TdFXZZw7SsGvnZfkiA4eTxcx4w2wnBNn+6T/iNlXc6HYfnwDdle8OTcT30q9lxM1U=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQ2/CyPKdMX4ihmJJ2lRW73dTLqYu0aEN6HZaiE1oxnvXhSG4F
	vg43w3IwBFzEwqXdy9K3uAsFT5obu+GTIrqKA6DvQI/YaR1d842jvFNqIc+kPnQILWxpNxuEluq
	2Lwy35LI2+PoPuFsw/oHEY4pBsOpvtl5r4z6R/E0iLBtP1CAHHvigdTPuADrDX6CZ/A==
X-Gm-Gg: ASbGncsroVCO6S54edgAlpqCOL36JMPx/DxHVGvqtp0ObNoW2bynl+oNd9cMvsH+klD
	tPTMTybV/LBTPitrTlI7biBhSS9zkkzsoQDmQxzzKrx/tbDqnCm8MYbml961SLwku/8m6dn46BL
	j2uzFlPPFUJYAcBLsuPSOSmyj4+PCw+Pmx/AusxLlmNSF7MG1x8x/v8iCYoqkNoAkl9w7s7Aglp
	z0UX3K69EVulFp+plkJglWvMex0UnsoKUna4cnreQvOpJccdQIOcljJh0HMMS2zhA7wXggRvyAF
	B4asdbl3tNmU+ovN0vN8lHGS9heAOXSe4A==
X-Received: by 2002:a05:6214:2688:b0:6d8:850a:4d77 with SMTP id 6a1803df08f44-6e4455c19a6mr64469736d6.7.1738953065290;
        Fri, 07 Feb 2025 10:31:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEk4+CS8K2R5Bg2mrVOVObtVzytFfN1/LyTW9OYchrvGyzV5wA3IwTF+tEX4OmsXLElACR85Q==
X-Received: by 2002:a05:6214:2688:b0:6d8:850a:4d77 with SMTP id 6a1803df08f44-6e4455c19a6mr64469426d6.7.1738953064964;
        Fri, 07 Feb 2025 10:31:04 -0800 (PST)
Received: from localhost (ip70-163-223-251.ph.ph.cox.net. [70.163.223.251])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e44e113e99sm4461126d6.98.2025.02.07.10.31.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2025 10:31:04 -0800 (PST)
Date: Fri, 7 Feb 2025 11:31:03 -0700
From: Jerry Snitselaar <jsnitsel@redhat.com>
To: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Cc: Peter Huewe <peterhuewe@gmx.de>, Jarkko Sakkinen <jarkko@kernel.org>, 
	Jason Gunthorpe <jgg@ziepe.ca>, linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Mike Seo <mikeseohyungjin@gmail.com>, kernel-dev@igalia.com, stable@vger.kernel.org
Subject: Re: [PATCH v2] tpm: do not start chip while suspended
Message-ID: <nounmgquiu46ii5kjsteg7r3qi5c6xmnuu4rlurxhk5mlsqq5m@w4lvevxc3eoa>
References: <20250207-tpm-suspend-v2-1-b8cfb51d43ce@igalia.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250207-tpm-suspend-v2-1-b8cfb51d43ce@igalia.com>

On Fri, Feb 07, 2025 at 03:07:46PM -0300, Thadeu Lima de Souza Cascardo wrote:
> Checking TPM_CHIP_FLAG_SUSPENDED after the call to tpm_find_get_ops() can
> lead to a spurious tpm_chip_start() call:
> 
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
> [35985.503942]  tpm_try_get_ops+0x57/0x90
> [35985.503948]  tpm_find_get_ops+0x26/0xd0
> [35985.503955]  tpm_get_random+0x2d/0x80
> 
> Don't move forward with tpm_chip_start() inside tpm_try_get_ops(), unless
> TPM_CHIP_FLAG_SUSPENDED is not set. tpm_find_get_ops() will return NULL in
> such a failure case.
> 
> Fixes: 9265fed6db60 ("tpm: Lock TPM chip in tpm_pm_suspend() first")
> Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
> Cc: stable@vger.kernel.org
> Cc: Jerry Snitselaar <jsnitsel@redhat.com>
> Cc: Mike Seo <mikeseohyungjin@gmail.com>
> Cc: Jarkko Sakkinen <jarkko@kernel.org>

Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>

> ---
> Changes in v2:
> - Improve commit message as suggested by Jarkko Sakkinen.
> - Link to v1: https://lore.kernel.org/r/20250205-tpm-suspend-v1-1-fb89a29c0b69@igalia.com
> ---
>  drivers/char/tpm/tpm-chip.c      | 5 +++++
>  drivers/char/tpm/tpm-interface.c | 7 -------
>  2 files changed, 5 insertions(+), 7 deletions(-)
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
> index b1daa0d7b341b1a4c71a200115f0d29d2e87512d..f62f7871edbdb0181fad8af3367878308fa8a454 100644
> --- a/drivers/char/tpm/tpm-interface.c
> +++ b/drivers/char/tpm/tpm-interface.c
> @@ -445,18 +445,11 @@ int tpm_get_random(struct tpm_chip *chip, u8 *out, size_t max)
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


