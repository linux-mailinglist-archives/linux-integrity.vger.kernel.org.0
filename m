Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 629155F14FA
	for <lists+linux-integrity@lfdr.de>; Fri, 30 Sep 2022 23:35:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232165AbiI3Vfx (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 30 Sep 2022 17:35:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231759AbiI3Vfw (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 30 Sep 2022 17:35:52 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BC07F3C7D;
        Fri, 30 Sep 2022 14:35:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2A77BB82A21;
        Fri, 30 Sep 2022 21:35:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7584EC433D7;
        Fri, 30 Sep 2022 21:35:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664573747;
        bh=U6P/ADlKgdqTvxp2lXJ7MbjYvmi7ddu424dztMTP1mk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=brlKorgSK7bLOUAYhdpOZoZ3vVekA4wlOr0+gXmm8eDkFFWkxledyBfs9HDZ+yPDy
         S+Mu/ZRae9mW+TUTp7lKH2TusERH//UOgzLj+EA0bJQDdrTD4NDmtGHwhN8dSmjCbv
         Rgdo1F0ZoMTOyndZeXpt9zOdb+025+t7FVQPDdz+/6RJfZoioB1ndLtUnsBBRW+t0z
         7wdae5cYo6p6QLaFwwEGVxM3LFdUUr1AceEa+5wWQqrmPMxo6EJXYeDSVGgQheg5Vz
         +QggwfouBMz1FQuIe+sYVfyLC8iPVWdvxCA9cvU/58/ujbyExlCzvIim7Dezaddi+v
         5sJ1JBtN7I97w==
Date:   Sat, 1 Oct 2022 00:35:45 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Evan Green <evgreen@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        apronin@chromium.org, dlunev@google.com,
        Pavel Machek <pavel@ucw.cz>, Ben Boeckel <me@benboeckel.net>,
        rjw@rjwysocki.net, corbet@lwn.net, linux-pm@vger.kernel.org,
        zohar@linux.ibm.com, Kees Cook <keescook@chromium.org>,
        Eric Biggers <ebiggers@kernel.org>, jejb@linux.ibm.com,
        gwendal@chromium.org, Matthew Garrett <mgarrett@aurora.tech>,
        Len Brown <len.brown@intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v3 08/11] PM: hibernate: Use TPM-backed keys to encrypt
 image
Message-ID: <YzdhMW6VqoT0EkGI@kernel.org>
References: <20220927164922.3383711-1-evgreen@chromium.org>
 <20220927094559.v3.8.Ibd067e73916b9fae268a5824c2dd037416426af8@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220927094559.v3.8.Ibd067e73916b9fae268a5824c2dd037416426af8@changeid>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Sep 27, 2022 at 09:49:19AM -0700, Evan Green wrote:
> When using encrypted hibernate images, have the TPM create a key for us
> and seal it. By handing back a sealed blob instead of the raw key, we
> prevent usermode from being able to decrypt and tamper with the
> hibernate image on a different machine.
> 
> We'll also go through the motions of having PCR23 set to a known value at
> the time of key creation and unsealing. Currently there's nothing that
> enforces the contents of PCR23 as a condition to unseal the key blob,
> that will come in a later change.
> 
> Sourced-from: Matthew Garrett <mjg59@google.com>
> Signed-off-by: Evan Green <evgreen@chromium.org>
> 
> ---
> Matthew's incarnation of this patch is at:
> https://patchwork.kernel.org/project/linux-pm/patch/20210220013255.1083202-9-matthewgarrett@google.com/
> 
> Changes in v3:
>  - ENCRYPTED_HIBERNATION needs TRUSTED_KEYS builtin for
>    key_type_trusted.
>  - Remove KEYS dependency since it's covered by TRUSTED_KEYS (Kees)
> 
> Changes in v2:
>  - Rework load/create_kernel_key() to eliminate a label (Andrey)
>  - Call put_device() needed from calling tpm_default_chip().
> 
>  kernel/power/Kconfig   |   1 +
>  kernel/power/snapenc.c | 207 +++++++++++++++++++++++++++++++++++++++--
>  kernel/power/user.h    |   1 +
>  3 files changed, 200 insertions(+), 9 deletions(-)
> 
> diff --git a/kernel/power/Kconfig b/kernel/power/Kconfig
> index cd574af0b43379..2f8acbd87b34dc 100644
> --- a/kernel/power/Kconfig
> +++ b/kernel/power/Kconfig
> @@ -96,6 +96,7 @@ config ENCRYPTED_HIBERNATION
>  	bool "Encryption support for userspace snapshots"
>  	depends on HIBERNATION_SNAPSHOT_DEV
>  	depends on CRYPTO_AEAD2=y
> +	depends on TRUSTED_KEYS=y
>  	default n
>  	help
>  	  Enable support for kernel-based encryption of hibernation snapshots
> diff --git a/kernel/power/snapenc.c b/kernel/power/snapenc.c
> index cb90692d6ab83a..90079f6d4f184b 100644
> --- a/kernel/power/snapenc.c
> +++ b/kernel/power/snapenc.c
> @@ -4,13 +4,23 @@
>  #include <linux/crypto.h>
>  #include <crypto/aead.h>
>  #include <crypto/gcm.h>
> +#include <keys/trusted-type.h>
> +#include <linux/key-type.h>
>  #include <linux/random.h>
>  #include <linux/mm.h>
> +#include <linux/tpm.h>
>  #include <linux/uaccess.h>
>  
>  #include "power.h"
>  #include "user.h"
>  
> +/* sha256("To sleep, perchance to dream") */
> +static struct tpm_digest known_digest = { .alg_id = TPM_ALG_SHA256,
> +	.digest = {0x92, 0x78, 0x3d, 0x79, 0x2d, 0x00, 0x31, 0xb0, 0x55, 0xf9,
> +		   0x1e, 0x0d, 0xce, 0x83, 0xde, 0x1d, 0xc4, 0xc5, 0x8e, 0x8c,
> +		   0xf1, 0x22, 0x38, 0x6c, 0x33, 0xb1, 0x14, 0xb7, 0xec, 0x05,
> +		   0x5f, 0x49}};
> +
>  /* Encrypt more data from the snapshot into the staging area. */
>  static int snapshot_encrypt_refill(struct snapshot_data *data)
>  {
> @@ -313,6 +323,12 @@ void snapshot_teardown_encryption(struct snapshot_data *data)
>  {
>  	int i;
>  
> +	if (data->key) {

Would be a helpful to have perhaps inline comment before the check.

Just stating this because I did not exactly follow why the null
check was needed (but do believe that there are good reasons to
do it).

> +		key_revoke(data->key);
> +		key_put(data->key);
> +		data->key = NULL;
> +	}
> +
>  	if (data->aead_req) {
>  		aead_request_free(data->aead_req);
>  		data->aead_req = NULL;
> @@ -381,11 +397,83 @@ static int snapshot_setup_encryption_common(struct snapshot_data *data)
>  	return rc;
>  }
>  
> +static int snapshot_create_kernel_key(struct snapshot_data *data)
> +{
> +	const struct cred *cred = current_cred();
> +	struct tpm_digest *digests = NULL;
> +	struct tpm_chip *chip;
> +	struct key *key = NULL;
> +	int ret, i;
> +	/* Create a key sealed by the SRK. */
> +	char *keyinfo = "new\t32\tkeyhandle=0x81000000";

Again, I'd consider put this declaration as first.

> +
> +	chip = tpm_default_chip();
> +	if (!chip)
> +		return -ENODEV;
> +
> +	if (!(tpm_is_tpm2(chip))) {
> +		ret = -ENODEV;
> +		goto out_dev;
> +	}
> +
> +	ret = tpm_pcr_reset(chip, 23);
> +	if (ret)
> +		goto out;
> +
> +	digests = kcalloc(chip->nr_allocated_banks, sizeof(struct tpm_digest),
> +			  GFP_KERNEL);
> +	if (!digests) {
> +		ret = -ENOMEM;
> +		goto out;
> +	}
> +
> +	for (i = 0; i <= chip->nr_allocated_banks; i++) {
> +		digests[i].alg_id = chip->allocated_banks[i].alg_id;
> +		if (digests[i].alg_id == known_digest.alg_id)
> +			memcpy(&digests[i], &known_digest, sizeof(known_digest));
> +	}
> +
> +	ret = tpm_pcr_extend(chip, 23, digests);
> +	if (ret != 0)
> +		goto out;
> +
> +	key = key_alloc(&key_type_trusted, "swsusp", GLOBAL_ROOT_UID,
> +			GLOBAL_ROOT_GID, cred, 0, KEY_ALLOC_NOT_IN_QUOTA,
> +			NULL);
> +
> +	if (IS_ERR(key)) {
> +		ret = PTR_ERR(key);
> +		key = NULL;
> +		goto out;
> +	}
> +
> +	ret = key_instantiate_and_link(key, keyinfo, strlen(keyinfo) + 1, NULL,
> +				       NULL);

Generally speaking, even if it somehow would be "safe", not strlen()
thank you.

AFAIK, keyinfo is a constant so you could just as well use sizeof().
And then you would not need "+ 1".

> +	if (ret != 0)
> +		goto out;
> +
> +	data->key = key;
> +	key = NULL;
> +
> +out:
> +	if (key) {
> +		key_revoke(key);
> +		key_put(key);
> +	}
> +
> +	kfree(digests);
> +	tpm_pcr_reset(chip, 23);
> +
> +out_dev:
> +	put_device(&chip->dev);
> +	return ret;
> +}
> +
>  int snapshot_get_encryption_key(struct snapshot_data *data,
>  	struct uswsusp_key_blob __user *key)
>  {
> -	u8 aead_key[SNAPSHOT_ENCRYPTION_KEY_SIZE];
>  	u8 nonce[USWSUSP_KEY_NONCE_SIZE];
> +	struct trusted_key_payload *payload;
>  	int rc;
>  	/* Don't pull a random key from a world that can be reset. */
>  	if (data->ready)
> @@ -399,21 +487,28 @@ int snapshot_get_encryption_key(struct snapshot_data *data,
>  	get_random_bytes(nonce, sizeof(nonce));
>  	memcpy(&data->nonce_low, &nonce[0], sizeof(data->nonce_low));
>  	memcpy(&data->nonce_high, &nonce[8], sizeof(data->nonce_high));
> -	/* Build a random key */
> -	get_random_bytes(aead_key, sizeof(aead_key));
> -	rc = crypto_aead_setkey(data->aead_tfm, aead_key, sizeof(aead_key));
> +
> +	/* Create a kernel key, and set it. */
> +	rc = snapshot_create_kernel_key(data);
> +	if (rc)
> +		goto fail;
> +
> +	payload = data->key->payload.data[0];
> +	/* Install the key */
> +	rc = crypto_aead_setkey(data->aead_tfm, payload->key, SNAPSHOT_ENCRYPTION_KEY_SIZE);
>  	if (rc)
>  		goto fail;
>  
> -	/* Hand the key back to user mode (to be changed!) */
> -	rc = put_user(sizeof(struct uswsusp_key_blob), &key->blob_len);
> +	/* Hand the key back to user mode in sealed form. */
> +	rc = put_user(payload->blob_len, &key->blob_len);
>  	if (rc)
>  		goto fail;
>  
> -	rc = copy_to_user(&key->blob, &aead_key, sizeof(aead_key));
> +	rc = copy_to_user(&key->blob, &payload->blob, payload->blob_len);
>  	if (rc)
>  		goto fail;
>  
> +	/* The nonce just gets handed back in the clear. */
>  	rc = copy_to_user(&key->nonce, &nonce, sizeof(nonce));
>  	if (rc)
>  		goto fail;
> @@ -425,10 +520,99 @@ int snapshot_get_encryption_key(struct snapshot_data *data,
>  	return rc;
>  }
>  
> +static int snapshot_load_kernel_key(struct snapshot_data *data,
> +	struct uswsusp_key_blob *blob)

Bad alignment.

> +{
> +
> +	const struct cred *cred = current_cred();
> +	char *keytemplate = "load\t%s\tkeyhandle=0x81000000";

Ditto.

> +	struct tpm_digest *digests = NULL;
> +	char *blobstring = NULL;
> +	char *keyinfo = NULL;
> +	struct tpm_chip *chip;
> +	struct key *key = NULL;
> +	int i, ret;
> +
> +	chip = tpm_default_chip();
> +	if (!chip)
> +		return -ENODEV;
> +
> +	if (!(tpm_is_tpm2(chip))) {
> +		ret = -ENODEV;
> +		goto out_dev;
> +	}
> +
> +	ret = tpm_pcr_reset(chip, 23);
> +	if (ret)
> +		goto out;
> +
> +	digests = kcalloc(chip->nr_allocated_banks, sizeof(struct tpm_digest),
> +			  GFP_KERNEL);
> +	if (!digests)
> +		goto out;
> +
> +	for (i = 0; i <= chip->nr_allocated_banks; i++) {
> +		digests[i].alg_id = chip->allocated_banks[i].alg_id;
> +		if (digests[i].alg_id == known_digest.alg_id)
> +			memcpy(&digests[i], &known_digest, sizeof(known_digest));
> +	}
> +
> +	ret = tpm_pcr_extend(chip, 23, digests);
> +	if (ret != 0)
> +		goto out;
> +
> +	blobstring = kmalloc(blob->blob_len * 2, GFP_KERNEL);
> +	if (!blobstring) {
> +		ret = -ENOMEM;
> +		goto out;
> +	}
> +
> +	bin2hex(blobstring, blob->blob, blob->blob_len);
> +	keyinfo = kasprintf(GFP_KERNEL, keytemplate, blobstring);
> +	if (!keyinfo) {
> +		ret = -ENOMEM;
> +		goto out;
> +	}
> +
> +	key = key_alloc(&key_type_trusted, "swsusp", GLOBAL_ROOT_UID,
> +			GLOBAL_ROOT_GID, cred, 0, KEY_ALLOC_NOT_IN_QUOTA,
> +			NULL);
> +
> +	if (IS_ERR(key)) {
> +		ret = PTR_ERR(key);
> +		key = NULL;
> +		goto out;
> +	}
> +
> +	ret = key_instantiate_and_link(key, keyinfo, strlen(keyinfo) + 1, NULL,
> +				       NULL);

Ditto.

> +	if (ret != 0)
> +		goto out;
> +
> +	data->key = key;
> +	key = NULL;
> +
> +out:
> +	if (key) {
> +		key_revoke(key);
> +		key_put(key);
> +	}
> +
> +	kfree(keyinfo);
> +	kfree(blobstring);
> +	kfree(digests);
> +	tpm_pcr_reset(chip, 23);
> +
> +out_dev:
> +	put_device(&chip->dev);
> +	return ret;
> +}
> +
>  int snapshot_set_encryption_key(struct snapshot_data *data,
>  	struct uswsusp_key_blob __user *key)
>  {
>  	struct uswsusp_key_blob blob;
> +	struct trusted_key_payload *payload;
>  	int rc;
>  
>  	/* It's too late if data's been pushed in. */
> @@ -444,13 +628,18 @@ int snapshot_set_encryption_key(struct snapshot_data *data,
>  	if (rc)
>  		goto crypto_setup_fail;
>  
> -	if (blob.blob_len != sizeof(struct uswsusp_key_blob)) {
> +	if (blob.blob_len > sizeof(key->blob)) {
>  		rc = -EINVAL;
>  		goto crypto_setup_fail;
>  	}
>  
> +	rc = snapshot_load_kernel_key(data, &blob);
> +	if (rc)
> +		goto crypto_setup_fail;
> +
> +	payload = data->key->payload.data[0];
>  	rc = crypto_aead_setkey(data->aead_tfm,
> -				blob.blob,
> +				payload->key,
>  				SNAPSHOT_ENCRYPTION_KEY_SIZE);
>  
>  	if (rc)
> diff --git a/kernel/power/user.h b/kernel/power/user.h
> index 6823e2eba7ec53..591b30bb213349 100644
> --- a/kernel/power/user.h
> +++ b/kernel/power/user.h
> @@ -31,6 +31,7 @@ struct snapshot_data {
>  	uint64_t crypt_total;
>  	uint64_t nonce_low;
>  	uint64_t nonce_high;
> +	struct key *key;
>  #endif
>  
>  };
> -- 
> 2.31.0
> 

BR, Jarkko
