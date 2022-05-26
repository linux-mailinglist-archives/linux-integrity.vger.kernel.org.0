Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 142C0534F25
	for <lists+linux-integrity@lfdr.de>; Thu, 26 May 2022 14:32:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347247AbiEZMcB (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 26 May 2022 08:32:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347237AbiEZMb6 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 26 May 2022 08:31:58 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49512219F
        for <linux-integrity@vger.kernel.org>; Thu, 26 May 2022 05:31:53 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id y13so2774670eje.2
        for <linux-integrity@vger.kernel.org>; Thu, 26 May 2022 05:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=LBL/8y8/LUYPF5+lyivMH99zmCcurEDsFooG2UU4WWA=;
        b=W2zqnFCyFSQ++tFA7S3b0yktYXOz/D9JMCw10nnNav9hy4QfgmkWMui5iFy6xEr8o+
         X/RCetDX9ZBi2elH8/0Gfd6LCouxCVLgA1/m57R7oJrcvnON0lYJCwccwBX+2Mo+k457
         AO9y12hotM9p5BJ1m+6i8ruYEapMeDJcKOsXoRyULW/oVhN9tyw2sxd9WpCFKhGsT710
         BC6B1Z2VamQPSs001O/+GzVlln02VdbV+9zWpRHgNkG2n81tl9nXRDtLAJdNm8Ey2unv
         m4mZLVNcEYaplBd/SZDQizB3rnLsNlbX2J4a2WS5pneMlKdL+Z7nWRnMHZw/ZM5IESoX
         JPGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=LBL/8y8/LUYPF5+lyivMH99zmCcurEDsFooG2UU4WWA=;
        b=3YoCrblXGcQS83zuh+4N0nkAxP4OCA8/S2EjjDkwvJurF16veDpcRH9oYl4jD6Z5by
         LCokbu5md+3ezj9MIQ56pWbPtrLb1rrmtvT6zJot0RuocVjLO1jdv2poza2S+SA2pB6E
         FU3R2hdVhH1AAr0YfrfJXt15/1KmfcgPEhylDsph3X1YyNJxy1QsO3zgJUmBGK52yEo2
         GdZUbOjCB1BZP+d1eTsC9qFX73RybNmLUHVV7cm+l5sl4ilstj5IxBSuREca1ODNEgVW
         FViFqZQUmQhh2ybOsw7oWJOdHINLAGG0G3E0wT2edwCk9rEizvb8zxTaApztZK58ZMhO
         F7IQ==
X-Gm-Message-State: AOAM531CSewAR/K8cqc8X3FDfuXacBvmSUHMIVzZZLEqn8KE2WvO+jd7
        S3hAOR06l1m4wrddfN2SA4ZGJw==
X-Google-Smtp-Source: ABdhPJwfFQ63TrQfru3/+Z/7dBzyzpa0UwjSeQH0rtIVp+Pb8HIBVLXpCN/yGk2ZdKFzTzOr/OhA4g==
X-Received: by 2002:a17:906:52c7:b0:6ce:a880:50a3 with SMTP id w7-20020a17090652c700b006cea88050a3mr32905178ejn.437.1653568311744;
        Thu, 26 May 2022 05:31:51 -0700 (PDT)
Received: from [192.168.0.177] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id d4-20020a50e404000000b0042617ba63c4sm742811edm.78.2022.05.26.05.31.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 May 2022 05:31:51 -0700 (PDT)
Message-ID: <4ee1f7e8-d73f-21f7-eaab-4c8fdca34a31@linaro.org>
Date:   Thu, 26 May 2022 14:31:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v4 3/3] tpm: Add tpm_tis_i2c backend for tpm_tis_core
Content-Language: en-US
To:     Alexander Steffen <Alexander.Steffen@infineon.com>,
        jarkko@kernel.org, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org
Cc:     peterhuewe@gmx.de, jgg@ziepe.ca, krzysztof.kozlowski+dt@linaro.org,
        Johannes Holland <johannes.holland@infineon.com>,
        Amir Mizinski <amirmizi6@gmail.com>
References: <20220525165849.7789-1-Alexander.Steffen@infineon.com>
 <20220525165849.7789-4-Alexander.Steffen@infineon.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220525165849.7789-4-Alexander.Steffen@infineon.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 25/05/2022 18:58, Alexander Steffen wrote:
> Implement the TCG I2C Interface driver, as specified in the TCG PC
> Client Platform TPM Profile (PTP) specification for TPM 2.0 v1.04
> revision 14, section 8, I2C Interface Definition.
> 
> This driver supports Guard Times. That is, if required by the TPM, the
> driver has to wait by a vendor-specific time after each I2C read/write.
> The specific time is read from the TPM_I2C_INTERFACE_CAPABILITY register.
> 
> Unfortunately, the TCG specified almost but not quite compatible
> register addresses. Therefore, the TIS register addresses need to be
> mapped to I2C ones. The locality is stripped because for now, only
> locality 0 is supported.
> 
> Add a sanity check to I2C reads of e.g. TPM_ACCESS and TPM_STS. This is
> to detect communication errors and issues due to non-standard behaviour
> (E.g. the clock stretching quirk in the BCM2835, see 4dbfb5f4401f). In
> case the sanity check fails, attempt a retry.
> 
> Co-developed-by: Johannes Holland <johannes.holland@infineon.com>
> Signed-off-by: Johannes Holland <johannes.holland@infineon.com>
> Co-developed-by: Amir Mizinski <amirmizi6@gmail.com>
> Signed-off-by: Amir Mizinski <amirmizi6@gmail.com>
> Signed-off-by: Alexander Steffen <Alexander.Steffen@infineon.com>
> ---
>  drivers/char/tpm/Kconfig       |  12 +
>  drivers/char/tpm/Makefile      |   1 +
>  drivers/char/tpm/tpm_tis_i2c.c | 406 +++++++++++++++++++++++++++++++++
>  3 files changed, 419 insertions(+)
>  create mode 100644 drivers/char/tpm/tpm_tis_i2c.c
> 
> diff --git a/drivers/char/tpm/Kconfig b/drivers/char/tpm/Kconfig
> index 4a5516406c22..927088b2c3d3 100644
> --- a/drivers/char/tpm/Kconfig
> +++ b/drivers/char/tpm/Kconfig
> @@ -74,6 +74,18 @@ config TCG_TIS_SPI_CR50
>  	  If you have a H1 secure module running Cr50 firmware on SPI bus,
>  	  say Yes and it will be accessible from within Linux.
>  
> +config TCG_TIS_I2C
> +	tristate "TPM Interface Specification 1.3 Interface / TPM 2.0 FIFO Interface - (I2C - generic)"
> +	depends on I2C
> +	select CRC_CCITT
> +	select TCG_TIS_CORE
> +	help
> +	  If you have a TPM security chip, compliant with the TCG TPM PTP
> +	  (I2C interface) specification and connected to an I2C bus master,
> +	  say Yes and it will be accessible from within Linux.
> +	  To compile this driver as a module, choose M here;
> +	  the module will be called tpm_tis_i2c.
> +
>  config TCG_TIS_SYNQUACER
>  	tristate "TPM Interface Specification 1.2 Interface / TPM 2.0 FIFO Interface (MMIO - SynQuacer)"
>  	depends on ARCH_SYNQUACER || COMPILE_TEST
> diff --git a/drivers/char/tpm/Makefile b/drivers/char/tpm/Makefile
> index 66d39ea6bd10..0222b1ddb310 100644
> --- a/drivers/char/tpm/Makefile
> +++ b/drivers/char/tpm/Makefile
> @@ -29,6 +29,7 @@ tpm_tis_spi-$(CONFIG_TCG_TIS_SPI_CR50) += tpm_tis_spi_cr50.o
>  
>  obj-$(CONFIG_TCG_TIS_I2C_CR50) += tpm_tis_i2c_cr50.o
>  
> +obj-$(CONFIG_TCG_TIS_I2C) += tpm_tis_i2c.o
>  obj-$(CONFIG_TCG_TIS_I2C_ATMEL) += tpm_i2c_atmel.o
>  obj-$(CONFIG_TCG_TIS_I2C_INFINEON) += tpm_i2c_infineon.o
>  obj-$(CONFIG_TCG_TIS_I2C_NUVOTON) += tpm_i2c_nuvoton.o
> diff --git a/drivers/char/tpm/tpm_tis_i2c.c b/drivers/char/tpm/tpm_tis_i2c.c
> new file mode 100644
> index 000000000000..8b9218e5405f
> --- /dev/null
> +++ b/drivers/char/tpm/tpm_tis_i2c.c
> @@ -0,0 +1,406 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2014-2021 Nuvoton Technology corporation
> + * Copyright (C) 2019-2022 Infineon Technologies AG
> + *
> + * This device driver implements the TPM interface as defined in the TCG PC
> + * Client Platform TPM Profile (PTP) Specification for TPM 2.0 v1.04
> + * Revision 14.
> + *
> + * It is based on the tpm_tis_spi device driver.
> + */
> +
> +#include <linux/init.h>
> +#include <linux/module.h>
> +#include <linux/moduleparam.h>
> +#include <linux/slab.h>
> +#include <linux/interrupt.h>

Is it used?

> +#include <linux/wait.h>
> +#include <linux/acpi.h>

Is it used?

> +#include <linux/freezer.h>

Is it used?

> +
> +#include <linux/module.h>
> +#include <linux/i2c.h>

> +#include <linux/gpio.h>
> +#include <linux/of_irq.h>
> +#include <linux/of_gpio.h>

The same for these three.

Best regards,
Krzysztof
