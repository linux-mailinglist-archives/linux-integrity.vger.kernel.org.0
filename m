Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 680A266721D
	for <lists+linux-integrity@lfdr.de>; Thu, 12 Jan 2023 13:26:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232314AbjALM0H (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 12 Jan 2023 07:26:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232256AbjALMZ7 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 12 Jan 2023 07:25:59 -0500
Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C6B2DF38
        for <linux-integrity@vger.kernel.org>; Thu, 12 Jan 2023 04:25:58 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.18.147.227])
        by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4Nt3VD6WTyz9v7bS
        for <linux-integrity@vger.kernel.org>; Thu, 12 Jan 2023 20:18:12 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
        by APP1 (Coremail) with SMTP id LxC2BwB3sg0f_L9jKjyOAA--.25294S9;
        Thu, 12 Jan 2023 13:25:44 +0100 (CET)
From:   Roberto Sassu <roberto.sassu@huaweicloud.com>
To:     zohar@linux.ibm.com, dmitry.kasatkin@gmail.com
Cc:     linux-integrity@vger.kernel.org, vt@altlinux.org, pvorel@suse.cz,
        stefanb@linux.ibm.com, Roberto Sassu <roberto.sassu@huawei.com>
Subject: [PATCH ima-evm-utils v2 7/9] Adapt fsverity.test to work with UML kernel
Date:   Thu, 12 Jan 2023 13:24:24 +0100
Message-Id: <20230112122426.3759938-8-roberto.sassu@huaweicloud.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230112122426.3759938-1-roberto.sassu@huaweicloud.com>
References: <20230112122426.3759938-1-roberto.sassu@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: LxC2BwB3sg0f_L9jKjyOAA--.25294S9
X-Coremail-Antispam: 1UD129KBjvJXoW7Ar17Wr43ZF1DWFWDJr18Krg_yoW8Wr43pF
        yUWFyYkrZ3tFyIyw4xWay7AFy0k3y5Zr4UWr97Z3Z5ur95Ar1qyr48tw12gFy5CrZFqa1r
        C3yF9F15G3srCrUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9jb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
        Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
        rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWUCVW8JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267
        AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAF
        wI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7
        xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Y
        z7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7
        v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF
        1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIx
        AIcVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4l
        IxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvf
        C2KfnxnUUI43ZEXa7IU13l1DUUUUU==
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQAPBF1jj4eEPQABsE
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Roberto Sassu <roberto.sassu@huawei.com>

Adapt fsverity.test by adding calls to the UML kernel API in functions.sh.
If the UML_MODE environment variable is set to 1, run first the UML kernel
specified as first argument of _run_user_mode() and execute the tests in
the new environment. Otherwise, keep the current behavior.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 tests/fsverity.test | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/tests/fsverity.test b/tests/fsverity.test
index 549c42a32608..84312aa08a30 100755
--- a/tests/fsverity.test
+++ b/tests/fsverity.test
@@ -49,7 +49,7 @@ _require dd mkfs blkid e2fsck tune2fs evmctl setfattr
 
 trap cleanup SIGINT SIGTERM EXIT
 
-cleanup() {
+_cleanup() {
         if [ -e $TST_MNT ]; then
 		if [ $LOOPBACK_MOUNTED -eq 1 ]; then
 			umount $TST_MNT
@@ -61,6 +61,11 @@ cleanup() {
 	_report_exit_and_cleanup
 }
 
+cleanup() {
+	_cleanup_user_mode _cleanup
+	_report_exit_and_cleanup
+}
+
 # Loopback mount a file
 mount_loopback_file() {
 	local ret
@@ -309,6 +314,15 @@ measure-ima() {
 	return "$error"
 }
 
+# Run in User Mode Linux.
+_run_user_mode ../linux $PWD/$(basename $0) "UML_MODE=$UML_MODE PATH=$PATH LD_LIBRARY_PATH=$LD_LIBRARY_PATH VERBOSE=$VERBOSE"
+
+# Exit from the parent if UML was used.
+_exit_user_mode ../linux
+
+# Mount filesystems in UML environment.
+_init_user_mode
+
 # Dependency on being able to read and write the IMA policy file.
 # Requires both CONFIG_IMA_WRITE_POLICY, CONFIG_IMA_READ_POLICY be
 # enabled.
-- 
2.25.1

