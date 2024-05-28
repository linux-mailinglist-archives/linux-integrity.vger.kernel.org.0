Return-Path: <linux-integrity+bounces-2677-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F5198D1797
	for <lists+linux-integrity@lfdr.de>; Tue, 28 May 2024 11:54:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 403A61C22030
	for <lists+linux-integrity@lfdr.de>; Tue, 28 May 2024 09:54:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1D4216A384;
	Tue, 28 May 2024 09:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P8W/XxLB"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84E53157E61;
	Tue, 28 May 2024 09:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716890083; cv=none; b=Ty/4t54QUciC8eksyMA5bd2SuPSopF3WiOMwj6kaEBUefy0KJkvr90+t1ALj03lN8dwHADceewLtz8B8ET3cvlqhM/RYkxkCAFkjb3MdbraN7j83gn2Y9vLwKTgECHwp1NYhBfPKkiPJiikmHz49yotVMzzAXQw3+3xB7uoLwT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716890083; c=relaxed/simple;
	bh=UoqEy8pe0oo6Q6KLGXA6s4y3pv5XRjR1eEUiP0TzPYg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gDkgQ+kdEKzPqbJeknaqtvme2W0+Tucp0tE24aKBq2jpLu4VNM7xBd7PZROyxRqO5aX8eKvdCzdbZBQ4SaOOpKYE2UxMUwtwgaZxRHM4eleZMU0vaHYwhe/bk2FOJN71X+oA1hN2er18zy3YUjFs1G3CLYKjLzpF5bFEkmzYzqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P8W/XxLB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE1F5C32782;
	Tue, 28 May 2024 09:54:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716890083;
	bh=UoqEy8pe0oo6Q6KLGXA6s4y3pv5XRjR1eEUiP0TzPYg=;
	h=From:To:Cc:Subject:Date:From;
	b=P8W/XxLBNi4IcCSCy0bmbc+Yvf1q2uC+2oqptIgkXrnrcwgqFvc1xRMe4U0/ksgd7
	 dkHSXB2n8Op0lDnHD8Mb31OW/KMRIw12HHPEIYOnECPF3tByo9rfcQj9nUjh7p3JDe
	 4f4iI2MF4rNisJWRGntg+URtETUlcA/FIJqERgjLTJN5FBfaftgxctUI61V5wm0Bq8
	 aP1YA6eB0dV6I9wu3NoGuewBnjZps65c6T0hJ9B07w1IynPY5ags4cfMsOP9uYV4IZ
	 byIrItxkQt0m0JiYDmVmA7X6TVVVqouROYS4rrFDXK2vSKFjC12JDkK9EPRSSQcVcV
	 zqz4sFaMBx46A==
From: Jarkko Sakkinen <jarkko@kernel.org>
To: linux-integrity@vger.kernel.org
Cc: keyrings@vger.kernel.org,
	James.Bottomley@HansenPartnership.com,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Peter Huewe <peterhuewe@gmx.de>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Stefan Berger <stefanb@linux.ibm.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Mario Limonciello <mario.limonciello@amd.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] tpm: Rename TPM2_OA_TMPL to TPM2_OA_NULL_KEY and make it local
Date: Tue, 28 May 2024 12:54:33 +0300
Message-ID: <20240528095438.1857-1-jarkko@kernel.org>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rename and document TPM2_OA_TMPL, as originally requested in the patch
set review, but left unaddressed without any appropriate reasoning. The
new name is TPM2_OA_NULL_KEY, has a documentation and is local only to
tpm2-sessions.c.

Link: https://lore.kernel.org/linux-integrity/ddbeb8111f48a8ddb0b8fca248dff6cc9d7079b2.camel@HansenPartnership.com/
Link: https://lore.kernel.org/linux-integrity/CZCKTWU6ZCC9.2UTEQPEVICYHL@suppilovahvero/
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
---
v2:
- linux/tpm.h is not a place for AES_* constants. Move them also to
  drivers/char/tpm/tpm2-sessions.c.
- Remove the comment related to TPM2_OA_TMPL as "key tcg documents"
  is not a legit xerf, and thus only adds obfuscation.
---
 drivers/char/tpm/tpm2-sessions.c | 21 +++++++++++++++++++--
 include/linux/tpm.h              | 15 ---------------
 2 files changed, 19 insertions(+), 17 deletions(-)

diff --git a/drivers/char/tpm/tpm2-sessions.c b/drivers/char/tpm/tpm2-sessions.c
index ea8860661876..907ac9956a78 100644
--- a/drivers/char/tpm/tpm2-sessions.c
+++ b/drivers/char/tpm/tpm2-sessions.c
@@ -80,6 +80,9 @@
 /* maximum number of names the TPM must remember for authorization */
 #define AUTH_MAX_NAMES	3
 
+#define AES_KEY_BYTES	AES_KEYSIZE_128
+#define AES_KEY_BITS	(AES_KEY_BYTES*8)
+
 static int tpm2_create_primary(struct tpm_chip *chip, u32 hierarchy,
 			       u32 *handle, u8 *name);
 
@@ -954,6 +957,20 @@ int tpm2_start_auth_session(struct tpm_chip *chip)
 }
 EXPORT_SYMBOL(tpm2_start_auth_session);
 
+/*
+ * A mask containing the object attributes for the kernel held null primary key
+ * used in HMAC encryption. For more information on specific attributes look up
+ * to "8.3 TPMA_OBJECT (Object Attributes)".
+ */
+#define TPM2_OA_NULL_KEY ( \
+	TPM2_OA_NO_DA | \
+	TPM2_OA_FIXED_TPM | \
+	TPM2_OA_FIXED_PARENT | \
+	TPM2_OA_SENSITIVE_DATA_ORIGIN |	\
+	TPM2_OA_USER_WITH_AUTH | \
+	TPM2_OA_DECRYPT | \
+	TPM2_OA_RESTRICTED)
+
 /**
  * tpm2_parse_create_primary() - parse the data returned from TPM_CC_CREATE_PRIMARY
  *
@@ -1018,7 +1035,7 @@ static int tpm2_parse_create_primary(struct tpm_chip *chip, struct tpm_buf *buf,
 	val = tpm_buf_read_u32(buf, &offset_t);
 
 	/* object properties */
-	if (val != TPM2_OA_TMPL)
+	if (val != TPM2_OA_NULL_KEY)
 		return -EINVAL;
 
 	/* auth policy (empty) */
@@ -1178,7 +1195,7 @@ static int tpm2_create_primary(struct tpm_chip *chip, u32 hierarchy,
 	tpm_buf_append_u16(&template, TPM_ALG_SHA256);
 
 	/* object properties */
-	tpm_buf_append_u32(&template, TPM2_OA_TMPL);
+	tpm_buf_append_u32(&template, TPM2_OA_NULL_KEY);
 
 	/* sauth policy (empty) */
 	tpm_buf_append_u16(&template, 0);
diff --git a/include/linux/tpm.h b/include/linux/tpm.h
index b3217200df28..21a67dc9efe8 100644
--- a/include/linux/tpm.h
+++ b/include/linux/tpm.h
@@ -394,21 +394,6 @@ enum tpm2_object_attributes {
 	TPM2_OA_SIGN			= BIT(18),
 };
 
-/*
- * definitions for the canonical template.  These are mandated
- * by the TCG key template documents
- */
-
-#define AES_KEY_BYTES	AES_KEYSIZE_128
-#define AES_KEY_BITS	(AES_KEY_BYTES*8)
-#define TPM2_OA_TMPL	(TPM2_OA_NO_DA |			\
-			 TPM2_OA_FIXED_TPM |			\
-			 TPM2_OA_FIXED_PARENT |			\
-			 TPM2_OA_SENSITIVE_DATA_ORIGIN |	\
-			 TPM2_OA_USER_WITH_AUTH |		\
-			 TPM2_OA_DECRYPT |			\
-			 TPM2_OA_RESTRICTED)
-
 enum tpm2_session_attributes {
 	TPM2_SA_CONTINUE_SESSION	= BIT(0),
 	TPM2_SA_AUDIT_EXCLUSIVE		= BIT(1),
-- 
2.45.1


