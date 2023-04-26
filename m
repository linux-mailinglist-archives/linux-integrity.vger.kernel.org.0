Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C5746EFD31
	for <lists+linux-integrity@lfdr.de>; Thu, 27 Apr 2023 00:36:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232343AbjDZWgO (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 26 Apr 2023 18:36:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229889AbjDZWgN (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 26 Apr 2023 18:36:13 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C08C7E6A
        for <linux-integrity@vger.kernel.org>; Wed, 26 Apr 2023 15:36:12 -0700 (PDT)
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33QMZhxg021981
        for <linux-integrity@vger.kernel.org>; Wed, 26 Apr 2023 22:36:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=y0XoGXPyyxwDmcA+UwwU2jMHsgVU/p5tb072VvlWO+4=;
 b=ZQkIyGrvlOLV5oRBIMX9yVzP8BcEvErRQ2nmxcMF9/khOUQ0mPNAFde+sYvsu00t8ad1
 D3FYGlFqNKgQ8Qm3fmcSQ91Uv1FR0Q32F+M50/J7pZl9E5BT7mYY1y3mM919dXc9rae2
 VSJGjZa7Xq1waLLdbXwEGRC/lPL7+4UTF0BHFwPVYA/va1+uLCj3DUumkVSovs2J5L8Y
 lpyE2KL2dDW4BfS/VNqPDHFCwCjm9GcPa4W5Dqt4ovlsWbb3P2bCcjO2zVXtt2qRY0Vp
 sj6SdajmuwLxy1qc15xZ+DG7OSDEia878+vuLYv4SMKohMebPvxeDEMqUysmGRFYkKnC 7g== 
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com [169.63.121.186])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3q7chyggy0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Wed, 26 Apr 2023 22:36:09 +0000
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
        by ppma03wdc.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 33QK7l3O000734
        for <linux-integrity@vger.kernel.org>; Wed, 26 Apr 2023 22:36:04 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([9.208.129.120])
        by ppma03wdc.us.ibm.com (PPS) with ESMTPS id 3q47787hb4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Wed, 26 Apr 2023 22:36:04 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
        by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 33QMa3JQ36700548
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Apr 2023 22:36:03 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F038358062;
        Wed, 26 Apr 2023 22:36:02 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 906C458066;
        Wed, 26 Apr 2023 22:36:02 +0000 (GMT)
Received: from sbct-2.pok.ibm.com (unknown [9.47.158.152])
        by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 26 Apr 2023 22:36:02 +0000 (GMT)
From:   Stefan Berger <stefanb@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     zohar@linux.ibm.com, Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH ima-evm-utils v3 2/4] Update OpenSSL config files for support for .machine keyring
Date:   Wed, 26 Apr 2023 18:35:57 -0400
Message-Id: <20230426223559.681668-3-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230426223559.681668-1-stefanb@linux.ibm.com>
References: <20230426223559.681668-1-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: MkhfdtUYx8-dUhgrQyyy20M2NBi5FLdz
X-Proofpoint-ORIG-GUID: MkhfdtUYx8-dUhgrQyyy20M2NBi5FLdz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-26_10,2023-04-26_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 suspectscore=0 bulkscore=0 mlxlogscore=999 clxscore=1015 adultscore=0
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

Update the OpenSSL config files for support for loading certs onto
the .machine keyring where certain key usage flags must be set.

Also update the OpenSSL config files shown in the README.

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 README                       | 3 ++-
 examples/ima-gen-local-ca.sh | 2 +-
 examples/ima-genkey.sh       | 1 +
 3 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/README b/README
index ae92f95..9e47eaf 100644
--- a/README
+++ b/README
@@ -235,6 +235,7 @@ Configuration file x509_evm.genkey:
 	[ myexts ]
 	basicConstraints=critical,CA:FALSE
 	keyUsage=digitalSignature
+	extendedKeyUsage=critical,codeSigning
 	subjectKeyIdentifier=hash
 	authorityKeyIdentifier=keyid
 	# EOF
@@ -287,7 +288,7 @@ Configuration file ima-local-ca.genkey:
 	basicConstraints=CA:TRUE
 	subjectKeyIdentifier=hash
 	authorityKeyIdentifier=keyid:always,issuer
-	# keyUsage = cRLSign, keyCertSign
+	keyUsage = cRLSign, keyCertSign
 	# EOF
 
 Generate private key and X509 public key certificate:
diff --git a/examples/ima-gen-local-ca.sh b/examples/ima-gen-local-ca.sh
index 055463c..6fd4997 100755
--- a/examples/ima-gen-local-ca.sh
+++ b/examples/ima-gen-local-ca.sh
@@ -19,7 +19,7 @@ emailAddress = ca@ima-ca
 basicConstraints=CA:TRUE
 subjectKeyIdentifier=hash
 authorityKeyIdentifier=keyid:always,issuer
-# keyUsage = cRLSign, keyCertSign
+keyUsage = cRLSign, keyCertSign
 __EOF__
 
 openssl req -new -x509 -utf8 -sha256 -days 3650 -batch -config $GENKEY \
diff --git a/examples/ima-genkey.sh b/examples/ima-genkey.sh
index c09205a..00fa648 100755
--- a/examples/ima-genkey.sh
+++ b/examples/ima-genkey.sh
@@ -20,6 +20,7 @@ basicConstraints=critical,CA:FALSE
 #basicConstraints=CA:FALSE
 keyUsage=digitalSignature
 #keyUsage = nonRepudiation, digitalSignature, keyEncipherment
+extendedKeyUsage=critical,codeSigning
 subjectKeyIdentifier=hash
 authorityKeyIdentifier=keyid
 #authorityKeyIdentifier=keyid,issuer
-- 
2.39.2

