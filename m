Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFF3E2BB202
	for <lists+linux-integrity@lfdr.de>; Fri, 20 Nov 2020 19:07:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728727AbgKTSEq (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 20 Nov 2020 13:04:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729488AbgKTSEq (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 20 Nov 2020 13:04:46 -0500
Received: from smtp-8fa8.mail.infomaniak.ch (smtp-8fa8.mail.infomaniak.ch [IPv6:2001:1600:4:17::8fa8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A6C4C0613CF
        for <linux-integrity@vger.kernel.org>; Fri, 20 Nov 2020 10:04:45 -0800 (PST)
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [10.4.36.108])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4Cd4FR6vGczlhXm5;
        Fri, 20 Nov 2020 19:04:43 +0100 (CET)
Received: from localhost (unknown [94.23.54.103])
        by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4Cd4FQ3LJ6zlh8T3;
        Fri, 20 Nov 2020 19:04:42 +0100 (CET)
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
Subject: [PATCH v1 8/9] certs: Replace K{U,G}IDT_INIT() with GLOBAL_ROOT_{U,G}ID
Date:   Fri, 20 Nov 2020 19:04:25 +0100
Message-Id: <20201120180426.922572-9-mic@digikod.net>
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

Align with the new macros and fix include files.

Cc: David Howells <dhowells@redhat.com>
Cc: David Woodhouse <dwmw2@infradead.org>
Signed-off-by: Mickaël Salaün <mic@linux.microsoft.com>
---
 certs/blacklist.c      | 4 ++--
 certs/system_keyring.c | 5 +++--
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/certs/blacklist.c b/certs/blacklist.c
index e869a23f38de..2404175d76c2 100644
--- a/certs/blacklist.c
+++ b/certs/blacklist.c
@@ -14,6 +14,7 @@
 #include <linux/ctype.h>
 #include <linux/err.h>
 #include <linux/seq_file.h>
+#include <linux/uidgid.h>
 #include <linux/verification.h>
 #include <keys/system_keyring.h>
 #include "blacklist.h"
@@ -263,8 +264,7 @@ static int __init blacklist_init(void)
 
 	blacklist_keyring =
 		keyring_alloc(".blacklist",
-			      KUIDT_INIT(0), KGIDT_INIT(0),
-			      current_cred(),
+			      GLOBAL_ROOT_UID, GLOBAL_ROOT_GID, current_cred(),
 			      KEY_POS_VIEW | KEY_POS_READ | KEY_POS_SEARCH |
 			      KEY_POS_WRITE |
 			      KEY_USR_VIEW | KEY_USR_READ | KEY_USR_SEARCH
diff --git a/certs/system_keyring.c b/certs/system_keyring.c
index 798291177186..4b693da488f1 100644
--- a/certs/system_keyring.c
+++ b/certs/system_keyring.c
@@ -11,6 +11,7 @@
 #include <linux/cred.h>
 #include <linux/err.h>
 #include <linux/slab.h>
+#include <linux/uidgid.h>
 #include <linux/verification.h>
 #include <keys/asymmetric-type.h>
 #include <keys/system_keyring.h>
@@ -98,7 +99,7 @@ static __init int system_trusted_keyring_init(void)
 
 	builtin_trusted_keys =
 		keyring_alloc(".builtin_trusted_keys",
-			      KUIDT_INIT(0), KGIDT_INIT(0), current_cred(),
+			      GLOBAL_ROOT_UID, GLOBAL_ROOT_GID, current_cred(),
 			      ((KEY_POS_ALL & ~KEY_POS_SETATTR) |
 			      KEY_USR_VIEW | KEY_USR_READ | KEY_USR_SEARCH),
 			      KEY_ALLOC_NOT_IN_QUOTA,
@@ -109,7 +110,7 @@ static __init int system_trusted_keyring_init(void)
 #ifdef CONFIG_SECONDARY_TRUSTED_KEYRING
 	secondary_trusted_keys =
 		keyring_alloc(".secondary_trusted_keys",
-			      KUIDT_INIT(0), KGIDT_INIT(0), current_cred(),
+			      GLOBAL_ROOT_UID, GLOBAL_ROOT_GID, current_cred(),
 			      ((KEY_POS_ALL & ~KEY_POS_SETATTR) |
 			       KEY_USR_VIEW | KEY_USR_READ | KEY_USR_SEARCH |
 			       KEY_USR_WRITE),
-- 
2.29.2

