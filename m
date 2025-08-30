Return-Path: <linux-integrity+bounces-6951-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89E33B3CB5B
	for <lists+linux-integrity@lfdr.de>; Sat, 30 Aug 2025 16:11:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36239A05682
	for <lists+linux-integrity@lfdr.de>; Sat, 30 Aug 2025 14:11:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 290101D8DE1;
	Sat, 30 Aug 2025 14:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pc/i+4eh"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05425255F57
	for <linux-integrity@vger.kernel.org>; Sat, 30 Aug 2025 14:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756563104; cv=none; b=sw79pjk+N+nZMywRHMeoNEfi+bJ1pncJZv6We4xco+vvmWPYODA8mvwCLUuzdQHR3Ip0tOoKMgll6z+9CiHxTxjUEhDzglkJ5Fab3iagh4E3YoeRUo8pmR+d5UCxQrf9wbI9EMV6ujlpWU1DA43k5vAdMvgFxNEbmiz3ZUBZCm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756563104; c=relaxed/simple;
	bh=xwNGhsbS5aT2iIpATvurDxD7BhbTvVnaLanuLhdFi0A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bcj1/7yUwTF4Ws6lhhO0GyFl5sGe7xyUQIdTAyvpuFaCxJdzD76CRR8Wg1l78VRwC9JevsjWnzWkmciFZQx3QXBtxr39G9jfiOb7Cd/iG/O+Tgv41X0MjsXWr4DVFgokNuh/VbRTJoxK77i9eEd1O+ThKqxnbOhn2mmJDnOoFlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pc/i+4eh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E78DC4CEEB;
	Sat, 30 Aug 2025 14:11:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756563103;
	bh=xwNGhsbS5aT2iIpATvurDxD7BhbTvVnaLanuLhdFi0A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pc/i+4ehgQm1FSokgqs8Z9uu9est5jQVLlR8FfBFtWUNNfFQ83RkLTbI/xXOadlln
	 ORUYD8FnQHhVu3mYWclw43NYW/MTQsNtZWes3xPIorq5LfA9xB8agWwbEvetLdEmzC
	 GIB44Gtr6jJsMxRm29cSjPlPJp8g6SPahabx5FY7qRK5uGNXlLsK1fb3y0+/CQHe/+
	 wGlqR2x0nevpaBTmUptjtfMtCS3pJT3Y/jMA1o71pfJd4DvU34PR3susHylfEUYGAb
	 AYJmW97SWM2Y4iWVvp84FC3fLLhigThKqkntHWNmijaej5b+GHJF1adIJ1I2o1bhT7
	 cjw3pbcUAsnHg==
Date: Sat, 30 Aug 2025 17:11:39 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Denis Aleksandrov <daleksan@redhat.com>
Cc: peterhuewe@gmx.de, jgg@ziepe.ca, linux-integrity@vger.kernel.org,
	Jan Stancek <jstancek@redhat.com>,
	Paul Menzel <pmenzel@molgen.mpg.de>
Subject: Re: [PATCH v3] tpm: Prevent local DOS via tpm/tpm0/ppi/*operations
Message-ID: <aLMGm9tf2mEdI_YX@kernel.org>
References: <20250829175152.9704-2-daleksan@redhat.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250829175152.9704-2-daleksan@redhat.com>

On Fri, Aug 29, 2025 at 01:51:53PM -0400, Denis Aleksandrov wrote:
> Reads on tpm/tpm0/ppi/*operations can become very long on
> misconfigured systems. Reading the TPM is a blocking operation,
> thus a user could effectively trigger a DOS.
> 
> Resolve this by caching the results and avoiding the blocking
> operations after the first read.
> 
> Reported-by: Jan Stancek <jstancek@redhat.com>
> Signed-off-by: Denis Aleksandrov <daleksan@redhat.com>
> Suggested-by: Jarkko Sakkinen <jarkko@kernel.org>
> Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
> ---
> 
> Changes in v3:
> 	- Generalizes ppi info to all architectures.
> 	- Adds reporting of "Not implemented" in ppi operations range.
> 
>  drivers/char/tpm/tpm_ppi.c | 88 ++++++++++++++++++++++++++++----------
>  1 file changed, 65 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm_ppi.c b/drivers/char/tpm/tpm_ppi.c
> index d53fce1c9d6f..a59b6da69bf6 100644
> --- a/drivers/char/tpm/tpm_ppi.c
> +++ b/drivers/char/tpm/tpm_ppi.c
> @@ -33,6 +33,21 @@ static const guid_t tpm_ppi_guid =
>  	GUID_INIT(0x3DDDFAA6, 0x361B, 0x4EB4,
>  		  0xA4, 0x24, 0x8D, 0x10, 0x08, 0x9D, 0x16, 0x53);
>  
> +static const char * const tpm_ppi_info[] = {
> +	"Not implemented",
> +	"BIOS only",
> +	"Blocked for OS by system firmware",
> +	"User required",
> +	"User not required",
> +};
> +
> +/* A spinlock to protect access to the cache from concurrent reads */
> +static DEFINE_SPINLOCK(tpm_ppi_lock);
> +
> +static u32 ppi_operations_cache[PPI_VS_REQ_END + 1];
> +

I might edit the patch just a tiny bit and remove this empty line :-)

(nit)

> +static bool ppi_cache_populated;
> +
>  static bool tpm_ppi_req_has_parameter(u64 req)
>  {
>  	return req == 23;
> @@ -277,8 +292,7 @@ static ssize_t tpm_show_ppi_response(struct device *dev,
>  	return status;
>  }
>  
> -static ssize_t show_ppi_operations(acpi_handle dev_handle, char *buf, u32 start,
> -				   u32 end)
> +static ssize_t cache_ppi_operations(acpi_handle dev_handle, char *buf)
>  {
>  	int i;
>  	u32 ret;
> @@ -286,34 +300,22 @@ static ssize_t show_ppi_operations(acpi_handle dev_handle, char *buf, u32 start,
>  	union acpi_object *obj, tmp;
>  	union acpi_object argv = ACPI_INIT_DSM_ARGV4(1, &tmp);
>  
> -	static char *info[] = {
> -		"Not implemented",
> -		"BIOS only",
> -		"Blocked for OS by BIOS",
> -		"User required",
> -		"User not required",
> -	};
> -
>  	if (!acpi_check_dsm(dev_handle, &tpm_ppi_guid, TPM_PPI_REVISION_ID_1,
>  			    1 << TPM_PPI_FN_GETOPR))
>  		return -EPERM;
>  
>  	tmp.integer.type = ACPI_TYPE_INTEGER;
> -	for (i = start; i <= end; i++) {
> +	for (i = 0; i <= PPI_VS_REQ_END; i++) {
>  		tmp.integer.value = i;
>  		obj = tpm_eval_dsm(dev_handle, TPM_PPI_FN_GETOPR,
>  				   ACPI_TYPE_INTEGER, &argv,
>  				   TPM_PPI_REVISION_ID_1);
> -		if (!obj) {
> +		if (!obj)
>  			return -ENOMEM;
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
>  	}
>  
>  	return len;
> @@ -323,20 +325,60 @@ static ssize_t tpm_show_ppi_tcg_operations(struct device *dev,
>  					   struct device_attribute *attr,
>  					   char *buf)
>  {
> +	int i;
> +	ssize_t len = 0;
> +	u32 ret;
>  	struct tpm_chip *chip = to_tpm_chip(dev);

I'd like you to put out v4 but note that it's not your fault. This is
just tidying that makes sense to do as part of this patch.

Can you reorder these to reverse christmas tree since you are anyway
modifying them.

I.e.

  	struct tpm_chip *chip = to_tpm_chip(dev);
	ssize_t len = 0;
	u32 ret;
	int i;

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
> +		if (ret >= 0 && ret < ARRAY_SIZE(tpm_ppi_info))
> +			len += sysfs_emit_at(buf, len, "%d %d: %s\n",
> +							i, ret, tpm_ppi_info[ret]);
> +	}
> +	spin_unlock(&tpm_ppi_lock);
> +
> +	return len;
>  }
>  
>  static ssize_t tpm_show_ppi_vs_operations(struct device *dev,
>  					  struct device_attribute *attr,
>  					  char *buf)
>  {
> +	int i;
> +	ssize_t len = 0;
> +	u32 ret;
>  	struct tpm_chip *chip = to_tpm_chip(dev);
>  
> -	return show_ppi_operations(chip->acpi_dev_handle, buf, PPI_VS_REQ_START,
> -				   PPI_VS_REQ_END);
> +	spin_lock(&tpm_ppi_lock);
> +	if (!ppi_cache_populated) {
> +		len = cache_ppi_operations(chip->acpi_dev_handle, buf);
> +

nit: remove empty line also here

> +		if (len < 0)
> +			return len;
> +
> +		ppi_cache_populated = true;
> +	}
> +
> +	for (i = PPI_VS_REQ_START; i <= PPI_VS_REQ_END; i++) {
> +		ret = ppi_operations_cache[i];
> +		if (ret >= 0 && ret < ARRAY_SIZE(tpm_ppi_info))
> +			len += sysfs_emit_at(buf, len, "%d %d: %s\n",
> +							i, ret, tpm_ppi_info[ret]);
> +	}
> +	spin_unlock(&tpm_ppi_lock);
> +
> +	return len;

This is really good as now the patch has more value, given than it
removes useless computation from everyone. Thanks for revisiting
and reconsidering the approach.

>  }
>  
>  static DEVICE_ATTR(version, S_IRUGO, tpm_show_ppi_version, NULL);
> -- 
> 2.48.1
> 

BR, Jarkko

