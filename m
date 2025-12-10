Return-Path: <linux-integrity+bounces-7895-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B5427CB3997
	for <lists+linux-integrity@lfdr.de>; Wed, 10 Dec 2025 18:22:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0A87A306901F
	for <lists+linux-integrity@lfdr.de>; Wed, 10 Dec 2025 17:20:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D91AE326D5D;
	Wed, 10 Dec 2025 17:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rlBz1who"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A949C324B3B;
	Wed, 10 Dec 2025 17:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765387240; cv=none; b=r5PSH6HLmJpcYu9qeR4Ii237lMul41VhTRjN02HTdMWjhf1Jki+pRa0wuzIYjCYI1uAYltkaZjKmb+oYDYXNNioAot6MF/jLDCuW94xvrht9DGYMBVbMBJ23I8Sq1Gqr+ao5TNLe82HFdi/AKPajgU3rOFyXWMpfYeU5wip0XFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765387240; c=relaxed/simple;
	bh=oKOYQ71Z+3HVJRFfeQlrhZzg8coYWIMYBLNyPIQ6zBg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=k7akdfqFZUt9OSAWah12KZILEDeC2AzMsdkCVjXb+b3nQANQbWed0Q+ZgTTgR7GEpx/CwZr0XZR1xPkdsmPyzlAGD+t1W5Q1WhBEpr5rePt9AH1FbSzpmcv05sfmPDvTacqut0gROTkdQYkwQWmZcUI9Wx2tbu0wc9D+GUnAElM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rlBz1who; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0E46C4CEF1;
	Wed, 10 Dec 2025 17:20:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765387240;
	bh=oKOYQ71Z+3HVJRFfeQlrhZzg8coYWIMYBLNyPIQ6zBg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rlBz1whoH137JQKUdbf5NFbxwg5SoUu6Mc032J2kAI8IGiO8Ac6sTTvVTUIbAjByR
	 euga85shpXGSRILbDS01uLDlQVRd3H96YDCb6gXaDhCvs9HlfUzBLBdZp+9mjb5Ja0
	 MfVK5P08NGWP6VgyE5blzxyD0zior4gJzr6W78AmsYdAw/TQXCGDS4tNMXc2KIDagy
	 lhK0ow/RZFJj2nFyOLpAYMT4Qlg4dnsIq/s8pGvZ+neBHeL4LT14bXkhoqHxZQ+Qet
	 l5H1Lb6v741Ic323PPmIjt25lQEZCyetDvpeJ3ILtaRKum4lPFGR6H39ILNHjVWX/+
	 AYHkcuXEtqVrw==
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
Subject: [PATCH v4 1/8] KEYS: trusted: Remove dead branch from tpm2_unseal_cmd
Date: Wed, 10 Dec 2025 19:20:19 +0200
Message-Id: <20251210172027.109938-2-jarkko@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251210172027.109938-1-jarkko@kernel.org>
References: <20251210172027.109938-1-jarkko@kernel.org>
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
2.39.5


