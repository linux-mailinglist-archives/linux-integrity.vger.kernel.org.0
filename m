Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B22282D7451
	for <lists+linux-integrity@lfdr.de>; Fri, 11 Dec 2020 11:57:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393808AbgLKKyX (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 11 Dec 2020 05:54:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:54166 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388658AbgLKKyU (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 11 Dec 2020 05:54:20 -0500
Date:   Fri, 11 Dec 2020 12:53:34 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607684019;
        bh=EPmBBhNcTPET0JJj1mJt7S39+Cb420fdyWPVR0mEG8U=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=MYTSzA6cHemNwpm43eNydrfmidXJSLItOxaSpLIS6AXOQrr5kmOluiTyIYh1tQmFF
         BhRaV830eAchuFY66Hqh4CjhZjdDa/VcTYamBmBWU4h4Spcq2W43QnlLcKtnkA+k6V
         Cdoxk4Gohp77Vc5AVixNHBIwTfHvToYpuEEydGcjo3p1ibUvP6o5okXVfvghJs475J
         oABVUfQr5NRLqUwdbVGtTq4l4+1WADxPSu4TFp9lV4/jdnkeGze50wMTnxAu7dgdr4
         x16VPklYgtSm94PwJdEP3lJ34EFTdfEn1s8vnZF+hGk93N1K+mCS/A+zRjmrj1trvd
         4OeUvvmOedgZw==
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Zheng Yongjun <zhengyongjun3@huawei.com>
Cc:     peterhuewe@gmx.de, jgg@ziepe.ca, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] char/tpm: simplify the return expression of
 tpm_tis_synquacer_module_init()
Message-ID: <20201211105334.GG12091@kernel.org>
References: <20201210135515.1310-1-zhengyongjun3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201210135515.1310-1-zhengyongjun3@huawei.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Dec 10, 2020 at 09:55:15PM +0800, Zheng Yongjun wrote:
> Simplify the return expression.
> 
> Signed-off-by: Zheng Yongjun <zhengyongjun3@huawei.com>

I don't see how this would be meaningful change as the existing
code is according to the coding style.

> ---
>  drivers/char/tpm/tpm_tis_synquacer.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm_tis_synquacer.c b/drivers/char/tpm/tpm_tis_synquacer.c
> index e47bdd272704..3b4ae2f23f09 100644
> --- a/drivers/char/tpm/tpm_tis_synquacer.c
> +++ b/drivers/char/tpm/tpm_tis_synquacer.c
> @@ -188,13 +188,8 @@ static struct platform_driver tis_synquacer_drv = {
>  
>  static int __init tpm_tis_synquacer_module_init(void)
>  {
> -	int rc;
>  
> -	rc = platform_driver_register(&tis_synquacer_drv);
> -	if (rc)
> -		return rc;
> -
> -	return 0;
> +	return platform_driver_register(&tis_synquacer_drv);
>  }
>  
>  static void __exit tpm_tis_synquacer_module_exit(void)
> -- 
> 2.22.0
> 
> 

/Jarkko
