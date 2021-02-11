Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10D9B3193A0
	for <lists+linux-integrity@lfdr.de>; Thu, 11 Feb 2021 20:57:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231637AbhBKT4a (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 11 Feb 2021 14:56:30 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:24478 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231486AbhBKT4A (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 11 Feb 2021 14:56:00 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 11BJhZ1K180221;
        Thu, 11 Feb 2021 14:55:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=/dVh8leYKPxVTu0OUSq0TIvb2aZyD1O6XwkrwUlEfqA=;
 b=V1hGgVFE6Mge/ewznGr5s5MpRz578ikiGXAOyoxt4igzebkkLGuRJXLunkha0N3dGNVh
 COtuzngk9E6CXkNFFn/+j87BGMV33I/EqpSIw+YoxgCoLx8Kk4uitDqxp/HSyzX5wyWi
 5R40QDumqsxDs6+U/EAvTZQCA4pgTEbRT51EtvbGcc11xSm95ttfi4chAqhFMUneK+UH
 vM2H17MBb7/O3Bx8OX1vnVl0s9af7xa1BVctZ9PW1UASo57ujk4z7qv+gF0azqVvPvqF
 CMejvvRfjAWN9/2qlHolPyEQBKyWDmNyqMB7kc92V3OsqXmBz3yT9AchChUfOy+6dPIi xQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36nb05r87u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 11 Feb 2021 14:55:19 -0500
Received: from m0098394.ppops.net (m0098394.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 11BJi4o7182965;
        Thu, 11 Feb 2021 14:55:19 -0500
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36nb05r872-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 11 Feb 2021 14:55:19 -0500
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 11BJqLSq030665;
        Thu, 11 Feb 2021 19:55:17 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma04fra.de.ibm.com with ESMTP id 36hjr8b5qh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 11 Feb 2021 19:55:17 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 11BJtEQ941419172
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 11 Feb 2021 19:55:14 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E43A14203F;
        Thu, 11 Feb 2021 19:55:13 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 388C34204B;
        Thu, 11 Feb 2021 19:55:12 +0000 (GMT)
Received: from li-4b5937cc-25c4-11b2-a85c-cea3a66903e4.ibm.com.com (unknown [9.160.81.209])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 11 Feb 2021 19:55:11 +0000 (GMT)
From:   Nayna Jain <nayna@linux.ibm.com>
To:     linux-integrity@vger.kernel.org, keyrings@vger.kernel.org
Cc:     linux-security-module@vger.kernel.org,
        David Howells <dhowells@redhat.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nayna Jain <nayna@linux.ibm.com>
Subject: [PATCH 5/5] ima: enable loading of build time generated key to .ima keyring
Date:   Thu, 11 Feb 2021 14:54:35 -0500
Message-Id: <20210211195435.135582-6-nayna@linux.ibm.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210211195435.135582-1-nayna@linux.ibm.com>
References: <20210211195435.135582-1-nayna@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-11_07:2021-02-11,2021-02-11 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 phishscore=0
 spamscore=0 impostorscore=0 adultscore=0 lowpriorityscore=0
 priorityscore=1501 clxscore=1015 suspectscore=0 mlxscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102110153
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

The kernel currently only loads the kernel module signing key onto
the builtin trusted keyring. To support IMA, load the module signing
key selectively either onto builtin or ima keyring based on MODULE_SIG
or MODULE_APPRAISE_MODSIG config respectively; and loads the CA kernel
key onto builtin trusted keyring.

Signed-off-by: Nayna Jain <nayna@linux.ibm.com>
---
 certs/system_keyring.c        | 56 +++++++++++++++++++++++++++--------
 include/keys/system_keyring.h |  9 +++++-
 security/integrity/digsig.c   |  4 +++
 3 files changed, 55 insertions(+), 14 deletions(-)

diff --git a/certs/system_keyring.c b/certs/system_keyring.c
index 798291177186..0bbbe501f8a7 100644
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
@@ -185,6 +178,43 @@ static __init int load_system_certificate_list(void)
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
+	load_cert(p, end, keyring, flags);
+
+	return 0;
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
+	load_cert(p, end, builtin_trusted_keys, KEY_ALLOC_NOT_IN_QUOTA |
+						KEY_ALLOC_BUILT_IN |
+						KEY_ALLOC_BYPASS_RESTRICTION);
+	return 0;
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
2.18.1

