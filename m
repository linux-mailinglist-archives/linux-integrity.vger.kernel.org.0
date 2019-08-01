Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2F6657D2CE
	for <lists+linux-integrity@lfdr.de>; Thu,  1 Aug 2019 03:24:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729686AbfHABXy (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 31 Jul 2019 21:23:54 -0400
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:57875 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726595AbfHABXy (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 31 Jul 2019 21:23:54 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=zhang.jia@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0TYHlArn_1564622625;
Received: from localhost(mailfrom:zhang.jia@linux.alibaba.com fp:SMTPD_---0TYHlArn_1564622625)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 01 Aug 2019 09:23:52 +0800
From:   Jia Zhang <zhang.jia@linux.alibaba.com>
To:     dhowells@redhat.com, zohar@linux.ibm.com, dmitry.kasatkin@gmail.com
Cc:     keyrings@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhang.jia@linux.alibaba.com
Subject: [PATCH] ima: Allow to import the blacklisted cert signed by secondary CA cert
Date:   Thu,  1 Aug 2019 09:23:45 +0800
Message-Id: <1564622625-112173-1-git-send-email-zhang.jia@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Similar to .ima, the cert imported to .ima_blacklist is able to be
authenticated by a secondary CA cert.

Signed-off-by: Jia Zhang <zhang.jia@linux.alibaba.com>
---
 include/keys/system_keyring.h    | 6 ++++++
 security/integrity/digsig.c      | 6 ------
 security/integrity/ima/ima_mok.c | 2 +-
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/include/keys/system_keyring.h b/include/keys/system_keyring.h
index c1a96fd..7dc91db 100644
--- a/include/keys/system_keyring.h
+++ b/include/keys/system_keyring.h
@@ -31,6 +31,12 @@ extern int restrict_link_by_builtin_and_secondary_trusted(
 #define restrict_link_by_builtin_and_secondary_trusted restrict_link_by_builtin_trusted
 #endif
 
+#ifdef CONFIG_IMA_KEYRINGS_PERMIT_SIGNED_BY_BUILTIN_OR_SECONDARY
+#define restrict_link_to_ima restrict_link_by_builtin_and_secondary_trusted
+#else
+#define restrict_link_to_ima restrict_link_by_builtin_trusted
+#endif
+
 #ifdef CONFIG_SYSTEM_BLACKLIST_KEYRING
 extern int mark_hash_blacklisted(const char *hash);
 extern int is_hash_blacklisted(const u8 *hash, size_t hash_len,
diff --git a/security/integrity/digsig.c b/security/integrity/digsig.c
index 868ade3..c6f3384 100644
--- a/security/integrity/digsig.c
+++ b/security/integrity/digsig.c
@@ -33,12 +33,6 @@
 	".platform",
 };
 
-#ifdef CONFIG_IMA_KEYRINGS_PERMIT_SIGNED_BY_BUILTIN_OR_SECONDARY
-#define restrict_link_to_ima restrict_link_by_builtin_and_secondary_trusted
-#else
-#define restrict_link_to_ima restrict_link_by_builtin_trusted
-#endif
-
 int integrity_digsig_verify(const unsigned int id, const char *sig, int siglen,
 			    const char *digest, int digestlen)
 {
diff --git a/security/integrity/ima/ima_mok.c b/security/integrity/ima/ima_mok.c
index 36cadad..6d0b12d 100644
--- a/security/integrity/ima/ima_mok.c
+++ b/security/integrity/ima/ima_mok.c
@@ -31,7 +31,7 @@ __init int ima_mok_init(void)
 	if (!restriction)
 		panic("Can't allocate IMA blacklist restriction.");
 
-	restriction->check = restrict_link_by_builtin_trusted;
+	restriction->check = restrict_link_to_ima;
 
 	ima_blacklist_keyring = keyring_alloc(".ima_blacklist",
 				KUIDT_INIT(0), KGIDT_INIT(0), current_cred(),
-- 
1.8.3.1

