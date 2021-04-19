Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35CD036469E
	for <lists+linux-integrity@lfdr.de>; Mon, 19 Apr 2021 17:02:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239586AbhDSPCa (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 19 Apr 2021 11:02:30 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:20630 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239230AbhDSPCa (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 19 Apr 2021 11:02:30 -0400
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13JEXaLH031502
        for <linux-integrity@vger.kernel.org>; Mon, 19 Apr 2021 11:02:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=56W0iEdGubB1+U29sYehFG0HtKMZrA9aSiTRV+T4vVg=;
 b=bYTgXYf52FkLSQT3fdvik1n86bbAJkMewyvW67M/M5nn+S4gSNuYFt9s+J/wFZveOADY
 TQ2eBamMSPU8KJK2fCemD4ImQxYHeEi5Ro5MimchU3vJzxp6X4Dn79qyF0/x/f9ttl8E
 /Hf8PQfBCeIZmXv3mxuoy+gVoezykybpg2BOJoxPnK3g5OYtvJw80t7EIHLEO4gwpFw3
 ZG8ozVkSHTTavzkeMmwpKAmsyIBcWY7oS4yZfu5RqJfpXozMFQlM3NX4FsXU7Oycu1u/
 UErGUlNJjg7nAnEdgk12+g5iL8r/E9IMLZInkbWEllH9e73PxuEUCh4YFSk/61sgSMiI nw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 380cwxv9yu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Mon, 19 Apr 2021 11:01:59 -0400
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 13JEXeLC032097
        for <linux-integrity@vger.kernel.org>; Mon, 19 Apr 2021 11:01:59 -0400
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com [169.47.144.27])
        by mx0a-001b2d01.pphosted.com with ESMTP id 380cwxv9xr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Apr 2021 11:01:59 -0400
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
        by ppma05wdc.us.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 13JEqgJd014062;
        Mon, 19 Apr 2021 15:01:58 GMT
Received: from b03cxnp08026.gho.boulder.ibm.com (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
        by ppma05wdc.us.ibm.com with ESMTP id 37yqa8tr55-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Apr 2021 15:01:58 +0000
Received: from b03ledav002.gho.boulder.ibm.com (b03ledav002.gho.boulder.ibm.com [9.17.130.233])
        by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 13JF1vWL21758428
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 19 Apr 2021 15:01:57 GMT
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2B214136051;
        Mon, 19 Apr 2021 15:01:57 +0000 (GMT)
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BB457136055;
        Mon, 19 Apr 2021 15:01:56 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.47.158.155])
        by b03ledav002.gho.boulder.ibm.com (Postfix) with ESMTP;
        Mon, 19 Apr 2021 15:01:56 +0000 (GMT)
From:   Stefan Berger <stefanb@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     zohar@linux.ibm.com, dmitry.kasatkin@gmail.com,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH 3/6] libimaevm: Rename variable returned from readlink to len
Date:   Mon, 19 Apr 2021 11:01:48 -0400
Message-Id: <20210419150151.236409-4-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210419150151.236409-1-stefanb@linux.ibm.com>
References: <20210419150151.236409-1-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: e_TsLhLG3rHxPmLX-fRjd1oZJUwXq5f6
X-Proofpoint-GUID: e_yB8I6lqTBOenZnZOAbYLRyn-oDys2D
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-19_10:2021-04-19,2021-04-19 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 phishscore=0
 malwarescore=0 bulkscore=0 mlxlogscore=999 suspectscore=0 adultscore=0
 mlxscore=0 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2104060000 definitions=main-2104190100
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

The variable returned from readlink is a length indicator of the
number of bytes placed into a buffer, not only an error. Leave
a note in the code that a zero-length link is also treated as an
error, besdies the usual -1.

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 src/libimaevm.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/src/libimaevm.c b/src/libimaevm.c
index 0137884..9a6739b 100644
--- a/src/libimaevm.c
+++ b/src/libimaevm.c
@@ -213,15 +213,16 @@ static int add_dir_hash(const char *file, EVP_MD_CTX *ctx)
 
 static int add_link_hash(const char *path, EVP_MD_CTX *ctx)
 {
-	int err;
+	int len;
 	char buf[1024];
 
-	err = readlink(path, buf, sizeof(buf));
-	if (err <= 0)
+	len = readlink(path, buf, sizeof(buf));
+	/* 0-length links are also an error */
+	if (len <= 0)
 		return -1;
 
-	log_info("link: %s -> %.*s\n", path, err, buf);
-	return !EVP_DigestUpdate(ctx, buf, err);
+	log_info("link: %s -> %.*s\n", path, len, buf);
+	return !EVP_DigestUpdate(ctx, buf, len);
 }
 
 static int add_dev_hash(struct stat *st, EVP_MD_CTX *ctx)
-- 
2.30.2

