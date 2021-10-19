Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84E1B433E59
	for <lists+linux-integrity@lfdr.de>; Tue, 19 Oct 2021 20:25:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232130AbhJSS1b (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 19 Oct 2021 14:27:31 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:39554 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231586AbhJSS1a (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 19 Oct 2021 14:27:30 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19JIHRE5018617;
        Tue, 19 Oct 2021 14:25:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=M6GVvsIf3qN4dj2myIsyGfbr4+Ejb3EOJABWRJpxkgE=;
 b=FAWWuSbSRuK4WegqwSgFSxFqpLdmZeS+YEBWEto6UFp8ygJbL7Gs+uBalb6B2qSGZbk1
 j5z1d6dQ60uVsy3qJMxJSeJcKIaQppvh0f2K19+8qRmIg8tAVLEHuVLb5Ks31J8CxRN4
 ST0BPP02WRc5upbjmYuWFVKkdIZ9Eq+k0ebvxDptu9pYljxI1u+P9Orx6pDWMc+KWa9C
 i7EZy7MSy3Bc2Ccfn1Xd5sEIaR0s5zJW1dMjGkoq79kvWPkAhaQ+PomYtdSxaGABtJ4R
 T8YvtlhFUvdiyIAzVxtg7zVH+ahWD960wJC9LL4Bw1tYBPGOBpSoMM3XOnmnMu1BUxsc oA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3bt35w05af-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 19 Oct 2021 14:25:11 -0400
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 19JIITF6025076;
        Tue, 19 Oct 2021 14:25:11 -0400
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com [169.47.144.26])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3bt35w05a5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 19 Oct 2021 14:25:10 -0400
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
        by ppma04wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 19JIHMbt019154;
        Tue, 19 Oct 2021 18:25:10 GMT
Received: from b03cxnp07027.gho.boulder.ibm.com (b03cxnp07027.gho.boulder.ibm.com [9.17.130.14])
        by ppma04wdc.us.ibm.com with ESMTP id 3bqpcb475x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 19 Oct 2021 18:25:10 +0000
Received: from b03ledav001.gho.boulder.ibm.com (b03ledav001.gho.boulder.ibm.com [9.17.130.232])
        by b03cxnp07027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 19JIP8Ud37093756
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Oct 2021 18:25:08 GMT
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C57BB6E05E;
        Tue, 19 Oct 2021 18:25:08 +0000 (GMT)
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1490C6E050;
        Tue, 19 Oct 2021 18:25:07 +0000 (GMT)
Received: from li-4b5937cc-25c4-11b2-a85c-cea3a66903e4.ibm.com (unknown [9.163.2.170])
        by b03ledav001.gho.boulder.ibm.com (Postfix) with ESMTP;
        Tue, 19 Oct 2021 18:25:07 +0000 (GMT)
Subject: Re: [PATCH v3] integrity: support including firmware ".platform" keys
 at build time
To:     linux-integrity@vger.kernel.org, keyrings@vger.kernel.org
Cc:     dhowells@redhat.com, zohar@linux.ibm.com, jarkko@kernel.org,
        seth.forshee@canonical.com, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>,
        Nayna Jain <nayna@linux.ibm.com>
References: <20211004145258.14056-1-nayna@linux.ibm.com>
From:   Nayna <nayna@linux.vnet.ibm.com>
Message-ID: <03ed8621-8fd0-a83f-24f6-eb9455dc0ca5@linux.vnet.ibm.com>
Date:   Tue, 19 Oct 2021 14:25:07 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <20211004145258.14056-1-nayna@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: EKMqZN0Ex_MEehf1qyWJbiwx-agbdbye
X-Proofpoint-ORIG-GUID: iyqZnYveBQ4VthIu6pO3G5av42t-enlc
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-19_02,2021-10-19_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 lowpriorityscore=0 impostorscore=0 spamscore=0
 malwarescore=0 phishscore=0 adultscore=0 clxscore=1011 mlxscore=0
 mlxlogscore=999 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2109230001 definitions=main-2110190105
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Gentle reminder for v3. Is this version good now for acceptance ?

Thanks & Regards,

      - Nayna

On 10/4/21 10:52 AM, Nayna Jain wrote:
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
> v3:
> * Included Jarkko's feedback
>   ** updated patch description to include approach.
>   ** removed extern for function declaration in the .h file.
> * Included load_certificate_list() within #ifdef CONFIG_KEYS condition.
>
> v2:
> * Fixed the error reported by kernel test robot
> * Updated patch description based on Jarkko's feedback.
>
>   certs/Makefile                                |  3 ++-
>   certs/blacklist.c                             |  1 -
>   certs/common.c                                |  2 +-
>   certs/common.h                                |  9 -------
>   certs/system_keyring.c                        |  1 -
>   include/keys/system_keyring.h                 |  6 +++++
>   security/integrity/Kconfig                    | 10 +++++++
>   security/integrity/Makefile                   | 17 +++++++++++-
>   security/integrity/digsig.c                   |  2 +-
>   security/integrity/integrity.h                |  6 +++++
>   .../integrity/platform_certs/platform_cert.S  | 23 ++++++++++++++++
>   .../platform_certs/platform_keyring.c         | 26 +++++++++++++++++++
>   12 files changed, 91 insertions(+), 15 deletions(-)
>   delete mode 100644 certs/common.h
>   create mode 100644 security/integrity/platform_certs/platform_cert.S
>
> diff --git a/certs/Makefile b/certs/Makefile
> index 279433783b10..64ee37f38b85 100644
> --- a/certs/Makefile
> +++ b/certs/Makefile
> @@ -3,7 +3,8 @@
>   # Makefile for the linux kernel signature checking certificates.
>   #
>   
> -obj-$(CONFIG_SYSTEM_TRUSTED_KEYRING) += system_keyring.o system_certificates.o common.o
> +obj-$(CONFIG_KEYS) += common.o
> +obj-$(CONFIG_SYSTEM_TRUSTED_KEYRING) += system_keyring.o system_certificates.o
>   obj-$(CONFIG_SYSTEM_BLACKLIST_KEYRING) += blacklist.o common.o
>   obj-$(CONFIG_SYSTEM_REVOCATION_LIST) += revocation_certificates.o
>   ifneq ($(CONFIG_SYSTEM_BLACKLIST_HASH_LIST),"")
> diff --git a/certs/blacklist.c b/certs/blacklist.c
> index c9a435b15af4..b95e9b19c42f 100644
> --- a/certs/blacklist.c
> +++ b/certs/blacklist.c
> @@ -17,7 +17,6 @@
>   #include <linux/uidgid.h>
>   #include <keys/system_keyring.h>
>   #include "blacklist.h"
> -#include "common.h"
>   
>   static struct key *blacklist_keyring;
>   
> diff --git a/certs/common.c b/certs/common.c
> index 16a220887a53..41f763415a00 100644
> --- a/certs/common.c
> +++ b/certs/common.c
> @@ -2,7 +2,7 @@
>   
>   #include <linux/kernel.h>
>   #include <linux/key.h>
> -#include "common.h"
> +#include <keys/system_keyring.h>
>   
>   int load_certificate_list(const u8 cert_list[],
>   			  const unsigned long list_size,
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
>   #include <keys/asymmetric-type.h>
>   #include <keys/system_keyring.h>
>   #include <crypto/pkcs7.h>
> -#include "common.h"
>   
>   static struct key *builtin_trusted_keys;
>   #ifdef CONFIG_SECONDARY_TRUSTED_KEYRING
> diff --git a/include/keys/system_keyring.h b/include/keys/system_keyring.h
> index 6acd3cf13a18..d3f914d9a632 100644
> --- a/include/keys/system_keyring.h
> +++ b/include/keys/system_keyring.h
> @@ -10,6 +10,12 @@
>   
>   #include <linux/key.h>
>   
> +#ifdef CONFIG_KEYS
> +int load_certificate_list(const u8 cert_list[],
> +			  const unsigned long list_size,
> +			  const struct key *keyring);
> +#endif
> +
>   #ifdef CONFIG_SYSTEM_TRUSTED_KEYRING
>   
>   extern int restrict_link_by_builtin_trusted(struct key *keyring,
> diff --git a/security/integrity/Kconfig b/security/integrity/Kconfig
> index 71f0177e8716..b2009b792882 100644
> --- a/security/integrity/Kconfig
> +++ b/security/integrity/Kconfig
> @@ -62,6 +62,16 @@ config INTEGRITY_PLATFORM_KEYRING
>            provided by the platform for verifying the kexec'ed kerned image
>            and, possibly, the initramfs signature.
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
>   config LOAD_UEFI_KEYS
>          depends on INTEGRITY_PLATFORM_KEYRING
>          depends on EFI
> diff --git a/security/integrity/Makefile b/security/integrity/Makefile
> index 7ee39d66cf16..a45f083589b8 100644
> --- a/security/integrity/Makefile
> +++ b/security/integrity/Makefile
> @@ -3,13 +3,18 @@
>   # Makefile for caching inode integrity data (iint)
>   #
>   
> +quiet_cmd_extract_certs  = EXTRACT_CERTS   $(patsubst "%",%,$(2))
> +      cmd_extract_certs  = scripts/extract-cert $(2) $@
> +$(eval $(call config_filename,INTEGRITY_PLATFORM_BUILTIN_KEYS))
> +
>   obj-$(CONFIG_INTEGRITY) += integrity.o
>   
>   integrity-y := iint.o
>   integrity-$(CONFIG_INTEGRITY_AUDIT) += integrity_audit.o
>   integrity-$(CONFIG_INTEGRITY_SIGNATURE) += digsig.o
>   integrity-$(CONFIG_INTEGRITY_ASYMMETRIC_KEYS) += digsig_asymmetric.o
> -integrity-$(CONFIG_INTEGRITY_PLATFORM_KEYRING) += platform_certs/platform_keyring.o
> +integrity-$(CONFIG_INTEGRITY_PLATFORM_KEYRING) += platform_certs/platform_keyring.o \
> +						  platform_certs/platform_cert.o
>   integrity-$(CONFIG_LOAD_UEFI_KEYS) += platform_certs/efi_parser.o \
>   				      platform_certs/load_uefi.o \
>   				      platform_certs/keyring_handler.o
> @@ -19,3 +24,13 @@ integrity-$(CONFIG_LOAD_PPC_KEYS) += platform_certs/efi_parser.o \
>                                        platform_certs/keyring_handler.o
>   obj-$(CONFIG_IMA)			+= ima/
>   obj-$(CONFIG_EVM)			+= evm/
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
>   #define restrict_link_to_ima restrict_link_by_builtin_trusted
>   #endif
>   
> -static struct key *integrity_keyring_from_id(const unsigned int id)
> +struct key *integrity_keyring_from_id(const unsigned int id)
>   {
>   	if (id >= INTEGRITY_KEYRING_MAX)
>   		return ERR_PTR(-EINVAL);
> diff --git a/security/integrity/integrity.h b/security/integrity/integrity.h
> index 547425c20e11..feb84e1b1105 100644
> --- a/security/integrity/integrity.h
> +++ b/security/integrity/integrity.h
> @@ -167,6 +167,7 @@ int __init integrity_init_keyring(const unsigned int id);
>   int __init integrity_load_x509(const unsigned int id, const char *path);
>   int __init integrity_load_cert(const unsigned int id, const char *source,
>   			       const void *data, size_t len, key_perm_t perm);
> +struct key *integrity_keyring_from_id(const unsigned int id);
>   #else
>   
>   static inline int integrity_digsig_verify(const unsigned int id,
> @@ -194,6 +195,11 @@ static inline int __init integrity_load_cert(const unsigned int id,
>   {
>   	return 0;
>   }
> +
> +static inline struct key *integrity_keyring_from_id(const unsigned int id)
> +{
> +	return ERR_PTR(-EOPNOTSUPP);
> +}
>   #endif /* CONFIG_INTEGRITY_SIGNATURE */
>   
>   #ifdef CONFIG_INTEGRITY_ASYMMETRIC_KEYS
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
> index bcafd7387729..17535050d08d 100644
> --- a/security/integrity/platform_certs/platform_keyring.c
> +++ b/security/integrity/platform_certs/platform_keyring.c
> @@ -12,8 +12,12 @@
>   #include <linux/cred.h>
>   #include <linux/err.h>
>   #include <linux/slab.h>
> +#include <keys/system_keyring.h>
>   #include "../integrity.h"
>   
> +extern __initconst const u8 platform_certificate_list[];
> +extern __initconst const unsigned long platform_certificate_list_size;
> +
>   /**
>    * add_to_platform_keyring - Add to platform keyring without validation.
>    * @source: Source of key
> @@ -37,6 +41,28 @@ void __init add_to_platform_keyring(const char *source, const void *data,
>   		pr_info("Error adding keys to platform keyring %s\n", source);
>   }
>   
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
>   /*
>    * Create the trusted keyrings.
>    */
