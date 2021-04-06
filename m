Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AB6C3554AC
	for <lists+linux-integrity@lfdr.de>; Tue,  6 Apr 2021 15:12:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232492AbhDFNM1 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 6 Apr 2021 09:12:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344328AbhDFNMZ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 6 Apr 2021 09:12:25 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF6D7C06175F;
        Tue,  6 Apr 2021 06:12:16 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id x21-20020a17090a5315b029012c4a622e4aso7639812pjh.2;
        Tue, 06 Apr 2021 06:12:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+JOlxAjdwrWBStq5coNeqp17/mN4hB0eLuINH+S2ykE=;
        b=LY4BHuMMpzYN3r9lrp0/vfHCRdISDLrHblnB4sNqvH19YeXlKVEeDhq6P31mgXHoGq
         zJnLG6ZRXsMhffHQDwNYzw+WsQTXxf5fkz8bz7VGWfzMY/6zdNEXtU5cG20QcMSHE/B/
         9AbZIWOLGV+ytjcDB95d8s2sB9qJuz93thJ1LY7HAQD3O550Bt1vJdisgQUuFJ+6u2iS
         Ge8cvpAd7v3Ywe6F4z6QZOjC2oglOWfL1tE8LCDrlLDZ/0x8PtKlvl2X9P07vXhrj6Ss
         z0qfuKjUrWf7iWUFXLCCVmdjoc5A9XchRMEAPI460yN4BIKx31lfU058Cbc4sb8DQylr
         xY6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+JOlxAjdwrWBStq5coNeqp17/mN4hB0eLuINH+S2ykE=;
        b=ckNC6myTB/7L51RrLSWGt14FTFN/f6WaZWzGldw6WPkgmJN/pLZVCoWOr4yw+YLSXO
         fC/HvjWw7BDV5bn/i2g5YICbFmz+ya0oXzro1V0CWVxYw0j/iYnq7lsvBXpu+QKh4xSj
         Nw6Rsb0uOBjm1KdXxnRWjdKDXOFResc5cVS6rXBJOwYG+3ej/8aDFJQUrTMNEnbnnXa4
         ipfYKWA7uHKqHTno1LuSrKHjhxYefVMa895b9Jzwcsc4QX4f8aTPNOfTA2Upcxh07NoF
         mjSNq/zAYoG48dvy9Q4QWj4fMBoVBXBfnI65AJ8/Iu3130SBCyMkDf5br0z1Pb56HLCd
         xzgQ==
X-Gm-Message-State: AOAM5326+cKROADAxz0rm1g6A2I0IvrhHmOelKdXz5Km0WD573+R4z3D
        2IGNX5AmWITDbo1FiV3xuvdf8co7/u86TQ==
X-Google-Smtp-Source: ABdhPJyMVtfhwMCknT9X8JTJ6mg9jYbdQ1m8a7iB6YRdQPhdOI3o3n8gMC5PC5PxOhi815j99VFKMw==
X-Received: by 2002:a17:90b:4c0c:: with SMTP id na12mr1734982pjb.117.1617714736104;
        Tue, 06 Apr 2021 06:12:16 -0700 (PDT)
Received: from localhost.localdomain ([203.205.141.39])
        by smtp.gmail.com with ESMTPSA id i73sm13801351pgc.9.2021.04.06.06.12.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Apr 2021 06:12:15 -0700 (PDT)
From:   Hongbo Li <herbert.tencent@gmail.com>
To:     keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
        herbert@gondor.apana.org.au, dhowells@redhat.com,
        zohar@linux.ibm.com, jarkko@kernel.org, herberthbli@tencent.com
Cc:     linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org
Subject: [PATCH 4/5] crypto: ecdsa ima support
Date:   Tue,  6 Apr 2021 21:11:25 +0800
Message-Id: <1617714686-25754-5-git-send-email-herbert.tencent@gmail.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1617714686-25754-1-git-send-email-herbert.tencent@gmail.com>
References: <1617714686-25754-1-git-send-email-herbert.tencent@gmail.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Hongbo Li <herberthbli@tencent.com>

This patch is borrowed from Stefan Berger's ecdsa patch series,
will be removed when ecdsa is merged into kernel.

Signed-off-by: Hongbo Li <herberthbli@tencent.com>
---
 include/keys/asymmetric-type.h         |  6 ++++++
 security/integrity/digsig_asymmetric.c | 29 ++++++++++++++---------------
 2 files changed, 20 insertions(+), 15 deletions(-)

diff --git a/include/keys/asymmetric-type.h b/include/keys/asymmetric-type.h
index a29d3ff..c432fdb8 100644
--- a/include/keys/asymmetric-type.h
+++ b/include/keys/asymmetric-type.h
@@ -72,6 +72,12 @@ const struct asymmetric_key_ids *asymmetric_key_ids(const struct key *key)
 	return key->payload.data[asym_key_ids];
 }
 
+static inline
+const struct public_key *asymmetric_key_public_key(const struct key *key)
+{
+	return key->payload.data[asym_crypto];
+}
+
 extern struct key *find_asymmetric_key(struct key *keyring,
 				       const struct asymmetric_key_id *id_0,
 				       const struct asymmetric_key_id *id_1,
diff --git a/security/integrity/digsig_asymmetric.c b/security/integrity/digsig_asymmetric.c
index a662024..183f452 100644
--- a/security/integrity/digsig_asymmetric.c
+++ b/security/integrity/digsig_asymmetric.c
@@ -84,6 +84,7 @@ int asymmetric_verify(struct key *keyring, const char *sig,
 {
 	struct public_key_signature pks;
 	struct signature_v2_hdr *hdr = (struct signature_v2_hdr *)sig;
+	const struct public_key *pk;
 	struct key *key;
 	int ret;
 
@@ -105,23 +106,21 @@ int asymmetric_verify(struct key *keyring, const char *sig,
 	memset(&pks, 0, sizeof(pks));
 
 	pks.hash_algo = hash_algo_name[hdr->hash_algo];
-	switch (hdr->hash_algo) {
-	case HASH_ALGO_STREEBOG_256:
-	case HASH_ALGO_STREEBOG_512:
-		/* EC-RDSA and Streebog should go together. */
-		pks.pkey_algo = "ecrdsa";
-		pks.encoding = "raw";
-		break;
-	case HASH_ALGO_SM3_256:
-		/* SM2 and SM3 should go together. */
-		pks.pkey_algo = "sm2";
-		pks.encoding = "raw";
-		break;
-	default:
-		pks.pkey_algo = "rsa";
+
+	pk = asymmetric_key_public_key(key);
+	pks.pkey_algo = pk->pkey_algo;
+	if (!strcmp(pk->pkey_algo, "rsa")) {
 		pks.encoding = "pkcs1";
-		break;
+	} else if (!strncmp(pk->pkey_algo, "ecdsa-", 6)) {
+		/* edcsa-nist-p192 etc. */
+		pks.encoding = "x962";
+	} else if (!strcmp(pk->pkey_algo, "ecrdsa") ||
+		   !strcmp(pk->pkey_algo, "sm2")) {
+		pks.encoding = "raw";
+	} else {
+		return -ENOPKG;
 	}
+
 	pks.digest = (u8 *)data;
 	pks.digest_size = datalen;
 	pks.s = hdr->sig;
-- 
1.8.3.1

