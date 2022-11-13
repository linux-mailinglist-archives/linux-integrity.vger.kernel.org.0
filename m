Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F58F627313
	for <lists+linux-integrity@lfdr.de>; Sun, 13 Nov 2022 23:55:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233850AbiKMWzU (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 13 Nov 2022 17:55:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231972AbiKMWzT (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 13 Nov 2022 17:55:19 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B970F10040;
        Sun, 13 Nov 2022 14:55:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4859760BDB;
        Sun, 13 Nov 2022 22:55:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B5F0C433C1;
        Sun, 13 Nov 2022 22:55:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668380115;
        bh=z0bkMaDPFItV7dkdvWiTq+WI44ui+/N4FjEd9Ph4VQ0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Pygh2ztMVpUqSvYsRVcu0RpKUpPN9cUrXVnteNDuCPevRxQ0c+OkGIn28O2aUXjWp
         mZj6pi/qg+kuktYZALKnpQHnzM+tMP9qQGaZY5NGkNLi46VczwQ21luuHCaR3g9t3+
         I6qnebLJP2d1IOSBdeWBv9NUY5jbC145zEH9ykZsZVFUys0rlZNabjGAAcXefj6Hjs
         bQ6PQwrfKIPjezLFESqzlcu43ldPohG0/kexLqhlytwWKHsGLX39/cwqOv9VX/eG/J
         7W7TpsGI5zXwWTX9uc9CRuTjMtzdtfefWV0TWiQlDSldBSY1L/gcbzyH3L3pgVOAiq
         McF59KS8J70hw==
Date:   Sun, 13 Nov 2022 14:55:13 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Evan Green <evgreen@chromium.org>
Cc:     linux-kernel@vger.kernel.org, corbet@lwn.net,
        linux-integrity@vger.kernel.org, gwendal@chromium.org,
        dianders@chromium.org, apronin@chromium.org,
        Pavel Machek <pavel@ucw.cz>, Ben Boeckel <me@benboeckel.net>,
        rjw@rjwysocki.net, jejb@linux.ibm.com,
        Kees Cook <keescook@chromium.org>, dlunev@google.com,
        zohar@linux.ibm.com, Matthew Garrett <mgarrett@aurora.tech>,
        jarkko@kernel.org, linux-pm@vger.kernel.org,
        Len Brown <len.brown@intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v5 07/11] PM: hibernate: Add kernel-based encryption
Message-ID: <Y3F10djeCAqejW37@sol.localdomain>
References: <20221111231636.3748636-1-evgreen@chromium.org>
 <20221111151451.v5.7.Ifff11e11797a1bde0297577ecb2f7ebb3f9e2b04@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221111151451.v5.7.Ifff11e11797a1bde0297577ecb2f7ebb3f9e2b04@changeid>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, Nov 11, 2022 at 03:16:32PM -0800, Evan Green wrote:
> Enabling the kernel to be able to do encryption and integrity checks on
> the hibernate image prevents a malicious userspace from escalating to
> kernel execution via hibernation resume. As a first step toward this, add
> the scaffolding needed for the kernel to do AEAD encryption on the
> hibernate image, giving us both secrecy and integrity.

"Authenticity" would be more accurate than "integrity".

It is a common mistake, though...

> +#define USWSUSP_KEY_NONCE_SIZE 16
> +
> +/*
> + * This structure is used to pass the kernel's hibernate encryption key in
> + * either direction.
> + */
> +struct uswsusp_key_blob {
> +	__u32 blob_len;
> +	__u8 blob[512];
> +	__u8 nonce[USWSUSP_KEY_NONCE_SIZE];
> +} __attribute__((packed));

What is the purpose of the nonce here?

It seems to be associated with the key?  That doesn't make sense.

Also, please don't use __attribute__((packed)) on structures unless a specific
byte layout is needed (e.g. due to the struct being stored on-disk).

> +config ENCRYPTED_HIBERNATION
> +	bool "Encryption support for userspace snapshots"
> +	depends on HIBERNATION_SNAPSHOT_DEV
> +	depends on CRYPTO_AEAD2=y

"gcm(aes)" from the crypto API is being used, so CRYPTO_GCM and CRYPTO_AES are
needed to ensure that is available.

> +/* Encrypt more data from the snapshot into the staging area. */
> +static int snapshot_encrypt_refill(struct snapshot_data *data)
> +{
> +	struct aead_request *req = data->aead_req;
> +	u8 nonce[GCM_AES_IV_SIZE];
> +	DECLARE_CRYPTO_WAIT(wait);
> +	size_t total = 0;
> +	int pg_idx;
> +	int res;
> +
> +	/*
> +	 * The first buffer is the associated data, set to the offset to prevent
> +	 * attacks that rearrange chunks.
> +	 */
> +	sg_set_buf(&data->sg[0], &data->crypt_total, sizeof(data->crypt_total));

Wouldn't it be simpler to use implicit nonces?  I.e. make each nonce be the
offset of the page, instead of a value stored alongside the ciphertext?  Then
there would be no need to include the offset of the page in the AAD.

> +		/*
> +		 * Copy the page into the staging area. A future optimization
> +		 * could potentially skip this copy for lowmem pages.
> +		 */
> +		memcpy(buf, data_of(data->handle), PAGE_SIZE);
> +		sg_set_buf(&data->sg[1 + pg_idx], buf, PAGE_SIZE);
> +		total += PAGE_SIZE;

This is a bit ugly.  It means that highmem pages in the snapshot get copied
twice, first from the snapshot page to the static variable 'buffer', and then to
a page in snapshot_data::crypt_pages.  And lowmem pages in the snapshot get
copied once, into snapshot_data::crypt_pages.

It should be possible to encrypt directly from the snapshot page in both cases,
saving all the copies.

I suppose it is fine as-is for now, but I wonder if there's a clean way to
implement the zero-copy method.

> +	}
> +
> +	sg_set_buf(&data->sg[1 + pg_idx], &data->auth_tag, SNAPSHOT_AUTH_TAG_SIZE);
> +	aead_request_set_callback(req, 0, crypto_req_done, &wait);
> +	/*
> +	 * Use incrementing nonces for each chunk, since a 64 bit value won't
> +	 * roll into re-use for any given hibernate image.
> +	 */
> +	memcpy(&nonce[0], &data->nonce_low, sizeof(data->nonce_low));
> +	memcpy(&nonce[sizeof(data->nonce_low)],
> +	       &data->nonce_high,
> +	       sizeof(nonce) - sizeof(data->nonce_low));
> +	data->nonce_low += 1;

Hmm, so you *are* using incrementing nonces.  In that case there's no need to
store them alongside the ciphertext or to include them in the AAD.

Also, since it's being assumed that the counter doesn't overflow 64 bits, there
should be no need for 'nonce_high' to exist.

> +	/* Set up the encryption transform */
> +	data->aead_tfm = crypto_alloc_aead("gcm(aes)", 0, 0);
> +	if (IS_ERR(data->aead_tfm)) {
> +		rc = PTR_ERR(data->aead_tfm);
> +		data->aead_tfm = NULL;
> +		return rc;
> +	}
> +
> +	rc = -ENOMEM;
> +	data->aead_req = aead_request_alloc(data->aead_tfm, GFP_KERNEL);
> +	if (data->aead_req == NULL)
> +		goto setup_fail;
> +
> +	/* Allocate the staging area */
> +	for (i = 0; i < CHUNK_SIZE; i++) {
> +		data->crypt_pages[i] = (void *)__get_free_page(GFP_ATOMIC);
> +		if (data->crypt_pages[i] == NULL)
> +			goto setup_fail;
> +	}

The GFP_ATOMIC above should be GFP_KERNEL, given that the same function uses
GFP_KERNEL already.

> +int snapshot_get_encryption_key(struct snapshot_data *data,
> +				struct uswsusp_key_blob __user *key)
> +{
> +	u8 aead_key[SNAPSHOT_ENCRYPTION_KEY_SIZE];
> +	u8 nonce[USWSUSP_KEY_NONCE_SIZE];
> +	int rc;
> +
> +	/* Don't pull a random key from a world that can be reset. */
> +	if (data->ready)
> +		return -EPIPE;
> +
> +	rc = snapshot_setup_encryption_common(data);
> +	if (rc)
> +		return rc;
> +
> +	/* Build a random starting nonce. */
> +	get_random_bytes(nonce, sizeof(nonce));
> +	memcpy(&data->nonce_low, &nonce[0], sizeof(data->nonce_low));
> +	memcpy(&data->nonce_high, &nonce[8], sizeof(data->nonce_high));
> +	/* Build a random key */
> +	get_random_bytes(aead_key, sizeof(aead_key));
> +	rc = crypto_aead_setkey(data->aead_tfm, aead_key, sizeof(aead_key));
> +	if (rc)
> +		goto fail;

Why not just start the nonce at 0?  It's a new key.

> +	rc = copy_to_user(&key->blob, &aead_key, sizeof(aead_key));
> +	if (rc)
> +		goto fail;
> +
> +	rc = copy_to_user(&key->nonce, &nonce, sizeof(nonce));
> +	if (rc)
> +		goto fail;

This is not handling the return value of copy_to_user() correctly.

> +int snapshot_set_encryption_key(struct snapshot_data *data,
> +				struct uswsusp_key_blob __user *key)
> +{
> +	struct uswsusp_key_blob blob;
> +	int rc;
> +
> +	/* It's too late if data's been pushed in. */
> +	if (data->handle.cur)
> +		return -EPIPE;
> +
> +	rc = snapshot_setup_encryption_common(data);
> +	if (rc)
> +		return rc;
> +
> +	/* Load the key from user mode. */
> +	rc = copy_from_user(&blob, key, sizeof(struct uswsusp_key_blob));
> +	if (rc)
> +		goto crypto_setup_fail;

Likewise, this is not handling the return value of copy_from_user() correctly.

> +
> +	if (blob.blob_len != sizeof(struct uswsusp_key_blob)) {
> +		rc = -EINVAL;
> +		goto crypto_setup_fail;
> +	}

Later in the patch series this changes to:

	if (blob.blob_len > sizeof(key->blob))

So the semantics of the blob_len field changes from "size of the struct" to
"size of a field in the struct".   That's confusing.  Which one did you intend?

> +loff_t snapshot_get_encrypted_image_size(loff_t raw_size)
> +{
> +	loff_t pages = raw_size >> PAGE_SHIFT;
> +	loff_t chunks = (pages + (CHUNK_SIZE - 1)) / CHUNK_SIZE;

DIV_ROUND_UP(pages, CHUNK_SIZE)

> +	/*
> +	 * The encrypted size is the normal size, plus a stitched in
> +	 * authentication tag for every chunk of pages.
> +	 */
> +	return raw_size + (chunks * SNAPSHOT_AUTH_TAG_SIZE);
> +}
> +
> +int snapshot_finalize_decrypted_image(struct snapshot_data *data)
> +{
> +	int rc;
> +
> +	if (data->crypt_offset != 0) {
> +		rc = snapshot_decrypt_drain(data);
> +		if (rc)
> +			return rc;
> +	}
> +
> +	return 0;

There's no need for the 'rc' variable:

        if (data->crypt_offset != 0)
                return snapshot_decrypt_drain(data);
        return 0;

> diff --git a/kernel/power/user.c b/kernel/power/user.c
> index 3a4e70366f354c..bba5cdbd2c0239 100644
> --- a/kernel/power/user.c
> +++ b/kernel/power/user.c
> @@ -25,19 +25,10 @@
>  #include <linux/uaccess.h>
>  
>  #include "power.h"
> +#include "user.h"
>  
>  static bool need_wait;
> -
> -static struct snapshot_data {
> -	struct snapshot_handle handle;
> -	int swap;
> -	int mode;
> -	bool frozen;
> -	bool ready;
> -	bool platform_support;
> -	bool free_bitmaps;
> -	dev_t dev;
> -} snapshot_state;
> +struct snapshot_data snapshot_state;

Why is this variable made non-static?  It's still only used in this file.

> diff --git a/kernel/power/user.h b/kernel/power/user.h
> new file mode 100644
> index 00000000000000..ac429782abff85
> --- /dev/null
> +++ b/kernel/power/user.h
> @@ -0,0 +1,103 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +#include <linux/crypto.h>
> +#include <crypto/aead.h>
> +#include <crypto/aes.h>
> +
> +#define SNAPSHOT_ENCRYPTION_KEY_SIZE AES_KEYSIZE_128

Why use AES-128 instead of AES-256?

> +#if defined(CONFIG_ENCRYPTED_HIBERNATION)

#ifdef CONFIG_ENCRYPTED_HIBERNATION

> +#else
> +
> +ssize_t snapshot_read_encrypted(struct snapshot_data *data,
> +				char __user *buf, size_t count, loff_t *offp)
> +{
> +	return -ENOTTY;
> +}
> +
> +ssize_t snapshot_write_encrypted(struct snapshot_data *data,
> +				 const char __user *buf, size_t count,
> +				 loff_t *offp)
> +{
> +	return -ENOTTY;
> +}
> +
> +static void snapshot_teardown_encryption(struct snapshot_data *data) {}
> +static int snapshot_get_encryption_key(struct snapshot_data *data,
> +				       struct uswsusp_key_blob __user *key)
> +{
> +	return -ENOTTY;
> +}
> +
> +static int snapshot_set_encryption_key(struct snapshot_data *data,
> +				       struct uswsusp_key_blob __user *key)
> +{
> +	return -ENOTTY;
> +}
> +
> +static loff_t snapshot_get_encrypted_image_size(loff_t raw_size)
> +{
> +	return raw_size;
> +}
> +
> +static int snapshot_finalize_decrypted_image(struct snapshot_data *data)
> +{
> +	return -ENOTTY;
> +}
> +
> +#define snapshot_encryption_enabled(data) (0)

The above stubs should be 'static inline' functions.

- Eric
