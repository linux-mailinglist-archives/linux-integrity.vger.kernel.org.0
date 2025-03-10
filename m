Return-Path: <linux-integrity+bounces-5211-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1677FA5972E
	for <lists+linux-integrity@lfdr.de>; Mon, 10 Mar 2025 15:13:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46CD8168E89
	for <lists+linux-integrity@lfdr.de>; Mon, 10 Mar 2025 14:13:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9691522A818;
	Mon, 10 Mar 2025 14:12:58 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0821322A80A;
	Mon, 10 Mar 2025 14:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741615978; cv=none; b=JD1MaAttoJbycO+LZBdeOog/tbXsleUyYAVTXEcmhPrbccMHc0TOJgEtN1s1HwezzvqReF0IKah8SVo6JxDRhEgxjjjYRtMkregB0zqku/IF/jtwC3zfNThcR9Ywvpd7RHivOsXHJLQYw2kAdTtmkIHtsbBldWTS2K1G4GfHgEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741615978; c=relaxed/simple;
	bh=GxBwBLFH48jh32FDkdDhoDf5IRc91N9B3eYtyK7KSIA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q++FYyGFj4DHeo8yJEykvbZfLYSBR0PZtgi6M5Ea8QS34y9Aw/LWSGSq3/4DJ79//Dn8cyt1NvyVIQw4qXBJL7II6D1zqk3vY8prAHMlh/22wmlVG8eHylAQgrG6k/GaY39vQdraEBfXTQORtyC12gfprOOjx+RsjC26SSrVg/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.0.2] (ip5f5af04a.dynamic.kabel-deutschland.de [95.90.240.74])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id C778F61E647BD;
	Mon, 10 Mar 2025 15:12:18 +0100 (CET)
Message-ID: <bc28fec8-6ab3-4633-86ea-fd1b35ca91c8@molgen.mpg.de>
Date: Mon, 10 Mar 2025 15:12:18 +0100
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] tpm, tpm_tis: Workaround failed command reception on
 Infineon devices
To: Jonathan McDowell <noodles@earth.li>
Cc: Jarkko Sakkinen <jarkko@kernel.org>, Peter Huewe <peterhuewe@gmx.de>,
 Jason Gunthorpe <jgg@ziepe.ca>,
 James Bottomley <James.Bottomley@hansenpartnership.com>,
 Stefan Berger <stefanb@linux.ibm.com>, linux-integrity@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <Z8lkSKOqBgt78pU2@earth.li> <Z8ogT_gERUYstPbK@kernel.org>
 <Z8sgfMmsfn894yLj@earth.li> <Z8sixTuKG5sxO-D1@kernel.org>
 <Z87Y69l5_GbzlLfp@earth.li>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <Z87Y69l5_GbzlLfp@earth.li>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Jonathan,


Some nits, should you resend. Feel free to ignore. The verb *work 
around* is spelled with a space.

Am 10.03.25 um 13:19 schrieb Jonathan McDowell:
> From: Jonathan McDowell <noodles@meta.com>
> 
> Some Infineon devices have a issue where the status register will get
> stuck with a quick REQUEST_USE / COMMAND_READY sequence. This is not
> simply a matter of requiring a longer timeout; the work around is to

The noun without. ;-)

> retry the command submission. Add appropriate logic to do this in the
> send path.

Does the workaround have downsides?

> This is fixed in later firmware revisions, but those are not always
> available, and cannot generally be easily updated from outside a
> firmware environment.

Please mention the affected revisions. Is there an errata for tis.

> Testing has been performed with a simple repeated loop of doing a
> TPM2_CC_GET_CAPABILITY for TPM_CAP_PROP_MANUFACTURER using the Go code
> at:
> 
>   https://the.earth.li/~noodles/tpm-stuff/timeout-reproducer-simple.go

Awesome. Thank you for sharing.

> It can take several hours to reproduce, and several million operations.
> 
> Signed-off-by: Jonathan McDowell <noodles@meta.com>
> ---
> v2: Rename flag to TPM_TIS_STATUS_VALID_RETRY
> 
>   drivers/char/tpm/tpm_tis_core.c | 17 ++++++++++++++---
>   drivers/char/tpm/tpm_tis_core.h |  1 +
>   include/linux/tpm.h             |  1 +
>   3 files changed, 16 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/ 
> tpm_tis_core.c
> index c969a1793184..4ab69c3e103c 100644
> --- a/drivers/char/tpm/tpm_tis_core.c
> +++ b/drivers/char/tpm/tpm_tis_core.c
> @@ -463,7 +463,10 @@ static int tpm_tis_send_data(struct tpm_chip *chip, 
> const u8 *buf, size_t len)
> 
>           if (wait_for_tpm_stat(chip, TPM_STS_VALID, chip->timeout_c,
>                       &priv->int_queue, false) < 0) {
> -            rc = -ETIME;
> +            if (test_bit(TPM_TIS_STATUS_VALID_RETRY, &priv->flags))
> +                rc = -EAGAIN;
> +            else
> +                rc = -ETIME;

I’d use a ternary operator as the same variable is assigned to.

>               goto out_err;
>           }
>           status = tpm_tis_status(chip);
> @@ -480,7 +483,10 @@ static int tpm_tis_send_data(struct tpm_chip *chip, 
> const u8 *buf, size_t len)
> 
>       if (wait_for_tpm_stat(chip, TPM_STS_VALID, chip->timeout_c,
>                   &priv->int_queue, false) < 0) {
> -        rc = -ETIME;
> +        if (test_bit(TPM_TIS_STATUS_VALID_RETRY, &priv->flags))
> +            rc = -EAGAIN;
> +        else
> +            rc = -ETIME;
>           goto out_err;
>       }
>       status = tpm_tis_status(chip);
> @@ -545,9 +551,11 @@ static int tpm_tis_send_main(struct tpm_chip *chip, 
> const u8 *buf, size_t len)
>           if (rc >= 0)
>               /* Data transfer done successfully */
>               break;
> -        else if (rc != -EIO)
> +        else if (rc != EAGAIN && rc != -EIO)
>               /* Data transfer failed, not recoverable */
>               return rc;
> +
> +        usleep_range(priv->timeout_min, priv->timeout_max);
>       }
> 
>       /* go and do it */
> @@ -1143,6 +1151,9 @@ int tpm_tis_core_init(struct device *dev, struct 
> tpm_tis_data *priv, int irq,
>           priv->timeout_max = TIS_TIMEOUT_MAX_ATML;
>       }
> 
> +    if (priv->manufacturer_id == TPM_VID_IFX)
> +        set_bit(TPM_TIS_STATUS_VALID_RETRY, &priv->flags);
> +
>       if (is_bsw()) {
>           priv->ilb_base_addr = ioremap(INTEL_LEGACY_BLK_BASE_ADDR,
>                       ILB_REMAP_SIZE);
> diff --git a/drivers/char/tpm/tpm_tis_core.h b/drivers/char/tpm/ 
> tpm_tis_core.h
> index 690ad8e9b731..970d02c337c7 100644
> --- a/drivers/char/tpm/tpm_tis_core.h
> +++ b/drivers/char/tpm/tpm_tis_core.h
> @@ -89,6 +89,7 @@ enum tpm_tis_flags {
>       TPM_TIS_INVALID_STATUS        = 1,
>       TPM_TIS_DEFAULT_CANCELLATION    = 2,
>       TPM_TIS_IRQ_TESTED        = 3,
> +    TPM_TIS_STATUS_VALID_RETRY    = 4,
>   };
> 
>   struct tpm_tis_data {
> diff --git a/include/linux/tpm.h b/include/linux/tpm.h
> index 20a40ade8030..6c3125300c00 100644
> --- a/include/linux/tpm.h
> +++ b/include/linux/tpm.h
> @@ -335,6 +335,7 @@ enum tpm2_cc_attrs {
>   #define TPM_VID_WINBOND  0x1050
>   #define TPM_VID_STM      0x104A
>   #define TPM_VID_ATML     0x1114
> +#define TPM_VID_IFX      0x15D1
> 
>   enum tpm_chip_flags {
>       TPM_CHIP_FLAG_BOOTSTRAPPED        = BIT(0),


