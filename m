Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 550D662222F
	for <lists+linux-integrity@lfdr.de>; Wed,  9 Nov 2022 03:50:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230064AbiKICuf (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 8 Nov 2022 21:50:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbiKICue (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 8 Nov 2022 21:50:34 -0500
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFCFA1F62F;
        Tue,  8 Nov 2022 18:50:32 -0800 (PST)
From:   =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=weissschuh.net;
        s=mail; t=1667962230;
        bh=5ie3Yn8WEIYoQFT16uM/WFQsRiA4aQakHFCHCuSu24o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=S4RyJ1wzsu+CpZMBbNLMM2Rag3TXO+Xb3KPkzsImCQFf5lvbhoyLEXMvCLg+y4W4P
         s5eZT9wXxoZDpGbOcLoHawu1teXnAudH1mwzGMMXEy1x3Gm9jXVBZh0duYW9j9jTQj
         x4kZPMShWc4wEdNpenaPh88pLrVCr8Ta8dsMZghY=
To:     =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
        David Howells <dhowells@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Eric Snowberg <eric.snowberg@oracle.com>
Cc:     =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
        keyrings@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Pearson <markpearson@lenovo.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: [PATCH v2 3/3] certs: don't try to update blacklist keys
Date:   Wed,  9 Nov 2022 03:50:19 +0100
Message-Id: <20221109025019.1855-4-linux@weissschuh.net>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221109025019.1855-1-linux@weissschuh.net>
References: <20221109025019.1855-1-linux@weissschuh.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=ed25519-sha256; t=1667962214; l=1899; s=20211113; h=from:subject; bh=5ie3Yn8WEIYoQFT16uM/WFQsRiA4aQakHFCHCuSu24o=; b=OUVFxglzNA9V+JeUq6PfXkiyi8NjbHyOn/P067eIM9yuQtAu1elOs+T/uDNnoy72YvI6yHQrLyma IEfj5nx7Dt2CnrEBvK0SE2q0NTMjoP3maKxCmE9wV84O9Uf12dvH
X-Developer-Key: i=linux@weissschuh.net; a=ed25519; pk=9LP6KM4vD/8CwHW7nouRBhWLyQLcK1MkP6aTZbzUlj4=
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

When the same key is blacklisted repeatedly we don't want to log an
error. These duplicates can be provided by buggy firmware. Instead of
spamming the bootlog with errors we use a warning that can still be seen
by OEMs when testing.

Also extend BLACKLIST_KEY_PERM as otherwise the EACCES will shadow the
EEXIST.

Link: https://lore.kernel.org/all/c8c65713-5cda-43ad-8018-20f2e32e4432@t-8ch.de/
Link: https://lore.kernel.org/all/20221104014704.3469-1-linux@weissschuh.net/
Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 certs/blacklist.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/certs/blacklist.c b/certs/blacklist.c
index 6e260c4b6a19..ac8e3166b6d7 100644
--- a/certs/blacklist.c
+++ b/certs/blacklist.c
@@ -26,7 +26,7 @@
  */
 #define MAX_HASH_LEN	128
 
-#define BLACKLIST_KEY_PERM (KEY_POS_SEARCH | KEY_POS_VIEW | \
+#define BLACKLIST_KEY_PERM (KEY_POS_WRITE | KEY_POS_SEARCH | KEY_POS_VIEW | \
 			    KEY_USR_SEARCH | KEY_USR_VIEW)
 
 static const char tbs_prefix[] = "tbs";
@@ -183,16 +183,19 @@ static int mark_raw_hash_blacklisted(const char *hash)
 {
 	key_ref_t key;
 
-	key = key_create_or_update(make_key_ref(blacklist_keyring, true),
-				   "blacklist",
-				   hash,
-				   NULL,
-				   0,
-				   BLACKLIST_KEY_PERM,
-				   KEY_ALLOC_NOT_IN_QUOTA |
-				   KEY_ALLOC_BUILT_IN);
+	key = key_create(make_key_ref(blacklist_keyring, true),
+			 "blacklist",
+			 hash,
+			 NULL,
+			 0,
+			 BLACKLIST_KEY_PERM,
+			 KEY_ALLOC_NOT_IN_QUOTA |
+			 KEY_ALLOC_BUILT_IN);
 	if (IS_ERR(key)) {
-		pr_err("Problem blacklisting hash %s: %pe\n", hash, key);
+		if (PTR_ERR(key) == -EEXIST)
+			pr_warn("Duplicate blacklisted hash %s\n", hash);
+		else
+			pr_err("Problem blacklisting hash %s: %pe\n", hash, key);
 		return PTR_ERR(key);
 	}
 	return 0;
-- 
2.38.1

