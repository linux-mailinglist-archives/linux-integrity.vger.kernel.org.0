Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1F5159EF19
	for <lists+linux-integrity@lfdr.de>; Wed, 24 Aug 2022 00:27:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233638AbiHWW0y (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 23 Aug 2022 18:26:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233642AbiHWW0R (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 23 Aug 2022 18:26:17 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA17E87696
        for <linux-integrity@vger.kernel.org>; Tue, 23 Aug 2022 15:26:09 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id s3-20020a17090a2f0300b001facfc6fdbcso15428376pjd.1
        for <linux-integrity@vger.kernel.org>; Tue, 23 Aug 2022 15:26:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=h89V1jB8raz93s1UBdB755/qSlB/lATdkVzyb86xPlg=;
        b=nUlTu7qh1+o9COlB+JNxnTLFZQTa21AWzmc5sREQt16+4GKZCIQRkcyAEa9vEdLjFC
         MLZN9LcUOkjMGlexXqOKvML0eL7cxFfEybdFjI4Golhz8r3+DMqZvh8D2yrr+i813YdN
         D3AF/4liowxe+gcSd9iEKQUzpVAGnA7uWp0BE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=h89V1jB8raz93s1UBdB755/qSlB/lATdkVzyb86xPlg=;
        b=e8U+ew8OXxiE+Hb5o+b6JOdHfbG8PYS9I9L93kHZkDbxFsQCmi7L3cFEnfiCWvkFmT
         6cFGig2wsXtg57iTskmhKFoxU8f41NKlQFUupFleowxNAN6gcGEZXwQ9Bt7Gqxd663uo
         895aknI3aaX0syOOmHK8xARc7UCroLlhZJgf0Gkdm1um72gYp361/EnZCRSuCW8U7rEa
         ZdZrxQSBo769Hcq4k0hcg5L8WT6d3gmOv+m619zdXJltIEyBt+h2fE1HCDC2KdUREG3M
         5s2lfD3JZK7pivvo//LxykIukFirhwjkozrlJ24uvZ86iNMSW5hHLo7suho/j5OPbG/W
         VqMw==
X-Gm-Message-State: ACgBeo27eg11lM5v78RbABALfxfD9sQ0jOZ5lbMZ1oHv/BtPyUaQalFF
        C0pFNTHpXPtwnOcBcrVY5ew3pg==
X-Google-Smtp-Source: AA6agR6HauYb0XBAWZ9hxasy/RS63+xeO6/mMszxWoZRfjFzB6BGPJ5MpePgHRrY3xKu2KtNxa7bXA==
X-Received: by 2002:a17:90a:e7c2:b0:1f5:85ab:938c with SMTP id kb2-20020a17090ae7c200b001f585ab938cmr5289101pjb.133.1661293569204;
        Tue, 23 Aug 2022 15:26:09 -0700 (PDT)
Received: from evgreen-glaptop.lan ([98.45.66.167])
        by smtp.gmail.com with ESMTPSA id f76-20020a62384f000000b0052f20d70845sm11256292pfa.150.2022.08.23.15.26.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Aug 2022 15:26:08 -0700 (PDT)
From:   Evan Green <evgreen@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     gwendal@chromium.org, Eric Biggers <ebiggers@kernel.org>,
        Matthew Garrett <mgarrett@aurora.tech>, jarkko@kernel.org,
        zohar@linux.ibm.com, linux-integrity@vger.kernel.org,
        Pavel Machek <pavel@ucw.cz>, apronin@chromium.org,
        dlunev@google.com, rjw@rjwysocki.net, linux-pm@vger.kernel.org,
        corbet@lwn.net, jejb@linux.ibm.com,
        Matthew Garrett <matthewgarrett@google.com>,
        Matthew Garrett <mjg59@google.com>,
        Evan Green <evgreen@chromium.org>,
        David Howells <dhowells@redhat.com>,
        James Morris <jmorris@namei.org>,
        Paul Moore <paul@paul-moore.com>,
        "Serge E. Hallyn" <serge@hallyn.com>, keyrings@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: [PATCH v2 04/10] security: keys: trusted: Allow storage of PCR values in creation data
Date:   Tue, 23 Aug 2022 15:25:20 -0700
Message-Id: <20220823152108.v2.4.I32591db064b6cdc91850d777f363c9d05c985b39@changeid>
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

From: Matthew Garrett <matthewgarrett@google.com>

When TPMs generate keys, they can also generate some information
describing the state of the PCRs at creation time. This data can then
later be certified by the TPM, allowing verification of the PCR values.
This allows us to determine the state of the system at the time a key
was generated. Add an additional argument to the trusted key creation
options, allowing the user to provide the set of PCRs that should have
their values incorporated into the creation data.

From: Matthew Garrett <mjg59@google.com>
Signed-off-by: Matthew Garrett <mjg59@google.com>

Signed-off-by: Evan Green <evgreen@chromium.org>

---
Matthew's original version of this patch is at:
https://patchwork.kernel.org/patch/12096503/

(no changes since v1)

 .../security/keys/trusted-encrypted.rst       |  4 +++
 include/keys/trusted-type.h                   |  1 +
 security/keys/trusted-keys/trusted_tpm1.c     |  9 +++++++
 security/keys/trusted-keys/trusted_tpm2.c     | 25 +++++++++++++++++--
 4 files changed, 37 insertions(+), 2 deletions(-)

diff --git a/Documentation/security/keys/trusted-encrypted.rst b/Documentation/security/keys/trusted-encrypted.rst
index 0bfb4c33974890..dc9e11bb4824da 100644
--- a/Documentation/security/keys/trusted-encrypted.rst
+++ b/Documentation/security/keys/trusted-encrypted.rst
@@ -199,6 +199,10 @@ Usage::
        policyhandle= handle to an authorization policy session that defines the
                      same policy and with the same hash algorithm as was used to
                      seal the key.
+       creationpcrs= hex integer representing the set of PCR values to be
+                     included in the PCR creation data. The bit corresponding
+		     to each PCR should be 1 to be included, 0 to be ignored.
+		     TPM2 only.
 
 "keyctl print" returns an ascii hex copy of the sealed key, which is in standard
 TPM_STORED_DATA format.  The key length for new keys are always in bytes.
diff --git a/include/keys/trusted-type.h b/include/keys/trusted-type.h
index 209086fed240a5..8523d41507b2a4 100644
--- a/include/keys/trusted-type.h
+++ b/include/keys/trusted-type.h
@@ -54,6 +54,7 @@ struct trusted_key_options {
 	uint32_t policydigest_len;
 	unsigned char policydigest[MAX_DIGEST_SIZE];
 	uint32_t policyhandle;
+	uint32_t creation_pcrs;
 };
 
 struct trusted_key_ops {
diff --git a/security/keys/trusted-keys/trusted_tpm1.c b/security/keys/trusted-keys/trusted_tpm1.c
index aa108bea6739b3..2975827c01bec0 100644
--- a/security/keys/trusted-keys/trusted_tpm1.c
+++ b/security/keys/trusted-keys/trusted_tpm1.c
@@ -713,6 +713,7 @@ enum {
 	Opt_hash,
 	Opt_policydigest,
 	Opt_policyhandle,
+	Opt_creationpcrs,
 };
 
 static const match_table_t key_tokens = {
@@ -725,6 +726,7 @@ static const match_table_t key_tokens = {
 	{Opt_hash, "hash=%s"},
 	{Opt_policydigest, "policydigest=%s"},
 	{Opt_policyhandle, "policyhandle=%s"},
+	{Opt_creationpcrs, "creationpcrs=%s"},
 	{Opt_err, NULL}
 };
 
@@ -858,6 +860,13 @@ static int getoptions(char *c, struct trusted_key_payload *pay,
 				return -EINVAL;
 			opt->policyhandle = handle;
 			break;
+		case Opt_creationpcrs:
+			if (!tpm2)
+				return -EINVAL;
+			res = kstrtoint(args[0].from, 16, &opt->creation_pcrs);
+			if (res < 0)
+				return -EINVAL;
+			break;
 		default:
 			return -EINVAL;
 		}
diff --git a/security/keys/trusted-keys/trusted_tpm2.c b/security/keys/trusted-keys/trusted_tpm2.c
index 1f166d4fa307a9..1d1470b880ca01 100644
--- a/security/keys/trusted-keys/trusted_tpm2.c
+++ b/security/keys/trusted-keys/trusted_tpm2.c
@@ -389,7 +389,7 @@ int tpm2_seal_trusted(struct tpm_chip *chip,
 	struct tpm_buf buf;
 	u32 hash;
 	u32 flags;
-	int i;
+	int i, j;
 	int rc;
 
 	for (i = 0; i < ARRAY_SIZE(tpm2_hash_map); i++) {
@@ -458,7 +458,28 @@ int tpm2_seal_trusted(struct tpm_chip *chip,
 	tpm_buf_append_u16(&buf, 0);
 
 	/* creation PCR */
-	tpm_buf_append_u32(&buf, 0);
+	if (options->creation_pcrs) {
+		/* One bank */
+		tpm_buf_append_u32(&buf, 1);
+		/* Which bank to use */
+		tpm_buf_append_u16(&buf, hash);
+		/* Length of the PCR bitmask */
+		tpm_buf_append_u8(&buf, 3);
+		/* PCR bitmask */
+		for (i = 0; i < 3; i++) {
+			char tmp = 0;
+
+			for (j = 0; j < 8; j++) {
+				char bit = (i * 8) + j;
+
+				if (options->creation_pcrs & (1 << bit))
+					tmp |= (1 << j);
+			}
+			tpm_buf_append_u8(&buf, tmp);
+		}
+	} else {
+		tpm_buf_append_u32(&buf, 0);
+	}
 
 	if (buf.flags & TPM_BUF_OVERFLOW) {
 		rc = -E2BIG;
-- 
2.31.0

