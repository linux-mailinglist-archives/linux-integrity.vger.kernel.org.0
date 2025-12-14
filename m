Return-Path: <linux-integrity+bounces-7967-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ABA9CBBCC9
	for <lists+linux-integrity@lfdr.de>; Sun, 14 Dec 2025 16:38:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id ECB01301874C
	for <lists+linux-integrity@lfdr.de>; Sun, 14 Dec 2025 15:38:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E68AD2D321D;
	Sun, 14 Dec 2025 15:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E5N4kpq3"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B662A293C44;
	Sun, 14 Dec 2025 15:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765726713; cv=none; b=WQZAuMaEh/mxlaaSW7DvRMftH6Jqgqr7Iay04bUwUlNkAjZ7pdi5K1vR078MQ3zPbcBPrP7oSg/Q2o2ulXtn1eZAwE+f1A5464MzD+y0KAr75BpuO5Q0zPl9WykJHOAqHuHUWScggSKNTx8AhEGnGgsoFyff2JdUJs47r0Rs+94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765726713; c=relaxed/simple;
	bh=aFNuwSF5hMK4G6/+A3whucfg2dDtgRjOVVfXlJUu21c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BoB2qGD3LKmAUab2x7pl2aumrndvnxc3AV+IapG/pFh0659We19t8zJ+GLw11R7rJyxEsbWkE7PSTALqepTqXvf/bdsy8IaBT/ztIWo1nQxR+UsEEj29jv9fHk/R70q51urBzZY1XvxSeBIcA+VU8tMw98qbODe/jV6A4ldlCao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E5N4kpq3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03D74C4CEF1;
	Sun, 14 Dec 2025 15:38:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765726713;
	bh=aFNuwSF5hMK4G6/+A3whucfg2dDtgRjOVVfXlJUu21c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=E5N4kpq3ayygW785oQot39xujKbVRhhojA16Q9KKkFTsWk2zAiRimqSWchGE+p+y0
	 V0fQulpLYN7jckSTg9L1scA1YOiBvJ2FkfxUMKcAAdKX2KH+kDMo6zgjkdPAOPJWgY
	 7H8H5qsC2yse8KA78azGXFdOSL+TzkE/pT/RuB4qnlZHZmsGYXgwp0L+JdTj8xK81J
	 DwRyAg9SpYajYtzACBU3kGy/M7PILsaiixBgP31pQ8J74F3zkOGx5Dg+0ufIyj0TPx
	 QhFu9E/Gi0/um9UUqxFoJhxCPeFPqdXBDU82LNEX5UdQaJjwz+DoyodvWwDbWuIsZK
	 67iRd8acQ6vuw==
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
Subject: [PATCH v6 03/11] KEYS: trusted: Remove dead branch from tpm2_unseal_cmd
Date: Sun, 14 Dec 2025 17:38:00 +0200
Message-Id: <20251214153808.73831-4-jarkko@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251214153808.73831-1-jarkko@kernel.org>
References: <20251214153808.73831-1-jarkko@kernel.org>
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
index d3a5c5f2b926..3666e3e48eab 100644
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
 
@@ -495,14 +493,8 @@ static int tpm2_unseal_cmd(struct tpm_chip *chip,
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


