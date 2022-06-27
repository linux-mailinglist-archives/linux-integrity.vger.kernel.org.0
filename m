Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76DA155CF40
	for <lists+linux-integrity@lfdr.de>; Tue, 28 Jun 2022 15:06:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240650AbiF0Wn3 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 27 Jun 2022 18:43:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239815AbiF0Wn2 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 27 Jun 2022 18:43:28 -0400
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6E20B7D8;
        Mon, 27 Jun 2022 15:43:27 -0700 (PDT)
Received: by mail-il1-f180.google.com with SMTP id p9so6728199ilj.7;
        Mon, 27 Jun 2022 15:43:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=91IKVoV34p2SaHjlsoXEsJdmKXFfmHWgI/e+86ORCdc=;
        b=zq89+YDoReg3OHwi9fYgJKdc4lHgyvEXP0nFU0xLEN9B+h8TCDVZcbLV+JH3agYpUP
         g+yg+GWkzaoTfxmmp8FRN4NmPDjZOZFc9l6+S3a9LRrJN24UucA2lvB12ms4nbHokI4y
         Hh/7QR8EG90OAnlBHwvqDNegoyS1TCY4Z9XO44hGQLLK35r15E3nlNRM1UBKn5duxQVR
         8nwanac2v6/4wcqe52IV1Zv+NWa3QxTJ7hklmfq5LD49x2Tehb2/a0Q7ZQg3D/97y000
         Ru0/dwoXJOViUA1bI1XMzrcycZdf8f5KBUojHOnLairGywFmSCDRC9u0KYzASarRjMtm
         VA6A==
X-Gm-Message-State: AJIora92nh3l7W26VEMXsFa8NnmDbKyvDKiutTdYrzQTlLTo+PUpo/Xl
        F/selTmo8M3/E7ZBveqxow==
X-Google-Smtp-Source: AGRyM1thrWKms7c1c3mXmmen1uUthVUBGLRAbpm6KwkUZVHEbfzSNJO2k4D7fpl4siWOI9Aprr1yOg==
X-Received: by 2002:a92:608:0:b0:2da:999:9014 with SMTP id x8-20020a920608000000b002da09999014mr8687392ilg.69.1656369807046;
        Mon, 27 Jun 2022 15:43:27 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id u18-20020a92ccd2000000b002d8d813892csm5068217ilq.8.2022.06.27.15.43.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 15:43:26 -0700 (PDT)
Received: (nullmailer pid 3101886 invoked by uid 1000);
        Mon, 27 Jun 2022 22:43:25 -0000
Date:   Mon, 27 Jun 2022 16:43:25 -0600
From:   Rob Herring <robh@kernel.org>
To:     Stefan Berger <stefanb@linux.ibm.com>
Cc:     kexec@lists.infradead.org, devicetree@vger.kernel.org,
        linux-integrity@vger.kernel.org, nayna@linux.ibm.com,
        nasastry@in.ibm.com, Jarkko Sakkinen <jarkko@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Frank Rowand <frowand.list@gmail.com>
Subject: Re: [PATCH v2 1/3] tpm: of: Move of-tree specific code from tpm
 driver into of driver
Message-ID: <20220627224325.GB3082294-robh@kernel.org>
References: <20220616154130.2052541-1-stefanb@linux.ibm.com>
 <20220616154130.2052541-2-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220616154130.2052541-2-stefanb@linux.ibm.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Jun 16, 2022 at 11:41:28AM -0400, Stefan Berger wrote:
> Simplify tpm_read_log_of() by moving Openfirmware-specific code into
> the Openfirmware driver to make the code reusable. Call the new

There is no such 'Openfirmware driver'.

> of_tpm_get_sml_parameters() function from the TPM Openfirmware driver.
> 
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> Cc: Jarkko Sakkinen <jarkko@kernel.org>
> Cc: Jason Gunthorpe <jgg@ziepe.ca>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Frank Rowand <frowand.list@gmail.com>
> ---
>  drivers/char/tpm/eventlog/of.c | 31 +++++--------------------------
>  drivers/of/Makefile            |  2 +-
>  drivers/of/device_node.c       | 27 +++++++++++++++++++++++++++

Humm, definitely the wrong direction. Generally, code for specific 
bindings does not go in drivers/of/. There used to be some, but we've 
moved it to the appropriate subsystems. kexec was an exception to not 
have 2 copies of the same code in arch/.

>  include/linux/of_device_node.h |  9 +++++++++

of_tpm.h would be the right name assuming we kept this structure which 
we shouldn't. Probably linux/tpm.h? Just a guess, I'm not familar with 
the TPM code really.


>  4 files changed, 42 insertions(+), 27 deletions(-)
>  create mode 100644 drivers/of/device_node.c
>  create mode 100644 include/linux/of_device_node.h
> 
> diff --git a/drivers/char/tpm/eventlog/of.c b/drivers/char/tpm/eventlog/of.c
> index a9ce66d09a75..5b18f4333ad1 100644
> --- a/drivers/char/tpm/eventlog/of.c
> +++ b/drivers/char/tpm/eventlog/of.c
> @@ -12,6 +12,7 @@
>  
>  #include <linux/slab.h>
>  #include <linux/of.h>
> +#include <linux/of_device_node.h>
>  #include <linux/tpm_eventlog.h>
>  
>  #include "../tpm.h"
> @@ -20,11 +21,10 @@
>  int tpm_read_log_of(struct tpm_chip *chip)
>  {
>  	struct device_node *np;
> -	const u32 *sizep;
> -	const u64 *basep;
>  	struct tpm_bios_log *log;
>  	u32 size;
>  	u64 base;
> +	int ret;
>  
>  	log = &chip->log;
>  	if (chip->dev.parent && chip->dev.parent->of_node)
> @@ -35,30 +35,9 @@ int tpm_read_log_of(struct tpm_chip *chip)
>  	if (of_property_read_bool(np, "powered-while-suspended"))
>  		chip->flags |= TPM_CHIP_FLAG_ALWAYS_POWERED;
>  
> -	sizep = of_get_property(np, "linux,sml-size", NULL);
> -	basep = of_get_property(np, "linux,sml-base", NULL);
> -	if (sizep == NULL && basep == NULL)
> -		return -ENODEV;
> -	if (sizep == NULL || basep == NULL)
> -		return -EIO;
> -
> -	/*
> -	 * For both vtpm/tpm, firmware has log addr and log size in big
> -	 * endian format. But in case of vtpm, there is a method called
> -	 * sml-handover which is run during kernel init even before
> -	 * device tree is setup. This sml-handover function takes care
> -	 * of endianness and writes to sml-base and sml-size in little
> -	 * endian format. For this reason, vtpm doesn't need conversion
> -	 * but physical tpm needs the conversion.
> -	 */
> -	if (of_property_match_string(np, "compatible", "IBM,vtpm") < 0 &&
> -	    of_property_match_string(np, "compatible", "IBM,vtpm20") < 0) {
> -		size = be32_to_cpup((__force __be32 *)sizep);
> -		base = be64_to_cpup((__force __be64 *)basep);
> -	} else {
> -		size = *sizep;
> -		base = *basep;
> -	}
> +	ret = of_tpm_get_sml_parameters(np, &base, &size);
> +	if (ret < 0)
> +		return ret;
>  
>  	if (size == 0) {
>  		dev_warn(&chip->dev, "%s: Event log area empty\n", __func__);
> diff --git a/drivers/of/Makefile b/drivers/of/Makefile
> index e0360a44306e..1c9feac450ad 100644
> --- a/drivers/of/Makefile
> +++ b/drivers/of/Makefile
> @@ -1,5 +1,5 @@
>  # SPDX-License-Identifier: GPL-2.0
> -obj-y = base.o device.o platform.o property.o
> +obj-y = base.o device.o platform.o property.o device_node.o
>  obj-$(CONFIG_OF_KOBJ) += kobj.o
>  obj-$(CONFIG_OF_DYNAMIC) += dynamic.o
>  obj-$(CONFIG_OF_FLATTREE) += fdt.o
> diff --git a/drivers/of/device_node.c b/drivers/of/device_node.c
> new file mode 100644
> index 000000000000..71a19bc1bac2
> --- /dev/null
> +++ b/drivers/of/device_node.c
> @@ -0,0 +1,27 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <linux/export.h>
> +#include <linux/of_device_node.h>
> +
> +int of_tpm_get_sml_parameters(struct device_node *np, u64 *base, u32 *size)
> +{
> +	const u32 *sizep;
> +	const u64 *basep;
> +
> +	sizep = of_get_property(np, "linux,sml-size", NULL);
> +	basep = of_get_property(np, "linux,sml-base", NULL);
> +	if (sizep == NULL && basep == NULL)
> +		return -ENODEV;
> +	if (sizep == NULL || basep == NULL)
> +		return -EIO;
> +
> +	if (of_property_match_string(np, "compatible", "IBM,vtpm") < 0 &&
> +	    of_property_match_string(np, "compatible", "IBM,vtpm20") < 0) {
> +		*size = be32_to_cpup((__force __be32 *)sizep);
> +		*base = be64_to_cpup((__force __be64 *)basep);
> +	} else {
> +		*size = *sizep;
> +		*base = *basep;
> +	}
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(of_tpm_get_sml_parameters);
> diff --git a/include/linux/of_device_node.h b/include/linux/of_device_node.h
> new file mode 100644
> index 000000000000..ae3faf023aab
> --- /dev/null
> +++ b/include/linux/of_device_node.h
> @@ -0,0 +1,9 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _LINUX_OF_DEVICE_NODE_H
> +#define _LINUX_OF_DEVICE_NODE_H
> +
> +#include <linux/of.h>
> +
> +int of_tpm_get_sml_parameters(struct device_node *np, u64 *base, u32 *size);
> +
> +#endif /* _LINUX_OF_DEVICE_NODE_H */
> -- 
> 2.35.1
> 
> 
