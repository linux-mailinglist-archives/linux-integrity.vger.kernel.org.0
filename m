Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B8486B0FE2
	for <lists+linux-integrity@lfdr.de>; Wed,  8 Mar 2023 18:11:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229683AbjCHRLx (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 8 Mar 2023 12:11:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbjCHRLx (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 8 Mar 2023 12:11:53 -0500
Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FF00136DC;
        Wed,  8 Mar 2023 09:11:50 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.18.147.228])
        by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4PWzCW3J82z9xGnQ;
        Thu,  9 Mar 2023 01:03:03 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
        by APP1 (Coremail) with SMTP id LxC2BwDnbwu8wQhkZuyAAQ--.23704S2;
        Wed, 08 Mar 2023 18:11:31 +0100 (CET)
From:   Roberto Sassu <roberto.sassu@huaweicloud.com>
To:     zohar@linux.ibm.com, dmitry.kasatkin@gmail.com,
        paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, keescook@chromium.org,
        Roberto Sassu <roberto.sassu@huawei.com>
Subject: [PATCH v2] security: Introduce LSM_ORDER_LAST and set it for the integrity LSM
Date:   Wed,  8 Mar 2023 18:11:18 +0100
Message-Id: <20230308171119.1784326-1-roberto.sassu@huaweicloud.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: LxC2BwDnbwu8wQhkZuyAAQ--.23704S2
X-Coremail-Antispam: 1UD129KBjvJXoWxuryrZw4xKw1kur47tr4rAFb_yoW5Crykpa
        yDtFWfGr18AFWS93ZrA3Wak3WfK39YkFy7GrZ8Ww1DAa95Xry0vr4akrySkryUXFyvyF1I
        vr42vr4ak3Wqy3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvab4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
        AFwI0_Gr1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0E
        n4kS14v26r4a6rW5MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I
        0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWU
        tVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcV
        CY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Zr0_Wr1UMIIF0xvEx4A2jsIE
        14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyT
        uYvjxUsrcTDUUUU
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgAKBF1jj4ZaNAAAsV
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Roberto Sassu <roberto.sassu@huawei.com>

Introduce LSM_ORDER_LAST, to satisfy the requirement of LSMs willing to be
the last, e.g. the 'integrity' LSM, without changing the kernel command
line or configuration.

Also, set this order for the 'integrity' LSM. While not enforced, this is
the only LSM expected to use it.

Similarly to LSM_ORDER_FIRST, LSMs with LSM_ORDER_LAST are always enabled
and put at the end of the LSM list.

Finally, for LSM_ORDER_MUTABLE LSMs, set the found variable to true if an
LSM is found, regardless of its order. In this way, the kernel would not
wrongly report that the LSM is not built-in in the kernel if its order is
LSM_ORDER_LAST.

Fixes: 79f7865d844c ("LSM: Introduce "lsm=" for boottime LSM selection")
Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---

Changelog

v1:
- Add comment for LSM_ORDER_LAST definition (suggested by Mimi)
- Add Fixes tag (suggested by Mimi)
- Do minor corrections in the commit messages (suggested by Mimi and Stefan)

 include/linux/lsm_hooks.h |  1 +
 security/integrity/iint.c |  1 +
 security/security.c       | 12 +++++++++---
 3 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 6e156d2acff..c55761d93a2 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -1716,6 +1716,7 @@ extern void security_add_hooks(struct security_hook_list *hooks, int count,
 enum lsm_order {
 	LSM_ORDER_FIRST = -1,	/* This is only for capabilities. */
 	LSM_ORDER_MUTABLE = 0,
+	LSM_ORDER_LAST = 1,	/* This is only for integrity. */
 };
 
 struct lsm_info {
diff --git a/security/integrity/iint.c b/security/integrity/iint.c
index 8638976f799..b97eb59e0e3 100644
--- a/security/integrity/iint.c
+++ b/security/integrity/iint.c
@@ -182,6 +182,7 @@ static int __init integrity_iintcache_init(void)
 DEFINE_LSM(integrity) = {
 	.name = "integrity",
 	.init = integrity_iintcache_init,
+	.order = LSM_ORDER_LAST,
 };
 
 
diff --git a/security/security.c b/security/security.c
index cf6cc576736..2f36229d5b6 100644
--- a/security/security.c
+++ b/security/security.c
@@ -284,9 +284,9 @@ static void __init ordered_lsm_parse(const char *order, const char *origin)
 		bool found = false;
 
 		for (lsm = __start_lsm_info; lsm < __end_lsm_info; lsm++) {
-			if (lsm->order == LSM_ORDER_MUTABLE &&
-			    strcmp(lsm->name, name) == 0) {
-				append_ordered_lsm(lsm, origin);
+			if (strcmp(lsm->name, name) == 0) {
+				if (lsm->order == LSM_ORDER_MUTABLE)
+					append_ordered_lsm(lsm, origin);
 				found = true;
 			}
 		}
@@ -306,6 +306,12 @@ static void __init ordered_lsm_parse(const char *order, const char *origin)
 		}
 	}
 
+	/* LSM_ORDER_LAST is always last. */
+	for (lsm = __start_lsm_info; lsm < __end_lsm_info; lsm++) {
+		if (lsm->order == LSM_ORDER_LAST)
+			append_ordered_lsm(lsm, "   last");
+	}
+
 	/* Disable all LSMs not in the ordered list. */
 	for (lsm = __start_lsm_info; lsm < __end_lsm_info; lsm++) {
 		if (exists_ordered_lsm(lsm))
-- 
2.25.1

