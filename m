Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BAA8656A5A
	for <lists+linux-integrity@lfdr.de>; Tue, 27 Dec 2022 13:01:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229801AbiL0MBM (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 27 Dec 2022 07:01:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231678AbiL0L4K (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 27 Dec 2022 06:56:10 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B9F3A199
        for <linux-integrity@vger.kernel.org>; Tue, 27 Dec 2022 03:56:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AE38461013
        for <linux-integrity@vger.kernel.org>; Tue, 27 Dec 2022 11:56:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4F5BC433EF;
        Tue, 27 Dec 2022 11:56:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672142168;
        bh=MCbP4nE0gudJ57KgNOjmSML4VRM/9Rin7eC3pGC2/SI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LDFsP8sA0Sf/gPTXcb7AYLnbBcx/xFPIq46v6EmrCVLlxzYswPKTTYrFCEfpVDp9H
         27bgBleBFihecrwxWD4emz5yyJYs9ov5cSKwCqQb/HOLzQIjE/7I89Nf0fwzb8/aQn
         DjA4eLzdW2py6+gBLhRwgkgzVafyqVBx6sl3Rh845gsXiE6TsRuemcVSJlAstwRh15
         BFd3Gle3mj7sCkYkaFLNrJZhV6h7h/5bkfJpOUE+q5L+e/RZQkZlTWuH5llplPL59e
         JWtgwEgJzGtegwmhMgKoQJIIXnHaZlVOpPAQhobKHnWl+4c8GQ4aKesxw/ITlZvLcQ
         K7qEfFn4GB9Vg==
Date:   Tue, 27 Dec 2022 11:56:02 +0000
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Matthew Garrett <mjg59@srcf.ucam.org>
Cc:     peterhuewe@gmx.de, jgg@ziepe.ca, linux-integrity@vger.kernel.org
Subject: Re: [PATCH] tpm_crb: Add support for CRB devices based on Pluton
Message-ID: <Y6rdUvQhwIczoKXX@kernel.org>
References: <20221212104220.455658-1-mjg59@srcf.ucam.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221212104220.455658-1-mjg59@srcf.ucam.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Dec 12, 2022 at 02:42:20AM -0800, Matthew Garrett wrote:
> Pluton is an integrated security processor present in some recent Ryzen
> parts. If it's enabled, it presents two devices - an MSFT0101 ACPI device
> that's broadly an implementation of a Command Response Buffer TPM2, and
> an MSFT0200 ACPI device whose functionality I haven't examined in detail
> yet. This patch only attempts to add support for the TPM device.
> 
> There's a few things that need to be handled here. The first is that the
> TPM2 ACPI table uses a previously undefined start method identifier. The
> table format appears to include 16 bytes of startup data, which corresponds
> to one 64-bit address for a start message and one 64-bit address for a
> completion response. The second is that the ACPI tables on the Thinkpad Z13
> I'm testing this on don't define any memory windows in _CRS (or, more
> accurately, there are two empty memory windows). This check doesn't seem
> strictly necessary, so I've skipped that.
> 
> Finally, it seems like chip needs to be explicitly asked to transition into
> ready status on every command. Failing to do this means that if two commands
> are sent in succession without an idle/ready transition in between,
> everything will appear to work fine but the response is simply the original
> command. I'm working without any docs here, so I'm not sure if this is
> actually the required behaviour or if I'm missing something somewhere else,
> but doing this results in the chip working reliably.
> 
> Signed-off-by: Matthew Garrett <mjg59@srcf.ucam.org>
> ---
>  drivers/char/tpm/tpm_crb.c | 96 ++++++++++++++++++++++++++++++++++----
>  include/acpi/actbl3.h      |  1 +
>  2 files changed, 88 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm_crb.c b/drivers/char/tpm/tpm_crb.c
> index 18606651d1aa..7c6ec3aafce8 100644
> --- a/drivers/char/tpm/tpm_crb.c
> +++ b/drivers/char/tpm/tpm_crb.c
> @@ -98,6 +98,8 @@ struct crb_priv {
>  	u8 __iomem *rsp;
>  	u32 cmd_size;
>  	u32 smc_func_id;
> +	u32 __iomem *pluton_start_addr;
> +	u32 __iomem *pluton_reply_addr;
>  };
>  
>  struct tpm2_crb_smc {
> @@ -108,6 +110,11 @@ struct tpm2_crb_smc {
>  	u32 smc_func_id;
>  };
>  
> +struct tpm2_crb_pluton {
> +	u64 start_addr;
> +	u64 reply_addr;
> +};
> +
>  static bool crb_wait_for_reg_32(u32 __iomem *reg, u32 mask, u32 value,
>  				unsigned long timeout)
>  {
> @@ -127,6 +134,24 @@ static bool crb_wait_for_reg_32(u32 __iomem *reg, u32 mask, u32 value,
>  	return ((ioread32(reg) & mask) == value);
>  }
>  
> +static int crb_do_pluton_doorbell(struct crb_priv *priv, bool wait_for_complete)
> +{
> +	if (!crb_wait_for_reg_32(priv->pluton_reply_addr,
> +				 0xffffffff, 1, 200)) {

        if (!crb_wait_for_reg_32(priv->pluton_reply_addr, ~0, 1, TPM2_TIMEOUT_C)

> +		return -EINVAL;

Hmm... shouldn't this also return -ETIME?

> +	}
> +
> +	iowrite32(1, priv->pluton_start_addr);
> +	if (wait_for_complete == false)
> +		return 0;
> +
> +	if (!crb_wait_for_reg_32(priv->pluton_start_addr,
> +				 0xffffffff, 0, 200))
> +		return -ETIME;
> +
> +	return 0;
> +}
> +
>  /**
>   * __crb_go_idle - request tpm crb device to go the idle state
>   *
> @@ -145,6 +170,8 @@ static bool crb_wait_for_reg_32(u32 __iomem *reg, u32 mask, u32 value,
>   */
>  static int __crb_go_idle(struct device *dev, struct crb_priv *priv)
>  {
> +	int rc = 0;
> +
>  	if ((priv->sm == ACPI_TPM2_START_METHOD) ||
>  	    (priv->sm == ACPI_TPM2_COMMAND_BUFFER_WITH_START_METHOD) ||
>  	    (priv->sm == ACPI_TPM2_COMMAND_BUFFER_WITH_ARM_SMC))
> @@ -152,6 +179,12 @@ static int __crb_go_idle(struct device *dev, struct crb_priv *priv)
>  
>  	iowrite32(CRB_CTRL_REQ_GO_IDLE, &priv->regs_t->ctrl_req);
>  
> +	if (priv->sm == ACPI_TPM2_COMMAND_BUFFER_WITH_PLUTON)
> +		rc = crb_do_pluton_doorbell(priv, true);
> +
> +	if (rc)
> +		return rc;

Since the impact to latency is insignificant, wouldn't it be better
idea to name the function just: crg_try_pluton_doorbell() and in the
beginning of that function do:

static int crb_try_pluton_doorbell(struct crb_priv *priv, bool wait_for_complete)
{
        if (priv->sm != ACPI_TPM2_COMMAND_BUFFER_WITH_PLUTON)
                return 0;

The you don't have to repeat the same condition everywhere, and you don't
have to initialize 'rc' in the beginning of the function.

> +
>  	if (!crb_wait_for_reg_32(&priv->regs_t->ctrl_req,
>  				 CRB_CTRL_REQ_GO_IDLE/* mask */,
>  				 0, /* value */
> @@ -194,6 +227,10 @@ static int __crb_cmd_ready(struct device *dev, struct crb_priv *priv)
>  		return 0;
>  
>  	iowrite32(CRB_CTRL_REQ_CMD_READY, &priv->regs_t->ctrl_req);
> +
> +	if (priv->sm == ACPI_TPM2_COMMAND_BUFFER_WITH_PLUTON)
> +		crb_do_pluton_doorbell(priv, true);
> +
>  	if (!crb_wait_for_reg_32(&priv->regs_t->ctrl_req,
>  				 CRB_CTRL_REQ_CMD_READY /* mask */,
>  				 0, /* value */
> @@ -371,6 +408,10 @@ static int crb_send(struct tpm_chip *chip, u8 *buf, size_t len)
>  		return -E2BIG;
>  	}
>  
> +	/* Seems to be necessary for every command */
> +	if (priv->sm == ACPI_TPM2_COMMAND_BUFFER_WITH_PLUTON)
> +		__crb_cmd_ready(&chip->dev, priv);
> +
>  	memcpy_toio(priv->cmd, buf, len);
>  
>  	/* Make sure that cmd is populated before issuing start. */
> @@ -394,6 +435,9 @@ static int crb_send(struct tpm_chip *chip, u8 *buf, size_t len)
>  		rc = tpm_crb_smc_start(&chip->dev, priv->smc_func_id);
>  	}
>  
> +	if (priv->sm == ACPI_TPM2_COMMAND_BUFFER_WITH_PLUTON)
> +		rc = crb_do_pluton_doorbell(priv, false);
> +
>  	return rc;
>  }
>  
> @@ -524,15 +568,18 @@ static int crb_map_io(struct acpi_device *device, struct crb_priv *priv,
>  		return ret;
>  	acpi_dev_free_resource_list(&acpi_resource_list);
>  
> -	if (resource_type(iores_array) != IORESOURCE_MEM) {
> -		dev_err(dev, FW_BUG "TPM2 ACPI table does not define a memory resource\n");
> -		return -EINVAL;
> -	} else if (resource_type(iores_array + TPM_CRB_MAX_RESOURCES) ==
> -		IORESOURCE_MEM) {
> -		dev_warn(dev, "TPM2 ACPI table defines too many memory resources\n");
> -		memset(iores_array + TPM_CRB_MAX_RESOURCES,
> -		       0, sizeof(*iores_array));
> -		iores_array[TPM_CRB_MAX_RESOURCES].flags = 0;
> +	/* Pluton doesn't appear to define ACPI memory regions */
> +	if (priv->sm != ACPI_TPM2_COMMAND_BUFFER_WITH_PLUTON) {
> +		if (resource_type(iores_array) != IORESOURCE_MEM) {
> +			dev_err(dev, FW_BUG "TPM2 ACPI table does not define a memory resource\n");
> +			return -EINVAL;
> +		} else if (resource_type(iores_array + TPM_CRB_MAX_RESOURCES) ==
> +			   IORESOURCE_MEM) {
> +			dev_warn(dev, "TPM2 ACPI table defines too many memory resources\n");
> +			memset(iores_array + TPM_CRB_MAX_RESOURCES,
> +			       0, sizeof(*iores_array));
> +			iores_array[TPM_CRB_MAX_RESOURCES].flags = 0;
> +		}
>  	}
>  
>  	iores = NULL;
> @@ -656,6 +703,22 @@ static int crb_map_io(struct acpi_device *device, struct crb_priv *priv,
>  	return ret;
>  }
>  
> +static int crb_map_pluton(struct device *dev, struct crb_priv *priv,
> +	       struct acpi_table_tpm2 *buf, struct tpm2_crb_pluton *crb_pluton)
> +{
> +	priv->pluton_start_addr = crb_map_res(dev, NULL, NULL,
> +					      crb_pluton->start_addr, 4);
> +	if (IS_ERR(priv->pluton_start_addr))
> +		return PTR_ERR(priv->pluton_start_addr);
> +
> +	priv->pluton_reply_addr = crb_map_res(dev, NULL, NULL,
> +					      crb_pluton->reply_addr, 4);
> +	if (IS_ERR(priv->pluton_reply_addr))
> +		return PTR_ERR(priv->pluton_reply_addr);
> +
> +	return 0;
> +}
> +
>  static int crb_acpi_add(struct acpi_device *device)
>  {
>  	struct acpi_table_tpm2 *buf;
> @@ -663,6 +726,7 @@ static int crb_acpi_add(struct acpi_device *device)
>  	struct tpm_chip *chip;
>  	struct device *dev = &device->dev;
>  	struct tpm2_crb_smc *crb_smc;
> +	struct tpm2_crb_pluton *crb_pluton;
>  	acpi_status status;
>  	u32 sm;
>  	int rc;
> @@ -695,6 +759,20 @@ static int crb_acpi_add(struct acpi_device *device)
>  		priv->smc_func_id = crb_smc->smc_func_id;
>  	}
>  
> +	if (sm == ACPI_TPM2_COMMAND_BUFFER_WITH_PLUTON) {
> +		if (buf->header.length < (sizeof(*buf) + sizeof(*crb_pluton))) {
> +			dev_err(dev,
> +				FW_BUG "TPM2 ACPI table has wrong size %u for start method type %d\n",
> +				buf->header.length,
> +				ACPI_TPM2_COMMAND_BUFFER_WITH_PLUTON);
> +			return -EINVAL;
> +		}
> +		crb_pluton = ACPI_ADD_PTR(struct tpm2_crb_pluton, buf, sizeof(*buf));
> +		rc = crb_map_pluton(dev, priv, buf, crb_pluton);
> +		if (rc)
> +			return rc;
> +	}
> +
>  	priv->sm = sm;
>  	priv->hid = acpi_device_hid(device);
>  
> diff --git a/include/acpi/actbl3.h b/include/acpi/actbl3.h
> index 7b9571e00cc4..832c6464f063 100644
> --- a/include/acpi/actbl3.h
> +++ b/include/acpi/actbl3.h
> @@ -443,6 +443,7 @@ struct acpi_tpm2_phy {
>  #define ACPI_TPM2_RESERVED10                        10
>  #define ACPI_TPM2_COMMAND_BUFFER_WITH_ARM_SMC       11	/* V1.2 Rev 8 */
>  #define ACPI_TPM2_RESERVED                          12
> +#define ACPI_TPM2_COMMAND_BUFFER_WITH_PLUTON        13
>  
>  /* Optional trailer appears after any start_method subtables */
>  
> -- 
> 2.38.1
> 

BR, Jarkko
