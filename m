Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2E9062ECAD
	for <lists+linux-integrity@lfdr.de>; Fri, 18 Nov 2022 05:05:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240995AbiKREFM (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 17 Nov 2022 23:05:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240875AbiKREEW (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 17 Nov 2022 23:04:22 -0500
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C3E963EF;
        Thu, 17 Nov 2022 20:04:15 -0800 (PST)
From:   =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=weissschuh.net;
        s=mail; t=1668744245;
        bh=Ra7zlnQZv+5EzK/Di0o9djZFSiuiekY1TijxrLS1Kd0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Svfd8uOkMbffoYX8Te7hh+Xoiiy90lNcCSkrL2osEx5X9YIAi/ydZ/tAYH20IL1uS
         jHYUEAlOSSeJM9J97nyuEaCdA5zlZiwDPMUUmuX2O8INJZUqUqqEFmkNb3KSdf3QUl
         GtX5XaEU5d9aw6IdSEDICm1ohum0fZdkoU5X9oPE=
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
Subject: [PATCH v3 3/3] certs: don't try to update blacklist keys
Date:   Fri, 18 Nov 2022 05:03:43 +0100
Message-Id: <20221118040343.2958-4-linux@weissschuh.net>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221118040343.2958-1-linux@weissschuh.net>
References: <20221118040343.2958-1-linux@weissschuh.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=ed25519-sha256; t=1668744218; l=1646; i=linux@weissschuh.net; s=20211113; h=from:subject; bh=Ra7zlnQZv+5EzK/Di0o9djZFSiuiekY1TijxrLS1Kd0=; b=euq+Tl37jfAGfQqWEwou2v6H2ZJ/i3UBFQTNVxYuhrCTL+aTWP8IJh6g2+DHhxHMnGpq6zbHgDRr y0u+dCx7BwHjtmfv1ae2GaImiBQH0JxTi21872zx2ey96SFH67Eh
X-Developer-Key: i=linux@weissschuh.net; a=ed25519; pk=9LP6KM4vD/8CwHW7nouRBhWLyQLcK1MkP6aTZbzUlj4=
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

When the same key is blacklisted repeatedly logging at pr_err() level is
excessive as no functionality is impaired.
When these duplicates are provided by buggy firmware there is nothing
the enduser can do to fix the situation.
Instead of spamming the bootlog with errors we use a warning that can
still be seen by OEMs when testing their firmware.

Link: https://lore.kernel.org/all/c8c65713-5cda-43ad-8018-20f2e32e4432@t-8ch.de/
Link: https://lore.kernel.org/all/20221104014704.3469-1-linux@weissschuh.net/
Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 certs/blacklist.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/certs/blacklist.c b/certs/blacklist.c
index 6e260c4b6a19..675dd7a8f07a 100644
--- a/certs/blacklist.c
+++ b/certs/blacklist.c
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

