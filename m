Return-Path: <linux-integrity+bounces-7953-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 16BA3CBB342
	for <lists+linux-integrity@lfdr.de>; Sat, 13 Dec 2025 21:32:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9BE4430014D5
	for <lists+linux-integrity@lfdr.de>; Sat, 13 Dec 2025 20:32:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96CB33BB4A;
	Sat, 13 Dec 2025 20:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oUWXhiLz"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51EB0221F39;
	Sat, 13 Dec 2025 20:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765657965; cv=none; b=AMu6ht+L4VjAqoNh7i0vOPGiyuiWpse3wPorllgJOwfjMxGT0IlrdGGvx2Rp6FZyeO00oXQ2eTjpRhXeZ0Le5RMnKdavQF6yfgc5tBuT6BUJ3SzHu2uw3zCqxyXmFKi8TVsd2PqmiabkUIlakrjYSnGxc8A7L81iqJx59yCyRfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765657965; c=relaxed/simple;
	bh=+/TQTLSaA5zeMmENIXcS0wmTSXw51MGbxVB/mKeMXk8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ceqTxzdoQ+q/0adfbOjwxz/RyhJQNErrXwYkq3wSf9Ii41KLSQ9ZHD3842SVrUX7Rs8oNsRqfwQpYq+dm1oSwnU6IOnbeBFPIlZIDFDtIasbr5D4RKhIlpl5POrHjcfnNQez1CbQO3I+FpYpLGGEnktTvNsM8jpqi9gIxWeCpSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oUWXhiLz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 569C4C4CEF7;
	Sat, 13 Dec 2025 20:32:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765657964;
	bh=+/TQTLSaA5zeMmENIXcS0wmTSXw51MGbxVB/mKeMXk8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oUWXhiLzbqqmksvaM3TZnAz4+UzR//LqHbzRHltbVmjNJeo1aG5wX+ftWWoxMgc5Z
	 9HkGExsvOPYmFV4w78ckyYPr3YCFG6KMxj6bxtbcWzehLdStXiJGuwMf92DH07Tigr
	 nR/vyLVHLgy0t+wyuj85SKF8V2YnllEUAcBkCDdvdAnDYO/tdfNB79rORu+PXrc+Ik
	 zWljJH3K88Eib6hScBfkIv2E1LoKX4kuVN3ErALzUipADOA0HS6dQn6x8kZ8WNF06R
	 awnSKsofiR35v3mvEw9hYyQfGmtlbmu+M0Mhl3O0K0MlVO+6LFDODX9WwBcs8LP2Xw
	 tf6yMJbcGafVw==
From: Jarkko Sakkinen <jarkko@kernel.org>
To: linux-integrity@vger.kernel.org
Cc: Ross Philipson <ross.philipson@oracle.com>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	David Howells <dhowells@redhat.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	James Bottomley <James.Bottomley@HansenPartnership.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	keyrings@vger.kernel.org (open list:KEYS/KEYRINGS),
	linux-security-module@vger.kernel.org (open list:SECURITY SUBSYSTEM),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v5 02/12] KEYS: trusted: Remove dead branch from tpm2_unseal_cmd
Date: Sat, 13 Dec 2025 22:32:09 +0200
Message-Id: <20251213203220.317498-3-jarkko@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251213203220.317498-1-jarkko@kernel.org>
References: <20251213203220.317498-1-jarkko@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

TPM2_Unseal requires TPM2_ST_SESSIONS, and tpm2_unseal_cmd() always does
set up either password or HMAC session.

Remove the branch in tpm2_unseal_cmd() conditionally setting
TPM2_ST_NO_SESSIONS. It is faulty but luckily it is never exercised at
run-time, and thus does not cause regressions.

Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
---
 security/keys/trusted-keys/trusted_tpm2.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/security/keys/trusted-keys/trusted_tpm2.c b/security/keys/trusted-keys/trusted_tpm2.c
index d25d065c2af0..77e1532ef9d4 100644
--- a/security/keys/trusted-keys/trusted_tpm2.c
+++ b/security/keys/trusted-keys/trusted_tpm2.c
@@ -451,10 +451,8 @@ static int tpm2_unseal_cmd(struct tpm_chip *chip,
 			   struct trusted_key_options *options,
 			   u32 blob_handle)
 {
-	struct tpm_header *head;
 	struct tpm_buf buf;
 	u16 data_len;
-	int offset;
 	u8 *data;
 	int rc;
 
@@ -489,14 +487,8 @@ static int tpm2_unseal_cmd(struct tpm_chip *chip,
 		tpm_buf_append_u16(&buf, options->blobauth_len);
 		tpm_buf_append(&buf, options->blobauth, options->blobauth_len);
 
-		if (tpm2_chip_auth(chip)) {
+		if (tpm2_chip_auth(chip))
 			tpm_buf_append_hmac_session(chip, &buf, TPM2_SA_ENCRYPT, NULL, 0);
-		} else  {
-			offset = buf.handles * 4 + TPM_HEADER_SIZE;
-			head = (struct tpm_header *)buf.data;
-			if (tpm_buf_length(&buf) == offset)
-				head->tag = cpu_to_be16(TPM2_ST_NO_SESSIONS);
-		}
 	}
 
 	rc = tpm_buf_fill_hmac_session(chip, &buf);
-- 
2.39.5


