Return-Path: <linux-integrity+bounces-7887-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 393F7CB32C9
	for <lists+linux-integrity@lfdr.de>; Wed, 10 Dec 2025 15:40:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 420E43082352
	for <lists+linux-integrity@lfdr.de>; Wed, 10 Dec 2025 14:39:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E75E31F4176;
	Wed, 10 Dec 2025 14:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RpMJ3q+l"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B53A318787A;
	Wed, 10 Dec 2025 14:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765377591; cv=none; b=KzTlnrtvui7FbDMe/zxmosPj+gQuCkSrrJmQbcYW4sD2fb38Em+11Pp4yXFkNTwFTPTyuslmSBAPqKwmI8xP/tl6LCxZZSrC8dRpyNN001JovAL6kD79vczNEFeFsMGAK5ZzeORr9fvFc9cNeltxWq2y6DdZ8TzacY/MCBEeRTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765377591; c=relaxed/simple;
	bh=YUYqIvNjXnvmL0CNkyW+ra2WzRNZMTP9cgmJvuV1o7E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NbuWnO4kXow90nTK1kpFj8FN9Vcq7oTNrM/7gEoF+MPToS3zZ/2lb3XPSxKSolP2rdjWga18dGkmR02hIMFknOuCI/eazEdED5Njen0W8xxR24KfjgvtWyzuP7jTlzTA9BRB9DrHIt7DEEuT0tH6xcbwoxSD5CJ9fzBtWXhrcr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RpMJ3q+l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDD7CC4CEF7;
	Wed, 10 Dec 2025 14:39:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765377591;
	bh=YUYqIvNjXnvmL0CNkyW+ra2WzRNZMTP9cgmJvuV1o7E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RpMJ3q+lsapbu1e9o3qI1l+MorsWLFV7+fERjiGFZX9z5mXr/mM0hsN0pyfaSq2dM
	 yeMg2OAflNUyVndnDWZn66aGPfHwz+HtTjfgrf5OhrYW93xJNi3JLapIr1KN8kZby+
	 sCJ/elGWE7NuXFytzVf25OmdAfH2J4iv9FlAY0Z0UE//o67sMmnV3TnrkhEAUFmO0v
	 YlmpnIuqCD43dMq9aUyjCn1xu9X5B+H/zn9xpHNgAC9RAJNmg28h7NNdhYEhUDyamT
	 Yj5mDilY32C9TExvx0AhvzR2cCrVuL56/wwlz0mh7+3TqYyZc89BgcEIqF+7uTUZE/
	 QmaZYuktl8uUg==
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
Subject: [PATCH v3 1/7] KEYS: trusted: Remove dead branch from tpm2_unseal_cmd
Date: Wed, 10 Dec 2025 16:39:33 +0200
Message-ID: <20251210143940.264191-2-jarkko@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251210143940.264191-1-jarkko@kernel.org>
References: <20251210143940.264191-1-jarkko@kernel.org>
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
index 9074ae1a5896..27424e1a4a63 100644
--- a/security/keys/trusted-keys/trusted_tpm2.c
+++ b/security/keys/trusted-keys/trusted_tpm2.c
@@ -450,9 +450,7 @@ static int tpm2_unseal_cmd(struct tpm_chip *chip,
 			   struct trusted_key_options *options,
 			   u32 blob_handle)
 {
-	struct tpm_header *head;
 	u16 data_len;
-	int offset;
 	u8 *data;
 	int rc;
 
@@ -488,14 +486,8 @@ static int tpm2_unseal_cmd(struct tpm_chip *chip,
 		tpm_buf_append_u16(buf, options->blobauth_len);
 		tpm_buf_append(buf, options->blobauth, options->blobauth_len);
 
-		if (tpm2_chip_auth(chip)) {
+		if (tpm2_chip_auth(chip))
 			tpm_buf_append_hmac_session(chip, buf, TPM2_SA_ENCRYPT, NULL, 0);
-		} else  {
-			offset = buf->handles * 4 + TPM_HEADER_SIZE;
-			head = (struct tpm_header *)buf->data;
-			if (tpm_buf_length(buf) == offset)
-				head->tag = cpu_to_be16(TPM2_ST_NO_SESSIONS);
-		}
 	}
 
 	rc = tpm_buf_fill_hmac_session(chip, buf);
-- 
2.52.0


