Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9B99FA5DB6
	for <lists+linux-integrity@lfdr.de>; Tue,  3 Sep 2019 00:04:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727384AbfIBWEq (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 2 Sep 2019 18:04:46 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:42538 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726933AbfIBWEq (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 2 Sep 2019 18:04:46 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x82M1wX0045873
        for <linux-integrity@vger.kernel.org>; Mon, 2 Sep 2019 18:04:45 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2us9tbtc4w-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Mon, 02 Sep 2019 18:04:45 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Mon, 2 Sep 2019 23:04:42 +0100
Received: from b06avi18626390.portsmouth.uk.ibm.com (9.149.26.192)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 2 Sep 2019 23:04:39 +0100
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x82M4Fe725297256
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 2 Sep 2019 22:04:15 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CFFF9A405B;
        Mon,  2 Sep 2019 22:04:38 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CA111A4065;
        Mon,  2 Sep 2019 22:04:37 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.185.123])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon,  2 Sep 2019 22:04:37 +0000 (GMT)
Subject: Re: [PATCH 1/1] KEYS: Measure keys in trusted keyring
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        linux-integrity@vger.kernel.org
Cc:     jamorris@linux.microsoft.com, sashal@kernel.org,
        kgoldman@us.ibm.com
Date:   Mon, 02 Sep 2019 18:04:36 -0400
In-Reply-To: <20190828002735.31025-2-nramas@linux.microsoft.com>
References: <20190828002735.31025-1-nramas@linux.microsoft.com>
         <20190828002735.31025-2-nramas@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19090222-0028-0000-0000-00000396D31F
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19090222-0029-0000-0000-000024591E43
Message-Id: <1567461876.10024.338.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-09-02_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1909020248
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 2019-08-27 at 17:27 -0700, Lakshmi Ramasubramanian wrote:
> Measure keys in the trusted keyring. If CONFIG_SECONDARY_TRUSTED_KEYRING
> is enabled then the trusted keys keyring is secondary_trusted_keys.
> Otherwise, the trusted keys keyring is builtin_trusted_keys.
> 
> This measurement is in addition to IMA measuring module\file
> signature. It adds more information for attestation service
> to validate the client has known good keys in the trusted
> keyring.
> 
> Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>

IMA measures, appraises, and audits files based on policy[1].  If
you're going to measure keys, all of the code should be within the IMA
subdirectory.  The only code outside of the IMA subdirectory is either
an LSM or IMA hook.  If an LSM hook already exists, use it.  If an LSM
hook doesn't exist and the location is generic that other LSMs would
be interested, define a new LSM hook, otherwise define a new IMA hook.

For example, to measure /boot/cmdline, the rule is "measure
func=KEXEC_CMDLINE template=ima-buf".  A similar rule for measuring
keys would look something like "measure func=KEYS template=ima-buf
pcr=<number>".

Remember "ifdef's" don't belong in C code[2].  Normally a stub
function is defined in an include file to avoid ifdefs.

Mimi

[1] Documentation/ABI/testing/ima_policy
[2] Refer to Documentation/process/coding-style.rst section "21)
Conditional Compilation".


> ---
>  certs/system_keyring.c            | 15 ++++++
>  include/keys/system_keyring.h     |  4 ++
>  include/linux/key.h               | 21 ++++++++
>  security/integrity/ima/Kconfig    | 14 ++++++
>  security/integrity/ima/ima_init.c | 84 +++++++++++++++++++++++++++++++
>  security/keys/keyring.c           | 63 +++++++++++++++++++++++
>  6 files changed, 201 insertions(+)
> 
> diff --git a/certs/system_keyring.c b/certs/system_keyring.c
> index 1eba08a1af82..221eabee70b4 100644
> --- a/certs/system_keyring.c
> +++ b/certs/system_keyring.c
> @@ -283,3 +283,18 @@ void __init set_platform_trusted_keys(struct key *keyring)
>  	platform_trusted_keys = keyring;
>  }
>  #endif
> +
> +#ifdef CONFIG_IMA_MEASURE_TRUSTED_KEYS
> +struct key *get_trusted_keys(void)
> +{
> +	struct key *trusted_keys;
> +
> +#ifdef CONFIG_SECONDARY_TRUSTED_KEYRING
> +	trusted_keys = secondary_trusted_keys;
> +#else
> +	trusted_keys = builtin_trusted_keys;
> +#endif
> +
> +	return trusted_keys;
> +}
> +#endif /* CONFIG_IMA_MEASURE_TRUSTED_KEYS */
> diff --git a/include/keys/system_keyring.h b/include/keys/system_keyring.h
> index c1a96fdf598b..789782a1d5a9 100644
> --- a/include/keys/system_keyring.h
> +++ b/include/keys/system_keyring.h
> @@ -66,4 +66,8 @@ static inline void set_platform_trusted_keys(struct key *keyring)
>  }
>  #endif
>  
> +#ifdef CONFIG_IMA_MEASURE_TRUSTED_KEYS
> +extern struct key *get_trusted_keys(void);
> +#endif /* CONFIG_IMA_MEASURE_TRUSTED_KEYS */
> +
>  #endif /* _KEYS_SYSTEM_KEYRING_H */
> diff --git a/include/linux/key.h b/include/linux/key.h
> index 50028338a4cc..843198b94677 100644
> --- a/include/linux/key.h
> +++ b/include/linux/key.h
> @@ -408,6 +408,27 @@ extern key_ref_t lookup_user_key(key_serial_t id, unsigned long flags,
>  				 key_perm_t perm);
>  extern void key_free_user_ns(struct user_namespace *);
>  
> +typedef int (*key_iterator_func)(void *key, u32 keylen,
> +				const char *description);
> +
> +/*
> + * Context data used to iterate through the keys in a keyring.
> + *
> + *  size  - Total number of keys in the keyring
> + *  enumerated - Number of keys that have been enumerated so far
> + *  iterator - Pointer to the function called for each key
> + */
> +struct keyring_iterator {
> +	size_t size;
> +	size_t enumerated;
> +	key_iterator_func iterator;
> +};
> +
> +#ifdef CONFIG_IMA_MEASURE_TRUSTED_KEYS
> +extern long keyring_read_trusted_keys(
> +	struct keyring_iterator *key_iterator);
> +#endif /* CONFIG_IMA_MEASURE_TRUSTED_KEYS */
> +
>  /*
>   * The permissions required on a key that we're looking up.
>   */
> diff --git a/security/integrity/ima/Kconfig b/security/integrity/ima/Kconfig
> index 2ced99dde694..f33237da0add 100644
> --- a/security/integrity/ima/Kconfig
> +++ b/security/integrity/ima/Kconfig
> @@ -297,3 +297,17 @@ config IMA_APPRAISE_SIGNED_INIT
>  	default n
>  	help
>  	   This option requires user-space init to be signed.
> +
> +config IMA_MEASURE_TRUSTED_KEYS
> +	bool "Measure the keys in the Trusted Keys keyring"
> +	depends on IMA
> +	default n
> +	help
> +	   This option enables measurement of the public key of
> +	   the keys in the Trusted Keys keyring during
> +	   IMA initialization. Depending on the kernel configuration
> +	   the trusted keyring could be one of the following:
> +	    if CONFIG_SECONDARY_TRUSTED_KEYRING is enabled then
> +	        secondary_trusted_keys
> +	    else
> +	        builtin_trusted_keys
> diff --git a/security/integrity/ima/ima_init.c b/security/integrity/ima/ima_init.c
> index 5d55ade5f3b9..987939f6c0f6 100644
> --- a/security/integrity/ima/ima_init.c
> +++ b/security/integrity/ima/ima_init.c
> @@ -89,6 +89,83 @@ static int __init ima_add_boot_aggregate(void)
>  	return result;
>  }
>  
> +#ifdef CONFIG_IMA_MEASURE_TRUSTED_KEYS
> +int __init store_trusted_keyring_key(void *key,
> +		u32 keylen, const char *key_description)
> +{
> +	static const char op[] = "store_trusted_keyring_key";
> +	const char *audit_cause = "ENOMEM";
> +	struct ima_template_entry *entry;
> +	struct integrity_iint_cache tmp_iint, *iint = &tmp_iint;
> +	struct ima_event_data event_data = {iint, NULL, key_description,
> +					    NULL, 0, NULL};
> +	int result = -ENOMEM;
> +	int violation = 0;
> +	struct {
> +		struct ima_digest_data hdr;
> +		char digest[IMA_MAX_DIGEST_SIZE];
> +	} hash;
> +
> +	if (key == NULL || keylen == 0)
> +		return 0;
> +
> +	memset(iint, 0, sizeof(*iint));
> +	memset(&hash, 0, sizeof(hash));
> +	iint->ima_hash = &hash.hdr;
> +	iint->ima_hash->algo = HASH_ALGO_SHA1;
> +	iint->ima_hash->length = SHA1_DIGEST_SIZE;
> +
> +	result = ima_calc_buffer_hash(key, keylen, &hash.hdr);
> +	if (result < 0) {
> +		audit_cause = "hashing_error";
> +		goto err_out;
> +	}
> +
> +	result = ima_alloc_init_template(&event_data, &entry, NULL);
> +	if (result < 0) {
> +		audit_cause = "alloc_entry";
> +		goto err_out;
> +	}
> +
> +	result = ima_store_template(entry, violation, NULL,
> +					key_description,
> +					CONFIG_IMA_MEASURE_PCR_IDX);
> +	if (result < 0) {
> +		ima_free_template_entry(entry);
> +		audit_cause = "store_entry";
> +		goto err_out;
> +	}
> +	return 0;
> +err_out:
> +	integrity_audit_msg(AUDIT_INTEGRITY_PCR, NULL,
> +				key_description, op,
> +				audit_cause, result, 0);
> +	return result;
> +}
> +
> +int __init ima_add_trusted_keyring_keys(int (*store_trusted_key)(
> +			void *key,
> +			u32 keylen,
> +			const char *key_description))
> +{
> +	struct keyring_iterator key_iterator;
> +	int rc = 0;
> +
> +	/* Retrieve the information on keys in
> +	 * the Built-In Trusted Keys keyring.
> +	 */
> +	key_iterator.size = 0;
> +	key_iterator.enumerated = 0;
> +	key_iterator.iterator = store_trusted_key;
> +	rc = keyring_read_trusted_keys(&key_iterator);
> +	if (rc < 0)
> +		pr_err("Failed %d to read keys in trusted_keys\n", rc);
> +
> +	return rc;
> +}
> +
> +#endif /* CONFIG_IMA_MEASURE_TRUSTED_KEYS */
> +
>  #ifdef CONFIG_IMA_LOAD_X509
>  void __init ima_load_x509(void)
>  {
> @@ -129,6 +206,13 @@ int __init ima_init(void)
>  	if (rc != 0)
>  		return rc;
>  
> +#ifdef CONFIG_IMA_MEASURE_TRUSTED_KEYS
> +	/* Measure keys from builtin trusted keys keyring. */
> +	rc = ima_add_trusted_keyring_keys(store_trusted_keyring_key);
> +	if (rc != 0)
> +		return rc;
> +#endif /* CONFIG_IMA_MEASURE_TRUSTED_KEYS */
> +
>  	ima_init_policy();
>  
>  	return ima_fs_init();
> diff --git a/security/keys/keyring.c b/security/keys/keyring.c
> index febf36c6ddc5..fe84923b3c1c 100644
> --- a/security/keys/keyring.c
> +++ b/security/keys/keyring.c
> @@ -16,6 +16,9 @@
>  #include <linux/nsproxy.h>
>  #include <keys/keyring-type.h>
>  #include <keys/user-type.h>
> +#include <keys/asymmetric-type.h>
> +#include <keys/system_keyring.h>
> +#include <crypto/public_key.h>
>  #include <linux/assoc_array_priv.h>
>  #include <linux/uaccess.h>
>  #include <net/net_namespace.h>
> @@ -1790,3 +1793,63 @@ void keyring_restriction_gc(struct key *keyring, struct key_type *dead_type)
>  
>  	kleave(" [restriction gc]");
>  }
> +
> +#ifdef CONFIG_IMA_MEASURE_TRUSTED_KEYS
> +static int keyring_keys_iterator(const void *object, void *data)
> +{
> +	struct keyring_iterator *key_iterator = data;
> +	const struct key *key = keyring_ptr_to_key(object);
> +	const struct public_key *pk;
> +	int rc = 0;
> +
> +	if (key_iterator->enumerated < key_iterator->size) {
> +		key_iterator->enumerated++;
> +		pk = key->payload.data[asym_crypto];
> +		if ((pk != NULL) &&
> +			(pk->keylen > 0) &&
> +			(key->description != NULL)) {
> +			rc = key_iterator->iterator(pk->key,
> +					pk->keylen,
> +					key->description);
> +		}
> +	}
> +
> +	return rc;
> +}
> +
> +/*
> + * Read a list of keys from the given keyring.
> + *  keyring - Keyring to read the list of keys from
> + *  key_iterator - Keyring iterator
> + */
> +long keyring_read_keys(
> +	const struct key *keyring,
> +	struct keyring_iterator *key_iterator)
> +{
> +	long ret = 0;
> +
> +	kenter("{%d}", key_serial(keyring));
> +
> +	key_iterator->size = keyring->keys.nr_leaves_on_tree;
> +	key_iterator->enumerated = 0;
> +	ret = assoc_array_iterate(&keyring->keys,
> +				keyring_keys_iterator,
> +				key_iterator);
> +	if (ret == 0)
> +		kleave(" = %ld [ok]", ret);
> +	else
> +		kleave(" = %ld [error]", ret);
> +
> +	return ret;
> +}
> +
> +/*
> + * Read a list of keys from the trusted_keys keyring.
> + *  key_iterator - Keyring iterator
> + */
> +long keyring_read_trusted_keys(
> +	struct keyring_iterator *key_iterator)
> +{
> +	return keyring_read_keys(get_trusted_keys(), key_iterator);
> +}
> +#endif /* CONFIG_IMA_MEASURE_TRUSTED_KEYS */

