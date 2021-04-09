Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C70B359DAF
	for <lists+linux-integrity@lfdr.de>; Fri,  9 Apr 2021 13:45:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233533AbhDILpL (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 9 Apr 2021 07:45:11 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:2825 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231611AbhDILpK (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 9 Apr 2021 07:45:10 -0400
Received: from fraeml714-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4FGwzX2wvKz682sM;
        Fri,  9 Apr 2021 19:35:20 +0800 (CST)
Received: from fraphisprd00473.huawei.com (7.182.8.141) by
 fraeml714-chm.china.huawei.com (10.206.15.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Fri, 9 Apr 2021 13:44:56 +0200
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     <zohar@linux.ibm.com>
CC:     <linux-integrity@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Roberto Sassu <roberto.sassu@huawei.com>
Subject: [PATCH 7/7] evm: Extend evm= with allow_metadata_writes and complete values
Date:   Fri, 9 Apr 2021 13:43:13 +0200
Message-ID: <20210409114313.4073-8-roberto.sassu@huawei.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210409114313.4073-1-roberto.sassu@huawei.com>
References: <20210409114313.4073-1-roberto.sassu@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [7.182.8.141]
X-ClientProxiedBy: lhreml754-chm.china.huawei.com (10.201.108.204) To
 fraeml714-chm.china.huawei.com (10.206.15.33)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

With the patch 'evm: Ignore INTEGRITY_NOLABEL/INTEGRITY_NOXATTRS if
conditions are safe', the INTEGRITY_NOLABEL and INTEGRITY_NOXATTRS errors
can be ignored by setting the EVM_SETUP_COMPLETE flag. Also, the same
errors can be avoided by disabling EVM verification completely with the
EVM_ALLOW_METADATA_WRITES flag.

This patch makes it possible to set these initialization flags directly in
the kernel command line, so that no additional setup is required from the
initial ram disk. The new allowed values for evm= are:

allow_metadata_writes: permit metadata modificatons;
complete: don't allow further changes of the EVM mode.

While EVM_ALLOW_METADATA_WRITES will be applied directly by the kernel at
setup time, EVM_SETUP_COMPLETE will be applied only if a public key is
loaded by evm_load_x509().

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 Documentation/admin-guide/kernel-parameters.txt |  8 +++++---
 security/integrity/evm/evm_main.c               | 16 ++++++++++++----
 2 files changed, 17 insertions(+), 7 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index f61ce44c5d8e..eaf08095df43 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1339,9 +1339,11 @@
 			has equivalent usage. See its documentation for details.
 
 	evm=		[EVM]
-			Format: { "fix" }
-			Permit 'security.evm' to be updated regardless of
-			current integrity status.
+			Format: { "fix" | "allow_metadata_writes" | "complete" }
+			fix: permit 'security.evm' to be updated regardless of
+			current integrity status;
+			allow_metadata_writes: permit metadata modificatons;
+			complete: don't allow further changes of the EVM mode.
 
 	evm_hash=	[EVM] Hash algorithm used to calculate the HMAC.
 			Format: { md5 | sha1 | rmd160 | sha256 | sha384
diff --git a/security/integrity/evm/evm_main.c b/security/integrity/evm/evm_main.c
index cb3754e0cc60..84a9b7a69b1f 100644
--- a/security/integrity/evm/evm_main.c
+++ b/security/integrity/evm/evm_main.c
@@ -56,17 +56,22 @@ static struct xattr_list evm_config_default_xattrnames[] = {
 
 LIST_HEAD(evm_config_xattrnames);
 
-static int evm_fixmode;
-static int __init evm_set_fixmode(char *str)
+static int evm_fixmode __ro_after_init;
+static int evm_complete __ro_after_init;
+static int __init evm_set_param(char *str)
 {
 	if (strncmp(str, "fix", 3) == 0)
 		evm_fixmode = 1;
+	else if (strncmp(str, "allow_metadata_writes", 21) == 0)
+		evm_initialized |= EVM_ALLOW_METADATA_WRITES;
+	else if (strncmp(str, "complete", 8) == 0)
+		evm_complete = 1;
 	else
 		pr_err("invalid \"%s\" mode", str);
 
 	return 0;
 }
-__setup("evm=", evm_set_fixmode);
+__setup("evm=", evm_set_param);
 
 static void __init evm_init_config(void)
 {
@@ -737,8 +742,11 @@ void __init evm_load_x509(void)
 	int rc;
 
 	rc = integrity_load_x509(INTEGRITY_KEYRING_EVM, CONFIG_EVM_X509_PATH);
-	if (!rc)
+	if (!rc) {
 		evm_initialized |= EVM_INIT_X509;
+		if (evm_complete)
+			evm_initialized |= EVM_SETUP_COMPLETE;
+	}
 }
 #endif
 
-- 
2.26.2

