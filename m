Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F51D724A27
	for <lists+linux-integrity@lfdr.de>; Tue,  6 Jun 2023 19:27:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238346AbjFFR1T (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 6 Jun 2023 13:27:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237638AbjFFR1T (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 6 Jun 2023 13:27:19 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD12EE8
        for <linux-integrity@vger.kernel.org>; Tue,  6 Jun 2023 10:27:17 -0700 (PDT)
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 356HKt8v012806;
        Tue, 6 Jun 2023 17:27:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=tf+9H6+wPbrddSLARBiqpXfgZZ5fw/WGYj1RVHwN3OU=;
 b=PgpTTLdlKSOKUA4K69+ifvEHvYlLQOPnqbxrQej+SYajEhurq4eaZ/kufHdd5dMA60mN
 1snFaO9JOVT9KdUaKWfVxa+Yd5Ell7k1OtO+g+Mv4Z1N0DhuopHKrydRa2+F41g3mJ6Y
 OmrtS5vAiJIOFzLguJoiMRwQ4Xe1Z6lRC4Wq1uJrRMMjkw3smmgDiSCxUv+4Bi5V05MV
 rxEq+cYjFX4fNdVbcBx7fj89Tb+IH4ImMrqoRvD+aGwi8qK63TN5stXhcluC8vdhplpz
 gXPNpAbx1FRl4hOLd+6XUkm/qb+eYSrJL2D7reavia+CaarDz2VpMqwXY+FYaBdEOXS8 pQ== 
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3r294d03mg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 06 Jun 2023 17:27:04 +0000
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3567qeJ2014490;
        Tue, 6 Jun 2023 17:27:02 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
        by ppma01fra.de.ibm.com (PPS) with ESMTPS id 3qyxahhph8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 06 Jun 2023 17:27:01 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
        by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 356HQwMo13370062
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 6 Jun 2023 17:26:58 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 659DA20049;
        Tue,  6 Jun 2023 17:26:58 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DA2B620040;
        Tue,  6 Jun 2023 17:26:55 +0000 (GMT)
Received: from li-4b5937cc-25c4-11b2-a85c-cea3a66903e4.ibm.com (unknown [9.61.101.222])
        by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Tue,  6 Jun 2023 17:26:55 +0000 (GMT)
From:   Nayna Jain <nayna@linux.ibm.com>
To:     linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-integrity <linux-integrity@vger.kernel.org>
Cc:     Andrew Donnellan <ajd@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Russell Currey <ruscur@russell.cc>,
        Nageswara R Sastry <rnsastry@linux.ibm.com>,
        George Wilson <gcwilson@linux.ibm.com>,
        Nayna Jain <nayna@linux.ibm.com>
Subject: [PATCH] security/integrity: fix pointer to ESL data and its size on pseries
Date:   Tue,  6 Jun 2023 13:26:52 -0400
Message-Id: <20230606172652.198227-1-nayna@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: mh9IIeRDXFo6BJlckmIqBjcY1ruqOxO6
X-Proofpoint-GUID: mh9IIeRDXFo6BJlckmIqBjcY1ruqOxO6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-06_12,2023-06-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 clxscore=1011
 priorityscore=1501 mlxscore=0 suspectscore=0 bulkscore=0 mlxlogscore=999
 malwarescore=0 spamscore=0 phishscore=0 lowpriorityscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2306060147
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On PowerVM guest, variable data is prefixed with 8 bytes of timestamp.
Extract ESL by stripping off the timestamp before passing to ESL parser.

Fixes: 4b3e71e9a34c ("integrity/powerpc: Support loading keys from PLPKS")
Signed-off-by: Nayna Jain <nayna@linux.ibm.com>
---
 .../integrity/platform_certs/load_powerpc.c   | 39 ++++++++++++-------
 1 file changed, 26 insertions(+), 13 deletions(-)

diff --git a/security/integrity/platform_certs/load_powerpc.c b/security/integrity/platform_certs/load_powerpc.c
index b9de70b90826..57768cbf1fd3 100644
--- a/security/integrity/platform_certs/load_powerpc.c
+++ b/security/integrity/platform_certs/load_powerpc.c
@@ -15,6 +15,9 @@
 #include "keyring_handler.h"
 #include "../integrity.h"
 
+#define extract_data(db, data, size, offset)	\
+	do { db = data + offset; size = size - offset; } while (0)
+
 /*
  * Get a certificate list blob from the named secure variable.
  *
@@ -55,8 +58,10 @@ static __init void *get_cert_list(u8 *key, unsigned long keylen, u64 *size)
  */
 static int __init load_powerpc_certs(void)
 {
+	void *data = NULL;
+	u64 dsize = 0;
+	u64 offset = 0;
 	void *db = NULL, *dbx = NULL;
-	u64 dbsize = 0, dbxsize = 0;
 	int rc = 0;
 	ssize_t len;
 	char buf[32];
@@ -74,38 +79,46 @@ static int __init load_powerpc_certs(void)
 		return -ENODEV;
 	}
 
+	if (strcmp("ibm,plpks-sb-v1", buf) == 0)
+		/* PLPKS authenticated variables ESL data is prefixed with 8 bytes of timestamp */
+		offset = 8;
+
 	/*
 	 * Get db, and dbx. They might not exist, so it isn't an error if we
 	 * can't get them.
 	 */
-	db = get_cert_list("db", 3, &dbsize);
-	if (!db) {
+	data = get_cert_list("db", 3, &dsize);
+	if (!data) {
 		pr_info("Couldn't get db list from firmware\n");
-	} else if (IS_ERR(db)) {
-		rc = PTR_ERR(db);
+	} else if (IS_ERR(data)) {
+		rc = PTR_ERR(data);
 		pr_err("Error reading db from firmware: %d\n", rc);
 		return rc;
 	} else {
-		rc = parse_efi_signature_list("powerpc:db", db, dbsize,
+		extract_data(db, data, dsize, offset);
+
+		rc = parse_efi_signature_list("powerpc:db", db, dsize,
 					      get_handler_for_db);
 		if (rc)
 			pr_err("Couldn't parse db signatures: %d\n", rc);
-		kfree(db);
+		kfree(data);
 	}
 
-	dbx = get_cert_list("dbx", 4,  &dbxsize);
-	if (!dbx) {
+	data = get_cert_list("dbx", 4,  &dsize);
+	if (!data) {
 		pr_info("Couldn't get dbx list from firmware\n");
-	} else if (IS_ERR(dbx)) {
-		rc = PTR_ERR(dbx);
+	} else if (IS_ERR(data)) {
+		rc = PTR_ERR(data);
 		pr_err("Error reading dbx from firmware: %d\n", rc);
 		return rc;
 	} else {
-		rc = parse_efi_signature_list("powerpc:dbx", dbx, dbxsize,
+		extract_data(dbx, data, dsize, offset);
+
+		rc = parse_efi_signature_list("powerpc:dbx", dbx, dsize,
 					      get_handler_for_dbx);
 		if (rc)
 			pr_err("Couldn't parse dbx signatures: %d\n", rc);
-		kfree(dbx);
+		kfree(data);
 	}
 
 	return rc;
-- 
2.31.1

