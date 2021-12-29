Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7C20480E9F
	for <lists+linux-integrity@lfdr.de>; Wed, 29 Dec 2021 02:34:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238227AbhL2BeI (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 28 Dec 2021 20:34:08 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:44198 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238219AbhL2BeF (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 28 Dec 2021 20:34:05 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 18116B817AB;
        Wed, 29 Dec 2021 01:34:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F737C36AE7;
        Wed, 29 Dec 2021 01:34:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640741641;
        bh=pMJjVDZPgM948/4+cn0RybmypKFSAOF2Qet+npnB0qI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BGV9teAEQtKzRouTQ7FIODF/sdbQus2tfZqaEYCeOyWoxLcNLOerT6/njmAfsZlgW
         u8N1B5yAULEUHfmYSpNQhkkSWM6ZHyKNg7VTL+7XSHqC9AvZvGZ6pEbvBKtIKcn+gr
         jArbzeGfK2VxHoUZMODPU4Prja+huMn1I+Y5VFUdUAeKvbar/8SjMr0tMOF/K1OqMK
         K3u6fj0vy1DBPt87LB4yOApP1rZF5NXun8SccMIKmt6fC3PAA5e26QniGkEb2wDSNr
         sJJ8DT3vhJ4NXLWhMCmkUinoFv82sAWJ34zcwCktGslpXsIWZwVPOJ24g5BgBwA7RY
         /AxVns9mNF+hw==
Date:   Wed, 29 Dec 2021 03:33:59 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Nayna Jain <nayna@linux.ibm.com>
Cc:     linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        dhowells@redhat.com, zohar@linux.ibm.com,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dimitri.ledkov@canonical.com,
        seth@forshee.me
Subject: Re: [PATCH v6 3/3] integrity: support including firmware ".platform"
 keys at build time
Message-ID: <Ycu7B2RLatUFphqm@iki.fi>
References: <20211223013919.206273-1-nayna@linux.ibm.com>
 <20211223013919.206273-4-nayna@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211223013919.206273-4-nayna@linux.ibm.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Dec 22, 2021 at 08:39:19PM -0500, Nayna Jain wrote:
> Allow firmware keys to be embedded in the Linux kernel and loaded onto
> the ".platform" keyring on boot.
> 
> The firmware keys can be specified in a file as a list of PEM encoded
> certificates using new config INTEGRITY_PLATFORM_KEYS. The certificates
> are embedded in the image by converting the PEM-formatted certificates
> into DER(binary) and generating
> security/integrity/platform_certs/platform_certificate_list file at
> build time. On boot, the embedded certs from the image are loaded onto
> the ".platform" keyring.
> 
> Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
> Signed-off-by: Nayna Jain <nayna@linux.ibm.com>
> ---
>  security/integrity/Kconfig                    | 10 +++++++
>  security/integrity/Makefile                   | 17 +++++++++++-
>  .../integrity/platform_certs/platform_cert.S  | 23 ++++++++++++++++
>  .../platform_certs/platform_keyring.c         | 26 +++++++++++++++++++
>  4 files changed, 75 insertions(+), 1 deletion(-)
>  create mode 100644 security/integrity/platform_certs/platform_cert.S
> 
> diff --git a/security/integrity/Kconfig b/security/integrity/Kconfig
> index 71f0177e8716..9fccf1368b8a 100644
> --- a/security/integrity/Kconfig
> +++ b/security/integrity/Kconfig
> @@ -62,6 +62,16 @@ config INTEGRITY_PLATFORM_KEYRING
>           provided by the platform for verifying the kexec'ed kerned image
>           and, possibly, the initramfs signature.
>  
> +config INTEGRITY_PLATFORM_KEYS
> +        string "Builtin X.509 keys for .platform keyring"
> +        depends on KEYS
> +        depends on ASYMMETRIC_KEY_TYPE
> +        depends on INTEGRITY_PLATFORM_KEYRING
> +        help
> +          If set, this option should be the filename of a PEM-formatted file
> +          containing X.509 certificates to be loaded onto the ".platform"
> +          keyring.
> +
>  config LOAD_UEFI_KEYS
>         depends on INTEGRITY_PLATFORM_KEYRING
>         depends on EFI
> diff --git a/security/integrity/Makefile b/security/integrity/Makefile
> index 7ee39d66cf16..46629f5ef4f6 100644
> --- a/security/integrity/Makefile
> +++ b/security/integrity/Makefile
> @@ -3,13 +3,18 @@
>  # Makefile for caching inode integrity data (iint)
>  #
>  
> +quiet_cmd_extract_certs  = EXTRACT_CERTS   $(patsubst "%",%,$(2))
> +      cmd_extract_certs  = scripts/extract-cert $(2) $@
> +$(eval $(call config_filename,INTEGRITY_PLATFORM_KEYS))
> +
>  obj-$(CONFIG_INTEGRITY) += integrity.o
>  
>  integrity-y := iint.o
>  integrity-$(CONFIG_INTEGRITY_AUDIT) += integrity_audit.o
>  integrity-$(CONFIG_INTEGRITY_SIGNATURE) += digsig.o
>  integrity-$(CONFIG_INTEGRITY_ASYMMETRIC_KEYS) += digsig_asymmetric.o
> -integrity-$(CONFIG_INTEGRITY_PLATFORM_KEYRING) += platform_certs/platform_keyring.o
> +integrity-$(CONFIG_INTEGRITY_PLATFORM_KEYRING) += platform_certs/platform_keyring.o \
> +						  platform_certs/platform_cert.o
>  integrity-$(CONFIG_LOAD_UEFI_KEYS) += platform_certs/efi_parser.o \
>  				      platform_certs/load_uefi.o \
>  				      platform_certs/keyring_handler.o
> @@ -19,3 +24,13 @@ integrity-$(CONFIG_LOAD_PPC_KEYS) += platform_certs/efi_parser.o \
>                                       platform_certs/keyring_handler.o
>  obj-$(CONFIG_IMA)			+= ima/
>  obj-$(CONFIG_EVM)			+= evm/
> +
> +
> +$(obj)/platform_certs/platform_cert.o: $(obj)/platform_certs/platform_certificate_list
> +
> +targets += platform_certificate_list
> +
> +$(obj)/platform_certs/platform_certificate_list: scripts/extract-cert $(INTEGRITY_PLATFORM_KEYS_FILENAME) FORCE
> +	$(call if_changed,extract_certs,$(CONFIG_INTEGRITY_PLATFORM_KEYS))
> +
> +clean-files := platform_certs/platform_certificate_list
> diff --git a/security/integrity/platform_certs/platform_cert.S b/security/integrity/platform_certs/platform_cert.S
> new file mode 100644
> index 000000000000..20bccce5dc5a
> --- /dev/null
> +++ b/security/integrity/platform_certs/platform_cert.S
> @@ -0,0 +1,23 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#include <linux/export.h>
> +#include <linux/init.h>
> +
> +	__INITRODATA
> +
> +	.align 8
> +#ifdef CONFIG_INTEGRITY_PLATFORM_KEYRING
> +	.globl platform_certificate_list
> +platform_certificate_list:
> +__cert_list_start:
> +	.incbin "security/integrity/platform_certs/platform_certificate_list"
> +__cert_list_end:
> +#endif
> +
> +	.align 8
> +	.globl platform_certificate_list_size
> +platform_certificate_list_size:
> +#ifdef CONFIG_64BIT
> +	.quad __cert_list_end - __cert_list_start
> +#else
> +	.long __cert_list_end - __cert_list_start
> +#endif
> diff --git a/security/integrity/platform_certs/platform_keyring.c b/security/integrity/platform_certs/platform_keyring.c
> index bcafd7387729..b45de142c5f5 100644
> --- a/security/integrity/platform_certs/platform_keyring.c
> +++ b/security/integrity/platform_certs/platform_keyring.c
> @@ -12,8 +12,12 @@
>  #include <linux/cred.h>
>  #include <linux/err.h>
>  #include <linux/slab.h>
> +#include <keys/system_keyring.h>
>  #include "../integrity.h"
>  
> +extern __initconst const u8 platform_certificate_list[];
> +extern __initconst const unsigned long platform_certificate_list_size;
> +
>  /**
>   * add_to_platform_keyring - Add to platform keyring without validation.
>   * @source: Source of key
> @@ -37,6 +41,28 @@ void __init add_to_platform_keyring(const char *source, const void *data,
>  		pr_info("Error adding keys to platform keyring %s\n", source);
>  }
>  
> +static __init int load_platform_certificate_list(void)
> +{
> +	const u8 *p;
> +	unsigned long size;
> +	int rc;
> +	struct key *keyring;
> +
> +	p = platform_certificate_list;
> +	size = platform_certificate_list_size;
> +
> +	keyring = integrity_keyring_from_id(INTEGRITY_KEYRING_PLATFORM);
> +	if (IS_ERR(keyring))
> +		return PTR_ERR(keyring);
> +
> +	rc = load_certificate_list(p, size, keyring);
> +	if (rc)
> +		pr_info("Error adding keys to platform keyring %d\n", rc);
> +
> +	return rc;
> +}
> +late_initcall(load_platform_certificate_list);

Would not hurt to briefly explain the chosen initcall level in the commit
message.

> +
>  /*
>   * Create the trusted keyrings.
>   */
> -- 
> 2.27.0
> 

/Jarkko
