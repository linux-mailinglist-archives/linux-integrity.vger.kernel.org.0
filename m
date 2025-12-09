Return-Path: <linux-integrity+bounces-7868-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 72FA5CAF91B
	for <lists+linux-integrity@lfdr.de>; Tue, 09 Dec 2025 11:10:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8208030BF37A
	for <lists+linux-integrity@lfdr.de>; Tue,  9 Dec 2025 10:05:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C37D0328266;
	Tue,  9 Dec 2025 10:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u06yAno5"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89E3D2FCBE5;
	Tue,  9 Dec 2025 10:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765274751; cv=none; b=ZMdT0UE9HMFlAwJTALkwkX2EAhy49/rFW8D8v/04DY/mXxHH/vPfaYOmIKxldFZ8fMjIwEP93wuOWbbIKmPli5TEc1yfRuTFTlwLJzw8gxfKYn3YLDZJ1jN/XRdZjE0v5jtjHAuKgGly36RtKMrzn9ZoYi1wRqg8cl+H1stpEnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765274751; c=relaxed/simple;
	bh=YUYqIvNjXnvmL0CNkyW+ra2WzRNZMTP9cgmJvuV1o7E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p35uvoj1qf4H3F1ufJ9Q5nhiHIAF+FK9ZoNbt+Y2C8gTGof3uzQBhnQMxd+0/HKmkYGK7WIVinOB+Voe2Tgsdv/JhmasVt2HQoZbwxC67rtiASJFZCgZMT29znYBcOWbRvIxBCSTK3uTsEmBX4UWEbIXXgrVaV709ldjZgNZHOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u06yAno5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B63B8C4CEF5;
	Tue,  9 Dec 2025 10:05:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765274751;
	bh=YUYqIvNjXnvmL0CNkyW+ra2WzRNZMTP9cgmJvuV1o7E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=u06yAno5ByUPTQh3swMXqJTf1tbyTSJUzlZPa32tC4aZm+GkABCiE243yzyJvfFOa
	 JP9rbapwsr8wAXmSqWXGG3zpHgzwfbL39AwBDUdjqMNVTJIbvPMAtGrJgTcX2bHHEI
	 LB1/dbIjUgI8+UIz6+qSKiCkj6XU6GITJ2qKQpF6FHRsx+XExDLEBRouLTIlK82E/i
	 gYYgP+2/5/PohSvgOxsRI6Is18+JhZ0ybrSBhHrQ+qfRHro+gLLCgQMCtjdb3eE+gK
	 6C0HPxymu2Jc0cjFhKNPZlZq9gh4JdgxMgJ+MfUypoDfW1uRxFIWeH2QMb2Tl7rJeY
	 pIKxF/KHO415w==
From: Jarkko Sakkinen <jarkko@kernel.org>
To: linux-integrity@vger.kernel.org
Cc: Jarkko Sakkinen <jarkko@kernel.org>,
	Peter Huewe <peterhuewe@gmx.de>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	James Bottomley <James.Bottomley@HansenPartnership.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	David Howells <dhowells@redhat.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	linux-kernel@vger.kernel.org (open list),
	keyrings@vger.kernel.org (open list:KEYS-TRUSTED),
	linux-security-module@vger.kernel.org (open list:SECURITY SUBSYSTEM)
Subject: [PATCH v2 1/5] KEYS: trusted: Remove dead branch from tpm2_unseal_cmd
Date: Tue,  9 Dec 2025 12:05:24 +0200
Message-ID: <20251209100529.1700779-2-jarkko@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251209100529.1700779-1-jarkko@kernel.org>
References: <20251209100529.1700779-1-jarkko@kernel.org>
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


