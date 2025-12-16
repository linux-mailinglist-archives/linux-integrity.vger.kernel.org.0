Return-Path: <linux-integrity+bounces-8050-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FD22CC16DE
	for <lists+linux-integrity@lfdr.de>; Tue, 16 Dec 2025 09:00:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B212130FCF18
	for <lists+linux-integrity@lfdr.de>; Tue, 16 Dec 2025 07:55:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1315343D79;
	Tue, 16 Dec 2025 07:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i0ymvXei"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C28BA34321E;
	Tue, 16 Dec 2025 07:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765871124; cv=none; b=WbRELA1DhGsDDCdTJpmkj/LYkomfCV08blIPfv9fJH4VAYYyk0kzWd+tjh3GO7yR7QhgWQvPc2LyOXxGjfO1iEuG9B59iFGfwgeWNdPaS1FHepdy+1vPBGCgegNq1tzkIoiIXMWufYWc3Is9LWIYF/hhXR+ogXyje9moFboNRWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765871124; c=relaxed/simple;
	bh=aFNuwSF5hMK4G6/+A3whucfg2dDtgRjOVVfXlJUu21c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hxNzHF3qF+EMSBsc8lhUzT2F37kKDXf+DI2uBKT3BQk5VD2D+aJmCB27jcMO/cXRNRJnwFbQ7RP0kG76TgUdTUjtBu0+hORlECxDa2Dno15hJFfmrFZpnK3nsJpW9JWiwA8npCZBFzSKnDtI4l5fc2MPV3xdlsC4cbY2wjo538U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i0ymvXei; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08032C4CEF1;
	Tue, 16 Dec 2025 07:45:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765871124;
	bh=aFNuwSF5hMK4G6/+A3whucfg2dDtgRjOVVfXlJUu21c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=i0ymvXei+E3P2AHAIAN4S985O6T2DD+Qod2OSFdjym8qYMLAGHX5hGuEBqULaxGS8
	 NdrjNuE7/ij+5l7tR/FDep9jqFCUzNTHpdUwjRJMLyb5NWouGG7SqN/lPfy2pVJz+W
	 Euo9ohdRQnWyDWHBdURctF9p6jGUclT/uI8TZ+c1eQvqzwxVXUl+uJ94k4h+rEVFDz
	 PDXmo3sO8eJJ42G81KzdtgqKQw+ttcnAaRE1PyRpSgPcGb2FZ7RzWV8TcsOkJiR1YS
	 7y2CtRCGY+wUrP2LzKpVk5YI8eRHuIeXG6fhLnZFznwEB69i7LHMG6H7D//jOdtzG5
	 ArT/8JECIFnVA==
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
Subject: [PATCH v7 05/12] KEYS: trusted: Remove dead branch from tpm2_unseal_cmd
Date: Tue, 16 Dec 2025 09:44:46 +0200
Message-Id: <20251216074454.2192499-6-jarkko@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251216074454.2192499-1-jarkko@kernel.org>
References: <20251216074454.2192499-1-jarkko@kernel.org>
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


