Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC5026761F0
	for <lists+linux-integrity@lfdr.de>; Sat, 21 Jan 2023 01:13:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229511AbjAUANQ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 20 Jan 2023 19:13:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbjAUANP (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 20 Jan 2023 19:13:15 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D06A677A0;
        Fri, 20 Jan 2023 16:13:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2ABD1B82A99;
        Sat, 21 Jan 2023 00:13:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70BC8C433D2;
        Sat, 21 Jan 2023 00:13:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674259991;
        bh=KxHJJ5wVsnIwyxLLGrjeyRdyqzS7aLxC/G5m+Eq7WrA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TbixMpw5/8WDnDPgmbC4aBzf+pqg9ytmLouhWWaPP43tNeNPUEzFrm2qFYQkPkPuK
         uMUkBzt0G89Xst1uNDHZJCZ/3/TgvuNJcs/DaH4/6M/R8FbFl//nFh3WI216iO/Xuw
         ldW6jF/FMbP2ZjSXYP2sRwsGtisqJyI33UuwwQxnfs3O+9HgHuntK+zlH6pRfIhfwX
         PIdOljkuDVQWfLoWfvhxNVTYHWxzDwl4XwYyoqHtgst+N2iwB8UDo8UAmIS5kYoBDP
         DdTiv1Wnmqya3qcADbIgxdAJCTszQBJkzqsrUrlccJlP0/OsiiLdAqy0hXlOJ4SXj5
         o5/YxTuEOlMug==
Date:   Sat, 21 Jan 2023 00:13:09 +0000
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Eddie James <eajames@linux.ibm.com>
Cc:     linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        jgg@ziepe.ca, peterhuewe@gmx.de
Subject: Re: [PATCH v2 2/2] tpm: Add reserved memory event log
Message-ID: <Y8suFZHqR63ngGvL@kernel.org>
References: <20230113161017.1079299-1-eajames@linux.ibm.com>
 <20230113161017.1079299-3-eajames@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230113161017.1079299-3-eajames@linux.ibm.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, Jan 13, 2023 at 10:10:17AM -0600, Eddie James wrote:
> Some platforms may desire to pass the event log up to linux in the
> form of a reserved memory region. Add support for this in the TPM
> core to find the reserved memory region and map it.
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

I would CC this to linux-devicetree.

BR, Jarkko
