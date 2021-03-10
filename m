Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B205F334C45
	for <lists+linux-integrity@lfdr.de>; Thu, 11 Mar 2021 00:14:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233131AbhCJXOR (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 10 Mar 2021 18:14:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:36016 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232181AbhCJXNz (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 10 Mar 2021 18:13:55 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0222264FC1;
        Wed, 10 Mar 2021 23:13:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615418035;
        bh=9tF20wf+zLJcX7h7mHIULvFDAmy09SQE7kJ+VmzQ9kE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=G2bcNmRwZmhiPBUzM6e3vBhO4HkeTA4r10O6E812v9b+JggFD65FAoskjfbdebvaA
         6obZDMnNFIs4QgNAxxEGoKxcmdxZuEeUWDrV3G8qBi1rqCoKNosGoGrONkVnWA+KMc
         Yr8XXMSz5gMCR1Wb5his6LtP308VT7RsLxO7uf45d7DAYgNezlYn4C96x+1Xdv+BxU
         jpoN8CwRsorVWRg2LwZOc6AvqPNpQHhFBgjuiMHiapgR4w0uVBDcghj11xG6HuJqkL
         0bg0y/PT8ftnI3ePWCLosK1d8gwh34206dJjOprt88QgtOXBTpP7/3SnUcEMhE8sxb
         c4t4FxcXY2Wyg==
Date:   Thu, 11 Mar 2021 01:13:31 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Stefan Berger <stefanb@linux.ibm.com>
Cc:     peterhuewe@gmx.de, jgg@ziepe.ca, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] tpm: acpi: Check eventlog signature before using
 it
Message-ID: <YElSm4UchdU+W7D7@kernel.org>
References: <20210310221916.356716-1-stefanb@linux.ibm.com>
 <20210310221916.356716-3-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210310221916.356716-3-stefanb@linux.ibm.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Mar 10, 2021 at 05:19:15PM -0500, Stefan Berger wrote:
> Check the eventlog signature before using it. This avoids using an
> empty log, as may be the case when QEMU created the ACPI tables,
> rather than probing the EFI log next. This resolves an issue where
> the EFI log was empty since an empty ACPI log was used.
> 
> Fixes: 85467f63a05c ("tpm: Add support for event log pointer found in TPM2 ACPI table")
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> ---
>  drivers/char/tpm/eventlog/acpi.c | 33 +++++++++++++++++++++++++++++++-
>  1 file changed, 32 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/char/tpm/eventlog/acpi.c b/drivers/char/tpm/eventlog/acpi.c
> index 3633ed70f48f..1b18ce5ebab1 100644
> --- a/drivers/char/tpm/eventlog/acpi.c
> +++ b/drivers/char/tpm/eventlog/acpi.c
> @@ -41,6 +41,27 @@ struct acpi_tcpa {
>  	};
>  };
>  
> +/* Check that the given log is indeed a TPM2 log. */
> +static bool tpm_is_tpm2_log(void *bios_event_log, u64 len)
> +{
> +	struct tcg_efi_specid_event_head *efispecid;
> +	struct tcg_pcr_event *event_header;
> +	int n;
> +
> +	if (len < sizeof(*event_header))
> +		return false;
> +	len -= sizeof(*event_header);
> +	event_header = bios_event_log;
> +
> +	if (len < sizeof(*efispecid))
> +		return false;
> +	efispecid = (struct tcg_efi_specid_event_head *)event_header->event;
> +
> +	n = memcmp(efispecid->signature, TCG_SPECID_SIG,
> +		   sizeof(TCG_SPECID_SIG));
> +	return n == 0;
> +}
> +
>  /* read binary bios log */
>  int tpm_read_log_acpi(struct tpm_chip *chip)
>  {
> @@ -52,6 +73,7 @@ int tpm_read_log_acpi(struct tpm_chip *chip)
>  	struct acpi_table_tpm2 *tbl;
>  	struct acpi_tpm2_phy *tpm2_phy;
>  	int format;
> +	int ret;
>  
>  	log = &chip->log;
>  
> @@ -112,6 +134,7 @@ int tpm_read_log_acpi(struct tpm_chip *chip)
>  
>  	log->bios_event_log_end = log->bios_event_log + len;
>  
> +	ret = -EIO;
>  	virt = acpi_os_map_iomem(start, len);
>  	if (!virt)
>  		goto err;
> @@ -119,11 +142,19 @@ int tpm_read_log_acpi(struct tpm_chip *chip)
>  	memcpy_fromio(log->bios_event_log, virt, len);
>  
>  	acpi_os_unmap_iomem(virt, len);
> +
> +	if (chip->flags & TPM_CHIP_FLAG_TPM2 &&
> +	    !tpm_is_tpm2_log(log->bios_event_log, len)) {
> +		/* try EFI log next */
> +		ret = -ENODEV;
> +		goto err;
> +	}
> +
>  	return format;
>  
>  err:
>  	kfree(log->bios_event_log);
>  	log->bios_event_log = NULL;
> -	return -EIO;
> +	return ret;
>  
>  }
> -- 
> 2.29.2
> 
> 

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

/Jarkko
