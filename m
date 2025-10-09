Return-Path: <linux-integrity+bounces-7402-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F956BCA85D
	for <lists+linux-integrity@lfdr.de>; Thu, 09 Oct 2025 20:07:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D860483150
	for <lists+linux-integrity@lfdr.de>; Thu,  9 Oct 2025 18:07:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36891248F7F;
	Thu,  9 Oct 2025 18:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="XdrslLBy"
X-Original-To: linux-integrity@vger.kernel.org
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD57423C8A1
	for <linux-integrity@vger.kernel.org>; Thu,  9 Oct 2025 18:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760033230; cv=none; b=Xj6LO/bB2TEaoGgYOMWF0xBW5ZsVOmM+3nqd8KPGptoZUcr80M+qWYI4WgJ/U85yNKwF+yTTJ6I4jyWqtCr//jTSunfxIMerN1BbTfnLNKOSOXJ2jJwALTFfw76p+vHgrPTG+Qw91sElPQ+8NYYyAhFvu88IFEK2NqIGigkhiCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760033230; c=relaxed/simple;
	bh=+XROxS/6axodpUAsRfm1JbYQuQXZCNtj0a3EoWZH/LM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WTnIpINU8i/8QZ/LxhKWJxMSxNyZg4jtqASyoWsbCWezO06qwd6nNBwcjZE6H03ZctkACwxTXhiQvFy11TxJqR+pu7hXacjCMxvGxcX0WXAu/lMgwpWmFyjT2CdgbjjTrF+rLmslG9c06c/2x6LmcU8qfOsWeOQNn6W3HqrG60k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=XdrslLBy; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1760033225;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=EwX0KL5LDLB0rYQfiUxmeS4R3P9DgIfWZ4jyJPaAZqI=;
	b=XdrslLByArftI55uoHmsSsnxNGGLi5UoQYq8vD1LR5CnQyBNPnLFwO13gqjf+AOI8lRdga
	1d+Q51nchqY2H4fYdTtKlxmAoIdfoNXrELZiCZUAOTIa4N4mCwl5l4LNtaaPEnfjztUmus
	tn1Am2ibCPJWaqbFRMY9sI9pqk+SskQ=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Mimi Zohar <zohar@linux.ibm.com>,
	David Howells <dhowells@redhat.com>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>
Cc: linux-hardening@vger.kernel.org,
	Thorsten Blum <thorsten.blum@linux.dev>,
	linux-integrity@vger.kernel.org,
	keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] keys: Replace deprecated strncpy in ecryptfs_fill_auth_tok
Date: Thu,  9 Oct 2025 20:03:17 +0200
Message-ID: <20251009180316.394708-3-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

strncpy() is deprecated for NUL-terminated destination buffers; use
strscpy_pad() instead.

Link: https://github.com/KSPP/linux/issues/90
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 security/keys/encrypted-keys/ecryptfs_format.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/security/keys/encrypted-keys/ecryptfs_format.c b/security/keys/encrypted-keys/ecryptfs_format.c
index 8fdd76105ce3..2fc6f3a66135 100644
--- a/security/keys/encrypted-keys/ecryptfs_format.c
+++ b/security/keys/encrypted-keys/ecryptfs_format.c
@@ -54,8 +54,7 @@ int ecryptfs_fill_auth_tok(struct ecryptfs_auth_tok *auth_tok,
 	auth_tok->version = (((uint16_t)(major << 8) & 0xFF00)
 			     | ((uint16_t)minor & 0x00FF));
 	auth_tok->token_type = ECRYPTFS_PASSWORD;
-	strncpy((char *)auth_tok->token.password.signature, key_desc,
-		ECRYPTFS_PASSWORD_SIG_SIZE);
+	strscpy_pad(auth_tok->token.password.signature, key_desc);
 	auth_tok->token.password.session_key_encryption_key_bytes =
 		ECRYPTFS_MAX_KEY_BYTES;
 	/*
-- 
2.51.0


