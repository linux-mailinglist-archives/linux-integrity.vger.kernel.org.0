Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3732E32DE98
	for <lists+linux-integrity@lfdr.de>; Fri,  5 Mar 2021 01:53:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231905AbhCEAwd (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 4 Mar 2021 19:52:33 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:8990 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231591AbhCEAwZ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 4 Mar 2021 19:52:25 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1250hLfI097337;
        Thu, 4 Mar 2021 19:52:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=VtF4Yw7xrfj4MWr85/dNbECLCqQJ6pR1t+mfj8tqn0M=;
 b=q/1p6752gibSgXpWmQzNgNnHguCg+qM/05nwjUqQbnnGMoh2nvjuAehyiSF62aMeVBBV
 UBljInMmmIHa1o2Q84Abc2HFMikMaSidgv10U0nm1p00ntBJatFDY9JZKirnz5VE/Wz6
 e9/+zgC3k/HOxt7DYqol6xyYJ1JIEp0qDk9SOstR+a530IWBOQhm72A0NAMTuZEYmzK7
 KrUMKc55Pf2YRR+kQ72+NYByIlWGh/X+8c0aN9TlTR+zkCKvwdRIq0kp/5dl5usnKtiL
 t+iEjrwZ3YcrbKpOJrS8BZ2zlH8VJlA2JO/SCT9auDFz+gpjWumcuWRSPqO2yMurOtTy 5Q== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 373abpr62s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 04 Mar 2021 19:52:16 -0500
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1250m8Ge119728;
        Thu, 4 Mar 2021 19:52:15 -0500
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com [169.63.121.186])
        by mx0a-001b2d01.pphosted.com with ESMTP id 373abpr62h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 04 Mar 2021 19:52:15 -0500
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
        by ppma03wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 1250WomO025076;
        Fri, 5 Mar 2021 00:52:15 GMT
Received: from b03cxnp08026.gho.boulder.ibm.com (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
        by ppma03wdc.us.ibm.com with ESMTP id 37128gv1cy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 05 Mar 2021 00:52:15 +0000
Received: from b03ledav006.gho.boulder.ibm.com (b03ledav006.gho.boulder.ibm.com [9.17.130.237])
        by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1250qD6u13697470
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 5 Mar 2021 00:52:13 GMT
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BDD0FC605F;
        Fri,  5 Mar 2021 00:52:13 +0000 (GMT)
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 29DA6C6055;
        Fri,  5 Mar 2021 00:52:13 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTP;
        Fri,  5 Mar 2021 00:52:13 +0000 (GMT)
From:   Stefan Berger <stefanb@linux.vnet.ibm.com>
To:     keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
        davem@davemloft.net, herbert@gondor.apana.org.au,
        dhowells@redhat.com, zohar@linux.ibm.com
Cc:     linux-kernel@vger.kernel.org, patrick@puiterwijk.org,
        linux-integrity@vger.kernel.org,
        Saulo Alessandre <saulo.alessandre@tse.jus.br>,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v10 8/9] x509: Add OID for NIST P384 and extend parser for it
Date:   Thu,  4 Mar 2021 19:52:02 -0500
Message-Id: <20210305005203.3547587-9-stefanb@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210305005203.3547587-1-stefanb@linux.vnet.ibm.com>
References: <20210305005203.3547587-1-stefanb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-04_09:2021-03-03,2021-03-04 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 clxscore=1015
 mlxscore=0 malwarescore=0 phishscore=0 adultscore=0 spamscore=0
 suspectscore=0 mlxlogscore=999 priorityscore=1501 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103050001
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Saulo Alessandre <saulo.alessandre@tse.jus.br>

* crypto/asymmetric_keys/x509_cert_parser.c
  - prepare x509 parser to load nist_secp384r1

* include/linux/oid_registry.h
  - add OID_id_secp384r1

Signed-off-by: Saulo Alessandre <saulo.alessandre@tse.jus.br>
Tested-by: Stefan Berger <stefanb@linux.ibm.com>
---
 crypto/asymmetric_keys/x509_cert_parser.c | 3 +++
 include/linux/oid_registry.h              | 1 +
 2 files changed, 4 insertions(+)

diff --git a/crypto/asymmetric_keys/x509_cert_parser.c b/crypto/asymmetric_keys/x509_cert_parser.c
index f5d547c6dfb5..526c6a407e07 100644
--- a/crypto/asymmetric_keys/x509_cert_parser.c
+++ b/crypto/asymmetric_keys/x509_cert_parser.c
@@ -510,6 +510,9 @@ int x509_extract_key_data(void *context, size_t hdrlen,
 		case OID_id_prime256v1:
 			ctx->cert->pub->pkey_algo = "ecdsa-nist-p256";
 			break;
+		case OID_id_secp384r1:
+			ctx->cert->pub->pkey_algo = "ecdsa-nist-p384";
+			break;
 		default:
 			return -ENOPKG;
 		}
diff --git a/include/linux/oid_registry.h b/include/linux/oid_registry.h
index 3583908cf1ca..d656450dfc66 100644
--- a/include/linux/oid_registry.h
+++ b/include/linux/oid_registry.h
@@ -64,6 +64,7 @@ enum OID {
 
 	OID_certAuthInfoAccess,		/* 1.3.6.1.5.5.7.1.1 */
 	OID_sha1,			/* 1.3.14.3.2.26 */
+	OID_id_secp384r1,		/* 1.3.132.0.34 */
 	OID_sha256,			/* 2.16.840.1.101.3.4.2.1 */
 	OID_sha384,			/* 2.16.840.1.101.3.4.2.2 */
 	OID_sha512,			/* 2.16.840.1.101.3.4.2.3 */
-- 
2.29.2

