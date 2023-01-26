Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 669E967CD0E
	for <lists+linux-integrity@lfdr.de>; Thu, 26 Jan 2023 14:59:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231540AbjAZN7Z (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 26 Jan 2023 08:59:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231596AbjAZN7Q (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 26 Jan 2023 08:59:16 -0500
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B46756D5C8
        for <linux-integrity@vger.kernel.org>; Thu, 26 Jan 2023 05:59:07 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.18.147.227])
        by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4P2htv6y3fz9xFQD
        for <linux-integrity@vger.kernel.org>; Thu, 26 Jan 2023 21:51:03 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
        by APP1 (Coremail) with SMTP id LxC2BwB39P_4htJj+ajLAA--.553S8;
        Thu, 26 Jan 2023 14:58:54 +0100 (CET)
From:   Roberto Sassu <roberto.sassu@huaweicloud.com>
To:     zohar@linux.ibm.com, dmitry.kasatkin@gmail.com
Cc:     linux-integrity@vger.kernel.org, vt@altlinux.org, pvorel@suse.cz,
        stefanb@linux.ibm.com, Roberto Sassu <roberto.sassu@huawei.com>
Subject: [PATCH ima-evm-utils v4 06/11] Introduce TST_LIST variable to select a test to execute
Date:   Thu, 26 Jan 2023 14:58:02 +0100
Message-Id: <20230126135807.1848668-7-roberto.sassu@huaweicloud.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230126135807.1848668-1-roberto.sassu@huaweicloud.com>
References: <20230126135807.1848668-1-roberto.sassu@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: LxC2BwB39P_4htJj+ajLAA--.553S8
X-Coremail-Antispam: 1UD129KBjvJXoW7uF4UCr13XrWxJFWDWrWrAFb_yoW8WrW3pa
        yfCryagFykuFy7C3sxGrn29a4rCw4rJr1UZr4kJ34Y93y5Jrs8tr4Sk393WFy3Kr90vFZ5
        Za1Ivr4rW3Z5ArJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvEb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
        Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
        rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWUCVW8JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267
        AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r4j6F4UM28EF7xvwVC2z280aVCY1x0267AK
        xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7
        xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Y
        z7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7
        v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF
        1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIx
        AIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI
        42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWI
        evJa73UjIFyTuYvjxUFgAwUUUUU
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQAJBF1jj4ggcwADsl
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

TST_LIST can be also used in new environments, to execute a subset of
defined tests for each environment. It is sufficient to add the variable
and its value to the kernel command line.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
---
 tests/functions.sh | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/tests/functions.sh b/tests/functions.sh
index 03785db91ad6..2c4d20536316 100755
--- a/tests/functions.sh
+++ b/tests/functions.sh
@@ -72,6 +72,12 @@ declare -i TNESTED=0 # just for sanity checking
 expect_pass() {
   local -i ret
 
+  if [ -n "$TST_LIST" ] && [ "${TST_LIST/$1/}" = "$TST_LIST" ]; then
+    [ "$VERBOSE" -gt 1 ] && echo "____ SKIP test: $*"
+    testsskip+=1
+    return "$SKIP"
+  fi
+
   if [ $TNESTED -gt 0 ]; then
     echo $RED"expect_pass should not be run nested"$NORM
     testsfail+=1
@@ -98,6 +104,12 @@ expect_pass() {
 expect_fail() {
   local ret
 
+  if [ -n "$TST_LIST" ] && [ "${TST_LIST/$1/}" = "$TST_LIST" ]; then
+    [ "$VERBOSE" -gt 1 ] && echo "____ SKIP test: $*"
+    testsskip+=1
+    return "$SKIP"
+  fi
+
   if [ $TNESTED -gt 0 ]; then
     echo $RED"expect_fail should not be run nested"$NORM
     testsfail+=1
-- 
2.25.1

