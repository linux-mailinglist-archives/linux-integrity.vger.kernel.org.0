Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13F9367CD1C
	for <lists+linux-integrity@lfdr.de>; Thu, 26 Jan 2023 15:00:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230399AbjAZOAI (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 26 Jan 2023 09:00:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231786AbjAZN7s (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 26 Jan 2023 08:59:48 -0500
Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 880753C1B
        for <linux-integrity@vger.kernel.org>; Thu, 26 Jan 2023 05:59:29 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.18.147.228])
        by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4P2hv41HStz9v7bc
        for <linux-integrity@vger.kernel.org>; Thu, 26 Jan 2023 21:51:12 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
        by APP1 (Coremail) with SMTP id LxC2BwB39P_4htJj+ajLAA--.553S11;
        Thu, 26 Jan 2023 14:59:07 +0100 (CET)
From:   Roberto Sassu <roberto.sassu@huaweicloud.com>
To:     zohar@linux.ibm.com, dmitry.kasatkin@gmail.com
Cc:     linux-integrity@vger.kernel.org, vt@altlinux.org, pvorel@suse.cz,
        stefanb@linux.ibm.com, Roberto Sassu <roberto.sassu@huawei.com>
Subject: [PATCH ima-evm-utils v4 09/11] Use in-place built fsverity binary instead of installing it
Date:   Thu, 26 Jan 2023 14:58:05 +0100
Message-Id: <20230126135807.1848668-10-roberto.sassu@huaweicloud.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230126135807.1848668-1-roberto.sassu@huaweicloud.com>
References: <20230126135807.1848668-1-roberto.sassu@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: LxC2BwB39P_4htJj+ajLAA--.553S11
X-Coremail-Antispam: 1UD129KBjvJXoW7tFy8XryfXr18uFyfWFyxGrg_yoW8Xw17p3
        Wj93W0krn5XF1UCr48GFsFva4I9rWkWr15XrykXa4IvFWkAr4jqr1Svr4rWr1aqrWUXr4S
        yw4Ivrn5Ka1DArJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU90b4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
        Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
        rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWUCVW8JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267
        AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAF
        wI0_Gr1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I
        80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCj
        c4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4
        AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE
        17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1I6r4UMI
        IF0xvE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1x
        MIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIda
        VFxhVjvjDU0xZFpf9x07UZo7tUUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgAJBF1jj4Qi9AAAss
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Roberto Sassu <roberto.sassu@huawei.com>

Instead of making changes to the system, use in-place built fsverity binary
by adding ../fsverity-utils to the PATH variable, so that the binary can be
found with the 'command -v' command.

Don't delete the fsverity-utils directory, so that the built binary is
available. Not deleting should not be a problem, as the script is meant to
be executed in a CI environment, where cleanup is done by the CI
infrastructure itself.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
---
 tests/fsverity.test       | 2 +-
 tests/install-fsverity.sh | 3 +--
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/tests/fsverity.test b/tests/fsverity.test
index 8261de4ea3c9..01d5c3516631 100755
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
index 418fc42f472b..8311bc023915 100755
--- a/tests/install-fsverity.sh
+++ b/tests/install-fsverity.sh
@@ -2,6 +2,5 @@
 
 git clone https://git.kernel.org/pub/scm/linux/kernel/git/ebiggers/fsverity-utils.git
 cd fsverity-utils
-CC=gcc make -j$(nproc) && sudo make install
+CC=gcc make -j$(nproc)
 cd ..
-rm -rf fsverity-utils
-- 
2.25.1

