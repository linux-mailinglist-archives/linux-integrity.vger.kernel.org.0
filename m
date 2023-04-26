Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88A396EFD3E
	for <lists+linux-integrity@lfdr.de>; Thu, 27 Apr 2023 00:37:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233641AbjDZWh3 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 26 Apr 2023 18:37:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229889AbjDZWh1 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 26 Apr 2023 18:37:27 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C06C35B3
        for <linux-integrity@vger.kernel.org>; Wed, 26 Apr 2023 15:37:21 -0700 (PDT)
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33QM8B4D030389
        for <linux-integrity@vger.kernel.org>; Wed, 26 Apr 2023 22:37:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=QjpZQUmmpuJinS6mejsnGUA8Cr1q5JDmmhDlcH9volY=;
 b=TpqspV1BvTgzX31sxUizH8PxvvultBcVzmoNwew5PTr7wfN5yfYkXjhIqGRCkyrn/TDA
 zpj2tToOP/r6u714YYKjXgOsopI8ghSZk+3v9OwIOgps7dpC0BA28Z0rsRrRV31w2KZy
 8XkqkSR2wNeKYh8g8NAE/NRnEcG+pdTz6d/9ReJIGvC2cMayqOIX8JV7ws6q8EjUyMD+
 NvuVYF7Ft+I/pEMSs4v/OQRQ2+qZw1BU8XsWSILV8isFvRsY4rRvthm1pd4FW8ZR6sJ4
 3Y6B1BF1vAY24f79JCwJsET8lCywyZoJ2vXFInBA0MN7aKgjZWoDJZdwS0hKh9FTBPN2 NQ== 
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com [169.47.144.26])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3q7bnhj5hh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Wed, 26 Apr 2023 22:37:17 +0000
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
        by ppma04wdc.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 33QKL31N032073
        for <linux-integrity@vger.kernel.org>; Wed, 26 Apr 2023 22:36:05 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([9.208.129.113])
        by ppma04wdc.us.ibm.com (PPS) with ESMTPS id 3q4777yhn0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Wed, 26 Apr 2023 22:36:05 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
        by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 33QMa4LH33358194
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Apr 2023 22:36:04 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 327FC58054;
        Wed, 26 Apr 2023 22:36:04 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BCF6E58060;
        Wed, 26 Apr 2023 22:36:03 +0000 (GMT)
Received: from sbct-2.pok.ibm.com (unknown [9.47.158.152])
        by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 26 Apr 2023 22:36:03 +0000 (GMT)
From:   Stefan Berger <stefanb@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     zohar@linux.ibm.com, Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH ima-evm-utils v3 4/4] Add example scripts for EC key and certs generation
Date:   Wed, 26 Apr 2023 18:35:59 -0400
Message-Id: <20230426223559.681668-5-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230426223559.681668-1-stefanb@linux.ibm.com>
References: <20230426223559.681668-1-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: jPmGo0_NDVHvJb-TnsMfH-4rr2NSlWCn
X-Proofpoint-ORIG-GUID: jPmGo0_NDVHvJb-TnsMfH-4rr2NSlWCn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-26_10,2023-04-26_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 clxscore=1015
 spamscore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0 malwarescore=0
 priorityscore=1501 impostorscore=0 mlxlogscore=999 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2304260195
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Add example scripts for EC key and certificate creation and reference
them from the README and Makefile.am.

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 Makefile.am                      |  8 +++++++-
 README                           |  3 +++
 examples/ima-gen-local-ca-ecc.sh | 29 +++++++++++++++++++++++++++
 examples/ima-genkey-ecc.sh       | 34 ++++++++++++++++++++++++++++++++
 examples/ima-genkey-self-ecc.sh  | 29 +++++++++++++++++++++++++++
 5 files changed, 102 insertions(+), 1 deletion(-)
 create mode 100755 examples/ima-gen-local-ca-ecc.sh
 create mode 100755 examples/ima-genkey-ecc.sh
 create mode 100755 examples/ima-genkey-self-ecc.sh

diff --git a/Makefile.am b/Makefile.am
index e686d65..9ec5681 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -7,7 +7,13 @@ if MANPAGE_DOCBOOK_XSL
 dist_man_MANS = evmctl.1
 endif
 
-doc_DATA =  examples/ima-genkey-self.sh examples/ima-genkey.sh examples/ima-gen-local-ca.sh
+doc_DATA = \
+	 examples/ima-genkey-self.sh \
+	 examples/ima-genkey.sh \
+	 examples/ima-gen-local-ca.sh \
+	 examples/ima-genkey-self-ecc.sh \
+	 examples/ima-genkey-ecc.sh \
+	 examples/ima-gen-local-ca-ecc.sh
 EXTRA_DIST = autogen.sh $(doc_DATA)
 
 CLEANFILES = *.html *.xsl
diff --git a/README b/README
index d631eb7..40a61f9 100644
--- a/README
+++ b/README
@@ -470,6 +470,9 @@ Examples of scripts to generate X509 public key certificates:
  /usr/share/doc/ima-evm-utils/ima-genkey-self.sh
  /usr/share/doc/ima-evm-utils/ima-genkey.sh
  /usr/share/doc/ima-evm-utils/ima-gen-local-ca.sh
+ /usr/share/doc/ima-evm-utils/ima-genkey-self-ecc.sh
+ /usr/share/doc/ima-evm-utils/ima-genkey-ecc.sh
+ /usr/share/doc/ima-evm-utils/ima-gen-local-ca-ecc.sh
 
 
 AUTHOR
diff --git a/examples/ima-gen-local-ca-ecc.sh b/examples/ima-gen-local-ca-ecc.sh
new file mode 100755
index 0000000..1f17bcf
--- /dev/null
+++ b/examples/ima-gen-local-ca-ecc.sh
@@ -0,0 +1,29 @@
+#!/bin/sh
+
+GENKEY=ima-local-ca.genkey
+
+cat << __EOF__ >$GENKEY
+[ req ]
+distinguished_name = req_distinguished_name
+prompt = no
+string_mask = utf8only
+x509_extensions = v3_ca
+
+[ req_distinguished_name ]
+O = IMA-CA
+CN = IMA/EVM certificate signing key
+emailAddress = ca@ima-ca
+
+[ v3_ca ]
+basicConstraints=CA:TRUE
+subjectKeyIdentifier=hash
+authorityKeyIdentifier=keyid:always,issuer
+keyUsage = cRLSign, keyCertSign
+__EOF__
+
+openssl req -new -x509 -utf8 -sha256 -days 3650 -batch -config $GENKEY \
+		-outform DER -out ima-local-ca.x509 -keyout ima-local-ca.priv \
+		-newkey ec -pkeyopt ec_paramgen_curve:prime256v1
+
+openssl x509 -inform DER -in ima-local-ca.x509 -out ima-local-ca.pem
+
diff --git a/examples/ima-genkey-ecc.sh b/examples/ima-genkey-ecc.sh
new file mode 100755
index 0000000..bdc8d17
--- /dev/null
+++ b/examples/ima-genkey-ecc.sh
@@ -0,0 +1,34 @@
+#!/bin/sh
+
+GENKEY=ima.genkey
+
+cat << __EOF__ >$GENKEY
+[ req ]
+distinguished_name = req_distinguished_name
+prompt = no
+string_mask = utf8only
+x509_extensions = v3_usr
+
+[ req_distinguished_name ]
+O = `hostname`
+CN = `whoami` signing key
+emailAddress = `whoami`@`hostname`
+
+[ v3_usr ]
+basicConstraints=critical,CA:FALSE
+#basicConstraints=CA:FALSE
+keyUsage=digitalSignature
+#keyUsage = nonRepudiation, digitalSignature, keyEncipherment
+extendedKeyUsage=critical,codeSigning
+subjectKeyIdentifier=hash
+authorityKeyIdentifier=keyid
+#authorityKeyIdentifier=keyid,issuer
+__EOF__
+
+openssl req -new -nodes -utf8 -sha256 -days 365 -batch -config $GENKEY \
+		-out csr_ima.pem -keyout privkey_ima.pem \
+		-newkey ec -pkeyopt ec_paramgen_curve:prime256v1
+openssl x509 -req -in csr_ima.pem -days 365 -extfile $GENKEY -extensions v3_usr \
+		-CA ima-local-ca.pem -CAkey ima-local-ca.priv -CAcreateserial \
+		-outform DER -out x509_ima.der
+
diff --git a/examples/ima-genkey-self-ecc.sh b/examples/ima-genkey-self-ecc.sh
new file mode 100755
index 0000000..b5431e2
--- /dev/null
+++ b/examples/ima-genkey-self-ecc.sh
@@ -0,0 +1,29 @@
+#!/bin/sh
+
+GENKEY=x509_evm.genkey
+
+cat << __EOF__ >$GENKEY
+[ req ]
+distinguished_name = req_distinguished_name
+prompt = no
+string_mask = utf8only
+x509_extensions = myexts
+
+[ req_distinguished_name ]
+O = `hostname`
+CN = `whoami` signing key
+emailAddress = `whoami`@`hostname`
+
+[ myexts ]
+basicConstraints=critical,CA:FALSE
+keyUsage=digitalSignature
+subjectKeyIdentifier=hash
+authorityKeyIdentifier=keyid
+__EOF__
+
+openssl req -x509 -new -nodes -utf8 -sha256 -days 3650 -batch -config $GENKEY \
+		-outform DER -out x509_evm.der -keyout privkey_evm.pem \
+		-newkey ec -pkeyopt ec_paramgen_curve:prime256v1
+
+openssl ec -pubout -in privkey_evm.pem -out pubkey_evm.pem
+
-- 
2.39.2

