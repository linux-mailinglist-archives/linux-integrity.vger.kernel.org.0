Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4558A6EFD2F
	for <lists+linux-integrity@lfdr.de>; Thu, 27 Apr 2023 00:36:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233315AbjDZWgK (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 26 Apr 2023 18:36:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233180AbjDZWgJ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 26 Apr 2023 18:36:09 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A8B6187
        for <linux-integrity@vger.kernel.org>; Wed, 26 Apr 2023 15:36:07 -0700 (PDT)
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33QMZlYk022235
        for <linux-integrity@vger.kernel.org>; Wed, 26 Apr 2023 22:36:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=6xIODLFD2HglC+haoNwg7H0oVpZhbf0xpMMd8y9AsuI=;
 b=q9PKQc95BIjvZWH+Nri0Yo9TULR/0rtObc2LHwW2nObYzEA73ymejZkBoe39z9M0XfO6
 BcKEM38djCxmHBkIgD+T9B1rynooTRLH+WhD5haHPt45o0Vf5vkI6EOFZUHCKkwj+nNN
 Mq04S2z7C1dxqPsxeDo21yCnbMSXWBYOZrxMDjTomRNJB8CdoUv9cJ1eY7vSIXkb54Wx
 T2kgHDcvdn8Mz8e2kPiAKYAwufPe0+TZVWScu2K/9d72ev2OH1M8vEb/FXaS763fCLCU
 iVTWHqNK3NOUkvdKPGY7lIJk/aOxdoS1VAzg8E58mcc5grbonixi5FYpqmYN1lUjbOeK 2Q== 
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com [169.55.85.253])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3q7chyggx5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Wed, 26 Apr 2023 22:36:06 +0000
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
        by ppma01wdc.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 33QKLJJi012999
        for <linux-integrity@vger.kernel.org>; Wed, 26 Apr 2023 22:36:04 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([9.208.129.119])
        by ppma01wdc.us.ibm.com (PPS) with ESMTPS id 3q47787gsy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Wed, 26 Apr 2023 22:36:04 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
        by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 33QMa2O724183362
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Apr 2023 22:36:02 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 69B2258060;
        Wed, 26 Apr 2023 22:36:02 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 000D058062;
        Wed, 26 Apr 2023 22:36:01 +0000 (GMT)
Received: from sbct-2.pok.ibm.com (unknown [9.47.158.152])
        by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 26 Apr 2023 22:36:01 +0000 (GMT)
From:   Stefan Berger <stefanb@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     zohar@linux.ibm.com, Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH ima-evm-utils v3 1/4] Update default key sizes and hash to up-to-date values
Date:   Wed, 26 Apr 2023 18:35:56 -0400
Message-Id: <20230426223559.681668-2-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230426223559.681668-1-stefanb@linux.ibm.com>
References: <20230426223559.681668-1-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: WQId2K81-8yl7kYBl6h6T33BP5W36c1v
X-Proofpoint-ORIG-GUID: WQId2K81-8yl7kYBl6h6T33BP5W36c1v
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-26_10,2023-04-26_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 suspectscore=0 bulkscore=0 mlxlogscore=725 clxscore=1015 adultscore=0
 impostorscore=0 phishscore=0 spamscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304260195
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Update the documentation and example scripts to use 2048 bit RSA keys
and sha256.

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 README                       | 14 +++++++-------
 examples/ima-gen-local-ca.sh |  2 +-
 examples/ima-genkey-self.sh  |  4 ++--
 examples/ima-genkey.sh       |  4 ++--
 4 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/README b/README
index 75e4fd2..ae92f95 100644
--- a/README
+++ b/README
@@ -200,11 +200,11 @@ Generate signing and verification keys
 
 Generate private key in plain text format:
 
-    openssl genrsa -out privkey_evm.pem 1024
+    openssl genrsa -out privkey_evm.pem 2048
 
 Generate encrypted private key:
 
-    openssl genrsa -des3 -out privkey_evm.pem 1024
+    openssl genrsa -des3 -out privkey_evm.pem 2048
 
 Make encrypted private key from unencrypted:
 
@@ -213,7 +213,7 @@ Make encrypted private key from unencrypted:
 Generate self-signed X509 public key certificate and private key for using kernel
 asymmetric keys support:
 
-    openssl req -new -nodes -utf8 -sha1 -days 36500 -batch \
+    openssl req -new -nodes -utf8 -sha256 -days 36500 -batch \
     	        -x509 -config x509_evm.genkey \
 	        -outform DER -out x509_evm.der -keyout privkey_evm.pem
 
@@ -221,7 +221,7 @@ Configuration file x509_evm.genkey:
 
 	# Beginning of the file
 	[ req ]
-	default_bits = 1024
+	default_bits = 2048
 	distinguished_name = req_distinguished_name
 	prompt = no
 	string_mask = utf8only
@@ -292,7 +292,7 @@ Configuration file ima-local-ca.genkey:
 
 Generate private key and X509 public key certificate:
 
- openssl req -new -x509 -utf8 -sha1 -days 3650 -batch -config $GENKEY \
+ openssl req -new -x509 -utf8 -sha256 -days 3650 -batch -config $GENKEY \
              -outform DER -out ima-local-ca.x509 -keyout ima-local-ca.priv
 
 Produce X509 in DER format for using while building the kernel:
@@ -303,7 +303,7 @@ Configuration file ima.genkey:
 
 	# Beginning of the file
 	[ req ]
-	default_bits = 1024
+	default_bits = 2048
 	distinguished_name = req_distinguished_name
 	prompt = no
 	string_mask = utf8only
@@ -327,7 +327,7 @@ Configuration file ima.genkey:
 
 Generate private key and X509 public key certificate signing request:
 
- openssl req -new -nodes -utf8 -sha1 -days 365 -batch -config $GENKEY \
+ openssl req -new -nodes -utf8 -sha256 -days 365 -batch -config $GENKEY \
              -out csr_ima.pem -keyout privkey_ima.pem
 
 Sign X509 public key certificate signing request with local IMA CA private key:
diff --git a/examples/ima-gen-local-ca.sh b/examples/ima-gen-local-ca.sh
index 1f24949..055463c 100755
--- a/examples/ima-gen-local-ca.sh
+++ b/examples/ima-gen-local-ca.sh
@@ -22,7 +22,7 @@ authorityKeyIdentifier=keyid:always,issuer
 # keyUsage = cRLSign, keyCertSign
 __EOF__
 
-openssl req -new -x509 -utf8 -sha1 -days 3650 -batch -config $GENKEY \
+openssl req -new -x509 -utf8 -sha256 -days 3650 -batch -config $GENKEY \
 		-outform DER -out ima-local-ca.x509 -keyout ima-local-ca.priv
 
 openssl x509 -inform DER -in ima-local-ca.x509 -out ima-local-ca.pem
diff --git a/examples/ima-genkey-self.sh b/examples/ima-genkey-self.sh
index e293b94..c04df37 100755
--- a/examples/ima-genkey-self.sh
+++ b/examples/ima-genkey-self.sh
@@ -4,7 +4,7 @@ GENKEY=x509_evm.genkey
 
 cat << __EOF__ >$GENKEY
 [ req ]
-default_bits = 1024
+default_bits = 2048
 distinguished_name = req_distinguished_name
 prompt = no
 string_mask = utf8only
@@ -22,7 +22,7 @@ subjectKeyIdentifier=hash
 authorityKeyIdentifier=keyid
 __EOF__
 
-openssl req -x509 -new -nodes -utf8 -sha1 -days 3650 -batch -config $GENKEY \
+openssl req -x509 -new -nodes -utf8 -sha256 -days 3650 -batch -config $GENKEY \
 		-outform DER -out x509_evm.der -keyout privkey_evm.pem
 
 openssl rsa -pubout -in privkey_evm.pem -out pubkey_evm.pem
diff --git a/examples/ima-genkey.sh b/examples/ima-genkey.sh
index b08778f..c09205a 100755
--- a/examples/ima-genkey.sh
+++ b/examples/ima-genkey.sh
@@ -4,7 +4,7 @@ GENKEY=ima.genkey
 
 cat << __EOF__ >$GENKEY
 [ req ]
-default_bits = 1024
+default_bits = 2048
 distinguished_name = req_distinguished_name
 prompt = no
 string_mask = utf8only
@@ -25,7 +25,7 @@ authorityKeyIdentifier=keyid
 #authorityKeyIdentifier=keyid,issuer
 __EOF__
 
-openssl req -new -nodes -utf8 -sha1 -days 365 -batch -config $GENKEY \
+openssl req -new -nodes -utf8 -sha256 -days 365 -batch -config $GENKEY \
 		-out csr_ima.pem -keyout privkey_ima.pem
 openssl x509 -req -in csr_ima.pem -days 365 -extfile $GENKEY -extensions v3_usr \
 		-CA ima-local-ca.pem -CAkey ima-local-ca.priv -CAcreateserial \
-- 
2.39.2

