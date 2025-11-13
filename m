Return-Path: <linux-integrity+bounces-7621-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BB3FC57D40
	for <lists+linux-integrity@lfdr.de>; Thu, 13 Nov 2025 15:03:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E132C34477D
	for <lists+linux-integrity@lfdr.de>; Thu, 13 Nov 2025 13:59:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98521242D7B;
	Thu, 13 Nov 2025 13:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Hfx+M/ag"
X-Original-To: linux-integrity@vger.kernel.org
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 872C623EA8C
	for <linux-integrity@vger.kernel.org>; Thu, 13 Nov 2025 13:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763042347; cv=none; b=D0uxJS2vwH30864GygSkD34Isb+U2evKiqrNm4O1jUoM8tmBdSEvoSzNu48SvH48bkFRGy1cjmZBInHUzmclctP7/D5P6Tbq5IDyXJduk7cLVI1UL5v3uO47jkEXCnl+Fmk6fC/CXy/RMHwnjPFVi0mL6+6o+fUBI80Kf7wnRHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763042347; c=relaxed/simple;
	bh=kfd3RyhY4DVWYu8nmIBTbsxRwtREU+3sF2ZT8G9U/3M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=f0XAa/kl/5ILqSxFo4blRz4SPZPPESTWMHK01IlpYzuzt4YsIKryRPdrrDVXj9KLB3TtaEEzekasol0UpL1d/wSXKJnPB7KE6J5f3vdNR2ztWTcNd/WPtQVOwr10pZiJbCW4Fy1fjp2iTiHLkjcrX5yQDwxVoYK5JpSASW7WnOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Hfx+M/ag; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1763042332;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=0MNWm6Lip8Ocum3HyzjrIKBsn/zjzGl1/AKODQ4rsM4=;
	b=Hfx+M/agSYpYvlAwaquDtryNqbnRDrenQ3vOdWcwPWn9kCPPlQfx3+KfAJnj3C5yWw+5SY
	GJmqz/17VpljQPZISfU5oU9AD9GYsL4TBscVVvTVquqwxUWNwdexEmXDdnnZ2Wp17eTWzW
	FJsXvJeCmWNLWvhtMXMU5Bc9QzFgaec=
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
Subject: [PATCH] KEYS: encrypted: Replace deprecated strcpy and improve get_derived_key
Date: Thu, 13 Nov 2025 14:58:31 +0100
Message-ID: <20251113135831.98587-1-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Determine 'key_name' before allocating memory for 'derived_buf' to only
allocate as many bytes as needed. Currently, we potentially allocate one
more byte than necessary when 'key_name' is "ENC_KEY".

strcpy() is deprecated and uses an additional strlen() internally; use
memcpy() directly to copy 'key_name' since we already know its length
and that it is guaranteed to be NUL-terminated.

Also reuse 'key_name_len' when copying 'master_key' instead of calling
strlen() again.

Link: https://github.com/KSPP/linux/issues/88
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 security/keys/encrypted-keys/encrypted.c | 22 +++++++++-------------
 1 file changed, 9 insertions(+), 13 deletions(-)

diff --git a/security/keys/encrypted-keys/encrypted.c b/security/keys/encrypted-keys/encrypted.c
index 15841466b5d4..b16a5b8b935b 100644
--- a/security/keys/encrypted-keys/encrypted.c
+++ b/security/keys/encrypted-keys/encrypted.c
@@ -12,6 +12,7 @@
  */
 
 #include <linux/uaccess.h>
+#include <linux/minmax.h>
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/slab.h>
@@ -330,23 +331,18 @@ static int get_derived_key(u8 *derived_key, enum derived_key_type key_type,
 			   const u8 *master_key, size_t master_keylen)
 {
 	u8 *derived_buf;
-	unsigned int derived_buf_len;
-
-	derived_buf_len = strlen("AUTH_KEY") + 1 + master_keylen;
-	if (derived_buf_len < HASH_SIZE)
-		derived_buf_len = HASH_SIZE;
+	size_t derived_buf_len;
+	const char *key_name;
+	size_t key_name_len;
 
+	key_name = key_type ? "AUTH_KEY" : "ENC_KEY";
+	key_name_len = strlen(key_name) + 1;
+	derived_buf_len = max(key_name_len + master_keylen, HASH_SIZE);
 	derived_buf = kzalloc(derived_buf_len, GFP_KERNEL);
 	if (!derived_buf)
 		return -ENOMEM;
-
-	if (key_type)
-		strcpy(derived_buf, "AUTH_KEY");
-	else
-		strcpy(derived_buf, "ENC_KEY");
-
-	memcpy(derived_buf + strlen(derived_buf) + 1, master_key,
-	       master_keylen);
+	memcpy(derived_buf, key_name, key_name_len);
+	memcpy(derived_buf + key_name_len, master_key, master_keylen);
 	sha256(derived_buf, derived_buf_len, derived_key);
 	kfree_sensitive(derived_buf);
 	return 0;
-- 
2.51.1


