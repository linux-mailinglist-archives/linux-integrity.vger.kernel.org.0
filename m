Return-Path: <linux-integrity+bounces-2676-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C0DA8D177F
	for <lists+linux-integrity@lfdr.de>; Tue, 28 May 2024 11:46:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45811286486
	for <lists+linux-integrity@lfdr.de>; Tue, 28 May 2024 09:46:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C884973471;
	Tue, 28 May 2024 09:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eypyjVtk"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D8CB17E8F4;
	Tue, 28 May 2024 09:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716889613; cv=none; b=OPAneL88sI1n1AjATKWpwy/pcHXnV8q0CdTk4TvSD7o6fYdLVgnvdYzb/46lC0ksOSiRrbUMThszkruOaWBdno46zHVP9fFrcIZliFc/rYm7KU75lOR1twh79YCQ6DJZ0GkSGA7wGUzJxoy9XmU25vfrOtLurQXLCdwQTDqdRv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716889613; c=relaxed/simple;
	bh=uvIeCtTEEJDYfyHrP/Gk+XUZtIAdmLorcvNIp9zS3W8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ad8Mmr5+pStnefpSsORPT5+2BCRebe80hgJzYPTLbLEbK1j188jKT2AB6xjCh1VFTcevKGrYkZgQKtz/jgDk+c/Uanzj/vZDm2TgqKaKeubR6OYeP42+zjjnREVLNXTptKHd6Js4Jcm1WupGOcPZUyRKO2Qw4pWMO1EJKnLi/H8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eypyjVtk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8EC0C3277B;
	Tue, 28 May 2024 09:46:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716889613;
	bh=uvIeCtTEEJDYfyHrP/Gk+XUZtIAdmLorcvNIp9zS3W8=;
	h=From:To:Cc:Subject:Date:From;
	b=eypyjVtkDE746G/DlSuQfj0JPp+lgxIXGkYF0Md7/HpuJrnvBxpzYg2FPjMpj3Ia/
	 Io657MDr6w3x4l6vxIO8hkF3fHeOyrSr9NZBWIgrgnGrlRaYztQAWWGWaoq/kXhW0g
	 hZlbSZJcAAzjMDJUTbkGdUr73miojQsjEfpUZRIfv0rTtM6bLgTVxBaN9eh2dHrfLQ
	 u3rTuPELCfsQPV0DUesKXzk04kGo7Qzxl6OFiG597W6+t3y8Rj+X+f2Y92vGrgObqu
	 Q9ojWNfGruQTLeMxggMtV0ldGMiM0iExQQSLp2lbMiIRxyOXXXgHkUIYBaEpq/DU9S
	 J+g6tVTmjdHSw==
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
Subject: [PATCH] tpm: Rename TPM2_OA_TMPL to TPM2_OA_NULL_KEY and make it local
Date: Tue, 28 May 2024 12:46:41 +0300
Message-ID: <20240528094645.15583-1-jarkko@kernel.org>
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
 drivers/char/tpm/tpm2-sessions.c | 18 ++++++++++++++++--
 include/linux/tpm.h              |  7 -------
 2 files changed, 16 insertions(+), 9 deletions(-)

diff --git a/drivers/char/tpm/tpm2-sessions.c b/drivers/char/tpm/tpm2-sessions.c
index ea8860661876..ff2b7f4703fa 100644
--- a/drivers/char/tpm/tpm2-sessions.c
+++ b/drivers/char/tpm/tpm2-sessions.c
@@ -954,6 +954,20 @@ int tpm2_start_auth_session(struct tpm_chip *chip)
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
@@ -1018,7 +1032,7 @@ static int tpm2_parse_create_primary(struct tpm_chip *chip, struct tpm_buf *buf,
 	val = tpm_buf_read_u32(buf, &offset_t);
 
 	/* object properties */
-	if (val != TPM2_OA_TMPL)
+	if (val != TPM2_OA_NULL_KEY)
 		return -EINVAL;
 
 	/* auth policy (empty) */
@@ -1178,7 +1192,7 @@ static int tpm2_create_primary(struct tpm_chip *chip, u32 hierarchy,
 	tpm_buf_append_u16(&template, TPM_ALG_SHA256);
 
 	/* object properties */
-	tpm_buf_append_u32(&template, TPM2_OA_TMPL);
+	tpm_buf_append_u32(&template, TPM2_OA_NULL_KEY);
 
 	/* sauth policy (empty) */
 	tpm_buf_append_u16(&template, 0);
diff --git a/include/linux/tpm.h b/include/linux/tpm.h
index b3217200df28..d3b9e9f9073e 100644
--- a/include/linux/tpm.h
+++ b/include/linux/tpm.h
@@ -401,13 +401,6 @@ enum tpm2_object_attributes {
 
 #define AES_KEY_BYTES	AES_KEYSIZE_128
 #define AES_KEY_BITS	(AES_KEY_BYTES*8)
-#define TPM2_OA_TMPL	(TPM2_OA_NO_DA |			\
-			 TPM2_OA_FIXED_TPM |			\
-			 TPM2_OA_FIXED_PARENT |			\
-			 TPM2_OA_SENSITIVE_DATA_ORIGIN |	\
-			 TPM2_OA_USER_WITH_AUTH |		\
-			 TPM2_OA_DECRYPT |			\
-			 TPM2_OA_RESTRICTED)
 
 enum tpm2_session_attributes {
 	TPM2_SA_CONTINUE_SESSION	= BIT(0),
-- 
2.45.1


