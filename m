Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B40FE5B8A3B
	for <lists+linux-integrity@lfdr.de>; Wed, 14 Sep 2022 16:22:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229564AbiINOWn (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 14 Sep 2022 10:22:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbiINOWn (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 14 Sep 2022 10:22:43 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C41F4662E
        for <linux-integrity@vger.kernel.org>; Wed, 14 Sep 2022 07:22:42 -0700 (PDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28EDfYpl023820;
        Wed, 14 Sep 2022 14:22:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=5GFYGTnCZR9y51tprTuyHqbyaph8VTzYqA8AQfuX6Tw=;
 b=Zi6AVD8iD90y4fzsxlLfi/7vn2rzPYbmQXPT0vmpo0mcOdVAnK5OvhZXlT+R4y2g52Jy
 DORNlgC/1lloAOIdaj8VJ3caz3uM4T+e/zwduB8FHuJ/ETRLEzNHMwoj5gH3hv8qWjEX
 HcFLmJlfWJFXd52cbk/zuA8FfbxcLvGK/CVy4c2IXJg/eFHXtp8LmyRfj+27zf0nGORc
 oqaTxzPshHSa97v5W7otcvQ6RX65iuhLiBvaOTTwkLGvIANBDSd0a18vP2kknvL3Heo8
 rJFmCxjUaS/7/EqQzfzlWvupFu+7t98pceQui8SxoZA4eYtJrPGCoQP02PGJgzNA+SXw /A== 
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3jkg2e1nxs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Sep 2022 14:22:39 +0000
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 28EEL5rR008617;
        Wed, 14 Sep 2022 14:22:36 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma05fra.de.ibm.com with ESMTP id 3jjy9a0u1q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Sep 2022 14:22:36 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 28EEMXch37224942
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Sep 2022 14:22:33 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 136CB5204E;
        Wed, 14 Sep 2022 14:22:33 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com.com (unknown [9.65.200.242])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 701465204F;
        Wed, 14 Sep 2022 14:22:32 +0000 (GMT)
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.ibm.com>, Petr Vorel <pvorel@suse.cz>,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH ima-evm-utils 4/4] Fix tpm2_pcr_supported() output messages
Date:   Wed, 14 Sep 2022 10:22:25 -0400
Message-Id: <20220914142225.1381077-5-zohar@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220914142225.1381077-1-zohar@linux.ibm.com>
References: <20220914142225.1381077-1-zohar@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 7z00Nnxu6Mb-5n0T9GP6jFVJIiMJg3hC
X-Proofpoint-ORIG-GUID: 7z00Nnxu6Mb-5n0T9GP6jFVJIiMJg3hC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-14_06,2022-09-14_04,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 mlxlogscore=935 impostorscore=0 lowpriorityscore=0 spamscore=0 bulkscore=0
 clxscore=1015 adultscore=0 priorityscore=1501 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2208220000 definitions=main-2209140068
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Remove unnecessary path check in pcr_ibmtss.c and update the syntax
in the other.

Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
---
 src/pcr_ibmtss.c     | 12 +-----------
 src/pcr_tsspcrread.c |  4 ++--
 2 files changed, 3 insertions(+), 13 deletions(-)

diff --git a/src/pcr_ibmtss.c b/src/pcr_ibmtss.c
index b8700ddd5da8..6b38d280e80c 100644
--- a/src/pcr_ibmtss.c
+++ b/src/pcr_ibmtss.c
@@ -20,21 +20,11 @@
 #undef MAX_DIGEST_SIZE	/* imaevm uses a different value than the TSS */
 #include <ibmtss/tss.h>
 
-#define CMD "tsspcrread"
-
-static char path[PATH_MAX];
-
 int tpm2_pcr_supported(void)
 {
 	if (imaevm_params.verbose > LOG_INFO)
-		log_info("Using %s to read PCRs.\n", CMD);
-
-	if (get_cmd_path(CMD, path, sizeof(path))) {
-		log_debug("Couldn't find '%s' in $PATH\n", CMD);
-		return 0;
-	}
+		log_info("Using ibmtss to read PCRs.\n");
 
-	log_debug("Found '%s' in $PATH\n", CMD);
 	return 1;
 }
 
diff --git a/src/pcr_tsspcrread.c b/src/pcr_tsspcrread.c
index 95048f8a5469..39ff8f7fc14d 100644
--- a/src/pcr_tsspcrread.c
+++ b/src/pcr_tsspcrread.c
@@ -60,11 +60,11 @@ int tpm2_pcr_supported(void)
 		log_info("Using %s to read PCRs.\n", CMD);
 
 	if (get_cmd_path(CMD, path, sizeof(path))) {
-		log_debug("Couldn't find '%s' in $PATH\n", CMD);
+		log_info("Couldn't find '%s' in %s\n", CMD, path);
 		return 0;
 	}
 
-	log_debug("Found '%s' in $PATH\n", CMD);
+	log_debug("Found '%s' in %s\n", CMD, path);
 	return 1;
 }
 
-- 
2.31.1

