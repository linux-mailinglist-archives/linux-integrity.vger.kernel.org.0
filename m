Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB96E626578
	for <lists+linux-integrity@lfdr.de>; Sat, 12 Nov 2022 00:21:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234734AbiKKXVE (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 11 Nov 2022 18:21:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234658AbiKKXU2 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 11 Nov 2022 18:20:28 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B36D86D66
        for <linux-integrity@vger.kernel.org>; Fri, 11 Nov 2022 15:19:59 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id 4so5420886pli.0
        for <linux-integrity@vger.kernel.org>; Fri, 11 Nov 2022 15:19:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fYb7Pc7kk00iZIixiz1ShzY4z/wZpG44t4abSwKlK2k=;
        b=YsrTyClPvsWKOPUOmdMjFm3cMJd+VRq4mdvYTJHKJR8FbxBBdRBDvmV+VIuyla+V10
         4VBd9zqYyPp4bHY3aYNLW86+5FWLUQW+brN4cYdvvrLpxgUQzt0En2KhqKPDgAo+FSS1
         ITPaUkDCPa6LT+NLfRfX8fNR63T6F6OkGNraI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fYb7Pc7kk00iZIixiz1ShzY4z/wZpG44t4abSwKlK2k=;
        b=QsK4LTqoAB3brLLdf1Cn5yJ6uvudH/RK7AIMtH/zaZ4rc++nF1q8IO4D0ht+bRpn7m
         CePUUR/yWufYDUpBRyIZGQWK7vASa+c9G5MjKc38nhYxqg5jCu3ZtVCSsYDa3mpTIJxU
         z7BkHxez+Fzv41ShXAol+Dp5Q1xW/GzrFBW49BH1jKAyqOiVUf5W43LPgRFQT5xzk37N
         Z88gyalBQKwupF1cf2F1OwDO9chHi6b97lwBv6V7vdf/mWi5lb/oVcwjzG9b+uSxSFIy
         lv3179PtPhXEodpp/MfqE8rgQ9y4L3MU/UAaGp3QU7A2/bLUpJONVL+OeorRkmezmalH
         ng4A==
X-Gm-Message-State: ANoB5pk63W8oWLR59d+a52CEaEwgjxGtg9ifM8zoloWGX5W9FwMQOAWR
        P4kTmlIRLti7D1IOf+cDft4Hdw==
X-Google-Smtp-Source: AA0mqf5DEXa06bh3icgkK9RTugU4V7dfjDh1o93t+vywCXKUK2pWdElRBv/y9vBCEVYOM16Tz4oKmg==
X-Received: by 2002:a17:902:c115:b0:180:87d7:9be8 with SMTP id 21-20020a170902c11500b0018087d79be8mr4327747pli.85.1668208799133;
        Fri, 11 Nov 2022 15:19:59 -0800 (PST)
Received: from evgreen-glaptop.lan ([98.45.28.95])
        by smtp.gmail.com with ESMTPSA id x128-20020a623186000000b0056da2ad6503sm2106900pfx.39.2022.11.11.15.19.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Nov 2022 15:19:58 -0800 (PST)
From:   Evan Green <evgreen@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     corbet@lwn.net, linux-integrity@vger.kernel.org,
        Eric Biggers <ebiggers@kernel.org>, gwendal@chromium.org,
        dianders@chromium.org, apronin@chromium.org,
        Pavel Machek <pavel@ucw.cz>, Ben Boeckel <me@benboeckel.net>,
        rjw@rjwysocki.net, jejb@linux.ibm.com,
        Kees Cook <keescook@chromium.org>, dlunev@google.com,
        zohar@linux.ibm.com, Matthew Garrett <mgarrett@aurora.tech>,
        jarkko@kernel.org, linux-pm@vger.kernel.org,
        Evan Green <evgreen@chromium.org>,
        Matthew Garrett <mjg59@google.com>,
        Len Brown <len.brown@intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH v5 10/11] PM: hibernate: Verify the digest encryption key
Date:   Fri, 11 Nov 2022 15:16:35 -0800
Message-Id: <20221111151451.v5.10.I504d456c7a94ef1aaa7a2c63775ce9690c3ad7ab@changeid>
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
In-Reply-To: <20221111231636.3748636-1-evgreen@chromium.org>
References: <20221111231636.3748636-1-evgreen@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

We want to ensure that the key used to encrypt the digest was created by
the kernel during hibernation. To do this we request that the TPM
include information about the value of PCR 23 at the time of key
creation in the sealed blob. On resume, we can make sure that the PCR
information in the creation data blob (already certified by the TPM to
be accurate) corresponds to the expected value. Since only
the kernel can touch PCR 23, if an attacker generates a key themselves
the value of PCR 23 will have been different, allowing us to reject the
key and boot normally instead of resuming.

Co-developed-by: Matthew Garrett <mjg59@google.com>
Signed-off-by: Matthew Garrett <mjg59@google.com>
Signed-off-by: Evan Green <evgreen@chromium.org>

---
Matthew's original version of this patch is here:
https://patchwork.kernel.org/project/linux-pm/patch/20210220013255.1083202-9-matthewgarrett@google.com/

I moved the TPM2_CC_CERTIFYCREATION code into a separate change in the
trusted key code because the blob_handle was being flushed and was no
longer valid for use in CC_CERTIFYCREATION after the key was loaded. As
an added benefit of moving the certification into the trusted keys code,
we can drop the other patch from the original series that squirrelled
the blob_handle away.

Changes in v5:
 - Use a struct to access creation data (Kees)
 - Build PCR bitmask programmatically in creation data (Kees)

Changes in v4:
 - Local variable reordering (Jarkko)

Changes in v3:
 - Changed funky tag to Co-developed-by (Kees). Matthew, holler if you
   want something different.

Changes in v2:
 - Fixed some sparse warnings
 - Use CRYPTO_LIB_SHA256 to get rid of sha256_data() (Eric)
 - Adjusted offsets due to new ASN.1 format, and added a creation data
   length check.

 kernel/power/snapenc.c | 122 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 120 insertions(+), 2 deletions(-)

diff --git a/kernel/power/snapenc.c b/kernel/power/snapenc.c
index 0b38642628f7ce..f32c7347a330a4 100644
--- a/kernel/power/snapenc.c
+++ b/kernel/power/snapenc.c
@@ -22,6 +22,12 @@ static struct tpm_digest known_digest = { .alg_id = TPM_ALG_SHA256,
 		   0xf1, 0x22, 0x38, 0x6c, 0x33, 0xb1, 0x14, 0xb7, 0xec, 0x05,
 		   0x5f, 0x49}};
 
+/* sha256(sha256(empty_pcr | known_digest)) */
+static const char expected_digest[] = {0x2f, 0x96, 0xf2, 0x1b, 0x70, 0xa9, 0xe8,
+	0x42, 0x25, 0x8e, 0x66, 0x07, 0xbe, 0xbc, 0xe3, 0x1f, 0x2c, 0x84, 0x4a,
+	0x3f, 0x85, 0x17, 0x31, 0x47, 0x9a, 0xa5, 0x53, 0xbb, 0x23, 0x0c, 0x32,
+	0xf3};
+
 /* Derive a key from the kernel and user keys for data encryption. */
 static int snapshot_use_user_key(struct snapshot_data *data)
 {
@@ -491,7 +497,7 @@ static int snapshot_setup_encryption_common(struct snapshot_data *data)
 static int snapshot_create_kernel_key(struct snapshot_data *data)
 {
 	/* Create a key sealed by the SRK. */
-	char *keyinfo = "new\t32\tkeyhandle=0x81000000";
+	char *keyinfo = "new\t32\tkeyhandle=0x81000000\tcreationpcrs=0x00800000";
 	const struct cred *cred = current_cred();
 	struct tpm_digest *digests = NULL;
 	struct key *key = NULL;
@@ -612,17 +618,57 @@ int snapshot_get_encryption_key(struct snapshot_data *data,
 	return rc;
 }
 
+/* Currently only PCR23 is included in the creation data. */
+#define SNAPSHOT_KEY_PCR_COUNT 1
+
+/* The standard set of 24 PCRs takes 3 bytes to represent as a bitmask. */
+#define SNAPSHOT_KEY_PCR_SELECTION_BYTES 3
+
+/*
+ * The TPM loves to return variable length structures. This is the form of
+ * TPM2B_CREATION_DATA expected and verified for the snapshot key.
+ */
+struct snapshot_key_creation_data {
+	__be16 size;
+	/* TPMS_CREATION_DATA, the hashed portion */
+	struct {
+		/* TPML_PCR_SELECTION */
+		struct {
+			__be32 count;
+			/* TPMS_PCR_SELECTION */
+			struct {
+				__be16 hash_algo;
+				u8 size;
+				u8 select[SNAPSHOT_KEY_PCR_SELECTION_BYTES];
+			} __packed pcr_selections;
+		} __packed pcr_select;
+
+		/* TPM2B_DIGEST */
+		struct {
+			__be16 size;
+			u8 digest[SHA256_DIGEST_SIZE];
+		} __packed pcr_digest[SNAPSHOT_KEY_PCR_COUNT];
+
+		/* ... additional fields not verified ... */
+	} creation;
+} __packed;
+
 static int snapshot_load_kernel_key(struct snapshot_data *data,
 				    struct uswsusp_key_blob *blob)
 {
 
 	char *keytemplate = "load\t%s\tkeyhandle=0x81000000";
+	struct snapshot_key_creation_data *creation;
 	const struct cred *cred = current_cred();
+	struct trusted_key_payload *payload;
+	char certhash[SHA256_DIGEST_SIZE];
 	struct tpm_digest *digests = NULL;
+	unsigned int creation_hash_length;
 	char *blobstring = NULL;
 	struct key *key = NULL;
 	struct tpm_chip *chip;
 	char *keyinfo = NULL;
+	u32 pcr_selection = 0;
 	int i, ret;
 
 	chip = tpm_default_chip();
@@ -640,8 +686,10 @@ static int snapshot_load_kernel_key(struct snapshot_data *data,
 
 	digests = kcalloc(chip->nr_allocated_banks, sizeof(struct tpm_digest),
 			  GFP_KERNEL);
-	if (!digests)
+	if (!digests) {
+		ret = -ENOMEM;
 		goto out;
+	}
 
 	for (i = 0; i < chip->nr_allocated_banks; i++) {
 		digests[i].alg_id = chip->allocated_banks[i].alg_id;
@@ -681,6 +729,76 @@ static int snapshot_load_kernel_key(struct snapshot_data *data,
 	if (ret != 0)
 		goto out;
 
+	/* Verify the creation hash matches the creation data. */
+	payload = key->payload.data[0];
+	creation = (struct snapshot_key_creation_data *)payload->creation;
+	if (!creation || !payload->creation_hash ||
+	    (payload->creation_len < sizeof(*creation)) ||
+	    (payload->creation_hash_len - 2 != SHA256_DIGEST_SIZE)) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	creation_hash_length =
+		payload->creation_len -
+		offsetof(struct snapshot_key_creation_data, creation);
+
+	sha256((const u8 *)&creation->creation, creation_hash_length, certhash);
+	if (memcmp(payload->creation_hash + sizeof(__be16), certhash, SHA256_DIGEST_SIZE) != 0) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	/* We now know that the creation data is authentic - parse it */
+
+	/* Verify TPML_PCR_SELECTION.count */
+	if (be32_to_cpu(creation->creation.pcr_select.count) !=
+	    SNAPSHOT_KEY_PCR_COUNT) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	/* Verify the PCRs are SHA256. */
+	if (be16_to_cpu(creation->creation.pcr_select.pcr_selections.hash_algo) !=
+	    TPM_ALG_SHA256) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	/* Gather the PCR selection bitmask. */
+	if (creation->creation.pcr_select.pcr_selections.size !=
+	    SNAPSHOT_KEY_PCR_SELECTION_BYTES) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	for (i = SNAPSHOT_KEY_PCR_SELECTION_BYTES - 1; i >= 0; i--) {
+		pcr_selection <<= 8;
+		pcr_selection |=
+			creation->creation.pcr_select.pcr_selections.select[i];
+	}
+
+	/* Verify PCR 23 is selected. */
+	if (pcr_selection != (1 << 23)) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	/* Verify the first and only PCR hash is the expected size. */
+	if (be16_to_cpu(creation->creation.pcr_digest[0].size) !=
+	    SHA256_DIGEST_SIZE) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	/* Verify PCR 23 contained the expected value when the key was created. */
+	if (memcmp(&creation->creation.pcr_digest[0].digest, expected_digest,
+		   SHA256_DIGEST_SIZE) != 0) {
+
+		ret = -EINVAL;
+		goto out;
+	}
+
 	data->key = key;
 	key = NULL;
 
-- 
2.38.1.431.g37b22c650d-goog

