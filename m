Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBF2C62222D
	for <lists+linux-integrity@lfdr.de>; Wed,  9 Nov 2022 03:50:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229985AbiKICuf (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 8 Nov 2022 21:50:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbiKICue (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 8 Nov 2022 21:50:34 -0500
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFC381F61A;
        Tue,  8 Nov 2022 18:50:32 -0800 (PST)
From:   =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=weissschuh.net;
        s=mail; t=1667962230;
        bh=COwXzoOJifc0kBYkrsDthoC7PqTOtSdi1o8MWvrZGvg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RFw/Vm2E83YIgHtWCxE5pbYZhS4CloQ/BWpqQZOVwojSlxti2713CWbtT7DfN5yex
         g+GGsYBsuKhOCeD7QxLbnztD1C/IDyi5+pGFTD9AtpIONjJbQEGJyO1z11FSBTMNjk
         uEi8dEEMGzSajlt2uIl9vEakOIORMif0rUAKe1AA=
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
Subject: [PATCH v2 1/3] certs: log more information on blacklist error
Date:   Wed,  9 Nov 2022 03:50:17 +0100
Message-Id: <20221109025019.1855-2-linux@weissschuh.net>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221109025019.1855-1-linux@weissschuh.net>
References: <20221109025019.1855-1-linux@weissschuh.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=ed25519-sha256; t=1667962214; l=781; s=20211113; h=from:subject; bh=COwXzoOJifc0kBYkrsDthoC7PqTOtSdi1o8MWvrZGvg=; b=9x5DbFNV4IeM4Iy0DtoCRUoozHmclKCE+cEgSF4HGqidC0TEXqxiB6lTgA07FCcRuKVcFFgwwsn5 B8EN0PttAwXE0P3l+2gc7DGNn+b1Zq+W6/XVyg0ViLI7WWqXymfn
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

Without this information these logs are not actionable.

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

