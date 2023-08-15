Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCFD077CBB0
	for <lists+linux-integrity@lfdr.de>; Tue, 15 Aug 2023 13:28:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236002AbjHOL2Z (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 15 Aug 2023 07:28:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236074AbjHOL2F (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 15 Aug 2023 07:28:05 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D16FE110;
        Tue, 15 Aug 2023 04:28:02 -0700 (PDT)
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37FAv9u3007647;
        Tue, 15 Aug 2023 11:27:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=7umKQ18TfJ2rU0BAvlJw1ntvklLhAfPeNWw/sDM+fX4=;
 b=sRCxdfpkO3tjlBBeb1Fbe7qGKysmkrQCsqnoslt28v/yp3Vbfzr2hUDXGi8b04uW3iOx
 6MJ6dEw60eGj01xvGjiguqfP0/yfq+y3WX4zGAstTwmJBwdDgNlNjHSKVqFEbClG7bb3
 Xa6nTRziO1sXWJXFJ1ZssjLBw9lrQDwVSalMzbMqjDKkmCjL0cyaH7HnlLNCtz1d49w3
 jeb2tLKUOAljQTMsA1Q6lZOmDZhODcaERQsrCmuCu6oVI99LqT8TKmfnTWKxk5B4/tpK
 R6W/1utIgZ0xOVbq97EjUpK8fNEUG8+BfK2jvLMwMng5cGXuBBRvAFi9hzMArRyO8BCw RQ== 
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sg82ggjfp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 15 Aug 2023 11:27:53 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 37FABS99002409;
        Tue, 15 Aug 2023 11:27:53 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
        by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3sendn4erh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 15 Aug 2023 11:27:53 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
        by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 37FBRo3562259556
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Aug 2023 11:27:50 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 237802004B;
        Tue, 15 Aug 2023 11:27:50 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0F43320040;
        Tue, 15 Aug 2023 11:27:48 +0000 (GMT)
Received: from li-4b5937cc-25c4-11b2-a85c-cea3a66903e4.ibm.com (unknown [9.61.3.84])
        by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Tue, 15 Aug 2023 11:27:47 +0000 (GMT)
From:   Nayna Jain <nayna@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Eric Snowberg <eric.snowberg@oracle.com>,
        Paul Moore <paul@paul-moore.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-security-module@vger.kernel.org, inux-kernel@vger.kernel.org,
        Nayna Jain <nayna@linux.ibm.com>
Subject: [PATCH v4 6/6] integrity: PowerVM support for loading third party code signing keys
Date:   Tue, 15 Aug 2023 07:27:22 -0400
Message-Id: <20230815112722.1591829-7-nayna@linux.ibm.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20230815112722.1591829-1-nayna@linux.ibm.com>
References: <20230815112722.1591829-1-nayna@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: GC_cy-MCukNJoq6yujrRojl7WMEte774
X-Proofpoint-ORIG-GUID: GC_cy-MCukNJoq6yujrRojl7WMEte774
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

On secure boot enabled PowerVM LPAR, third party code signing keys are
needed during early boot to verify signed third party modules. These
third party keys are stored in moduledb object in the Platform
KeyStore (PKS).

Load third party code signing keys onto .secondary_trusted_keys keyring.

Signed-off-by: Nayna Jain <nayna@linux.ibm.com>
---
 certs/system_keyring.c                        | 30 +++++++++++++++++++
 include/keys/system_keyring.h                 |  4 +++
 .../platform_certs/keyring_handler.c          |  8 +++++
 .../platform_certs/keyring_handler.h          |  5 ++++
 .../integrity/platform_certs/load_powerpc.c   | 17 +++++++++++
 5 files changed, 64 insertions(+)

diff --git a/certs/system_keyring.c b/certs/system_keyring.c
index b348e0898d34..33841c91f12c 100644
--- a/certs/system_keyring.c
+++ b/certs/system_keyring.c
@@ -152,6 +152,36 @@ static __init struct key_restriction *get_builtin_and_secondary_restriction(void
 
 	return restriction;
 }
+
+/**
+ * add_to_secondary_keyring - Add to secondary keyring.
+ * @source: Source of key
+ * @data: The blob holding the key
+ * @len: The length of the data blob
+ *
+ * Add a key to the secondary keyring. The key must be vouched for by a key in the builtin,
+ * machine or secondary keyring itself.
+ */
+void __init add_to_secondary_keyring(const char *source, const void *data, size_t len)
+{
+	key_ref_t key;
+	key_perm_t perm;
+
+	perm = (KEY_POS_ALL & ~KEY_POS_SETATTR) | KEY_USR_VIEW;
+
+	key = key_create_or_update(make_key_ref(secondary_trusted_keys, 1),
+				   "asymmetric",
+				   NULL, data, len, perm,
+				   KEY_ALLOC_NOT_IN_QUOTA);
+	if (IS_ERR(key)) {
+		pr_err("Problem loading X.509 certificate from %s to secondary keyring %ld\n",
+		       source, PTR_ERR(key));
+		return;
+	}
+
+	pr_notice("Loaded X.509 cert '%s'\n", key_ref_to_ptr(key)->description);
+	key_ref_put(key);
+}
 #endif
 #ifdef CONFIG_INTEGRITY_MACHINE_KEYRING
 void __init set_machine_trusted_keys(struct key *keyring)
diff --git a/include/keys/system_keyring.h b/include/keys/system_keyring.h
index 7e2583208820..8365adf842ef 100644
--- a/include/keys/system_keyring.h
+++ b/include/keys/system_keyring.h
@@ -50,9 +50,13 @@ int restrict_link_by_digsig_builtin_and_secondary(struct key *keyring,
 						  const struct key_type *type,
 						  const union key_payload *payload,
 						  struct key *restriction_key);
+void __init add_to_secondary_keyring(const char *source, const void *data, size_t len);
 #else
 #define restrict_link_by_builtin_and_secondary_trusted restrict_link_by_builtin_trusted
 #define restrict_link_by_digsig_builtin_and_secondary restrict_link_by_digsig_builtin
+static inline void __init add_to_secondary_keyring(const char *source, const void *data, size_t len)
+{
+}
 #endif
 
 #ifdef CONFIG_INTEGRITY_MACHINE_KEYRING
diff --git a/security/integrity/platform_certs/keyring_handler.c b/security/integrity/platform_certs/keyring_handler.c
index 586027b9a3f5..13ea17207902 100644
--- a/security/integrity/platform_certs/keyring_handler.c
+++ b/security/integrity/platform_certs/keyring_handler.c
@@ -78,6 +78,14 @@ __init efi_element_handler_t get_handler_for_ca_keys(const efi_guid_t *sig_type)
 	return NULL;
 }
 
+__init efi_element_handler_t get_handler_for_code_signing_keys(const efi_guid_t *sig_type)
+{
+	if (efi_guidcmp(*sig_type, efi_cert_x509_guid) == 0)
+		return add_to_secondary_keyring;
+
+	return NULL;
+}
+
 /*
  * Return the appropriate handler for particular signature list types found in
  * the UEFI dbx and MokListXRT tables.
diff --git a/security/integrity/platform_certs/keyring_handler.h b/security/integrity/platform_certs/keyring_handler.h
index 6f15bb4cc8dc..f92895cc50f6 100644
--- a/security/integrity/platform_certs/keyring_handler.h
+++ b/security/integrity/platform_certs/keyring_handler.h
@@ -34,6 +34,11 @@ efi_element_handler_t get_handler_for_mok(const efi_guid_t *sig_type);
  */
 efi_element_handler_t get_handler_for_ca_keys(const efi_guid_t *sig_type);
 
+/*
+ * Return the handler for particular signature list types for code signing keys.
+ */
+efi_element_handler_t get_handler_for_code_signing_keys(const efi_guid_t *sig_type);
+
 /*
  * Return the handler for particular signature list types found in the dbx.
  */
diff --git a/security/integrity/platform_certs/load_powerpc.c b/security/integrity/platform_certs/load_powerpc.c
index 339053d9726d..c85febca3343 100644
--- a/security/integrity/platform_certs/load_powerpc.c
+++ b/security/integrity/platform_certs/load_powerpc.c
@@ -60,6 +60,7 @@ static int __init load_powerpc_certs(void)
 {
 	void *db = NULL, *dbx = NULL, *data = NULL;
 	void *trustedca;
+	void *moduledb;
 	u64 dsize = 0;
 	u64 offset = 0;
 	int rc = 0;
@@ -137,6 +138,22 @@ static int __init load_powerpc_certs(void)
 		kfree(data);
 	}
 
+	data = get_cert_list("moduledb", 9,  &dsize);
+	if (!data) {
+		pr_info("Couldn't get moduledb list from firmware\n");
+	} else if (IS_ERR(data)) {
+		rc = PTR_ERR(data);
+		pr_err("Error reading moduledb from firmware: %d\n", rc);
+	} else {
+		extract_esl(moduledb, data, dsize, offset);
+
+		rc = parse_efi_signature_list("powerpc:moduledb", moduledb, dsize,
+					      get_handler_for_code_signing_keys);
+		if (rc)
+			pr_err("Couldn't parse moduledb signatures: %d\n", rc);
+		kfree(data);
+	}
+
 	return rc;
 }
 late_initcall(load_powerpc_certs);
-- 
2.31.1

