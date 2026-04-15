Return-Path: <linux-integrity+bounces-9190-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id RgNCCSX63mmzNAAAu9opvQ
	(envelope-from <linux-integrity+bounces-9190-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Wed, 15 Apr 2026 04:38:29 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 117143FFCE8
	for <lists+linux-integrity@lfdr.de>; Wed, 15 Apr 2026 04:38:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CC6F03019DB5
	for <lists+linux-integrity@lfdr.de>; Wed, 15 Apr 2026 02:38:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3422314B8F;
	Wed, 15 Apr 2026 02:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LYsWWPpx"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90772314B77;
	Wed, 15 Apr 2026 02:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776220697; cv=none; b=Y9QBNeaCEt6ZLvP5rij8E67rvkUhCs3xM3d7PRNmGseUF9TCsdodIZPi3blXa26AjhClA1rWn3AQdqkXZR9fquKRycaT5Zon/NNLWOKbsZ0ax+pPX3LMhtGeEf+B16pvucAsLniBornPGlOh9NnbYAyavsdY/jWLYtiKk5ZU2jA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776220697; c=relaxed/simple;
	bh=39azMKTNlL6YESjrd49QChrlL7zprLIrlRZ3l/csz5E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c1WpoG8CeMwttZt96Y0HlEdYOyYAzvC96hpfcstlLeMkdzA/NEqinwBXf0txorqSwXihEH/abp4O3E7x2voO0D9aXssCg85C/M9ssQkjKzQH/WqVMCcZlfMWr/7WbPMuVKlpmVVaBP7Qe0KGWTOqPaiLZFO3+FrUuIP8odh+KRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LYsWWPpx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D7A3C2BCB5;
	Wed, 15 Apr 2026 02:38:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776220697;
	bh=39azMKTNlL6YESjrd49QChrlL7zprLIrlRZ3l/csz5E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LYsWWPpxTh0hxYYWq9dSoshPqX2mACNrmZXNdM5O9muKZyyempK6iXZVmUN8QUyGj
	 ZaBfZFy2m5rSRz8kkIDgtB2BSYhj7SxJWaOxTz/ixCDCal9BdHFmMJ+6HsS7sojEek
	 LZ8pgrIGmUXQhsrTpFhvGGC8FLnSSNEYjEni+ruh5yFq2tOV7LvdET6DAw5MS7h/De
	 cZJ4Zv+jtK2R/Ui+Oj20l9f2nqmMkVOe+/rE+f/Suj0v4FX9QusnWJLP9azglpZXFX
	 KjZR3r/q9/d2UiZZQOxEaQRbW2ReZwp7s6FPronC8B5NdCyHDLUXvRXVLbkDeq6gNT
	 rwgURg/cg6m5w==
Date: Wed, 15 Apr 2026 05:38:13 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Jacqueline Wong <jacqwong@google.com>
Cc: peterhuewe@gmx.de, jgg@ziepe.ca, Alexander.Steffen@infineon.com,
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
	axelrasmussen@google.com, Jordan Hand <jhand@google.com>
Subject: Re: [PATCH] tpm_tis: Check for an error after exhausting send retires
Message-ID: <ad76FXFSzJCL8L4y@kernel.org>
References: <20260410211350.1132611-1-jacqwong@google.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260410211350.1132611-1-jacqwong@google.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmx.de,ziepe.ca,infineon.com,vger.kernel.org,google.com];
	TAGGED_FROM(0.00)[bounces-9190-lists,linux-integrity=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jarkko@kernel.org,linux-integrity@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-integrity];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 117143FFCE8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Apr 10, 2026 at 09:13:50PM +0000, Jacqueline Wong wrote:
> From: Jordan Hand <jhand@google.com>
> 
> tpm_tis_send_main() will attempt to retry sending data TPM_RETRY times.
> Currently, if those retries are exhausted, the driver will attempt to
> call execute. The TPM will be in the wrong state, leading to the
> operation simply timing out.
> 
> Instead, if there is still an error after retries are exhausted, return
> that error immediately.
> 
> Additionally, add logging to more easily determine reason for transmit
> failure.
> 
> Fixes: 280db21e153d8 ("tpm_tis: Resend command to recover from data transfer errors")
> Signed-off-by: Jordan Hand <jhand@google.com>
> ---
>  drivers/char/tpm/tpm_tis_core.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
> index e2a1769081b1..b78937841879 100644
> --- a/drivers/char/tpm/tpm_tis_core.c
> +++ b/drivers/char/tpm/tpm_tis_core.c
> @@ -471,6 +471,8 @@ static int tpm_tis_send_data(struct tpm_chip *chip, const u8 *buf, size_t len)
>  		status = tpm_tis_status(chip);
>  		if (!itpm && (status & TPM_STS_DATA_EXPECT) == 0) {
>  			rc = -EIO;
> +			dev_err(&chip->dev, "TPM_STS_DATA_EXPECT should be set. sts = 0x%08x\n",
> +					status);
>  			goto out_err;
>  		}
>  	}
> @@ -491,6 +493,8 @@ static int tpm_tis_send_data(struct tpm_chip *chip, const u8 *buf, size_t len)
>  	status = tpm_tis_status(chip);
>  	if (!itpm && (status & TPM_STS_DATA_EXPECT) != 0) {
>  		rc = -EIO;
> +		dev_err(&chip->dev, "TPM_STS_DATA_EXPECT should be unset. sts = 0x%08x\n",
> +				status);
>  		goto out_err;
>  	}
>  
> @@ -552,11 +556,16 @@ static int tpm_tis_send_main(struct tpm_chip *chip, const u8 *buf, size_t len)
>  			break;
>  		else if (rc != -EAGAIN && rc != -EIO)
>  			/* Data transfer failed, not recoverable */
> -			return rc;
> +			goto out_err;
>  
>  		usleep_range(priv->timeout_min, priv->timeout_max);
>  	}
>  
> +	if (rc == -EAGAIN || rc == -EIO) {
> +		dev_err(&chip->dev, "Exhausted tpm_tis_send_data retries\n");
> +		goto out_err;
> +	}
> +
>  	/* go and do it */
>  	rc = tpm_tis_write8(priv, TPM_STS(priv->locality), TPM_STS_GO);
>  	if (rc < 0)
> -- 
> 2.53.0.1213.gd9a14994de-goog
> 

CHECK: Alignment should match open parenthesis
#35: FILE: drivers/char/tpm/tpm_tis_core.c:475:
+                       dev_err(&chip->dev, "TPM_STS_DATA_EXPECT should be set. sts = 0x%08x\n",
+                                       status);

CHECK: Alignment should match open parenthesis
#44: FILE: drivers/char/tpm/tpm_tis_core.c:497:
+               dev_err(&chip->dev, "TPM_STS_DATA_EXPECT should be unset. sts = 0x%08x\n",
+                               status);


I fixed these manually.

Good catch, thanks:

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

Applied.

BR, Jarkko

