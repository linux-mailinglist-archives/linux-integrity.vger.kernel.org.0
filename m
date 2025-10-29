Return-Path: <linux-integrity+bounces-7543-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AD62BC1C177
	for <lists+linux-integrity@lfdr.de>; Wed, 29 Oct 2025 17:32:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 592F8347FED
	for <lists+linux-integrity@lfdr.de>; Wed, 29 Oct 2025 16:32:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E4D2334C08;
	Wed, 29 Oct 2025 16:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Dsfb1GSa"
X-Original-To: linux-integrity@vger.kernel.org
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FDA22F0C6F
	for <linux-integrity@vger.kernel.org>; Wed, 29 Oct 2025 16:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761755558; cv=none; b=WC2SBRrDrKM83W7Yz2s/L7Am81dIBhMxsFrU7TXmdGAJNJVmogTCPa9vCKPyNS6JxBCsfaacdqCQRyuyAADSvQRwcUs4RAEiS9R9TJfPUIiF0NEvm4e/1xYcNkGCSmmFqcIe2pPA0JsuUeoFHgG/yUTVevFAnAGxQor8J1Gk/KE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761755558; c=relaxed/simple;
	bh=Ca7xEzFRwrwszkpl4txHQpXwetMMS+OAj7NM+yP3tuk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SJ5HyxRL6tK2sH2YVAj7/NEhJEFKeQl+EEGIKYxe+gsxQi5qdqrcUQl/djwj8TdpoEE+SHLMz5gh3vgBRYnuRe/ilVxxWmgylb/bG+4MZKlxObldK17oUm6GR0d8wPmHUbPa50CzBqreqPf+1FbZ9MnJOJAMCay3e+tyJ2Bol3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Dsfb1GSa; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761755543;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=GOAJ/2xYVpU7WKRC8hlYtRql72lR/1lCG+XFgyo4CmM=;
	b=Dsfb1GSa8mB+EMKzo+G38eO/WnewpdrJhs1oiAo1Li435FydEB6Afj4u9H9uG0Oe569RrQ
	BLD+KIslC0Z3QEForE0vzS4NojqugJLrS7SM43Sa3lV6u/qQ+QmKHY2AH5w1Xzx1qbNt09
	/ZiesvcXOAgBy7p1GCXac+1orbPZuA0=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Mimi Zohar <zohar@linux.ibm.com>,
	David Howells <dhowells@redhat.com>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-integrity@vger.kernel.org,
	keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] KEYS: encrypted: Return early on allocation failure and drop goto
Date: Wed, 29 Oct 2025 17:31:56 +0100
Message-ID: <20251029163157.119000-1-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Return ERR_PTR(-ENOMEM) immediately if memory allocation fails, instead
of using goto and returning a NULL pointer, and remove the now-unused
'out' label.

At the call site, check 'ascii_buf' with IS_ERR() and propagate the
error code returned by datablob_format().

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 security/keys/encrypted-keys/encrypted.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/security/keys/encrypted-keys/encrypted.c b/security/keys/encrypted-keys/encrypted.c
index be1f2118447c..25df00b7dbe9 100644
--- a/security/keys/encrypted-keys/encrypted.c
+++ b/security/keys/encrypted-keys/encrypted.c
@@ -276,7 +276,7 @@ static char *datablob_format(struct encrypted_key_payload *epayload,
 
 	ascii_buf = kmalloc(asciiblob_len + 1, GFP_KERNEL);
 	if (!ascii_buf)
-		goto out;
+		return ERR_PTR(-ENOMEM);
 
 	ascii_buf[asciiblob_len] = '\0';
 
@@ -288,7 +288,6 @@ static char *datablob_format(struct encrypted_key_payload *epayload,
 	bufp = &ascii_buf[len];
 	for (i = 0; i < (asciiblob_len - len) / 2; i++)
 		bufp = hex_byte_pack(bufp, iv[i]);
-out:
 	return ascii_buf;
 }
 
@@ -932,8 +931,8 @@ static long encrypted_read(const struct key *key, char *buffer,
 		goto out;
 
 	ascii_buf = datablob_format(epayload, asciiblob_len);
-	if (!ascii_buf) {
-		ret = -ENOMEM;
+	if (IS_ERR(ascii_buf)) {
+		ret = PTR_ERR(ascii_buf);
 		goto out;
 	}
 
-- 
2.51.0


