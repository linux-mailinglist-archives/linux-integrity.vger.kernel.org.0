Return-Path: <linux-integrity+bounces-6931-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 76E7DB37A0A
	for <lists+linux-integrity@lfdr.de>; Wed, 27 Aug 2025 07:55:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3453D3643FF
	for <lists+linux-integrity@lfdr.de>; Wed, 27 Aug 2025 05:55:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78F54305E3B;
	Wed, 27 Aug 2025 05:55:48 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D332F275872
	for <linux-integrity@vger.kernel.org>; Wed, 27 Aug 2025 05:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756274148; cv=none; b=q0hEyyHBpLd3WuYvgcyV0UGcl/iPoLXu/zKj0F7MCVK8raxlBxqj/bn6vrQKoOpR6PPYDnq0nt3aniEWrJ+ShlLD0NZBcuF/E4Rw34phd6guM4Eg8YwPh79RjQ31UaRddzcQFL6BFPQmKVGw6vrUNj/H18si8nUpEFAZhI/4K4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756274148; c=relaxed/simple;
	bh=y+jagLR+CrXlGWFTHzinA/vicPheBPppFI2M1maLkTk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Brvmjixxmi9cXPY9qZjEVKM3nfqnYbLIALYY34h3dqLGNyKDIPoww6CnBVAeDvNw7zJ9F59XkdIGXeGVyF4MtR7exCgL8gB2uGx10n3W9QVaMZWaHzkslG5pcCQixVV8c+bD3g+BuXk7fFM+gd2Jg0TcydHVyok7l57jr7IbvG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.2.202] (p5b13a549.dip0.t-ipconnect.de [91.19.165.73])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 93EDC60213B1D;
	Wed, 27 Aug 2025 07:55:24 +0200 (CEST)
Message-ID: <e576d3a8-2693-4445-8cd0-997afb5e5dc2@molgen.mpg.de>
Date: Wed, 27 Aug 2025 07:55:23 +0200
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] tpm: prevents local DOS via tpm/tpm0/ppi/*operations
To: Denis Aleksandrov <daleksan@redhat.com>
Cc: peterhuewe@gmx.de, jarkko@kernel.org, jgg@ziepe.ca,
 linux-integrity@vger.kernel.org, Jan Stancek <jstancek@redhat.com>
References: <20250827022102.17731-1-daleksan@redhat.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20250827022102.17731-1-daleksan@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Denis,


Thank you for your patch. In the summary, I’d use imperative mood:

tpm: Prevent local DOS …

Am 27.08.25 um 04:21 schrieb Denis Aleksandrov:
> Reads on tpm/tpm0/ppi/*operations can become very long on
> misconfigured systems. Reading the TPM is a blocking operation,
> thus a user could effectively trigger a DOS.
> 
> Resolve this by caching the results and avoiding the blocking
> operations after the first read.

If you could elaborate, how to test this, and in possible error cases, 
how to debug this – for example, how to disable the cache–, that’d be great.

> 
> Reported-by: Jan Stancek <jstancek@redhat.com>
> Signed-off-by: Denis Aleksandrov <daleksan@redhat.com>
> ---
> 
> Changes in v2:
>   - Replaced file permission change with a caching mechanism as
>     suggested by Jarkko.
> 
>   drivers/char/tpm/tpm_ppi.c | 88 ++++++++++++++++++++++++++++----------
>   1 file changed, 65 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm_ppi.c b/drivers/char/tpm/tpm_ppi.c
> index d53fce1c9d6f..e0212893748e 100644
> --- a/drivers/char/tpm/tpm_ppi.c
> +++ b/drivers/char/tpm/tpm_ppi.c
> @@ -33,6 +33,21 @@ static const guid_t tpm_ppi_guid =
>   	GUID_INIT(0x3DDDFAA6, 0x361B, 0x4EB4,
>   		  0xA4, 0x24, 0x8D, 0x10, 0x08, 0x9D, 0x16, 0x53);
>   
> +static const char * const tpm_ppi_info[] = {
> +	"Not implemented",
> +	"BIOS only",
> +	"Blocked for OS by BIOS",

Is this x86 specific? If not maybe use *system firmware*?

> +	"User required",
> +	"User not required",
> +};
> +
> +/* A spinlock to protect access to the cache from concurrent reads */
> +static DEFINE_SPINLOCK(tpm_ppi_lock);
> +
> +static u32 ppi_operations_cache[PPI_VS_REQ_END + 1];
> +
> +static bool ppi_cache_populated;
> +
>   static bool tpm_ppi_req_has_parameter(u64 req)
>   {
>   	return req == 23;
> @@ -277,8 +292,7 @@ static ssize_t tpm_show_ppi_response(struct device *dev,
>   	return status;
>   }
>   
> -static ssize_t show_ppi_operations(acpi_handle dev_handle, char *buf, u32 start,
> -				   u32 end)
> +static ssize_t cache_ppi_operations(acpi_handle dev_handle, char *buf)
>   {
>   	int i;
>   	u32 ret;
> @@ -286,34 +300,22 @@ static ssize_t show_ppi_operations(acpi_handle dev_handle, char *buf, u32 start,
>   	union acpi_object *obj, tmp;
>   	union acpi_object argv = ACPI_INIT_DSM_ARGV4(1, &tmp);
>   
> -	static char *info[] = {
> -		"Not implemented",
> -		"BIOS only",
> -		"Blocked for OS by BIOS",
> -		"User required",
> -		"User not required",
> -	};
> -
>   	if (!acpi_check_dsm(dev_handle, &tpm_ppi_guid, TPM_PPI_REVISION_ID_1,
>   			    1 << TPM_PPI_FN_GETOPR))
>   		return -EPERM;
>   
>   	tmp.integer.type = ACPI_TYPE_INTEGER;
> -	for (i = start; i <= end; i++) {
> +	for (i = 0; i <= PPI_VS_REQ_END; i++) {
>   		tmp.integer.value = i;
>   		obj = tpm_eval_dsm(dev_handle, TPM_PPI_FN_GETOPR,
>   				   ACPI_TYPE_INTEGER, &argv,
>   				   TPM_PPI_REVISION_ID_1);
> -		if (!obj) {
> +		if (!obj)
>   			return -ENOMEM;
> -		} else {
> -			ret = obj->integer.value;
> -			ACPI_FREE(obj);
> -		}
>   
> -		if (ret > 0 && ret < ARRAY_SIZE(info))
> -			len += sysfs_emit_at(buf, len, "%d %d: %s\n",
> -					     i, ret, info[ret]);
> +		ret = obj->integer.value;
> +		ppi_operations_cache[i] = ret;
> +		ACPI_FREE(obj);
>   	}
>   
>   	return len;
> @@ -323,20 +325,60 @@ static ssize_t tpm_show_ppi_tcg_operations(struct device *dev,
>   					   struct device_attribute *attr,
>   					   char *buf)
>   {
> +	int i;
> +	ssize_t len = 0;
> +	u32 ret;
>   	struct tpm_chip *chip = to_tpm_chip(dev);
>   
> -	return show_ppi_operations(chip->acpi_dev_handle, buf, 0,
> -				   PPI_TPM_REQ_MAX);
> +	spin_lock(&tpm_ppi_lock);
> +	if (!ppi_cache_populated) {
> +		len = cache_ppi_operations(chip->acpi_dev_handle, buf);
> +
> +		if (len < 0)
> +			return len;
> +
> +		ppi_cache_populated = true;
> +	}
> +
> +	for (i = 0; i <= PPI_TPM_REQ_MAX; i++) {
> +		ret = ppi_operations_cache[i];
> +		if (ret > 0 && ret < ARRAY_SIZE(tpm_ppi_info))
> +			len += sysfs_emit_at(buf, len, "%d %d: %s\n",
> +							i, ret, tpm_ppi_info[ret]);
> +	}
> +	spin_unlock(&tpm_ppi_lock);
> +
> +	return len;
>   }
>   
>   static ssize_t tpm_show_ppi_vs_operations(struct device *dev,
>   					  struct device_attribute *attr,
>   					  char *buf)
>   {
> +	int i;
> +	ssize_t len = 0;
> +	u32 ret;
>   	struct tpm_chip *chip = to_tpm_chip(dev);
>   
> -	return show_ppi_operations(chip->acpi_dev_handle, buf, PPI_VS_REQ_START,
> -				   PPI_VS_REQ_END);
> +	spin_lock(&tpm_ppi_lock);
> +	if (!ppi_cache_populated) {
> +		len = cache_ppi_operations(chip->acpi_dev_handle, buf);
> +
> +		if (len < 0)
> +			return len;
> +
> +		ppi_cache_populated = true;
> +	}
> +
> +	for (i = PPI_VS_REQ_START; i <= PPI_VS_REQ_END; i++) {
> +		ret = ppi_operations_cache[i];
> +		if (ret > 0 && ret < ARRAY_SIZE(tpm_ppi_info))
> +			len += sysfs_emit_at(buf, len, "%d %d: %s\n",
> +							i, ret, tpm_ppi_info[ret]);
> +	}
> +	spin_unlock(&tpm_ppi_lock);
> +
> +	return len;
>   }
>   
>   static DEVICE_ATTR(version, S_IRUGO, tpm_show_ppi_version, NULL);

The diff looks good. Feel free to carry:

Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>


Kind regards,

Paul Menzel

