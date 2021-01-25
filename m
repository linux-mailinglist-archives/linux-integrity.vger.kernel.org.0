Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CA993028AD
	for <lists+linux-integrity@lfdr.de>; Mon, 25 Jan 2021 18:22:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730970AbhAYRU1 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 25 Jan 2021 12:20:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730704AbhAYRTh (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 25 Jan 2021 12:19:37 -0500
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F5FDC0617AA;
        Mon, 25 Jan 2021 09:18:50 -0800 (PST)
Received: by mail-oi1-x22c.google.com with SMTP id p5so15510839oif.7;
        Mon, 25 Jan 2021 09:18:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=a2SCYB2pu4LcKaw5cBiz01GNZW0EUKZzcZ1pkjCeWGA=;
        b=Ag9WiKeQmuOHp9O12Fnkh+BfSr6ckKoKHTEit3oe3Afivms+lIhZwJucmaKXZjAISS
         ELKlp1mni1/z7azoh3ANYNbzJarJT6eI2TRcR6nYldOVQkgG4CZI0bU915dTBnMQPtq/
         UJKusmPIzBvdxuBu0JT1Bdt/MqEV6ErBVOI5eJhCtvRSG/hrFHtNfCbfRMkbKruB02U/
         DVGwAXXwAMGAO2wUxKsK615fCxJYzIZdMZ3A0XzvHcvT7UeCfw+UFCzZrn1GGCjfy765
         OylaodB8uvctXw5xQCtFqUP8I5IWC/gcWAjP5VTRKzmJIOnuYqjOuE4ng9CUrWUW6ENf
         Az+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=a2SCYB2pu4LcKaw5cBiz01GNZW0EUKZzcZ1pkjCeWGA=;
        b=F0rYL0GF7LXzgg4vbb1hQhOKCjycLX+165iZUESwD9dA18IwY3nHv+75r8uphh/pqY
         n4Yzaz8apFY+1UMXlbXh6VeELQJPM+IfPqEOAatwH83wduvx3gB8sdetHvxRFoOMKn/Q
         7Qd0nEbtN8ETAY36EZO+wKxacT+yGebJL9KJ+AN0mGdru5ESjVy6FfnICsss4dk1QqE9
         IfLqGtvh5XP1vix9nFMkpFFu5CzCzXDdeLWRPHAzAS8y7fIUfpw3sgzzt5PCnYIjYWsV
         S+8QJJ4uInzs/YY90JW5FtvqSFsbLIkrA3J7asU4Q/dLnRUYo3ULhHFVrO9lmf7gqJe1
         2bAg==
X-Gm-Message-State: AOAM532330irriwO2Al69OH3ygqQXMCPjAfDqxABVIu/ZsHa453MoAJN
        EvLF7LM8lqUAEcaRCNOK42E=
X-Google-Smtp-Source: ABdhPJzBFt2YyPMKKOv/QzXRgJsqK9hQIpdDnxUZ/IFsJTVqc5bJ/4yaukPwJLM9PwTFQyh1Bmlwwg==
X-Received: by 2002:aca:b409:: with SMTP id d9mr797395oif.120.1611595129653;
        Mon, 25 Jan 2021 09:18:49 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id j9sm3170102ooq.1.2021.01.25.09.18.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 Jan 2021 09:18:48 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 25 Jan 2021 09:18:46 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Lukasz Majczak <lma@semihalf.com>
Cc:     Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        Radoslaw Biernacki <rad@semihalf.com>,
        Marcin Wojtas <mw@semihalf.com>,
        Alex Levin <levinale@google.com>
Subject: Re: [PATCH] tpm_tis: Add missing start/stop_tpm_chip calls
Message-ID: <20210125171846.GA31929@roeck-us.net>
References: <20210123014247.989368-1-lma@semihalf.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210123014247.989368-1-lma@semihalf.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Lukasz,

On Sat, Jan 23, 2021 at 02:42:47AM +0100, Lukasz Majczak wrote:
> There is a missing call to start_tpm_chip before the call to
> the tpm_get_timeouts() and tpm_tis_probe_irq_single(). As the current
> approach maight work for tpm2, it fails for tpm1.x - in that case
> call to tpm_get_timeouts() or tpm_tis_probe_irq_single() tries to
> transmit TPM commands on a disabled chip what what doesn't succeed

s/what what/what/

> and in turn causes tpm_tis_core_init() to fail.
> Tested on Samsung Chromebook Pro (Caroline).
> 
> Signed-off-by: Lukasz Majczak <lma@semihalf.com>
> ---
>  drivers/char/tpm/tpm_tis_core.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
> index 92c51c6cfd1b..ff0e5fe46a9d 100644
> --- a/drivers/char/tpm/tpm_tis_core.c
> +++ b/drivers/char/tpm/tpm_tis_core.c
> @@ -1063,12 +1063,16 @@ int tpm_tis_core_init(struct device *dev, struct tpm_tis_data *priv, int irq,
>  	init_waitqueue_head(&priv->read_queue);
>  	init_waitqueue_head(&priv->int_queue);
>  	if (irq != -1) {
> +		rc = tpm_chip_start(chip);

Unless I am missing something, the underlying problem seems to be
the calls to tpm1_getcap(). From other code calling this function,
it looks like it may only require tpm_clk_enable() to work.

With that in mind, would it possibly be better to call tpm_clk_enable()
and tpm_clk_disable() around the calls to tpm1_getcap(), ie in
tpm1_get_timeouts() and in tpm_tis_gen_interrupt() ?

This would avoid the unnecessary calls to tpm_chip_start() and
tpm_chip_stop() for tpm2 chips.

Thanks,
Guenter


> +		if (rc)
> +			goto out_err;
>  		/* Before doing irq testing issue a command to the TPM in polling mode
>  		 * to make sure it works. May as well use that command to set the
>  		 * proper timeouts for the driver.
>  		 */
>  		if (tpm_get_timeouts(chip)) {
>  			dev_err(dev, "Could not get TPM timeouts and durations\n");
> +			tpm_chip_stop(chip);
>  			rc = -ENODEV;
>  			goto out_err;
>  		}
> @@ -1085,6 +1089,7 @@ int tpm_tis_core_init(struct device *dev, struct tpm_tis_data *priv, int irq,
>  		} else {
>  			tpm_tis_probe_irq(chip, intmask);
>  		}
> +		tpm_chip_stop(chip);
>  	}
>  
>  	rc = tpm_chip_register(chip);
