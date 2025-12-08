Return-Path: <linux-integrity+bounces-7854-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 79009CAD80A
	for <lists+linux-integrity@lfdr.de>; Mon, 08 Dec 2025 15:56:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1C4F53022F32
	for <lists+linux-integrity@lfdr.de>; Mon,  8 Dec 2025 14:54:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC3A32D7DFF;
	Mon,  8 Dec 2025 14:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V4jL4Xaq"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9452127F19F;
	Mon,  8 Dec 2025 14:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765205683; cv=none; b=AbXBggJpeuPD3tD6geJY5krQWylFuvuFV+Te4uJOMnEjR/+s1hBHAUds/wWplPQDvHom6HZwTIM76pNO0uVq2daVF7M9Vu3LhBHbFUUqd8USpBUtfik12lIRlDUcNYer8DvlEUBktxOHCzRr0RGWrjlu59+q6QoG9Il+hbFGlZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765205683; c=relaxed/simple;
	bh=GvW6n/lAGt/LmYRllNamSKK/+4hnPj7HQYQ86EXpy1I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sj4au4MLBKNLKra14xx/oBYhPfQYRpe3GBQEt/8XoJ7gJHHY2WFSzY0OnGz5O7ZLrxv66Qe/Md1KG1tEBkqfW0yWWeDOlnV0BjVgHi1XuKhl0LpaC2P9y3GQHPErCYK/THdF/y8EDoJ0rgSkEBUMA9izzD5hbDsynanmM1d0r2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V4jL4Xaq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCBB4C19425;
	Mon,  8 Dec 2025 14:54:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765205683;
	bh=GvW6n/lAGt/LmYRllNamSKK/+4hnPj7HQYQ86EXpy1I=;
	h=From:To:Cc:Subject:Date:From;
	b=V4jL4Xaqx+i7JzCIckp9tElRYrKwL2c7BeNTskQkYHKCrlRiPwckz5uVcDhRw093R
	 bftrWkL/+sJCYZGoQ5I98STSTDK+XAjJ79Q89UpPPIJRU+WDZTb4cXljiB5fm+J3wg
	 uFxgr+QSvf2Xqeyb+EY9pBi4xjboU2Eozv9sShywW+9sS4lhXYDDy4Gb6L3DYFOHP4
	 OgEudsFm7wiLy0n6cJwcs9UH+r+qqcSQ0sDHKwEqT7OAcNDfw7YtOIxxm7uvWvy1nZ
	 UeV8W0dNCa1fX0Xbrf4EdCyifsOtqdSXGQ1YA0hXxExN4pYeZTO3aKJioAt98v1xkD
	 txxO6JY9QToYw==
From: Jarkko Sakkinen <jarkko@kernel.org>
To: linux-integrity@vger.kernel.org
Cc: Jarkko Sakkinen <jarkko@kernel.org>,
	stable@vger.kernel.org,
	James Bottomley <James.Bottomley@HansenPartnership.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	David Howells <dhowells@redhat.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	keyrings@vger.kernel.org (open list:KEYS-TRUSTED),
	linux-security-module@vger.kernel.org (open list:SECURITY SUBSYSTEM),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] KEYS: trusted: Fix overwrite of keyhandle parameter
Date: Mon,  8 Dec 2025 16:54:35 +0200
Message-Id: <20251208145436.21519-1-jarkko@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

tpm2_key_decode() overrides the explicit keyhandle parameter, which can
lead to problems, if the loaded parent handle does not match the handle
stored to the key file. This can easily happen as handle by definition
is an ambiguous attribute.

Cc: stable@vger.kernel.org # v5.13+
Fixes: f2219745250f ("security: keys: trusted: use ASN.1 TPM2 key format for the blobs")
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
---
 security/keys/trusted-keys/trusted_tpm2.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/security/keys/trusted-keys/trusted_tpm2.c b/security/keys/trusted-keys/trusted_tpm2.c
index fb76c4ea496f..950684e54c71 100644
--- a/security/keys/trusted-keys/trusted_tpm2.c
+++ b/security/keys/trusted-keys/trusted_tpm2.c
@@ -121,7 +121,9 @@ static int tpm2_key_decode(struct trusted_key_payload *payload,
 		return -ENOMEM;
 
 	*buf = blob;
-	options->keyhandle = ctx.parent;
+
+	if (!options->keyhandle)
+		options->keyhandle = ctx.parent;
 
 	memcpy(blob, ctx.priv, ctx.priv_len);
 	blob += ctx.priv_len;
-- 
2.39.5


