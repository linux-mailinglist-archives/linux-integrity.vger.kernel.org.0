Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B46944F57E0
	for <lists+linux-integrity@lfdr.de>; Wed,  6 Apr 2022 10:44:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237086AbiDFIfD (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 6 Apr 2022 04:35:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381792AbiDFIdv (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 6 Apr 2022 04:33:51 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F356B7FE;
        Tue,  5 Apr 2022 20:33:36 -0700 (PDT)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4KY96b15hLzgYLl;
        Wed,  6 Apr 2022 11:31:51 +0800 (CST)
Received: from huawei.com (10.67.175.31) by dggpemm500024.china.huawei.com
 (7.185.36.203) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Wed, 6 Apr
 2022 11:33:34 +0800
From:   GUO Zihua <guozihua@huawei.com>
To:     <linux-integrity@vger.kernel.org>
CC:     <zohar@linux.ibm.com>, <dmitry.kasatkin@gmail.com>,
        <roberto.sassu@huawei.com>,
        <linux-security-module@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] ima: remove the IMA_TEMPLATE Kconfig option
Date:   Wed, 6 Apr 2022 11:32:42 +0800
Message-ID: <20220406033242.145393-1-guozihua@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.175.31]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500024.china.huawei.com (7.185.36.203)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

It is discovered that allowing template "ima" as the compiled default
would cause the following issue: the boot command line option
"ima_hash=" must be behind "ima_template=", otherwise "ima_hash=" might
be rejected.

The root cause of this issue is that during the processing of ima_hash,
we would try to check whether the hash algorithm is compatible with the
template. If the template is not set at the moment we do the check, we
check the algorithm against the compiled default template. If the
complied default template is "ima", then we reject any hash algorithm
other than sha1 and md5.

For example, if the compiled default template is "ima", and the default
algorithm is sha1 (which is the current default). In the cmdline, we put
in "ima_hash=sha256 ima_template=ima-ng". The expected behavior would be
that ima starts with ima-ng as the template and sha256 as the hash
algorithm. However, during the processing of "ima_hash=",
"ima_template=" has not been processed yet, and hash_setup would check
the configured hash algorithm against the compiled default: ima, and
reject sha256. So at the end, the hash algorithm that is actually used
will be sha1.

With template "ima" removed from the compiled default, we ensure that
the default tempalte would at least be "ima-ng" which allows for
basically any hash algorithm. Users who needs to use "ima" template
could still do it by specifying "ima_template=ima" in boot command line.

This change would not break the algorithm compatibility checking for
IMA.

Fixes: 4286587dccd43 ("ima: add Kconfig default measurement list template")
Signed-off-by: GUO Zihua <guozihua@huawei.com>
---
 security/integrity/ima/Kconfig | 22 +++++++++-------------
 1 file changed, 9 insertions(+), 13 deletions(-)

diff --git a/security/integrity/ima/Kconfig b/security/integrity/ima/Kconfig
index f3a9cc201c8c..f392cac7a7d1 100644
--- a/security/integrity/ima/Kconfig
+++ b/security/integrity/ima/Kconfig
@@ -65,14 +65,11 @@ choice
 	help
 	  Select the default IMA measurement template.
 
-	  The original 'ima' measurement list template contains a
-	  hash, defined as 20 bytes, and a null terminated pathname,
-	  limited to 255 characters.  The 'ima-ng' measurement list
-	  template permits both larger hash digests and longer
-	  pathnames.
-
-	config IMA_TEMPLATE
-		bool "ima"
+	  The 'ima-ng' measurement list template permits various hash
+	  digests and long pathnames. The compiled default template
+	  can be overwritten using the kernel command line
+	  'ima_template=' option.
+
 	config IMA_NG_TEMPLATE
 		bool "ima-ng (default)"
 	config IMA_SIG_TEMPLATE
@@ -82,7 +79,6 @@ endchoice
 config IMA_DEFAULT_TEMPLATE
 	string
 	depends on IMA
-	default "ima" if IMA_TEMPLATE
 	default "ima-ng" if IMA_NG_TEMPLATE
 	default "ima-sig" if IMA_SIG_TEMPLATE
 
@@ -102,19 +98,19 @@ choice
 
 	config IMA_DEFAULT_HASH_SHA256
 		bool "SHA256"
-		depends on CRYPTO_SHA256=y && !IMA_TEMPLATE
+		depends on CRYPTO_SHA256=y
 
 	config IMA_DEFAULT_HASH_SHA512
 		bool "SHA512"
-		depends on CRYPTO_SHA512=y && !IMA_TEMPLATE
+		depends on CRYPTO_SHA512=y
 
 	config IMA_DEFAULT_HASH_WP512
 		bool "WP512"
-		depends on CRYPTO_WP512=y && !IMA_TEMPLATE
+		depends on CRYPTO_WP512=y
 
 	config IMA_DEFAULT_HASH_SM3
 		bool "SM3"
-		depends on CRYPTO_SM3=y && !IMA_TEMPLATE
+		depends on CRYPTO_SM3=y
 endchoice
 
 config IMA_DEFAULT_HASH
-- 
2.17.1

