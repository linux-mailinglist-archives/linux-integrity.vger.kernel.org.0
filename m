Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECDE177CBAD
	for <lists+linux-integrity@lfdr.de>; Tue, 15 Aug 2023 13:28:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235940AbjHOL2Z (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 15 Aug 2023 07:28:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236009AbjHOL2D (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 15 Aug 2023 07:28:03 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A365F7;
        Tue, 15 Aug 2023 04:28:01 -0700 (PDT)
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37FBQJZJ000900;
        Tue, 15 Aug 2023 11:27:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=M/sQfVzrC8d2QZrImPRGkYy/MfrT1TGVavwMdGxuas8=;
 b=mcHO+csMXBqj76q1Nh81mO4MHrwZuWlc2QTED1wqHfXTMprQJfuy6TuQ55OIFYxcVXEg
 fHNoPPYP1itbVdXL4xFz5nHPGOqKdsZwm+ZVsemoGK9umss6Bl0myVOde0p6lBX7nYfr
 Pby+kK1Kt+/2ie91sIWcp97GtPxebMmHOuLN0afwwPZZf/jJy7KaL7qM6sSAHkn22t6Y
 MSQfgfAUesfKaHXKPUT53SDeBz5g6UBYJg4vVpoZuvHYIc0FAhTNFerRif67SFWpvFoW
 u6UMF/rTXTdGJUSfvo5InRhLRh0ZHK3cG8i/6GCLDIfpA9dt6PkWxKa11dYzozCjxr/I jw== 
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sg82ggjcp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 15 Aug 2023 11:27:46 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
        by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 37F9KYGO003439;
        Tue, 15 Aug 2023 11:27:45 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
        by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3semdscvju-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 15 Aug 2023 11:27:45 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
        by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 37FBRgIs37290540
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Aug 2023 11:27:42 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8B81320043;
        Tue, 15 Aug 2023 11:27:42 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5795620040;
        Tue, 15 Aug 2023 11:27:40 +0000 (GMT)
Received: from li-4b5937cc-25c4-11b2-a85c-cea3a66903e4.ibm.com (unknown [9.61.3.84])
        by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Tue, 15 Aug 2023 11:27:40 +0000 (GMT)
From:   Nayna Jain <nayna@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Eric Snowberg <eric.snowberg@oracle.com>,
        Paul Moore <paul@paul-moore.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-security-module@vger.kernel.org, inux-kernel@vger.kernel.org,
        Nayna Jain <nayna@linux.ibm.com>
Subject: [PATCH v4 3/6] integrity: remove global variable from machine_keyring.c
Date:   Tue, 15 Aug 2023 07:27:19 -0400
Message-Id: <20230815112722.1591829-4-nayna@linux.ibm.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20230815112722.1591829-1-nayna@linux.ibm.com>
References: <20230815112722.1591829-1-nayna@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: BRy0kpX9ZzFlKVXxqr6gzNJWumoE-Oa7
X-Proofpoint-ORIG-GUID: BRy0kpX9ZzFlKVXxqr6gzNJWumoE-Oa7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-15_10,2023-08-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 adultscore=0
 mlxscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0 phishscore=0
 priorityscore=1501 bulkscore=0 suspectscore=0 clxscore=1015
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308150099
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

trust_mok variable is accessed within a single function locally.

Change trust_mok from global to local static variable.

Signed-off-by: Nayna Jain <nayna@linux.ibm.com>
Reviewed-and-tested-by: Mimi Zohar <zohar@linux.ibm.com>
Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
---
 security/integrity/platform_certs/machine_keyring.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/security/integrity/platform_certs/machine_keyring.c b/security/integrity/platform_certs/machine_keyring.c
index 389a6e7c9245..9482e16cb2ca 100644
--- a/security/integrity/platform_certs/machine_keyring.c
+++ b/security/integrity/platform_certs/machine_keyring.c
@@ -8,8 +8,6 @@
 #include <linux/efi.h>
 #include "../integrity.h"
 
-static bool trust_mok;
-
 static __init int machine_keyring_init(void)
 {
 	int rc;
@@ -65,9 +63,11 @@ static __init bool uefi_check_trust_mok_keys(void)
 bool __init trust_moklist(void)
 {
 	static bool initialized;
+	static bool trust_mok;
 
 	if (!initialized) {
 		initialized = true;
+		trust_mok = false;
 
 		if (uefi_check_trust_mok_keys())
 			trust_mok = true;
-- 
2.31.1

