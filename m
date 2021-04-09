Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16D5035A131
	for <lists+linux-integrity@lfdr.de>; Fri,  9 Apr 2021 16:35:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233953AbhDIOfr (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 9 Apr 2021 10:35:47 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:40688 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233915AbhDIOfo (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 9 Apr 2021 10:35:44 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 139EXdQL122253;
        Fri, 9 Apr 2021 10:35:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=ZR3AnmvHvVrLQTtNhkZBfTTjyjO+odybSOncG5g3+9M=;
 b=WweNq6+n8zufsNH2KSHgl4c898wKCQT80MjUnGCtPGj1u7HU1v77nRpWavgiushfaMeS
 kXgqeb0cTcgvmTgOp2OXQRvVcKHlW502EX+EMy0xx7Pzu2f4gAF0VsmtSxWvHKd9cW5N
 aMqyfpFO8V4sf7Fc36hZ5jN4/gBKUIfN7w15WcQr7KLpBGjX4khxCRnxxs8x33tIxoHL
 DnAzCExDXfhveWCn7XzdIlXRtof/t0+3CIsgbH8W7UpZhXb6TAkZZHaPUU+JDti4TEMH
 f6HwQsrCKbeaPJli4xLocJRas/EsD1Y4rKH8jlxy/s4PfKU/5AK/Jn9pH8FN5WucN+rb tw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 37rw7mg34s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 09 Apr 2021 10:35:28 -0400
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 139EXnqO122793;
        Fri, 9 Apr 2021 10:35:28 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 37rw7mg33x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 09 Apr 2021 10:35:28 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 139EXT8A020560;
        Fri, 9 Apr 2021 14:35:25 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma04ams.nl.ibm.com with ESMTP id 37rvbuahfb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 09 Apr 2021 14:35:25 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 139EZMMA63242508
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 9 Apr 2021 14:35:22 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5D1554C04A;
        Fri,  9 Apr 2021 14:35:22 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 32E3A4C046;
        Fri,  9 Apr 2021 14:35:20 +0000 (GMT)
Received: from li-4b5937cc-25c4-11b2-a85c-cea3a66903e4.ibm.com.com (unknown [9.211.63.3])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri,  9 Apr 2021 14:35:19 +0000 (GMT)
From:   Nayna Jain <nayna@linux.ibm.com>
To:     linux-integrity@vger.kernel.org, keyrings@vger.kernel.org
Cc:     linux-security-module@vger.kernel.org,
        David Howells <dhowells@redhat.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Stefan Berger <stefanb@linux.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Nayna Jain <nayna@linux.ibm.com>
Subject: [PATCH v4 3/3] ima: enable loading of build time generated key on .ima keyring
Date:   Fri,  9 Apr 2021 10:35:07 -0400
Message-Id: <20210409143507.191443-4-nayna@linux.ibm.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210409143507.191443-1-nayna@linux.ibm.com>
References: <20210409143507.191443-1-nayna@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 7T2_09vbtw2fGNoyY09CBi_uaWrPN3oG
X-Proofpoint-ORIG-GUID: Exp0e4j45OrJ46B645Qnuo4s9WmRfBxS
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-09_06:2021-04-09,2021-04-09 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 mlxlogscore=999 malwarescore=0 lowpriorityscore=0 suspectscore=0
 phishscore=0 adultscore=0 priorityscore=1501 spamscore=0 impostorscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104090110
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

The kernel currently only loads the kernel module signing key onto the
builtin trusted keyring. Load the module signing key onto the IMA keyring
as well.

Signed-off-by: Nayna Jain <nayna@linux.ibm.com>
Acked-by: Stefan Berger <stefanb@linux.ibm.com>
---
 certs/system_certificates.S   | 13 ++++++++-
 certs/system_keyring.c        | 50 ++++++++++++++++++++++++++++-------
 include/keys/system_keyring.h |  7 +++++
 security/integrity/digsig.c   |  2 ++
 4 files changed, 61 insertions(+), 11 deletions(-)

diff --git a/certs/system_certificates.S b/certs/system_certificates.S
index 8f29058adf93..dcad27ea8527 100644
--- a/certs/system_certificates.S
+++ b/certs/system_certificates.S
@@ -8,9 +8,11 @@
 	.globl system_certificate_list
 system_certificate_list:
 __cert_list_start:
-#ifdef CONFIG_MODULE_SIG
+__module_cert_start:
+#if defined(CONFIG_MODULE_SIG) || defined(CONFIG_IMA_APPRAISE_MODSIG)
 	.incbin "certs/signing_key.x509"
 #endif
+__module_cert_end:
 	.incbin "certs/x509_certificate_list"
 __cert_list_end:
 
@@ -35,3 +37,12 @@ system_certificate_list_size:
 #else
 	.long __cert_list_end - __cert_list_start
 #endif
+
+	.align 8
+	.globl module_cert_size
+module_cert_size:
+#ifdef CONFIG_64BIT
+	.quad __module_cert_end - __module_cert_start
+#else
+	.long __module_cert_end - __module_cert_start
+#endif
diff --git a/certs/system_keyring.c b/certs/system_keyring.c
index 4b693da488f1..2b3ad375ecc1 100644
--- a/certs/system_keyring.c
+++ b/certs/system_keyring.c
@@ -27,6 +27,7 @@ static struct key *platform_trusted_keys;
 
 extern __initconst const u8 system_certificate_list[];
 extern __initconst const unsigned long system_certificate_list_size;
+extern __initconst const unsigned long module_cert_size;
 
 /**
  * restrict_link_to_builtin_trusted - Restrict keyring addition by built in CA
@@ -132,19 +133,11 @@ static __init int system_trusted_keyring_init(void)
  */
 device_initcall(system_trusted_keyring_init);
 
-/*
- * Load the compiled-in list of X.509 certificates.
- */
-static __init int load_system_certificate_list(void)
+static __init int load_cert(const u8 *p, const u8 *end, struct key *keyring)
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
@@ -159,7 +152,7 @@ static __init int load_system_certificate_list(void)
 		if (plen > end - p)
 			goto dodgy_cert;
 
-		key = key_create_or_update(make_key_ref(builtin_trusted_keys, 1),
+		key = key_create_or_update(make_key_ref(keyring, 1),
 					   "asymmetric",
 					   NULL,
 					   p,
@@ -186,6 +179,43 @@ static __init int load_system_certificate_list(void)
 	pr_err("Problem parsing in-kernel X.509 certificate list\n");
 	return 0;
 }
+
+__init int load_module_cert(struct key *keyring)
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
+	return load_cert(p, end, keyring);
+}
+
+/*
+ * Load the compiled-in list of X.509 certificates.
+ */
+static __init int load_system_certificate_list(void)
+{
+	const u8 *p, *end;
+	unsigned long size;
+
+	pr_notice("Loading compiled-in X.509 certificates\n");
+
+#ifdef CONFIG_MODULE_SIG
+	p = system_certificate_list;
+	size = system_certificate_list_size;
+#else
+	p = system_certificate_list + module_cert_size;
+	size = system_certificate_list_size - module_cert_size;
+#endif
+
+	end = p + size;
+	return load_cert(p, end, builtin_trusted_keys);
+}
 late_initcall(load_system_certificate_list);
 
 #ifdef CONFIG_SYSTEM_DATA_VERIFICATION
diff --git a/include/keys/system_keyring.h b/include/keys/system_keyring.h
index fb8b07daa9d1..f954276c616a 100644
--- a/include/keys/system_keyring.h
+++ b/include/keys/system_keyring.h
@@ -16,9 +16,16 @@ extern int restrict_link_by_builtin_trusted(struct key *keyring,
 					    const struct key_type *type,
 					    const union key_payload *payload,
 					    struct key *restriction_key);
+extern __init int load_module_cert(struct key *keyring);
 
 #else
 #define restrict_link_by_builtin_trusted restrict_link_reject
+
+static inline __init int load_module_cert(struct key *keyring)
+{
+	return 0;
+}
+
 #endif
 
 #ifdef CONFIG_SECONDARY_TRUSTED_KEYRING
diff --git a/security/integrity/digsig.c b/security/integrity/digsig.c
index 250fb0836156..3b06a01bd0fd 100644
--- a/security/integrity/digsig.c
+++ b/security/integrity/digsig.c
@@ -111,6 +111,8 @@ static int __init __integrity_init_keyring(const unsigned int id,
 	} else {
 		if (id == INTEGRITY_KEYRING_PLATFORM)
 			set_platform_trusted_keys(keyring[id]);
+		if (id == INTEGRITY_KEYRING_IMA)
+			load_module_cert(keyring[id]);
 	}
 
 	return err;
-- 
2.29.2

