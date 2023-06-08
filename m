Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D6D3727F9A
	for <lists+linux-integrity@lfdr.de>; Thu,  8 Jun 2023 14:05:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235638AbjFHMFQ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 8 Jun 2023 08:05:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235670AbjFHMFQ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 8 Jun 2023 08:05:16 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36CF71FDB
        for <linux-integrity@vger.kernel.org>; Thu,  8 Jun 2023 05:05:11 -0700 (PDT)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 358BeBeC031269;
        Thu, 8 Jun 2023 12:04:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=H+37Lslye+qIw9vFX9ZvVCKFhtWRKZLlcWZxRGx/5SE=;
 b=Eh+vUi5g5eELGlG/ObbIysChyXatjY5uMK9ui3bPqT9NWBCrzBCjUjGvTn9V7CAxMCaW
 Lk35Y6ueRcQnvu9mu0oWa3GM4lr0yRWB9iYsWzYnx9xlPO5iV3+AamNQ96V0gyCRoNa+
 2E4LcKfhpoGPLAdNz+JfdiyekQsfAkP2/p8ydiD1fSyLTN/c9slxVN31TZRhUKb2CGB0
 aeKYFUmedG5/LSy7vjq0b7tJw8lT5cyirvz1ljEE6dC5Y4tmHI51OxI4dX7J1fc57NSL
 j7EhVPYlGAlS7W68Gsq0VbHvEWQEubPwNaW2fUYPmQmUDTNdYgIjRzLn8e0frMqlew0e yA== 
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3r3dks9qfr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 08 Jun 2023 12:04:56 +0000
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 358BdIn7021066;
        Thu, 8 Jun 2023 12:04:54 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
        by ppma03fra.de.ibm.com (PPS) with ESMTPS id 3r2a790vay-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 08 Jun 2023 12:04:54 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
        by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 358C4oew12845800
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 8 Jun 2023 12:04:51 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D1E652004F;
        Thu,  8 Jun 2023 12:04:50 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7B68220043;
        Thu,  8 Jun 2023 12:04:48 +0000 (GMT)
Received: from li-4b5937cc-25c4-11b2-a85c-cea3a66903e4.ibm.com (unknown [9.61.101.222])
        by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Thu,  8 Jun 2023 12:04:48 +0000 (GMT)
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
        Nayna Jain <nayna@linux.ibm.com>, stable@vger.kenrnel.org
Subject: [PATCH v2] security/integrity: fix pointer to ESL data and its size on pseries
Date:   Thu,  8 Jun 2023 08:04:44 -0400
Message-Id: <20230608120444.382527-1-nayna@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: DZl_F4kyxxumbfpRS0zEWpVOywuDRALL
X-Proofpoint-GUID: DZl_F4kyxxumbfpRS0zEWpVOywuDRALL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-08_08,2023-06-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 clxscore=1011 phishscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 priorityscore=1501 spamscore=0 suspectscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306080104
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
Cc: stable@vger.kenrnel.org # v6.3
Signed-off-by: Nayna Jain <nayna@linux.ibm.com>
---
Changelog:
v2: Fixed feedback from Jarkko
      * added CC to stable
      * moved *data declaration to same line as *db,*dbx
    Renamed extract_data() macro to extract_esl() for clarity
 .../integrity/platform_certs/load_powerpc.c   | 40 ++++++++++++-------
 1 file changed, 26 insertions(+), 14 deletions(-)

diff --git a/security/integrity/platform_certs/load_powerpc.c b/security/integrity/platform_certs/load_powerpc.c
index b9de70b90826..170789dc63d2 100644
--- a/security/integrity/platform_certs/load_powerpc.c
+++ b/security/integrity/platform_certs/load_powerpc.c
@@ -15,6 +15,9 @@
 #include "keyring_handler.h"
 #include "../integrity.h"
 
+#define extract_esl(db, data, size, offset)	\
+	do { db = data + offset; size = size - offset; } while (0)
+
 /*
  * Get a certificate list blob from the named secure variable.
  *
@@ -55,8 +58,9 @@ static __init void *get_cert_list(u8 *key, unsigned long keylen, u64 *size)
  */
 static int __init load_powerpc_certs(void)
 {
-	void *db = NULL, *dbx = NULL;
-	u64 dbsize = 0, dbxsize = 0;
+	void *db = NULL, *dbx = NULL, *data = NULL;
+	u64 dsize = 0;
+	u64 offset = 0;
 	int rc = 0;
 	ssize_t len;
 	char buf[32];
@@ -74,38 +78,46 @@ static int __init load_powerpc_certs(void)
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
+		extract_esl(db, data, dsize, offset);
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
+		extract_esl(dbx, data, dsize, offset);
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

