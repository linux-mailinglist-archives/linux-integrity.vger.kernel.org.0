Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F112618701
	for <lists+linux-integrity@lfdr.de>; Thu,  3 Nov 2022 19:05:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229551AbiKCSFG (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 3 Nov 2022 14:05:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230383AbiKCSEO (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 3 Nov 2022 14:04:14 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B121823BFD
        for <linux-integrity@vger.kernel.org>; Thu,  3 Nov 2022 11:01:55 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id 130so2328134pfu.8
        for <linux-integrity@vger.kernel.org>; Thu, 03 Nov 2022 11:01:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zmWNArOWA63+Rp+4KSjfkZ/X8L7crokDBuY2zqY1JQ4=;
        b=EaqDm7Xl0Ea2PZH6mPEVFdEcgktPCKge1E7xRIasguVtrYMF4tocv9gOBmyDp2zCAF
         rgUUrNngU/x1jtj2CJVUNjmCABNZeGrrFEbALTQkWY331ugsSutrIVYltYE4QsoT1J8J
         vbXDWRSUpz4nR+duOLw/S+jV7/iioZYSCQadQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zmWNArOWA63+Rp+4KSjfkZ/X8L7crokDBuY2zqY1JQ4=;
        b=OEdl6KjZLOyIYwCONATM3Rfq2Pm+pjMFy0Hdz4Mu3sbH6o3QlEE0lQNjNRpmWPBs5z
         86FQ+PPW2NlFm3yUQnCid93UyhnqA4FYkX7XoMersLva70vZC3Ur6JmRLTGmrkaNS+LS
         IfZ6KceRe+JctsNlnll903JQb+69NFqXrh8sS+zUZ2z/K6SQvvLK/Ue/buVoA02apIoi
         YZHx3BJsK4Sf7wAYwMZwxKzms6LvAJCaiy0mAu9nO3qFz2Z6F3zxrTqUwlmUQ3N8/ef2
         VkaGCMkyoSYjRs+1nUBucqRtd3PZLi981I8yZxGZf1fdKI00BLAkhGwsE6UU8p4bg5qe
         LMEg==
X-Gm-Message-State: ACrzQf0Kpfq2lJ/9cXXbfjgPtbST58sEiwgxOGXSZLmGTyiP2zug/bMG
        VwwaGV1Lj8a2WxUNzYtVX+GH/g==
X-Google-Smtp-Source: AMsMyM5NCdtte+TiA5CkaGdf8YHCzOF2rZ2JUeWfMzQXd99PrtrTx1HE+dZnJMmlZ/F8gvdxjfHN8Q==
X-Received: by 2002:a63:8bc3:0:b0:46f:fa99:7d76 with SMTP id j186-20020a638bc3000000b0046ffa997d76mr11438904pge.134.1667498514923;
        Thu, 03 Nov 2022 11:01:54 -0700 (PDT)
Received: from evgreen-glaptop.lan ([98.45.28.95])
        by smtp.gmail.com with ESMTPSA id t12-20020a1709027fcc00b00177fb862a87sm1000277plb.20.2022.11.03.11.01.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 11:01:54 -0700 (PDT)
From:   Evan Green <evgreen@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     corbet@lwn.net, linux-pm@vger.kernel.org, rjw@rjwysocki.net,
        gwendal@chromium.org, apronin@chromium.org,
        Pavel Machek <pavel@ucw.cz>, Kees Cook <keescook@chromium.org>,
        Matthew Garrett <mgarrett@aurora.tech>,
        linux-integrity@vger.kernel.org, jejb@linux.ibm.com,
        zohar@linux.ibm.com, dlunev@google.com,
        Eric Biggers <ebiggers@kernel.org>,
        Ben Boeckel <me@benboeckel.net>, jarkko@kernel.org,
        Evan Green <evgreen@chromium.org>,
        Len Brown <len.brown@intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH v4 09/11] PM: hibernate: Mix user key in encrypted hibernate
Date:   Thu,  3 Nov 2022 11:01:17 -0700
Message-Id: <20221103105558.v4.9.I87952411cf83f2199ff7a4cc8c828d357b8c8ce3@changeid>
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
In-Reply-To: <20221103180120.752659-1-evgreen@chromium.org>
References: <20221103180120.752659-1-evgreen@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Usermode may have their own data protection requirements when it comes
to encrypting the hibernate image. For example, users may want a policy
where the hibernate image is protected by a key derived both from
platform-level security as well as authentication data (such as a
password or PIN). This way, even if the platform is compromised (ie a
stolen laptop), sensitive data cannot be exfiltrated via the hibernate
image without additional data (like the user's password).

The kernel is already doing the encryption, but will be protecting its
key with the TPM alone. Allow usermode to mix in key content of their own
for the data portion of the hibernate image, so that the image
encryption key is determined both by a TPM-backed secret and
user-defined data.

To mix the user key in, we hash the kernel key followed by the user key,
and use the resulting hash as the new key. This allows usermode to mix
in its key material without giving it too much control over what key is
actually driving the encryption (which might be used to attack the
secret kernel key).

Limiting this to the data portion allows the kernel to receive the page
map and prepare its giant allocation even if this user key is not yet
available (ie the user has not yet finished typing in their password).
Once the user key becomes available, the data portion can be pushed
through to the kernel as well. This enables "preloading" scenarios,
where the hibernate image is loaded off of disk while the additional
key material (eg password) is being collected.

One annoyance of the "preloading" scheme is that hibernate image memory
is effectively double-allocated: first by the usermode process pulling
encrypted contents off of disk and holding it, and second by the kernel
in its giant allocation in prepare_image(). An interesting future
optimization would be to allow the kernel to accept and store encrypted
page data before the user key is available. This would remove the
double allocation problem, as usermode could push the encrypted pages
loaded from disk immediately without storing them. The kernel could defer
decryption of the data until the user key is available, while still
knowing the correct page locations to store the encrypted data in.

Signed-off-by: Evan Green <evgreen@chromium.org>
---

(no changes since v2)

Changes in v2:
 - Add missing static on snapshot_encrypted_byte_count()
 - Fold in only the used kernel key bytes to the user key.
 - Make the user key length 32 (Eric)
 - Use CRYPTO_LIB_SHA256 for less boilerplate (Eric)

 include/uapi/linux/suspend_ioctls.h |  15 ++-
 kernel/power/Kconfig                |   1 +
 kernel/power/power.h                |   1 +
 kernel/power/snapenc.c              | 158 ++++++++++++++++++++++++++--
 kernel/power/snapshot.c             |   5 +
 kernel/power/user.c                 |   4 +
 kernel/power/user.h                 |  12 +++
 7 files changed, 185 insertions(+), 11 deletions(-)

diff --git a/include/uapi/linux/suspend_ioctls.h b/include/uapi/linux/suspend_ioctls.h
index b73026ef824bb9..f93a22eac52dc2 100644
--- a/include/uapi/linux/suspend_ioctls.h
+++ b/include/uapi/linux/suspend_ioctls.h
@@ -25,6 +25,18 @@ struct uswsusp_key_blob {
 	__u8 nonce[USWSUSP_KEY_NONCE_SIZE];
 } __attribute__((packed));
 
+/*
+ * Allow user mode to fold in key material for the data portion of the hibernate
+ * image.
+ */
+struct uswsusp_user_key {
+	/* Kernel returns the metadata size. */
+	__kernel_loff_t meta_size;
+	__u32 key_len;
+	__u8 key[32];
+	__u32 pad;
+};
+
 #define SNAPSHOT_IOC_MAGIC	'3'
 #define SNAPSHOT_FREEZE			_IO(SNAPSHOT_IOC_MAGIC, 1)
 #define SNAPSHOT_UNFREEZE		_IO(SNAPSHOT_IOC_MAGIC, 2)
@@ -42,6 +54,7 @@ struct uswsusp_key_blob {
 #define SNAPSHOT_AVAIL_SWAP_SIZE	_IOR(SNAPSHOT_IOC_MAGIC, 19, __kernel_loff_t)
 #define SNAPSHOT_ALLOC_SWAP_PAGE	_IOR(SNAPSHOT_IOC_MAGIC, 20, __kernel_loff_t)
 #define SNAPSHOT_ENABLE_ENCRYPTION	_IOWR(SNAPSHOT_IOC_MAGIC, 21, struct uswsusp_key_blob)
-#define SNAPSHOT_IOC_MAXNR	21
+#define SNAPSHOT_SET_USER_KEY		_IOWR(SNAPSHOT_IOC_MAGIC, 22, struct uswsusp_user_key)
+#define SNAPSHOT_IOC_MAXNR	22
 
 #endif /* _LINUX_SUSPEND_IOCTLS_H */
diff --git a/kernel/power/Kconfig b/kernel/power/Kconfig
index 2f8acbd87b34dc..35bf48b925ebf6 100644
--- a/kernel/power/Kconfig
+++ b/kernel/power/Kconfig
@@ -97,6 +97,7 @@ config ENCRYPTED_HIBERNATION
 	depends on HIBERNATION_SNAPSHOT_DEV
 	depends on CRYPTO_AEAD2=y
 	depends on TRUSTED_KEYS=y
+	select CRYPTO_LIB_SHA256
 	default n
 	help
 	  Enable support for kernel-based encryption of hibernation snapshots
diff --git a/kernel/power/power.h b/kernel/power/power.h
index b4f43394320961..5955e5cf692302 100644
--- a/kernel/power/power.h
+++ b/kernel/power/power.h
@@ -151,6 +151,7 @@ struct snapshot_handle {
 
 extern unsigned int snapshot_additional_pages(struct zone *zone);
 extern unsigned long snapshot_get_image_size(void);
+extern unsigned long snapshot_get_meta_page_count(void);
 extern int snapshot_read_next(struct snapshot_handle *handle);
 extern int snapshot_write_next(struct snapshot_handle *handle);
 extern void snapshot_write_finalize(struct snapshot_handle *handle);
diff --git a/kernel/power/snapenc.c b/kernel/power/snapenc.c
index 7ff4fc66f7500c..50167a37c5bf23 100644
--- a/kernel/power/snapenc.c
+++ b/kernel/power/snapenc.c
@@ -6,6 +6,7 @@
 #include <crypto/gcm.h>
 #include <keys/trusted-type.h>
 #include <linux/key-type.h>
+#include <crypto/sha.h>
 #include <linux/random.h>
 #include <linux/mm.h>
 #include <linux/tpm.h>
@@ -21,6 +22,38 @@ static struct tpm_digest known_digest = { .alg_id = TPM_ALG_SHA256,
 		   0xf1, 0x22, 0x38, 0x6c, 0x33, 0xb1, 0x14, 0xb7, 0xec, 0x05,
 		   0x5f, 0x49}};
 
+/* Derive a key from the kernel and user keys for data encryption. */
+static int snapshot_use_user_key(struct snapshot_data *data)
+{
+	u8 digest[SHA256_DIGEST_SIZE];
+	struct trusted_key_payload *payload = data->key->payload.data[0];
+	struct sha256_state sha256_state;
+
+	/*
+	 * Hash the kernel key and the user key together. This folds in the user
+	 * key, but not in a way that gives the user mode predictable control
+	 * over the key bits.
+	 */
+	sha256_init(&sha256_state);
+	sha256_update(&sha256_state, payload->key, SNAPSHOT_ENCRYPTION_KEY_SIZE);
+	sha256_update(&sha256_state, data->user_key, sizeof(data->user_key));
+	sha256_final(&sha256_state, digest);
+	return crypto_aead_setkey(data->aead_tfm,
+				  digest,
+				  SNAPSHOT_ENCRYPTION_KEY_SIZE);
+}
+
+/* Check to see if it's time to switch to the user key, and do it if so. */
+static int snapshot_check_user_key_switch(struct snapshot_data *data)
+{
+	if (data->user_key_valid && data->meta_size &&
+	    data->crypt_total == data->meta_size) {
+		return snapshot_use_user_key(data);
+	}
+
+	return 0;
+}
+
 /* Encrypt more data from the snapshot into the staging area. */
 static int snapshot_encrypt_refill(struct snapshot_data *data)
 {
@@ -32,6 +65,15 @@ static int snapshot_encrypt_refill(struct snapshot_data *data)
 	int pg_idx;
 	int res;
 
+	if (data->crypt_total == 0) {
+		data->meta_size = snapshot_get_meta_page_count() << PAGE_SHIFT;
+
+	} else {
+		res = snapshot_check_user_key_switch(data);
+		if (res)
+			return res;
+	}
+
 	/*
 	 * The first buffer is the associated data, set to the offset to prevent
 	 * attacks that rearrange chunks.
@@ -42,6 +84,11 @@ static int snapshot_encrypt_refill(struct snapshot_data *data)
 	for (pg_idx = 0; pg_idx < CHUNK_SIZE; pg_idx++) {
 		void *buf = data->crypt_pages[pg_idx];
 
+		/* Stop at the meta page boundary to potentially switch keys. */
+		if (total &&
+		    ((data->crypt_total + total) == data->meta_size))
+			break;
+
 		res = snapshot_read_next(&data->handle);
 		if (res < 0)
 			return res;
@@ -114,10 +161,10 @@ static int snapshot_decrypt_drain(struct snapshot_data *data)
 		sg_set_buf(&data->sg[1 + pg_idx], data->crypt_pages[pg_idx], PAGE_SIZE);
 
 	/*
-	 * It's possible this is the final decrypt, and there are fewer than
-	 * CHUNK_SIZE pages. If this is the case we would have just written the
-	 * auth tag into the first few bytes of a new page. Copy to the tag if
-	 * so.
+	 * It's possible this is the final decrypt, or the final decrypt of the
+	 * meta region, and there are fewer than CHUNK_SIZE pages. If this is
+	 * the case we would have just written the auth tag into the first few
+	 * bytes of a new page. Copy to the tag if so.
 	 */
 	if ((page_count < CHUNK_SIZE) &&
 	    (data->crypt_offset - total) == sizeof(data->auth_tag)) {
@@ -172,7 +219,14 @@ static int snapshot_decrypt_drain(struct snapshot_data *data)
 		total += PAGE_SIZE;
 	}
 
+	if (data->crypt_total == 0)
+		data->meta_size = snapshot_get_meta_page_count() << PAGE_SHIFT;
+
 	data->crypt_total += total;
+	res = snapshot_check_user_key_switch(data);
+	if (res)
+		return res;
+
 	return 0;
 }
 
@@ -221,8 +275,26 @@ static ssize_t snapshot_write_next_encrypted(struct snapshot_data *data,
 	if (data->crypt_offset < (PAGE_SIZE * CHUNK_SIZE)) {
 		size_t pg_idx = data->crypt_offset >> PAGE_SHIFT;
 		size_t pg_off = data->crypt_offset & (PAGE_SIZE - 1);
+		size_t size_avail = PAGE_SIZE;
 		*buf = data->crypt_pages[pg_idx] + pg_off;
-		return PAGE_SIZE - pg_off;
+
+		/*
+		 * If this is the boundary where the meta pages end, then just
+		 * return enough for the auth tag.
+		 */
+		if (data->meta_size && (data->crypt_total < data->meta_size)) {
+			uint64_t total_done =
+				data->crypt_total + data->crypt_offset;
+
+			if ((total_done >= data->meta_size) &&
+			    (total_done <
+			     (data->meta_size + SNAPSHOT_AUTH_TAG_SIZE))) {
+
+				size_avail = SNAPSHOT_AUTH_TAG_SIZE;
+			}
+		}
+
+		return size_avail - pg_off;
 	}
 
 	/* Use offsets just beyond the size to return the tag. */
@@ -304,9 +376,15 @@ ssize_t snapshot_write_encrypted(struct snapshot_data *data,
 			break;
 		}
 
-		/* Drain the encrypted buffer if it's full. */
+		/*
+		 * Drain the encrypted buffer if it's full, or if we hit the end
+		 * of the meta pages and need a key change.
+		 */
 		if ((data->crypt_offset >=
-		    ((PAGE_SIZE * CHUNK_SIZE) + SNAPSHOT_AUTH_TAG_SIZE))) {
+		    ((PAGE_SIZE * CHUNK_SIZE) + SNAPSHOT_AUTH_TAG_SIZE)) ||
+		    (data->meta_size && (data->crypt_total < data->meta_size) &&
+		     ((data->crypt_total + data->crypt_offset) ==
+		      (data->meta_size + SNAPSHOT_AUTH_TAG_SIZE)))) {
 
 			int rc;
 
@@ -350,6 +428,8 @@ void snapshot_teardown_encryption(struct snapshot_data *data)
 			data->crypt_pages[i] = NULL;
 		}
 	}
+
+	memset(data->user_key, 0, sizeof(data->user_key));
 }
 
 static int snapshot_setup_encryption_common(struct snapshot_data *data)
@@ -359,6 +439,7 @@ static int snapshot_setup_encryption_common(struct snapshot_data *data)
 	data->crypt_total = 0;
 	data->crypt_offset = 0;
 	data->crypt_size = 0;
+	data->user_key_valid = false;
 	memset(data->crypt_pages, 0, sizeof(data->crypt_pages));
 	/* This only works once per hibernate. */
 	if (data->aead_tfm)
@@ -661,15 +742,72 @@ int snapshot_set_encryption_key(struct snapshot_data *data,
 	return rc;
 }
 
-loff_t snapshot_get_encrypted_image_size(loff_t raw_size)
+static loff_t snapshot_encrypted_byte_count(loff_t plain_size)
 {
-	loff_t pages = raw_size >> PAGE_SHIFT;
+	loff_t pages = plain_size >> PAGE_SHIFT;
 	loff_t chunks = (pages + (CHUNK_SIZE - 1)) / CHUNK_SIZE;
 	/*
 	 * The encrypted size is the normal size, plus a stitched in
 	 * authentication tag for every chunk of pages.
 	 */
-	return raw_size + (chunks * SNAPSHOT_AUTH_TAG_SIZE);
+	return plain_size + (chunks * SNAPSHOT_AUTH_TAG_SIZE);
+}
+
+static loff_t snapshot_get_meta_data_size(void)
+{
+	loff_t pages = snapshot_get_meta_page_count();
+
+	return snapshot_encrypted_byte_count(pages << PAGE_SHIFT);
+}
+
+int snapshot_set_user_key(struct snapshot_data *data,
+	struct uswsusp_user_key __user *key)
+{
+	struct uswsusp_user_key user_key;
+	unsigned int key_len;
+	int rc;
+	loff_t size;
+
+	/*
+	 * Return the metadata size, the number of bytes that can be fed in before
+	 * the user data key is needed at resume time.
+	 */
+	size = snapshot_get_meta_data_size();
+	rc = put_user(size, &key->meta_size);
+	if (rc)
+		return rc;
+
+	rc = copy_from_user(&user_key, key, sizeof(struct uswsusp_user_key));
+	if (rc)
+		return rc;
+
+	key_len = min_t(__u32, user_key.key_len, sizeof(data->user_key));
+	if (key_len < 8)
+		return -EINVAL;
+
+	/* Don't allow it if it's too late. */
+	if (data->crypt_total > data->meta_size)
+		return -EBUSY;
+
+	memset(data->user_key, 0, sizeof(data->user_key));
+	memcpy(data->user_key, user_key.key, key_len);
+	data->user_key_valid = true;
+	/* Install the key if the user is just under the wire. */
+	rc = snapshot_check_user_key_switch(data);
+	if (rc)
+		return rc;
+
+	return 0;
+}
+
+loff_t snapshot_get_encrypted_image_size(loff_t raw_size)
+{
+	loff_t pages = raw_size >> PAGE_SHIFT;
+	loff_t meta_size;
+
+	pages -= snapshot_get_meta_page_count();
+	meta_size = snapshot_get_meta_data_size();
+	return snapshot_encrypted_byte_count(pages << PAGE_SHIFT) + meta_size;
 }
 
 int snapshot_finalize_decrypted_image(struct snapshot_data *data)
diff --git a/kernel/power/snapshot.c b/kernel/power/snapshot.c
index 2a406753af9049..026ee511633bc9 100644
--- a/kernel/power/snapshot.c
+++ b/kernel/power/snapshot.c
@@ -2083,6 +2083,11 @@ unsigned long snapshot_get_image_size(void)
 	return nr_copy_pages + nr_meta_pages + 1;
 }
 
+unsigned long snapshot_get_meta_page_count(void)
+{
+	return nr_meta_pages + 1;
+}
+
 static int init_header(struct swsusp_info *info)
 {
 	memset(info, 0, sizeof(struct swsusp_info));
diff --git a/kernel/power/user.c b/kernel/power/user.c
index bba5cdbd2c0239..a66e32c9596da8 100644
--- a/kernel/power/user.c
+++ b/kernel/power/user.c
@@ -427,6 +427,10 @@ static long snapshot_ioctl(struct file *filp, unsigned int cmd,
 			error = snapshot_set_encryption_key(data, (void __user *)arg);
 		break;
 
+	case SNAPSHOT_SET_USER_KEY:
+		error = snapshot_set_user_key(data, (void __user *)arg);
+		break;
+
 	default:
 		error = -ENOTTY;
 
diff --git a/kernel/power/user.h b/kernel/power/user.h
index 6c86fb64ebe13e..c1e80a835d0a38 100644
--- a/kernel/power/user.h
+++ b/kernel/power/user.h
@@ -32,6 +32,9 @@ struct snapshot_data {
 	uint64_t nonce_low;
 	uint64_t nonce_high;
 	struct key *key;
+	u8 user_key[SNAPSHOT_ENCRYPTION_KEY_SIZE];
+	bool user_key_valid;
+	uint64_t meta_size;
 #endif
 
 };
@@ -55,6 +58,9 @@ int snapshot_get_encryption_key(struct snapshot_data *data,
 int snapshot_set_encryption_key(struct snapshot_data *data,
 				struct uswsusp_key_blob __user *key);
 
+int snapshot_set_user_key(struct snapshot_data *data,
+	struct uswsusp_user_key __user *key);
+
 loff_t snapshot_get_encrypted_image_size(loff_t raw_size);
 
 int snapshot_finalize_decrypted_image(struct snapshot_data *data);
@@ -89,6 +95,12 @@ static int snapshot_set_encryption_key(struct snapshot_data *data,
 	return -ENOTTY;
 }
 
+static int snapshot_set_user_key(struct snapshot_data *data,
+	struct uswsusp_user_key __user *key)
+{
+	return -ENOTTY;
+}
+
 static loff_t snapshot_get_encrypted_image_size(loff_t raw_size)
 {
 	return raw_size;
-- 
2.38.1.431.g37b22c650d-goog

