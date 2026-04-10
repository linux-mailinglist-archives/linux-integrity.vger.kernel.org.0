Return-Path: <linux-integrity+bounces-9158-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2JVOGwhq2Wn5pQgAu9opvQ
	(envelope-from <linux-integrity+bounces-9158-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Fri, 10 Apr 2026 23:22:16 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DBC683DCDAC
	for <lists+linux-integrity@lfdr.de>; Fri, 10 Apr 2026 23:22:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0427D3006B37
	for <lists+linux-integrity@lfdr.de>; Fri, 10 Apr 2026 21:22:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03E993B27D2;
	Fri, 10 Apr 2026 21:22:09 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C25E3A7844;
	Fri, 10 Apr 2026 21:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775856128; cv=none; b=MlsZIcyX7YIh6VxaF8du+88wtnGeWOWOu//WWgEpzWGe8i2oklhpEmldM1vAIzCwCpVYXI/aozxiDlw+PhvjBwTlYIr0NIsEsStfhnzkWnTCj3pPDpVzth+p2HSMEy3FN2H8Oy+kU4XoupDMaDyQGqkWWH2niEMLhPh1ALcuzcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775856128; c=relaxed/simple;
	bh=WoNeDqGPNna8+1ZONE7iaFqpncChQUctQshNBds29YU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZRnvgd/SpI6KdU+cElwtKsVaoRTZeKp10PxGaHyZdXxldssghqPfYcjHXaqBWY6G7JEpbBvi/wWtTNONXDg6hbSP06LFK/209KVhh7qV/C6leKHKG5Rsi6jdaJtTDnv7XAHGdiRzpHKR5CEb6n1du64umThOxd9yrmKYE1Kd5k4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.1.112] (dynamic-077-011-040-087.77.11.pool.telefonica.de [77.11.40.87])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 32FEA4C2C37D77;
	Fri, 10 Apr 2026 23:21:50 +0200 (CEST)
Message-ID: <6f67d0f9-43bf-42fc-af84-5c24ad560594@molgen.mpg.de>
Date: Fri, 10 Apr 2026 23:21:45 +0200
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tpm_tis: Check for an error after exhausting send retires
To: Jacqueline Wong <jacqwong@google.com>
Cc: peterhuewe@gmx.de, jarkko@kernel.org, jgg@ziepe.ca,
 Alexander.Steffen@infineon.com, linux-integrity@vger.kernel.org,
 linux-kernel@vger.kernel.org, axelrasmussen@google.com,
 Jordan Hand <jhand@google.com>
References: <20260410211350.1132611-1-jacqwong@google.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20260410211350.1132611-1-jacqwong@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmx.de,kernel.org,ziepe.ca,infineon.com,vger.kernel.org,google.com];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9158-lists,linux-integrity=lfdr.de];
	DMARC_NA(0.00)[mpg.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-integrity];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pmenzel@molgen.mpg.de,linux-integrity@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[9];
	R_DKIM_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,molgen.mpg.de:mid]
X-Rspamd-Queue-Id: DBC683DCDAC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Dear Jacqueline,


Thank you for your patch.

Am 10.04.26 um 23:13 schrieb Jacqueline Wong:
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

Please paste the logs without and with your patch of an effected system.

*Additionally* is often a good indicator to split the patch into even 
smaller pieces. ;-)

> Fixes: 280db21e153d8 ("tpm_tis: Resend command to recover from data transfer errors")
> Signed-off-by: Jordan Hand <jhand@google.com>
> ---
>   drivers/char/tpm/tpm_tis_core.c | 11 ++++++++++-
>   1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
> index e2a1769081b1..b78937841879 100644
> --- a/drivers/char/tpm/tpm_tis_core.c
> +++ b/drivers/char/tpm/tpm_tis_core.c
> @@ -471,6 +471,8 @@ static int tpm_tis_send_data(struct tpm_chip *chip, const u8 *buf, size_t len)
>   		status = tpm_tis_status(chip);
>   		if (!itpm && (status & TPM_STS_DATA_EXPECT) == 0) {
>   			rc = -EIO;
> +			dev_err(&chip->dev, "TPM_STS_DATA_EXPECT should be set. sts = 0x%08x\n",
> +					status);
>   			goto out_err;
>   		}
>   	}
> @@ -491,6 +493,8 @@ static int tpm_tis_send_data(struct tpm_chip *chip, const u8 *buf, size_t len)
>   	status = tpm_tis_status(chip);
>   	if (!itpm && (status & TPM_STS_DATA_EXPECT) != 0) {
>   		rc = -EIO;
> +		dev_err(&chip->dev, "TPM_STS_DATA_EXPECT should be unset. sts = 0x%08x\n",
> +				status);
>   		goto out_err;
>   	}
>   
> @@ -552,11 +556,16 @@ static int tpm_tis_send_main(struct tpm_chip *chip, const u8 *buf, size_t len)
>   			break;
>   		else if (rc != -EAGAIN && rc != -EIO)
>   			/* Data transfer failed, not recoverable */
> -			return rc;
> +			goto out_err;
>   
>   		usleep_range(priv->timeout_min, priv->timeout_max);
>   	}
>   
> +	if (rc == -EAGAIN || rc == -EIO) {
> +		dev_err(&chip->dev, "Exhausted tpm_tis_send_data retries\n");

Please also print the number of retries.

> +		goto out_err;
> +	}
> +
>   	/* go and do it */
>   	rc = tpm_tis_write8(priv, TPM_STS(priv->locality), TPM_STS_GO);
>   	if (rc < 0)

Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>


Kind regards,

Paul

