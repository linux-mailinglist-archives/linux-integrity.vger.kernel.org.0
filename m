Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C98477CC35
	for <lists+linux-integrity@lfdr.de>; Tue, 15 Aug 2023 13:58:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236887AbjHOL6K (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 15 Aug 2023 07:58:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236922AbjHOL5l (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 15 Aug 2023 07:57:41 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BACA1FD2;
        Tue, 15 Aug 2023 04:57:17 -0700 (PDT)
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37FBQhmh023836;
        Tue, 15 Aug 2023 11:54:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=ZR9sgM0xhRDfzWmEBgP5Y5OKvGxOgfPFBhQzlqMrnJo=;
 b=A03//yPitUN/hawo5yUjkHN8kPV5A23YnkgYGfB/xoob3i9ttNj/INrPK3Hxs4+yq0zs
 1diWQ7KDdbbsj5kFxGgF0ZxHq8+opiqcKfyrzsQF1zGysWXVNQlDDZFuk2dnap+GXzl8
 IhqltAShfa+1cE897/g5OyaKNf9gitJcX8vcZWjSdBolIk7DBrL4tBOizi0wNpD91G3z
 rViSkrmRwczjBEaBlPvmd1CU3jM64s/QV/60KxdooMyR8ciwSEbzLZ2vbCiFia8dscF6
 lS/dfbq5hOguKdszFMek+8tbLtDdZ+9YtKUXGAVKirbUjOYBl5tKOE4fKqRS0dnG2Ise Og== 
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sg8gc0ex4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 15 Aug 2023 11:54:59 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 37FBCit6007861;
        Tue, 15 Aug 2023 11:27:40 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
        by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3senwk4905-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 15 Aug 2023 11:27:40 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
        by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 37FBRbk615139454
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Aug 2023 11:27:37 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7EBF920040;
        Tue, 15 Aug 2023 11:27:37 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3AC1C20043;
        Tue, 15 Aug 2023 11:27:35 +0000 (GMT)
Received: from li-4b5937cc-25c4-11b2-a85c-cea3a66903e4.ibm.com (unknown [9.61.3.84])
        by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Tue, 15 Aug 2023 11:27:35 +0000 (GMT)
From:   Nayna Jain <nayna@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Eric Snowberg <eric.snowberg@oracle.com>,
        Paul Moore <paul@paul-moore.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-security-module@vger.kernel.org, inux-kernel@vger.kernel.org,
        Nayna Jain <nayna@linux.ibm.com>
Subject: [PATCH v4 1/6] integrity: PowerVM support for loading CA keys on machine keyring
Date:   Tue, 15 Aug 2023 07:27:17 -0400
Message-Id: <20230815112722.1591829-2-nayna@linux.ibm.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20230815112722.1591829-1-nayna@linux.ibm.com>
References: <20230815112722.1591829-1-nayna@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: qzVduxJSBr2AQOXelN07RiqCLXU5Njrm
X-Proofpoint-GUID: qzVduxJSBr2AQOXelN07RiqCLXU5Njrm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-15_10,2023-08-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 impostorscore=0 priorityscore=1501 lowpriorityscore=0 phishscore=0
 adultscore=0 mlxlogscore=999 suspectscore=0 spamscore=0 clxscore=1015
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308150103
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Keys that derive their trust from an entity such as a security officer,
administrator, system owner, or machine owner are said to have "imputed
trust". CA keys with imputed trust can be loaded onto the machine keyring.
The mechanism for loading these keys onto the machine keyring is platform
dependent.

Load keys stored in the variable trustedcadb onto the .machine keyring
on PowerVM platform.

Signed-off-by: Nayna Jain <nayna@linux.ibm.com>
Reviewed-and-tested-by: Mimi Zohar <zohar@linux.ibm.com>
---
 .../integrity/platform_certs/keyring_handler.c  |  8 ++++++++
 .../integrity/platform_certs/keyring_handler.h  |  5 +++++
 .../integrity/platform_certs/load_powerpc.c     | 17 +++++++++++++++++
 3 files changed, 30 insertions(+)

diff --git a/security/integrity/platform_certs/keyring_handler.c b/security/integrity/platform_certs/keyring_handler.c
index 8a1124e4d769..1649d047e3b8 100644
--- a/security/integrity/platform_certs/keyring_handler.c
+++ b/security/integrity/platform_certs/keyring_handler.c
@@ -69,6 +69,14 @@ __init efi_element_handler_t get_handler_for_mok(const efi_guid_t *sig_type)
 	return NULL;
 }
 
+__init efi_element_handler_t get_handler_for_ca_keys(const efi_guid_t *sig_type)
+{
+	if (efi_guidcmp(*sig_type, efi_cert_x509_guid) == 0)
+		return add_to_machine_keyring;
+
+	return NULL;
+}
+
 /*
  * Return the appropriate handler for particular signature list types found in
  * the UEFI dbx and MokListXRT tables.
diff --git a/security/integrity/platform_certs/keyring_handler.h b/security/integrity/platform_certs/keyring_handler.h
index 212d894a8c0c..6f15bb4cc8dc 100644
--- a/security/integrity/platform_certs/keyring_handler.h
+++ b/security/integrity/platform_certs/keyring_handler.h
@@ -29,6 +29,11 @@ efi_element_handler_t get_handler_for_db(const efi_guid_t *sig_type);
  */
 efi_element_handler_t get_handler_for_mok(const efi_guid_t *sig_type);
 
+/*
+ * Return the handler for particular signature list types for CA keys.
+ */
+efi_element_handler_t get_handler_for_ca_keys(const efi_guid_t *sig_type);
+
 /*
  * Return the handler for particular signature list types found in the dbx.
  */
diff --git a/security/integrity/platform_certs/load_powerpc.c b/security/integrity/platform_certs/load_powerpc.c
index 170789dc63d2..339053d9726d 100644
--- a/security/integrity/platform_certs/load_powerpc.c
+++ b/security/integrity/platform_certs/load_powerpc.c
@@ -59,6 +59,7 @@ static __init void *get_cert_list(u8 *key, unsigned long keylen, u64 *size)
 static int __init load_powerpc_certs(void)
 {
 	void *db = NULL, *dbx = NULL, *data = NULL;
+	void *trustedca;
 	u64 dsize = 0;
 	u64 offset = 0;
 	int rc = 0;
@@ -120,6 +121,22 @@ static int __init load_powerpc_certs(void)
 		kfree(data);
 	}
 
+	data = get_cert_list("trustedcadb", 12,  &dsize);
+	if (!data) {
+		pr_info("Couldn't get trustedcadb list from firmware\n");
+	} else if (IS_ERR(data)) {
+		rc = PTR_ERR(data);
+		pr_err("Error reading trustedcadb from firmware: %d\n", rc);
+	} else {
+		extract_esl(trustedca, data, dsize, offset);
+
+		rc = parse_efi_signature_list("powerpc:trustedca", trustedca, dsize,
+					      get_handler_for_ca_keys);
+		if (rc)
+			pr_err("Couldn't parse trustedcadb signatures: %d\n", rc);
+		kfree(data);
+	}
+
 	return rc;
 }
 late_initcall(load_powerpc_certs);
-- 
2.31.1

