Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E27B66B7A6
	for <lists+linux-integrity@lfdr.de>; Mon, 16 Jan 2023 07:53:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231824AbjAPGxX (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 16 Jan 2023 01:53:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231808AbjAPGxT (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 16 Jan 2023 01:53:19 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0F54B454;
        Sun, 15 Jan 2023 22:53:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7953260EB9;
        Mon, 16 Jan 2023 06:53:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9943C433EF;
        Mon, 16 Jan 2023 06:53:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673851997;
        bh=r330yDSt0Ej4UFVtrX6ThGlLnT2ao1tPmMsNZmoKis0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=m8Y5lRCHCGJBITA9PqkzFPYD5rpERBJ7PATh5cewKy1OXWj7srJ3l2EdJCsUJMVp6
         Jtfn6e77c1Kz5PzuDnvoWkiUhn5mDPBrdNdDjsyyp2QbyD1FDzO54lKi9+iMkNkxG3
         gEklRbn6gzpd6jEA5pYmE3yXLT5+5LYrb/xaxdUx205hpBSMGgrHS2P3fjn6B9avbz
         aw3JBKE8MA4lB1YHspCPMDpnrWinqP8eP0mwEkMgmW8ME1d7lo7tcPW2EEsBhN0Hug
         ppEl0X0JwCIrSzpazeaGnaEMXna78mFYd6cjP52Znp+uunZf3bMPlFtbw5xo/874eW
         nJPMqybozjBEg==
Date:   Mon, 16 Jan 2023 08:53:11 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Eddie James <eajames@linux.ibm.com>
Cc:     linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        jgg@ziepe.ca, peterhuewe@gmx.de, joel@jms.id.au
Subject: Re: [PATCH] tpm: Add reserved memory event log
Message-ID: <Y8T0VxQiCQH5sDEs@kernel.org>
References: <20230103162010.381214-1-eajames@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230103162010.381214-1-eajames@linux.ibm.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Jan 03, 2023 at 10:20:10AM -0600, Eddie James wrote:
> Some platforms may desire to pass the event log up to linux in the
> form of a reserved memory region. Add support for this in the TPM
> core to find the reserved memory region and map it.
> 
> Signed-off-by: Eddie James <eajames@linux.ibm.com>

Which platforms? 

I do not see information of 

+	void (*release)(void *ptr);

in the commit message. The description of the implemenation approach is
missing.


> ---
>  drivers/char/tpm/eventlog/of.c | 38 +++++++++++++++++++++++++++++++++-
>  drivers/char/tpm/tpm-chip.c    |  3 ++-
>  include/linux/tpm.h            |  1 +
>  3 files changed, 40 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/char/tpm/eventlog/of.c b/drivers/char/tpm/eventlog/of.c
> index a9ce66d09a75..0455d7f61c10 100644
> --- a/drivers/char/tpm/eventlog/of.c
> +++ b/drivers/char/tpm/eventlog/of.c
> @@ -11,12 +11,48 @@
>   */
>  
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
> +	chip->log.bios_event_log = memremap(res.start, resource_size(&res), MEMREMAP_WB);
> +	if (!chip->log.bios_event_log) {
> +		dev_info(&chip->dev, "err memremap\n");
> +		return -ENOMEM;
> +	}
> +
> +	chip->log.release = memunmap;
> +	chip->log.bios_event_log_end = chip->log.bios_event_log + resource_size(&res);
> +
> +	return chip->flags & TPM_CHIP_FLAG_TPM2 ? EFI_TCG2_EVENT_LOG_FORMAT_TCG_2 :
> +		EFI_TCG2_EVENT_LOG_FORMAT_TCG_1_2;
> +}

We do not want to support TPM 1.2 for new features.

> +
>  int tpm_read_log_of(struct tpm_chip *chip)
>  {
>  	struct device_node *np;
> @@ -38,7 +74,7 @@ int tpm_read_log_of(struct tpm_chip *chip)
>  	sizep = of_get_property(np, "linux,sml-size", NULL);
>  	basep = of_get_property(np, "linux,sml-base", NULL);
>  	if (sizep == NULL && basep == NULL)
> -		return -ENODEV;
> +		return tpm_read_log_memory_region(chip);
>  	if (sizep == NULL || basep == NULL)
>  		return -EIO;
>  
> diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
> index 741d8f3e8fb3..09ea8145d7c6 100644
> --- a/drivers/char/tpm/tpm-chip.c
> +++ b/drivers/char/tpm/tpm-chip.c
> @@ -267,7 +267,7 @@ static void tpm_dev_release(struct device *dev)
>  	idr_remove(&dev_nums_idr, chip->dev_num);
>  	mutex_unlock(&idr_lock);
>  
> -	kfree(chip->log.bios_event_log);
> +	chip->log.release(chip->log.bios_event_log);
>  	kfree(chip->work_space.context_buf);
>  	kfree(chip->work_space.session_buf);
>  	kfree(chip->allocated_banks);
> @@ -324,6 +324,7 @@ struct tpm_chip *tpm_chip_alloc(struct device *pdev,
>  	init_rwsem(&chip->ops_sem);
>  
>  	chip->ops = ops;
> +	chip->log.release = (void(*)(void *))kfree;

Why do you need this cast?

>  
>  	mutex_lock(&idr_lock);
>  	rc = idr_alloc(&dev_nums_idr, NULL, 0, TPM_NUM_DEVICES, GFP_KERNEL);
> diff --git a/include/linux/tpm.h b/include/linux/tpm.h
> index dfeb25a0362d..f1c0b0eb20a5 100644
> --- a/include/linux/tpm.h
> +++ b/include/linux/tpm.h
> @@ -109,6 +109,7 @@ struct tpm_space {
>  struct tpm_bios_log {
>  	void *bios_event_log;
>  	void *bios_event_log_end;
> +	void (*release)(void *ptr);
>  };
>  
>  struct tpm_chip_seqops {
> -- 
> 2.31.1
> 

BR, Jarkko
