Return-Path: <linux-integrity+bounces-6101-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 09874AA50CB
	for <lists+linux-integrity@lfdr.de>; Wed, 30 Apr 2025 17:51:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6CFA8179020
	for <lists+linux-integrity@lfdr.de>; Wed, 30 Apr 2025 15:51:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C16325DAF0;
	Wed, 30 Apr 2025 15:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m6UhhimE"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 432DF2DC760;
	Wed, 30 Apr 2025 15:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746028282; cv=none; b=gy6IdHxa2etqLY0yxOxZ9UST1krW9P5EshKVDGHlkj7gOLDs3G/xh0HfhVQsth8VPSn09y1jb515MXmmNCz/Pa/ZawgT8DB7YDCAND45GzuJTPNX7Osvt+L7TE+xv2t1Feh1aEIKDgBxLB6n5MCiTer3JrVtE/YoLdHfZeVoHn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746028282; c=relaxed/simple;
	bh=HFAl2I5gZT2GyBUXPqdrTWgbvKrwXcO69HTsc8RnnRI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AJ2tn8cXEXw9ov55WrRK4D0ifQIjKkVuIHMD0m3qdRhm4fEss5/ouq+gsR+ffHkB2HJ3VmPdTQ9IHHufmzLCGlFnOUCrpQXMKJhmJGlskxE6WGT+j1iU2ZjCVJ9BwTHdE3oWDGTeHz+aAGDGXeovrTFgz8ibbUZtXI0sg5B9IZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m6UhhimE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3DCAC4CEE7;
	Wed, 30 Apr 2025 15:51:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746028282;
	bh=HFAl2I5gZT2GyBUXPqdrTWgbvKrwXcO69HTsc8RnnRI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=m6UhhimEujjkJ1riJa7v3hJ+BFdf3ed1IaOiLbfA4Ao9B6hLaSnLHK0ZKsej5VjVh
	 azzbV9TzXlIoQgQAnjmgGIa0eGV5bLthO3H2Y66F6A0GmubDM8MO79vexYL0HelCeK
	 cH2AEZXKUVoIUnmm+3aABkVcxg04395YThwkRhhQ4G7TNdNfeBNaIK11ebuGV2fmyX
	 bbSb6GrVUWVlr+VCUZpirD5jsW0HwUOLmKQ6BjrR323E2bY8I2qitjE84jlDG0DSVV
	 XRVOxgnbQahqO0TzL19ZJur3LXTfrL/yR0tInnre553KbrOSS0bhNdTY8uepwtEBki
	 wdGmmU19cH81w==
Date: Wed, 30 Apr 2025 18:51:17 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Yeoreum Yun <yeoreum.yun@arm.com>
Cc: peterhuewe@gmx.de, jgg@ziepe.ca, sudeep.holla@arm.com,
	stuart.yoder@arm.com, sgarzare@redhat.com,
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/2] tpm_ffa_crb: access tpm service over FF-A direct
 message request v2
Message-ID: <aBJG9TmzSCQTNy5b@kernel.org>
References: <20250415185013.2387369-1-yeoreum.yun@arm.com>
 <20250415185013.2387369-2-yeoreum.yun@arm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250415185013.2387369-2-yeoreum.yun@arm.com>

On Tue, Apr 15, 2025 at 07:50:12PM +0100, Yeoreum Yun wrote:
> For secure partition with multi service, tpm_ffa_crb can access tpm
> service with direct message request v2 interface according to chapter 3.3,
> TPM Service Command Response Buffer Interface Over FF-A specificationi v1.0 BET.
> 
> This patch reflects this spec to access tpm service over
> FF-A direct message request v2 ABI.
> 
> Acked-by: Sudeep Holla <sudeep.holla@arm.com>
> Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
> ---
>  drivers/char/tpm/tpm_crb_ffa.c | 55 ++++++++++++++++++++++++----------
>  1 file changed, 40 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm_crb_ffa.c b/drivers/char/tpm/tpm_crb_ffa.c
> index 3169a87a56b6..fed775cf53ab 100644
> --- a/drivers/char/tpm/tpm_crb_ffa.c
> +++ b/drivers/char/tpm/tpm_crb_ffa.c
> @@ -105,7 +105,10 @@ struct tpm_crb_ffa {
>  	u16 minor_version;
>  	/* lock to protect sending of FF-A messages: */
>  	struct mutex msg_data_lock;
> -	struct ffa_send_direct_data direct_msg_data;
> +	union {
> +		struct ffa_send_direct_data direct_msg_data;
> +		struct ffa_send_direct_data2 direct_msg_data2;
> +	};
>  };
>  
>  static struct tpm_crb_ffa *tpm_crb_ffa;
> @@ -185,18 +188,34 @@ static int __tpm_crb_ffa_send_recieve(unsigned long func_id,
>  
>  	msg_ops = tpm_crb_ffa->ffa_dev->ops->msg_ops;
>  
> -	memset(&tpm_crb_ffa->direct_msg_data, 0x00,
> -	       sizeof(struct ffa_send_direct_data));
> -
> -	tpm_crb_ffa->direct_msg_data.data1 = func_id;
> -	tpm_crb_ffa->direct_msg_data.data2 = a0;
> -	tpm_crb_ffa->direct_msg_data.data3 = a1;
> -	tpm_crb_ffa->direct_msg_data.data4 = a2;
> +	if (ffa_partition_supports_direct_req2_recv(tpm_crb_ffa->ffa_dev)) {
> +		memset(&tpm_crb_ffa->direct_msg_data2, 0x00,
> +		       sizeof(struct ffa_send_direct_data2));
> +
> +		tpm_crb_ffa->direct_msg_data2.data[0] = func_id;
> +		tpm_crb_ffa->direct_msg_data2.data[1] = a0;
> +		tpm_crb_ffa->direct_msg_data2.data[2] = a1;
> +		tpm_crb_ffa->direct_msg_data2.data[3] = a2;
> +
> +		ret = msg_ops->sync_send_receive2(tpm_crb_ffa->ffa_dev,
> +				&tpm_crb_ffa->direct_msg_data2);
> +		if (!ret)
> +			ret = tpm_crb_ffa_to_linux_errno(tpm_crb_ffa->direct_msg_data2.data[0]);
> +	} else {
> +		memset(&tpm_crb_ffa->direct_msg_data, 0x00,
> +		       sizeof(struct ffa_send_direct_data));
> +
> +		tpm_crb_ffa->direct_msg_data.data1 = func_id;
> +		tpm_crb_ffa->direct_msg_data.data2 = a0;
> +		tpm_crb_ffa->direct_msg_data.data3 = a1;
> +		tpm_crb_ffa->direct_msg_data.data4 = a2;
> +
> +		ret = msg_ops->sync_send_receive(tpm_crb_ffa->ffa_dev,
> +				&tpm_crb_ffa->direct_msg_data);
> +		if (!ret)
> +			ret = tpm_crb_ffa_to_linux_errno(tpm_crb_ffa->direct_msg_data.data1);
> +	}
>  
> -	ret = msg_ops->sync_send_receive(tpm_crb_ffa->ffa_dev,
> -			&tpm_crb_ffa->direct_msg_data);
> -	if (!ret)
> -		ret = tpm_crb_ffa_to_linux_errno(tpm_crb_ffa->direct_msg_data.data1);
>  
>  	return ret;
>  }
> @@ -231,8 +250,13 @@ int tpm_crb_ffa_get_interface_version(u16 *major, u16 *minor)
>  
>  	rc = __tpm_crb_ffa_send_recieve(CRB_FFA_GET_INTERFACE_VERSION, 0x00, 0x00, 0x00);
>  	if (!rc) {
> -		*major = CRB_FFA_MAJOR_VERSION(tpm_crb_ffa->direct_msg_data.data2);
> -		*minor = CRB_FFA_MINOR_VERSION(tpm_crb_ffa->direct_msg_data.data2);
> +		if (ffa_partition_supports_direct_req2_recv(tpm_crb_ffa->ffa_dev)) {
> +			*major = CRB_FFA_MAJOR_VERSION(tpm_crb_ffa->direct_msg_data2.data[1]);
> +			*minor = CRB_FFA_MINOR_VERSION(tpm_crb_ffa->direct_msg_data2.data[1]);
> +		} else {
> +			*major = CRB_FFA_MAJOR_VERSION(tpm_crb_ffa->direct_msg_data.data2);
> +			*minor = CRB_FFA_MINOR_VERSION(tpm_crb_ffa->direct_msg_data.data2);
> +		}
>  	}
>  
>  	return rc;
> @@ -277,7 +301,8 @@ static int tpm_crb_ffa_probe(struct ffa_device *ffa_dev)
>  
>  	tpm_crb_ffa = ERR_PTR(-ENODEV); // set tpm_crb_ffa so we can detect probe failure
>  
> -	if (!ffa_partition_supports_direct_recv(ffa_dev)) {
> +	if (!ffa_partition_supports_direct_recv(ffa_dev) &&
> +	    !ffa_partition_supports_direct_req2_recv(ffa_dev)) {
>  		pr_err("TPM partition doesn't support direct message receive.\n");
>  		return -EINVAL;
>  	}
> -- 
> LEVI:{C3F47F37-75D8-414A-A8BA-3980EC8A46D7}
> 
> 

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko

