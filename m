Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E131380D06
	for <lists+linux-integrity@lfdr.de>; Fri, 14 May 2021 17:29:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234753AbhENPak (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 14 May 2021 11:30:40 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3077 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233842AbhENPah (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 14 May 2021 11:30:37 -0400
Received: from fraeml714-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4FhXKp2mG7z6rmKT;
        Fri, 14 May 2021 23:21:02 +0800 (CST)
Received: from roberto-ThinkStation-P620.huawei.com (10.204.62.217) by
 fraeml714-chm.china.huawei.com (10.206.15.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 14 May 2021 17:29:24 +0200
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     <zohar@linux.ibm.com>, <mjg59@srcf.ucam.org>
CC:     <linux-integrity@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Roberto Sassu <roberto.sassu@huawei.com>
Subject: [PATCH v7 09/12] evm: Deprecate EVM_ALLOW_METADATA_WRITES
Date:   Fri, 14 May 2021 17:27:50 +0200
Message-ID: <20210514152753.982958-10-roberto.sassu@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210514152753.982958-1-roberto.sassu@huawei.com>
References: <20210514152753.982958-1-roberto.sassu@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.204.62.217]
X-ClientProxiedBy: lhreml753-chm.china.huawei.com (10.201.108.203) To
 fraeml714-chm.china.huawei.com (10.206.15.33)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

This patch deprecates the usage of EVM_ALLOW_METADATA_WRITES, as it is no
longer necessary. All the issues that prevent the usage of EVM portable
signatures just with a public key loaded have been solved.

This flag will remain available for a short time to ensure that users are
able to use EVM without it.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 Documentation/ABI/testing/evm | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/Documentation/ABI/testing/evm b/Documentation/ABI/testing/evm
index 2243b72e4110..553fd8a33e56 100644
--- a/Documentation/ABI/testing/evm
+++ b/Documentation/ABI/testing/evm
@@ -24,7 +24,7 @@ Description:
 		1	  Enable digital signature validation
 		2	  Permit modification of EVM-protected metadata at
 			  runtime. Not supported if HMAC validation and
-			  creation is enabled.
+			  creation is enabled (deprecated).
 		31	  Disable further runtime modification of EVM policy
 		===	  ==================================================
 
@@ -47,7 +47,13 @@ Description:
 
 		will enable digital signature validation, permit
 		modification of EVM-protected metadata and
-		disable all further modification of policy
+		disable all further modification of policy. This option is now
+		deprecated in favor of::
+
+		  echo 0x80000002 ><securityfs>/evm
+
+		as the outstanding issues that prevent the usage of EVM portable
+		signatures have been solved.
 
 		Echoing a value is additive, the new value is added to the
 		existing initialization flags.
-- 
2.25.1

