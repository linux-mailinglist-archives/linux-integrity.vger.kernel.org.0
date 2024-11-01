Return-Path: <linux-integrity+bounces-3968-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 052519B9370
	for <lists+linux-integrity@lfdr.de>; Fri,  1 Nov 2024 15:38:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A2B11F24223
	for <lists+linux-integrity@lfdr.de>; Fri,  1 Nov 2024 14:38:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 686D61AAE1C;
	Fri,  1 Nov 2024 14:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="mTCVXdiX";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="1e8g5RvL";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="mTCVXdiX";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="1e8g5RvL"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7B7C1A7249
	for <linux-integrity@vger.kernel.org>; Fri,  1 Nov 2024 14:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730471860; cv=none; b=htoqo2VFrQ+Qdj4zkgTUh55ccLJjCRxjONNoWGfeapE48p7+MUeyiCL7NgFoGMSCreoNuHAa1UaZog5bgfrIX7yVMAmWMRa9qtmPrbkto6oxMktPaSImiBk9DutGzP+aNpoDTp1MFzCXIKzI8UM6cyp+3TfnQECwOnbjeUEJSBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730471860; c=relaxed/simple;
	bh=SoiZLGRhupmlPMz8xcYKzfdf5Nm/gYfWr6IhDSkY/EQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MugeD7xUPF0jqTL5H9IH/HlvOlXcYOLtJuICJ4nu0iCvuonBLKyMRcATJTI/9UGmY+oyX09OClnD4MsdKZDd9l3xgwD5SnVNh8wiue1JB6Nca8i2atR7dD/M9o0h2AbyJXGAuECBCgtqINSWfHNbITW0r8FTIiM3g41eLzMnIcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=mTCVXdiX; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=1e8g5RvL; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=mTCVXdiX; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=1e8g5RvL; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id F2E3F21C5B;
	Fri,  1 Nov 2024 14:37:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1730471856; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=kgQnsygS2WZdQQfVxbZvwRKERagfjDRkXQjp6aZIpKs=;
	b=mTCVXdiXX1bOYLoHnFrvOUdItpPNyiYEhOXCSqEU/8KYG/aSt+zcdrQryNsOkMXajzdib7
	zXEVB6TZjVtr1/HZC0daFsIrIH1l/aBNh6Vr0wcp9xBH5ZZTNorKl+rKtmBZtz4GFORvhK
	0is5/18b0FrRNHpAR4IHPLXWrNQ6/NQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1730471856;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=kgQnsygS2WZdQQfVxbZvwRKERagfjDRkXQjp6aZIpKs=;
	b=1e8g5RvLk4gdjILop5Hva2J6D5mXf+h9XbQxlHmwus3Qwj0F+XSSVMzxv4gX4XKMVpFcxr
	/qdCbsX2Bq690qBQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=mTCVXdiX;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=1e8g5RvL
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1730471856; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=kgQnsygS2WZdQQfVxbZvwRKERagfjDRkXQjp6aZIpKs=;
	b=mTCVXdiXX1bOYLoHnFrvOUdItpPNyiYEhOXCSqEU/8KYG/aSt+zcdrQryNsOkMXajzdib7
	zXEVB6TZjVtr1/HZC0daFsIrIH1l/aBNh6Vr0wcp9xBH5ZZTNorKl+rKtmBZtz4GFORvhK
	0is5/18b0FrRNHpAR4IHPLXWrNQ6/NQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1730471856;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=kgQnsygS2WZdQQfVxbZvwRKERagfjDRkXQjp6aZIpKs=;
	b=1e8g5RvLk4gdjILop5Hva2J6D5mXf+h9XbQxlHmwus3Qwj0F+XSSVMzxv4gX4XKMVpFcxr
	/qdCbsX2Bq690qBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CC11613722;
	Fri,  1 Nov 2024 14:37:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Hi6IMK/nJGeICwAAD6G6ig
	(envelope-from <pvorel@suse.cz>); Fri, 01 Nov 2024 14:37:35 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Cc: Petr Vorel <pvorel@suse.cz>,
	Mimi Zohar <zohar@linux.ibm.com>,
	linux-integrity@vger.kernel.org
Subject: [PATCH 1/2] ima_boot_aggregate: Fix openssl 3.0 deprecation warnings
Date: Fri,  1 Nov 2024 15:37:25 +0100
Message-ID: <20241101143726.1278291-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: F2E3F21C5B
X-Spam-Score: -3.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_COUNT_TWO(0.00)[2];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCPT_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

From the docs:
https://docs.openssl.org/3.0/man7/migration_guide/#deprecated-low-level-digest-functions

    Use of low-level digest functions such as SHA1_Init(3) have been
    informally discouraged from use for a long time. Applications should
    instead use the high level EVP APIs EVP_DigestInit_ex(3),
    EVP_DigestUpdate(3) and EVP_DigestFinal_ex(3), or the quick one-shot
    EVP_Q_digest(3).

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 .../integrity/ima/src/ima_boot_aggregate.c    | 32 +++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/testcases/kernel/security/integrity/ima/src/ima_boot_aggregate.c b/testcases/kernel/security/integrity/ima/src/ima_boot_aggregate.c
index 62468e0d19..68d12fc3c2 100644
--- a/testcases/kernel/security/integrity/ima/src/ima_boot_aggregate.c
+++ b/testcases/kernel/security/integrity/ima/src/ima_boot_aggregate.c
@@ -24,6 +24,7 @@
 
 #if HAVE_LIBCRYPTO
 #include <openssl/sha.h>
+#include <openssl/evp.h>
 
 #define MAX_EVENT_SIZE (1024*1024)
 #define EVENT_HEADER_SIZE 32
@@ -61,7 +62,11 @@ static void display_sha1_digest(unsigned char *pcr)
 static void do_test(void)
 {
 	FILE *fp;
+#if OPENSSL_VERSION_NUMBER > 0x030000000L
+	EVP_MD_CTX *c = NULL;
+#else
 	SHA_CTX c;
+#endif
 	int i;
 
 	if (!file)
@@ -85,12 +90,24 @@ static void do_test(void)
 		}
 
 		if (event.header.pcr < NUM_PCRS) {
+#if OPENSSL_VERSION_NUMBER > 0x030000000L
+			if ((c = EVP_MD_CTX_new()) == NULL)
+				tst_brk(TBROK, "can't get new context");
+
+			EVP_DigestInit_ex(c, EVP_sha1(), NULL);
+			EVP_DigestUpdate(c, pcr[event.header.pcr].digest,
+					 SHA_DIGEST_LENGTH);
+			EVP_DigestUpdate(c, event.header.digest, SHA_DIGEST_LENGTH);
+			EVP_DigestFinal_ex(c, pcr[event.header.pcr].digest, NULL);
+			EVP_MD_CTX_free(c);
+#else
 			SHA1_Init(&c);
 			SHA1_Update(&c, pcr[event.header.pcr].digest,
 				    SHA_DIGEST_LENGTH);
 			SHA1_Update(&c, event.header.digest,
 				    SHA_DIGEST_LENGTH);
 			SHA1_Final(pcr[event.header.pcr].digest, &c);
+#endif
 		}
 
 #if MAX_EVENT_DATA_SIZE < USHRT_MAX
@@ -107,15 +124,30 @@ static void do_test(void)
 
 	/* Extend the boot aggregate with the pseudo PCR digest values */
 	memset(&boot_aggregate, 0, SHA_DIGEST_LENGTH);
+
+#if OPENSSL_VERSION_NUMBER > 0x030000000L
+	EVP_DigestInit_ex(c, EVP_sha1(), NULL);
+#else
 	SHA1_Init(&c);
+#endif
+
 	for (i = 0; i < NUM_PCRS; i++) {
 		if (debug) {
 			printf("PCR-%2.2x: ", i);
 			display_sha1_digest(pcr[i].digest);
 		}
+#if OPENSSL_VERSION_NUMBER > 0x030000000L
+		EVP_DigestUpdate(c, pcr[i].digest, SHA_DIGEST_LENGTH);
+#else
 		SHA1_Update(&c, pcr[i].digest, SHA_DIGEST_LENGTH);
+#endif
 	}
+
+#if OPENSSL_VERSION_NUMBER > 0x030000000L
+	EVP_MD_CTX_free(c);
+#else
 	SHA1_Final(boot_aggregate, &c);
+#endif
 
 	printf("sha1:");
 	display_sha1_digest(boot_aggregate);
-- 
2.45.2


