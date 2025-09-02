Return-Path: <linux-integrity+bounces-6975-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74845B40BC1
	for <lists+linux-integrity@lfdr.de>; Tue,  2 Sep 2025 19:14:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 27A9B7A32B6
	for <lists+linux-integrity@lfdr.de>; Tue,  2 Sep 2025 17:12:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59B152E11B8;
	Tue,  2 Sep 2025 17:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jVZVXADz"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 355CD2DF125
	for <linux-integrity@vger.kernel.org>; Tue,  2 Sep 2025 17:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756833246; cv=none; b=CctkYm1f2oVW7MY5rFjvJsEpmkRKCmaYgwjEspKiLMVxrUytWoYtqqUbMA2f93cow0BcrMVBztDqH28DtWECmHU6/tYzeeMT7MdqVWbQeFC/JQKSbDdVHDSx00ET+bUe0BJ1SQ2J1efzChrwD15+rRAJb3CmQdQ7wmaIT4nWi04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756833246; c=relaxed/simple;
	bh=Be0+k6MY6vVENcAfhrfp2MYHomxltjHUr91GZjMg06Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TC1Xa9qTNv13/045sKx06XHof8sM3c3MeCE9xic1BuJCdlp5K6fJC0QtXoLSi0Wf+fOmwDepMQB72ruT6QlOV5hU87tH3tRMECJhnwCxDDFD/riWgzoVMwjxgZ9czEdeETGBOKhiVCutkBx4pc0VneUtK0EZ91P+qHuzrgmLh2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jVZVXADz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F9B7C4CEED;
	Tue,  2 Sep 2025 17:14:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756833245;
	bh=Be0+k6MY6vVENcAfhrfp2MYHomxltjHUr91GZjMg06Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jVZVXADzXEVGzWI2QKAbulu5MecRjH5u5kh3VK3Vm4N0JXmwm5xuwDBczLVWRJ2Jp
	 UypNmfFw/RwWy2j4ISIw+txAqmFeDzdoSCBj8ZZUOfFSRkcQHZ3xQDmyy05+Y/L/Vs
	 dUHArSBUeMDNyiawQtQXH6cOM5ky2gjZK7bPgLPCgWXCTOHVw2u3SpsCU2NWs6k+Li
	 rt0juZ9B86AGy46ZHHkp+m+lP7VvxIc3PDAuq5tbNTU9zHCczNtxLHEf2YEoxlU1MB
	 EescNl/+C/ZSAQ5957wkY0wtBmvPUdwzNdCzivlAnTidG4AWY4Vewpdc3+620ucbgu
	 Ds+XyBr/rWmIQ==
Date: Tue, 2 Sep 2025 20:14:01 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Denis Aleksandrov <daleksan@redhat.com>
Cc: peterhuewe@gmx.de, jgg@ziepe.ca, linux-integrity@vger.kernel.org,
	Jan Stancek <jstancek@redhat.com>,
	Paul Menzel <pmenzel@molgen.mpg.de>
Subject: Re: [PATCH v4] tpm: Prevent local DOS via tpm/tpm0/ppi/*operations
Message-ID: <aLcl2SzTc_nTX56u@kernel.org>
References: <20250902142429.14041-2-daleksan@redhat.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250902142429.14041-2-daleksan@redhat.com>

On Tue, Sep 02, 2025 at 10:24:30AM -0400, Denis Aleksandrov wrote:
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
> Changes in v4:
> 	- Removes empty lines.
> 	- Reorders vars to reverse christmas tree.
> 
>  drivers/char/tpm/tpm_ppi.c | 85 +++++++++++++++++++++++++++-----------
>  1 file changed, 62 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm_ppi.c b/drivers/char/tpm/tpm_ppi.c
> index d53fce1c9d6f..df34b215440d 100644
> --- a/drivers/char/tpm/tpm_ppi.c
> +++ b/drivers/char/tpm/tpm_ppi.c
> @@ -33,6 +33,20 @@ static const guid_t tpm_ppi_guid =
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
> +static bool ppi_cache_populated;
> +
>  static bool tpm_ppi_req_has_parameter(u64 req)
>  {
>  	return req == 23;
> @@ -277,8 +291,7 @@ static ssize_t tpm_show_ppi_response(struct device *dev,
>  	return status;
>  }
>  
> -static ssize_t show_ppi_operations(acpi_handle dev_handle, char *buf, u32 start,
> -				   u32 end)
> +static ssize_t cache_ppi_operations(acpi_handle dev_handle, char *buf)
>  {
>  	int i;
>  	u32 ret;
> @@ -286,34 +299,22 @@ static ssize_t show_ppi_operations(acpi_handle dev_handle, char *buf, u32 start,
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
> @@ -324,9 +325,28 @@ static ssize_t tpm_show_ppi_tcg_operations(struct device *dev,
>  					   char *buf)
>  {
>  	struct tpm_chip *chip = to_tpm_chip(dev);
> +	ssize_t len = 0;
> +	u32 ret;
> +	int i;
> +
> +	spin_lock(&tpm_ppi_lock);
> +	if (!ppi_cache_populated) {
> +		len = cache_ppi_operations(chip->acpi_dev_handle, buf);
> +		if (len < 0)
> +			return len;
>  
> -	return show_ppi_operations(chip->acpi_dev_handle, buf, 0,
> -				   PPI_TPM_REQ_MAX);
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
> @@ -334,9 +354,28 @@ static ssize_t tpm_show_ppi_vs_operations(struct device *dev,
>  					  char *buf)
>  {
>  	struct tpm_chip *chip = to_tpm_chip(dev);
> +	ssize_t len = 0;
> +	u32 ret;
> +	int i;
>  
> -	return show_ppi_operations(chip->acpi_dev_handle, buf, PPI_VS_REQ_START,
> -				   PPI_VS_REQ_END);
> +	spin_lock(&tpm_ppi_lock);
> +	if (!ppi_cache_populated) {
> +		len = cache_ppi_operations(chip->acpi_dev_handle, buf);
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
>  }
>  
>  static DEVICE_ATTR(version, S_IRUGO, tpm_show_ppi_version, NULL);
> -- 
> 2.48.1
> 

Thank you! It's now an actual quality of service improvement whereas the
first fix more like "duct tape" alike solution :-)

I'll apply this within next few days.

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko

