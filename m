Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0A086B0FE5
	for <lists+linux-integrity@lfdr.de>; Wed,  8 Mar 2023 18:12:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbjCHRME (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 8 Mar 2023 12:12:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbjCHRL5 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 8 Mar 2023 12:11:57 -0500
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 508A45ADF8;
        Wed,  8 Mar 2023 09:11:55 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.18.147.229])
        by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4PWzCZ52pfz9xqxM;
        Thu,  9 Mar 2023 01:03:06 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
        by APP1 (Coremail) with SMTP id LxC2BwDnbwu8wQhkZuyAAQ--.23704S3;
        Wed, 08 Mar 2023 18:11:36 +0100 (CET)
From:   Roberto Sassu <roberto.sassu@huaweicloud.com>
To:     zohar@linux.ibm.com, dmitry.kasatkin@gmail.com,
        paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, keescook@chromium.org,
        Roberto Sassu <roberto.sassu@huawei.com>
Subject: [PATCH] Revert "integrity: double check iint_cache was initialized"
Date:   Wed,  8 Mar 2023 18:11:19 +0100
Message-Id: <20230308171119.1784326-2-roberto.sassu@huaweicloud.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230308171119.1784326-1-roberto.sassu@huaweicloud.com>
References: <20230308171119.1784326-1-roberto.sassu@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: LxC2BwDnbwu8wQhkZuyAAQ--.23704S3
X-Coremail-Antispam: 1UD129KBjvJXoWrurWkGF4UXr43try8WFyUZFb_yoW8Jr1xpF
        W2gayUGr1UZFW0ka1vya45uFWSk3yqgry8Wws8Grn7Aas8Zr1jqF1DKryUWFy5WrWFy3WS
        qrn0gr45u3Wqyw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUPab4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUGw
        A2048vs2IY020Ec7CjxVAFwI0_JFI_Gr1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
        w2x7M28EF7xvwVC0I7IYx2IY67AKxVWUJVWUCwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
        WxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
        Gr1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ew
        Av7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY
        6r1j6r4UM4x0Y48IcxkI7VAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS14
        v26r4a6rW5MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8C
        rVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8Zw
        CIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x02
        67AKxVWxJVW8Jr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r
        4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjxU
        Vy89DUUUU
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQAKBF1jj4pYHQAAsx
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Roberto Sassu <roberto.sassu@huawei.com>

With the recent introduction of LSM_ORDER_LAST, the 'integrity' LSM is
always initialized and the iint_cache is always created (the kernel panics
on error). Thus, the additional check of iint_cache in
integrity_inode_get() is no longer necessary.

This reverts commit 92063f3ca73aab794bd5408d3361fd5b5ea33079.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 security/integrity/iint.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/security/integrity/iint.c b/security/integrity/iint.c
index b97eb59e0e3..c73858e8c6d 100644
--- a/security/integrity/iint.c
+++ b/security/integrity/iint.c
@@ -98,14 +98,6 @@ struct integrity_iint_cache *integrity_inode_get(struct inode *inode)
 	struct rb_node *node, *parent = NULL;
 	struct integrity_iint_cache *iint, *test_iint;
 
-	/*
-	 * The integrity's "iint_cache" is initialized at security_init(),
-	 * unless it is not included in the ordered list of LSMs enabled
-	 * on the boot command line.
-	 */
-	if (!iint_cache)
-		panic("%s: lsm=integrity required.\n", __func__);
-
 	iint = integrity_iint_find(inode);
 	if (iint)
 		return iint;
-- 
2.25.1

