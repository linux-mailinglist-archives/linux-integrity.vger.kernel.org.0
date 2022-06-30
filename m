Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 108A856270A
	for <lists+linux-integrity@lfdr.de>; Fri,  1 Jul 2022 01:27:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230186AbiF3XTm (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 30 Jun 2022 19:19:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231373AbiF3XTl (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 30 Jun 2022 19:19:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A32DE564FD;
        Thu, 30 Jun 2022 16:19:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1F204616E0;
        Thu, 30 Jun 2022 23:19:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 282AFC34115;
        Thu, 30 Jun 2022 23:19:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656631157;
        bh=BR0r2dduUR/WI3YgZVdnl8RyvuG0Wez2J1vJInDake0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=B4J7g71ivqGJC1/F+MdyOekEY20SPrHHPzPZCT/sdH4sCfNz2zx735XfQ78Ybw1ma
         Nswr4afSN44uvWlQWvklHbvWV6aQDLTwJWXEG3cui3fzCW8St76MbUu4itvu5iPXdq
         i178d0ucpC3LdPTZ+ozp9Wa+CYBD3pcD/FUVQBZg3sPEVtt94UAf1NpP6ejkCkUWiu
         oNvdXEKvmNgogEQh2Z3IGdTedDD8L1vGx/kbWkpGJZhn/rUbP98qaGZEHCY2daAUsM
         mKlLtOP2mIAwVNV6McA+dZlhciP+P6YkE37VAbPgA6zoyG0/T3jEOQ8oE9R+yOKU13
         NZRGq+YdIARJQ==
Date:   Fri, 1 Jul 2022 02:19:13 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Lino Sanfilippo <LinoSanfilippo@gmx.de>
Cc:     peterhuewe@gmx.de, jgg@ziepe.ca, stefanb@linux.vnet.ibm.com,
        linux@mniewoehner.de, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, l.sanfilippo@kunbus.com,
        lukas@wunner.de, p.rosenberger@kunbus.com
Subject: Re: [PATCH v7 06/10] tpm, tpm_tis: Move interrupt mask checks into
 own function
Message-ID: <Yr4vcYpAonXzD2Qu@kernel.org>
References: <20220629232653.1306735-1-LinoSanfilippo@gmx.de>
 <20220629232653.1306735-7-LinoSanfilippo@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220629232653.1306735-7-LinoSanfilippo@gmx.de>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Jun 30, 2022 at 01:26:49AM +0200, Lino Sanfilippo wrote:
> From: Lino Sanfilippo <l.sanfilippo@kunbus.com>
> 
> Clean up wait_for_tpm_stat() by moving multiple similar interrupt mask
> checks into an own function.
> 
> Signed-off-by: Lino Sanfilippo <l.sanfilippo@kunbus.com>
> Suggested-by: Jarkko Sakkinen <jarkko@kernel.org>
> ---
>  drivers/char/tpm/tpm_tis_core.c | 29 ++++++++++++++++++-----------
>  1 file changed, 18 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
> index c13599e94ab6..bd4eeb0b2192 100644
> --- a/drivers/char/tpm/tpm_tis_core.c
> +++ b/drivers/char/tpm/tpm_tis_core.c
> @@ -44,6 +44,20 @@ static bool wait_for_tpm_stat_cond(struct tpm_chip *chip, u8 mask,
>  	return false;
>  }
>  
> +static u8 tpm_tis_filter_sts_mask(u8 int_mask, u8 sts_mask)
> +{
> +	if (!(int_mask & TPM_INTF_STS_VALID_INT))
> +		sts_mask &= ~TPM_STS_VALID;
> +
> +	if (!(int_mask & TPM_INTF_DATA_AVAIL_INT))
> +		sts_mask &= ~TPM_STS_DATA_AVAIL;
> +
> +	if (!(int_mask & TPM_INTF_CMD_READY_INT))
> +		sts_mask &= ~TPM_STS_COMMAND_READY;
> +
> +	return sts_mask;
> +}
> +
>  static int wait_for_tpm_stat(struct tpm_chip *chip, u8 mask,
>  		unsigned long timeout, wait_queue_head_t *queue,
>  		bool check_cancel)
> @@ -53,7 +67,7 @@ static int wait_for_tpm_stat(struct tpm_chip *chip, u8 mask,
>  	long rc;
>  	u8 status;
>  	bool canceled = false;
> -	u8 sts_mask = 0;
> +	u8 sts_mask;
>  	int ret = 0;
>  
>  	/* check current status */
> @@ -61,17 +75,10 @@ static int wait_for_tpm_stat(struct tpm_chip *chip, u8 mask,
>  	if ((status & mask) == mask)
>  		return 0;
>  
> +	sts_mask = mask & (TPM_STS_VALID | TPM_STS_DATA_AVAIL |
> +			   TPM_STS_COMMAND_READY);
>  	/* check which status changes can be handled by irqs */
> -	if (priv->int_mask & TPM_INTF_STS_VALID_INT)
> -		sts_mask |= TPM_STS_VALID;
> -
> -	if (priv->int_mask & TPM_INTF_DATA_AVAIL_INT)
> -		sts_mask |= TPM_STS_DATA_AVAIL;
> -
> -	if (priv->int_mask & TPM_INTF_CMD_READY_INT)
> -		sts_mask |= TPM_STS_COMMAND_READY;
> -
> -	sts_mask &= mask;
> +	sts_mask = tpm_tis_filter_sts_mask(priv->int_mask, sts_mask);
>  
>  	stop = jiffies + timeout;
>  	/* process status changes with irq support */
> -- 
> 2.25.1
> 

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko
