Return-Path: <linux-integrity+bounces-5219-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25269A5BC8F
	for <lists+linux-integrity@lfdr.de>; Tue, 11 Mar 2025 10:46:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60A18164F78
	for <lists+linux-integrity@lfdr.de>; Tue, 11 Mar 2025 09:46:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FF8318DB35;
	Tue, 11 Mar 2025 09:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MrGR1Zdd"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07F85BA34;
	Tue, 11 Mar 2025 09:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741686382; cv=none; b=d1/hve6OfnasT6UOLf+bukkJFWiVtCes2lLU+JdhgA5PFV8cIwHH6qHCCl3XZ57w2dPhVajiy1vDNTWm4rLWt8RhL7GrlI98yN83/IkUVbCGu+jmcGcm2VJUGZWqWkQW5DKpZqRLTRKpxQNw/4i5rYsDnIrpHYR9mZTAm2/K3Fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741686382; c=relaxed/simple;
	bh=d8Jim/iiohrABurwDR77MNQoAwfat32rGLhjPDfq6ok=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m+Mcp/JvqUH1a92PXahgjpPCPxaC0kmIHPcxHFNU3DJae/pOHFH2YaP7/ZHB5BB/o4TStB7RUH6rPK3RR9o95F6rZKpEXqbksPTs0N+EoFExNJFFEuZN8O8L/JxYdZ7jORbJN2RSg/LvIQsgC+C29ZOETuhHweeFkpWQ0U0dj6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MrGR1Zdd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25927C4CEEB;
	Tue, 11 Mar 2025 09:46:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741686381;
	bh=d8Jim/iiohrABurwDR77MNQoAwfat32rGLhjPDfq6ok=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MrGR1Zdd7AsE2BOoAS7ZJwdLAitNHN8d7OyyL5dlHpHZi9OSlp2RgfE1ZhVVrNDUb
	 ejLAJ+xwuzDlB5Odcy5tRTzxeNvP3tMoRkGnE7aAzONlqAIfUW92nruRgHwXSqhAGA
	 RyStsAiyxKKi02hI8UVv7h1uJQVj26H1fjqHDgVUVLPcbsvsElbKwO0aYWIDYvGS2b
	 1jAO+pINQOnctXmuR7z3rM4oiWp+8H+ST771fHfv5PFj4qCp27UpfQvwH4f17XBV8o
	 0Qy2DmBzIQsXLRnu7oF+pDvtaRb2OFZBfxxBA7dGAxKJSfjlljjgCdOBiVH6nD+A4I
	 hOd8SlvpLHxag==
Date: Tue, 11 Mar 2025 11:46:17 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Jonathan McDowell <noodles@earth.li>
Cc: Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	Stefan Berger <stefanb@linux.ibm.com>,
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] tpm, tpm_tis: Workaround failed command reception on
 Infineon devices
Message-ID: <Z9AGaau3GdNpMBMC@kernel.org>
References: <Z8lkSKOqBgt78pU2@earth.li>
 <Z8ogT_gERUYstPbK@kernel.org>
 <Z8sgfMmsfn894yLj@earth.li>
 <Z8sixTuKG5sxO-D1@kernel.org>
 <Z87Y69l5_GbzlLfp@earth.li>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z87Y69l5_GbzlLfp@earth.li>

On Mon, Mar 10, 2025 at 12:19:55PM +0000, Jonathan McDowell wrote:
> From: Jonathan McDowell <noodles@meta.com>
> 
> Some Infineon devices have a issue where the status register will get
> stuck with a quick REQUEST_USE / COMMAND_READY sequence. This is not
> simply a matter of requiring a longer timeout; the work around is to
> retry the command submission. Add appropriate logic to do this in the
> send path.
> 
> This is fixed in later firmware revisions, but those are not always
> available, and cannot generally be easily updated from outside a
> firmware environment.
> 
> Testing has been performed with a simple repeated loop of doing a
> TPM2_CC_GET_CAPABILITY for TPM_CAP_PROP_MANUFACTURER using the Go code
> at:
> 
>  https://the.earth.li/~noodles/tpm-stuff/timeout-reproducer-simple.go
> 
> It can take several hours to reproduce, and several million operations.
> 
> Signed-off-by: Jonathan McDowell <noodles@meta.com>
> ---
> v2: Rename flag to TPM_TIS_STATUS_VALID_RETRY
> 
>  drivers/char/tpm/tpm_tis_core.c | 17 ++++++++++++++---
>  drivers/char/tpm/tpm_tis_core.h |  1 +
>  include/linux/tpm.h             |  1 +
>  3 files changed, 16 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
> index c969a1793184..4ab69c3e103c 100644
> --- a/drivers/char/tpm/tpm_tis_core.c
> +++ b/drivers/char/tpm/tpm_tis_core.c
> @@ -463,7 +463,10 @@ static int tpm_tis_send_data(struct tpm_chip *chip, const u8 *buf, size_t len)
>  		if (wait_for_tpm_stat(chip, TPM_STS_VALID, chip->timeout_c,
>  					&priv->int_queue, false) < 0) {
> -			rc = -ETIME;
> +			if (test_bit(TPM_TIS_STATUS_VALID_RETRY, &priv->flags))
> +				rc = -EAGAIN;
> +			else
> +				rc = -ETIME;
>  			goto out_err;
>  		}
>  		status = tpm_tis_status(chip);
> @@ -480,7 +483,10 @@ static int tpm_tis_send_data(struct tpm_chip *chip, const u8 *buf, size_t len)
>  	if (wait_for_tpm_stat(chip, TPM_STS_VALID, chip->timeout_c,
>  				&priv->int_queue, false) < 0) {
> -		rc = -ETIME;
> +		if (test_bit(TPM_TIS_STATUS_VALID_RETRY, &priv->flags))
> +			rc = -EAGAIN;
> +		else
> +			rc = -ETIME;
>  		goto out_err;
>  	}
>  	status = tpm_tis_status(chip);
> @@ -545,9 +551,11 @@ static int tpm_tis_send_main(struct tpm_chip *chip, const u8 *buf, size_t len)
>  		if (rc >= 0)
>  			/* Data transfer done successfully */
>  			break;
> -		else if (rc != -EIO)
> +		else if (rc != EAGAIN && rc != -EIO)
>  			/* Data transfer failed, not recoverable */
>  			return rc;
> +
> +		usleep_range(priv->timeout_min, priv->timeout_max);
>  	}
>  	/* go and do it */
> @@ -1143,6 +1151,9 @@ int tpm_tis_core_init(struct device *dev, struct tpm_tis_data *priv, int irq,
>  		priv->timeout_max = TIS_TIMEOUT_MAX_ATML;
>  	}
> +	if (priv->manufacturer_id == TPM_VID_IFX)
> +		set_bit(TPM_TIS_STATUS_VALID_RETRY, &priv->flags);
> +
>  	if (is_bsw()) {
>  		priv->ilb_base_addr = ioremap(INTEL_LEGACY_BLK_BASE_ADDR,
>  					ILB_REMAP_SIZE);
> diff --git a/drivers/char/tpm/tpm_tis_core.h b/drivers/char/tpm/tpm_tis_core.h
> index 690ad8e9b731..970d02c337c7 100644
> --- a/drivers/char/tpm/tpm_tis_core.h
> +++ b/drivers/char/tpm/tpm_tis_core.h
> @@ -89,6 +89,7 @@ enum tpm_tis_flags {
>  	TPM_TIS_INVALID_STATUS		= 1,
>  	TPM_TIS_DEFAULT_CANCELLATION	= 2,
>  	TPM_TIS_IRQ_TESTED		= 3,
> +	TPM_TIS_STATUS_VALID_RETRY	= 4,
>  };
>  struct tpm_tis_data {
> diff --git a/include/linux/tpm.h b/include/linux/tpm.h
> index 20a40ade8030..6c3125300c00 100644
> --- a/include/linux/tpm.h
> +++ b/include/linux/tpm.h
> @@ -335,6 +335,7 @@ enum tpm2_cc_attrs {
>  #define TPM_VID_WINBOND  0x1050
>  #define TPM_VID_STM      0x104A
>  #define TPM_VID_ATML     0x1114
> +#define TPM_VID_IFX      0x15D1
>  enum tpm_chip_flags {
>  	TPM_CHIP_FLAG_BOOTSTRAPPED		= BIT(0),
> -- 
> 2.48.1
> 

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko

