Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6937A39F7D9
	for <lists+linux-integrity@lfdr.de>; Tue,  8 Jun 2021 15:30:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232951AbhFHNcJ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 8 Jun 2021 09:32:09 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:54592 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S232867AbhFHNcJ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 8 Jun 2021 09:32:09 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 158DK0HM140298;
        Tue, 8 Jun 2021 09:30:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=IP3duN864xa1cVoB78QPdLcAYKL05Ae17t2palp2cYE=;
 b=Iz4iCICvmkOFL22U+frxDU3uGViVHUB4rVtph14fq9WdkPKY3GmOsjm7WazfNzzhJrMu
 dE+Y1sXPWHjWwn2ftihQ2HWLyj8KF43KQijYA9N2GLIf/8eW9y3r070Q0og0r4QpVjdA
 xED8+PkOKDMOwVbdvMP3LzUuME9v+tuVNf+3ObXS1OJp4fk+PrGoExq52DdiT4sByGfO
 sehz7m9WbVT7F21BDJSelGUKB1NkJD3AIVB3H/mffvd4FoxUnYe3a9lSxlNO53yksFiH
 OsxY5myNt3toxKHnGDFGsW/7ayBQqvOC7BytzLiyfNvVI9nDPGkM3qb1ON1Bs7AICMIR JA== 
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0b-001b2d01.pphosted.com with ESMTP id 39251dg4mk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Jun 2021 09:30:11 -0400
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 158DS5v6020870;
        Tue, 8 Jun 2021 13:30:09 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma04fra.de.ibm.com with ESMTP id 3900w88v1h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Jun 2021 13:30:09 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 158DU6Xb10223980
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 8 Jun 2021 13:30:06 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6A637A4068;
        Tue,  8 Jun 2021 13:30:06 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E3421A406D;
        Tue,  8 Jun 2021 13:30:04 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com.com (unknown [9.160.43.202])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  8 Jun 2021 13:30:04 +0000 (GMT)
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     linux-security-module@vger.kernel.org,
        Stefan Berger <stefanb@linux.ibm.com>,
        Russell Coker <russell@coker.com.au>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Subject: [PATCH 2/2] evm: output EVM digest calculation info
Date:   Tue,  8 Jun 2021 09:29:50 -0400
Message-Id: <20210608132950.424148-3-zohar@linux.ibm.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210608132950.424148-1-zohar@linux.ibm.com>
References: <20210608132950.424148-1-zohar@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: ojJqpzKNMbwYts6Iv9nrKLaKmCfgOhXJ
X-Proofpoint-GUID: ojJqpzKNMbwYts6Iv9nrKLaKmCfgOhXJ
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-06-08_09:2021-06-04,2021-06-08 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 phishscore=0
 lowpriorityscore=0 mlxlogscore=999 mlxscore=0 suspectscore=0 spamscore=0
 priorityscore=1501 bulkscore=0 malwarescore=0 clxscore=1015
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106080086
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Output the data used in calculating the EVM digest and the resulting
digest as ascii hexadecimal strings.

Suggested-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com> (CONFIG_DYNAMIC_DEBUG)
Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
---
Changelog:
- Use pr_debug *phN format
- Define dump_security_xattr() for larger binary data
- Based on CONFIG_DYNAMIC_DEBUG

 security/integrity/evm/evm_crypto.c | 42 +++++++++++++++++++++++++++++
 security/integrity/evm/evm_main.c   |  4 +++
 2 files changed, 46 insertions(+)

diff --git a/security/integrity/evm/evm_crypto.c b/security/integrity/evm/evm_crypto.c
index 1628e2ca9862..900cf8a157b6 100644
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
@@ -175,6 +177,29 @@ static void hmac_add_misc(struct shash_desc *desc, struct inode *inode,
 	    type != EVM_XATTR_PORTABLE_DIGSIG)
 		crypto_shash_update(desc, (u8 *)&inode->i_sb->s_uuid, UUID_SIZE);
 	crypto_shash_final(desc, digest);
+
+	pr_debug("hmac_misc: (%lu) [%*phN]\n", sizeof(struct h_misc),
+		 (int) sizeof(struct h_misc), &hmac_misc);
+}
+
+/*
+ * Dump large security xattr values as a continuous ascii hexademical string.
+ * (pr_debug is limited to 64 bytes.)
+ */
+static void dump_security_xattr(const char *prefix, const void *src, size_t count)
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
+	pr_debug("%s: (%lu) %.*s\n", prefix, count, (int) count * 2, asciihex);
+	kfree(asciihex);
+#endif
 }
 
 /*
@@ -230,6 +255,16 @@ static int evm_calc_hmac_or_hash(struct dentry *dentry,
 					     req_xattr_value_len);
 			if (is_ima)
 				ima_present = true;
+
+			if (req_xattr_value_len < 64)
+				pr_debug("%s: (%lu) [%*phN]\n", req_xattr_name,
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
@@ -246,6 +281,13 @@ static int evm_calc_hmac_or_hash(struct dentry *dentry,
 		crypto_shash_update(desc, (const u8 *)xattr_value, xattr_size);
 		if (is_ima)
 			ima_present = true;
+
+		if (xattr_size < 64)
+			pr_debug("%s: (%lu) [%*phN]", xattr->name, xattr_size,
+				 (int)xattr_size, xattr_value);
+		else
+			dump_security_xattr(xattr->name, xattr_value,
+					    xattr_size);
 	}
 	hmac_add_misc(desc, inode, type, data->digest);
 
diff --git a/security/integrity/evm/evm_main.c b/security/integrity/evm/evm_main.c
index 2c226e634ae9..059ac17a0041 100644
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

