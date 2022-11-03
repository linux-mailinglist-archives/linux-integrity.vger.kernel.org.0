Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CD466186F2
	for <lists+linux-integrity@lfdr.de>; Thu,  3 Nov 2022 19:04:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231474AbiKCSEw (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 3 Nov 2022 14:04:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229950AbiKCSEH (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 3 Nov 2022 14:04:07 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24E9F626A
        for <linux-integrity@vger.kernel.org>; Thu,  3 Nov 2022 11:01:47 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id gw22so2395239pjb.3
        for <linux-integrity@vger.kernel.org>; Thu, 03 Nov 2022 11:01:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=izZdOIN6JWP3fwMuNlCfXVu66JA2QFEY9SoPm54SNBw=;
        b=MOY3PJGr2LIy205MrPpag/ClsGw4MP56tI7WpOwNj6gRfuTiQCVn98MtRZStlxteOr
         z/rYnBoJ3tFl3LO6m2/egnvL4bcl7xkZx16guu7qdEyEmyMdVtcyQ9dR/pPXZQo6EsME
         JCOc9PvVPmrBN7ZLPAp3bUoEUQZ3DsvlFd5so=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=izZdOIN6JWP3fwMuNlCfXVu66JA2QFEY9SoPm54SNBw=;
        b=dO+BBULgHOLreNbyCrxaOFpueQDk6vY10HRiRVedNuve4g8Qklf9F3zxg3MHi7z/rp
         v/gl59MtBnVO54t0QQl+7OCrw9tPBZ6UQTDwe0qw7BTgBABzd8WpP6caAlNYNoXzaWrL
         AeyhQY6IcZrgbiUuzjqu6JC4Eb1s5Sa29gY8fHrSJb8FsBuA4VKPkX/7EKJ3IL4UTphj
         55o+kK9lRfT9vUJB4miUUkz69ADwJ92pzS1FKFJTPG12BFi5YuqjsAt6tJyzjxBcV8An
         r/xCTgFvo1Tm7YkoJuRUJizGnrrPl9CHdW75cwThUhIUdRKPPDNCr0or71GhIwKGfKC6
         1BIQ==
X-Gm-Message-State: ACrzQf2cxFD920Zr57mEWl5WCKEsSkq6f6dWk5D48j3XEvXrWbZe8Aet
        j838SlM+bYn7nyxY/aKVXAbiHg==
X-Google-Smtp-Source: AMsMyM6RmbXOOHxWXmI1WbxbS7/D6I8ewM4LRqfQX2jVykTakTV/EqKIJaeg9+BsosfNX6F7K9BLXw==
X-Received: by 2002:a17:90a:540e:b0:210:1e26:9422 with SMTP id z14-20020a17090a540e00b002101e269422mr31496427pjh.100.1667498506839;
        Thu, 03 Nov 2022 11:01:46 -0700 (PDT)
Received: from evgreen-glaptop.lan ([98.45.28.95])
        by smtp.gmail.com with ESMTPSA id t12-20020a1709027fcc00b00177fb862a87sm1000277plb.20.2022.11.03.11.01.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 11:01:46 -0700 (PDT)
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
        Matthew Garrett <matthewgarrett@google.com>,
        Matthew Garrett <mjg59@google.com>,
        Evan Green <evgreen@chromium.org>,
        Ben Boeckel <linux@me.benboeckel.net>,
        David Howells <dhowells@redhat.com>,
        James Morris <jmorris@namei.org>,
        Paul Moore <paul@paul-moore.com>,
        "Serge E. Hallyn" <serge@hallyn.com>, keyrings@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: [PATCH v4 05/11] security: keys: trusted: Allow storage of PCR values in creation data
Date:   Thu,  3 Nov 2022 11:01:13 -0700
Message-Id: <20221103105558.v4.5.I32591db064b6cdc91850d777f363c9d05c985b39@changeid>
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
In-Reply-To: <20221103180120.752659-1-evgreen@chromium.org>
References: <20221103180120.752659-1-evgreen@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
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

Link: https://lore.kernel.org/lkml/20210220013255.1083202-6-matthewgarrett@google.com/
Signed-off-by: Matthew Garrett <mjg59@google.com>
Signed-off-by: Evan Green <evgreen@chromium.org>
Reviewed-by: Ben Boeckel <linux@me.benboeckel.net>
---

(no changes since v3)

Changes in v3:
 - Clarified creationpcrs documentation (Ben)

 .../security/keys/trusted-encrypted.rst       |  6 +++++
 include/keys/trusted-type.h                   |  1 +
 security/keys/trusted-keys/trusted_tpm1.c     |  9 +++++++
 security/keys/trusted-keys/trusted_tpm2.c     | 25 +++++++++++++++++--
 4 files changed, 39 insertions(+), 2 deletions(-)

diff --git a/Documentation/security/keys/trusted-encrypted.rst b/Documentation/security/keys/trusted-encrypted.rst
index 9bc9db8ec6517c..a1872964fe862f 100644
--- a/Documentation/security/keys/trusted-encrypted.rst
+++ b/Documentation/security/keys/trusted-encrypted.rst
@@ -199,6 +199,12 @@ Usage::
        policyhandle= handle to an authorization policy session that defines the
                      same policy and with the same hash algorithm as was used to
                      seal the key.
+       creationpcrs= hex integer representing the set of PCRs to be
+                     included in the creation data. For each bit set, the
+                     corresponding PCR will be included in the key creation
+                     data. Bit 0 corresponds to PCR0. Currently only the first
+                     PC standard 24 PCRs are supported on the currently active
+                     bank. Leading zeroes are optional. TPM2 only.
 
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
index e1388d7d799a36..a7ad83bc0e5396 100644
--- a/security/keys/trusted-keys/trusted_tpm2.c
+++ b/security/keys/trusted-keys/trusted_tpm2.c
@@ -401,7 +401,7 @@ int tpm2_seal_trusted(struct tpm_chip *chip,
 	struct tpm_buf buf;
 	u32 hash;
 	u32 flags;
-	int i;
+	int i, j;
 	int rc;
 
 	for (i = 0; i < ARRAY_SIZE(tpm2_hash_map); i++) {
@@ -470,7 +470,28 @@ int tpm2_seal_trusted(struct tpm_chip *chip,
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
2.38.1.431.g37b22c650d-goog

