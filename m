Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99F9159EF37
	for <lists+linux-integrity@lfdr.de>; Wed, 24 Aug 2022 00:27:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234121AbiHWW1X (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 23 Aug 2022 18:27:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233888AbiHWW0f (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 23 Aug 2022 18:26:35 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E758B870AA
        for <linux-integrity@vger.kernel.org>; Tue, 23 Aug 2022 15:26:24 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id y141so14762937pfb.7
        for <linux-integrity@vger.kernel.org>; Tue, 23 Aug 2022 15:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=Tz3YQHlg7lPKnl8810X0eKouDRImUz/13B9zincHNWA=;
        b=Wv5JaMMYwHBpWL278QUwYO9DY6IaHzIbnhZDnYZ96/QvRII8RcbPWBWjeBtmIne9le
         qZjwLds3yzxRjEg6PMgQ3+ZKVDefOo/26u8/e5VZJ/cL5jfRNsSkaJDBND30BF5msNY5
         4x+4rQX6ve4nrYaBemGNl9KU+6ZM8ZYnIVDGQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=Tz3YQHlg7lPKnl8810X0eKouDRImUz/13B9zincHNWA=;
        b=CYyJ4VasPr/7fOgXXYVLjhwpTXvv3tHJzOEjCxJmOprU/qDzuXQTxA7Ah69sWhtKV1
         PXsOSAsehidDE4S+CvlETSDUB888Om4iwUco4iufHvnTlfwxfn4fzbjAk6zofGiOeJCz
         3auJ49sGJrV3H/d96TDKjdSP0GyIEi7l5C6dBtIeamvL2zxq4ZHGwF5UMV7m70StXHgi
         KPgTm7BDBoqfnXKyRwHPeUeDnM4LPjjPmS+qGdI+uIsf6khONSNr+fyefcBOZvEVuHKf
         tSQMirKTmGySPsCc9OfkjV/tJkfcHq6r82XP1qWBOaEgFC5CMgZbHCa8Kl7fcCIPlE8N
         S1JQ==
X-Gm-Message-State: ACgBeo3hGxwc4TUgLPn27rcy+zBu/IQ96nnGTdQ0BcDvx7DwNcrbkAeI
        fANUEV8Jwz6mMVQJzynnUtuEbg==
X-Google-Smtp-Source: AA6agR7FQ9WlKLJeWlN4z1N50CerpdT2pXOjpoZwpiqb82lHYslzyUvA7umGVzB89k5iWjoebs0Wdg==
X-Received: by 2002:aa7:94a4:0:b0:536:4ec6:2de2 with SMTP id a4-20020aa794a4000000b005364ec62de2mr16717815pfl.33.1661293584432;
        Tue, 23 Aug 2022 15:26:24 -0700 (PDT)
Received: from evgreen-glaptop.lan ([98.45.66.167])
        by smtp.gmail.com with ESMTPSA id f76-20020a62384f000000b0052f20d70845sm11256292pfa.150.2022.08.23.15.26.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Aug 2022 15:26:24 -0700 (PDT)
From:   Evan Green <evgreen@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     gwendal@chromium.org, Eric Biggers <ebiggers@kernel.org>,
        Matthew Garrett <mgarrett@aurora.tech>, jarkko@kernel.org,
        zohar@linux.ibm.com, linux-integrity@vger.kernel.org,
        Pavel Machek <pavel@ucw.cz>, apronin@chromium.org,
        dlunev@google.com, rjw@rjwysocki.net, linux-pm@vger.kernel.org,
        corbet@lwn.net, jejb@linux.ibm.com,
        Evan Green <evgreen@chromium.org>,
        Len Brown <len.brown@intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH v2 09/10] PM: hibernate: Verify the digest encryption key
Date:   Tue, 23 Aug 2022 15:25:25 -0700
Message-Id: <20220823152108.v2.9.I504d456c7a94ef1aaa7a2c63775ce9690c3ad7ab@changeid>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20220823222526.1524851-1-evgreen@chromium.org>
References: <20220823222526.1524851-1-evgreen@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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

Sourced-from: Matthew Garrett <mjg59@google.com>
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

Changes in v2:
 - Fixed some sparse warnings
 - Use CRYPTO_LIB_SHA256 to get rid of sha256_data() (Eric)
 - Adjusted offsets due to new ASN.1 format, and added a creation data
   length check.

 kernel/power/snapenc.c | 67 ++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 65 insertions(+), 2 deletions(-)

diff --git a/kernel/power/snapenc.c b/kernel/power/snapenc.c
index e0b902d2dcf13a..1f08942450775a 100644
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
@@ -486,7 +492,7 @@ static int snapshot_create_kernel_key(struct snapshot_data *data)
 	struct key *key = NULL;
 	int ret, i;
 	/* Create a key sealed by the SRK. */
-	char *keyinfo = "new\t32\tkeyhandle=0x81000000";
+	char *keyinfo = "new\t32\tkeyhandle=0x81000000\tcreationpcrs=0x00800000";
 
 	chip = tpm_default_chip();
 	if (!chip)
@@ -605,6 +611,7 @@ static int snapshot_load_kernel_key(struct snapshot_data *data,
 	struct uswsusp_key_blob *blob)
 {
 
+	char certhash[SHA256_DIGEST_SIZE];
 	const struct cred *cred = current_cred();
 	char *keytemplate = "load\t%s\tkeyhandle=0x81000000";
 	struct tpm_digest *digests = NULL;
@@ -612,6 +619,7 @@ static int snapshot_load_kernel_key(struct snapshot_data *data,
 	char *keyinfo = NULL;
 	struct tpm_chip *chip;
 	struct key *key = NULL;
+	struct trusted_key_payload *payload;
 	int i, ret;
 
 	chip = tpm_default_chip();
@@ -629,8 +637,10 @@ static int snapshot_load_kernel_key(struct snapshot_data *data,
 
 	digests = kcalloc(chip->nr_allocated_banks, sizeof(struct tpm_digest),
 			  GFP_KERNEL);
-	if (!digests)
+	if (!digests) {
+		ret = -ENOMEM;
 		goto out;
+	}
 
 	for (i = 0; i <= chip->nr_allocated_banks; i++) {
 		digests[i].alg_id = chip->allocated_banks[i].alg_id;
@@ -670,6 +680,59 @@ static int snapshot_load_kernel_key(struct snapshot_data *data,
 	if (ret != 0)
 		goto out;
 
+	/* Verify the creation hash matches the creation data. */
+	payload = key->payload.data[0];
+	if (!payload->creation || !payload->creation_hash ||
+	    (payload->creation_len < 3) ||
+	    (payload->creation_hash_len < SHA256_DIGEST_SIZE)) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	sha256(payload->creation + 2, payload->creation_len - 2, certhash);
+	if (memcmp(payload->creation_hash + 2, certhash, SHA256_DIGEST_SIZE) != 0) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	/* We now know that the creation data is authentic - parse it */
+
+	/* TPML_PCR_SELECTION.count */
+	if (be32_to_cpu(*(__be32 *)&payload->creation[2]) != 1) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	if (be16_to_cpu(*(__be16 *)&payload->creation[6]) != TPM_ALG_SHA256) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	if (*(char *)&payload->creation[8] != 3) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	/* PCR 23 selected */
+	if (be32_to_cpu(*(__be32 *)&payload->creation[8]) != 0x03000080) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	if (be16_to_cpu(*(__be16 *)&payload->creation[12]) !=
+	    SHA256_DIGEST_SIZE) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	/* Verify PCR 23 contained the expected value when the key was created. */
+	if (memcmp(&payload->creation[14], expected_digest,
+		   SHA256_DIGEST_SIZE) != 0) {
+
+		ret = -EINVAL;
+		goto out;
+	}
+
 	data->key = key;
 	key = NULL;
 
-- 
2.31.0

