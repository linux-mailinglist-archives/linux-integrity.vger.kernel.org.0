Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BDBC409F8A
	for <lists+linux-integrity@lfdr.de>; Tue, 14 Sep 2021 00:18:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234858AbhIMWTk (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 13 Sep 2021 18:19:40 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:56470 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235133AbhIMWTk (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 13 Sep 2021 18:19:40 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.0.43) with SMTP id 18DLMvB1000423
        for <linux-integrity@vger.kernel.org>; Mon, 13 Sep 2021 18:18:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=N+QaTzX4Nnf6KGCI81/2NJF8rX9m8g9w8NR+FWs/0R8=;
 b=VJYUOxTqdyHQJ8mYYvjREhFvm7TVci3JNcg58F1cwmlbw8apB7IWae3ZGjYsUlcXpT34
 A4u2pyD3Bl6u69tVQD3Kv4dvLBnwBSLVc4ijwvmf2evtoJd2Kh7TvWssf6rlSXKS0u0t
 Y5HkufEu5d87wFBNvDoeIXfLqH3XC8g8ACCI+ZT1zGyLpiTsPsBOhdI3suDWavQrfBBJ
 ire31mxn46oHg4H7CdMuyiCuILoZwU4r6EAD2OznhhoWZ5hg+1+S6noN58e5Dj+b6IUv
 AVfNYT7t1I4qUlC3VwPjJgii7m/XFvmUMOIR0aJroIG+nbYJJAO0IinabfcU3Mvzonaa 7Q== 
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com [169.63.121.186])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3b23hwakxq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Mon, 13 Sep 2021 18:18:23 -0400
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
        by ppma03wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 18DMHKSN019348
        for <linux-integrity@vger.kernel.org>; Mon, 13 Sep 2021 22:18:22 GMT
Received: from b03cxnp08025.gho.boulder.ibm.com (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
        by ppma03wdc.us.ibm.com with ESMTP id 3b0m3aawq6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Mon, 13 Sep 2021 22:18:22 +0000
Received: from b03ledav005.gho.boulder.ibm.com (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
        by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 18DMIL3T53150020
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Sep 2021 22:18:21 GMT
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7BB16BE05D;
        Mon, 13 Sep 2021 22:18:21 +0000 (GMT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 35FA9BE054;
        Mon, 13 Sep 2021 22:18:21 +0000 (GMT)
Received: from sbct-2.pok.ibm.com (unknown [9.47.158.152])
        by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTP;
        Mon, 13 Sep 2021 22:18:21 +0000 (GMT)
From:   Stefan Berger <stefanb@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     zohar@linux.ibm.com, Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v4 2/9] evmctl: Handle failure to initialize the openssl engine
Date:   Mon, 13 Sep 2021 18:18:06 -0400
Message-Id: <20210913221813.2554880-3-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210913221813.2554880-1-stefanb@linux.ibm.com>
References: <20210913221813.2554880-1-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: r7L-FpqGLrPkJQlvbMiju8J7xCaefE19
X-Proofpoint-GUID: r7L-FpqGLrPkJQlvbMiju8J7xCaefE19
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.687,Hydra:6.0.235,FMLib:17.0.607.475
 definitions=2020-10-13_15,2020-10-13_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 spamscore=0 mlxscore=0 priorityscore=1501 phishscore=0 clxscore=1015
 lowpriorityscore=0 mlxlogscore=498 impostorscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109030001 definitions=main-2109130048
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Handle failure to initialize the openssl engine. For example,

$ ./src/evmctl --engine foo
engine foo isn't available
140322992015168:error:25066067:DSO support routines:dlfcn_load:could not load the shared library:crypto/dso/dso_dlfcn.c:118:filename(/usr/lib64/engines-1.1/foo.so): /usr/lib64/engines-1.1/foo.so: cannot open shared object file: No such file or directory
140322992015168:error:25070067:DSO support routines:DSO_load:could not load the shared library:crypto/dso/dso_lib.c:162:
140322992015168:error:260B6084:engine routines:dynamic_load:dso not found:crypto/engine/eng_dyn.c:414:
140322992015168:error:2606A074:engine routines:ENGINE_by_id:no such engine:crypto/engine/eng_list.c:334:id=foo
Segmentation fault (core dumped)

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 src/evmctl.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/src/evmctl.c b/src/evmctl.c
index 58f8e66..ed0ece3 100644
--- a/src/evmctl.c
+++ b/src/evmctl.c
@@ -2765,7 +2765,10 @@ int main(int argc, char *argv[])
 				ENGINE_free(eng);
 				eng = NULL;
 			}
-			ENGINE_set_default(eng, ENGINE_METHOD_ALL);
+			if (eng)
+				ENGINE_set_default(eng, ENGINE_METHOD_ALL);
+			else
+				goto error;
 			break;
 		case 140: /* --xattr-user */
 			xattr_ima = "user.ima";
@@ -2839,6 +2842,7 @@ int main(int argc, char *argv[])
 			err = 125;
 	}
 
+error:
 	if (eng) {
 		ENGINE_finish(eng);
 		ENGINE_free(eng);
-- 
2.31.1

