Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 430A85F757
	for <lists+linux-integrity@lfdr.de>; Thu,  4 Jul 2019 13:46:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727548AbfGDLqh (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 4 Jul 2019 07:46:37 -0400
Received: from mga01.intel.com ([192.55.52.88]:2313 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727436AbfGDLqh (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 4 Jul 2019 07:46:37 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Jul 2019 04:46:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,450,1557212400"; 
   d="scan'208";a="363334703"
Received: from jsakkine-mobl1.tm.intel.com ([10.237.50.189])
  by fmsmga006.fm.intel.com with ESMTP; 04 Jul 2019 04:46:33 -0700
Message-ID: <f0d67f0dc48ca8162c666c988da5147cb92b623b.camel@linux.intel.com>
Subject: Re: [PATCH v3] tpm: Get TCG log from TPM2 ACPI table for tpm2
 systems
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Jordan Hand <jordanhand22@gmail.com>
Cc:     Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Allison Randal <allison@lohutok.net>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 04 Jul 2019 14:46:32 +0300
In-Reply-To: <20190624174643.21746-1-jorhand@microsoft.com>
References: <20190624174643.21746-1-jorhand@microsoft.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, 2019-06-24 at 10:46 -0700, Jordan Hand wrote:
> From: Jordan Hand <jordanhand22@gmail.com>
>
> For TPM2-based systems, retrieve the TCG log from the TPM2 ACPI table.
> The TPM2 ACPI table is defined in section 7.3 of the TCG ACPI
> Specification (see link).

You are claiming here that this applies to all systems I've never used
even a single one that uses it. How can you possibly back this up?  I've
been aware that SeaBIOS does use it but only now became aware that it
has been also updated to the standard. This kind of change is welcome
but lets scope things properly.

Unfortunately, also the short summary looks like pure nonsense at the
moment. What are "TCG log", "tpm2 systems" and why is TPM2 not
capitalized there?

For short summary I'd just put "tpm: Parse event log from TPM2 table"

> The TPM2 table is used primarily by legacy BIOS in place of the TCPA table
> when the system's TPM is version 2.0 to denote (among other metadata) the

"for TPM2 systems"

Stick with a single notation. If count correctly you use in total three
different notations for the same thing in the commit message.

> location of the crypto-agile TCG log. In particluar, the SeaBios firmware
> used by default by QEMU makes use of this table for crypto-agile logs.

crypto-agile log should be enough given the context.

> Link:
> 
https://trustedcomputinggroup.org/wp-content/uploads/TCG_ACPIGeneralSpecification_v1.20_r8.pdf

Should be in the same line. You should also separate them with a single
space character, not with a new line character.

This is a more sane URL for the resource to use:

https://trustedcomputinggroup.org/resource/tcg-acpi-specification/

>

Remove this extra new line character.

> Signed-off-by: Jordan Hand <jordanhand22@gmail.com>
> ---
>
> Same as v2 with more descriptive commit message
>
>  drivers/char/tpm/eventlog/acpi.c | 67 +++++++++++++++++++++++---------
>  1 file changed, 48 insertions(+), 19 deletions(-)
>
> diff --git a/drivers/char/tpm/eventlog/acpi.c
> b/drivers/char/tpm/eventlog/acpi.c
> index 63ada5e53f13..b945c4ff3af6 100644
> --- a/drivers/char/tpm/eventlog/acpi.c
> +++ b/drivers/char/tpm/eventlog/acpi.c
> @@ -41,17 +41,31 @@ struct acpi_tcpa {
>  	};
>  };
>
> +struct acpi_tpm2 {
> +	struct acpi_table_header hdr;
> +	u16 platform_class;
> +	u16 reserved;
> +	u64 control_area_addr;
> +	u32 start_method;
> +	u8 start_method_params[12];
> +	u32 log_max_len;
> +	u64 log_start_addr;
> +} __packed;

This is a duplicate definition to struct acpi_table_tpm2 located in
include/acpi/actbl3.h. If you need to update that file, please do it
as a separate commit.

Other examples of use can be found from tpm_crb.c and tpm_tis.c.
Please skim them through.

> +
>  /* read binary bios log */
>  int tpm_read_log_acpi(struct tpm_chip *chip)
>  {
> -	struct acpi_tcpa *buff;
> +	struct acpi_table_header *buff;
> +	struct acpi_tcpa *tcpa;
> +	struct acpi_tpm2 *tpm2;
> +

A trailing new line.

>  	acpi_status status;
>  	void __iomem *virt;
>  	u64 len, start;
> +	int log_type;
>  	struct tpm_bios_log *log;
> -
> -	if (chip->flags & TPM_CHIP_FLAG_TPM2)
> -		return -ENODEV;
> +	bool is_tpm2 = chip->flags & TPM_CHIP_FLAG_TPM2;
> +	acpi_string table_sig;
>
>  	log = &chip->log;
>
> @@ -61,26 +75,41 @@ int tpm_read_log_acpi(struct tpm_chip *chip)
>  	if (!chip->acpi_dev_handle)
>  		return -ENODEV;
>
> -	/* Find TCPA entry in RSDT (ACPI_LOGICAL_ADDRESSING) */
> -	status = acpi_get_table(ACPI_SIG_TCPA, 1,
> -				(struct acpi_table_header **)&buff);
> +	/* Find TCPA or TPM2 entry in RSDT (ACPI_LOGICAL_ADDRESSING) */
> +	table_sig = is_tpm2 ? ACPI_SIG_TPM2 : ACPI_SIG_TCPA;
> +	status = acpi_get_table(table_sig, 1, &buff);
>
>  	if (ACPI_FAILURE(status))
>  		return -ENODEV;
>
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
> +	/* If log_max_len and log_start_addr are set, start_method_params will
> +	 * be 12 bytes, according to TCG ACPI spec. If start_method_params is
> +	 * fewer than 12 bytes, the TCG log is not available
> +	 */

What is start_method_params? I don't understand this comment. Please
remove and instead implement validation to all branches.

> +	if (is_tpm2 && (buff->length == sizeof(struct acpi_tpm2))) {
> +		tpm2 = (struct acpi_tpm2 *)buff;
> +		len = tpm2->log_max_len;
> +		start = tpm2->log_start_addr;
> +		log_type = EFI_TCG2_EVENT_LOG_FORMAT_TCG_2;
> +	} else {

Instead "else if (buff->length == sizeof(struct acpi_tcpa)" and return
-EINVAL if neither matches.

Logically that is a distinct change so you need to turn this into
a patch set where the first patch contains only the change that
validates that the length for TCPA and return -EINVAL if not.

> +		tcpa = (struct acpi_tcpa *)buff;

Did not look everything in the detail because there is still so much
groundwork to do but this will branch to use TCPA table with a TPM2
chip when the length differs from sizeof(struct acpi_tpm2).

/Jarkko

