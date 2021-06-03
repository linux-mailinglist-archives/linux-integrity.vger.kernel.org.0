Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92C6B39A45B
	for <lists+linux-integrity@lfdr.de>; Thu,  3 Jun 2021 17:18:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231822AbhFCPUj (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 3 Jun 2021 11:20:39 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:35292 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231592AbhFCPUj (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 3 Jun 2021 11:20:39 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 153F35s6169332;
        Thu, 3 Jun 2021 11:18:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=ufLlDCHXwNBJ9689K1+dSKEwc03o9UPDWzyE3HhRfok=;
 b=gpPtPYYrGK6JBJ1cF5dGOK95lkH8+M7sSHplG/w2FGlkz4xkJjBQWG5CdUdMue+v6Elw
 AUyNndOJ9Bg9DjwcxnMs1zLV27reLJfvFm/g7OGA4NDx5lr3fS5n9bOSblquOKXtB1/4
 +aqUTLd1gq5I2Rq3M8wfABc5y5ZXl7Dm0n20D1XBxkLajhZkD+COwjfJ6S9RE7RSTqzQ
 t9OIQF29RZDOSADD9WkzK3Pq5XuTnxFiUt5TTqfG8BBaC1t/Knp+owWGXc1mvKMciqUj
 8oSn3omR4AAw3itowhJG8Nz/3RxIxYLBSRb0DUXJLFeEC8u5mbvZYIjnsRg8dhhvyW+f Pg== 
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com with ESMTP id 38y01wktqy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Jun 2021 11:18:41 -0400
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 153FI0aJ032686;
        Thu, 3 Jun 2021 15:18:38 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma02fra.de.ibm.com with ESMTP id 38w413s22r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Jun 2021 15:18:38 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 153FIZOV21430532
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 3 Jun 2021 15:18:35 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BB3EDA4055;
        Thu,  3 Jun 2021 15:18:35 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 74C52A404D;
        Thu,  3 Jun 2021 15:18:34 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com.com (unknown [9.160.13.122])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu,  3 Jun 2021 15:18:34 +0000 (GMT)
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     Roberto Sassu <roberto.sassu@huawei.com>,
        Stefan Berger <stefanb@linux.ibm.com>,
        Russell Coker <russell@coker.com.au>,
        Mimi Zohar <zohar@linux.ibm.com>
Subject: [RFC PATCH 2/2] evm: output EVM digest calculation info needed for debugging
Date:   Thu,  3 Jun 2021 11:18:19 -0400
Message-Id: <20210603151819.242247-3-zohar@linux.ibm.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210603151819.242247-1-zohar@linux.ibm.com>
References: <20210603151819.242247-1-zohar@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Coi5TMlgQE-zt7ZQZ1RoGTc0Doinlg6a
X-Proofpoint-ORIG-GUID: Coi5TMlgQE-zt7ZQZ1RoGTc0Doinlg6a
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-06-03_09:2021-06-02,2021-06-03 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 mlxscore=0
 spamscore=0 adultscore=0 clxscore=1015 lowpriorityscore=0 bulkscore=0
 phishscore=0 impostorscore=0 suspectscore=0 priorityscore=1501
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106030102
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Convert and output the binary data used in calculating the EVM digest
to a hexadecimal string.

Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
---
 security/integrity/evm/evm.h        |  1 +
 security/integrity/evm/evm_crypto.c |  7 +++++++
 security/integrity/evm/evm_main.c   | 19 +++++++++++++++++++
 3 files changed, 27 insertions(+)

diff --git a/security/integrity/evm/evm.h b/security/integrity/evm/evm.h
index 0d44f41d16f8..3d2d2da8fa97 100644
--- a/security/integrity/evm/evm.h
+++ b/security/integrity/evm/evm.h
@@ -64,5 +64,6 @@ int evm_calc_hash(struct dentry *dentry, const char *req_xattr_name,
 int evm_init_hmac(struct inode *inode, const struct xattr *xattr,
 		  char *hmac_val);
 int evm_init_secfs(void);
+void evm_bin2hex_print(const char *prefix, const void *src, size_t count);
 
 #endif
diff --git a/security/integrity/evm/evm_crypto.c b/security/integrity/evm/evm_crypto.c
index 1628e2ca9862..7601aa29c6d3 100644
--- a/security/integrity/evm/evm_crypto.c
+++ b/security/integrity/evm/evm_crypto.c
@@ -175,6 +175,8 @@ static void hmac_add_misc(struct shash_desc *desc, struct inode *inode,
 	    type != EVM_XATTR_PORTABLE_DIGSIG)
 		crypto_shash_update(desc, (u8 *)&inode->i_sb->s_uuid, UUID_SIZE);
 	crypto_shash_final(desc, digest);
+
+	evm_bin2hex_print("hmac_misc", &hmac_misc, sizeof(struct h_misc));
 }
 
 /*
@@ -230,6 +232,9 @@ static int evm_calc_hmac_or_hash(struct dentry *dentry,
 					     req_xattr_value_len);
 			if (is_ima)
 				ima_present = true;
+
+			evm_bin2hex_print(req_xattr_name, req_xattr_value,
+				      req_xattr_value_len);
 			continue;
 		}
 		size = vfs_getxattr_alloc(&init_user_ns, dentry, xattr->name,
@@ -246,6 +251,8 @@ static int evm_calc_hmac_or_hash(struct dentry *dentry,
 		crypto_shash_update(desc, (const u8 *)xattr_value, xattr_size);
 		if (is_ima)
 			ima_present = true;
+
+		evm_bin2hex_print(xattr->name, xattr_value, xattr_size);
 	}
 	hmac_add_misc(desc, inode, type, data->digest);
 
diff --git a/security/integrity/evm/evm_main.c b/security/integrity/evm/evm_main.c
index 2c226e634ae9..03d963fe2e67 100644
--- a/security/integrity/evm/evm_main.c
+++ b/security/integrity/evm/evm_main.c
@@ -155,6 +155,23 @@ static int evm_find_protected_xattrs(struct dentry *dentry)
 	return count;
 }
 
+void evm_bin2hex_print(const char *prefix, const void *src, size_t count)
+{
+#ifdef DEBUG
+	char *asciihex, *p;
+
+	p = asciihex = kmalloc(count * 2 + 1, GFP_KERNEL);
+	if (!asciihex)
+		return;
+
+	p = bin2hex(p, src, count);
+	*p = 0;
+	printk("%s: (%lu) %.*s\n", prefix, count, (int) count * 2, asciihex);
+
+	kfree(asciihex);
+#endif
+}
+
 /*
  * evm_verify_hmac - calculate and compare the HMAC with the EVM xattr
  *
@@ -272,6 +289,8 @@ static enum integrity_status evm_verify_hmac(struct dentry *dentry,
 		else
 			evm_status = INTEGRITY_FAIL;
 	}
+
+	evm_bin2hex_print("evm digest", digest.digest, digest.hdr.length);
 out:
 	if (iint)
 		iint->evm_status = evm_status;
-- 
2.27.0

