Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAC6320B279
	for <lists+linux-integrity@lfdr.de>; Fri, 26 Jun 2020 15:27:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727898AbgFZN1M (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 26 Jun 2020 09:27:12 -0400
Received: from mga07.intel.com ([134.134.136.100]:34481 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725925AbgFZN1M (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 26 Jun 2020 09:27:12 -0400
IronPort-SDR: muOj99OIv3E1iveTOt1FOb+gzvkPwVoJVa+E2U7WqPXlMtXe46Ki0CqItzdkJwQM3ROSqPYQJi
 rJ9L9Cypbk7w==
X-IronPort-AV: E=McAfee;i="6000,8403,9663"; a="210398005"
X-IronPort-AV: E=Sophos;i="5.75,283,1589266800"; 
   d="scan'208";a="210398005"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2020 06:27:11 -0700
IronPort-SDR: +bWsPzrFUhxPzvJ8c//x2qMDHqJqSWA1Z+mVXfaepwU60kPECytauFEsnT5qyQrYzUnd5yydjz
 tAFQcrkdUM9w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,283,1589266800"; 
   d="scan'208";a="480003202"
Received: from cgheban-mobl.ger.corp.intel.com (HELO localhost) ([10.249.40.199])
  by fmsmga005.fm.intel.com with ESMTP; 26 Jun 2020 06:27:08 -0700
Date:   Fri, 26 Jun 2020 16:27:06 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Stefan Berger <stefanb@linux.vnet.ibm.com>
Cc:     linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-security-module@vger.kernel.org,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: Re: [PATCH v7 2/2] tpm: Add support for event log pointer found in
 TPM2 ACPI table
Message-ID: <20200626132706.GC7853@linux.intel.com>
References: <20200625215000.2052086-1-stefanb@linux.vnet.ibm.com>
 <20200625215000.2052086-3-stefanb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200625215000.2052086-3-stefanb@linux.vnet.ibm.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Jun 25, 2020 at 05:50:00PM -0400, Stefan Berger wrote:
> From: Stefan Berger <stefanb@linux.ibm.com>
> 
> In case a TPM2 is attached, search for a TPM2 ACPI table when trying
> to get the event log from ACPI. If one is found, use it to get the
> start and length of the log area. This allows non-UEFI systems, such
> as SeaBIOS, to pass an event log when using a TPM2.
> 
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> ---
>  drivers/char/tpm/eventlog/acpi.c | 62 +++++++++++++++++++++-----------
>  1 file changed, 41 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/char/tpm/eventlog/acpi.c b/drivers/char/tpm/eventlog/acpi.c
> index 63ada5e53f13..e2258cfa6cb1 100644
> --- a/drivers/char/tpm/eventlog/acpi.c
> +++ b/drivers/char/tpm/eventlog/acpi.c
> @@ -49,9 +49,9 @@ int tpm_read_log_acpi(struct tpm_chip *chip)
>  	void __iomem *virt;
>  	u64 len, start;
>  	struct tpm_bios_log *log;
> -
> -	if (chip->flags & TPM_CHIP_FLAG_TPM2)
> -		return -ENODEV;
> +	struct acpi_table_tpm2 *tbl;
> +	struct acpi_tpm2_phy *t2phy;
> +	int format;
>  
>  	log = &chip->log;
>  
> @@ -61,23 +61,43 @@ int tpm_read_log_acpi(struct tpm_chip *chip)
>  	if (!chip->acpi_dev_handle)
>  		return -ENODEV;
>  
> -	/* Find TCPA entry in RSDT (ACPI_LOGICAL_ADDRESSING) */
> -	status = acpi_get_table(ACPI_SIG_TCPA, 1,
> -				(struct acpi_table_header **)&buff);
> -
> -	if (ACPI_FAILURE(status))
> -		return -ENODEV;
> -
> -	switch(buff->platform_class) {
> -	case BIOS_SERVER:
> -		len = buff->server.log_max_len;
> -		start = buff->server.log_start_addr;
> -		break;
> -	case BIOS_CLIENT:
> -	default:
> -		len = buff->client.log_max_len;
> -		start = buff->client.log_start_addr;
> -		break;
> +	if (chip->flags & TPM_CHIP_FLAG_TPM2) {
> +		status = acpi_get_table("TPM2", 1,
> +					(struct acpi_table_header **)&tbl);
> +		if (ACPI_FAILURE(status))
> +			return -ENODEV;
> +
> +		if (tbl->header.length <
> +				sizeof(*tbl) + sizeof(struct acpi_tpm2_phy))
> +			return -ENODEV;
> +
> +		t2phy = (void *)tbl + sizeof(*tbl);
> +		len = t2phy->log_area_minimum_length;
> +
> +		start = t2phy->log_area_start_address;
> +		if (!start || !len)
> +			return -ENODEV;
> +
> +		format = EFI_TCG2_EVENT_LOG_FORMAT_TCG_2;
> +	} else {
> +		/* Find TCPA entry in RSDT (ACPI_LOGICAL_ADDRESSING) */
> +		status = acpi_get_table(ACPI_SIG_TCPA, 1,
> +					(struct acpi_table_header **)&buff);
> +		if (ACPI_FAILURE(status))
> +			return -ENODEV;
> +
> +		switch (buff->platform_class) {
> +		case BIOS_SERVER:
> +			len = buff->server.log_max_len;
> +			start = buff->server.log_start_addr;
> +			break;
> +		case BIOS_CLIENT:
> +		default:
> +			len = buff->client.log_max_len;
> +			start = buff->client.log_start_addr;
> +			break;
> +		}

Empty line as in the first branch after the conditional statement.

> +		format = EFI_TCG2_EVENT_LOG_FORMAT_TCG_1_2;
>  	}
>  	if (!len) {
>  		dev_warn(&chip->dev, "%s: TCPA log area empty\n", __func__);
> @@ -98,7 +118,7 @@ int tpm_read_log_acpi(struct tpm_chip *chip)
>  	memcpy_fromio(log->bios_event_log, virt, len);
>  
>  	acpi_os_unmap_iomem(virt, len);
> -	return EFI_TCG2_EVENT_LOG_FORMAT_TCG_1_2;
> +	return format;
>  
>  err:
>  	kfree(log->bios_event_log);
> -- 
> 2.26.2
> 

/Jarkko
