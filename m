Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2CEA91984F5
	for <lists+linux-integrity@lfdr.de>; Mon, 30 Mar 2020 21:54:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727745AbgC3TyU (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 30 Mar 2020 15:54:20 -0400
Received: from mga17.intel.com ([192.55.52.151]:49932 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727255AbgC3TyU (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 30 Mar 2020 15:54:20 -0400
IronPort-SDR: 6S1t14dixeNBUmwjxQOQ9pl/LINK/gWp84pKsTWuFP4IdzjpCbmI7C9c5up/fPpbTYt0foIi+X
 QzXbIQzUhUOA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2020 12:54:20 -0700
IronPort-SDR: mRB9tzHdIXCtzQHvqCcpOK2Y6qUuoCpdeKJQ6yI1MxaEm2qCX7qMHfqMQ2W3PdeCWQOFcCX380
 l04PXmiAIvgg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,325,1580803200"; 
   d="scan'208";a="359275521"
Received: from plachner-mobl.ger.corp.intel.com (HELO localhost) ([10.252.35.129])
  by fmsmga001.fm.intel.com with ESMTP; 30 Mar 2020 12:54:17 -0700
Date:   Mon, 30 Mar 2020 22:54:16 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Stefan Berger <stefanb@linux.vnet.ibm.com>
Cc:     linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-security-module@vger.kernel.org,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: Re: [PATCH v2 3/3] tpm: Add support for ACPI logs from TPM2 ACPI
 table
Message-ID: <20200330195416.GE1384380@linux.intel.com>
References: <20200330151536.871700-1-stefanb@linux.vnet.ibm.com>
 <20200330151536.871700-4-stefanb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200330151536.871700-4-stefanb@linux.vnet.ibm.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Mar 30, 2020 at 11:15:36AM -0400, Stefan Berger wrote:
> From: Stefan Berger <stefanb@linux.ibm.com>
> 
> In case of a TPM2 search for a TPM2 ACPI table and if found use it to
> find start and length of the log area.
> 
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>

Please use "tpm/eventlog".

There's a typo in the short summary: I guess you meant event log when
you speak of "ACPI log".

Also, I'm not getting the long description e.g. "TPM2 search" is an
alien term.

> ---
>  drivers/char/tpm/eventlog/acpi.c | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/char/tpm/eventlog/acpi.c b/drivers/char/tpm/eventlog/acpi.c
> index 1ef2267c9378..2447f21e4a23 100644
> --- a/drivers/char/tpm/eventlog/acpi.c
> +++ b/drivers/char/tpm/eventlog/acpi.c
> @@ -49,6 +49,8 @@ int tpm_read_log_acpi(struct tpm_chip *chip)
>  	void __iomem *virt;
>  	u64 len, start;
>  	struct tpm_bios_log *log;
> +	struct acpi_table_tpm2 *tbl;
> +	int format;
>  
>  	log = &chip->log;
>  
> @@ -59,7 +61,15 @@ int tpm_read_log_acpi(struct tpm_chip *chip)
>  		return -ENODEV;
>  
>  	if (chip->flags & TPM_CHIP_FLAG_TPM2) {
> -		return -ENODEV;
> +		status = acpi_get_table("TPM2", 1,
> +					(struct acpi_table_header **)&tbl);
> +		if (ACPI_FAILURE(status))
> +			return -ENODEV;
> +		if (tbl->header.length < sizeof(*tbl))
> +			return -ENODEV;
> +		len = tbl->log_area_minimum_length;
> +		start = tbl->log_area_start_address;
> +		format = EFI_TCG2_EVENT_LOG_FORMAT_TCG_2;
>  	} else {
>  		/* Find TCPA entry in RSDT (ACPI_LOGICAL_ADDRESSING) */
>  		status = acpi_get_table(ACPI_SIG_TCPA, 1,
> @@ -79,6 +89,7 @@ int tpm_read_log_acpi(struct tpm_chip *chip)
>  			start = buff->client.log_start_addr;
>  			break;
>  		}
> +		format = EFI_TCG2_EVENT_LOG_FORMAT_TCG_1_2;
>  	}
>  	if (!len) {
>  		dev_warn(&chip->dev, "%s: TCPA log area empty\n", __func__);
> @@ -99,7 +110,7 @@ int tpm_read_log_acpi(struct tpm_chip *chip)
>  	memcpy_fromio(log->bios_event_log, virt, len);
>  
>  	acpi_os_unmap_iomem(virt, len);
> -	return EFI_TCG2_EVENT_LOG_FORMAT_TCG_1_2;
> +	return format;
>  
>  err:
>  	kfree(log->bios_event_log);
> -- 
> 2.14.5
> 

The code change looks fine but need a review after squashed with 2/3.

/Jarkko
