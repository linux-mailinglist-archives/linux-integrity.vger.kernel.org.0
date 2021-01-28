Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1411307CBD
	for <lists+linux-integrity@lfdr.de>; Thu, 28 Jan 2021 18:39:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233197AbhA1Ri7 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 28 Jan 2021 12:38:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233188AbhA1Ri3 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 28 Jan 2021 12:38:29 -0500
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56123C061573;
        Thu, 28 Jan 2021 09:37:49 -0800 (PST)
Received: by mail-ot1-x336.google.com with SMTP id 63so5967419oty.0;
        Thu, 28 Jan 2021 09:37:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=sGm2kYn86noUJSLKSSv0EpGYvhiuc8NWtVaZiuoIBic=;
        b=sQK6U6fqtdrijWJoNgXO7Ylu8Nv167zljUjWbz06EWT46J4X1wwDyuSKCQWjhObjtO
         AnGRtwIGWNaPI/ayB2ILV15Je+8R+IrgpJB4ntFpP1xBjUFcWlq8mg2mE3L/o+eWj2oD
         rRvfflLHjzzZJkCVJftYtyB984wrkiuNY7lOXSkMfrZxLFY2txFgu/bpU8br7gynza0G
         e+YUqxxibFUfvUEK3xSwToTz3AmbOYZ3H1c32D69Ck8eo6PTIxILXuR3gpyJ9YKXH9/n
         JFANsDjRmNEHTCyLrJU7147tl3WLGnOdv06OJbkwjPplVDxs6wS4/rACxH+g3pf1qFZC
         0RMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=sGm2kYn86noUJSLKSSv0EpGYvhiuc8NWtVaZiuoIBic=;
        b=iAJ1Ld+SPBuuS+KfMnfMUrf20U3+x9PpXwvK1TsFdzLIwqGlEwl5D3uSSv7Z8LWN9C
         vwZ2L+aIsOKVaD53CLchYoR7iXt8fNg5Rf0fbYRi7GKqFFoZqryTlwr4eOfHB07Ev+Nt
         +1AsapzxAbz0ApYP2kgatGpYW+/TD+HAwlRu9x6gOp/e6pz1s5a3qax1Gfas0PG9PwLR
         L2Y7TxcNmKbNlDDlZ+vhTa5UBmFDhT1Q6ayPlwZ4EkA6Yrjm4Im+hiseLfIF0gG5XIAG
         zC6FZgwcNBvO73yFqYNu5IofM76HVzOOuAkoSDXiefhjeausFgDPuWp9XwvZEE3iVGiN
         M4nw==
X-Gm-Message-State: AOAM530shCicLWQTKY7JDBjt1zZLkSiy9A5ZOE3iBl22PD+W/iOg2m58
        32QxF23ci23v2C+KmyQD8DE=
X-Google-Smtp-Source: ABdhPJyxJgX+FMXIpqyrqaxY/4bR+ZEPWQ4Kw1a2saiqwCwlZWIhyTC6Iwi418HWgv984YX+3JEJFg==
X-Received: by 2002:a9d:7194:: with SMTP id o20mr372737otj.214.1611855468715;
        Thu, 28 Jan 2021 09:37:48 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id a96sm1087817otb.12.2021.01.28.09.37.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 28 Jan 2021 09:37:47 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Thu, 28 Jan 2021 09:37:46 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Lukasz Majczak <lma@semihalf.com>
Cc:     Jarkko Sakkinen <jarkko@kernel.org>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Tj <ml.linux@elloe.vision>, Dirk Gouders <dirk@gouders.net>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        Radoslaw Biernacki <rad@semihalf.com>,
        Marcin Wojtas <mw@semihalf.com>,
        Alex Levin <levinale@google.com>
Subject: Re: [PATCH v2] tpm_tis: Add missing tpm_request/relinquish_locality
 calls
Message-ID: <20210128173746.GA158525@roeck-us.net>
References: <20210123014247.989368-1-lma@semihalf.com>
 <20210128130753.1283534-1-lma@semihalf.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210128130753.1283534-1-lma@semihalf.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Lukasz,

On Thu, Jan 28, 2021 at 02:07:53PM +0100, Lukasz Majczak wrote:
> There is a missing call to tpm_request_locality before the call to
> the tpm_get_timeouts() and tpm_tis_probe_irq_single(). As the current
> approach might work for tpm2, it fails for tpm1.x - in that case
> call to tpm_get_timeouts() or tpm_tis_probe_irq_single()
> without locality fails and in turn causes tpm_tis_core_init() to fail.
> Tested on Samsung Chromebook Pro (Caroline).
> 
> Signed-off-by: Lukasz Majczak <lma@semihalf.com>
> ---
> Jarkko, James, Guenter
> 
> I’m aware about the other thread, but it seems to be dead for a few months.
> Here is the small patch as fixing this specific issue
> would allow us to unblock the ChromeOs development. 
> We want to upstream all of our patches,
> so the ChromeOs will not diverge even more,
> so I'm hoping this could be applied, if you see it neat enough.
> 
> Best regards,
> Lukasz
> 
> v1 -> v2:
>  - fixed typos
>  - as there is no need to enable clock, switched to
>    use only tpm_request/relinquish_locality calls
>  - narrowed down boundaries of tpm_request/relinquish_locality calls
>  
>  drivers/char/tpm/tpm-chip.c      |  4 ++--
>  drivers/char/tpm/tpm-interface.c | 11 +++++++++--
>  drivers/char/tpm/tpm.h           |  2 ++
>  drivers/char/tpm/tpm_tis_core.c  | 12 ++++++++++--
>  4 files changed, 23 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
> index ddaeceb7e109..5351963a4b19 100644
> --- a/drivers/char/tpm/tpm-chip.c
> +++ b/drivers/char/tpm/tpm-chip.c
> @@ -32,7 +32,7 @@ struct class *tpm_class;
>  struct class *tpmrm_class;
>  dev_t tpm_devt;
>  
> -static int tpm_request_locality(struct tpm_chip *chip)
> +int tpm_request_locality(struct tpm_chip *chip)
>  {
>  	int rc;
>  
> @@ -47,7 +47,7 @@ static int tpm_request_locality(struct tpm_chip *chip)
>  	return 0;
>  }
>  
> -static void tpm_relinquish_locality(struct tpm_chip *chip)
> +void tpm_relinquish_locality(struct tpm_chip *chip)
>  {
>  	int rc;
>  
> diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
> index 1621ce818705..69309b2bea6a 100644
> --- a/drivers/char/tpm/tpm-interface.c
> +++ b/drivers/char/tpm/tpm-interface.c
> @@ -243,8 +243,15 @@ int tpm_get_timeouts(struct tpm_chip *chip)
>  
>  	if (chip->flags & TPM_CHIP_FLAG_TPM2)
>  		return tpm2_get_timeouts(chip);
> -	else
> -		return tpm1_get_timeouts(chip);
> +	else {

{ } needed around if part of if/else statement.

> +		ssize_t ret = tpm_request_locality(chip);
> +
> +		if (ret)
> +			return ret;
> +		ret = tpm1_get_timeouts(chip);
> +		tpm_relinquish_locality(chip);
> +		return ret;
> +	}
>  }
>  EXPORT_SYMBOL_GPL(tpm_get_timeouts);
>  
> diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
> index 947d1db0a5cc..8c13008437dd 100644
> --- a/drivers/char/tpm/tpm.h
> +++ b/drivers/char/tpm/tpm.h
> @@ -193,6 +193,8 @@ static inline void tpm_msleep(unsigned int delay_msec)
>  
>  int tpm_chip_start(struct tpm_chip *chip);
>  void tpm_chip_stop(struct tpm_chip *chip);
> +int tpm_request_locality(struct tpm_chip *chip);
> +void tpm_relinquish_locality(struct tpm_chip *chip);
>  struct tpm_chip *tpm_find_get_ops(struct tpm_chip *chip);
>  __must_check int tpm_try_get_ops(struct tpm_chip *chip);
>  void tpm_put_ops(struct tpm_chip *chip);
> diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
> index 92c51c6cfd1b..0ae675e8cf2f 100644
> --- a/drivers/char/tpm/tpm_tis_core.c
> +++ b/drivers/char/tpm/tpm_tis_core.c
> @@ -754,9 +754,17 @@ static int tpm_tis_gen_interrupt(struct tpm_chip *chip)
>  
>  	if (chip->flags & TPM_CHIP_FLAG_TPM2)
>  		return tpm2_get_tpm_pt(chip, 0x100, &cap2, desc);
> -	else
> -		return tpm1_getcap(chip, TPM_CAP_PROP_TIS_TIMEOUT, &cap, desc,
> +	else {
> +		ssize_t ret = tpm_request_locality(chip);
> +
> +		if (ret)
> +			return ret;
> +		ret = tpm1_getcap(chip, TPM_CAP_PROP_TIS_TIMEOUT, &cap, desc,
>  				  0);
> +		tpm_relinquish_locality(chip);
> +		return ret;
> +	}
> +

James' earlier patch does not address the problem in tpm_get_timeouts().
However, it states that "interrupt registers are only writeable in
the current locality" and "TPM_CHIP_FLAG_IRQ never gets set initially".
So the question is if the above is sufficient, or if James' patch
(requesting locality for all of tpm_tis_probe_irq_single and setting
TPM_CHIP_FLAG_IRQ) is needed. Unfortunately I can not answer that.

Guenter

>  }
>  
>  /* Register the IRQ and issue a command that will cause an interrupt. If an
> -- 
> 2.25.1
> 
