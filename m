Return-Path: <linux-integrity+bounces-6204-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3E68AB6C22
	for <lists+linux-integrity@lfdr.de>; Wed, 14 May 2025 15:07:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A53E17ABBB
	for <lists+linux-integrity@lfdr.de>; Wed, 14 May 2025 13:07:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B294727702E;
	Wed, 14 May 2025 13:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="mJmBS7T4"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp-relay-canonical-0.canonical.com (smtp-relay-canonical-0.canonical.com [185.125.188.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E64127A469;
	Wed, 14 May 2025 13:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747227997; cv=none; b=asbk7+5b729gbOiVtos7pB77w7iQTRqR2NNNHGp96su9p/NvWv3YhGDms3uU2Q/iku3YNne9h/jpVAe+nfYZlQ+rlhb7bbyLLGz0w6qdd9F6NuHFstrHOJvlYCXajoMFkC97+/i/j4tuDH+30oMPs9pJoyukUxXwBm2Mj8I88es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747227997; c=relaxed/simple;
	bh=ttsKWBQiDhFn5AW+ppRKPv3ghbT4g74GrIVAH9d5yPI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tBY4HQrma7Q4j2x+wffbz1sBZTN2C7vvp2t1EpSbhJcSNzemRh3ZLFZ6ejhufYCYnIM0kHgPty8ZY2hHOG0PkuHFn20csFLAFH3iRvgK+M1rABsK2QsugzsTMLrrlL1n1yLMPfRyj76vqwINfx6RY6nuhIX4vFUZwb2pTS+kW94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=mJmBS7T4; arc=none smtp.client-ip=185.125.188.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from [172.20.3.254] (unknown [213.157.19.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id EDA263FA5D;
	Wed, 14 May 2025 13:06:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1747227992;
	bh=seFAzSEzE4LptAWFHqQQPXptnMlZvi+VBvbMAFS9z8g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type;
	b=mJmBS7T4KOTbhcX5nt9cvy5gAq6miNQ8Qa/sV+X3Ud8SXDL/FAoYzW4+6Pn1GAr11
	 4b4xKruCXGVXVM9NdEPo5CWyLKpassFQERprd0Ez+EZDakf1CIj6HFKZ5Z/Gl9Yj4P
	 f2f37A6E7+OXEvXKFlM5KM+z1C+tSqE0FRvzDK1TEbxNIuwf3AyAdiNGRJBOaCMZSM
	 jdqDbVDPM/2gOU5in/bqGYPp2KGnoRNLlanv9wqou2YKBTXbq54WmH0h3L72QJShnE
	 cKh0RX0OzMjQbeCfkrGH8vUu94fMhNQttfqvWr9Bn7Ze4hT5Wk7sPbSOhw31nxdXcq
	 +baCUsQEwam3Q==
Message-ID: <5cfa9bca-27e4-4012-b152-90eb8435f0e9@canonical.com>
Date: Wed, 14 May 2025 06:06:30 -0700
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 25/29] ima,evm: move initcalls to the LSM framework
To: Paul Moore <paul@paul-moore.com>, linux-security-module@vger.kernel.org,
 linux-integrity@vger.kernel.org, selinux@vger.kernel.org
Cc: Mimi Zohar <zohar@linux.ibm.com>, Roberto Sassu
 <roberto.sassu@huawei.com>, Fan Wu <wufan@kernel.org>,
 =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
 =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>,
 Kees Cook <kees@kernel.org>, Micah Morton <mortonm@chromium.org>,
 Casey Schaufler <casey@schaufler-ca.com>,
 Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
References: <20250409185019.238841-31-paul@paul-moore.com>
 <20250409185019.238841-56-paul@paul-moore.com>
Content-Language: en-US
From: John Johansen <john.johansen@canonical.com>
Autocrypt: addr=john.johansen@canonical.com; keydata=
 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 lT9Q
Organization: Canonical
In-Reply-To: <20250409185019.238841-56-paul@paul-moore.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 4/9/25 11:50, Paul Moore wrote:
> This patch converts IMA and EVM to use the LSM frameworks's initcall
> mechanism.  There were two challenges to doing this conversion: the
> first simply being the number of initcalls across IMA and EVM, and the
> second was the number of resources shared between the two related,
> yet independent LSMs.
> 
> The first problem was resolved by the creation of two new functions,
> integrity_device_init() and integrity_late_init(), with each focused on
> calling all of the various IMA/EVM initcalls for a single initcall type.
> The second problem was resolved by registering both of these new
> functions as initcalls for each LSM and including code in each
> registered initcall to ensure it only executes once.
> 
> Signed-off-by: Paul Moore <paul@paul-moore.com>
> ---
>   security/integrity/Makefile                   |  2 +-
>   security/integrity/evm/evm_main.c             |  7 +-
>   security/integrity/iint.c                     |  4 +-
>   security/integrity/ima/ima_main.c             |  7 +-
>   security/integrity/ima/ima_mok.c              |  4 +-
>   security/integrity/initcalls.c                | 97 +++++++++++++++++++
>   security/integrity/initcalls.h                | 23 +++++
>   .../integrity/platform_certs/load_ipl_s390.c  |  4 +-
>   .../integrity/platform_certs/load_powerpc.c   |  4 +-
>   security/integrity/platform_certs/load_uefi.c |  4 +-
>   .../platform_certs/machine_keyring.c          |  4 +-
>   .../platform_certs/platform_keyring.c         | 14 ++-
>   12 files changed, 147 insertions(+), 27 deletions(-)
>   create mode 100644 security/integrity/initcalls.c
>   create mode 100644 security/integrity/initcalls.h
> 
> diff --git a/security/integrity/Makefile b/security/integrity/Makefile
> index 92b63039c654..6ea330ea88b1 100644
> --- a/security/integrity/Makefile
> +++ b/security/integrity/Makefile
> @@ -5,7 +5,7 @@
>   
>   obj-$(CONFIG_INTEGRITY) += integrity.o
>   
> -integrity-y := iint.o
> +integrity-y := iint.o initcalls.o
>   integrity-$(CONFIG_INTEGRITY_AUDIT) += integrity_audit.o
>   integrity-$(CONFIG_INTEGRITY_SIGNATURE) += digsig.o
>   integrity-$(CONFIG_INTEGRITY_ASYMMETRIC_KEYS) += digsig_asymmetric.o
> diff --git a/security/integrity/evm/evm_main.c b/security/integrity/evm/evm_main.c
> index db8e324ed4e6..770d0411da2b 100644
> --- a/security/integrity/evm/evm_main.c
> +++ b/security/integrity/evm/evm_main.c
> @@ -25,6 +25,7 @@
>   #include <crypto/hash.h>
>   #include <crypto/hash_info.h>
>   #include <crypto/utils.h>
> +#include "../initcalls.h"
>   #include "evm.h"
>   
>   int evm_initialized;
> @@ -1112,7 +1113,7 @@ void __init evm_load_x509(void)
>   }
>   #endif
>   
> -static int __init init_evm(void)
> +int __init init_evm(void)
>   {
>   	int error;
>   	struct list_head *pos, *q;
> @@ -1179,6 +1180,6 @@ DEFINE_LSM(evm) = {
>   	.init = init_evm_lsm,
>   	.order = LSM_ORDER_LAST,
>   	.blobs = &evm_blob_sizes,
> +	.initcall_device = integrity_device_init,
> +	.initcall_late = integrity_late_init,
>   };
> -
> -late_initcall(init_evm);
> diff --git a/security/integrity/iint.c b/security/integrity/iint.c
> index 068ac6c2ae1e..a4b88d67ff43 100644
> --- a/security/integrity/iint.c
> +++ b/security/integrity/iint.c
> @@ -11,6 +11,7 @@
>    */
>   #include <linux/security.h>
>   #include "integrity.h"
> +#include "initcalls.h"
>   
>   struct dentry *integrity_dir;
>   
> @@ -42,7 +43,7 @@ void __init integrity_load_keys(void)
>   		evm_load_x509();
>   }
>   
> -static int __init integrity_fs_init(void)
> +int __init integrity_fs_init(void)
>   {
>   	integrity_dir = securityfs_create_dir("integrity", NULL);
>   	if (IS_ERR(integrity_dir)) {
> @@ -58,4 +59,3 @@ static int __init integrity_fs_init(void)
>   	return 0;
>   }
>   
> -late_initcall(integrity_fs_init)
> diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
> index 55a4f08a2565..1687badafb48 100644
> --- a/security/integrity/ima/ima_main.c
> +++ b/security/integrity/ima/ima_main.c
> @@ -27,6 +27,7 @@
>   #include <linux/fs.h>
>   #include <linux/iversion.h>
>   #include <linux/evm.h>
> +#include "../initcalls.h"
>   
>   #include "ima.h"
>   
> @@ -1180,7 +1181,7 @@ static int ima_kernel_module_request(char *kmod_name)
>   
>   #endif /* CONFIG_INTEGRITY_ASYMMETRIC_KEYS */
>   
> -static int __init init_ima(void)
> +int __init init_ima(void)
>   {
>   	int error;
>   
> @@ -1255,6 +1256,6 @@ DEFINE_LSM(ima) = {
>   	.init = init_ima_lsm,
>   	.order = LSM_ORDER_LAST,
>   	.blobs = &ima_blob_sizes,
> +	.initcall_device = integrity_device_init,
> +	.initcall_late = integrity_late_init,
>   };
> -
> -late_initcall(init_ima);	/* Start IMA after the TPM is available */
> diff --git a/security/integrity/ima/ima_mok.c b/security/integrity/ima/ima_mok.c
> index 95cc31525c57..4374fb6cc66d 100644
> --- a/security/integrity/ima/ima_mok.c
> +++ b/security/integrity/ima/ima_mok.c
> @@ -14,6 +14,7 @@
>   #include <linux/init.h>
>   #include <linux/slab.h>
>   #include <keys/system_keyring.h>
> +#include "../initcalls.h"
>   
>   
>   struct key *ima_blacklist_keyring;
> @@ -21,7 +22,7 @@ struct key *ima_blacklist_keyring;
>   /*
>    * Allocate the IMA blacklist keyring
>    */
> -static __init int ima_mok_init(void)
> +int __init ima_mok_init(void)
>   {
>   	struct key_restriction *restriction;
>   
> @@ -46,4 +47,3 @@ static __init int ima_mok_init(void)
>   		panic("Can't allocate IMA blacklist keyring.");
>   	return 0;
>   }
> -device_initcall(ima_mok_init);
> diff --git a/security/integrity/initcalls.c b/security/integrity/initcalls.c
> new file mode 100644
> index 000000000000..de39754a1c2c
> --- /dev/null
> +++ b/security/integrity/initcalls.c
> @@ -0,0 +1,97 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Platform certificate / keyring initcalls
> + *
> + */
> +
> +#include <linux/init.h>
> +
> +#include "initcalls.h"
> +
> +/**
> + * integrity_device_init - device_initcalls for IMA/EVM
> + *
> + * This helper function wraps all of the device_initcalls for both IMA and EVM.
> + * It can be called multiple times, e.g. once from IMA and once from EVM,
> + * without problem as it maintains an internal static state variable which
> + * ensures that any setup/initialization is only done once.
> + */
> +int __init integrity_device_init(void)
> +{
> +	int rc = 0, rc_tmp;
if none of the below config options are defined then rc_tmp is unused and the build can kick out with

../security/integrity/initcalls.c:21:21: error: unused variable ‘rc_tmp’ [-Werror=unused-variable]


> +	static bool setup = false;
> +
> +	if (setup)
> +		return 0;
> +	setup = true;
> +
> +#if defined(CONFIG_INTEGRITY_PLATFORM_KEYRING)
> +	rc_tmp = platform_keyring_init();
> +	if (!rc && rc_tmp)
> +		rc = rc_tmp;
> +#endif
> +
> +#if defined(CONFIG_INTEGRITY_MACHINE_KEYRING)
> +	rc_tmp = machine_keyring_init();
> +	if (!rc && rc_tmp)
> +		rc = rc_tmp;
> +#endif
> +
> +#if defined(CONFIG_IMA_BLACKLIST_KEYRING)
> +	rc_tmp = ima_mok_init();
> +	if (!rc && rc_tmp)
> +		rc = rc_tmp;
> +#endif
> +
> +	return rc;
> +}
> +
> +/**
> + * integrity_late_init - late_initcalls for IMA/EVM
> + *
> + * This helper function wraps all of the late_initcalls for both IMA and EVM.
> + * It can be called multiple times, e.g. once from IMA and once from EVM,
> + * without problem as it maintains an internal static state variable which
> + * ensures that any setup/initialization is only done once.
> + */
> +int __init integrity_late_init(void)
> +{
> +	int rc = 0, rc_tmp;
> +	static bool setup = false;
> +
> +	if (setup)
> +		return 0;
> +	setup = true;
> +
> +#if defined(CONFIG_LOAD_UEFI_KEYS)
> +	rc_tmp = load_uefi_certs();
> +	if (!rc && rc_tmp)
> +		rc = rc_tmp;
> +#endif
> +
> +#if defined(CONFIG_LOAD_IPL_KEYS)
> +	rc_tmp = load_ipl_certs();
> +	if (!rc && rc_tmp)
> +		rc = rc_tmp;
> +#endif
> +
> +#if defined(CONFIG_LOAD_PPC_KEYS)
> +	rc_tmp = load_powerpc_certs();
> +	if (!rc && rc_tmp)
> +		rc = rc_tmp;
> +#endif
> +
> +	rc_tmp = integrity_fs_init();
> +	if (!rc && rc_tmp)
> +		rc = rc_tmp;
> +
> +	rc_tmp = init_ima();
> +	if (!rc && rc_tmp)
> +		rc = rc_tmp;
> +
> +	rc_tmp = init_evm();
> +	if (!rc && rc_tmp)
> +		rc = rc_tmp;
> +
> +	return rc;
> +}
> diff --git a/security/integrity/initcalls.h b/security/integrity/initcalls.h
> new file mode 100644
> index 000000000000..dce16abb3b8a
> --- /dev/null
> +++ b/security/integrity/initcalls.h
> @@ -0,0 +1,23 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +#ifndef PLATFORM_CERTS_INITCALLS_H
> +#define PLATFORM_CERTS_INITCALLS_H
> +
> +int machine_keyring_init(void);
> +int platform_keyring_init(void);
> +
> +int load_uefi_certs(void);
> +int load_ipl_certs(void);
> +int load_powerpc_certs(void);
> +
> +int integrity_fs_init(void);
> +
> +int init_ima(void);
> +int init_evm(void);
> +
> +int ima_mok_init(void);
> +
> +int integrity_device_init(void);
> +int integrity_late_init(void);
> +
> +#endif
> diff --git a/security/integrity/platform_certs/load_ipl_s390.c b/security/integrity/platform_certs/load_ipl_s390.c
> index c7c381a9ddaa..3bf91d925614 100644
> --- a/security/integrity/platform_certs/load_ipl_s390.c
> +++ b/security/integrity/platform_certs/load_ipl_s390.c
> @@ -10,12 +10,13 @@
>   #include <keys/system_keyring.h>
>   #include <asm/boot_data.h>
>   #include "../integrity.h"
> +#include "../initcalls.h"
>   
>   /*
>    * Load the certs contained in the IPL report created by the machine loader
>    * into the platform trusted keyring.
>    */
> -static int __init load_ipl_certs(void)
> +int __init load_ipl_certs(void)
>   {
>   	void *ptr, *end;
>   	unsigned int len;
> @@ -33,4 +34,3 @@ static int __init load_ipl_certs(void)
>   	}
>   	return 0;
>   }
> -late_initcall(load_ipl_certs);
> diff --git a/security/integrity/platform_certs/load_powerpc.c b/security/integrity/platform_certs/load_powerpc.c
> index c85febca3343..2904559e485b 100644
> --- a/security/integrity/platform_certs/load_powerpc.c
> +++ b/security/integrity/platform_certs/load_powerpc.c
> @@ -14,6 +14,7 @@
>   #include <asm/secvar.h>
>   #include "keyring_handler.h"
>   #include "../integrity.h"
> +#include "../initcalls.h"
>   
>   #define extract_esl(db, data, size, offset)	\
>   	do { db = data + offset; size = size - offset; } while (0)
> @@ -56,7 +57,7 @@ static __init void *get_cert_list(u8 *key, unsigned long keylen, u64 *size)
>    * keyring and the blacklisted X.509 cert SHA256 hashes into the blacklist
>    * keyring.
>    */
> -static int __init load_powerpc_certs(void)
> +int __init load_powerpc_certs(void)
>   {
>   	void *db = NULL, *dbx = NULL, *data = NULL;
>   	void *trustedca;
> @@ -156,4 +157,3 @@ static int __init load_powerpc_certs(void)
>   
>   	return rc;
>   }
> -late_initcall(load_powerpc_certs);
> diff --git a/security/integrity/platform_certs/load_uefi.c b/security/integrity/platform_certs/load_uefi.c
> index d1fdd113450a..52c180704674 100644
> --- a/security/integrity/platform_certs/load_uefi.c
> +++ b/security/integrity/platform_certs/load_uefi.c
> @@ -12,6 +12,7 @@
>   #include <keys/system_keyring.h>
>   #include "../integrity.h"
>   #include "keyring_handler.h"
> +#include "../initcalls.h"
>   
>   /*
>    * On T2 Macs reading the db and dbx efi variables to load UEFI Secure Boot
> @@ -157,7 +158,7 @@ static int __init load_moklist_certs(void)
>    * keyring and the UEFI blacklisted X.509 cert SHA256 hashes into the blacklist
>    * keyring.
>    */
> -static int __init load_uefi_certs(void)
> +int __init load_uefi_certs(void)
>   {
>   	efi_guid_t secure_var = EFI_IMAGE_SECURITY_DATABASE_GUID;
>   	efi_guid_t mok_var = EFI_SHIM_LOCK_GUID;
> @@ -235,4 +236,3 @@ static int __init load_uefi_certs(void)
>   
>   	return rc;
>   }
> -late_initcall(load_uefi_certs);
> diff --git a/security/integrity/platform_certs/machine_keyring.c b/security/integrity/platform_certs/machine_keyring.c
> index a401640a63cd..b49eb2bab7a2 100644
> --- a/security/integrity/platform_certs/machine_keyring.c
> +++ b/security/integrity/platform_certs/machine_keyring.c
> @@ -7,8 +7,9 @@
>   
>   #include <linux/efi.h>
>   #include "../integrity.h"
> +#include "../initcalls.h"
>   
> -static __init int machine_keyring_init(void)
> +int __init machine_keyring_init(void)
>   {
>   	int rc;
>   
> @@ -19,7 +20,6 @@ static __init int machine_keyring_init(void)
>   	pr_notice("Machine keyring initialized\n");
>   	return 0;
>   }
> -device_initcall(machine_keyring_init);
>   
>   void __init add_to_machine_keyring(const char *source, const void *data, size_t len)
>   {
> diff --git a/security/integrity/platform_certs/platform_keyring.c b/security/integrity/platform_certs/platform_keyring.c
> index bcafd7387729..84a8e4309f06 100644
> --- a/security/integrity/platform_certs/platform_keyring.c
> +++ b/security/integrity/platform_certs/platform_keyring.c
> @@ -13,6 +13,7 @@
>   #include <linux/err.h>
>   #include <linux/slab.h>
>   #include "../integrity.h"
> +#include "../initcalls.h"
>   
>   /**
>    * add_to_platform_keyring - Add to platform keyring without validation.
> @@ -37,10 +38,12 @@ void __init add_to_platform_keyring(const char *source, const void *data,
>   		pr_info("Error adding keys to platform keyring %s\n", source);
>   }
>   
> -/*
> - * Create the trusted keyrings.
> +/**
> + * platform_keyring_init - Create the trusted keyrings.
> + *
> + * Must be initialised before we try and load the keys into the keyring.
>    */
> -static __init int platform_keyring_init(void)
> +int __init platform_keyring_init(void)
>   {
>   	int rc;
>   
> @@ -51,8 +54,3 @@ static __init int platform_keyring_init(void)
>   	pr_notice("Platform Keyring initialized\n");
>   	return 0;
>   }
> -
> -/*
> - * Must be initialised before we try and load the keys into the keyring.
> - */
> -device_initcall(platform_keyring_init);


