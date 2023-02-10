Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C99806919B6
	for <lists+linux-integrity@lfdr.de>; Fri, 10 Feb 2023 09:06:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231675AbjBJIGB (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 10 Feb 2023 03:06:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231601AbjBJIFE (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 10 Feb 2023 03:05:04 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 729C08184F;
        Fri, 10 Feb 2023 00:04:37 -0800 (PST)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31A7hHQB006819;
        Fri, 10 Feb 2023 08:04:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=WMu/Zb3Iphqdf5G/sJin/L6+0Yox6l6Bi4TmsUaD9TQ=;
 b=UCmJaO45nvIV0W7EGfHgNcSql7sDe54v/Kae5Fgm3Us/NNB4pzFW3hr8v/55lVZcwzBT
 ROUGF8PG0sdHepscyGv41DUv87aEH7zdbb8mtA7FmjruKaHbkpHwYp/GLZ7qq3Lh4gP5
 VVpSGecC3Pbz1Ps7Qj+yCYN5ppeGbR/Gj45ULJTWCHpWQI/7kPNw29AIrx5x2YMIKqr/
 secn9BhgN/0RdDIa+m3yRnSXIjJxgGhtbyH1WZNs8zSAd0E1mFnWrfj1TA9yMWyTCIMg
 Z82n0rRraEXdmWSGlRY05aBxRVhqsXidzwokW4KpJVUGNriIGmz7bZxDQ+k6j7Dl5DL4 XQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nnhsjrhqv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Feb 2023 08:04:28 +0000
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 31A7lVKx022488;
        Fri, 10 Feb 2023 08:04:27 GMT
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nnhsjrhp4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Feb 2023 08:04:27 +0000
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 319J2h8U016244;
        Fri, 10 Feb 2023 08:04:25 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
        by ppma04fra.de.ibm.com (PPS) with ESMTPS id 3nhf06w3vw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Feb 2023 08:04:25 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
        by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 31A84M9G31523290
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Feb 2023 08:04:22 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AF03820040;
        Fri, 10 Feb 2023 08:04:22 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2BFCF2004B;
        Fri, 10 Feb 2023 08:04:22 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
        by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Fri, 10 Feb 2023 08:04:22 +0000 (GMT)
Received: from jarvis-ozlabs-ibm-com.ozlabs.ibm.com (haven.au.ibm.com [9.192.254.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.au.ibm.com (Postfix) with ESMTPSA id 15538609C2;
        Fri, 10 Feb 2023 19:04:16 +1100 (AEDT)
From:   Andrew Donnellan <ajd@linux.ibm.com>
To:     linuxppc-dev@lists.ozlabs.org, linux-integrity@vger.kernel.org
Cc:     ruscur@russell.cc, bgray@linux.ibm.com, nayna@linux.ibm.com,
        gcwilson@linux.ibm.com, gjoyce@linux.ibm.com, brking@linux.ibm.com,
        stefanb@linux.ibm.com, sudhakar@linux.ibm.com,
        erichte@linux.ibm.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, zohar@linux.ibm.com, joel@jms.id.au,
        npiggin@gmail.com
Subject: [PATCH v6 25/26] integrity/powerpc: Improve error handling & reporting when loading certs
Date:   Fri, 10 Feb 2023 19:04:00 +1100
Message-Id: <20230210080401.345462-26-ajd@linux.ibm.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230210080401.345462-1-ajd@linux.ibm.com>
References: <20230210080401.345462-1-ajd@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Em6Yri6B21nTAEyUorthCqs09ILSRYOM
X-Proofpoint-ORIG-GUID: 7Iv5FbqKSN2l7pMBiH0sVq6x69BUo64f
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-10_03,2023-02-09_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 bulkscore=0 suspectscore=0 lowpriorityscore=0 adultscore=0
 spamscore=0 mlxscore=0 clxscore=1015 mlxlogscore=999 impostorscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302100070
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Russell Currey <ruscur@russell.cc>

A few improvements to load_powerpc.c:

 - include integrity.h for the pr_fmt()
 - move all error reporting out of get_cert_list()
 - use ERR_PTR() to better preserve error detail
 - don't use pr_err() for missing keys

Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
Signed-off-by: Russell Currey <ruscur@russell.cc>
Signed-off-by: Andrew Donnellan <ajd@linux.ibm.com>

---

v3: New patch
---
 .../integrity/platform_certs/load_powerpc.c   | 26 ++++++++++++++-----
 1 file changed, 20 insertions(+), 6 deletions(-)

diff --git a/security/integrity/platform_certs/load_powerpc.c b/security/integrity/platform_certs/load_powerpc.c
index 1e4f80a4e71c..dee51606d5f4 100644
--- a/security/integrity/platform_certs/load_powerpc.c
+++ b/security/integrity/platform_certs/load_powerpc.c
@@ -14,9 +14,15 @@
 #include <asm/secure_boot.h>
 #include <asm/secvar.h>
 #include "keyring_handler.h"
+#include "../integrity.h"
 
 /*
  * Get a certificate list blob from the named secure variable.
+ *
+ * Returns:
+ *  - a pointer to a kmalloc'd buffer containing the cert list on success
+ *  - NULL if the key does not exist
+ *  - an ERR_PTR on error
  */
 static __init void *get_cert_list(u8 *key, unsigned long keylen, u64 *size)
 {
@@ -25,19 +31,19 @@ static __init void *get_cert_list(u8 *key, unsigned long keylen, u64 *size)
 
 	rc = secvar_ops->get(key, keylen, NULL, size);
 	if (rc) {
-		pr_err("Couldn't get size: %d\n", rc);
-		return NULL;
+		if (rc == -ENOENT)
+			return NULL;
+		return ERR_PTR(rc);
 	}
 
 	db = kmalloc(*size, GFP_KERNEL);
 	if (!db)
-		return NULL;
+		return ERR_PTR(-ENOMEM);
 
 	rc = secvar_ops->get(key, keylen, db, size);
 	if (rc) {
 		kfree(db);
-		pr_err("Error reading %s var: %d\n", key, rc);
-		return NULL;
+		return ERR_PTR(rc);
 	}
 
 	return db;
@@ -69,7 +75,11 @@ static int __init load_powerpc_certs(void)
 	 */
 	db = get_cert_list("db", 3, &dbsize);
 	if (!db) {
-		pr_err("Couldn't get db list from firmware\n");
+		pr_info("Couldn't get db list from firmware\n");
+	} else if (IS_ERR(db)) {
+		rc = PTR_ERR(db);
+		pr_err("Error reading db from firmware: %d\n", rc);
+		return rc;
 	} else {
 		rc = parse_efi_signature_list("powerpc:db", db, dbsize,
 					      get_handler_for_db);
@@ -81,6 +91,10 @@ static int __init load_powerpc_certs(void)
 	dbx = get_cert_list("dbx", 4,  &dbxsize);
 	if (!dbx) {
 		pr_info("Couldn't get dbx list from firmware\n");
+	} else if (IS_ERR(dbx)) {
+		rc = PTR_ERR(dbx);
+		pr_err("Error reading dbx from firmware: %d\n", rc);
+		return rc;
 	} else {
 		rc = parse_efi_signature_list("powerpc:dbx", dbx, dbxsize,
 					      get_handler_for_dbx);
-- 
2.39.1

