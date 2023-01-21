Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D53806761EA
	for <lists+linux-integrity@lfdr.de>; Sat, 21 Jan 2023 01:11:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229464AbjAUAL4 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 20 Jan 2023 19:11:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjAUALz (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 20 Jan 2023 19:11:55 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43CDC36474;
        Fri, 20 Jan 2023 16:11:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CB3E4B82AA3;
        Sat, 21 Jan 2023 00:11:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31158C433D2;
        Sat, 21 Jan 2023 00:11:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674259910;
        bh=oeflYO/FzcUbxQAMi5p6VjdDtqp1ZHCffKVR3C/+CsM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KSIHNrbB81dhd/QyS09hPzaXJNd6RUJySA8IPAGruXNud6RiPlY0WDf3opptfQ9kb
         Yio7Hlp1yKwAzqF+7B3LGP86aRZMbK7pCJNKuDWIRR5WrUNgDWN5FX9q74q+endjCV
         du4nVsgE8svwAtsHOohlRTz4AkGtMRLNDlJ4n+SnQCz1MJLqxmClTNGXHqprLF8w6Y
         FENOZCWDOum+3nE7ApXzbPe/DqP5IucfAKX5PMTkG8u62VHB7PJVCsv+4KPXTBoREN
         b1/acXff5y1fIaI73k26xEPGn3/K0nlJauAipeiC78ucwpQPq5d1U/d6B4YpjVjjd1
         hg4DOCB87gnUw==
Date:   Sat, 21 Jan 2023 00:11:48 +0000
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Eddie James <eajames@linux.ibm.com>
Cc:     linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        jgg@ziepe.ca, peterhuewe@gmx.de
Subject: Re: [PATCH v2 1/2] tpm: Use managed allocation for bios event log
Message-ID: <Y8stxF+2XfSFN9wt@kernel.org>
References: <20230113161017.1079299-1-eajames@linux.ibm.com>
 <20230113161017.1079299-2-eajames@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230113161017.1079299-2-eajames@linux.ibm.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, Jan 13, 2023 at 10:10:16AM -0600, Eddie James wrote:
> Since the bios event log is freed in the device release function,
> let devres handle the deallocation. This will allow other memory
> allocation/mapping functions to be used for the bios event log.
> 
> Signed-off-by: Eddie James <eajames@linux.ibm.com>
> ---
>  drivers/char/tpm/eventlog/acpi.c |  5 +++--
>  drivers/char/tpm/eventlog/efi.c  | 13 +++++++------
>  drivers/char/tpm/eventlog/of.c   |  3 ++-
>  drivers/char/tpm/tpm-chip.c      |  1 -
>  4 files changed, 12 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/char/tpm/eventlog/acpi.c b/drivers/char/tpm/eventlog/acpi.c
> index 0913d3eb8d51..40360e599bc3 100644
> --- a/drivers/char/tpm/eventlog/acpi.c
> +++ b/drivers/char/tpm/eventlog/acpi.c
> @@ -14,6 +14,7 @@
>   * Access to the event log extended by the TCG BIOS of PC platform
>   */
>  
> +#include <linux/device.h>
>  #include <linux/seq_file.h>
>  #include <linux/fs.h>
>  #include <linux/security.h>
> @@ -135,7 +136,7 @@ int tpm_read_log_acpi(struct tpm_chip *chip)
>  	}
>  
>  	/* malloc EventLog space */
> -	log->bios_event_log = kmalloc(len, GFP_KERNEL);
> +	log->bios_event_log = devm_kmalloc(&chip->dev, len, GFP_KERNEL);
>  	if (!log->bios_event_log)
>  		return -ENOMEM;
>  
> @@ -160,7 +161,7 @@ int tpm_read_log_acpi(struct tpm_chip *chip)
>  	return format;
>  
>  err:
> -	kfree(log->bios_event_log);
> +	devm_kfree(&chip->dev, log->bios_event_log);

I wonder do we want to do devm_kfree's at all as the memory is freed during
detach, i.e. taken care by devres.

>  	log->bios_event_log = NULL;
>  	return ret;
>  }
> diff --git a/drivers/char/tpm/eventlog/efi.c b/drivers/char/tpm/eventlog/efi.c
> index e6cb9d525e30..4e9d7c2bf32e 100644
> --- a/drivers/char/tpm/eventlog/efi.c
> +++ b/drivers/char/tpm/eventlog/efi.c
> @@ -6,6 +6,7 @@
>   *      Thiebaud Weksteen <tweek@google.com>
>   */
>  
> +#include <linux/device.h>
>  #include <linux/efi.h>
>  #include <linux/tpm_eventlog.h>
>  
> @@ -55,7 +56,7 @@ int tpm_read_log_efi(struct tpm_chip *chip)
>  	}
>  
>  	/* malloc EventLog space */
> -	log->bios_event_log = kmemdup(log_tbl->log, log_size, GFP_KERNEL);
> +	log->bios_event_log = devm_kmemdup(&chip->dev, log_tbl->log, log_size, GFP_KERNEL);
>  	if (!log->bios_event_log) {
>  		ret = -ENOMEM;
>  		goto out;
> @@ -76,7 +77,7 @@ int tpm_read_log_efi(struct tpm_chip *chip)
>  			     MEMREMAP_WB);
>  	if (!final_tbl) {
>  		pr_err("Could not map UEFI TPM final log\n");
> -		kfree(log->bios_event_log);
> +		devm_kfree(&chip->dev, log->bios_event_log);
>  		ret = -ENOMEM;
>  		goto out;
>  	}
> @@ -91,11 +92,11 @@ int tpm_read_log_efi(struct tpm_chip *chip)
>  	 * Allocate memory for the 'combined log' where we will append the
>  	 * 'final events log' to.
>  	 */
> -	tmp = krealloc(log->bios_event_log,
> -		       log_size + final_events_log_size,
> -		       GFP_KERNEL);
> +	tmp = devm_krealloc(&chip->dev, log->bios_event_log,
> +			    log_size + final_events_log_size,
> +			    GFP_KERNEL);
>  	if (!tmp) {
> -		kfree(log->bios_event_log);
> +		devm_kfree(&chip->dev, log->bios_event_log);
>  		ret = -ENOMEM;
>  		goto out;
>  	}
> diff --git a/drivers/char/tpm/eventlog/of.c b/drivers/char/tpm/eventlog/of.c
> index a9ce66d09a75..741ab2204b11 100644
> --- a/drivers/char/tpm/eventlog/of.c
> +++ b/drivers/char/tpm/eventlog/of.c
> @@ -10,6 +10,7 @@
>   * Read the event log created by the firmware on PPC64
>   */
>  
> +#include <linux/device.h>
>  #include <linux/slab.h>
>  #include <linux/of.h>
>  #include <linux/tpm_eventlog.h>
> @@ -65,7 +66,7 @@ int tpm_read_log_of(struct tpm_chip *chip)
>  		return -EIO;
>  	}
>  
> -	log->bios_event_log = kmemdup(__va(base), size, GFP_KERNEL);
> +	log->bios_event_log = devm_kmemdup(&chip->dev, __va(base), size, GFP_KERNEL);
>  	if (!log->bios_event_log)
>  		return -ENOMEM;
>  
> diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
> index 741d8f3e8fb3..b99f55f2d4fd 100644
> --- a/drivers/char/tpm/tpm-chip.c
> +++ b/drivers/char/tpm/tpm-chip.c
> @@ -267,7 +267,6 @@ static void tpm_dev_release(struct device *dev)
>  	idr_remove(&dev_nums_idr, chip->dev_num);
>  	mutex_unlock(&idr_lock);
>  
> -	kfree(chip->log.bios_event_log);
>  	kfree(chip->work_space.context_buf);
>  	kfree(chip->work_space.session_buf);
>  	kfree(chip->allocated_banks);
> -- 
> 2.31.1
> 

BR, Jarkko
