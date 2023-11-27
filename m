Return-Path: <linux-integrity+bounces-241-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BCD777FAA1C
	for <lists+linux-integrity@lfdr.de>; Mon, 27 Nov 2023 20:18:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7792B2819D3
	for <lists+linux-integrity@lfdr.de>; Mon, 27 Nov 2023 19:18:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E8D93EA71;
	Mon, 27 Nov 2023 19:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="ua67W9qf"
X-Original-To: linux-integrity@vger.kernel.org
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [IPv6:2607:fcd0:100:8a00::2])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71DD7D5A;
	Mon, 27 Nov 2023 11:18:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1701112704;
	bh=ci2tUZJFssoaOderYOzOd9qex+QuIGvuf9CFulw4d8E=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:From;
	b=ua67W9qflCD0kwz0rS4V1uoyESKMhP8jOVhWowgF+HK5MQu4Rpz4toAUbVTgjcl2Q
	 4ShfuExY/ypJCx/Sp5bViH8e3yetqQt5/koIwwTSI4IREbQE2kS/GNzhoedm6Aw4+O
	 t3e4wIDWFZ9zR1RJZ1HymwIyV1i8a0gO2yAKJEEs=
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id 3062E12867F5;
	Mon, 27 Nov 2023 14:18:24 -0500 (EST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id mFK8TLoWG4vg; Mon, 27 Nov 2023 14:18:24 -0500 (EST)
Received: from lingrow.int.hansenpartnership.com (unknown [153.66.160.227])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id 84515128645F;
	Mon, 27 Nov 2023 14:18:23 -0500 (EST)
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: linux-integrity@vger.kernel.org
Cc: Jarkko Sakkinen <jarkko@kernel.org>,
	keyrings@vger.kernel.org,
	Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH v5 13/17] tpm: add hmac checks to tpm2_pcr_extend()
Date: Mon, 27 Nov 2023 14:08:50 -0500
Message-Id: <20231127190854.13310-14-James.Bottomley@HansenPartnership.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20231127190854.13310-1-James.Bottomley@HansenPartnership.com>
References: <20231127190854.13310-1-James.Bottomley@HansenPartnership.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

tpm2_pcr_extend() is used by trusted keys to extend a PCR to prevent a
key from being re-loaded until the next reboot.  To use this
functionality securely, that extend must be protected by a session
hmac.  This patch adds HMAC protection so tampering with the
tpm2_pcr_extend() command in flight is detected.

Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
---
 drivers/char/tpm/tpm2-cmd.c | 27 ++++++++++-----------------
 1 file changed, 10 insertions(+), 17 deletions(-)

diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
index b0e72fb563d9..a53a843294ed 100644
--- a/drivers/char/tpm/tpm2-cmd.c
+++ b/drivers/char/tpm/tpm2-cmd.c
@@ -216,13 +216,6 @@ int tpm2_pcr_read(struct tpm_chip *chip, u32 pcr_idx,
 	return rc;
 }
 
-struct tpm2_null_auth_area {
-	__be32  handle;
-	__be16  nonce_size;
-	u8  attributes;
-	__be16  auth_size;
-} __packed;
-
 /**
  * tpm2_pcr_extend() - extend a PCR value
  *
@@ -236,24 +229,22 @@ int tpm2_pcr_extend(struct tpm_chip *chip, u32 pcr_idx,
 		    struct tpm_digest *digests)
 {
 	struct tpm_buf buf;
-	struct tpm2_null_auth_area auth_area;
 	int rc;
 	int i;
 
-	rc = tpm_buf_init(&buf, TPM2_ST_SESSIONS, TPM2_CC_PCR_EXTEND);
+	rc = tpm2_start_auth_session(chip);
 	if (rc)
 		return rc;
 
-	tpm_buf_append_u32(&buf, pcr_idx);
+	rc = tpm_buf_init(&buf, TPM2_ST_SESSIONS, TPM2_CC_PCR_EXTEND);
+	if (rc) {
+		tpm2_end_auth_session(chip);
+		return rc;
+	}
 
-	auth_area.handle = cpu_to_be32(TPM2_RS_PW);
-	auth_area.nonce_size = 0;
-	auth_area.attributes = 0;
-	auth_area.auth_size = 0;
+	tpm_buf_append_name(chip, &buf, pcr_idx, NULL);
+	tpm_buf_append_hmac_session(chip, &buf, 0, NULL, 0);
 
-	tpm_buf_append_u32(&buf, sizeof(struct tpm2_null_auth_area));
-	tpm_buf_append(&buf, (const unsigned char *)&auth_area,
-		       sizeof(auth_area));
 	tpm_buf_append_u32(&buf, chip->nr_allocated_banks);
 
 	for (i = 0; i < chip->nr_allocated_banks; i++) {
@@ -262,7 +253,9 @@ int tpm2_pcr_extend(struct tpm_chip *chip, u32 pcr_idx,
 			       chip->allocated_banks[i].digest_size);
 	}
 
+	tpm_buf_fill_hmac_session(chip, &buf);
 	rc = tpm_transmit_cmd(chip, &buf, 0, "attempting extend a PCR value");
+	rc = tpm_buf_check_hmac_response(chip, &buf, rc);
 
 	tpm_buf_destroy(&buf);
 
-- 
2.35.3


