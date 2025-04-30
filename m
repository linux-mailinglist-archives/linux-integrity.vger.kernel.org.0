Return-Path: <linux-integrity+bounces-6102-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 231BBAA50CD
	for <lists+linux-integrity@lfdr.de>; Wed, 30 Apr 2025 17:51:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EAC1B9A4134
	for <lists+linux-integrity@lfdr.de>; Wed, 30 Apr 2025 15:51:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25E1E25B1C2;
	Wed, 30 Apr 2025 15:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TGLC1iTW"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3B5422156D;
	Wed, 30 Apr 2025 15:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746028311; cv=none; b=Iq82PurvUIoaeZPkHi36mi4Y4nPBV7aEihHcFWgK4QZemr4lWcI21ZNhI1Hxl7byE6XYmUoNIf/iur4d7WUTBz4WplQuN1BpobGZjtr4wZWITf9z7Ik/Dt84RVc1+3grV4zICDkwmvDJmxBOa3V4EeoEpO97sSnAkt5xYhmigbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746028311; c=relaxed/simple;
	bh=qHt+fbelDpkV87aLSJc+IyuA57EgLArJ4MYkvgj6wC8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BxobpBMQqllyrxyKFYSYaGcOFj2NgWARt7WoevwY1sKu2OBxgM8DWbAAqstUYWRHJCwhlrP7oYMc84ARk/FX4qXA2OFCsfFiPcohjVQRuG+vjzvulW7EvoucpWtmQrV2CmwfXW9Z94xlRD363iY3GC01q4i6W9Rhm16SAVySAaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TGLC1iTW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CADAEC4CEE7;
	Wed, 30 Apr 2025 15:51:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746028310;
	bh=qHt+fbelDpkV87aLSJc+IyuA57EgLArJ4MYkvgj6wC8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TGLC1iTWkEoFUdboTey0EUVYjlQxm277R0u67HVs0tcyIqynQXG0SXDgsI2BEZEB6
	 WhiKjpFm+VfgTmiZpOGQXwWuubD1pgqk9Iv2wNVtSvUEaDsB4d2Tmcx3b5faJpthwN
	 o4JYZa5tW4M3pli8w+TZkx9bM8ajw2Aco/SreOmLJlc+7DNZuLXiAsg76rBwpP9eFq
	 fihDBhH1OQCMRBryBw5L146jKTrlaO/H8zr6vcYFQ2lH8DCzwk0aG51cHfigfw+XRa
	 cGmtRng1PcgoScYsL4x+TJopOgraj0qQpr0VQxASNeRneFVvhUnXi+MWq0mLiiVuQP
	 ZhkdE4VlOtpxQ==
Date: Wed, 30 Apr 2025 18:51:45 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Yeoreum Yun <yeoreum.yun@arm.com>
Cc: peterhuewe@gmx.de, jgg@ziepe.ca, sudeep.holla@arm.com,
	stuart.yoder@arm.com, sgarzare@redhat.com,
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/2] tpm_crb_ffa: use dev_xx() macro to print log
Message-ID: <aBJHESVFL6K0pgmd@kernel.org>
References: <20250415185013.2387369-1-yeoreum.yun@arm.com>
 <20250415185013.2387369-3-yeoreum.yun@arm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250415185013.2387369-3-yeoreum.yun@arm.com>

On Tue, Apr 15, 2025 at 07:50:13PM +0100, Yeoreum Yun wrote:
> Instead of pr_xxx() macro, use dev_xxx() to print log.
> This patch changes some error log level to warn log level when
> the tpm_crb_ffa secure partition doesn't support properly but
> system can run without it.
> (i.e) unsupport of direct message ABI or unsupported ABI version
> 
> Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
> ---
>  drivers/char/tpm/tpm_crb_ffa.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm_crb_ffa.c b/drivers/char/tpm/tpm_crb_ffa.c
> index fed775cf53ab..66b38b2cbdd5 100644
> --- a/drivers/char/tpm/tpm_crb_ffa.c
> +++ b/drivers/char/tpm/tpm_crb_ffa.c
> @@ -303,7 +303,7 @@ static int tpm_crb_ffa_probe(struct ffa_device *ffa_dev)
>  
>  	if (!ffa_partition_supports_direct_recv(ffa_dev) &&
>  	    !ffa_partition_supports_direct_req2_recv(ffa_dev)) {
> -		pr_err("TPM partition doesn't support direct message receive.\n");
> +		dev_warn(&ffa_dev->dev, "partition doesn't support direct message receive.\n");
>  		return -EINVAL;
>  	}
>  
> @@ -324,17 +324,17 @@ static int tpm_crb_ffa_probe(struct ffa_device *ffa_dev)
>  	rc = tpm_crb_ffa_get_interface_version(&tpm_crb_ffa->major_version,
>  					       &tpm_crb_ffa->minor_version);
>  	if (rc) {
> -		pr_err("failed to get crb interface version. rc:%d", rc);
> +		dev_err(&ffa_dev->dev, "failed to get crb interface version. rc:%d\n", rc);
>  		goto out;
>  	}
>  
> -	pr_info("ABI version %u.%u", tpm_crb_ffa->major_version,
> +	dev_info(&ffa_dev->dev, "ABI version %u.%u\n", tpm_crb_ffa->major_version,
>  		tpm_crb_ffa->minor_version);
>  
>  	if (tpm_crb_ffa->major_version != CRB_FFA_VERSION_MAJOR ||
>  	    (tpm_crb_ffa->minor_version > 0 &&
>  	    tpm_crb_ffa->minor_version < CRB_FFA_VERSION_MINOR)) {
> -		pr_err("Incompatible ABI version");
> +		dev_warn(&ffa_dev->dev, "Incompatible ABI version\n");
>  		goto out;
>  	}
>  
> -- 
> LEVI:{C3F47F37-75D8-414A-A8BA-3980EC8A46D7}
> 
> 

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko

