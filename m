Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4819732029E
	for <lists+linux-integrity@lfdr.de>; Sat, 20 Feb 2021 02:37:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230016AbhBTBfe (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 19 Feb 2021 20:35:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230015AbhBTBfJ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 19 Feb 2021 20:35:09 -0500
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0951AC061226
        for <linux-integrity@vger.kernel.org>; Fri, 19 Feb 2021 17:33:15 -0800 (PST)
Received: by mail-qv1-xf4a.google.com with SMTP id p4so4306914qvn.23
        for <linux-integrity@vger.kernel.org>; Fri, 19 Feb 2021 17:33:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=5s65rAUyafrnqP9PDtk4qfuDVzKOqtCy9uXyzty++eY=;
        b=ckXns8cEP+qoyBNXWqxZ/Pqz+1OzcyHa3rdo4kRUVo4uBYz2UPFHEl2UxhqLMHs44p
         SwCDNE39L1kZJAH0CwNAQuu6tKwNayENEqa5thHOiM1J3Voe6eSp81WNW43w4QqXp4ZS
         I6Mh8gcaQULV4BpLo5K27QD67/gr71IWSpXAojezrc7f2PXUet5rYCWvycSc3mR7/IB1
         qA6isMB7s0Fxq76r7o7lY6pzocQiWmYDWhIQG4wJ/bH6L8YRjkJviJXx7kQdlxvBMsyp
         QaRkEb9Hy7UA9cSNBd6HWY6t4cV6SeE2VYRiuBw8BKsfRp++GlV62foOQK1zoqhWee/t
         qOGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=5s65rAUyafrnqP9PDtk4qfuDVzKOqtCy9uXyzty++eY=;
        b=o/3EIAcvtlHdmCN5pZ4T0aeX3PQgApM7pevp+mfIyVx3ZLxDQjEHBggDkw4Up0MuYK
         4T3xt9XqRNPCw+V5BSV4DQir20g9ac97pP8LPojYOyrf3QzedaQmAYjo+EFwpC3TFCg0
         MioDb6z+Xz3azZVcFURDcwdy4m/XipMK+oNBtXK1RHfosydKsFiCYYEeskKVBtVa4sbC
         0bbH0cryqJIVuBYI7n0vwNjmCPRNam7m406dE1ET+e103z7NlChEtJy+u0um5IwcpwXW
         S0oxZuQALNLccGqTuV4axJ/5Yhb/I3uDh8fbPp5Wi83LuIpNrFyIsJm4DmRrq7GNDEw1
         ymcw==
X-Gm-Message-State: AOAM531SY4HGgdEfMNM1v1ShlZb/uGyhdvISrk1mKfUFd7NImHj4st2y
        4DHE/ZryX+N47W12sElmhaQGBrklHIj4+g1bx3RCVg==
X-Google-Smtp-Source: ABdhPJxe0tcmAT4r+GJm84m4ZI8dalvzV9xz8hB5vIXENWytlqBxGoK9QHBaPGrOIOkjE3sq0edeDJIlSBq6GZPZhGFw4g==
Sender: "matthewgarrett via sendgmr" 
        <matthewgarrett@matthewgarrett-tmp.c.googlers.com>
X-Received: from matthewgarrett-tmp.c.googlers.com ([fda3:e722:ac3:10:7f:e700:c0a8:1081])
 (user=matthewgarrett job=sendgmr) by 2002:a0c:ed4f:: with SMTP id
 v15mr4210810qvq.55.1613784794251; Fri, 19 Feb 2021 17:33:14 -0800 (PST)
Date:   Sat, 20 Feb 2021 01:32:51 +0000
In-Reply-To: <20210220013255.1083202-1-matthewgarrett@google.com>
Message-Id: <20210220013255.1083202-6-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20210220013255.1083202-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.30.0.617.g56c4b15f3c-goog
Subject: [PATCH 5/9] security: keys: trusted: Allow storage of PCR values in
 creation data
From:   Matthew Garrett <matthewgarrett@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-integrity@vger.kernel.org, linux-pm@vger.kernel.org,
        keyrings@vger.kernel.org, zohar@linux.ibm.com, jejb@linux.ibm.com,
        jarkko@kernel.org, corbet@lwn.net, rjw@rjwysocki.net,
        Matthew Garrett <matthewgarrett@google.com>,
        Matthew Garrett <mjg59@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

When TPMs generate keys, they can also generate some information
describing the state of the PCRs at creation time. This data can then
later be certified by the TPM, allowing verification of the PCR values.
This allows us to determine the state of the system at the time a key
was generated. Add an additional argument to the trusted key creation
options, allowing the user to provide the set of PCRs that should have
their values incorporated into the creation data.

Signed-off-by: Matthew Garrett <mjg59@google.com>
---
 .../security/keys/trusted-encrypted.rst       |  4 +++
 include/keys/trusted-type.h                   |  1 +
 security/keys/trusted-keys/trusted_tpm1.c     |  9 +++++++
 security/keys/trusted-keys/trusted_tpm2.c     | 25 +++++++++++++++++--
 4 files changed, 37 insertions(+), 2 deletions(-)

diff --git a/Documentation/security/keys/trusted-encrypted.rst b/Documentation/security/keys/trusted-encrypted.rst
index 1da879a68640..27bc43463ec8 100644
--- a/Documentation/security/keys/trusted-encrypted.rst
+++ b/Documentation/security/keys/trusted-encrypted.rst
@@ -72,6 +72,10 @@ Usage::
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
index 154d8a1769c3..875e05f33b84 100644
--- a/include/keys/trusted-type.h
+++ b/include/keys/trusted-type.h
@@ -47,6 +47,7 @@ struct trusted_key_options {
 	uint32_t policydigest_len;
 	unsigned char policydigest[MAX_DIGEST_SIZE];
 	uint32_t policyhandle;
+	uint32_t creation_pcrs;
 };
 
 extern struct key_type key_type_trusted;
diff --git a/security/keys/trusted-keys/trusted_tpm1.c b/security/keys/trusted-keys/trusted_tpm1.c
index 74d82093cbaa..3d371ab3441f 100644
--- a/security/keys/trusted-keys/trusted_tpm1.c
+++ b/security/keys/trusted-keys/trusted_tpm1.c
@@ -709,6 +709,7 @@ enum {
 	Opt_hash,
 	Opt_policydigest,
 	Opt_policyhandle,
+	Opt_creationpcrs,
 };
 
 static const match_table_t key_tokens = {
@@ -724,6 +725,7 @@ static const match_table_t key_tokens = {
 	{Opt_hash, "hash=%s"},
 	{Opt_policydigest, "policydigest=%s"},
 	{Opt_policyhandle, "policyhandle=%s"},
+	{Opt_creationpcrs, "creationpcrs=%s"},
 	{Opt_err, NULL}
 };
 
@@ -834,6 +836,13 @@ static int getoptions(char *c, struct trusted_key_payload *pay,
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
index a3673fffd834..282f956ad610 100644
--- a/security/keys/trusted-keys/trusted_tpm2.c
+++ b/security/keys/trusted-keys/trusted_tpm2.c
@@ -124,7 +124,7 @@ int tpm2_seal_trusted(struct tpm_chip *chip,
 	unsigned int offset;
 	struct tpm_buf buf;
 	u32 hash;
-	int i;
+	int i, j;
 	int rc;
 
 	for (i = 0; i < ARRAY_SIZE(tpm2_hash_map); i++) {
@@ -181,7 +181,28 @@ int tpm2_seal_trusted(struct tpm_chip *chip,
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
2.30.0.617.g56c4b15f3c-goog

