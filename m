Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AF617184AC3
	for <lists+linux-integrity@lfdr.de>; Fri, 13 Mar 2020 16:30:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726637AbgCMPa2 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 13 Mar 2020 11:30:28 -0400
Received: from mga18.intel.com ([134.134.136.126]:19575 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726446AbgCMPa2 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 13 Mar 2020 11:30:28 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Mar 2020 08:30:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,549,1574150400"; 
   d="scan'208";a="278261968"
Received: from mlitka-mobl1.ger.corp.intel.com (HELO localhost) ([10.249.155.148])
  by fmsmga002.fm.intel.com with ESMTP; 13 Mar 2020 08:30:22 -0700
Date:   Fri, 13 Mar 2020 17:30:20 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Stefan Berger <stefanb@linux.vnet.ibm.com>
Cc:     linux-integrity@vger.kernel.org, aik@ozlabs.ru,
        david@gibson.dropbear.id.au, linux-kernel@vger.kernel.org,
        nayna@linux.vnet.ibm.com, gcwilson@linux.ibm.com, jgg@ziepe.ca,
        Stefan Berger <stefanb@linux.ibm.com>,
        Nayna Jain <nayna@linux.ibm.com>
Subject: Re: [PATCH v7 3/3] tpm: ibmvtpm: Add support for TPM2
Message-ID: <20200313153020.GD142269@linux.intel.com>
References: <20200312155332.671464-1-stefanb@linux.vnet.ibm.com>
 <20200312155332.671464-4-stefanb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200312155332.671464-4-stefanb@linux.vnet.ibm.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Mar 12, 2020 at 11:53:32AM -0400, Stefan Berger wrote:
> From: Stefan Berger <stefanb@linux.ibm.com>
> 
> Support TPM2 in the IBM vTPM driver. The hypervisor tells us what
> version of TPM is connected through the vio_device_id.
> 
> In case a TPM2 device is found, we set the TPM_CHIP_FLAG_TPM2 flag
> and get the command codes attributes table. The driver does
> not need the timeouts and durations, though.
> 
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> Acked-by: Nayna Jain <nayna@linux.ibm.com>
> Tested-by: Nayna Jain <nayna@linux.ibm.com>
> ---
>  drivers/char/tpm/tpm.h         | 1 +
>  drivers/char/tpm/tpm2-cmd.c    | 2 +-
>  drivers/char/tpm/tpm_ibmvtpm.c | 8 ++++++++
>  3 files changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
> index 2b2c225e1190..0fbcede241ea 100644
> --- a/drivers/char/tpm/tpm.h
> +++ b/drivers/char/tpm/tpm.h
> @@ -226,6 +226,7 @@ int tpm2_auto_startup(struct tpm_chip *chip);
>  void tpm2_shutdown(struct tpm_chip *chip, u16 shutdown_type);
>  unsigned long tpm2_calc_ordinal_duration(struct tpm_chip *chip, u32 ordinal);
>  int tpm2_probe(struct tpm_chip *chip);
> +int tpm2_get_cc_attrs_tbl(struct tpm_chip *chip);
>  int tpm2_find_cc(struct tpm_chip *chip, u32 cc);
>  int tpm2_init_space(struct tpm_space *space);
>  void tpm2_del_space(struct tpm_chip *chip, struct tpm_space *space);
> diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
> index 760329598b99..76f67b155bd5 100644
> --- a/drivers/char/tpm/tpm2-cmd.c
> +++ b/drivers/char/tpm/tpm2-cmd.c
> @@ -615,7 +615,7 @@ ssize_t tpm2_get_pcr_allocation(struct tpm_chip *chip)
>  	return rc;
>  }
>  
> -static int tpm2_get_cc_attrs_tbl(struct tpm_chip *chip)
> +int tpm2_get_cc_attrs_tbl(struct tpm_chip *chip)
>  {
>  	struct tpm_buf buf;
>  	u32 nr_commands;
> diff --git a/drivers/char/tpm/tpm_ibmvtpm.c b/drivers/char/tpm/tpm_ibmvtpm.c
> index cfe40e7b1ba4..1a49db9e108e 100644
> --- a/drivers/char/tpm/tpm_ibmvtpm.c
> +++ b/drivers/char/tpm/tpm_ibmvtpm.c
> @@ -29,6 +29,7 @@ static const char tpm_ibmvtpm_driver_name[] = "tpm_ibmvtpm";
>  
>  static const struct vio_device_id tpm_ibmvtpm_device_table[] = {
>  	{ "IBM,vtpm", "IBM,vtpm"},
> +	{ "IBM,vtpm", "IBM,vtpm20"},
>  	{ "", "" }
>  };
>  MODULE_DEVICE_TABLE(vio, tpm_ibmvtpm_device_table);
> @@ -672,6 +673,13 @@ static int tpm_ibmvtpm_probe(struct vio_dev *vio_dev,
>  	if (rc)
>  		goto init_irq_cleanup;
>  
> +	if (!strcmp(id->compat, "IBM,vtpm20")) {
> +		chip->flags |= TPM_CHIP_FLAG_TPM2;
> +		rc = tpm2_get_cc_attrs_tbl(chip);
> +		if (rc)
> +			goto init_irq_cleanup;
> +	}
> +
>  	if (!wait_event_timeout(ibmvtpm->crq_queue.wq,
>  				ibmvtpm->rtce_buf != NULL,
>  				HZ)) {
> -- 
> 2.23.0
> 

Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

/Jarkko
