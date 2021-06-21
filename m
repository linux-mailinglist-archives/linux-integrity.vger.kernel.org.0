Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 493803AE139
	for <lists+linux-integrity@lfdr.de>; Mon, 21 Jun 2021 03:03:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229905AbhFUBGG (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 20 Jun 2021 21:06:06 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:59552 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229872AbhFUBGG (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 20 Jun 2021 21:06:06 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15L0Y40N162549;
        Sun, 20 Jun 2021 21:03:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=A06ITPhiDkryY96IgAHJbnxPNgUsULHu/KQlJkXt7AM=;
 b=PNFj6to1Iid23+JnPwc4gKN/DoI/ONZxn0bVN68qjlsmR+rqlmx+xWXJs0f9Q4rUOASG
 hD60q+ciewSIJPyMTlztjMXalVglwEe8Up/0n9rVMUWZj3fS0PsiH3ax/ZAt4CXJovlL
 5ys6Ihg9uGDUvy6tyB0lv3WGMNx7gnL71+73L0nHK4VyfJL0IWDevxko9o6eFRN4xwXd
 KHRGzya0UvXiwxOk/eOepliM2awA6YbB1RDI1zfYUlV+x9iTdx8w1rwDbtGu8gEa0CKO
 l3l1xgc2sSMuiEjCFI1ivxxaG2T8Dv5pBAqGItHcVY7nqVBbyDI8uQZmwS9eYw1yfBDf ug== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 39aer2a7ce-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 20 Jun 2021 21:03:45 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 15L0wtM4000532;
        Mon, 21 Jun 2021 01:03:43 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma06ams.nl.ibm.com with ESMTP id 3997uh8kbd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 21 Jun 2021 01:03:42 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 15L13dwV28705102
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 21 Jun 2021 01:03:39 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1AA0452051;
        Mon, 21 Jun 2021 01:03:39 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com.com (unknown [9.160.17.97])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 812F65204F;
        Mon, 21 Jun 2021 01:03:37 +0000 (GMT)
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        Stefan Berger <stefanb@linux.ibm.com>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH v2] evm: output EVM digest calculation info
Date:   Sun, 20 Jun 2021 21:03:27 -0400
Message-Id: <20210621010327.467523-1-zohar@linux.ibm.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Uu4mICs5-xTGD17OYN2VR8Ec6JP-nUWg
X-Proofpoint-ORIG-GUID: Uu4mICs5-xTGD17OYN2VR8Ec6JP-nUWg
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-06-20_14:2021-06-20,2021-06-20 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 mlxlogscore=999 suspectscore=0 clxscore=1015 priorityscore=1501
 impostorscore=0 mlxscore=0 lowpriorityscore=0 spamscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106210001
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Output the data used in calculating the EVM digest and the resulting
digest as ascii hexadecimal strings.

Suggested-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com> (CONFIG_DYNAMIC_DEBUG)
Reviewed-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Reported-by: kernel test robot <lkp@intel.com> (Use %zu for size_t)
Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
---
Changelog v1:
- Use %zu for size_t

 security/integrity/evm/evm_crypto.c | 43 +++++++++++++++++++++++++++++
 security/integrity/evm/evm_main.c   |  4 +++
 2 files changed, 47 insertions(+)

diff --git a/security/integrity/evm/evm_crypto.c b/security/integrity/evm/evm_crypto.c
index 1628e2ca9862..bebe160c57b9 100644
--- a/security/integrity/evm/evm_crypto.c
+++ b/security/integrity/evm/evm_crypto.c
@@ -10,6 +10,8 @@
  *	 Using root's kernel master key (kmk), calculate the HMAC
  */
 
+#define pr_fmt(fmt) "EVM: "fmt
+
 #include <linux/export.h>
 #include <linux/crypto.h>
 #include <linux/xattr.h>
@@ -175,6 +177,30 @@ static void hmac_add_misc(struct shash_desc *desc, struct inode *inode,
 	    type != EVM_XATTR_PORTABLE_DIGSIG)
 		crypto_shash_update(desc, (u8 *)&inode->i_sb->s_uuid, UUID_SIZE);
 	crypto_shash_final(desc, digest);
+
+	pr_debug("hmac_misc: (%zu) [%*phN]\n", sizeof(struct h_misc),
+		 (int)sizeof(struct h_misc), &hmac_misc);
+}
+
+/*
+ * Dump large security xattr values as a continuous ascii hexademical string.
+ * (pr_debug is limited to 64 bytes.)
+ */
+static void dump_security_xattr(const char *prefix, const void *src,
+				size_t count)
+{
+#if defined(DEBUG) || defined(CONFIG_DYNAMIC_DEBUG)
+	char *asciihex, *p;
+
+	p = asciihex = kmalloc(count * 2 + 1, GFP_KERNEL);
+	if (!asciihex)
+		return;
+
+	p = bin2hex(p, src, count);
+	*p = 0;
+	pr_debug("%s: (%zu) %.*s\n", prefix, count, (int)count * 2, asciihex);
+	kfree(asciihex);
+#endif
 }
 
 /*
@@ -230,6 +256,16 @@ static int evm_calc_hmac_or_hash(struct dentry *dentry,
 					     req_xattr_value_len);
 			if (is_ima)
 				ima_present = true;
+
+			if (req_xattr_value_len < 64)
+				pr_debug("%s: (%zu) [%*phN]\n", req_xattr_name,
+					 req_xattr_value_len,
+					 (int)req_xattr_value_len,
+					 req_xattr_value);
+			else
+				dump_security_xattr(req_xattr_name,
+						    req_xattr_value,
+						    req_xattr_value_len);
 			continue;
 		}
 		size = vfs_getxattr_alloc(&init_user_ns, dentry, xattr->name,
@@ -246,6 +282,13 @@ static int evm_calc_hmac_or_hash(struct dentry *dentry,
 		crypto_shash_update(desc, (const u8 *)xattr_value, xattr_size);
 		if (is_ima)
 			ima_present = true;
+
+		if (xattr_size < 64)
+			pr_debug("%s: (%zu) [%*phN]", xattr->name, xattr_size,
+				 (int)xattr_size, xattr_value);
+		else
+			dump_security_xattr(xattr->name, xattr_value,
+					    xattr_size);
 	}
 	hmac_add_misc(desc, inode, type, data->digest);
 
diff --git a/security/integrity/evm/evm_main.c b/security/integrity/evm/evm_main.c
index 977208aecd06..1c8435dfabee 100644
--- a/security/integrity/evm/evm_main.c
+++ b/security/integrity/evm/evm_main.c
@@ -11,6 +11,8 @@
  *	evm_inode_removexattr, and evm_verifyxattr
  */
 
+#define pr_fmt(fmt) "EVM: "fmt
+
 #include <linux/init.h>
 #include <linux/crypto.h>
 #include <linux/audit.h>
@@ -272,6 +274,8 @@ static enum integrity_status evm_verify_hmac(struct dentry *dentry,
 		else
 			evm_status = INTEGRITY_FAIL;
 	}
+	pr_debug("digest: (%d) [%*phN]\n", digest.hdr.length, digest.hdr.length,
+		  digest.digest);
 out:
 	if (iint)
 		iint->evm_status = evm_status;
-- 
2.27.0

