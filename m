Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E2F366721B
	for <lists+linux-integrity@lfdr.de>; Thu, 12 Jan 2023 13:25:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231437AbjALMZv (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 12 Jan 2023 07:25:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229946AbjALMZt (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 12 Jan 2023 07:25:49 -0500
Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B21F3E851
        for <linux-integrity@vger.kernel.org>; Thu, 12 Jan 2023 04:25:48 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.18.147.227])
        by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4Nt3V23Vxxz9xFHS
        for <linux-integrity@vger.kernel.org>; Thu, 12 Jan 2023 20:18:02 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
        by APP1 (Coremail) with SMTP id LxC2BwB3sg0f_L9jKjyOAA--.25294S7;
        Thu, 12 Jan 2023 13:25:35 +0100 (CET)
From:   Roberto Sassu <roberto.sassu@huaweicloud.com>
To:     zohar@linux.ibm.com, dmitry.kasatkin@gmail.com
Cc:     linux-integrity@vger.kernel.org, vt@altlinux.org, pvorel@suse.cz,
        stefanb@linux.ibm.com, Roberto Sassu <roberto.sassu@huawei.com>
Subject: [PATCH ima-evm-utils v2 5/9] Introduce TST_LIST variable to select a test to execute
Date:   Thu, 12 Jan 2023 13:24:22 +0100
Message-Id: <20230112122426.3759938-6-roberto.sassu@huaweicloud.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230112122426.3759938-1-roberto.sassu@huaweicloud.com>
References: <20230112122426.3759938-1-roberto.sassu@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: LxC2BwB3sg0f_L9jKjyOAA--.25294S7
X-Coremail-Antispam: 1UD129KBjvJXoW7uF4UCr13XrWxJFWDWrWrAFb_yoW8Xry7pa
        yfCr12gFykuFyak343Wwn7Ga4rCw48Jr17Xr4kJw4j9a15JrsIqr4SkrW3GFy3Kr90vFs5
        Za1Iqr1rW3Z5A3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvKb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
        Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
        rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWUCVW8JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267
        AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r4j6F4UM28EF7xvwVC2z280aVCY1x0267AK
        xVW8JVW8Jr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2
        WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkE
        bVWUJVW8JwACjcxG0xvY0x0EwIxGrwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbV
        WUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF
        67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42
        IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF
        0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxh
        VjvjDU0xZFpf9x07UZo7tUUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgAPBF1jj4OGlwAAsq
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Roberto Sassu <roberto.sassu@huawei.com>

It might be desirable, due to restrictions in the testing environment, to
execute tests individually. Introduce the TST_LIST variable, which can be
set with the name of the test to execute. If the variable is set,
expect_pass and expect_fail automatically skip the tests when the first
argument of those functions does not match the value of TST_LIST.

TST_LIST can be also used in conjunction with the UML kernel. It is
sufficient to add it to the kernel command line.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 tests/functions.sh | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/tests/functions.sh b/tests/functions.sh
index 98829d94fae1..298c30393ce6 100755
--- a/tests/functions.sh
+++ b/tests/functions.sh
@@ -72,6 +72,12 @@ declare -i TNESTED=0 # just for sanity checking
 expect_pass() {
   local -i ret
 
+  if [ -n "$TST_LIST" ] && [ "${TST_LIST/$1/}" = $TST_LIST ]; then
+    [ "$VERBOSE" -gt 1 ] && echo "____ SKIP test: $*"
+    testsskip+=1
+    return $SKIP
+  fi
+
   if [ $TNESTED -gt 0 ]; then
     echo $RED"expect_pass should not be run nested"$NORM
     testsfail+=1
@@ -98,6 +104,12 @@ expect_pass() {
 expect_fail() {
   local ret
 
+  if [ -n "$TST_LIST" ] && [ "${TST_LIST/$1/}" = $TST_LIST ]; then
+    [ "$VERBOSE" -gt 1 ] && echo "____ SKIP test: $*"
+    testsskip+=1
+    return $SKIP
+  fi
+
   if [ $TNESTED -gt 0 ]; then
     echo $RED"expect_fail should not be run nested"$NORM
     testsfail+=1
-- 
2.25.1

