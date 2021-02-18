Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CBDE31F1FF
	for <lists+linux-integrity@lfdr.de>; Thu, 18 Feb 2021 23:03:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230140AbhBRWCK (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 18 Feb 2021 17:02:10 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:5583 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230124AbhBRWBt (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 18 Feb 2021 17:01:49 -0500
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 11ILiHGs175790;
        Thu, 18 Feb 2021 17:01:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=9hX00GQXwNwM1pmRk0HiBYCC9/cO2w/+l9BIDU/7qSU=;
 b=mrRo9Kzz4EMjwJoqDg5HwVmU4jzCG8g1Um78NygSY3UcqCE9+OPR0ymWw4U6X8l5IqMj
 bJ+He/pQyzDOlbOy5GSy87smROOA6FzgptXAYnS9tO+t3HCtaGRI+6xDxjogwb6YjXJe
 qTXcBpMFIXpDs8Fp5r6KaZEn9exnwAr+s+sHL5cAoatGr2sf96h8LghiJD+qjStULkcS
 qFwRx4cZa++G2fTLK4khY1W6/eMvJTdBY3kAQ7JTPMZHFmR/aDhjKObfZBVMTHgl86U6
 vwZaqlsot+UStG/HzR2ovf6CZIXBG0ORul6q2i7PZBSApOWum5MTQe4rC4XUG1b9v17L uw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36syay9mb8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 Feb 2021 17:01:00 -0500
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 11ILA0UO176618;
        Thu, 18 Feb 2021 17:00:59 -0500
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36syay9m9s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 Feb 2021 17:00:59 -0500
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 11ILqkCZ013553;
        Thu, 18 Feb 2021 22:00:55 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma04ams.nl.ibm.com with ESMTP id 36p6d8d1r9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 Feb 2021 22:00:55 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 11IM0qk343385276
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 Feb 2021 22:00:52 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CAB4F4C04E;
        Thu, 18 Feb 2021 22:00:52 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BF0E94C050;
        Thu, 18 Feb 2021 22:00:50 +0000 (GMT)
Received: from li-4b5937cc-25c4-11b2-a85c-cea3a66903e4.ibm.com.com (unknown [9.211.90.194])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 18 Feb 2021 22:00:50 +0000 (GMT)
From:   Nayna Jain <nayna@linux.ibm.com>
To:     linux-integrity@vger.kernel.org, keyrings@vger.kernel.org
Cc:     linux-security-module@vger.kernel.org,
        David Howells <dhowells@redhat.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Stefan Berger <stefanb@linux.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nayna Jain <nayna@linux.ibm.com>
Subject: [PATCH v2 5/5] ima: enable loading of build time generated key on .ima keyring
Date:   Thu, 18 Feb 2021 17:00:11 -0500
Message-Id: <20210218220011.67625-6-nayna@linux.ibm.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210218220011.67625-1-nayna@linux.ibm.com>
References: <20210218220011.67625-1-nayna@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-02-18_09:2021-02-18,2021-02-18 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1015
 phishscore=0 lowpriorityscore=0 suspectscore=0 adultscore=0 mlxscore=0
 mlxlogscore=999 malwarescore=0 priorityscore=1501 bulkscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102180176
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

The kernel currently only loads the kernel module signing key onto
the builtin trusted keyring. To support IMA, load the module signing
key selectively either onto the builtin or IMA keyring based on MODULE_SIG
or MODULE_APPRAISE_MODSIG config respectively; and loads the CA kernel
key onto the builtin trusted keyring.

Signed-off-by: Nayna Jain <nayna@linux.ibm.com>
---
 certs/system_keyring.c        | 55 ++++++++++++++++++++++++++---------
 include/keys/system_keyring.h |  9 +++++-
 security/integrity/digsig.c   |  4 +++
 3 files changed, 54 insertions(+), 14 deletions(-)

diff --git a/certs/system_keyring.c b/certs/system_keyring.c
index 798291177186..ea3826627729 100644
--- a/certs/system_keyring.c
+++ b/certs/system_keyring.c
@@ -26,6 +26,7 @@ static struct key *platform_trusted_keys;
 
 extern __initconst const u8 system_certificate_list[];
 extern __initconst const unsigned long system_certificate_list_size;
+extern __initconst const unsigned long module_cert_size;
 
 /**
  * restrict_link_to_builtin_trusted - Restrict keyring addition by built in CA
@@ -131,19 +132,12 @@ static __init int system_trusted_keyring_init(void)
  */
 device_initcall(system_trusted_keyring_init);
 
-/*
- * Load the compiled-in list of X.509 certificates.
- */
-static __init int load_system_certificate_list(void)
+static __init int load_cert(const u8 *p, const u8 *end, struct key *keyring,
+			    unsigned long flags)
 {
 	key_ref_t key;
-	const u8 *p, *end;
 	size_t plen;
 
-	pr_notice("Loading compiled-in X.509 certificates\n");
-
-	p = system_certificate_list;
-	end = p + system_certificate_list_size;
 	while (p < end) {
 		/* Each cert begins with an ASN.1 SEQUENCE tag and must be more
 		 * than 256 bytes in size.
@@ -158,16 +152,15 @@ static __init int load_system_certificate_list(void)
 		if (plen > end - p)
 			goto dodgy_cert;
 
-		key = key_create_or_update(make_key_ref(builtin_trusted_keys, 1),
+		key = key_create_or_update(make_key_ref(keyring, 1),
 					   "asymmetric",
 					   NULL,
 					   p,
 					   plen,
 					   ((KEY_POS_ALL & ~KEY_POS_SETATTR) |
 					   KEY_USR_VIEW | KEY_USR_READ),
-					   KEY_ALLOC_NOT_IN_QUOTA |
-					   KEY_ALLOC_BUILT_IN |
-					   KEY_ALLOC_BYPASS_RESTRICTION);
+					   flags);
+
 		if (IS_ERR(key)) {
 			pr_err("Problem loading in-kernel X.509 certificate (%ld)\n",
 			       PTR_ERR(key));
@@ -185,6 +178,42 @@ static __init int load_system_certificate_list(void)
 	pr_err("Problem parsing in-kernel X.509 certificate list\n");
 	return 0;
 }
+
+__init int load_module_cert(struct key *keyring, unsigned long flags)
+{
+	const u8 *p, *end;
+
+	if (!IS_ENABLED(CONFIG_IMA_APPRAISE_MODSIG))
+		return 0;
+
+	pr_notice("Loading compiled-in module X.509 certificates\n");
+
+	p = system_certificate_list;
+	end = p + module_cert_size;
+
+	return load_cert(p, end, keyring, flags);
+}
+
+/*
+ * Load the compiled-in list of X.509 certificates.
+ */
+static __init int load_system_certificate_list(void)
+{
+	const u8 *p, *end;
+
+	pr_notice("Loading compiled-in X.509 certificates\n");
+
+#ifdef CONFIG_MODULE_SIG
+	p = system_certificate_list;
+#else
+	p = system_certificate_list + module_cert_size;
+#endif
+	end = p + system_certificate_list_size;
+
+	return load_cert(p, end, builtin_trusted_keys, KEY_ALLOC_NOT_IN_QUOTA |
+						KEY_ALLOC_BUILT_IN |
+						KEY_ALLOC_BYPASS_RESTRICTION);
+}
 late_initcall(load_system_certificate_list);
 
 #ifdef CONFIG_SYSTEM_DATA_VERIFICATION
diff --git a/include/keys/system_keyring.h b/include/keys/system_keyring.h
index fb8b07daa9d1..e91c03376599 100644
--- a/include/keys/system_keyring.h
+++ b/include/keys/system_keyring.h
@@ -16,9 +16,16 @@ extern int restrict_link_by_builtin_trusted(struct key *keyring,
 					    const struct key_type *type,
 					    const union key_payload *payload,
 					    struct key *restriction_key);
-
+extern __init int load_module_cert(struct key *keyring, unsigned long flags);
 #else
 #define restrict_link_by_builtin_trusted restrict_link_reject
+
+static inline __init int load_module_cert(struct key *keyring,
+					  unsigned long flags)
+{
+	return 0;
+}
+
 #endif
 
 #ifdef CONFIG_SECONDARY_TRUSTED_KEYRING
diff --git a/security/integrity/digsig.c b/security/integrity/digsig.c
index 0f518dcfde05..4009d1e33fe0 100644
--- a/security/integrity/digsig.c
+++ b/security/integrity/digsig.c
@@ -111,8 +111,12 @@ static int __init __integrity_init_keyring(const unsigned int id,
 	} else {
 		if (id == INTEGRITY_KEYRING_PLATFORM)
 			set_platform_trusted_keys(keyring[id]);
+		if (id == INTEGRITY_KEYRING_IMA)
+			load_module_cert(keyring[id], KEY_ALLOC_NOT_IN_QUOTA);
 	}
 
+	pr_info("Loading key to ima keyring\n");
+
 	return err;
 }
 
-- 
2.29.2

