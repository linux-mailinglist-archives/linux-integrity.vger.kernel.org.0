Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 519333979A4
	for <lists+linux-integrity@lfdr.de>; Tue,  1 Jun 2021 19:59:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233853AbhFASBV (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 1 Jun 2021 14:01:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:36422 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233397AbhFASBV (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 1 Jun 2021 14:01:21 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 57A766023E;
        Tue,  1 Jun 2021 17:59:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622570379;
        bh=WOADzyUBf9n76BCxIQx4JqRndHroRi5mY4vBcQ1FD9w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SlU+P2TgRhujZjkAdkdIj0ksZdaNdw2SLxgtDVFQcnTjc5tcpNz7dzNvVyt67dJKP
         pkjlZjmJwW7MekJkr29onvtkVOMhU0B98xmswJqRFroLmKW57ghgEH1UyAB1eYTVV7
         /H3yn6oziR1bz6CtlzoUrWI5f8ytSalTsxYDuJC8kMTlz3E47ovVb2ssFK5BmsfG3k
         pTwKxwHT07loc/qb/uhAwVbkzfHO40bTlWeKRdf95eiOvMWVSRq9X9HoNk1WF4nkYu
         fnqzg8sJVs5u9zoZfmQHOskA8edULNP60XIe1EuYEd7K6hYS4Z4bzg4AjyxBpKLI1N
         ar7l7pmUejeyQ==
Date:   Tue, 1 Jun 2021 20:59:37 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org
Subject: Re: [PATCH -next] tpm: fix  some doc warnings in tpm1-cmd.c
Message-ID: <20210601175937.ucfwk6our4djdndj@kernel.org>
References: <20210601122230.3205331-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210601122230.3205331-1-yangyingliang@huawei.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Jun 01, 2021 at 08:22:30PM +0800, Yang Yingliang wrote:
> Fix the following make W=1 warnings:
> 
>   drivers/char/tpm/tpm1-cmd.c:325: warning: expecting prototype for tpm_startup(). Prototype was for tpm1_startup() instead
>   drivers/char/tpm/tpm1-cmd.c:621: warning: expecting prototype for tpm_continue_selftest(). Prototype was for tpm1_continue_selftest() instead
> 
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

/Jarkko


> ---
>  drivers/char/tpm/tpm1-cmd.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm1-cmd.c b/drivers/char/tpm/tpm1-cmd.c
> index ca7158fa6e6c..f7dc986fa4a0 100644
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
> 2.25.1
> 
> 
