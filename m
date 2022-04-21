Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 996C050A779
	for <lists+linux-integrity@lfdr.de>; Thu, 21 Apr 2022 19:53:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344687AbiDURzf (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 21 Apr 2022 13:55:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348173AbiDURzf (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 21 Apr 2022 13:55:35 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F88C4A905;
        Thu, 21 Apr 2022 10:52:45 -0700 (PDT)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 23LHjJex015002;
        Thu, 21 Apr 2022 17:52:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=gnHqcVl14TlQ27AwNqWXg/Smd/Wsov5xzewf3DuKwhk=;
 b=tDLXq31y5zk/K80mRbLylCJQGSkoRKXWtimRzUvEkiRRaHjtWgCFXH8lRa15f6HAk5gd
 jvY2NOqq41See7mZ38IQzc9zdp1Lwu4Fh2l4v7rdUgfEB9gUFqF4JnrJ6wwfpMkBGjB2
 tejxUAz1khE/kl29penlVthFx70XIDZw1oEjMWSuSVem+NOsEQVE24GhQBDidqu5hsLt
 4Yo6VUqUCiNtfPpHBZj4wcKDNTkl0oDZrBP0kRtsjMNdz2iwQP3pMo/0Fp+n1vmkh2Pw
 qQxn7SELHfrLf71QP6i1K8ATIRaqjJH5FeFOVFg7tK8BD1bVxAaYGa/hWr5b0Jnd87AK EA== 
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3fkbxug3sf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 21 Apr 2022 17:52:43 +0000
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 23LHn7fj030972;
        Thu, 21 Apr 2022 17:52:43 GMT
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com [9.57.198.29])
        by ppma01dal.us.ibm.com with ESMTP id 3ffneb6pp9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 21 Apr 2022 17:52:43 +0000
Received: from b01ledav002.gho.pok.ibm.com (b01ledav002.gho.pok.ibm.com [9.57.199.107])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 23LHqgLi28049880
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Apr 2022 17:52:42 GMT
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 22301124054;
        Thu, 21 Apr 2022 17:52:42 +0000 (GMT)
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1527C124052;
        Thu, 21 Apr 2022 17:52:42 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b01ledav002.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu, 21 Apr 2022 17:52:42 +0000 (GMT)
From:   Stefan Berger <stefanb@linux.ibm.com>
To:     zohar@linux.ibm.com, linux-integrity@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH] integrity: Fix sparse warnings in keyring_handler
Date:   Thu, 21 Apr 2022 13:52:05 -0400
Message-Id: <20220421175205.798974-1-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 3oKpnBtKbyC-w9Vm6rYPA1jQBQZq4CHc
X-Proofpoint-ORIG-GUID: 3oKpnBtKbyC-w9Vm6rYPA1jQBQZq4CHc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-21_03,2022-04-21_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 bulkscore=0 phishscore=0 malwarescore=0
 impostorscore=0 adultscore=0 priorityscore=1501 mlxlogscore=999
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204210092
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Fix the following sparse warnings:

  CHECK   security/integrity/platform_certs/keyring_handler.c
security/integrity/platform_certs/keyring_handler.c:76:16: warning: Using plain integer as NULL pointer
security/integrity/platform_certs/keyring_handler.c:91:16: warning: Using plain integer as NULL pointer
security/integrity/platform_certs/keyring_handler.c:106:16: warning: Using plain integer as NULL pointer

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 security/integrity/platform_certs/keyring_handler.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/security/integrity/platform_certs/keyring_handler.c b/security/integrity/platform_certs/keyring_handler.c
index 1db4d3b4356d..6cc90ce0056d 100644
--- a/security/integrity/platform_certs/keyring_handler.c
+++ b/security/integrity/platform_certs/keyring_handler.c
@@ -73,7 +73,7 @@ __init efi_element_handler_t get_handler_for_db(const efi_guid_t *sig_type)
 {
 	if (efi_guidcmp(*sig_type, efi_cert_x509_guid) == 0)
 		return add_to_platform_keyring;
-	return 0;
+	return NULL;
 }
 
 /*
@@ -88,7 +88,7 @@ __init efi_element_handler_t get_handler_for_mok(const efi_guid_t *sig_type)
 		else
 			return add_to_platform_keyring;
 	}
-	return 0;
+	return NULL;
 }
 
 /*
@@ -103,5 +103,5 @@ __init efi_element_handler_t get_handler_for_dbx(const efi_guid_t *sig_type)
 		return uefi_blacklist_binary;
 	if (efi_guidcmp(*sig_type, efi_cert_x509_guid) == 0)
 		return uefi_revocation_list_x509;
-	return 0;
+	return NULL;
 }
-- 
2.34.1

