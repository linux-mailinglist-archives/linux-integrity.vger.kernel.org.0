Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71EEB31939B
	for <lists+linux-integrity@lfdr.de>; Thu, 11 Feb 2021 20:57:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230381AbhBKT4T (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 11 Feb 2021 14:56:19 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:65522 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231447AbhBKTz6 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 11 Feb 2021 14:55:58 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 11BJhWpx179856;
        Thu, 11 Feb 2021 14:55:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=HM3sotdvFTqXt6WRGTIBw2VdbazueFIt2qG6yysrYuo=;
 b=TKyNgzKbwifl1EtKIPpJLZenz5WBolpRX2SoyCTx0qhjQq9heOLdVQQ0swmCXD5epTKK
 ni82C8CvdwSyWRe6bxAwhPmSRzCsgL0UC2vmcXtIMHU4Hsv0dCWPOWduvktM27fGvNYU
 3rr4MBlu4XSDfehXdRLqAiIH/5CWFBtU6JnCjFi6VjW/gLjDuPk/8PF+XhkSXFTvm91R
 EpLPOZo/D1g2SbsKRdWc+Dxxpir90AMbIlG/uD4s9gBynewcGEOUqjOEtEGzLxqINUWJ
 n+YL0TDhV6h3+g20k8B1Q3oVQRf1J7Z7QooYnoMoGzdpohfNn0qCnQ024IywfWro2j9Q DA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36nb05r86b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 11 Feb 2021 14:55:16 -0500
Received: from m0098394.ppops.net (m0098394.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 11BJiJD1184706;
        Thu, 11 Feb 2021 14:55:16 -0500
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36nb05r854-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 11 Feb 2021 14:55:16 -0500
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 11BJtD8i020320;
        Thu, 11 Feb 2021 19:55:13 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma06fra.de.ibm.com with ESMTP id 36hjch35k1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 11 Feb 2021 19:55:13 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 11BJtBM041091458
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 11 Feb 2021 19:55:11 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DEC614204D;
        Thu, 11 Feb 2021 19:55:10 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1AF4342049;
        Thu, 11 Feb 2021 19:55:09 +0000 (GMT)
Received: from li-4b5937cc-25c4-11b2-a85c-cea3a66903e4.ibm.com.com (unknown [9.160.81.209])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 11 Feb 2021 19:55:08 +0000 (GMT)
From:   Nayna Jain <nayna@linux.ibm.com>
To:     linux-integrity@vger.kernel.org, keyrings@vger.kernel.org
Cc:     linux-security-module@vger.kernel.org,
        David Howells <dhowells@redhat.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nayna Jain <nayna@linux.ibm.com>
Subject: [PATCH 4/5] keys: define build time generated ephemeral kernel CA key
Date:   Thu, 11 Feb 2021 14:54:34 -0500
Message-Id: <20210211195435.135582-5-nayna@linux.ibm.com>
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

Certificates being loaded onto the IMA trusted keyring must be signed by
a key on either the builtin and secondary trusted keyring.

This patch creates and includes in the kernel image an ephemeral CA
key, at build time when IMA_APPRAISE_MODSIG is enabled.

Signed-off-by: Nayna Jain <nayna@linux.ibm.com>
---
 Makefile                    |  2 ++
 certs/Makefile              | 68 ++++++++++++++++++++++++++++++++++---
 certs/system_certificates.S | 16 ++++++++-
 3 files changed, 80 insertions(+), 6 deletions(-)

diff --git a/Makefile b/Makefile
index 9c87fdd600d8..a1d4b0a1745e 100644
--- a/Makefile
+++ b/Makefile
@@ -1475,6 +1475,8 @@ MRPROPER_FILES += include/config include/generated          \
 		  certs/signing_key.pem certs/signing_key.x509 \
 		  certs/x509.genkey certs/signing_key.key \
 		  certs/signing_key.crt certs/signing_key.csr \
+		  certs/ca_signing_key.pem certs/ca_signing_key.x509 \
+		  certs/ca_signing_key.srl \
 		  vmlinux-gdb.py \
 		  *.spec
 
diff --git a/certs/Makefile b/certs/Makefile
index b2be7eb413d3..c3592ba63a05 100644
--- a/certs/Makefile
+++ b/certs/Makefile
@@ -32,6 +32,14 @@ endif # CONFIG_SYSTEM_TRUSTED_KEYRING
 clean-files := x509_certificate_list .x509.list
 
 ifeq ($(CONFIG_MODULE_SIG),y)
+SIGN_KEY = y
+endif
+
+ifeq ($(CONFIG_IMA_APPRAISE_MODSIG),y)
+SIGN_KEY = y
+endif
+
+ifdef SIGN_KEY
 ###############################################################################
 #
 # If module signing is requested, say by allyesconfig, but a key has not been
@@ -51,6 +59,16 @@ silent_redirect_openssl = 2>/dev/null
 # external private key, because 'make randconfig' might enable such a
 # boolean option and we unfortunately can't make it depend on !RANDCONFIG.
 ifeq ($(CONFIG_MODULE_SIG_KEY),"certs/signing_key.pem")
+
+ifeq ($(CONFIG_IMA_APPRAISE_MODSIG),y)
+# openssl arguments for CA Signed certificate.
+CA_KEY = certs/ca_signing_key.pem
+SIGNER = -CA $(CA_KEY) -CAkey $(CA_KEY) -CAcreateserial
+else
+# openssl arguments for Self Signed certificate.
+SIGNER = -signkey $(obj)/signing_key.key
+endif # CONFIG_IMA_APPRAISE_MODSIG
+
 $(obj)/signing_key.pem: $(obj)/x509.genkey
 	@$(kecho) "###"
 	@$(kecho) "### Now generating an X.509 key pair to be used for signing modules."
@@ -60,14 +78,23 @@ $(obj)/signing_key.pem: $(obj)/x509.genkey
 	@$(kecho) "### needs to be run as root, and uses a hardware random"
 	@$(kecho) "### number generator if one is available."
 	@$(kecho) "###"
+ifeq ($(CONFIG_IMA_APPRAISE_MODSIG),y)
+	# Generate kernel build time CA Certificate.
+	@$(Q)openssl req -new -nodes -utf8 \
+		-$(CONFIG_MODULE_SIG_HASH) -days 36500 \
+		-subj "/CN=Build time autogenerated kernel CA key" \
+		-batch -x509 -config $(obj)/x509.genkey \
+		-outform PEM -out $(CA_KEY) \
+		-keyout $(CA_KEY) -extensions ca_ext \
+		$($(quiet)redirect_openssl)
+endif # CONFIG_IMA_APPRAISE_MODSIG
 	$(Q)openssl req -new -nodes -utf8 \
 		-batch -config $(obj)/x509.genkey \
 		-outform PEM -out $(obj)/signing_key.csr \
 		-keyout $(obj)/signing_key.key -extensions myexts \
 		$($(quiet)redirect_openssl)
 	$(Q)openssl x509 -req -days 36500 -in $(obj)/signing_key.csr \
-		-outform PEM -out $(obj)/signing_key.crt \
-		-signkey $(obj)/signing_key.key \
+		-outform PEM -out $(obj)/signing_key.crt $(SIGNER) \
 		-$(CONFIG_MODULE_SIG_HASH) -extensions myexts \
 		-extfile $(obj)/x509.genkey \
 		$($(quiet)redirect_openssl)
@@ -95,19 +122,50 @@ $(obj)/x509.genkey:
 	@echo >>$@ "keyUsage=digitalSignature"
 	@echo >>$@ "subjectKeyIdentifier=hash"
 	@echo >>$@ "authorityKeyIdentifier=keyid"
+	@echo >>$@
+	@echo >>$@ "[ ca_ext ]"
+	@echo >>$@ "keyUsage=critical,keyCertSign"
+	@echo >>$@ "basicConstraints=critical,CA:TRUE,pathlen:0"
+	@echo >>$@ "subjectKeyIdentifier=hash"
+	@echo >>$@ "authorityKeyIdentifier=keyid"
 endif # CONFIG_MODULE_SIG_KEY
 
 $(eval $(call config_filename,MODULE_SIG_KEY))
+SUBJECT=CN = Build time autogenerated kernel key
+ISSUER=$(shell openssl x509 -in certs/signing_key.crt -noout -issuer)
 
 # If CONFIG_MODULE_SIG_KEY isn't a PKCS#11 URI, depend on it
+
+# GCC PR#66871 again.
+ifeq ($(CONFIG_IMA_APPRAISE_MODSIG),y)
+
+# Remove existing keys if it is self-signed.
+$(if $(findstring $(SUBJECT),$(ISSUER)),$(shell rm -f certs/signing_key.* certs/x509.genkey))
+CA_KEY = certs/ca_signing_key.pem
+
+$(obj)/system_certificates.o: $(obj)/ca_signing_key.x509 $(obj)/signing_key.x509
+
+targets += ca_signing_key.x509
+$(obj)/ca_signing_key.x509: $(obj)/signing_key.x509 scripts/extract-cert FORCE
+	$(call if_changed,extract_certs,$(CA_KEY))
+
+targets += signing_key.x509
+$(obj)/signing_key.x509: $(obj)/signing_key.pem scripts/extract-cert FORCE
+	$(call if_changed,extract_certs,$(MODULE_SIG_KEY_SRCPREFIX)$(CONFIG_MODULE_SIG_KEY))
+else
+
+# Remove existing keys if it is CA signed.
+$(if $(findstring $(SUBJECT),$(ISSUER)),,$(shell rm -f certs/ca_signing_key.* certs/signing_key.* certs/x509.genkey))
+
 ifeq ($(patsubst pkcs11:%,%,$(firstword $(MODULE_SIG_KEY_FILENAME))),$(firstword $(MODULE_SIG_KEY_FILENAME)))
 X509_DEP := $(MODULE_SIG_KEY_SRCPREFIX)$(MODULE_SIG_KEY_FILENAME)
 endif
 
-# GCC PR#66871 again.
 $(obj)/system_certificates.o: $(obj)/signing_key.x509
 
 targets += signing_key.x509
-$(obj)/signing_key.x509: scripts/extract-cert $(X509_DEP) FORCE
+$(obj)/signing_key.x509: certs/signing_key.pem scripts/extract-cert $(X509_DEP) FORCE
 	$(call if_changed,extract_certs,$(MODULE_SIG_KEY_SRCPREFIX)$(CONFIG_MODULE_SIG_KEY))
-endif # CONFIG_MODULE_SIG
+
+endif # CONFIG_IMA_APPRAISE_MODSIG
+endif # SIGN_KEY
diff --git a/certs/system_certificates.S b/certs/system_certificates.S
index 8f29058adf93..e10043800a7e 100644
--- a/certs/system_certificates.S
+++ b/certs/system_certificates.S
@@ -8,8 +8,13 @@
 	.globl system_certificate_list
 system_certificate_list:
 __cert_list_start:
-#ifdef CONFIG_MODULE_SIG
+__module_cert_start:
+#if defined(CONFIG_MODULE_SIG) || defined(CONFIG_IMA_APPRAISE_MODSIG)
 	.incbin "certs/signing_key.x509"
+#endif
+__module_cert_end:
+#ifdef CONFIG_IMA_APPRAISE_MODSIG
+	.incbin "certs/ca_signing_key.x509"
 #endif
 	.incbin "certs/x509_certificate_list"
 __cert_list_end:
@@ -35,3 +40,12 @@ system_certificate_list_size:
 #else
 	.long __cert_list_end - __cert_list_start
 #endif
+
+	.align 8
+	.globl module_cert_size
+	module_cert_size:
+#ifdef CONFIG_64BIT
+	.quad __module_cert_end - __module_cert_start
+#else
+	.long __module_cert_end - __module_cert_start
+#endif
-- 
2.18.1

