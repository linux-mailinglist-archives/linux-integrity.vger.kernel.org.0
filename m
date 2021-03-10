Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA787334856
	for <lists+linux-integrity@lfdr.de>; Wed, 10 Mar 2021 20:52:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230183AbhCJTwP (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 10 Mar 2021 14:52:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:51612 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233777AbhCJTwF (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 10 Mar 2021 14:52:05 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1A4D764FBB;
        Wed, 10 Mar 2021 19:52:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615405925;
        bh=GZ5OFZ8M2S6Yq9NYIS2ZSVYVl+keV4Ek6HWIupTvzJ4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=M9spjTGwEG1TJx2rU4Tet6X7QzZZnz7k0WfZ2oboeRpygnNBhsC1G32EEjjLyOhgw
         bNAfIGxNGZxrzdRBdI/Lh0uaYDIZEez46tfJbenPMojvZFeJ/a1pVCxcJmna7gE+9Y
         AtKU2mquCjnFu+WFw9PsOoylEMsKnAB+Xs3R/rhSUTn6zmxAxEsg3HACGLYIOrvkWP
         DAFTr8fSYUOL6pVwOLtjDdgkm4UNBMesXiLoIv41lGLZsyKVVHHZv7p1YvPZI7mED+
         ADTM7c0YwBJEdGrec+jEJgXaCGYiDAbtjNCnbJVtOzhJAqaM+HFz0jXyvfjSIaNvzK
         nIIkyulfby/oQ==
Date:   Wed, 10 Mar 2021 21:51:42 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Stefan Berger <stefanb@linux.ibm.com>
Cc:     peterhuewe@gmx.de, jgg@ziepe.ca, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] tpm: acpi: Check eventlog signature before using it
Message-ID: <YEkjTim/800967kS@kernel.org>
References: <20210309031954.6232-1-stefanb@linux.ibm.com>
 <20210309031954.6232-3-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210309031954.6232-3-stefanb@linux.ibm.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Mar 08, 2021 at 10:19:53PM -0500, Stefan Berger wrote:
> Check the eventlog signature before using it. This avoids using an
> empty log, as may be the case when QEMU created the ACPI tables,
> rather than probing the EFI log next. This resolves an issue where
> the EFI log was empty since an empty ACPI log was used.
> 
> Fixes: 85467f63a05c ("tpm: Add support for event log pointer found in TPM2 ACPI table")
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> ---
>  drivers/char/tpm/eventlog/acpi.c | 31 ++++++++++++++++++++++++++++++-
>  1 file changed, 30 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/char/tpm/eventlog/acpi.c b/drivers/char/tpm/eventlog/acpi.c
> index 3633ed70f48f..b6bfd22e4a2f 100644
> --- a/drivers/char/tpm/eventlog/acpi.c
> +++ b/drivers/char/tpm/eventlog/acpi.c
> @@ -41,6 +41,25 @@ struct acpi_tcpa {
>  	};
>  };
>  
> +/* check that the given log is indeed a TPM2 log */

/* Check that the given log is indeed a TPM2 log. */

> +static int tpm_check_tpm2_log_header(void *bios_event_log, u64 len)

Just by this name does not give any clue what the function does.
"check" can refer to almost anything.

Perhaps just tpm_is_tpm2_log()?

> +{
> +	struct tcg_efi_specid_event_head *efispecid;
> +	struct tcg_pcr_event *event_header = bios_event_log;

Please, reorder these declarations (reverse christmas tree).

> +
> +	if (len < sizeof(*event_header))
> +		return 1;
> +	len -= sizeof(*event_header);
> +
> +	efispecid = (struct tcg_efi_specid_event_head *)event_header->event;
> +	if (len < sizeof(*efispecid) ||
> +	    memcmp(efispecid->signature, TCG_SPECID_SIG,
> +		   sizeof(TCG_SPECID_SIG)))

Please never put memcmp() inside a conditional statement.

> +		return 1;
> +
> +	return 0;
> +}
> +
>  /* read binary bios log */
>  int tpm_read_log_acpi(struct tpm_chip *chip)
>  {
> @@ -52,6 +71,7 @@ int tpm_read_log_acpi(struct tpm_chip *chip)
>  	struct acpi_table_tpm2 *tbl;
>  	struct acpi_tpm2_phy *tpm2_phy;
>  	int format;
> +	int ret;
>  
>  	log = &chip->log;
>  
> @@ -112,6 +132,7 @@ int tpm_read_log_acpi(struct tpm_chip *chip)
>  
>  	log->bios_event_log_end = log->bios_event_log + len;
>  
> +	ret = -EIO;
>  	virt = acpi_os_map_iomem(start, len);
>  	if (!virt)
>  		goto err;
> @@ -119,11 +140,19 @@ int tpm_read_log_acpi(struct tpm_chip *chip)
>  	memcpy_fromio(log->bios_event_log, virt, len);
>  
>  	acpi_os_unmap_iomem(virt, len);
> +
> +	if (chip->flags & TPM_CHIP_FLAG_TPM2 &&
> +	    tpm_check_tpm2_log_header(log->bios_event_log, len)) {
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

/Jarkko
