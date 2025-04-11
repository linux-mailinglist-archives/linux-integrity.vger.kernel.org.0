Return-Path: <linux-integrity+bounces-5834-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 26580A85A4A
	for <lists+linux-integrity@lfdr.de>; Fri, 11 Apr 2025 12:41:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4CEB3BB4BB
	for <lists+linux-integrity@lfdr.de>; Fri, 11 Apr 2025 10:39:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05D1222128A;
	Fri, 11 Apr 2025 10:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fnO4fYmI"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1C7C22126F;
	Fri, 11 Apr 2025 10:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744367856; cv=none; b=Mca85cRD1+c7prsQ0meOQI87R8nhVA0Uc4hyfKlM7A5XCiv4TOgBvQdgdb+z8eWGh2IHvD8xtYzZdWn1NMPZ84jP3xndnXKXZYCMLIx+MmP6yB41BeaWvt4As9qilMDsRZTTaiu0YkodM5PFiLqMmLjVB4xPE7ItmJP0F7YkUF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744367856; c=relaxed/simple;
	bh=CpLL6t19QUpzwuQ8jKApV5Z2lDYMZzmlkYr11mNxyIw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qTUqJQpXXN8KBS7m8PK5X6Aq/znyWJeVxItnqWz3cHSLdw7zGNIoWHDVisQL0znItRktOq+qLVNMmUhimwrhnzqKKzJ8/5AAkDyZJB9cOeVcDcJS+go3rsv1D8ME7/19n2TnQiOuLGEDp63Qt7VoOqmF9ZmCWM5hc3LYhd8JVIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fnO4fYmI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B35FEC4CEE2;
	Fri, 11 Apr 2025 10:37:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744367856;
	bh=CpLL6t19QUpzwuQ8jKApV5Z2lDYMZzmlkYr11mNxyIw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fnO4fYmIect0GDZXg0/NRfyaLoz95pbAnmIplc68nfAZ3sZPnoqE6J6Zm4dz5cwpj
	 +DReqKDSKbipsfaOXH8z5hQC3ZQA+xcnqBMMpMb1KfF/rgEsupWEjIfqu49uPnFqNl
	 +JSK6tFhGEYJngfnEbkdUDdDM27nNd1QWz4sPSzdbLTfAPj8FxCNjg5yLDgRQGC1Uy
	 yhlHY6WwEYcZ0tuVEc9GsVqhQsdAAWz7pEay6Iz+loXyggQf+v2uyW4fN7DznxLPdA
	 qm6yryWLd0knssritOXZYz3c8yzwo/kBk+Vu8RPZmjmadwNurhebeboL/009/SHN8+
	 mHACV/8hgKGtQ==
Date: Fri, 11 Apr 2025 13:37:31 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Yeoreum Yun <yeoreum.yun@arm.com>
Cc: peterhuewe@gmx.de, jgg@ziepe.ca, sudeep.holla@arm.com,
	stuart.yoder@arm.com, linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] tpm_ffa_crb: access tpm service over FF-A direct
 message request v2
Message-ID: <Z_jw6z_2k0vzqyK_@kernel.org>
References: <20250411090856.1417021-1-yeoreum.yun@arm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250411090856.1417021-1-yeoreum.yun@arm.com>

On Fri, Apr 11, 2025 at 10:08:56AM +0100, Yeoreum Yun wrote:
> For secure partition with multi service, tpm_ffa_crb can access tpm
> service with direct message request v2 interface according to chapter 3.3,
> TPM Service Command Response Buffer Interface Over FF-A specification [0].
> 
> This patch reflects this spec to access tpm service over
> FF-A direct message request v2 ABI.
> 
> Link: https://developer.arm.com/documentation/den0138/latest/ [0]

Sorry, did not notice in the first round:

1. Does not have "[0]" postfix.
2. Only for lore links:
   https://www.kernel.org/doc/html/v6.12/maintainer/configure-git.html#creating-commit-links-to-lore-kernel-org 

> Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
> ---
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
>  		return -EINVAL;
>  	}
> --
> LEVI:{C3F47F37-75D8-414A-A8BA-3980EC8A46D7}
> 

BR, Jarkko

