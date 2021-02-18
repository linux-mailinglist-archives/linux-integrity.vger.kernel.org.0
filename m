Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA02931F202
	for <lists+linux-integrity@lfdr.de>; Thu, 18 Feb 2021 23:03:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230160AbhBRWCO (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 18 Feb 2021 17:02:14 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:1411 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230122AbhBRWBt (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 18 Feb 2021 17:01:49 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 11IM0ipB159882;
        Thu, 18 Feb 2021 17:00:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=o/P4rb7HYu57ssuVl1LBxKPDr70tc9GhDGkWWdWnze4=;
 b=UzRtSAahWPWbfKdUYbK0cLsHY000dUiRo56ffObAYvy49plnxgwk96AADegiSTrzyHR0
 pwi0jFo5Zdv6kJ1jwJ3yZ43QqUjutptakCUS3ZP3hO0CqPDLQ0+QZ+qFDj8dsnt3vpro
 483OBmfy9pjaxVh/5WgzJeEBo92gk6mLnFOvjsThKhSMx61xZsQxhrDj9kHDPeV4gz2z
 QbihZI3zacucWFlnaiC+RKL5Y6mEljfFcOq3q/Ci7YamSGXNDmlHc/IumYIdfjPFHCn8
 xrLBw3tNsM6sYg17DoqXAFq7DMQRnl1LP564v9gpEKIPm8YgfDBSmbEOjAi0KUpEeib1 jA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36t0mc02g3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 Feb 2021 17:00:54 -0500
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 11IM0saJ160666;
        Thu, 18 Feb 2021 17:00:54 -0500
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36t0mc02ew-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 Feb 2021 17:00:54 -0500
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 11ILrtXj028364;
        Thu, 18 Feb 2021 22:00:51 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma02fra.de.ibm.com with ESMTP id 36p6d8jmvw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 Feb 2021 22:00:51 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 11IM0n5f38142422
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 Feb 2021 22:00:49 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EFDA64C052;
        Thu, 18 Feb 2021 22:00:48 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D021C4C050;
        Thu, 18 Feb 2021 22:00:46 +0000 (GMT)
Received: from li-4b5937cc-25c4-11b2-a85c-cea3a66903e4.ibm.com.com (unknown [9.211.90.194])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 18 Feb 2021 22:00:46 +0000 (GMT)
From:   Nayna Jain <nayna@linux.ibm.com>
To:     linux-integrity@vger.kernel.org, keyrings@vger.kernel.org
Cc:     linux-security-module@vger.kernel.org,
        David Howells <dhowells@redhat.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Stefan Berger <stefanb@linux.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nayna Jain <nayna@linux.ibm.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH v2 4/5] keys: define build time generated ephemeral kernel CA key
Date:   Thu, 18 Feb 2021 17:00:10 -0500
Message-Id: <20210218220011.67625-5-nayna@linux.ibm.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210218220011.67625-1-nayna@linux.ibm.com>
References: <20210218220011.67625-1-nayna@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-02-18_09:2021-02-18,2021-02-18 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 impostorscore=0
 bulkscore=0 priorityscore=1501 mlxscore=0 spamscore=0 clxscore=1011
 malwarescore=0 lowpriorityscore=0 suspectscore=0 mlxlogscore=999
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102180178
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Certificates being loaded onto the IMA trusted keyring must be signed by
a key on either the builtin or secondary trusted keyring. Create and
include in the kernel image an ephemeral CA key at build time when
IMA_APPRAISE_MODSIG is enabled.

Reported-by: kernel test robot <lkp@intel.com> (redirect openssl stderr)
Signed-off-by: Nayna Jain <nayna@linux.ibm.com>
---
 Makefile                    |  2 ++
 certs/Makefile              | 68 ++++++++++++++++++++++++++++++++++---
 certs/system_certificates.S | 16 ++++++++-
 3 files changed, 80 insertions(+), 6 deletions(-)

diff --git a/Makefile b/Makefile
index a971d4ae40bd..15e8344836b1 100644
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
index b2be7eb413d3..3fe6b73786fa 100644
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
+ISSUER=$(shell openssl x509 -in certs/signing_key.crt -noout -issuer $($(quiet)redirect_openssl))
 
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
2.29.2

