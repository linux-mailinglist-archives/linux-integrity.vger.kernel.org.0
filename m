Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED0D62BB1FE
	for <lists+linux-integrity@lfdr.de>; Fri, 20 Nov 2020 19:07:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729468AbgKTSEm (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 20 Nov 2020 13:04:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729447AbgKTSEm (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 20 Nov 2020 13:04:42 -0500
Received: from smtp-190a.mail.infomaniak.ch (smtp-190a.mail.infomaniak.ch [IPv6:2001:1600:4:17::190a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95287C0613CF;
        Fri, 20 Nov 2020 10:04:41 -0800 (PST)
Received: from smtp-2-0000.mail.infomaniak.ch (unknown [10.5.36.107])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4Cd4FN2xkHzlhYJt;
        Fri, 20 Nov 2020 19:04:40 +0100 (CET)
Received: from localhost (unknown [94.23.54.103])
        by smtp-2-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4Cd4FN0yKKzlh8TN;
        Fri, 20 Nov 2020 19:04:40 +0100 (CET)
From:   =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To:     David Howells <dhowells@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>
Cc:     =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
        "David S . Miller" <davem@davemloft.net>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        James Morris <jmorris@namei.org>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@linux.microsoft.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        "Serge E . Hallyn" <serge@hallyn.com>, keyrings@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: [PATCH v1 6/9] certs: Fix blacklist flag type confusion
Date:   Fri, 20 Nov 2020 19:04:23 +0100
Message-Id: <20201120180426.922572-7-mic@digikod.net>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201120180426.922572-1-mic@digikod.net>
References: <20201120180426.922572-1-mic@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Mickaël Salaün <mic@linux.microsoft.com>

KEY_FLAG_KEEP is not meant to be passed to keyring_alloc() nor
key_alloc(), which only takes KEY_ALLOC_* flags.  KEY_FLAG_KEEP has the
same value as KEY_ALLOC_BYPASS_RESTRICTION, but fortunately only
key_create_or_update() uses it.  LSMs using the key_alloc hook don't
check such flag.

KEY_FLAG_KEEP is then ignored but fortunately (again) the root user
cannot write to the blacklist keyring, then it is not possible to remove
a key/hash from it.

Remove KEY_FLAG_KEEP from the call to keyring_alloc() and set the
keyring flags with it.

This should not fix a bug with the current implementation but it is
required for the next commit to allow to add new hashes to the blacklist
without the possibility to remove them.

Cc: David Howells <dhowells@redhat.com>
Cc: David Woodhouse <dwmw2@infradead.org>
Signed-off-by: Mickaël Salaün <mic@linux.microsoft.com>
---
 certs/blacklist.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/certs/blacklist.c b/certs/blacklist.c
index 0d2c959e9422..d1e2f69d91c2 100644
--- a/certs/blacklist.c
+++ b/certs/blacklist.c
@@ -224,11 +224,11 @@ static int __init blacklist_init(void)
 			      (KEY_POS_ALL & ~KEY_POS_SETATTR) |
 			      KEY_USR_VIEW | KEY_USR_READ |
 			      KEY_USR_SEARCH,
-			      KEY_ALLOC_NOT_IN_QUOTA |
-			      KEY_FLAG_KEEP,
+			      KEY_ALLOC_NOT_IN_QUOTA,
 			      NULL, NULL);
 	if (IS_ERR(blacklist_keyring))
 		panic("Can't allocate system blacklist keyring\n");
+	set_bit(KEY_FLAG_KEEP, &blacklist_keyring->flags);
 
 	for (bl = blacklist_hashes; *bl; bl++)
 		if (mark_raw_hash_blacklisted(*bl) < 0)
-- 
2.29.2

