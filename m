Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 008E7662BE8
	for <lists+linux-integrity@lfdr.de>; Mon,  9 Jan 2023 17:58:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234178AbjAIQ5q (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 9 Jan 2023 11:57:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbjAIQ5P (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 9 Jan 2023 11:57:15 -0500
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86F0EE0DC
        for <linux-integrity@vger.kernel.org>; Mon,  9 Jan 2023 08:57:14 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.18.147.229])
        by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4NrKfc0Dvtz9v7Vg
        for <linux-integrity@vger.kernel.org>; Tue, 10 Jan 2023 00:49:28 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
        by APP2 (Coremail) with SMTP id GxC2BwCXHWQ9R7xjPQWBAA--.14103S9;
        Mon, 09 Jan 2023 17:57:00 +0100 (CET)
From:   Roberto Sassu <roberto.sassu@huaweicloud.com>
To:     zohar@linux.ibm.com, dmitry.kasatkin@gmail.com
Cc:     linux-integrity@vger.kernel.org, vt@altlinux.org,
        Roberto Sassu <roberto.sassu@huawei.com>
Subject: [PATCH ima-evm-utils 7/8] Adapt fsverity.test to work with UML kernel
Date:   Mon,  9 Jan 2023 17:55:51 +0100
Message-Id: <20230109165552.3409716-8-roberto.sassu@huaweicloud.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230109165552.3409716-1-roberto.sassu@huaweicloud.com>
References: <20230109165552.3409716-1-roberto.sassu@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: GxC2BwCXHWQ9R7xjPQWBAA--.14103S9
X-Coremail-Antispam: 1UD129KBjvJXoW7Ar17Wr43ZF1DWFWDJr18Krg_yoW8Wr43pF
        yUWFyYkrZ3tFyIyw4xWay7AFy0k3y5Zr4UWr97Z3Z5ur95Ar1qyr48tw12gFy5CrZFqa1r
        C3yF9F15G3srCrUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQAMBF1jj4dfhQABsk
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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

