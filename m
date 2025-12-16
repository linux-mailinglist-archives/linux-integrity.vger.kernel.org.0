Return-Path: <linux-integrity+bounces-8066-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E71F5CC1D23
	for <lists+linux-integrity@lfdr.de>; Tue, 16 Dec 2025 10:36:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B8F35304E3B1
	for <lists+linux-integrity@lfdr.de>; Tue, 16 Dec 2025 09:33:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C58AE34106B;
	Tue, 16 Dec 2025 09:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qy5z8+E1"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97618341058;
	Tue, 16 Dec 2025 09:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765876945; cv=none; b=RrMD595M1Fd1ACMBDSS4gT2lfYuYRWF7xJUQaD0kak0E0+dnNiYLjh8U3Lv9K+dDQJBnutCtk6zdCOuxPRPEt5oYadjWrybcxDKHtvSzm6EIPZVbZJ/+DsQHRKNZWIPIsB72PVNq8kK15WHxGOgXgWVLCQ/KybdA18PvwMukgTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765876945; c=relaxed/simple;
	bh=aFNuwSF5hMK4G6/+A3whucfg2dDtgRjOVVfXlJUu21c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PUz7uobwq5a0CQkK8blnCLSJJapSdOHtlth+olY9l6OhOCvXIgnGRCBaqLPNIElqr8+bgD7qEycDgLjYAN6n1QLDY2+1e4WTuG2mVKE4r7YfpzAwPxmDq3KjhI36BH3nLBuXfg771lw78Tc92+hVBAvVtDthOJnovDAihPGHgto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qy5z8+E1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2D5DC113D0;
	Tue, 16 Dec 2025 09:22:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765876945;
	bh=aFNuwSF5hMK4G6/+A3whucfg2dDtgRjOVVfXlJUu21c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qy5z8+E1Dfd2AOdTbl3c4RMxNVa0W/ncmtY1qhUiRke1mSL0bLAhaldJtomGZppi0
	 H+gdEyZsPoYDUySOMqoI2KWFHukOC6f/ErjcMjNGb/5R508epYZL9xg9taxP8SVjDO
	 qdCv8WXTY5Swu3nbxXPZoVrhmX59ZJgJP/quWVLPvp8fNx5zEGtrRiP2PIfpb7ak7B
	 fC2PfU3jkXCN9JfQDhjGO9ZBAOpCJA59McbCmiY3e3Wo5Kuh4C4eQJl4UVMh9myc7H
	 VuzIjF9znLw+c0+IMpzlGdX7qY/Fm8EkwraTyrCSArauCJ1zc5g43CiG/31SPzO+sD
	 7MLmZjpBWq0Og==
From: Jarkko Sakkinen <jarkko@kernel.org>
To: linux-integrity@vger.kernel.org
Cc: Jarkko Sakkinen <jarkko@kernel.org>,
	David Howells <dhowells@redhat.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	James Bottomley <James.Bottomley@HansenPartnership.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	keyrings@vger.kernel.org (open list:KEYS/KEYRINGS),
	linux-security-module@vger.kernel.org (open list:SECURITY SUBSYSTEM),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v8 07/12] KEYS: trusted: Remove dead branch from tpm2_unseal_cmd
Date: Tue, 16 Dec 2025 11:21:41 +0200
Message-Id: <20251216092147.2326606-8-jarkko@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251216092147.2326606-1-jarkko@kernel.org>
References: <20251216092147.2326606-1-jarkko@kernel.org>
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


