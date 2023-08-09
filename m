Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2EF1776943
	for <lists+linux-integrity@lfdr.de>; Wed,  9 Aug 2023 21:54:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231298AbjHITx4 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 9 Aug 2023 15:53:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230497AbjHITxw (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 9 Aug 2023 15:53:52 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E715810DC;
        Wed,  9 Aug 2023 12:53:51 -0700 (PDT)
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 379JrMXm025237;
        Wed, 9 Aug 2023 19:53:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=2K+xOl9iCiEdHbs8U9vWbwZhgSfvBN7iaw7oWsKkQPc=;
 b=Ih8MoIR6k2J1Xn+pNxWJcL+GvRA86qstbQVvgssiSAMpnNISG6SCK8sRTAagXPN6Afg4
 MuRTXXnF/Q140GaDY6P1qgUfWiN4nHz9+lonOzrMyBpg/7GxKomX/Ps2rTbKf6locc/i
 hzkvFXAREYbTzPblJTabFqj9gXEydY4wzpOFAHS/GxYV45FpJ8BvB8tlK50IZ8HyF56H
 lWHd++xTckUdpF5H9UyLYUIBbkwZfHCaVEnuJxeOfffAgrlMQqpi0AZRI+ZMifys97vg
 8IIT6+JhXW6pa4rAKDsC5zi/hGyquqGUE1w/08CcnbyCvFCGDgY5W5k3XfCbhSTkRA1+ 6A== 
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3schbn8071-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Aug 2023 19:53:43 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 379IaVjG007573;
        Wed, 9 Aug 2023 19:53:43 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
        by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3sa14ykjxj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Aug 2023 19:53:42 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
        by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 379Jrdsx32703162
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 9 Aug 2023 19:53:40 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D48EE20043;
        Wed,  9 Aug 2023 19:53:39 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B623E20040;
        Wed,  9 Aug 2023 19:53:37 +0000 (GMT)
Received: from li-4b5937cc-25c4-11b2-a85c-cea3a66903e4.ibm.com (unknown [9.61.3.84])
        by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Wed,  9 Aug 2023 19:53:37 +0000 (GMT)
From:   Nayna Jain <nayna@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Eric Snowberg <eric.snowberg@oracle.com>,
        Paul Moore <paul@paul-moore.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, Nayna Jain <nayna@linux.ibm.com>
Subject: [PATCH v2 4/6] integrity: check whether imputed trust is enabled
Date:   Wed,  9 Aug 2023 15:53:13 -0400
Message-Id: <20230809195315.1085656-5-nayna@linux.ibm.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20230809195315.1085656-1-nayna@linux.ibm.com>
References: <20230809195315.1085656-1-nayna@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: YkRxITWoHoezWme_NbkY_sfwWuSH0JQy
X-Proofpoint-ORIG-GUID: YkRxITWoHoezWme_NbkY_sfwWuSH0JQy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-09_17,2023-08-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 lowpriorityscore=0 mlxlogscore=999 impostorscore=0 bulkscore=0
 malwarescore=0 clxscore=1015 priorityscore=1501 suspectscore=0 mlxscore=0
 spamscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308090171
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

trust_moklist() is specific to UEFI enabled systems. Other platforms
rely only on the Kconfig.

Define a generic wrapper named imputed_trust_enabled().

Signed-off-by: Nayna Jain <nayna@linux.ibm.com>
Reviewed-off-by: Mimi Zohar <zohar@linux.ibm.com>
---
 security/integrity/digsig.c                    |  2 +-
 security/integrity/integrity.h                 |  5 +++--
 .../integrity/platform_certs/keyring_handler.c |  3 ++-
 .../integrity/platform_certs/machine_keyring.c | 18 ++++++++++++++++--
 4 files changed, 22 insertions(+), 6 deletions(-)

diff --git a/security/integrity/digsig.c b/security/integrity/digsig.c
index d0704b1597d4..df387de29bfa 100644
--- a/security/integrity/digsig.c
+++ b/security/integrity/digsig.c
@@ -113,7 +113,7 @@ static int __init __integrity_init_keyring(const unsigned int id,
 	} else {
 		if (id == INTEGRITY_KEYRING_PLATFORM)
 			set_platform_trusted_keys(keyring[id]);
-		if (id == INTEGRITY_KEYRING_MACHINE && trust_moklist())
+		if (id == INTEGRITY_KEYRING_MACHINE && imputed_trust_enabled())
 			set_machine_trusted_keys(keyring[id]);
 		if (id == INTEGRITY_KEYRING_IMA)
 			load_module_cert(keyring[id]);
diff --git a/security/integrity/integrity.h b/security/integrity/integrity.h
index 7167a6e99bdc..d7553c93f5c0 100644
--- a/security/integrity/integrity.h
+++ b/security/integrity/integrity.h
@@ -320,13 +320,14 @@ static inline void __init add_to_platform_keyring(const char *source,
 
 #ifdef CONFIG_INTEGRITY_MACHINE_KEYRING
 void __init add_to_machine_keyring(const char *source, const void *data, size_t len);
-bool __init trust_moklist(void);
+bool __init imputed_trust_enabled(void);
 #else
 static inline void __init add_to_machine_keyring(const char *source,
 						  const void *data, size_t len)
 {
 }
-static inline bool __init trust_moklist(void)
+
+static inline bool __init imputed_trust_enabled(void)
 {
 	return false;
 }
diff --git a/security/integrity/platform_certs/keyring_handler.c b/security/integrity/platform_certs/keyring_handler.c
index 1649d047e3b8..586027b9a3f5 100644
--- a/security/integrity/platform_certs/keyring_handler.c
+++ b/security/integrity/platform_certs/keyring_handler.c
@@ -61,7 +61,8 @@ __init efi_element_handler_t get_handler_for_db(const efi_guid_t *sig_type)
 __init efi_element_handler_t get_handler_for_mok(const efi_guid_t *sig_type)
 {
 	if (efi_guidcmp(*sig_type, efi_cert_x509_guid) == 0) {
-		if (IS_ENABLED(CONFIG_INTEGRITY_MACHINE_KEYRING) && trust_moklist())
+		if (IS_ENABLED(CONFIG_INTEGRITY_MACHINE_KEYRING) &&
+		    imputed_trust_enabled())
 			return add_to_machine_keyring;
 		else
 			return add_to_platform_keyring;
diff --git a/security/integrity/platform_certs/machine_keyring.c b/security/integrity/platform_certs/machine_keyring.c
index 9482e16cb2ca..a401640a63cd 100644
--- a/security/integrity/platform_certs/machine_keyring.c
+++ b/security/integrity/platform_certs/machine_keyring.c
@@ -34,7 +34,8 @@ void __init add_to_machine_keyring(const char *source, const void *data, size_t
 	 * If the restriction check does not pass and the platform keyring
 	 * is configured, try to add it into that keyring instead.
 	 */
-	if (rc && efi_enabled(EFI_BOOT) && IS_ENABLED(CONFIG_INTEGRITY_PLATFORM_KEYRING))
+	if (rc && efi_enabled(EFI_BOOT) &&
+	    IS_ENABLED(CONFIG_INTEGRITY_PLATFORM_KEYRING))
 		rc = integrity_load_cert(INTEGRITY_KEYRING_PLATFORM, source,
 					 data, len, perm);
 
@@ -60,7 +61,7 @@ static __init bool uefi_check_trust_mok_keys(void)
 	return false;
 }
 
-bool __init trust_moklist(void)
+static bool __init trust_moklist(void)
 {
 	static bool initialized;
 	static bool trust_mok;
@@ -75,3 +76,16 @@ bool __init trust_moklist(void)
 
 	return trust_mok;
 }
+
+/*
+ * Provides platform specific check for trusting imputed keys before loading
+ * on .machine keyring. UEFI systems enable this trust based on a variable,
+ * and for other platforms, it is always enabled.
+ */
+bool __init imputed_trust_enabled(void)
+{
+	if (efi_enabled(EFI_BOOT))
+		return trust_moklist();
+
+	return true;
+}
-- 
2.31.1

