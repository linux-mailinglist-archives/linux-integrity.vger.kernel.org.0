Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37752639BF6
	for <lists+linux-integrity@lfdr.de>; Sun, 27 Nov 2022 18:21:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229563AbiK0RVt (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 27 Nov 2022 12:21:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbiK0RVs (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 27 Nov 2022 12:21:48 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C7D4E0C6;
        Sun, 27 Nov 2022 09:21:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 10736B80B28;
        Sun, 27 Nov 2022 17:21:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75584C433C1;
        Sun, 27 Nov 2022 17:21:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669569703;
        bh=yyGZAKSi7dlG99PxQGUXdvxP+H5Bjf8b1R4WTI/6NOs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tEepddheUjXivjZNeWJHRb7ZU63FD0Sdt9N7X3LCVG4dCOaqe4adAyfLoBfOCELR1
         uDvRdMXUkWdvRBA57oremvR15fQ4LrPOVFgcD8PKq2fuxWqplR0+/4UftgNlFxfsFB
         5apnLltHV3MRSLXrvKTSjG6J/byjbp/kJEc6yIFmPGMJBDfQPgm2j2QgAjmUTx6cMw
         awsGnWtSjDsq5tnCr71bE6dS3nG9BNmz/JVjIdC5L6jkzEcgeFZVn1ctcwkJhRBHnr
         d/D5h3vxLfaSytz17ds+ifWxZbJQ+eLG85nUE7bd6emRU5T05yPzDwaMDtNeqI5Ke1
         9emmdURTqI9og==
Date:   Sun, 27 Nov 2022 19:21:39 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Hanjun Guo <guohanjun@huawei.com>
Cc:     Peter Huewe <peterhuewe@gmx.de>, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] tpm: tpm_tis: Add the missed acpi_put_table() to
 fix memory leak
Message-ID: <Y4Oco99TYl6CN8Yk@kernel.org>
References: <1668684222-38457-1-git-send-email-guohanjun@huawei.com>
 <1668684222-38457-4-git-send-email-guohanjun@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1668684222-38457-4-git-send-email-guohanjun@huawei.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Nov 17, 2022 at 07:23:42PM +0800, Hanjun Guo wrote:
> In check_acpi_tpm2(), we get the TPM2 table just to make
> sure the table is there, not used after the init, so the
> acpi_put_table() should be added to release the ACPI memory.
> 
> Fixes: 4cb586a188d4 ("tpm_tis: Consolidate the platform and acpi probe flow")
> Cc: stable@vger.kernel.org
> Signed-off-by: Hanjun Guo <guohanjun@huawei.com>
> ---
>  drivers/char/tpm/tpm_tis.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm_tis.c b/drivers/char/tpm/tpm_tis.c
> index bcff642..ed5dabd 100644
> --- a/drivers/char/tpm/tpm_tis.c
> +++ b/drivers/char/tpm/tpm_tis.c
> @@ -125,6 +125,7 @@ static int check_acpi_tpm2(struct device *dev)
>  	const struct acpi_device_id *aid = acpi_match_device(tpm_acpi_tbl, dev);
>  	struct acpi_table_tpm2 *tbl;
>  	acpi_status st;
> +	int ret = 0;
>  
>  	if (!aid || aid->driver_data != DEVICE_IS_TPM2)
>  		return 0;
> @@ -132,8 +133,7 @@ static int check_acpi_tpm2(struct device *dev)
>  	/* If the ACPI TPM2 signature is matched then a global ACPI_SIG_TPM2
>  	 * table is mandatory
>  	 */
> -	st =
> -	    acpi_get_table(ACPI_SIG_TPM2, 1, (struct acpi_table_header **)&tbl);
> +	st = acpi_get_table(ACPI_SIG_TPM2, 1, (struct acpi_table_header **)&tbl);
>  	if (ACPI_FAILURE(st) || tbl->header.length < sizeof(*tbl)) {
>  		dev_err(dev, FW_BUG "failed to get TPM2 ACPI table\n");
>  		return -EINVAL;
> @@ -141,9 +141,10 @@ static int check_acpi_tpm2(struct device *dev)
>  
>  	/* The tpm2_crb driver handles this device */
>  	if (tbl->start_method != ACPI_TPM2_MEMORY_MAPPED)
> -		return -ENODEV;
> +		ret = -ENODEV;
>  
> -	return 0;
> +	acpi_put_table((struct acpi_table_header *)tbl);
> +	return ret;
>  }
>  #else
>  static int check_acpi_tpm2(struct device *dev)
> -- 
> 1.7.12.4
> 

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko
