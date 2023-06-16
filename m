Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CFD37339D6
	for <lists+linux-integrity@lfdr.de>; Fri, 16 Jun 2023 21:27:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345886AbjFPT1q (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 16 Jun 2023 15:27:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346149AbjFPT1d (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 16 Jun 2023 15:27:33 -0400
Received: from frasgout13.his.huawei.com (unknown [14.137.139.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E686D4697
        for <linux-integrity@vger.kernel.org>; Fri, 16 Jun 2023 12:25:51 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.18.147.229])
        by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4QjTNS717mz9y8JV
        for <linux-integrity@vger.kernel.org>; Sat, 17 Jun 2023 03:14:00 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
        by APP2 (Coremail) with SMTP id GxC2BwAH2F7TtoxksMlFAw--.17356S4;
        Fri, 16 Jun 2023 20:24:19 +0100 (CET)
From:   Roberto Sassu <roberto.sassu@huaweicloud.com>
To:     zohar@linux.ibm.com, dmitry.kasatkin@gmail.com
Cc:     linux-integrity@vger.kernel.org, vt@altlinux.org, pvorel@suse.cz,
        stefanb@linux.ibm.com, paul@paul-moore.com, casey@schaufler-ca.com,
        Roberto Sassu <roberto.sassu@huawei.com>
Subject: [PATCH v3 ima-evm-utils 2/4] Restore correct HMAC calculation for directories
Date:   Fri, 16 Jun 2023 21:23:56 +0200
Message-Id: <20230616192358.314906-3-roberto.sassu@huaweicloud.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230616192358.314906-1-roberto.sassu@huaweicloud.com>
References: <20230616192358.314906-1-roberto.sassu@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: GxC2BwAH2F7TtoxksMlFAw--.17356S4
X-Coremail-Antispam: 1UD129KBjvJXoWrZF1DJFWkAw4fZr4Utr4DCFg_yoW8Jr4kpa
        1UWw1fGFZ5Kr17GFn3tFsrX343WaykWa15XF4kCw15CwnxuFn8KF1xtF43Xas3Jr4rJrWY
        v3ZIgryUXa1DA3JanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUBFb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUXw
        A2048vs2IY020Ec7CjxVAFwI0_Gr0_Xr1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
        w2x7M28EF7xvwVC0I7IYx2IY67AKxVWUCVW8JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
        W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
        6r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2
        WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkE
        bVWUJVW8JwACjcxG0xvY0x0EwIxGrwCY1x0262kKe7AKxVW8ZVWrXwCF04k20xvY0x0EwI
        xGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480
        Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7
        IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJwCI42IY6xAI
        w20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x
        0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x07jga9-UUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgAKBF1jj4rIbAABsS
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        MAY_BE_FORGED,PDS_RDNS_DYNAMIC_FP,RDNS_DYNAMIC,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Roberto Sassu <roberto.sassu@huawei.com>

Commit 6ecb88352886 ("evmctl: Remove left-over check S_ISDIR() for
directory signing") removes fetching the inode generation for directories.

While directories might not be signed, EVM currently calculates the HMAC on
them, including the inode generation.

To keep user space and kernel space aligned, reenable fetching the inode
generation for directories, and add again the comment that the inode
generation cannot be obtained for special files.

Fixes: Commit 6ecb88352886 ("evmctl: Remove left-over check S_ISDIR() for directory signing")
Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 src/evmctl.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/src/evmctl.c b/src/evmctl.c
index c24261cf0e6..7a3ffd7c823 100644
--- a/src/evmctl.c
+++ b/src/evmctl.c
@@ -1229,7 +1229,11 @@ static int calc_evm_hmac(const char *file, const char *keyfile, unsigned char *s
 		goto out;
 	}
 
-	if (S_ISREG(st.st_mode)) {
+	if (S_ISREG(st.st_mode) || S_ISDIR(st.st_mode)) {
+		/*
+		 * We cannot at the moment get generation of special files..
+		 * kernel API does not support it.
+		 */
 		int fd = open(file, 0);
 
 		if (fd < 0) {
-- 
2.25.1

