Return-Path: <linux-integrity+bounces-1179-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C47D7853727
	for <lists+linux-integrity@lfdr.de>; Tue, 13 Feb 2024 18:21:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4D133B24BB9
	for <lists+linux-integrity@lfdr.de>; Tue, 13 Feb 2024 17:21:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21DD35FDD6;
	Tue, 13 Feb 2024 17:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="KujFkC23"
X-Original-To: linux-integrity@vger.kernel.org
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [96.44.175.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AED015FDC7;
	Tue, 13 Feb 2024 17:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.44.175.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707844875; cv=none; b=qOu817BezdwCak4TLfdos2zRAjKFf8N662omcSCSSrB9zVJQvnYN1w1ZSEAJa/sa8Xs06F/D9/3BNtX+6XIYxujE/M9ohXLg8b9ldTWl74BoOYomiNfsvvVKNA5uDUuTlGNsVcnnujqZohAJOTZCL6N1RGH7mkHDlhljXLyKg/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707844875; c=relaxed/simple;
	bh=BkLyBAyuRrKe9xAril8jS648H4kvAAKXrIJmeVCqvzA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=US4SQ5294QS49IwQpoGbsZnCqiMdKkMk061hQx59wwyJlJPNweUqkvkOfeyDxWk+Z/2EU7N3Q8235Ycndt6yeyGNybxea19Ag7tIwKuQDbzT2rHT0cz3AWqhxtt1xEoQmal6Ywb/PcuBfar0OmZqRHMvN5CiYejOW+uFkktH/aI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=KujFkC23; arc=none smtp.client-ip=96.44.175.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1707844872;
	bh=BkLyBAyuRrKe9xAril8jS648H4kvAAKXrIJmeVCqvzA=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:From;
	b=KujFkC2339FSGH5rIznqGD2dTrmXguIyvkfj0oGd4i4GuVkM8kB/CBWw/nEwjeGgM
	 C4o5aQlP4VzVvangXQFVeghrhUXXvjT+HwtVLeyCwVe2Aqr0OnLtzV/3HiqEPqdznC
	 e3/PgA+CJ7qQ2h6uy/qB89sk1aEBQW9m+1JdBCmU=
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id EBC991280D89;
	Tue, 13 Feb 2024 12:21:12 -0500 (EST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id wybY5_HqMma7; Tue, 13 Feb 2024 12:21:12 -0500 (EST)
Received: from lingrow.int.hansenpartnership.com (unknown [153.66.160.227])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id 14C631280CB7;
	Tue, 13 Feb 2024 12:21:12 -0500 (EST)
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: linux-integrity@vger.kernel.org
Cc: Jarkko Sakkinen <jarkko@kernel.org>,
	keyrings@vger.kernel.org,
	Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH v7 16/21] tpm: add hmac checks to tpm2_pcr_extend()
Date: Tue, 13 Feb 2024 12:13:29 -0500
Message-Id: <20240213171334.30479-17-James.Bottomley@HansenPartnership.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240213171334.30479-1-James.Bottomley@HansenPartnership.com>
References: <20240213171334.30479-1-James.Bottomley@HansenPartnership.com>
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
Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

---
v7: add review
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


