Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2396A34E8C6
	for <lists+linux-integrity@lfdr.de>; Tue, 30 Mar 2021 15:18:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232084AbhC3NRd (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 30 Mar 2021 09:17:33 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:20034 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232006AbhC3NRG (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 30 Mar 2021 09:17:06 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12UD3tut052668;
        Tue, 30 Mar 2021 09:17:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=hCx2pyFl8NZJWI/gvhH5lakNnGcU4/hycynVYfk31Q4=;
 b=oSiTruNtqX9xZHCxAiFQccE9wk/xgjvs3Ab7BhR62c/Z8Blm4+lxzuIh7HjgDmmgduio
 gtupak6gqWj3rC6aE76S31Oue6Zk1NJuEl9KNxKDsqbAkrNu9nJjm8x9UDo3HicaQKhM
 bVBk6AcUZQ9iqvPbVygAHfhIA+BTHJVFb4FSeHDLiHaBofOXIOsvjZy7ZQwilU9ed2w9
 ufIgT4BhM+Y/HABbe0eVhAjgkNhcM4SmISSh79EatGuIJ0B0f05CycMP3iDurzTAYdMO
 MCmK+fomLC5IZaN6om52iLDXiAqTePYhKKGHTbE8iJ2zBC+fmdMhPhJkmJE97N69a3ts CA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 37juyp12v4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 Mar 2021 09:17:04 -0400
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 12UD4eMU059484;
        Tue, 30 Mar 2021 09:17:03 -0400
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com with ESMTP id 37juyp12tp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 Mar 2021 09:17:03 -0400
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 12UDH17e005187;
        Tue, 30 Mar 2021 13:17:01 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma06fra.de.ibm.com with ESMTP id 37huyh9f6u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 Mar 2021 13:17:01 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 12UDGdsr31457748
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Mar 2021 13:16:39 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4E6854C052;
        Tue, 30 Mar 2021 13:16:58 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0DD104C040;
        Tue, 30 Mar 2021 13:16:56 +0000 (GMT)
Received: from li-4b5937cc-25c4-11b2-a85c-cea3a66903e4.ibm.com.com (unknown [9.211.103.158])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 30 Mar 2021 13:16:55 +0000 (GMT)
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
Subject: [PATCH v3 3/3] ima: enable loading of build time generated key on .ima keyring
Date:   Tue, 30 Mar 2021 09:16:36 -0400
Message-Id: <20210330131636.21711-4-nayna@linux.ibm.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210330131636.21711-1-nayna@linux.ibm.com>
References: <20210330131636.21711-1-nayna@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 3Yq-VkukkJGo81HZefSDwP3rSGOkSiCw
X-Proofpoint-GUID: _lk4JPAzk7TUA1I2to7b3HOYVlOQIztJ
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-30_03:2021-03-30,2021-03-30 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxscore=0
 phishscore=0 spamscore=0 clxscore=1015 priorityscore=1501 impostorscore=0
 bulkscore=0 mlxlogscore=999 lowpriorityscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2103250000 definitions=main-2103300094
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

The kernel currently only loads the kernel module signing key onto the
builtin trusted keyring. Load the module signing key onto the IMA keyring
as well.

Signed-off-by: Nayna Jain <nayna@linux.ibm.com>
---
 certs/system_certificates.S   | 13 +++++++++-
 certs/system_keyring.c        | 47 +++++++++++++++++++++++++++--------
 include/keys/system_keyring.h |  7 ++++++
 security/integrity/digsig.c   |  2 ++
 4 files changed, 58 insertions(+), 11 deletions(-)

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
index 4b693da488f1..bb122bf4cc17 100644
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
@@ -186,6 +179,40 @@ static __init int load_system_certificate_list(void)
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
+
+	pr_notice("Loading compiled-in X.509 certificates\n");
+
+#ifdef CONFIG_MODULE_SIG
+	p = system_certificate_list;
+#else
+	p = system_certificate_list + module_cert_size;
+#endif
+
+	end = p + system_certificate_list_size;
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

