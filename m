Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE36640DD26
	for <lists+linux-integrity@lfdr.de>; Thu, 16 Sep 2021 16:46:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237406AbhIPOrs (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 16 Sep 2021 10:47:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:32790 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238711AbhIPOrr (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 16 Sep 2021 10:47:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6415361244;
        Thu, 16 Sep 2021 14:46:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631803586;
        bh=22rxIjv1rE4uFsJEAEsxB7/kV1REJ7s4P+7NA+MQ5W4=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=M26To7GpoyidZEq4IMoswguBpMqd/c7BbfA4As2rCccNv15dLH2bLTWHVo4vJAqvo
         y3mwhmVIVl36DacmAGkddFy8KRnnyf39m03qAYKgnCKFlXVVszimW3feigR1iuL8qx
         eAEUrl1iimFcxLZqRBSNlhNHXXSm/SxJcvcX/GQiuTB/kt6SBsEjq1OiorGGRFOI0S
         THyCEU/7epKJ4gpI3LYulYTMre8eSgVoQ7JuKnhKr5CCyLeFjGJFD2YsHX8xxuHvFp
         6CgaxV3L9lmh31X439vY4R6FddEpn8Em+zEtXgJ18P378ySuIEjLas3lopDROb720A
         Dc8fAYuja1fJw==
Message-ID: <8b8678505d4fe299a2f3a82133d81f41b2c527b7.camel@kernel.org>
Subject: Re: [PATCH v2] integrity: support including firmware ".platform"
 keys at build time
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Nayna Jain <nayna@linux.ibm.com>, linux-integrity@vger.kernel.org,
        keyrings@vger.kernel.org
Cc:     dhowells@redhat.com, zohar@linux.ibm.com,
        seth.forshee@canonical.com, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
Date:   Thu, 16 Sep 2021 17:46:24 +0300
In-Reply-To: <20210916125756.89908-1-nayna@linux.ibm.com>
References: <20210916125756.89908-1-nayna@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 2021-09-16 at 08:57 -0400, Nayna Jain wrote:
> Some firmware support secureboot by embedding static keys to verify the
> Linux kernel during boot. However, these firmware do not expose an
> interface for the kernel to load firmware keys onto ".platform" keyring.
> This would prevent kernel signature verification on kexec. For those
> environments, allow firmware keys to be compiled into the kernel and
> loaded onto the ".platform" keyring.

"allow" means absolutely nothing. Just tell what your patch does,=20
and approach taken. Already the patch description should roughly
give idea what and why of code changes. There's nothing here.

>=20
> Reported-by: kernel test robot <lkp@intel.com>

I don't get this reported-by here.

> Signed-off-by: Nayna Jain <nayna@linux.ibm.com>
> ---
>=20
> v2:
> * Fixed the error reported by kernel test robot
> * Updated patch description based on Jarkko's feedback.
>=20
>  certs/Makefile                                |  3 ++-
>  certs/blacklist.c                             |  1 -
>  certs/common.c                                |  2 +-
>  certs/common.h                                |  9 -------
>  certs/system_keyring.c                        |  1 -
>  include/keys/system_keyring.h                 |  3 +++
>  security/integrity/Kconfig                    | 10 +++++++
>  security/integrity/Makefile                   | 17 +++++++++++-
>  security/integrity/digsig.c                   |  2 +-
>  security/integrity/integrity.h                |  6 +++++
>  .../integrity/platform_certs/platform_cert.S  | 23 ++++++++++++++++
>  .../platform_certs/platform_keyring.c         | 26 +++++++++++++++++++
>  12 files changed, 88 insertions(+), 15 deletions(-)
>  delete mode 100644 certs/common.h
>  create mode 100644 security/integrity/platform_certs/platform_cert.S
>=20
> diff --git a/certs/Makefile b/certs/Makefile
> index 279433783b10..64ee37f38b85 100644
> --- a/certs/Makefile
> +++ b/certs/Makefile
> @@ -3,7 +3,8 @@
>  # Makefile for the linux kernel signature checking certificates.
>  #
> =20
> -obj-$(CONFIG_SYSTEM_TRUSTED_KEYRING) +=3D system_keyring.o system_certif=
icates.o common.o
> +obj-$(CONFIG_KEYS) +=3D common.o
> +obj-$(CONFIG_SYSTEM_TRUSTED_KEYRING) +=3D system_keyring.o system_certif=
icates.o
>  obj-$(CONFIG_SYSTEM_BLACKLIST_KEYRING) +=3D blacklist.o common.o
>  obj-$(CONFIG_SYSTEM_REVOCATION_LIST) +=3D revocation_certificates.o
>  ifneq ($(CONFIG_SYSTEM_BLACKLIST_HASH_LIST),"")
> diff --git a/certs/blacklist.c b/certs/blacklist.c
> index c9a435b15af4..b95e9b19c42f 100644
> --- a/certs/blacklist.c
> +++ b/certs/blacklist.c
> @@ -17,7 +17,6 @@
>  #include <linux/uidgid.h>
>  #include <keys/system_keyring.h>
>  #include "blacklist.h"
> -#include "common.h"
> =20
>  static struct key *blacklist_keyring;
> =20
> diff --git a/certs/common.c b/certs/common.c
> index 16a220887a53..41f763415a00 100644
> --- a/certs/common.c
> +++ b/certs/common.c
> @@ -2,7 +2,7 @@
> =20
>  #include <linux/kernel.h>
>  #include <linux/key.h>
> -#include "common.h"

Why this include is removed?

You should include to your commit message *also* the approach
you are taking. If you export a function, you should mention
it explicitly.

> +#include <keys/system_keyring.h>
> =20
>  int load_certificate_list(const u8 cert_list[],
>  			  const unsigned long list_size,
> diff --git a/certs/common.h b/certs/common.h
> deleted file mode 100644
> index abdb5795936b..000000000000
> --- a/certs/common.h
> +++ /dev/null
> @@ -1,9 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0-or-later */
> -
> -#ifndef _CERT_COMMON_H
> -#define _CERT_COMMON_H
> -
> -int load_certificate_list(const u8 cert_list[], const unsigned long list=
_size,
> -			  const struct key *keyring);
> -
> -#endif
> diff --git a/certs/system_keyring.c b/certs/system_keyring.c
> index 692365dee2bd..d130d5a96e09 100644
> --- a/certs/system_keyring.c
> +++ b/certs/system_keyring.c
> @@ -16,7 +16,6 @@
>  #include <keys/asymmetric-type.h>
>  #include <keys/system_keyring.h>
>  #include <crypto/pkcs7.h>
> -#include "common.h"
> =20
>  static struct key *builtin_trusted_keys;
>  #ifdef CONFIG_SECONDARY_TRUSTED_KEYRING
> diff --git a/include/keys/system_keyring.h b/include/keys/system_keyring.=
h
> index 6acd3cf13a18..842d770b2a46 100644
> --- a/include/keys/system_keyring.h
> +++ b/include/keys/system_keyring.h
> @@ -10,6 +10,9 @@
> =20
>  #include <linux/key.h>
> =20
> +extern int load_certificate_list(const u8 cert_list[],
> +				 const unsigned long list_size,
> +				 const struct key *keyring);

Remove "extern". It's not needed for functions.

>  #ifdef CONFIG_SYSTEM_TRUSTED_KEYRING
> =20
>  extern int restrict_link_by_builtin_trusted(struct key *keyring,
> diff --git a/security/integrity/Kconfig b/security/integrity/Kconfig
> index 71f0177e8716..b2009b792882 100644
> --- a/security/integrity/Kconfig
> +++ b/security/integrity/Kconfig
> @@ -62,6 +62,16 @@ config INTEGRITY_PLATFORM_KEYRING
>           provided by the platform for verifying the kexec'ed kerned imag=
e
>           and, possibly, the initramfs signature.
> =20
> +config INTEGRITY_PLATFORM_BUILTIN_KEYS
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
> index 7ee39d66cf16..a45f083589b8 100644
> --- a/security/integrity/Makefile
> +++ b/security/integrity/Makefile
> @@ -3,13 +3,18 @@
>  # Makefile for caching inode integrity data (iint)
>  #
> =20
> +quiet_cmd_extract_certs  =3D EXTRACT_CERTS   $(patsubst "%",%,$(2))
> +      cmd_extract_certs  =3D scripts/extract-cert $(2) $@
> +$(eval $(call config_filename,INTEGRITY_PLATFORM_BUILTIN_KEYS))
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
INTEGRITY_PLATFORM_BUILTIN_KEYS_FILENAME) FORCE
> +	$(call if_changed,extract_certs,$(CONFIG_INTEGRITY_PLATFORM_BUILTIN_KEY=
S))
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
> index bcafd7387729..17535050d08d 100644
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
> +static __init int load_builtin_platform_cert(void)
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
> +late_initcall(load_builtin_platform_cert);
> +
>  /*
>   * Create the trusted keyrings.
>   */


/Jarkko

