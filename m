Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CECA962AFB0
	for <lists+linux-integrity@lfdr.de>; Wed, 16 Nov 2022 00:52:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbiKOXwn (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 15 Nov 2022 18:52:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbiKOXwl (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 15 Nov 2022 18:52:41 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A8DFD2E9
        for <linux-integrity@vger.kernel.org>; Tue, 15 Nov 2022 15:52:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 15F1E61383
        for <linux-integrity@vger.kernel.org>; Tue, 15 Nov 2022 23:52:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22167C433C1;
        Tue, 15 Nov 2022 23:52:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668556359;
        bh=Z8oAqSPw3Y6LYw/8EU5Fby3CisQjgbbW8xIV7plr5YI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=N9RqWqIycd6+1J/iIROaXKjGZW6kWpx4NjWr8/U17rPmNrPWFlKBWC2OEKqF5xs28
         VGWSoNi52iFt355OBw9ikumo+xFG5QhSguXw+nwNImB82ocVEIsKQcdxIdCH9nTlPI
         35tsC71kU7b62CLKi3ZQovqBwJ1X1Vp0Tw91qmLLBq7gY8rE3EWW5XNSEe/n+2yOfL
         QJPrScYvG17icdKAiXE90J/eycZitD+bUR7JuNc2LnHhHd51fte7gqpo2vQslWiU6t
         gORaNsraLKRsIzRlQyxfA7JNTpT08Ywk6g+MhhW+JQJE8xhqBYMA3frJSEvgHOpu1B
         wfJxERN0/WOlA==
Date:   Wed, 16 Nov 2022 01:52:36 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Hanjun Guo <guohanjun@huawei.com>
Cc:     linux-integrity@vger.kernel.org, Peter Huewe <peterhuewe@gmx.de>
Subject: Re: [PATCH 3/3] tpm: tpm_tis: Add the missed acpi_put_table() to fix
 memory leak
Message-ID: <Y3QmRNk6rPuoWQjA@kernel.org>
References: <1667966622-19711-1-git-send-email-guohanjun@huawei.com>
 <1667966622-19711-4-git-send-email-guohanjun@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1667966622-19711-4-git-send-email-guohanjun@huawei.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Nov 09, 2022 at 12:03:42PM +0800, Hanjun Guo wrote:
> In check_acpi_tpm2(), we get the TPM2 table just to make
> sure the table is there, not used after the init, so the
> acpi_put_table() should be added to release the ACPI memory.
> 
> Fixes: 4cb586a188d4 ("tpm_tis: Consolidate the platform and acpi probe flow")
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

Ditto.

BR, Jarkko
