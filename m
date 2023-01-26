Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9395567D7DE
	for <lists+linux-integrity@lfdr.de>; Thu, 26 Jan 2023 22:43:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229891AbjAZVnA (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 26 Jan 2023 16:43:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjAZVnA (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 26 Jan 2023 16:43:00 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E52811557D;
        Thu, 26 Jan 2023 13:42:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 91A84B81F30;
        Thu, 26 Jan 2023 21:42:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE2E9C433D2;
        Thu, 26 Jan 2023 21:42:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674769375;
        bh=l3Uyb82BaOWolYcaNG8gvhPvBzloLPhy1u9itF1KnXQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jr9FeX+8ohKfjWMmp5iYnhJ5jis4zsasvr38Cn8JZ4YXcUUh4DbNpVpfPOsngWLPz
         viEqUJafcH17WCoVLqKdDPBHUgnZc0U2aVAp3lvkTUjcph4SnVj1YaO/A0a6Xs4FY/
         cgQoBWOhSpJdavhd16k4VP4nJl0Fvaix5KlZzEmrFqYXuv8rSPWKMCyjj/OaIFyami
         U+F92bi5ltseH60vBD7c//h1OUWB9SDgeK5ShnbRjeuI78YjT692nRyc+6b8x/M63K
         QWS5s6yOXwKv2hZjPXsOzd7DkZvCvKXQFXQaf8Lj3XrdLx+oM/+qAe6IQqN4Tmc57c
         jd2yEGMQzOSuw==
Date:   Thu, 26 Jan 2023 21:42:52 +0000
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Eddie James <eajames@linux.ibm.com>
Cc:     linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, peterhuewe@gmx.de, jgg@ziepe.ca,
        stefanb@linux.ibm.com
Subject: Re: [PATCH v3 2/2] tpm: Add reserved memory event log
Message-ID: <Y9Lz3EnACr937Oeh@kernel.org>
References: <20230126210810.881119-1-eajames@linux.ibm.com>
 <20230126210810.881119-3-eajames@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230126210810.881119-3-eajames@linux.ibm.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Jan 26, 2023 at 03:08:10PM -0600, Eddie James wrote:
> Some platforms may desire to pass the event log up to Linux in the
> form of a reserved memory region. In particular, this is desirable
> for embedded systems or baseboard management controllers (BMCs)
> booting with U-Boot. IBM OpenBMC BMCs will be the first user.
> Add support for the reserved memory in the TPM core to find the
> region and map it.
> 
> Signed-off-by: Eddie James <eajames@linux.ibm.com>
> ---
>  drivers/char/tpm/eventlog/of.c | 38 +++++++++++++++++++++++++++++++++-
>  1 file changed, 37 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/char/tpm/eventlog/of.c b/drivers/char/tpm/eventlog/of.c
> index 741ab2204b11..c815cadf00a4 100644
> --- a/drivers/char/tpm/eventlog/of.c
> +++ b/drivers/char/tpm/eventlog/of.c
> @@ -12,12 +12,48 @@
>  
>  #include <linux/device.h>
>  #include <linux/slab.h>
> +#include <linux/io.h>
> +#include <linux/ioport.h>
>  #include <linux/of.h>
> +#include <linux/of_address.h>
> +#include <linux/of_reserved_mem.h>
>  #include <linux/tpm_eventlog.h>
>  
>  #include "../tpm.h"
>  #include "common.h"
>  
> +static int tpm_read_log_memory_region(struct tpm_chip *chip)
> +{
> +	struct device_node *node;
> +	struct resource res;
> +	int rc;
> +
> +	node = of_parse_phandle(chip->dev.parent->of_node, "memory-region", 0);
> +	if (!node) {
> +		dev_info(&chip->dev, "no phandle\n");
> +		return -ENODEV;
> +	}
> +
> +	rc = of_address_to_resource(node, 0, &res);
> +	of_node_put(node);
> +	if (rc) {
> +		dev_info(&chip->dev, "no mem\n");
> +		return rc;
> +	}
> +
> +	chip->log.bios_event_log = devm_memremap(&chip->dev, res.start, resource_size(&res),
> +						 MEMREMAP_WB);
> +	if (!chip->log.bios_event_log) {
> +		dev_info(&chip->dev, "err memremap\n");
> +		return -ENOMEM;
> +	}
> +
> +	chip->log.bios_event_log_end = chip->log.bios_event_log + resource_size(&res);
> +
> +	return chip->flags & TPM_CHIP_FLAG_TPM2 ? EFI_TCG2_EVENT_LOG_FORMAT_TCG_2 :
> +		EFI_TCG2_EVENT_LOG_FORMAT_TCG_1_2;
> +}
> +
>  int tpm_read_log_of(struct tpm_chip *chip)
>  {
>  	struct device_node *np;
> @@ -39,7 +75,7 @@ int tpm_read_log_of(struct tpm_chip *chip)
>  	sizep = of_get_property(np, "linux,sml-size", NULL);
>  	basep = of_get_property(np, "linux,sml-base", NULL);
>  	if (sizep == NULL && basep == NULL)
> -		return -ENODEV;
> +		return tpm_read_log_memory_region(chip);
>  	if (sizep == NULL || basep == NULL)
>  		return -EIO;
>  
> -- 
> 2.31.1
> 

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko
