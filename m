Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 712E162ECB9
	for <lists+linux-integrity@lfdr.de>; Fri, 18 Nov 2022 05:05:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241020AbiKREFt (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 17 Nov 2022 23:05:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235178AbiKREE7 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 17 Nov 2022 23:04:59 -0500
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39E4598241;
        Thu, 17 Nov 2022 20:04:41 -0800 (PST)
From:   =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=weissschuh.net;
        s=mail; t=1668744275;
        bh=P/SxYrzIDdEyGtP2C7/8aV4gnstE9Djts92CSEamDqg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LGhsJnfLe8kJSopHA7/MaHb4q5Q8CqAWSKTSOkQQE9L/WlUY2AaPzncPaEJsdc/0G
         LFynYr1APxAyOrYQxvJKeqg2Y9dciSqUq15c0yGo/QEk28P2VXX/EJxngwSMBATS+0
         +jmug/2mV1tZC4mAKwoRLS8YuZjCDrRRQm9VSezo=
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
Subject: [PATCH v3 1/3] certs: log hash value on blacklist error
Date:   Fri, 18 Nov 2022 05:03:41 +0100
Message-Id: <20221118040343.2958-2-linux@weissschuh.net>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221118040343.2958-1-linux@weissschuh.net>
References: <20221118040343.2958-1-linux@weissschuh.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=ed25519-sha256; t=1668744217; l=1006; i=linux@weissschuh.net; s=20211113; h=from:subject; bh=P/SxYrzIDdEyGtP2C7/8aV4gnstE9Djts92CSEamDqg=; b=wAaNSCu5g8hAafN2wCdcLQkehdyg+hECJ2kV43YgMZiDa+w0E7D8Jpy4P/iIuBZvrEBflMpL7Y9L ZSI0/RSAB4PmKBJpq/2dgHHR9Ia9MwKDzHfd9EUajCiWN6brQCAG
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

Without this information these logs are not actionable.

For example on duplicate blacklisted hashes reported by the system
firmware users should be able to report the erroneous hashes to their
system vendors.

While we are at it use the dedicated format string for ERR_PTR.

Fixes: 6364d106e041 ("certs: Allow root user to append signed hashes to the blacklist keyring")
Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 certs/blacklist.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/certs/blacklist.c b/certs/blacklist.c
index 41f10601cc72..6e260c4b6a19 100644
--- a/certs/blacklist.c
+++ b/certs/blacklist.c
@@ -192,7 +192,7 @@ static int mark_raw_hash_blacklisted(const char *hash)
 				   KEY_ALLOC_NOT_IN_QUOTA |
 				   KEY_ALLOC_BUILT_IN);
 	if (IS_ERR(key)) {
-		pr_err("Problem blacklisting hash (%ld)\n", PTR_ERR(key));
+		pr_err("Problem blacklisting hash %s: %pe\n", hash, key);
 		return PTR_ERR(key);
 	}
 	return 0;
-- 
2.38.1

