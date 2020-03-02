Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A079A17594D
	for <lists+linux-integrity@lfdr.de>; Mon,  2 Mar 2020 12:15:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726831AbgCBLPT (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 2 Mar 2020 06:15:19 -0500
Received: from mga01.intel.com ([192.55.52.88]:43024 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725996AbgCBLPS (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 2 Mar 2020 06:15:18 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Mar 2020 03:15:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,506,1574150400"; 
   d="scan'208";a="412244791"
Received: from aorourk1-mobl.ger.corp.intel.com (HELO localhost) ([10.251.86.123])
  by orsmga005.jf.intel.com with ESMTP; 02 Mar 2020 03:15:15 -0800
Date:   Mon, 2 Mar 2020 13:15:14 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Stefan Berger <stefanb@linux.vnet.ibm.com>
Cc:     linux-integrity@vger.kernel.org, aik@ozlabs.ru,
        david@gibson.dropbear.id.au, linux-kernel@vger.kernel.org,
        nayna@linux.vnet.ibm.com, gcwilson@linux.ibm.com, jgg@ziepe.ca,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: Re: [PATCH v5 3/3] tpm: ibmvtpm: Add support for TPM 2
Message-ID: <20200302111514.GC3979@linux.intel.com>
References: <20200228030330.18081-1-stefanb@linux.vnet.ibm.com>
 <20200228030330.18081-4-stefanb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200228030330.18081-4-stefanb@linux.vnet.ibm.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Feb 27, 2020 at 10:03:30PM -0500, Stefan Berger wrote:
> From: Stefan Berger <stefanb@linux.ibm.com>
> 
> Support TPM 2 in the IBM vTPM driver. The hypervisor tells us what
> version of TPM is connected through the vio_device_id.

I'd prefer "TPM2" over "TPM 2".

> In case a TPM 2 is found, we set the TPM_CHIP_FLAG_TPM2 flag
> and get the command codes attributes table. The driver does
> not need the timeouts and durations, though.

A TPM2 what? TPM2 is not a thing.

> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> ---
>  drivers/char/tpm/tpm.h         | 1 +
>  drivers/char/tpm/tpm2-cmd.c    | 2 +-
>  drivers/char/tpm/tpm_ibmvtpm.c | 8 ++++++++
>  3 files changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
> index 5620747da0cf..ad55c9824338 100644
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
> index 13696deceae8..b6a0ee6bb03a 100644
> --- a/drivers/char/tpm/tpm2-cmd.c
> +++ b/drivers/char/tpm/tpm2-cmd.c
> @@ -613,7 +613,7 @@ ssize_t tpm2_get_pcr_allocation(struct tpm_chip *chip)
>  	return rc;
>  }
>  
> -static int tpm2_get_cc_attrs_tbl(struct tpm_chip *chip)
> +int tpm2_get_cc_attrs_tbl(struct tpm_chip *chip)
>  {
>  	struct tpm_buf buf;
>  	u32 nr_commands;
> diff --git a/drivers/char/tpm/tpm_ibmvtpm.c b/drivers/char/tpm/tpm_ibmvtpm.c
> index eee566eddb35..676a65148f82 100644
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

The code change looks fine.

/Jarkko
