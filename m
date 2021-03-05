Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A13132F4DE
	for <lists+linux-integrity@lfdr.de>; Fri,  5 Mar 2021 22:00:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229711AbhCEVAV (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 5 Mar 2021 16:00:21 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:49368 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229563AbhCEVAL (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 5 Mar 2021 16:00:11 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 125Kd2fm088864;
        Fri, 5 Mar 2021 16:00:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=niAyQwmdKx6f0YB7Kpf/eHYKGfKhTDz1oiuvJUn7NaY=;
 b=shGO8Qqnq291otYEF7U72qTrPIH9a+L/ThsgIBp5tFMmgt5Nj7s+lZN9u0WYLYTlCMBl
 Z1o4Hl0Db8Av4XIv+C5jNnQn0CcxFyCGAj/otUwIu795H9zt5dpw6Gtf+OcSYSN1M1oj
 X0e71dHw/Wbfd/czQKZ5tdviQ7xd4uKJAwC+6j8hX6Oa3NwrluYLrdW+l1LTpJC0HHGH
 FvQ9076bVmPyLfe1n8PCTyr6NZ144jyNS4g3+UUGiz9iLFd6EwkdJy5eq3dAFVzH4sNP
 NcfNh4m/BMRpokzovP5Mca9RQaZvvsFE/M6QFgaxpCHsHlhbEFLcho+l79AN/1Mjgxqg vQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 373tntt4mp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 05 Mar 2021 16:00:04 -0500
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 125Kd9mv089427;
        Fri, 5 Mar 2021 16:00:03 -0500
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com [169.55.91.170])
        by mx0a-001b2d01.pphosted.com with ESMTP id 373tntt4ky-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 05 Mar 2021 16:00:03 -0500
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
        by ppma02wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 125KrJAQ001883;
        Fri, 5 Mar 2021 21:00:02 GMT
Received: from b03cxnp07028.gho.boulder.ibm.com (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
        by ppma02wdc.us.ibm.com with ESMTP id 3711dxjqd5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 05 Mar 2021 21:00:02 +0000
Received: from b03ledav005.gho.boulder.ibm.com (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
        by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 125L01Bq17695006
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 5 Mar 2021 21:00:01 GMT
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EF8F9BE056;
        Fri,  5 Mar 2021 21:00:00 +0000 (GMT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2C478BE054;
        Fri,  5 Mar 2021 21:00:00 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTP;
        Fri,  5 Mar 2021 21:00:00 +0000 (GMT)
From:   Stefan Berger <stefanb@linux.vnet.ibm.com>
To:     keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
        davem@davemloft.net, herbert@gondor.apana.org.au,
        dhowells@redhat.com, zohar@linux.ibm.com, jarkko@kernel.org
Cc:     linux-kernel@vger.kernel.org, patrick@puiterwijk.org,
        linux-integrity@vger.kernel.org,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v11 01/10] oid_registry: Add OIDs for ECDSA with sha224/256/384/512
Date:   Fri,  5 Mar 2021 15:59:47 -0500
Message-Id: <20210305205956.3594375-2-stefanb@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210305205956.3594375-1-stefanb@linux.vnet.ibm.com>
References: <20210305205956.3594375-1-stefanb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-05_14:2021-03-03,2021-03-05 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011
 priorityscore=1501 malwarescore=0 spamscore=0 bulkscore=0 impostorscore=0
 mlxscore=0 suspectscore=0 mlxlogscore=934 phishscore=0 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103050103
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Stefan Berger <stefanb@linux.ibm.com>

Add OIDs for ECDSA with sha224/256/384/512.

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 include/linux/oid_registry.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/include/linux/oid_registry.h b/include/linux/oid_registry.h
index 4462ed2c18cd..b504e2f36b25 100644
--- a/include/linux/oid_registry.h
+++ b/include/linux/oid_registry.h
@@ -19,8 +19,12 @@
 enum OID {
 	OID_id_dsa_with_sha1,		/* 1.2.840.10030.4.3 */
 	OID_id_dsa,			/* 1.2.840.10040.4.1 */
-	OID_id_ecdsa_with_sha1,		/* 1.2.840.10045.4.1 */
 	OID_id_ecPublicKey,		/* 1.2.840.10045.2.1 */
+	OID_id_ecdsa_with_sha1,		/* 1.2.840.10045.4.1 */
+	OID_id_ecdsa_with_sha224,	/* 1.2.840.10045.4.3.1 */
+	OID_id_ecdsa_with_sha256,	/* 1.2.840.10045.4.3.2 */
+	OID_id_ecdsa_with_sha384,	/* 1.2.840.10045.4.3.3 */
+	OID_id_ecdsa_with_sha512,	/* 1.2.840.10045.4.3.4 */
 
 	/* PKCS#1 {iso(1) member-body(2) us(840) rsadsi(113549) pkcs(1) pkcs-1(1)} */
 	OID_rsaEncryption,		/* 1.2.840.113549.1.1.1 */
-- 
2.29.2

