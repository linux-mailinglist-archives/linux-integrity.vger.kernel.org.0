Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 010DC6713FE
	for <lists+linux-integrity@lfdr.de>; Wed, 18 Jan 2023 07:27:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229759AbjARG0s (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 18 Jan 2023 01:26:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbjARGV7 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 18 Jan 2023 01:21:59 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B3024DBDD;
        Tue, 17 Jan 2023 22:11:24 -0800 (PST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30I2BSdH022504;
        Wed, 18 Jan 2023 06:11:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=U0T7vD2M0LInYRTBrTCo83YjKh6AqmuZmIT8n37KGrk=;
 b=CIhotGLxYHn6tszisAhDIyb3XdjgNZMqy/CR9jXgadqo6XsoqP4U9chwewWA9OO+jURf
 bAjXv3CpiHCQ3Ofks6NyZXjcDTfw/ERe5SxI8wTzgqOp3BnsGQzNNuWki7oz+QBXUq1t
 sG9iqPX0QvsbfFIPZvZXb36cwpOyp6nRDcECMIHUIrLNRX4yMfnLZCveVa5te4NWfNBc
 XSGnvrEmjI/CNZggvS3BeiBNV2N5ExmwG5DEyoSlRnVFcrvBqUaBpy+pUU1MrAF9gI+r
 OTgRXPNU7pBO45aniPtT9+bfzOQPUC8ip0Jio1vLnmr6tiIrFafAuNUdu66E4K1fQVZZ Fg== 
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3n66eydfy1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 Jan 2023 06:11:15 +0000
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 30HD6s2M002145;
        Wed, 18 Jan 2023 06:11:13 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
        by ppma02fra.de.ibm.com (PPS) with ESMTPS id 3n3m16kgr4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 Jan 2023 06:11:13 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
        by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 30I6BBBk20775336
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Jan 2023 06:11:11 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0687A20040;
        Wed, 18 Jan 2023 06:11:11 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1010120043;
        Wed, 18 Jan 2023 06:11:10 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
        by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 18 Jan 2023 06:11:10 +0000 (GMT)
Received: from jarvis-ozlabs-ibm-com.ozlabs.ibm.com (haven.au.ibm.com [9.192.254.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.au.ibm.com (Postfix) with ESMTPSA id 162DE605A5;
        Wed, 18 Jan 2023 17:11:08 +1100 (AEDT)
From:   Andrew Donnellan <ajd@linux.ibm.com>
To:     linuxppc-dev@lists.ozlabs.org, linux-integrity@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, gcwilson@linux.ibm.com,
        linux-kernel@vger.kernel.org, nayna@linux.ibm.com,
        ruscur@russell.cc, zohar@linux.ibm.com, mpe@ellerman.id.au,
        gjoyce@linux.ibm.com, sudhakar@linux.ibm.com, bgray@linux.ibm.com,
        erichte@linux.ibm.com
Subject: [PATCH v3 01/24] powerpc/secvar: Use u64 in secvar_operations
Date:   Wed, 18 Jan 2023 17:10:26 +1100
Message-Id: <20230118061049.1006141-2-ajd@linux.ibm.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230118061049.1006141-1-ajd@linux.ibm.com>
References: <20230118061049.1006141-1-ajd@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 4qI0ws-PasjnYfNFG193quJzQvVlpk5O
X-Proofpoint-GUID: 4qI0ws-PasjnYfNFG193quJzQvVlpk5O
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-18_01,2023-01-17_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 priorityscore=1501 impostorscore=0 malwarescore=0 spamscore=0 mlxscore=0
 bulkscore=0 adultscore=0 mlxlogscore=999 suspectscore=0 clxscore=1015
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301180051
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Michael Ellerman <mpe@ellerman.id.au>

There's no reason for secvar_operations to use uint64_t vs the more
common kernel type u64.

The types are compatible, but they require different printk format
strings which can lead to confusion.

Change all the secvar related routines to use u64.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Reviewed-by: Russell Currey <ruscur@russell.cc>
Reviewed-by: Andrew Donnellan <ajd@linux.ibm.com>
Signed-off-by: Andrew Donnellan <ajd@linux.ibm.com>

---

v3: Include new patch
---
 arch/powerpc/include/asm/secvar.h                | 9 +++------
 arch/powerpc/kernel/secvar-sysfs.c               | 8 ++++----
 arch/powerpc/platforms/powernv/opal-secvar.c     | 9 +++------
 security/integrity/platform_certs/load_powerpc.c | 4 ++--
 4 files changed, 12 insertions(+), 18 deletions(-)

diff --git a/arch/powerpc/include/asm/secvar.h b/arch/powerpc/include/asm/secvar.h
index 4cc35b58b986..07ba36f868a7 100644
--- a/arch/powerpc/include/asm/secvar.h
+++ b/arch/powerpc/include/asm/secvar.h
@@ -14,12 +14,9 @@
 extern const struct secvar_operations *secvar_ops;
 
 struct secvar_operations {
-	int (*get)(const char *key, uint64_t key_len, u8 *data,
-		   uint64_t *data_size);
-	int (*get_next)(const char *key, uint64_t *key_len,
-			uint64_t keybufsize);
-	int (*set)(const char *key, uint64_t key_len, u8 *data,
-		   uint64_t data_size);
+	int (*get)(const char *key, u64 key_len, u8 *data, u64 *data_size);
+	int (*get_next)(const char *key, u64 *key_len, u64 keybufsize);
+	int (*set)(const char *key, u64 key_len, u8 *data, u64 data_size);
 };
 
 #ifdef CONFIG_PPC_SECURE_BOOT
diff --git a/arch/powerpc/kernel/secvar-sysfs.c b/arch/powerpc/kernel/secvar-sysfs.c
index 1ee4640a2641..001cdbcdb9d2 100644
--- a/arch/powerpc/kernel/secvar-sysfs.c
+++ b/arch/powerpc/kernel/secvar-sysfs.c
@@ -47,7 +47,7 @@ static ssize_t format_show(struct kobject *kobj, struct kobj_attribute *attr,
 static ssize_t size_show(struct kobject *kobj, struct kobj_attribute *attr,
 			 char *buf)
 {
-	uint64_t dsize;
+	u64 dsize;
 	int rc;
 
 	rc = secvar_ops->get(kobj->name, strlen(kobj->name) + 1, NULL, &dsize);
@@ -64,8 +64,8 @@ static ssize_t data_read(struct file *filep, struct kobject *kobj,
 			 struct bin_attribute *attr, char *buf, loff_t off,
 			 size_t count)
 {
-	uint64_t dsize;
 	char *data;
+	u64 dsize;
 	int rc;
 
 	rc = secvar_ops->get(kobj->name, strlen(kobj->name) + 1, NULL, &dsize);
@@ -166,9 +166,9 @@ static int update_kobj_size(void)
 
 static int secvar_sysfs_load(void)
 {
-	char *name;
-	uint64_t namesize = 0;
 	struct kobject *kobj;
+	u64 namesize = 0;
+	char *name;
 	int rc;
 
 	name = kzalloc(NAME_MAX_SIZE, GFP_KERNEL);
diff --git a/arch/powerpc/platforms/powernv/opal-secvar.c b/arch/powerpc/platforms/powernv/opal-secvar.c
index 14133e120bdd..ef89861569e0 100644
--- a/arch/powerpc/platforms/powernv/opal-secvar.c
+++ b/arch/powerpc/platforms/powernv/opal-secvar.c
@@ -54,8 +54,7 @@ static int opal_status_to_err(int rc)
 	return err;
 }
 
-static int opal_get_variable(const char *key, uint64_t ksize,
-			     u8 *data, uint64_t *dsize)
+static int opal_get_variable(const char *key, u64 ksize, u8 *data, u64 *dsize)
 {
 	int rc;
 
@@ -71,8 +70,7 @@ static int opal_get_variable(const char *key, uint64_t ksize,
 	return opal_status_to_err(rc);
 }
 
-static int opal_get_next_variable(const char *key, uint64_t *keylen,
-				  uint64_t keybufsize)
+static int opal_get_next_variable(const char *key, u64 *keylen, u64 keybufsize)
 {
 	int rc;
 
@@ -88,8 +86,7 @@ static int opal_get_next_variable(const char *key, uint64_t *keylen,
 	return opal_status_to_err(rc);
 }
 
-static int opal_set_variable(const char *key, uint64_t ksize, u8 *data,
-			     uint64_t dsize)
+static int opal_set_variable(const char *key, u64 ksize, u8 *data, u64 dsize)
 {
 	int rc;
 
diff --git a/security/integrity/platform_certs/load_powerpc.c b/security/integrity/platform_certs/load_powerpc.c
index a2900cb85357..1e4f80a4e71c 100644
--- a/security/integrity/platform_certs/load_powerpc.c
+++ b/security/integrity/platform_certs/load_powerpc.c
@@ -18,7 +18,7 @@
 /*
  * Get a certificate list blob from the named secure variable.
  */
-static __init void *get_cert_list(u8 *key, unsigned long keylen, uint64_t *size)
+static __init void *get_cert_list(u8 *key, unsigned long keylen, u64 *size)
 {
 	int rc;
 	void *db;
@@ -51,7 +51,7 @@ static __init void *get_cert_list(u8 *key, unsigned long keylen, uint64_t *size)
 static int __init load_powerpc_certs(void)
 {
 	void *db = NULL, *dbx = NULL;
-	uint64_t dbsize = 0, dbxsize = 0;
+	u64 dbsize = 0, dbxsize = 0;
 	int rc = 0;
 	struct device_node *node;
 
-- 
2.39.0

