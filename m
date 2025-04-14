Return-Path: <linux-integrity+bounces-5863-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26622A885AF
	for <lists+linux-integrity@lfdr.de>; Mon, 14 Apr 2025 16:50:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1AECC3BE2D0
	for <lists+linux-integrity@lfdr.de>; Mon, 14 Apr 2025 14:40:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5679629291F;
	Mon, 14 Apr 2025 14:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sEUcfMRO"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E3751A29A;
	Mon, 14 Apr 2025 14:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744640528; cv=none; b=OO28wdKQfgVtXjYxG9vQDS9lWIAvCmNB9xByIEITzqDkR+GgLciQ0jh/UsD9o5tx0mkPGK44p9jqDmxbe8P8RGM985cGIIPxCQi0C/rhABnjID+k8/Hz8B4WiPWbuCSVGmTTI8PjeuRht8N4VkB1givHakJFG10aPmFLPmryaRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744640528; c=relaxed/simple;
	bh=3fNBOwE754iG88jD0y+EyHyTfQKeUQI6NeGIyUiGJFQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BB1P5xz7ihyaZc1+7S1NTbHsUrrwuS6kls7gvQu0XaJjSNnc2WkHTgkdvxBZUkmBnicMsTCpixSRWemtfVr2zA/yy1G9Qhkkyo1moHNsHeEDEXRyYPCaCmvkUoNbUtVud4Q5hHd3zNRGb8zo7+q2gKZVH6BCaP5O+y+3uRWg9vQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sEUcfMRO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54356C4CEE2;
	Mon, 14 Apr 2025 14:22:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744640527;
	bh=3fNBOwE754iG88jD0y+EyHyTfQKeUQI6NeGIyUiGJFQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sEUcfMRO+rp0WDkKdWvJDOgyKJbCsIW7p6NHFJTf4iiNWWBnZLozx+PIlhf6e9cHk
	 lZQdaqObYz5zoZo6xFrs1Tk67uh5TC0VX6EPWLlQYZjqF+caqrseGaB6wM+sZb7mz3
	 L+NWMAeMqSuZMlCZbmSoVtk/8Ui6tCu6AhUmWXO42hVTE162sCmHgQS2hgGCnX+Cse
	 GruTHDyLCDPiSLxtkLxJKeBAqTjo8Po+kBrWMS2tnvXh05ylqXrDYGyk1T7hGoMjfq
	 7Mmqm1tsQhyhomZhiAYwaJNZaS5sPd3OEuxD+4eCloat682Jt4SaOS3ePOqIP1NA/P
	 I8GkTSBi+56dA==
Date: Mon, 14 Apr 2025 17:22:03 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Yeoreum Yun <yeoreum.yun@arm.com>
Cc: peterhuewe@gmx.de, jgg@ziepe.ca, sudeep.holla@arm.com,
	stuart.yoder@arm.com, sgarzare@redhat.com,
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] tpm_ffa_crb: access tpm service over FF-A direct
 message request v2
Message-ID: <Z_0aBHJ16l-Vw72p@kernel.org>
References: <20250412054721.1647439-1-yeoreum.yun@arm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250412054721.1647439-1-yeoreum.yun@arm.com>

On Sat, Apr 12, 2025 at 06:47:21AM +0100, Yeoreum Yun wrote:
> For secure partition with multi service, tpm_ffa_crb can access tpm
> service with direct message request v2 interface according to chapter 3.3,
> TPM Service Command Response Buffer Interface Over FF-A specification, v1.0 BET.
> 
> This patch reflects this spec to access tpm service over
> FF-A direct message request v2 ABI.
> 
> Acked-by: Sudeep Holla <sudeep.holla@arm.com>
> Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
> ---
> Since v2:
>     - rewokring commit message
>     - https://lore.kernel.org/all/20250411090856.1417021-1-yeoreum.yun@arm.com/
> 
> Since v1:
>     - Fix indentation.
>     - https://lore.kernel.org/all/20250410110701.1244965-1-yeoreum.yun@arm.com/
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

did not notice but there's couple of things:

1. It should be probably warn. Driver is working incorrectly, isn't it?
2. dev_warn()

So along the lines of would summarize all this:

dev_warn(&ffa_dev->dev, "partition doesn't support direct message receive.\n");

"TPM" was removed because this gives the device info.


>  		return -EINVAL;
>  	}
> --
> LEVI:{C3F47F37-75D8-414A-A8BA-3980EC8A46D7}
> 

BR, Jarkko

