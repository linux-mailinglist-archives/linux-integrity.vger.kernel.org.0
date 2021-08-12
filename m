Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA6A63EAA83
	for <lists+linux-integrity@lfdr.de>; Thu, 12 Aug 2021 20:58:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234850AbhHLS7V (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 12 Aug 2021 14:59:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:58258 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234588AbhHLS7V (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 12 Aug 2021 14:59:21 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 517E660200;
        Thu, 12 Aug 2021 18:58:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628794735;
        bh=4j5w1bAhfwL043thWwHbrt8AtOIjqKgMLpSCAvsF/DM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SimV6NQ2HUs2ObVX/JcHfnmJnp/3j54BtO9QUC53vlsO171hYCohgpZ/jyNzVJBx1
         VB5Q/L0LsqaijM0pdpD0PuRrFY7Ag6RDTneRTCkllRi4SLN5DVdcJ2fx+Oa90AVEmr
         glaUhxPer2JtidZrhMew0ndS1tXnEOsbJzj4IO+xYGaMGwcDENU9Q1r/NBRpe5qWs2
         7cMp3wh7kKsiDbBb38rkyL1KG7+w0x49qc+iXeRMZBLfOPuXlNaXwoNFKQALwwMtXp
         7gLi6TLmntoQF41tS8Z/s8UM7pqNybygnGQXtgqbyi+4jPt9yJTsb5JbtgfRXRIdY3
         2OIt55S3DsSAw==
Date:   Thu, 12 Aug 2021 21:58:53 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Eric Snowberg <eric.snowberg@oracle.com>
Cc:     keyrings@vger.kernel.org, linux-integrity@vger.kernel.org,
        zohar@linux.ibm.com, dhowells@redhat.com, dwmw2@infradead.org,
        herbert@gondor.apana.org.au, davem@davemloft.net,
        jmorris@namei.org, serge@hallyn.com, keescook@chromium.org,
        gregkh@linuxfoundation.org, torvalds@linux-foundation.org,
        scott.branden@broadcom.com, weiyongjun1@huawei.com,
        nayna@linux.ibm.com, ebiggers@google.com, ardb@kernel.org,
        nramas@linux.microsoft.com, lszubowi@redhat.com,
        linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        James.Bottomley@hansenpartnership.com, pjones@redhat.com,
        glin@suse.com, konrad.wilk@oracle.com
Subject: Re: [PATCH v3 01/14] integrity: Introduce a Linux keyring for the
 Machine Owner Key (MOK)
Message-ID: <20210812185853.p5mgsgrftgwvt5fx@kernel.org>
References: <20210812021855.3083178-1-eric.snowberg@oracle.com>
 <20210812021855.3083178-2-eric.snowberg@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210812021855.3083178-2-eric.snowberg@oracle.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Aug 11, 2021 at 10:18:42PM -0400, Eric Snowberg wrote:
> Many UEFI Linux distributions boot using shim.  The UEFI shim provides
> what is called Machine Owner Keys (MOK). Shim uses both the UEFI Secure
> Boot DB and MOK keys to validate the next step in the boot chain.  The
> MOK facility can be used to import user generated keys.  These keys can
> be used to sign an end-users development kernel build.  When Linux
> boots, both UEFI Secure Boot DB and MOK keys get loaded in the Linux
> .platform keyring.
> 
> Add a new Linux keyring called .mok.  This keyring shall contain just

I would consider ".machine" instead. It holds MOK keys but is not a
MOK key.

> MOK keys and not the remaining keys in the platform keyring. This new
> .mok keyring will be used in follow on patches.  Unlike keys in the
> platform keyring, keys contained in the .mok keyring will be trusted
> within the kernel if the end-user has chosen to do so.
> 
> Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>
> ---
> v1: Initial version
> v2: Removed destory keyring code
> v3: Unmodified from v2
> ---
>  security/integrity/Makefile                   |  3 ++-
>  security/integrity/digsig.c                   |  1 +
>  security/integrity/integrity.h                |  3 ++-
>  .../integrity/platform_certs/mok_keyring.c    | 21 +++++++++++++++++++
>  4 files changed, 26 insertions(+), 2 deletions(-)
>  create mode 100644 security/integrity/platform_certs/mok_keyring.c
> 
> diff --git a/security/integrity/Makefile b/security/integrity/Makefile
> index 7ee39d66cf16..8e2e98cba1f6 100644
> --- a/security/integrity/Makefile
> +++ b/security/integrity/Makefile
> @@ -9,7 +9,8 @@ integrity-y := iint.o
>  integrity-$(CONFIG_INTEGRITY_AUDIT) += integrity_audit.o
>  integrity-$(CONFIG_INTEGRITY_SIGNATURE) += digsig.o
>  integrity-$(CONFIG_INTEGRITY_ASYMMETRIC_KEYS) += digsig_asymmetric.o
> -integrity-$(CONFIG_INTEGRITY_PLATFORM_KEYRING) += platform_certs/platform_keyring.o
> +integrity-$(CONFIG_INTEGRITY_PLATFORM_KEYRING) += platform_certs/platform_keyring.o \
> +						  platform_certs/mok_keyring.o
>  integrity-$(CONFIG_LOAD_UEFI_KEYS) += platform_certs/efi_parser.o \
>  				      platform_certs/load_uefi.o \
>  				      platform_certs/keyring_handler.o
> diff --git a/security/integrity/digsig.c b/security/integrity/digsig.c
> index 3b06a01bd0fd..e07334504ef1 100644
> --- a/security/integrity/digsig.c
> +++ b/security/integrity/digsig.c
> @@ -30,6 +30,7 @@ static const char * const keyring_name[INTEGRITY_KEYRING_MAX] = {
>  	".ima",
>  #endif
>  	".platform",
> +	".mok",
>  };
>  
>  #ifdef CONFIG_IMA_KEYRINGS_PERMIT_SIGNED_BY_BUILTIN_OR_SECONDARY
> diff --git a/security/integrity/integrity.h b/security/integrity/integrity.h
> index 547425c20e11..e0e17ccba2e6 100644
> --- a/security/integrity/integrity.h
> +++ b/security/integrity/integrity.h
> @@ -151,7 +151,8 @@ int integrity_kernel_read(struct file *file, loff_t offset,
>  #define INTEGRITY_KEYRING_EVM		0
>  #define INTEGRITY_KEYRING_IMA		1
>  #define INTEGRITY_KEYRING_PLATFORM	2
> -#define INTEGRITY_KEYRING_MAX		3
> +#define INTEGRITY_KEYRING_MOK		3
> +#define INTEGRITY_KEYRING_MAX		4
>  
>  extern struct dentry *integrity_dir;
>  
> diff --git a/security/integrity/platform_certs/mok_keyring.c b/security/integrity/platform_certs/mok_keyring.c
> new file mode 100644
> index 000000000000..b1ee45b77731
> --- /dev/null
> +++ b/security/integrity/platform_certs/mok_keyring.c
> @@ -0,0 +1,21 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * MOK keyring routines.
> + *
> + * Copyright (c) 2021, Oracle and/or its affiliates.
> + */
> +
> +#include "../integrity.h"
> +
> +static __init int mok_keyring_init(void)
> +{
> +	int rc;
> +
> +	rc = integrity_init_keyring(INTEGRITY_KEYRING_MOK);
> +	if (rc)
> +		return rc;
> +
> +	pr_notice("MOK Keyring initialized\n");
> +	return 0;
> +}
> +device_initcall(mok_keyring_init);
> -- 
> 2.18.4
> 
> 

/Jarkko
