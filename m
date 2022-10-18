Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BF826025A5
	for <lists+linux-integrity@lfdr.de>; Tue, 18 Oct 2022 09:26:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbiJRH01 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 18 Oct 2022 03:26:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbiJRH00 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 18 Oct 2022 03:26:26 -0400
Received: from mail.nfschina.com (mail.nfschina.com [124.16.136.209])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 12EC01900A;
        Tue, 18 Oct 2022 00:26:23 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mail.nfschina.com (Postfix) with ESMTP id 189201E80D76;
        Tue, 18 Oct 2022 15:25:42 +0800 (CST)
X-Virus-Scanned: amavisd-new at test.com
Received: from mail.nfschina.com ([127.0.0.1])
        by localhost (mail.nfschina.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id gJH4XJN1_3v4; Tue, 18 Oct 2022 15:25:39 +0800 (CST)
Received: from localhost.localdomain (unknown [219.141.250.2])
        (Authenticated sender: zeming@nfschina.com)
        by mail.nfschina.com (Postfix) with ESMTPA id 4B8E81E80D17;
        Tue, 18 Oct 2022 15:25:39 +0800 (CST)
From:   Li zeming <zeming@nfschina.com>
To:     zohar@linux.ibm.com, dmitry.kasatkin@gmail.com,
        paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, Li zeming <zeming@nfschina.com>
Subject: [PATCH] integrity: iint: Optimize integrity_iintcache_init and integrity_inode_free function
Date:   Tue, 18 Oct 2022 15:26:11 +0800
Message-Id: <20221018072611.198802-1-zeming@nfschina.com>
X-Mailer: git-send-email 2.18.2
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

These functions are optimized as follows.
1. Remove void * variable foo cast type.
2. iint_cache Added memory allocation check.

Signed-off-by: Li zeming <zeming@nfschina.com>
---
 security/integrity/iint.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/security/integrity/iint.c b/security/integrity/iint.c
index 8638976f7990..7c902b92482e 100644
--- a/security/integrity/iint.c
+++ b/security/integrity/iint.c
@@ -160,7 +160,7 @@ void integrity_inode_free(struct inode *inode)
 
 static void init_once(void *foo)
 {
-	struct integrity_iint_cache *iint = (struct integrity_iint_cache *) foo;
+	struct integrity_iint_cache *iint = foo;
 
 	memset(iint, 0, sizeof(*iint));
 	iint->ima_file_status = INTEGRITY_UNKNOWN;
@@ -177,6 +177,9 @@ static int __init integrity_iintcache_init(void)
 	iint_cache =
 	    kmem_cache_create("iint_cache", sizeof(struct integrity_iint_cache),
 			      0, SLAB_PANIC, init_once);
+	if (!iint_cache)
+		return -ENOMEM;
+
 	return 0;
 }
 DEFINE_LSM(integrity) = {
-- 
2.18.2

