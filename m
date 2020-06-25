Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7B18209751
	for <lists+linux-integrity@lfdr.de>; Thu, 25 Jun 2020 02:00:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387828AbgFYAA2 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 24 Jun 2020 20:00:28 -0400
Received: from mga09.intel.com ([134.134.136.24]:6763 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387823AbgFYAA1 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 24 Jun 2020 20:00:27 -0400
IronPort-SDR: FxSabzpGPEY9+GE9Tinq0VaX6p9OZPJcp+g/82LnhL3wwRPIqFqINq+P4qqONmzzCWetkMDnsB
 XMnBMIY9sXXA==
X-IronPort-AV: E=McAfee;i="6000,8403,9662"; a="146179287"
X-IronPort-AV: E=Sophos;i="5.75,277,1589266800"; 
   d="scan'208";a="146179287"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2020 17:00:27 -0700
IronPort-SDR: pjG5eaLCFNWTd03vuiWSsY/pk4STlnXy2S0/Q2aCFJxPu7F+avONDD3C/RVlvyntbe44QmOLni
 6/ocnzeLccMQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,277,1589266800"; 
   d="scan'208";a="385319591"
Received: from hluxenbu-mobl.ger.corp.intel.com (HELO localhost) ([10.252.36.218])
  by fmsmga001.fm.intel.com with ESMTP; 24 Jun 2020 17:00:22 -0700
Date:   Thu, 25 Jun 2020 03:00:21 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Stefan Berger <stefanb@linux.vnet.ibm.com>,
        Jiandi An <anjiandi@codeaurora.org>
Cc:     linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-security-module@vger.kernel.org,
        Stefan Berger <stefanb@linux.ibm.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH v5 1/2] acpi: Extend TPM2 ACPI table with missing log
 fields
Message-ID: <20200625000021.GC21758@linux.intel.com>
References: <20200623120636.1453470-1-stefanb@linux.vnet.ibm.com>
 <20200623120636.1453470-2-stefanb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200623120636.1453470-2-stefanb@linux.vnet.ibm.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Jun 23, 2020 at 08:06:35AM -0400, Stefan Berger wrote:
> From: Stefan Berger <stefanb@linux.ibm.com>
> 
> Recent extensions of the TPM2 ACPI table added 3 more fields
> including 12 bytes of start method specific parameters and Log Area
> Minimum Length (u32) and Log Area Start Address (u64). So, we extend
> the existing structure with these fields to allow non-UEFI systems
> to access the TPM2's log.
> 
> The specification that has the new fields is the following:
>   TCG ACPI Specification
>   Family "1.2" and "2.0"
>   Version 1.2, Revision 8
> 
> Adapt all existing table size calculations to use
> offsetof(struct acpi_table_tpm2, start_method_specific)
> [where start_method_specific is a newly added field]
> rather than sizeof(struct acpi_table_tpm2) so that the addition
> of the new fields does not affect current systems that may not
> have them.
> 

I found at least one regression from this patch. Please remove my
reviewed-by comment form the next version.

Should have:

  Link: https://trustedcomputinggroup.org/wp-content/uploads/TCG_ACPIGeneralSpecification_v1.20_r8.pdf

Please, add this.

> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> Cc: linux-acpi@vger.kernel.org
> Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> ---
>  drivers/char/tpm/tpm_crb.c | 13 ++++++++++---
>  drivers/char/tpm/tpm_tis.c |  4 +++-
>  include/acpi/actbl3.h      |  5 +++--
>  3 files changed, 16 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm_crb.c b/drivers/char/tpm/tpm_crb.c
> index a9dcf31eadd2..0565aa5482f9 100644
> --- a/drivers/char/tpm/tpm_crb.c
> +++ b/drivers/char/tpm/tpm_crb.c
> @@ -669,7 +669,9 @@ static int crb_acpi_add(struct acpi_device *device)
>  
>  	status = acpi_get_table(ACPI_SIG_TPM2, 1,
>  				(struct acpi_table_header **) &buf);
> -	if (ACPI_FAILURE(status) || buf->header.length < sizeof(*buf)) {
> +	if (ACPI_FAILURE(status) || buf->header.length <
> +			offsetof(struct acpi_table_tpm2,
> +				 start_method_specific)) {
>  		dev_err(dev, FW_BUG "failed to get TPM2 ACPI table\n");
>  		return -EINVAL;
>  	}
> @@ -684,14 +686,19 @@ static int crb_acpi_add(struct acpi_device *device)
>  		return -ENOMEM;
>  
>  	if (sm == ACPI_TPM2_COMMAND_BUFFER_WITH_ARM_SMC) {
> -		if (buf->header.length < (sizeof(*buf) + sizeof(*crb_smc))) {
> +		if (buf->header.length <
> +			(offsetof(struct acpi_table_tpm2,
> +				  start_method_specific) +

Should be

  offsetof(struct acpti_table_tpm2, log_area_minimum_length)

> +			 sizeof(*crb_smc))) {
>  			dev_err(dev,
>  				FW_BUG "TPM2 ACPI table has wrong size %u for start method type %d\n",
>  				buf->header.length,
>  				ACPI_TPM2_COMMAND_BUFFER_WITH_ARM_SMC);
>  			return -EINVAL;
>  		}
> -		crb_smc = ACPI_ADD_PTR(struct tpm2_crb_smc, buf, sizeof(*buf));
> +		crb_smc = ACPI_ADD_PTR(struct tpm2_crb_smc, buf,
> +			   offsetof(struct acpi_table_tpm2,
> +				    start_method_specific));
>  		priv->smc_func_id = crb_smc->smc_func_id;
>  	}
>  
> diff --git a/drivers/char/tpm/tpm_tis.c b/drivers/char/tpm/tpm_tis.c
> index e7df342a317d..a80f36860bac 100644
> --- a/drivers/char/tpm/tpm_tis.c
> +++ b/drivers/char/tpm/tpm_tis.c
> @@ -111,7 +111,9 @@ static int check_acpi_tpm2(struct device *dev)
>  	 */
>  	st =
>  	    acpi_get_table(ACPI_SIG_TPM2, 1, (struct acpi_table_header **)&tbl);
> -	if (ACPI_FAILURE(st) || tbl->header.length < sizeof(*tbl)) {
> +	if (ACPI_FAILURE(st) || tbl->header.length <
> +			offsetof(struct acpi_table_tpm2,
> +				 start_method_specific)) {
>  		dev_err(dev, FW_BUG "failed to get TPM2 ACPI table\n");
>  		return -EINVAL;
>  	}
> diff --git a/include/acpi/actbl3.h b/include/acpi/actbl3.h
> index b0b163b9efc6..8b55426bbcf6 100644
> --- a/include/acpi/actbl3.h
> +++ b/include/acpi/actbl3.h
> @@ -411,8 +411,9 @@ struct acpi_table_tpm2 {
>  	u16 reserved;
>  	u64 control_address;
>  	u32 start_method;
> -
> -	/* Platform-specific data follows */
> +	u8  start_method_specific[12];
> +	u32 log_area_minimum_length;		/* optional */
> +	u64 log_area_start_address;		/* optional */

'start_method_specific' is also optional. Please remove the optional
comments altogether as platform-specific data is by definition optional.

>  };
>  
>  /* Values for start_method above */
> -- 
> 2.26.2
> 

Please add this to the next version since we do not want to break ARM
side:

  Cc: Jiandi An <anjiandi@codeaurora.org>

/Jarkko
