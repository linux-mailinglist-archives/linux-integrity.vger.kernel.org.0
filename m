Return-Path: <linux-integrity+bounces-6503-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C79CAE7324
	for <lists+linux-integrity@lfdr.de>; Wed, 25 Jun 2025 01:29:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C9FB57A48DC
	for <lists+linux-integrity@lfdr.de>; Tue, 24 Jun 2025 23:28:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75AA626A0FD;
	Tue, 24 Jun 2025 23:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lxbf109m"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D3E2307496;
	Tue, 24 Jun 2025 23:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750807773; cv=none; b=CfG8PMoor/yNhfwFoEqbGqb4nyb3iqu/1gJ1bj9dsuufeeejljzL6s/bZOPUc3Dv68NV+hXRiezGU/VYc96TXhRkHwSh2ar2h0Luxp2IxXaAddos9ZJVHIAuVX0Q5AqSM/jvBLjiZlQvjwDr4ebupGtnhIOdrDMh/1KnXe4TUSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750807773; c=relaxed/simple;
	bh=05HNQPwBtyrgW26Vc7Vbxtx/maWAq57HxbUh2ZxvJ30=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O6XhhZXq8q1XYrrd/20UXgs34SvuYctJ4W0468dZJBpMkPZNulnhmuqK0d3Fyh4vM49yzQGU9IOsaFs8+aQPFbRHT67bp+z390/JoaeJXQ64pxrI/GWXjJJccLhlkVmg9BAXZi105ga5ckuJc5uLEZv46Zb5jq4RHeQ/iuDgy6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lxbf109m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A0BCC4CEE3;
	Tue, 24 Jun 2025 23:29:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750807773;
	bh=05HNQPwBtyrgW26Vc7Vbxtx/maWAq57HxbUh2ZxvJ30=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Lxbf109mvjbn0TirCG+sCyt/Ame5IbV1g9IA1Uk281WOkYBEqT5INF4ZLGxA8RyxY
	 zjDWHb/aPeSRxTvj9N+lGl1qY3GHih7gWN9bOvsQB7PQ313Gg7GvWWaKVn0KDhKw3y
	 g687ccDbjrB3wMt+6p6Fl79jtMGP1Dthonu1FEqomnou7JuNanxq6gJml/W2FIFtHc
	 8fJ091giY5xzz2ViYJW5nsIgk14kHTwJ0m4d6jj+TE9VhAS1v+zcLxp9tLW8AXMu47
	 pS76wLnldyp2MM08loZc8EsKqsU2zc1gdS7xOjuEU6YD9Lt7gRQJ4/RCSU91qAj67i
	 Zco3zMSmyBFOw==
Date: Wed, 25 Jun 2025 02:29:29 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Yeoreum Yun <yeoreum.yun@arm.com>
Cc: sudeep.holla@arm.com, peterhuewe@gmx.de, jgg@ziepe.ca,
	stuart.yoder@arm.com, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org
Subject: Re: [PATCH v4 2/2] tpm: tpm_crb_ffa: try to probe tpm_crb_ffa when
 it's built-in
Message-ID: <aFs02ZgVyGTg2cJx@kernel.org>
References: <20250618102302.2379029-1-yeoreum.yun@arm.com>
 <20250618102302.2379029-3-yeoreum.yun@arm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250618102302.2379029-3-yeoreum.yun@arm.com>

On Wed, Jun 18, 2025 at 11:23:02AM +0100, Yeoreum Yun wrote:
> To generate the boot_aggregate log in the IMA subsystem using TPM PCR values,
> the TPM driver must be built as built-in and must be probed before
> the IMA subsystem is initialized.
> 
> However, when the TPM device operates over the FF-A protocol using the CRB interface,
> probing fails and returns -EPROBE_DEFER
> if the tpm_crb_ffa device — an FF-A device that provides
> the communication interface to the tpm_crb driver — has not yet been probed.
> 
> This issue occurs because both crb_acpi_driver_init() and
> tpm_crb_ffa_driver_init() are registered with device_initcall.
> As a result, crb_acpi_driver_init() may be invoked before
> tpm_crb_ffa_driver_init(), which is responsible for probing the tpm_crb_ffa device.
> 
> When this happens, IMA fails to detect the TPM device and
> logs the following message:
> 
>   | ima: No TPM chip found, activating TPM-bypass!
> 
> Consequently, it cannot generate the boot_aggregate log with
> the PCR values provided by the TPM.
> 
> To resolve this issue, the tpm_crb_ffa_init() function explicitly attempts to
> probe the tpm_crb_ffa by register tpm_crb_ffa driver so that
> when tpm_crb_ffa device is created before tpm_crb_ffa_init(),
> probe the tpm_crb_ffa device in tpm_crb_ffa_init() to finish probe the
> TPM device completely.
> 
> This ensures that the TPM device using CRB over FF-A
> can be successfully probed, even if crb_acpi_driver_init() is called first.
> 
> Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
> ---
>  drivers/char/tpm/tpm_crb_ffa.c | 19 ++++++++++++++++---
>  1 file changed, 16 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm_crb_ffa.c b/drivers/char/tpm/tpm_crb_ffa.c
> index 4ead61f01299..462fcf610020 100644
> --- a/drivers/char/tpm/tpm_crb_ffa.c
> +++ b/drivers/char/tpm/tpm_crb_ffa.c
> @@ -115,6 +115,7 @@ struct tpm_crb_ffa {
>  };
>  
>  static struct tpm_crb_ffa *tpm_crb_ffa;
> +static struct ffa_driver tpm_crb_ffa_driver;
>  
>  static int tpm_crb_ffa_to_linux_errno(int errno)
>  {
> @@ -168,13 +169,23 @@ static int tpm_crb_ffa_to_linux_errno(int errno)
>   */
>  int tpm_crb_ffa_init(void)
>  {
> +	int ret = 0;
> +
> +	if (!IS_MODULE(CONFIG_TCG_ARM_CRB_FFA)) {
> +		ret = ffa_register(&tpm_crb_ffa_driver);
> +		if (ret) {
> +			tpm_crb_ffa = ERR_PTR(-ENODEV);
> +			return ret;
> +		}
> +	}
> +
>  	if (!tpm_crb_ffa)
> -		return -ENOENT;
> +		ret = -ENOENT;
>  
>  	if (IS_ERR_VALUE(tpm_crb_ffa))
> -		return -ENODEV;
> +		ret = -ENODEV;
>  
> -	return 0;
> +	return ret;
>  }
>  EXPORT_SYMBOL_GPL(tpm_crb_ffa_init);
>  
> @@ -369,7 +380,9 @@ static struct ffa_driver tpm_crb_ffa_driver = {
>  	.id_table = tpm_crb_ffa_device_id,
>  };
>  
> +#ifdef MODULE
>  module_ffa_driver(tpm_crb_ffa_driver);
> +#endif
>  
>  MODULE_AUTHOR("Arm");
>  MODULE_DESCRIPTION("TPM CRB FFA driver");
> -- 
> LEVI:{C3F47F37-75D8-414A-A8BA-3980EC8A46D7}
> 

NAK

BR, Jarkko

