Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E183C6E6E79
	for <lists+linux-integrity@lfdr.de>; Tue, 18 Apr 2023 23:41:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232431AbjDRVle (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 18 Apr 2023 17:41:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233057AbjDRVlb (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 18 Apr 2023 17:41:31 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4868BB80
        for <linux-integrity@vger.kernel.org>; Tue, 18 Apr 2023 14:41:26 -0700 (PDT)
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33ILalgZ019164
        for <linux-integrity@vger.kernel.org>; Tue, 18 Apr 2023 21:41:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=s2tHVMMCFITmPapgdnZHjyjowVkUwWdpxNtxvCTj8M4=;
 b=V12OZxNEjC7AFol3wa5GWkChRb1mVJdhlSh/5n6r5YDk5SDWHGmBfJCfbe5k9TaCDVln
 tUZZ4kmaHpScrrL5UlQ7DZBMJwoOHy7SEIdNtFvx8h2QqlckhW6agJThAzjhAYtNbIDa
 X1WHoZJWSw73GWvwW1crAWZo3H3wiVS7Bldqzw557LfdfeUpwFLeXoFECxcWvPHSp+Hk
 xI7/uy6Wp3G4QX58thVHKJmFHp0p3vewp1vxfQAckjvzAF2d4fJbtvLyN1Rqqu3Qjntz
 86C7QksdKK148ZDWB42kAL9Yc05CWNNbJKpOv7WH4bsgIuL3OdbeZQ26wqKF/TJDbD0Q BA== 
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com [169.63.121.186])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3q20sbc6ch-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Tue, 18 Apr 2023 21:41:25 +0000
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
        by ppma03wdc.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 33IJJFYb010080
        for <linux-integrity@vger.kernel.org>; Tue, 18 Apr 2023 21:41:24 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([9.208.129.116])
        by ppma03wdc.us.ibm.com (PPS) with ESMTPS id 3pykj7b3qb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Tue, 18 Apr 2023 21:41:24 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
        by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 33ILfM8J14353084
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Apr 2023 21:41:22 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C44205805B;
        Tue, 18 Apr 2023 21:41:22 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5B4A258055;
        Tue, 18 Apr 2023 21:41:22 +0000 (GMT)
Received: from sbct-2.pok.ibm.com (unknown [9.47.158.152])
        by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Tue, 18 Apr 2023 21:41:22 +0000 (GMT)
From:   Stefan Berger <stefanb@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     zohar@linux.ibm.com, Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH ima-evm-utils] Add openssl command line examples for creation of EC keys
Date:   Tue, 18 Apr 2023 17:41:20 -0400
Message-Id: <20230418214120.102679-1-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: oKwP76whpe7lFjw-zDnd4eEsjN-q7R-N
X-Proofpoint-ORIG-GUID: oKwP76whpe7lFjw-zDnd4eEsjN-q7R-N
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-18_15,2023-04-18_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 priorityscore=1501
 mlxlogscore=999 spamscore=0 impostorscore=0 malwarescore=0
 lowpriorityscore=0 adultscore=0 phishscore=0 suspectscore=0 clxscore=1015
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304180179
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Add openssl command line examples for creation of EC keys for
EVM and IMA CA and signing key.

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 README | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/README b/README
index 75e4fd2..fd12680 100644
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
@@ -244,6 +256,9 @@ Generate public key for using RSA key format:
 
     openssl rsa -pubout -in privkey_evm.pem -out pubkey_evm.pem
 
+Similarly generate public EC key:
+
+    openssl ec -pubout -in privkey_evm.pem -out pubkey_evm.pem
 
 Copy keys to /etc/keys:
 
@@ -290,6 +305,12 @@ Configuration file ima-local-ca.genkey:
 	# keyUsage = cRLSign, keyCertSign
 	# EOF
 
+Note: To generated elliptic curve keys add the following parameters to
+      the 'req' commands below (supported since Linux v5.13):
+
+      -newkey ec -pkeyopt ec_paramgen_curve:prime256v1
+
+
 Generate private key and X509 public key certificate:
 
  openssl req -new -x509 -utf8 -sha1 -days 3650 -batch -config $GENKEY \
-- 
2.39.2

