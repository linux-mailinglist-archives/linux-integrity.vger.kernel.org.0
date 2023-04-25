Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F9A16EE552
	for <lists+linux-integrity@lfdr.de>; Tue, 25 Apr 2023 18:11:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234211AbjDYQLY (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 25 Apr 2023 12:11:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234552AbjDYQLX (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 25 Apr 2023 12:11:23 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A46711619D
        for <linux-integrity@vger.kernel.org>; Tue, 25 Apr 2023 09:11:09 -0700 (PDT)
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33PG8v3j000810
        for <linux-integrity@vger.kernel.org>; Tue, 25 Apr 2023 16:11:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=s2tHVMMCFITmPapgdnZHjyjowVkUwWdpxNtxvCTj8M4=;
 b=A5bEjs0ZO6kjE2juA6bek1bVwBwt4Ff9v2Gx2FcgfGzyDI+mkugoY2TAXcrR2oJW5h0H
 dIzbp/r91grAMTVpj1Kh8R8hj3ZfJ+kz5bN72RB5Ipe5+bNOeaGva+YdNAZM98WiV9wO
 4vls90fIbAzluB9P1op34Ea9l3p2MPq8bQmNrgQ7VtsbO+C9sRmSiPMd1GnMDqLy0oHw
 6811CXRw78gM7bWOJu0GVanw7zE6dyrmcWPPss561JzK0BTCTdOWHSwdpxnxosLD2AgF
 3TWyTcCZsR9vbJw5czAUbSrSkmlL+Q5sEWJCwzDcPnY9XSzxq9a7N/m/xXmvLN/qqZpA Fg== 
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com [169.63.121.186])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3q6j0bgd7h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Tue, 25 Apr 2023 16:11:06 +0000
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
        by ppma03wdc.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 33PEmCX7026452
        for <linux-integrity@vger.kernel.org>; Tue, 25 Apr 2023 16:10:21 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([9.208.129.114])
        by ppma03wdc.us.ibm.com (PPS) with ESMTPS id 3q477812hc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Tue, 25 Apr 2023 16:10:21 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
        by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 33PGAKdt54853932
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Apr 2023 16:10:20 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0B3DC58057;
        Tue, 25 Apr 2023 16:10:20 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C905758058;
        Tue, 25 Apr 2023 16:10:19 +0000 (GMT)
Received: from sbct-2.pok.ibm.com (unknown [9.47.158.152])
        by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Tue, 25 Apr 2023 16:10:19 +0000 (GMT)
From:   Stefan Berger <stefanb@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     zohar@linux.ibm.com, Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH ima-evm-utils v2 1/2] Add openssl command line examples for creation of EC keys
Date:   Tue, 25 Apr 2023 12:10:14 -0400
Message-Id: <20230425161015.593988-2-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230425161015.593988-1-stefanb@linux.ibm.com>
References: <20230425161015.593988-1-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: JLFjSOulhL_UgKEH0vApTYETBfMe9YrP
X-Proofpoint-GUID: JLFjSOulhL_UgKEH0vApTYETBfMe9YrP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-25_07,2023-04-25_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 malwarescore=0 mlxlogscore=999 impostorscore=0
 adultscore=0 spamscore=0 priorityscore=1501 mlxscore=0 phishscore=0
 bulkscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304250144
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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

