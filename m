Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F3603646A3
	for <lists+linux-integrity@lfdr.de>; Mon, 19 Apr 2021 17:02:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239385AbhDSPCw (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 19 Apr 2021 11:02:52 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:4319 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S239093AbhDSPCw (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 19 Apr 2021 11:02:52 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13JEX87v108261
        for <linux-integrity@vger.kernel.org>; Mon, 19 Apr 2021 11:02:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=WWyEfL1pkUewMfAZssJxuGavAYFKzB5IbQ1lXIRSmsY=;
 b=PlvTjvRX3uuSFIbM7347uOBmk+DEQhSN6xlidLsYOTU5iFSVbVMp54ScH21MkwcSDhFg
 ByUBa2xHMy8Be+LStyOcjBDBL6wghD91JMn1WeoXvI3iDb44Lm7dF1Kq3NdUbJmR1EVu
 CrT0vMJYb9MvqaG6Jb0H/yL8U8PqFFUqFGz6mR0jy13rih/KJM7lpVkx+/2O8KmzyZrQ
 HOUnjCb3GLJVar3I9wdR5b39Q1fcrPFjzkFfEThpVUHH4FN5Uf/lEhoG6PG/5+TXQGv2
 Maq0462mgI4qzE8XQZVbVPItr6ngI1k0ZC0BLZh7ohoDD2N1S/UrpPt++AUkcGpxoXV8 DQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 380d7dm133-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Mon, 19 Apr 2021 11:02:01 -0400
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 13JEX9xr108463
        for <linux-integrity@vger.kernel.org>; Mon, 19 Apr 2021 11:02:01 -0400
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0b-001b2d01.pphosted.com with ESMTP id 380d7dm129-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Apr 2021 11:02:01 -0400
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 13JEqfqf013437;
        Mon, 19 Apr 2021 15:02:00 GMT
Received: from b03cxnp08027.gho.boulder.ibm.com (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
        by ppma02dal.us.ibm.com with ESMTP id 37yqa9ycx1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Apr 2021 15:02:00 +0000
Received: from b03ledav002.gho.boulder.ibm.com (b03ledav002.gho.boulder.ibm.com [9.17.130.233])
        by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 13JF1wLS63636036
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 19 Apr 2021 15:01:58 GMT
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B5D21136061;
        Mon, 19 Apr 2021 15:01:58 +0000 (GMT)
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 520C2136053;
        Mon, 19 Apr 2021 15:01:58 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.47.158.155])
        by b03ledav002.gho.boulder.ibm.com (Postfix) with ESMTP;
        Mon, 19 Apr 2021 15:01:58 +0000 (GMT)
From:   Stefan Berger <stefanb@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     zohar@linux.ibm.com, dmitry.kasatkin@gmail.com,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH 6/6] libimaevm: Use function parameter algo for name of hash
Date:   Mon, 19 Apr 2021 11:01:51 -0400
Message-Id: <20210419150151.236409-7-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210419150151.236409-1-stefanb@linux.ibm.com>
References: <20210419150151.236409-1-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 8J9oE0bAmjK4upi0uV9m8XrTs-J6x8bK
X-Proofpoint-GUID: 2VHFTbQQupV0oXpclr9ZF0tSGZOai2ep
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-19_10:2021-04-19,2021-04-19 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 mlxlogscore=999 mlxscore=0 adultscore=0 suspectscore=0
 spamscore=0 impostorscore=0 priorityscore=1501 clxscore=1015 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104190100
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Instead of using the global variable imaevm_params.hash_algo as the
hash algo to use, use the algo parameter passed into the function.
Existing code in this function already uses 'algo' for writing the
has into the header:

        hdr->hash_algo = imaevm_get_hash_algo(algo);

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 src/libimaevm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/libimaevm.c b/src/libimaevm.c
index 06f1063..2856270 100644
--- a/src/libimaevm.c
+++ b/src/libimaevm.c
@@ -913,7 +913,7 @@ static int sign_hash_v2(const char *algo, const unsigned char *hash,
 		return -1;
 	}
 
-	log_info("hash(%s): ", imaevm_params.hash_algo);
+	log_info("hash(%s): ", algo);
 	log_dump(hash, size);
 
 	pkey = read_priv_pkey(keyfile, imaevm_params.keypass);
@@ -939,7 +939,7 @@ static int sign_hash_v2(const char *algo, const unsigned char *hash,
 	if (!EVP_PKEY_sign_init(ctx))
 		goto err;
 	st = "EVP_get_digestbyname";
-	if (!(md = EVP_get_digestbyname(imaevm_params.hash_algo)))
+	if (!(md = EVP_get_digestbyname(algo)))
 		goto err;
 	st = "EVP_PKEY_CTX_set_signature_md";
 	if (!EVP_PKEY_CTX_set_signature_md(ctx, md))
-- 
2.30.2

