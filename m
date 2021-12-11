Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20F3F4712BF
	for <lists+linux-integrity@lfdr.de>; Sat, 11 Dec 2021 09:11:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229998AbhLKIK6 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sat, 11 Dec 2021 03:10:58 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:35624 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbhLKIK6 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 11 Dec 2021 03:10:58 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 04E9BCE2F2E;
        Sat, 11 Dec 2021 08:10:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BF93C004DD;
        Sat, 11 Dec 2021 08:10:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639210254;
        bh=oI+5/sY/L+5iscdhfDYqcwxVdpLCj2U5gYE5uvfSF84=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=PSQeWoYZFP5ERRveMRS37qY8u3LQsZgP6Vp6Cbrxi7jRHR0+VTAGSef6cS95rTceq
         kc3D8/nf3tEpnoIXEFTZYNVx/CAonAp5ip3NF0kPhoOHxErpIIF9Ah+vJDKiJJhIdC
         aE/WdLt6P273VsBhsX4/zTLYT3almJOsqEuhBItdfIckiIC9SpjZ4htzZmbJzZ4mLo
         jYpv6//uE6liBfAqVg+eDS9SXOxDPw2gVD9OBg5bE/st9g8iXGFOnPHP55edmUXDRx
         j9sFoDC10In/vcqsgT6LB+CRxE1vgzzmsKprFhSp37tLwuWalBeb/nJCb2BIrSwZpY
         3bb/nGBVUE3eg==
Message-ID: <2751d6f75d030cbb51abc916f2edbc5218d7f3f7.camel@kernel.org>
Subject: Re: [PATCH v5 2/2] integrity: support including firmware
 ".platform" keys at build time
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Nayna Jain <nayna@linux.ibm.com>, linux-integrity@vger.kernel.org,
        keyrings@vger.kernel.org
Cc:     dhowells@redhat.com, zohar@linux.ibm.com,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Dimitri John Ledkov <dimitri.ledkov@canonical.com>,
        Seth Forshee <seth@forshee.me>
Date:   Sat, 11 Dec 2021 10:10:50 +0200
In-Reply-To: <20211124204714.82514-3-nayna@linux.ibm.com>
References: <20211124204714.82514-1-nayna@linux.ibm.com>
         <20211124204714.82514-3-nayna@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.42.2 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 2021-11-24 at 15:47 -0500, Nayna Jain wrote:
> A new function load_builtin_platform_cert() is defined to load compiled
> in certificates onto the ".platform" keyring.
>=20
> Signed-off-by: Nayna Jain <nayna@linux.ibm.com>

This is way too non-verbose.

It does not *really* describe what the patch does, e.g. it is
completely any description that a kconfig option is added.
You should describe all things that are going to happen as a
consequence of applying this patch.

It's not like the commit is just adding a function, and that's
the whole story.

Nit: always use imperative form: "Add a new function...".


> ---
>  security/integrity/Kconfig                    | 10 +++++++
>  security/integrity/Makefile                   | 17 +++++++++++-
>  security/integrity/digsig.c                   |  2 +-
>  security/integrity/integrity.h                |  6 +++++
>  .../integrity/platform_certs/platform_cert.S  | 23 ++++++++++++++++
>  .../platform_certs/platform_keyring.c         | 26 +++++++++++++++++++
>  6 files changed, 82 insertions(+), 2 deletions(-)
>  create mode 100644 security/integrity/platform_certs/platform_cert.S
>=20
> diff --git a/security/integrity/Kconfig b/security/integrity/Kconfig
> index 71f0177e8716..9fccf1368b8a 100644
> --- a/security/integrity/Kconfig
> +++ b/security/integrity/Kconfig
> @@ -62,6 +62,16 @@ config INTEGRITY_PLATFORM_KEYRING
>           provided by the platform for verifying the kexec'ed kerned imag=
e
>           and, possibly, the initramfs signature.
> =20
> +config INTEGRITY_PLATFORM_KEYS
> +        string "Builtin X.509 keys for .platform keyring"
> +        depends on KEYS
> +        depends on ASYMMETRIC_KEY_TYPE
> +        depends on INTEGRITY_PLATFORM_KEYRING
> +        help
> +          If set, this option should be the filename of a PEM-formatted =
file
> +          containing X.509 certificates to be loaded onto the ".platform=
"
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
> =20
> +quiet_cmd_extract_certs  =3D EXTRACT_CERTS   $(patsubst "%",%,$(2))
> +      cmd_extract_certs  =3D scripts/extract-cert $(2) $@
> +$(eval $(call config_filename,INTEGRITY_PLATFORM_KEYS))
> +
>  obj-$(CONFIG_INTEGRITY) +=3D integrity.o
> =20
>  integrity-y :=3D iint.o
>  integrity-$(CONFIG_INTEGRITY_AUDIT) +=3D integrity_audit.o
>  integrity-$(CONFIG_INTEGRITY_SIGNATURE) +=3D digsig.o
>  integrity-$(CONFIG_INTEGRITY_ASYMMETRIC_KEYS) +=3D digsig_asymmetric.o
> -integrity-$(CONFIG_INTEGRITY_PLATFORM_KEYRING) +=3D platform_certs/platf=
orm_keyring.o
> +integrity-$(CONFIG_INTEGRITY_PLATFORM_KEYRING) +=3D platform_certs/platf=
orm_keyring.o \
> +						  platform_certs/platform_cert.o
>  integrity-$(CONFIG_LOAD_UEFI_KEYS) +=3D platform_certs/efi_parser.o \
>  				      platform_certs/load_uefi.o \
>  				      platform_certs/keyring_handler.o
> @@ -19,3 +24,13 @@ integrity-$(CONFIG_LOAD_PPC_KEYS) +=3D platform_certs/=
efi_parser.o \
>                                       platform_certs/keyring_handler.o
>  obj-$(CONFIG_IMA)			+=3D ima/
>  obj-$(CONFIG_EVM)			+=3D evm/
> +
> +
> +$(obj)/platform_certs/platform_cert.o: $(obj)/platform_certs/platform_ce=
rtificate_list
> +
> +targets +=3D platform_certificate_list
> +
> +$(obj)/platform_certs/platform_certificate_list: scripts/extract-cert $(=
INTEGRITY_PLATFORM_KEYS_FILENAME) FORCE
> +	$(call if_changed,extract_certs,$(CONFIG_INTEGRITY_PLATFORM_KEYS))
> +
> +clean-files :=3D platform_certs/platform_certificate_list
> diff --git a/security/integrity/digsig.c b/security/integrity/digsig.c
> index 3b06a01bd0fd..0ea40ed8dfcb 100644
> --- a/security/integrity/digsig.c
> +++ b/security/integrity/digsig.c
> @@ -38,7 +38,7 @@ static const char * const keyring_name[INTEGRITY_KEYRIN=
G_MAX] =3D {
>  #define restrict_link_to_ima restrict_link_by_builtin_trusted
>  #endif
> =20
> -static struct key *integrity_keyring_from_id(const unsigned int id)
> +struct key *integrity_keyring_from_id(const unsigned int id)

This export should be split into separate patch.

>  {
>  	if (id >=3D INTEGRITY_KEYRING_MAX)
>  		return ERR_PTR(-EINVAL);
> diff --git a/security/integrity/integrity.h b/security/integrity/integrit=
y.h
> index 547425c20e11..feb84e1b1105 100644
> --- a/security/integrity/integrity.h
> +++ b/security/integrity/integrity.h
> @@ -167,6 +167,7 @@ int __init integrity_init_keyring(const unsigned int =
id);
>  int __init integrity_load_x509(const unsigned int id, const char *path);
>  int __init integrity_load_cert(const unsigned int id, const char *source=
,
>  			       const void *data, size_t len, key_perm_t perm);
> +struct key *integrity_keyring_from_id(const unsigned int id);
>  #else
> =20
>  static inline int integrity_digsig_verify(const unsigned int id,
> @@ -194,6 +195,11 @@ static inline int __init integrity_load_cert(const u=
nsigned int id,
>  {
>  	return 0;
>  }
> +
> +static inline struct key *integrity_keyring_from_id(const unsigned int i=
d)
> +{
> +	return ERR_PTR(-EOPNOTSUPP);
> +}
>  #endif /* CONFIG_INTEGRITY_SIGNATURE */
> =20
>  #ifdef CONFIG_INTEGRITY_ASYMMETRIC_KEYS
> diff --git a/security/integrity/platform_certs/platform_cert.S b/security=
/integrity/platform_certs/platform_cert.S
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
> diff --git a/security/integrity/platform_certs/platform_keyring.c b/secur=
ity/integrity/platform_certs/platform_keyring.c
> index bcafd7387729..b45de142c5f5 100644
> --- a/security/integrity/platform_certs/platform_keyring.c
> +++ b/security/integrity/platform_certs/platform_keyring.c
> @@ -12,8 +12,12 @@
>  #include <linux/cred.h>
>  #include <linux/err.h>
>  #include <linux/slab.h>
> +#include <keys/system_keyring.h>
>  #include "../integrity.h"
> =20
> +extern __initconst const u8 platform_certificate_list[];
> +extern __initconst const unsigned long platform_certificate_list_size;
> +
>  /**
>   * add_to_platform_keyring - Add to platform keyring without validation.
>   * @source: Source of key
> @@ -37,6 +41,28 @@ void __init add_to_platform_keyring(const char *source=
, const void *data,
>  		pr_info("Error adding keys to platform keyring %s\n", source);
>  }
> =20
> +static __init int load_platform_certificate_list(void)
> +{
> +	const u8 *p;
> +	unsigned long size;
> +	int rc;
> +	struct key *keyring;
> +
> +	p =3D platform_certificate_list;
> +	size =3D platform_certificate_list_size;
> +
> +	keyring =3D integrity_keyring_from_id(INTEGRITY_KEYRING_PLATFORM);
> +	if (IS_ERR(keyring))
> +		return PTR_ERR(keyring);
> +
> +	rc =3D load_certificate_list(p, size, keyring);
> +	if (rc)
> +		pr_info("Error adding keys to platform keyring %d\n", rc);
> +
> +	return rc;
> +}
> +late_initcall(load_platform_certificate_list);
> +
>  /*
>   * Create the trusted keyrings.
>   */

/Jarkko
