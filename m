Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F01673D2B41
	for <lists+linux-integrity@lfdr.de>; Thu, 22 Jul 2021 19:36:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229536AbhGVQzY (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 22 Jul 2021 12:55:24 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3457 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229710AbhGVQzX (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 22 Jul 2021 12:55:23 -0400
Received: from fraeml714-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4GVzkX1zfsz6D8XB;
        Fri, 23 Jul 2021 01:21:08 +0800 (CST)
Received: from roberto-ThinkStation-P620.huawei.com (10.204.63.22) by
 fraeml714-chm.china.huawei.com (10.206.15.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 22 Jul 2021 19:35:57 +0200
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     <zohar@linux.ibm.com>
CC:     <pvorel@suse.cz>, <vt@altlinux.org>,
        <linux-integrity@vger.kernel.org>,
        Roberto Sassu <roberto.sassu@huawei.com>
Subject: [RFC][PATCH ima-evm-utils 6/7] Introduce TST_LIST variable to select a test to execute
Date:   Thu, 22 Jul 2021 19:34:13 +0200
Message-ID: <20210722173414.1738041-7-roberto.sassu@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210722173414.1738041-1-roberto.sassu@huawei.com>
References: <20210722173414.1738041-1-roberto.sassu@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.204.63.22]
X-ClientProxiedBy: lhreml753-chm.china.huawei.com (10.201.108.203) To
 fraeml714-chm.china.huawei.com (10.206.15.33)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

It might be desirable, due to restrictions in the testing environment, to
execute tests individually. This patch introduces the TST_LIST variable,
which can be set with the name of the test to execute. If the variable is
set, expect_pass and expect_fail automatically skip the tests when the
first argument of those functions does not match the value of TST_LIST.

TST_LIST can be also used in conjunction with the UML kernel. It is
sufficient to add it to the kernel command line.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 tests/functions.sh | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/tests/functions.sh b/tests/functions.sh
index 9f05429d47ce..2602b4699f5c 100755
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

