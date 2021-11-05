Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE971446497
	for <lists+linux-integrity@lfdr.de>; Fri,  5 Nov 2021 15:05:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233052AbhKEOIG (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 5 Nov 2021 10:08:06 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:47800
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232753AbhKEOIF (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 5 Nov 2021 10:08:05 -0400
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com [209.85.208.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 3FA413F4BA
        for <linux-integrity@vger.kernel.org>; Fri,  5 Nov 2021 14:05:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1636121122;
        bh=CSGVzne6nEVrrdYkYe9odL+tYVCKVWjj9rAAFICz7Ow=;
        h=Message-ID:Date:MIME-Version:To:Cc:References:From:Subject:
         In-Reply-To:Content-Type;
        b=OsHf1bvVljsZk9d0HOZ6ckKubNIZPyOcJQe057Y8naZfb64uUvDYLr4rB7AeXjYI5
         T5ZGMCHYeV5MkgpulCXzF7mElZ2Xwx1iOqLF+VhjT3hk6oVKTB4zsjtYga2pVICiCW
         SCjjcqI0U2I8JQ0aYFC9lQh2FDtBDXCf+UOvdBjYQNgKDhgGrA3zkjQv45xI9JM6Vh
         wi/dcKBObp0Tst4bE9fP49eO8tjSV7Y9ZJkw6Wk8GT8vzVSREKakzazhHLjhG6bhIU
         8OuXG2gYbdb+KGjhG58a6rCoIrArkWiJdRYPtLr3lG4ZvOYw6JlNiIrqafaeY+A40g
         dSwKwBoqI7NvA==
Received: by mail-ed1-f72.google.com with SMTP id f20-20020a0564021e9400b003e2ad3eae74so8960771edf.5
        for <linux-integrity@vger.kernel.org>; Fri, 05 Nov 2021 07:05:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:subject:in-reply-to
         :content-transfer-encoding;
        bh=CSGVzne6nEVrrdYkYe9odL+tYVCKVWjj9rAAFICz7Ow=;
        b=rmgYhbIYi8n0jGBlNBkqUxQcZHInUrJXMROj2EN7uKuHlleIBXSnjlMdXS4GcicRMv
         OmWD7SYJo24tcj8eqvSUWnIH2SXWruty6WZlYAqlffm3pe1Gz6HopPQk9LOB8n+zREG9
         9LsgdPIT4eLSxFt3X3KRsQucrTQscGobr7SNDSq5NWTNVWXK1zRuSKX78V5x4ABMVTd7
         6pp8pzM3krEjyHOWQvET9ebCYYo6NZ29SBRxi3n4j3+nt5rs/BXehWmq+grlkWD4tCHL
         aMz06+OHVzYO7lsKzTQ1jNjTEfNmEUsU4qhHyKOALQzW4/20RGgPeeI/+GisR+B9gALM
         Ew6A==
X-Gm-Message-State: AOAM532heJQfDXu8EM/muVcQ5PE2cKgYQo+w75F0u8n9KI0Oo8K15tPv
        HWu3Sq32UOGFowYs5vjHAD4Q3b/YQf7RGgQhIUJSHWxLans6OII9Xyb5PqGbQD7AOLB9FAojA4A
        Fb5tPoxyM5AKB3yhb08OLaVl6wZn0j9CToKERv/VKsaA7IQ==
X-Received: by 2002:a17:907:d07:: with SMTP id gn7mr70410775ejc.272.1636121121715;
        Fri, 05 Nov 2021 07:05:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzhzQNZQ3+8dyhBUvypJa4qfu48lMb1hQuX65yB4IdfIPrrrtkrkIxU2IVzJPoS1HoHhMW5ng==
X-Received: by 2002:a17:907:d07:: with SMTP id gn7mr70410736ejc.272.1636121121377;
        Fri, 05 Nov 2021 07:05:21 -0700 (PDT)
Received: from [10.172.193.92] (uk.sesame.canonical.com. [91.189.88.160])
        by smtp.gmail.com with ESMTPSA id sc27sm3906186ejc.125.2021.11.05.07.05.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Nov 2021 07:05:21 -0700 (PDT)
Message-ID: <8d7e1609-f77e-834e-cf40-05e19bbc3dbe@canonical.com>
Date:   Fri, 5 Nov 2021 14:05:19 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Content-Language: en-US
To:     Nayna Jain <nayna@linux.ibm.com>, linux-integrity@vger.kernel.org,
        keyrings@vger.kernel.org
Cc:     dhowells@redhat.com, zohar@linux.ibm.com, jarkko@kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, Seth Forshee <seth@forshee.me>
References: <20211004145258.14056-1-nayna@linux.ibm.com>
From:   Dimitri John Ledkov <dimitri.ledkov@canonical.com>
Subject: Re: [PATCH v3] integrity: support including firmware ".platform" keys
 at build time
In-Reply-To: <20211004145258.14056-1-nayna@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

(Changing Seth's email to personal domain one)

On 04/10/2021 15:52, Nayna Jain wrote:
> Some firmware support secure boot by embedding static keys to verify the
> Linux kernel during boot. However, these firmware do not expose an
> interface for the kernel to load firmware keys onto ".platform" keyring.
> This would prevent kernel signature verification on kexec.
> 
> For these environments, a new function load_builtin_platform_cert() is
> defined to load compiled in certificates onto the ".platform" keyring.
> 
> load_certificate_list() is currently used for parsing compiled in
> certificates to be loaded onto the .builtin or .blacklist keyrings.
> Export load_certificate_list() allowing it to be used for parsing compiled
> in ".platform" keyring certificates as well.
> 
> Reported-by: kernel test robot <lkp@intel.com>(auto build test ERROR)
> Signed-off-by: Nayna Jain <nayna@linux.ibm.com>
> ---
> NOTE: I am wondering if we should split this patch into two:
> (https://lore.kernel.org/linux-integrity/be4bd13d-659d-710d-08b9-1a34a65e5c5d@linux.vnet.ibm.com/).
> I can do so if you also prefer the same. 
>

Yes, i think you should split the patches into refactor & new feature.
It allows one to clearly inspect/validate the no-change refactor, and
separately review the newly added feature with clarity.

Or maybe avoid the refactor all together, see my optional suggestion at
the end.

> v3:
> * Included Jarkko's feedback
>  ** updated patch description to include approach.
>  ** removed extern for function declaration in the .h file.
> * Included load_certificate_list() within #ifdef CONFIG_KEYS condition.
> 
> v2:
> * Fixed the error reported by kernel test robot
> * Updated patch description based on Jarkko's feedback.
> 
>  certs/Makefile                                |  3 ++-
>  certs/blacklist.c                             |  1 -
>  certs/common.c                                |  2 +-
>  certs/common.h                                |  9 -------
>  certs/system_keyring.c                        |  1 -
>  include/keys/system_keyring.h                 |  6 +++++
>  security/integrity/Kconfig                    | 10 +++++++
>  security/integrity/Makefile                   | 17 +++++++++++-
>  security/integrity/digsig.c                   |  2 +-
>  security/integrity/integrity.h                |  6 +++++
>  .../integrity/platform_certs/platform_cert.S  | 23 ++++++++++++++++
>  .../platform_certs/platform_keyring.c         | 26 +++++++++++++++++++
>  12 files changed, 91 insertions(+), 15 deletions(-)
>  delete mode 100644 certs/common.h
>  create mode 100644 security/integrity/platform_certs/platform_cert.S
> 
> diff --git a/certs/Makefile b/certs/Makefile
> index 279433783b10..64ee37f38b85 100644
> --- a/certs/Makefile
> +++ b/certs/Makefile
> @@ -3,7 +3,8 @@
>  # Makefile for the linux kernel signature checking certificates.
>  #
>  
> -obj-$(CONFIG_SYSTEM_TRUSTED_KEYRING) += system_keyring.o system_certificates.o common.o
> +obj-$(CONFIG_KEYS) += common.o
> +obj-$(CONFIG_SYSTEM_TRUSTED_KEYRING) += system_keyring.o system_certificates.o
>  obj-$(CONFIG_SYSTEM_BLACKLIST_KEYRING) += blacklist.o common.o
>  obj-$(CONFIG_SYSTEM_REVOCATION_LIST) += revocation_certificates.o
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
>  
>  static struct key *blacklist_keyring;
>  
> diff --git a/certs/common.c b/certs/common.c
> index 16a220887a53..41f763415a00 100644
> --- a/certs/common.c
> +++ b/certs/common.c
> @@ -2,7 +2,7 @@
>  
>  #include <linux/kernel.h>
>  #include <linux/key.h>
> -#include "common.h"
> +#include <keys/system_keyring.h>
>  
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
> -int load_certificate_list(const u8 cert_list[], const unsigned long list_size,
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
>  
>  static struct key *builtin_trusted_keys;
>  #ifdef CONFIG_SECONDARY_TRUSTED_KEYRING
> diff --git a/include/keys/system_keyring.h b/include/keys/system_keyring.h
> index 6acd3cf13a18..d3f914d9a632 100644
> --- a/include/keys/system_keyring.h
> +++ b/include/keys/system_keyring.h
> @@ -10,6 +10,12 @@
>  
>  #include <linux/key.h>
>  
> +#ifdef CONFIG_KEYS
> +int load_certificate_list(const u8 cert_list[],
> +			  const unsigned long list_size,
> +			  const struct key *keyring);
> +#endif
> +
>  #ifdef CONFIG_SYSTEM_TRUSTED_KEYRING
>  
>  extern int restrict_link_by_builtin_trusted(struct key *keyring,
> diff --git a/security/integrity/Kconfig b/security/integrity/Kconfig
> index 71f0177e8716..b2009b792882 100644
> --- a/security/integrity/Kconfig
> +++ b/security/integrity/Kconfig
> @@ -62,6 +62,16 @@ config INTEGRITY_PLATFORM_KEYRING
>           provided by the platform for verifying the kexec'ed kerned image
>           and, possibly, the initramfs signature.
>  
> +config INTEGRITY_PLATFORM_BUILTIN_KEYS
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
> index 7ee39d66cf16..a45f083589b8 100644
> --- a/security/integrity/Makefile
> +++ b/security/integrity/Makefile
> @@ -3,13 +3,18 @@
>  # Makefile for caching inode integrity data (iint)
>  #
>  
> +quiet_cmd_extract_certs  = EXTRACT_CERTS   $(patsubst "%",%,$(2))
> +      cmd_extract_certs  = scripts/extract-cert $(2) $@
> +$(eval $(call config_filename,INTEGRITY_PLATFORM_BUILTIN_KEYS))
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
> +$(obj)/platform_certs/platform_certificate_list: scripts/extract-cert $(INTEGRITY_PLATFORM_BUILTIN_KEYS_FILENAME) FORCE
> +	$(call if_changed,extract_certs,$(CONFIG_INTEGRITY_PLATFORM_BUILTIN_KEYS))
> +
> +clean-files := platform_certs/platform_certificate_list
> diff --git a/security/integrity/digsig.c b/security/integrity/digsig.c
> index 3b06a01bd0fd..0ea40ed8dfcb 100644
> --- a/security/integrity/digsig.c
> +++ b/security/integrity/digsig.c
> @@ -38,7 +38,7 @@ static const char * const keyring_name[INTEGRITY_KEYRING_MAX] = {
>  #define restrict_link_to_ima restrict_link_by_builtin_trusted
>  #endif
>  
> -static struct key *integrity_keyring_from_id(const unsigned int id)
> +struct key *integrity_keyring_from_id(const unsigned int id)
>  {
>  	if (id >= INTEGRITY_KEYRING_MAX)
>  		return ERR_PTR(-EINVAL);
> diff --git a/security/integrity/integrity.h b/security/integrity/integrity.h
> index 547425c20e11..feb84e1b1105 100644
> --- a/security/integrity/integrity.h
> +++ b/security/integrity/integrity.h
> @@ -167,6 +167,7 @@ int __init integrity_init_keyring(const unsigned int id);
>  int __init integrity_load_x509(const unsigned int id, const char *path);
>  int __init integrity_load_cert(const unsigned int id, const char *source,
>  			       const void *data, size_t len, key_perm_t perm);
> +struct key *integrity_keyring_from_id(const unsigned int id);
>  #else
>  
>  static inline int integrity_digsig_verify(const unsigned int id,
> @@ -194,6 +195,11 @@ static inline int __init integrity_load_cert(const unsigned int id,
>  {
>  	return 0;
>  }
> +
> +static inline struct key *integrity_keyring_from_id(const unsigned int id)
> +{
> +	return ERR_PTR(-EOPNOTSUPP);
> +}
>  #endif /* CONFIG_INTEGRITY_SIGNATURE */
>  
>  #ifdef CONFIG_INTEGRITY_ASYMMETRIC_KEYS
> diff --git a/security/integrity/platform_certs/platform_cert.S b/security/integrity/platform_certs/platform_cert.S
> new file mode 100644
> index 000000000000..20bccce5dc5a
> --- /dev/null
> +++ b/security/integrity/platform_certs/platform_cert.S
> @@ -0,0 +1,23 @@
> +/* SPDX-License-Identifier: GPL-2.0 */

My personal preference would be to have platform_cert.S next to all the
other "extract certs and build an object out of them", as in
/certs/platform_cert.S right next to the other similar .S files, i.e
system_certificates.S and revocation_certificates.S it would make it
easier to inspect the build and find all the various types of built-in keys.

This is a minor comment/suggestion, that you can reject.

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
> index bcafd7387729..17535050d08d 100644
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

I think the below hunk should be guarded with #ifdef
CONFIG_INTEGRITY_PLATFORM_BUILTIN_KEYS, similar to how similar call is
ifdef'ed in case of revocation keys i.e. see ifdef
CONFIG_SYSTEM_REVOCATION_LIST in certs/blacklist.c. Because one can
configure a kernel with a platform keyring, but without platform builtin
keys.

I think this must be be fixed.

> +static __init int load_builtin_platform_cert(void)
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
> +late_initcall(load_builtin_platform_cert);
> +


Some more general comment:
I do wonder if the refactor of load_certificate_list can be somehow
avoided. For example, when platform keyring is allocated it calls
set_platform_trusted_keys() from certs/system-keyring.c which could add
a call to load_builtin_platform_cert, and it already has a handle to the
platform keyring. The set_platform_trusted_keys() could call to
load_certificate_list there without late_initcall, alocating variables,
and looking up the integrity_keyring_from id. It would make this feature
patch very concise and straight forward then.

That way builtin platform certs will be done before platform specific
load_*.c things are done. But also it will make builtin certs loading be
done in a different place from the rest of the platform certs loading
(e.g. the uefi one). So maybe doing builtin certs loading, next to all
other platform cert loading makes sense, despite it being away from
other builtin certs loading into other keyrings.

I am divided on this =)

>  /*
>   * Create the trusted keyrings.
>   */
> 
Regards,

Dimitri.
