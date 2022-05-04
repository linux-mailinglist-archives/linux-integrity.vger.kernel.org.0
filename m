Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEA3951B454
	for <lists+linux-integrity@lfdr.de>; Thu,  5 May 2022 02:09:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359450AbiEEABb (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 4 May 2022 20:01:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385492AbiEDXZ0 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 4 May 2022 19:25:26 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37E744EA0B
        for <linux-integrity@vger.kernel.org>; Wed,  4 May 2022 16:21:49 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id x18so2823786plg.6
        for <linux-integrity@vger.kernel.org>; Wed, 04 May 2022 16:21:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=T0Ha5PjFrQlu4myFqDfG5tFx9BSiu6/SZECZT4sF2bI=;
        b=lygx6dOsIFOk6hF+4C4Y8LRBekgsVCS6E/2MWFWQDMqc5bqCTYepfliMJM1myFV70X
         jLFK02Fm2WKNyG22x0nZg+TsW5CsKzRyxkbYqV5+/PZ+gd4MpqDNr7coCd5Kt+2BDZNd
         ONxJuOjN2+D6qeZ3Xquf1Dcw1BHsLe77ypccU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=T0Ha5PjFrQlu4myFqDfG5tFx9BSiu6/SZECZT4sF2bI=;
        b=N34Z04rYKmbVIQyWUVEYKEVEitV8WYINrUmOE17Qn0ezLjDX8Kwomu5wmQKRmZWUEl
         AspxRNNniUzpGzTLF9QiH7ypHbRqA8XouZg0ThudYQAITRAANrJQcvlbGCU9DeF+pL+P
         aq9ENDXFB9ZynR/6tpGzIHDyCHuHqTSpsKDHiqe21oE//SxMmBbqENsNIe7Ywg+m2Yli
         oiPEm8Ytpzsna54TUx6AIq1nK6fCCMprPY1JShnwkNLFs6LLOYj3JmxpWDHju4v7/iM/
         /hJXBmd7vRX7twOwd8YWVv7qlgnjv4ceZ5JwuB+Ny5OdpD3ijXIo+vIKV9Uafi4TGj35
         g4pw==
X-Gm-Message-State: AOAM532lsJ0d5gZw+hgrgfCNRgOvyTkGvDOc/2SntqqS0oJ8e6/NYcOn
        ve/JKJM4HDJVkTaYF5+BKUFZRQ==
X-Google-Smtp-Source: ABdhPJwTek7lbCixRIDyD0usxwvu26W1HK2YAo0odHiNuXLR54TGcMPEtMfBRJ0xUOtP1S0Xrla3iw==
X-Received: by 2002:a17:903:22c9:b0:15e:a8a0:2a79 with SMTP id y9-20020a17090322c900b0015ea8a02a79mr16125068plg.31.1651706508866;
        Wed, 04 May 2022 16:21:48 -0700 (PDT)
Received: from evgreen-glaptop.lan ([98.47.98.87])
        by smtp.gmail.com with ESMTPSA id q12-20020a170902f78c00b0015e8d4eb2d6sm1901pln.288.2022.05.04.16.21.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 May 2022 16:21:48 -0700 (PDT)
From:   Evan Green <evgreen@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Matthew Garrett <mgarrett@aurora.tech>, dlunev@google.com,
        zohar@linux.ibm.com, jejb@linux.ibm.com,
        linux-integrity@vger.kernel.org, corbet@lwn.net, rjw@rjwysocki.net,
        gwendal@chromium.org, jarkko@kernel.org, linux-pm@vger.kernel.org,
        Evan Green <evgreen@chromium.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH 09/10] PM: hibernate: Verify the digest encryption key
Date:   Wed,  4 May 2022 16:21:01 -0700
Message-Id: <20220504161439.9.I504d456c7a94ef1aaa7a2c63775ce9690c3ad7ab@changeid>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20220504232102.469959-1-evgreen@chromium.org>
References: <20220504232102.469959-1-evgreen@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

 kernel/power/snapenc.c | 96 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 94 insertions(+), 2 deletions(-)

diff --git a/kernel/power/snapenc.c b/kernel/power/snapenc.c
index 067f49c05a4d54..38bc820f780d8b 100644
--- a/kernel/power/snapenc.c
+++ b/kernel/power/snapenc.c
@@ -23,6 +23,45 @@ static struct tpm_digest known_digest = { .alg_id = TPM_ALG_SHA256,
 		   0xf1, 0x22, 0x38, 0x6c, 0x33, 0xb1, 0x14, 0xb7, 0xec, 0x05,
 		   0x5f, 0x49}};
 
+/* sha256(sha256(empty_pcr | known_digest)) */
+static const char expected_digest[] = {0x2f, 0x96, 0xf2, 0x1b, 0x70, 0xa9, 0xe8,
+	0x42, 0x25, 0x8e, 0x66, 0x07, 0xbe, 0xbc, 0xe3, 0x1f, 0x2c, 0x84, 0x4a,
+	0x3f, 0x85, 0x17, 0x31, 0x47, 0x9a, 0xa5, 0x53, 0xbb, 0x23, 0x0c, 0x32,
+	0xf3};
+
+static int sha256_data(char *buf, int size, char *output)
+{
+	struct crypto_shash *tfm;
+	struct shash_desc *desc;
+	int ret;
+
+	tfm = crypto_alloc_shash("sha256", 0, 0);
+	if (IS_ERR(tfm))
+		return PTR_ERR(tfm);
+
+	desc = kmalloc(sizeof(struct shash_desc) +
+			       crypto_shash_descsize(tfm), GFP_KERNEL);
+	if (!desc) {
+		crypto_free_shash(tfm);
+		return -ENOMEM;
+	}
+
+	desc->tfm = tfm;
+	ret = crypto_shash_init(desc);
+	if (ret != 0) {
+		crypto_free_shash(tfm);
+		kfree(desc);
+		return ret;
+	}
+
+	crypto_shash_update(desc, buf, size);
+	crypto_shash_final(desc, output);
+	crypto_free_shash(desc->tfm);
+	kfree(desc);
+
+	return 0;
+}
+
 /* Derive a key from the kernel and user keys for data encryption. */
 static int snapshot_use_user_key(struct snapshot_data *data)
 {
@@ -515,7 +554,7 @@ static int snapshot_create_kernel_key(struct snapshot_data *data)
 	struct key *key;
 	int ret, i;
 	/* Create a key sealed by the SRK. */
-	char *keyinfo = "new\t32\tkeyhandle=0x81000000";
+	char *keyinfo = "new\t32\tkeyhandle=0x81000000\tcreationpcrs=0x00800000";
 
 	chip = tpm_default_chip();
 	if (!chip)
@@ -628,6 +667,7 @@ static int snapshot_load_kernel_key(struct snapshot_data *data,
 	struct uswsusp_key_blob *blob)
 {
 
+	char certhash[SHA256_DIGEST_SIZE];
 	const struct cred *cred = current_cred();
 	char *keytemplate = "load\t%s\tkeyhandle=0x81000000";
 	struct tpm_digest *digests = NULL;
@@ -635,6 +675,7 @@ static int snapshot_load_kernel_key(struct snapshot_data *data,
 	char *keyinfo = NULL;
 	struct tpm_chip *chip;
 	struct key *key;
+	struct trusted_key_payload *payload;
 	int i, ret;
 
 	chip = tpm_default_chip();
@@ -650,8 +691,10 @@ static int snapshot_load_kernel_key(struct snapshot_data *data,
 
 	digests = kcalloc(chip->nr_allocated_banks, sizeof(struct tpm_digest),
 			  GFP_KERNEL);
-	if (!digests)
+	if (!digests) {
+		ret = -ENOMEM;
 		goto reset;
+	}
 
 	for (i = 0; i <= chip->nr_allocated_banks; i++) {
 		digests[i].alg_id = chip->allocated_banks[i].alg_id;
@@ -690,6 +733,55 @@ static int snapshot_load_kernel_key(struct snapshot_data *data,
 	if (ret < 0)
 		goto out;
 
+	/* Verify the creation hash matches the creation data. */
+	payload = key->payload.data[0];
+	ret = sha256_data(payload->creation, payload->creation_len, certhash);
+	if (ret < 0)
+		goto out;
+
+	if (memcmp(payload->creation_hash, certhash, SHA256_DIGEST_SIZE) != 0) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	/* We now know that the creation data is authentic - parse it */
+
+	/* TPML_PCR_SELECTION.count */
+	if (be32_to_cpu(*(int *)payload->creation) != 1) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	if (be16_to_cpu(*(u16 *)&payload->creation[4]) != TPM_ALG_SHA256) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	if (*(char *)&payload->creation[6] != 3) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	/* PCR 23 selected */
+	if (be32_to_cpu(*(int *)&payload->creation[6]) != 0x03000080) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	if (be16_to_cpu(*(u16 *)&payload->creation[10]) !=
+	    SHA256_DIGEST_SIZE) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	/* Verify PCR 23 contained the expected value when the key was created. */
+	if (memcmp(&payload->creation[12], expected_digest,
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

