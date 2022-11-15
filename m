Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D6D362AFAE
	for <lists+linux-integrity@lfdr.de>; Wed, 16 Nov 2022 00:51:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229923AbiKOXvp (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 15 Nov 2022 18:51:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbiKOXvo (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 15 Nov 2022 18:51:44 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A65E2FC24
        for <linux-integrity@vger.kernel.org>; Tue, 15 Nov 2022 15:51:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D1294B81B58
        for <linux-integrity@vger.kernel.org>; Tue, 15 Nov 2022 23:51:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F7D4C433D6;
        Tue, 15 Nov 2022 23:51:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668556300;
        bh=MEQ5kON3sTP/2R/qxhY3ycCLBiPp9AUSlyKkHUXy4uU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bq19RaPLX/S6y0ZNfiaMDK5dw9NhsCbti8h9dfrEsdgnd/TB6sVTY+jUlhZYdCynL
         +jBgppRiR1GMj7HNC8uXEoUgvLwadt1sH/hSrTRfS2hcS+G2LegWmWjb/cemb31z6G
         SYQLqD3kpYPKX94HYJ0tm0V/T7yJvMe18faGNv+xyMS4sgMLJQHdNmJEA4fW/VAHpA
         WQ3/0YxGbARkLJAp/Vyc9TpM6LwPkUbtSXTLCYFWpiTqORej63hcUrFgiMGV8iIw2s
         vldeK8CIrYUlC7FibpNDnU2usiJPlJZObxoQLgwLpTgE9M/V2bD72N/IlOCituMONY
         Gq3Ylsstr99fg==
Date:   Wed, 16 Nov 2022 01:51:37 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Hanjun Guo <guohanjun@huawei.com>
Cc:     linux-integrity@vger.kernel.org, Peter Huewe <peterhuewe@gmx.de>
Subject: Re: [PATCH 1/3] tpm: acpi: Call acpi_put_table() to fix memory leak
Message-ID: <Y3QmCUux2D+9ebmp@kernel.org>
References: <1667966622-19711-1-git-send-email-guohanjun@huawei.com>
 <1667966622-19711-2-git-send-email-guohanjun@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1667966622-19711-2-git-send-email-guohanjun@huawei.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Nov 09, 2022 at 12:03:40PM +0800, Hanjun Guo wrote:
> The start and length of the event log area are obtained from
> TPM2 or TCPA table, so we call acpi_get_table() to get the
> ACPI information, but the acpi_get_table() should be coupled with
> acpi_put_table() to release the ACPI memory, add the acpi_put_table()
> properly to fix the memory leak.
> 
> While we are at it, remove the redundant empty line at the
> end of the tpm_read_log_acpi().
> 

Please add to the commit message:

Cc: stable@vger.kernel.org

And cc this patch also to linux-kernel@vger.kernel.org.

> Fixes: 0bfb23746052 ("tpm: Move eventlog files to a subdirectory")
> Fixes: 85467f63a05c ("tpm: Add support for event log pointer found in TPM2 ACPI table")
> Signed-off-by: Hanjun Guo <guohanjun@huawei.com>
> ---
>  drivers/char/tpm/eventlog/acpi.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/char/tpm/eventlog/acpi.c b/drivers/char/tpm/eventlog/acpi.c
> index 1b18ce5..0913d3eb 100644
> --- a/drivers/char/tpm/eventlog/acpi.c
> +++ b/drivers/char/tpm/eventlog/acpi.c
> @@ -90,16 +90,21 @@ int tpm_read_log_acpi(struct tpm_chip *chip)
>  			return -ENODEV;
>  
>  		if (tbl->header.length <
> -				sizeof(*tbl) + sizeof(struct acpi_tpm2_phy))
> +				sizeof(*tbl) + sizeof(struct acpi_tpm2_phy)) {
> +			acpi_put_table((struct acpi_table_header *)tbl);
>  			return -ENODEV;
> +		}
>  
>  		tpm2_phy = (void *)tbl + sizeof(*tbl);
>  		len = tpm2_phy->log_area_minimum_length;
>  
>  		start = tpm2_phy->log_area_start_address;
> -		if (!start || !len)
> +		if (!start || !len) {
> +			acpi_put_table((struct acpi_table_header *)tbl);
>  			return -ENODEV;
> +		}
>  
> +		acpi_put_table((struct acpi_table_header *)tbl);
>  		format = EFI_TCG2_EVENT_LOG_FORMAT_TCG_2;
>  	} else {
>  		/* Find TCPA entry in RSDT (ACPI_LOGICAL_ADDRESSING) */
> @@ -120,8 +125,10 @@ int tpm_read_log_acpi(struct tpm_chip *chip)
>  			break;
>  		}
>  
> +		acpi_put_table((struct acpi_table_header *)buff);
>  		format = EFI_TCG2_EVENT_LOG_FORMAT_TCG_1_2;
>  	}
> +
>  	if (!len) {
>  		dev_warn(&chip->dev, "%s: TCPA log area empty\n", __func__);
>  		return -EIO;
> @@ -156,5 +163,4 @@ int tpm_read_log_acpi(struct tpm_chip *chip)
>  	kfree(log->bios_event_log);
>  	log->bios_event_log = NULL;
>  	return ret;
> -
>  }
> -- 
> 1.7.12.4
> 

Thank you for fixing this.

BR, Jarkko
