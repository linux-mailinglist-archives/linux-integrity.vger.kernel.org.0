Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5C4838B47E
	for <lists+linux-integrity@lfdr.de>; Thu, 20 May 2021 18:41:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234293AbhETQmr (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 20 May 2021 12:42:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:39952 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234282AbhETQmq (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 20 May 2021 12:42:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C528C6101E;
        Thu, 20 May 2021 16:41:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621528885;
        bh=jHaZ9/+rDGFnf5r8VoX0d3+e+OVFelwHxFJgzMpRDpc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tauIHfSFa45basZoUKC+9D34NYCmpVHLTmeSb1soQ9M0/0YFrfBUcKGhzHJWULY/v
         JKOoL67xyyKneNRmMNwTLaAMr9j5U6oX2xpy5L0yGPJlgVNRgFk5nZeAlSaobmk0me
         WVdEaNw0QycdOc2kftxFzS0PLTjppqG+kDoPlKea9Tfj+c4TDbKvbvmT899PVkD3zz
         JN2R5YjhasY6hMbrpT1h48yDQa3YpAhzjRxUPb5nTBuBajcP3ALWNy8Yx9byUXe4tc
         t3zpUeakrNX9ULuWS7JkJH0hU6zjAIJZoevDtxrE/x2LCbbY5x2nePOzJpHuDMZGhn
         AJrI1xOyDGSCg==
Date:   Thu, 20 May 2021 19:41:23 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-kernel@vger.kernel.org, Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        van Doorn <leendert@watson.ibm.com>,
        Dave Safford <safford@watson.ibm.com>,
        Reiner Sailer <sailer@watson.ibm.com>,
        Kylene Hall <kjhall@us.ibm.com>,
        linux-integrity@vger.kernel.org
Subject: Re: [PATCH 07/16] char: tpm: tpm1-cmd: Fix a couple of misnamed
 functions
Message-ID: <YKaRM2ANJ5yflidJ@kernel.org>
References: <20210520121347.3467794-1-lee.jones@linaro.org>
 <20210520121347.3467794-8-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210520121347.3467794-8-lee.jones@linaro.org>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, May 20, 2021 at 01:13:38PM +0100, Lee Jones wrote:
> Fixes the following W=1 kernel build warning(s):
> 
>  drivers/char/tpm/tpm1-cmd.c:325: warning: expecting prototype for tpm_startup(). Prototype was for tpm1_startup() instead
>  drivers/char/tpm/tpm1-cmd.c:621: warning: expecting prototype for tpm_continue_selftest(). Prototype was for tpm1_continue_selftest() instead
> 
> Cc: Peter Huewe <peterhuewe@gmx.de>
> Cc: Jarkko Sakkinen <jarkko@kernel.org>
> Cc: Jason Gunthorpe <jgg@ziepe.ca>
> Cc: van Doorn <leendert@watson.ibm.com>
> Cc: Dave Safford <safford@watson.ibm.com>
> Cc: Reiner Sailer <sailer@watson.ibm.com>
> Cc: Kylene Hall <kjhall@us.ibm.com>
> Cc: linux-integrity@vger.kernel.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>


Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

Thanks, I'll apply this.

> ---
>  drivers/char/tpm/tpm1-cmd.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm1-cmd.c b/drivers/char/tpm/tpm1-cmd.c
> index ca7158fa6e6cd..f7dc986fa4a0a 100644
> --- a/drivers/char/tpm/tpm1-cmd.c
> +++ b/drivers/char/tpm/tpm1-cmd.c
> @@ -312,7 +312,7 @@ unsigned long tpm1_calc_ordinal_duration(struct tpm_chip *chip, u32 ordinal)
>  #define TPM_ST_CLEAR 1
>  
>  /**
> - * tpm_startup() - turn on the TPM
> + * tpm1_startup() - turn on the TPM
>   * @chip: TPM chip to use
>   *
>   * Normally the firmware should start the TPM. This function is provided as a
> @@ -611,7 +611,7 @@ int tpm1_pcr_read(struct tpm_chip *chip, u32 pcr_idx, u8 *res_buf)
>  
>  #define TPM_ORD_CONTINUE_SELFTEST 83
>  /**
> - * tpm_continue_selftest() - run TPM's selftest
> + * tpm1_continue_selftest() - run TPM's selftest
>   * @chip: TPM chip to use
>   *
>   * Returns 0 on success, < 0 in case of fatal error or a value > 0 representing
> -- 
> 2.31.1
> 
> 

/Jarkko
