Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A63676EE54E
	for <lists+linux-integrity@lfdr.de>; Tue, 25 Apr 2023 18:11:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234700AbjDYQLB (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 25 Apr 2023 12:11:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234477AbjDYQKv (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 25 Apr 2023 12:10:51 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B27A15470
        for <linux-integrity@vger.kernel.org>; Tue, 25 Apr 2023 09:10:49 -0700 (PDT)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33PG8uLl029953
        for <linux-integrity@vger.kernel.org>; Tue, 25 Apr 2023 16:10:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=/oiWxKbEcjblk4iiJXxLkyn95x7AYvkxP/xAs8xlWKg=;
 b=NdkRMggI2Xm2dpc9Eco7quEIc25xd3q4d2spbxd/HlQK3WFtPF0FnO5CIfpFqXOSYBu7
 zrgmcNE21Evg80y1C+Zyp33LZ/ixqRep4qQvmYZT/6C74Bq/uFJShSIABHp+QolRNc6h
 vfkeWQ+T3rBBwyQwc1+Y2qu/Z/PftolPTzPNI3p5DZhhfNva/6phmkgi/gfTOq9SB+gV
 rS7qrjc4dkCgLgFolMPhCROuBkqhBh5Gn5nD7+4mfvgxtvMzPjq+YCuda0rD1aDr5cVb
 MCLNMKki497Ble2zK3rvQmyMzMPkm3k9ILu2tT1MRI8vmsns7WkfumUJMSqlMa/Szq1r jQ== 
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com [169.47.144.26])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3q6hr40wbn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Tue, 25 Apr 2023 16:10:46 +0000
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
        by ppma04wdc.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 33PFCGZ5014344
        for <linux-integrity@vger.kernel.org>; Tue, 25 Apr 2023 16:10:22 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([9.208.129.114])
        by ppma04wdc.us.ibm.com (PPS) with ESMTPS id 3q4777s26y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Tue, 25 Apr 2023 16:10:22 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
        by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 33PGAKJb36962842
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Apr 2023 16:10:20 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6A9C458061;
        Tue, 25 Apr 2023 16:10:20 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2AE7F58058;
        Tue, 25 Apr 2023 16:10:20 +0000 (GMT)
Received: from sbct-2.pok.ibm.com (unknown [9.47.158.152])
        by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Tue, 25 Apr 2023 16:10:20 +0000 (GMT)
From:   Stefan Berger <stefanb@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     zohar@linux.ibm.com, Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH ima-evm-utils v2 2/2] examples: Add examples for elliptic curve key and certs generation
Date:   Tue, 25 Apr 2023 12:10:15 -0400
Message-Id: <20230425161015.593988-3-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230425161015.593988-1-stefanb@linux.ibm.com>
References: <20230425161015.593988-1-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 9CXNFor3eqUwZbhS-SBdz-4tYdW0KJkm
X-Proofpoint-GUID: 9CXNFor3eqUwZbhS-SBdz-4tYdW0KJkm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-25_07,2023-04-25_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 priorityscore=1501
 impostorscore=0 phishscore=0 adultscore=0 mlxlogscore=997 suspectscore=0
 clxscore=1015 spamscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2304250144
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Add example scripts for ECC key and certificate creation and reference
them from the README.

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 README                           |  3 +++
 examples/ima-gen-local-ca-ecc.sh | 29 ++++++++++++++++++++++++++++
 examples/ima-genkey-ecc.sh       | 33 ++++++++++++++++++++++++++++++++
 examples/ima-genkey-self-ecc.sh  | 29 ++++++++++++++++++++++++++++
 4 files changed, 94 insertions(+)
 create mode 100755 examples/ima-gen-local-ca-ecc.sh
 create mode 100755 examples/ima-genkey-ecc.sh
 create mode 100755 examples/ima-genkey-self-ecc.sh

diff --git a/README b/README
index fd12680..ef7f475 100644
--- a/README
+++ b/README
@@ -469,6 +469,9 @@ Examples of scripts to generate X509 public key certificates:
  /usr/share/doc/ima-evm-utils/ima-genkey-self.sh
  /usr/share/doc/ima-evm-utils/ima-genkey.sh
  /usr/share/doc/ima-evm-utils/ima-gen-local-ca.sh
+ /usr/share/doc/ima-evm-utils/ima-genkey-self-ecc.sh
+ /usr/share/doc/ima-evm-utils/ima-genkey-ecc.sh
+ /usr/share/doc/ima-evm-utils/ima-gen-local-ca-ecc.sh
 
 
 AUTHOR
diff --git a/examples/ima-gen-local-ca-ecc.sh b/examples/ima-gen-local-ca-ecc.sh
new file mode 100755
index 0000000..ee2aeb6
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
+# keyUsage = cRLSign, keyCertSign
+__EOF__
+
+openssl req -new -x509 -utf8 -sha1 -days 3650 -batch -config $GENKEY \
+		-outform DER -out ima-local-ca.x509 -keyout ima-local-ca.priv \
+		-newkey ec -pkeyopt ec_paramgen_curve:prime256v1
+
+openssl x509 -inform DER -in ima-local-ca.x509 -out ima-local-ca.pem
+
diff --git a/examples/ima-genkey-ecc.sh b/examples/ima-genkey-ecc.sh
new file mode 100755
index 0000000..735c665
--- /dev/null
+++ b/examples/ima-genkey-ecc.sh
@@ -0,0 +1,33 @@
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
+subjectKeyIdentifier=hash
+authorityKeyIdentifier=keyid
+#authorityKeyIdentifier=keyid,issuer
+__EOF__
+
+openssl req -new -nodes -utf8 -sha1 -days 365 -batch -config $GENKEY \
+		-out csr_ima.pem -keyout privkey_ima.pem \
+		-newkey ec -pkeyopt ec_paramgen_curve:prime256v1
+openssl x509 -req -in csr_ima.pem -days 365 -extfile $GENKEY -extensions v3_usr \
+		-CA ima-local-ca.pem -CAkey ima-local-ca.priv -CAcreateserial \
+		-outform DER -out x509_ima.der
+
diff --git a/examples/ima-genkey-self-ecc.sh b/examples/ima-genkey-self-ecc.sh
new file mode 100755
index 0000000..3d8f11f
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
+openssl req -x509 -new -nodes -utf8 -sha1 -days 3650 -batch -config $GENKEY \
+		-outform DER -out x509_evm.der -keyout privkey_evm.pem \
+		-newkey ec -pkeyopt ec_paramgen_curve:prime256v1
+
+openssl ec -pubout -in privkey_evm.pem -out pubkey_evm.pem
+
-- 
2.39.2

