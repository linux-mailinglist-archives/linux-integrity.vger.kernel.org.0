Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 657C76EFD30
	for <lists+linux-integrity@lfdr.de>; Thu, 27 Apr 2023 00:36:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233180AbjDZWgK (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 26 Apr 2023 18:36:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229889AbjDZWgK (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 26 Apr 2023 18:36:10 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A537E6A
        for <linux-integrity@vger.kernel.org>; Wed, 26 Apr 2023 15:36:08 -0700 (PDT)
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33QMUO6m012291
        for <linux-integrity@vger.kernel.org>; Wed, 26 Apr 2023 22:36:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=BIvpIuzaOxfO82cI312mhA4CfWg60slJlzKrWtG8u8A=;
 b=Sg3ofaRrwlpD8jY2T+2NBnB50KKSRny8NsRPsblDTmSRt7gMFSKyrLG5RszRsejRPVjW
 VKdksQ4o38IQ0TtqTSPKyGAt0952YqBezggXv5nIOL8i58PiSY7EDP+DBiTlsUUl9r4/
 retpQ1yrxf5CeFlvae65Yk3KJOtakI3zXvVh2kk4VAfeVT0atXL4kXbCUMFsAthtgx/a
 Vh/6kEW3KnaZpr0cia04KgRO2nJiQDDA/KUHUtD9ySae9OgmXXDOR5rHWZhRw+IRe2NI
 0sbpD812ahGfhaiynBnmny1zj3UtxBBwrP/4d5Rqr2WKvkTQy5GwHeRsuYrN1XhuQcZT 6A== 
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com [169.47.144.26])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3q7chyggyn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Wed, 26 Apr 2023 22:36:07 +0000
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
        by ppma04wdc.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 33QKAROH032079
        for <linux-integrity@vger.kernel.org>; Wed, 26 Apr 2023 22:36:05 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([9.208.129.120])
        by ppma04wdc.us.ibm.com (PPS) with ESMTPS id 3q4777yhmy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Wed, 26 Apr 2023 22:36:05 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
        by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 33QMa3xp36569506
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Apr 2023 22:36:03 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9616F58064;
        Wed, 26 Apr 2023 22:36:03 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2CAAB58056;
        Wed, 26 Apr 2023 22:36:03 +0000 (GMT)
Received: from sbct-2.pok.ibm.com (unknown [9.47.158.152])
        by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 26 Apr 2023 22:36:03 +0000 (GMT)
From:   Stefan Berger <stefanb@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     zohar@linux.ibm.com, Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH ima-evm-utils v3 3/4] Add openssl command line examples for creation of EC keys
Date:   Wed, 26 Apr 2023 18:35:58 -0400
Message-Id: <20230426223559.681668-4-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230426223559.681668-1-stefanb@linux.ibm.com>
References: <20230426223559.681668-1-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: hjF2-LcHDQvv2aSQHbR6rje_J4Wt7hPw
X-Proofpoint-ORIG-GUID: hjF2-LcHDQvv2aSQHbR6rje_J4Wt7hPw
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
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Add openssl command line examples for creation of EC keys for EVM and IMA
CA and signing key.

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 README | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/README b/README
index 9e47eaf..d631eb7 100644
--- a/README
+++ b/README
@@ -217,6 +217,18 @@ asymmetric keys support:
     	        -x509 -config x509_evm.genkey \
 	        -outform DER -out x509_evm.der -keyout privkey_evm.pem
 
+Create an elliptic curve (EC) key (supported since Linux v5.13)
+
+    openssl ecparam -name prime256v1 -genkey -out privkey_evm.pem
+
+Generate self-signed x509 EC public key certificate and private key for using
+kernel asymmetric key support (supported since Linux v5.13):
+
+   openssl req -new -nodes -utf8 -sha1 -days 36500 -batch \
+                -x509 -config x509_evm.genkey \
+                -outform DER -out x509_evm.der -keyout privkey_evm.pem \
+                -newkey ec -pkeyopt ec_paramgen_curve:prime256v1
+
 Configuration file x509_evm.genkey:
 
 	# Beginning of the file
@@ -245,6 +257,9 @@ Generate public key for using RSA key format:
 
     openssl rsa -pubout -in privkey_evm.pem -out pubkey_evm.pem
 
+Similarly generate public EC key:
+
+    openssl ec -pubout -in privkey_evm.pem -out pubkey_evm.pem
 
 Copy keys to /etc/keys:
 
@@ -291,6 +306,12 @@ Configuration file ima-local-ca.genkey:
 	keyUsage = cRLSign, keyCertSign
 	# EOF
 
+Note: To generated elliptic curve keys add the following parameters to
+      the 'req' commands below (supported since Linux v5.13):
+
+      -newkey ec -pkeyopt ec_paramgen_curve:prime256v1
+
+
 Generate private key and X509 public key certificate:
 
  openssl req -new -x509 -utf8 -sha256 -days 3650 -batch -config $GENKEY \
-- 
2.39.2

