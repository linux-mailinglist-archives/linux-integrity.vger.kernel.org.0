Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55D8A662BE9
	for <lists+linux-integrity@lfdr.de>; Mon,  9 Jan 2023 17:58:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235031AbjAIQ5r (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 9 Jan 2023 11:57:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229789AbjAIQ51 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 9 Jan 2023 11:57:27 -0500
Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58DE3614F
        for <linux-integrity@vger.kernel.org>; Mon,  9 Jan 2023 08:57:18 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.18.147.227])
        by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4NrKfn31Q5z9v7Yw
        for <linux-integrity@vger.kernel.org>; Tue, 10 Jan 2023 00:49:37 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
        by APP2 (Coremail) with SMTP id GxC2BwCXHWQ9R7xjPQWBAA--.14103S10;
        Mon, 09 Jan 2023 17:57:04 +0100 (CET)
From:   Roberto Sassu <roberto.sassu@huaweicloud.com>
To:     zohar@linux.ibm.com, dmitry.kasatkin@gmail.com
Cc:     linux-integrity@vger.kernel.org, vt@altlinux.org,
        Roberto Sassu <roberto.sassu@huawei.com>
Subject: [PATCH ima-evm-utils 8/8] Use in-place built fsverity binary instead of installing it
Date:   Mon,  9 Jan 2023 17:55:52 +0100
Message-Id: <20230109165552.3409716-9-roberto.sassu@huaweicloud.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230109165552.3409716-1-roberto.sassu@huaweicloud.com>
References: <20230109165552.3409716-1-roberto.sassu@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: GxC2BwCXHWQ9R7xjPQWBAA--.14103S10
X-Coremail-Antispam: 1UD129KBjvJXoW7XrWfCw1xJryDJr4fAw1kKrg_yoW8JrWfp3
        Wjv3W0krn3XFnrCr18GFsFya4Ik395Wr1UZrWkXa4xZFWkAr4Utr1S9r4rWr1fXrWUXrna
        yw40vrn5Ka1DArJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUBab4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
        Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
        rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267
        AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I0E
        14v26r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrV
        C2j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE
        7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCY1x0262kKe7AKxVW8ZVWrXwCF04k20xvY0x
        0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E
        7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcV
        C0I7IYx2IY67AKxVW8JVW5JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJwCI42IY
        6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aV
        CY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x07jxwIDUUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgAMBF1jj4NhnQAAsE
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Roberto Sassu <roberto.sassu@huawei.com>

Instead of making changes to the system, use in-place built fsverity binary
by adding ../fsverity-utils to the PATH variable, so that the binary can be
found with the 'which' command.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 tests/fsverity.test       | 2 +-
 tests/install-fsverity.sh | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/fsverity.test b/tests/fsverity.test
index 84312aa08a30..e05978be7ea6 100755
--- a/tests/fsverity.test
+++ b/tests/fsverity.test
@@ -30,7 +30,7 @@
 # custom policy rules might take precedence.
 
 cd "$(dirname "$0")" || exit 1
-PATH=../src:$PATH
+PATH=../src:../fsverity-utils:$PATH
 source ./functions.sh
 
 # Base VERBOSE on the environment variable, if set.
diff --git a/tests/install-fsverity.sh b/tests/install-fsverity.sh
index 418fc42f472b..d00674c0d3a2 100755
--- a/tests/install-fsverity.sh
+++ b/tests/install-fsverity.sh
@@ -2,6 +2,6 @@
 
 git clone https://git.kernel.org/pub/scm/linux/kernel/git/ebiggers/fsverity-utils.git
 cd fsverity-utils
-CC=gcc make -j$(nproc) && sudo make install
+CC=gcc make -j$(nproc)
 cd ..
 rm -rf fsverity-utils
-- 
2.25.1

