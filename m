Return-Path: <linux-integrity+bounces-4056-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 214D79C057D
	for <lists+linux-integrity@lfdr.de>; Thu,  7 Nov 2024 13:18:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C31491F22C94
	for <lists+linux-integrity@lfdr.de>; Thu,  7 Nov 2024 12:18:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E1EA17BB0D;
	Thu,  7 Nov 2024 12:18:04 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFAC91CC8BD
	for <linux-integrity@vger.kernel.org>; Thu,  7 Nov 2024 12:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730981884; cv=none; b=hJmNEpLk1j+DrJdHzTz8YX2SonCEZMza2gkPUnsUbv2VFkbtaDGQmpfOIpWaS3GnM9VzawvME1xGWkBWCo5gv1X41wizuV+h8FyIwG7sOA2+p8Jkul86OAPPCVNMklzpQ4XlzgdasQ+t4yi3/Zvqa2h842W6deYezRnMgWO8Z6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730981884; c=relaxed/simple;
	bh=AjCih7E4LOgOBfp9Lhk4cDAXkY9pkOr7iCnSsQD6EkA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oFEUlgeZ9dDFqWEghpMhcPNwsQHQTRKj4C+Uf3WCdL33R1cv+hZA/Q3a2aftzbohSz0p+0XVdUKi1F0SO/XnrJ3d9VOz5Tr6Frl1QAhF2Jc1E+HN/yJhueBAHA7GcbhGt3n6++58KRRBFGlC7ngbSPJwVumNXfQReyHBaKwfIXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [141.14.220.45] (g45.guest.molgen.mpg.de [141.14.220.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id AC45C61E5FE05;
	Thu, 07 Nov 2024 13:17:33 +0100 (CET)
Message-ID: <87f11490-06ab-43a5-8058-102722a3c3ba@molgen.mpg.de>
Date: Thu, 7 Nov 2024 13:17:33 +0100
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tpm/eventlog: Use kvmalloc() for event log buffer
To: Takashi Iwai <tiwai@suse.de>
Cc: Jarkko Sakkinen <jarkko@kernel.org>, Peter Huewe <peterhuewe@gmx.de>,
 Jason Gunthorpe <jgg@ziepe.ca>, linux-integrity@vger.kernel.org,
 Andy Liang <andy.liang@hpe.com>, jenifer.golmitz@hpe.com
References: <20241107112054.28448-1-tiwai@suse.de>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20241107112054.28448-1-tiwai@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Takashi,


Thank you for the patch.

Am 07.11.24 um 12:18 schrieb Takashi Iwai:
> The TPM2 ACPI table may request a large size for the event log, and it
> may be over the max size of kmalloc().  When this happens, the driver

What is kmalloc()’s maximum size?

> spews the kernel WARNING at the probe time, but the error is
> eventually ignored in the caller side, and it results in the missing
> TPM event log exposure.
> 
> This patch replaces the devm_kmalloc() call with kvmalloc() to allow
> larger sizes.  Since there is no devm variant for kvmalloc(), now it's
> managed manually via devres_alloc() and devres_add().

As the access to the bug report is restricted, are you at liberty to 
share the system you’ve seen this on?

> Reported-and-tested-by: Andy Liang <andy.liang@hpe.com>
> Cc: jenifer.golmitz@hpe.com
> Link: https://bugzilla.suse.com/show_bug.cgi?id=1232421
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> ---
>   drivers/char/tpm/eventlog/acpi.c | 21 ++++++++++++++++++---
>   1 file changed, 18 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/char/tpm/eventlog/acpi.c b/drivers/char/tpm/eventlog/acpi.c
> index 69533d0bfb51..56f7d73fa6bf 100644
> --- a/drivers/char/tpm/eventlog/acpi.c
> +++ b/drivers/char/tpm/eventlog/acpi.c
> @@ -63,6 +63,13 @@ static bool tpm_is_tpm2_log(void *bios_event_log, u64 len)
>   	return n == 0;
>   }
>   
> +static void bios_event_log_release(struct device *dev, void *res)
> +{
> +	void **logp = res;
> +
> +	kvfree(*logp);
> +}
> +
>   /* read binary bios log */
>   int tpm_read_log_acpi(struct tpm_chip *chip)
>   {
> @@ -71,6 +78,7 @@ int tpm_read_log_acpi(struct tpm_chip *chip)
>   	void __iomem *virt;
>   	u64 len, start;
>   	struct tpm_bios_log *log;
> +	void **logp;
>   	struct acpi_table_tpm2 *tbl;
>   	struct acpi_tpm2_phy *tpm2_phy;
>   	int format;
> @@ -136,9 +144,16 @@ int tpm_read_log_acpi(struct tpm_chip *chip)
>   	}
>   
>   	/* malloc EventLog space */
> -	log->bios_event_log = devm_kmalloc(&chip->dev, len, GFP_KERNEL);
> -	if (!log->bios_event_log)
> +	logp = devres_alloc(bios_event_log_release, sizeof(*logp), GFP_KERNEL);
> +	if (!logp)
>   		return -ENOMEM;
> +	devres_add(&chip->dev, logp);
> +	log->bios_event_log = kvmalloc(len, GFP_KERNEL);
> +	if (!log->bios_event_log) {
> +		ret = -ENOMEM;
> +		goto err;
> +	}
> +	*logp = log->bios_event_log;
>   
>   	log->bios_event_log_end = log->bios_event_log + len;
>   
> @@ -164,7 +179,7 @@ int tpm_read_log_acpi(struct tpm_chip *chip)
>   	return format;
>   
>   err:
> -	devm_kfree(&chip->dev, log->bios_event_log);
> +	devres_release(&chip->dev, bios_event_log_release, NULL, NULL);
>   	log->bios_event_log = NULL;
>   	return ret;
>   }

The diff looks good to me.


Kind regards,

Paul

