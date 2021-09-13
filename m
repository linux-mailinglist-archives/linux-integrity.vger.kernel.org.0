Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9B12409F8B
	for <lists+linux-integrity@lfdr.de>; Tue, 14 Sep 2021 00:18:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235603AbhIMWTl (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 13 Sep 2021 18:19:41 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:41246 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235332AbhIMWTk (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 13 Sep 2021 18:19:40 -0400
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.0.43) with SMTP id 18DKcgZ9033402
        for <linux-integrity@vger.kernel.org>; Mon, 13 Sep 2021 18:18:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=hd4ugYZpp2RpvNlnH5eyWkmmkNTfw9p3KghcP9bNUsg=;
 b=TcvW8HZjr7SD2KgzfItvboGcDXb/p0fXiEcXj9FEY9kQBVRQcctQUOJEhTTpYDw6YJ6O
 HdPDvm087/IHhd7GU8pCIX2E7jiynWuLq/6+kkZsWVDo1yAERbAB35H7Ape9QB1IYBTt
 nZzIxHR7r/gEibifnsuTUk5abnmqK5Rgm3EvIF5Xh9gTAr62cYTHDa6izaPvq2EBE7f2
 8C/KSxAT4efqxDmnjQqJ5mYuumD1aKptfz06ePBvJWiSBJxHWA7Cpq/g3fHpeh2UnmGy
 G2r8FZJRFirVeaUnTjb+1amIqfsd2xWEKdebSmyW1R1Mq7ALHwWQud24l1EuvY+J9dw9 ag== 
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3b232jaqjj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Mon, 13 Sep 2021 18:18:24 -0400
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 18DMHkPc020837
        for <linux-integrity@vger.kernel.org>; Mon, 13 Sep 2021 22:18:23 GMT
Received: from b03cxnp08025.gho.boulder.ibm.com (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
        by ppma03dal.us.ibm.com with ESMTP id 3b0m3adawx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Mon, 13 Sep 2021 22:18:23 +0000
Received: from b03ledav005.gho.boulder.ibm.com (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
        by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 18DMILTC54198778
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Sep 2021 22:18:22 GMT
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DDA6ABE054;
        Mon, 13 Sep 2021 22:18:21 +0000 (GMT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9376BBE058;
        Mon, 13 Sep 2021 22:18:21 +0000 (GMT)
Received: from sbct-2.pok.ibm.com (unknown [9.47.158.152])
        by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTP;
        Mon, 13 Sep 2021 22:18:21 +0000 (GMT)
From:   Stefan Berger <stefanb@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     zohar@linux.ibm.com, Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v4 3/9] evmctl: Implement function for setting up an OpenSSL engine
Date:   Mon, 13 Sep 2021 18:18:07 -0400
Message-Id: <20210913221813.2554880-4-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210913221813.2554880-1-stefanb@linux.ibm.com>
References: <20210913221813.2554880-1-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: bsUE4NaFuGynjfefnfXQ9hCAlrtvyUCE
X-Proofpoint-ORIG-GUID: bsUE4NaFuGynjfefnfXQ9hCAlrtvyUCE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.687,Hydra:6.0.235,FMLib:17.0.607.475
 definitions=2020-10-13_15,2020-10-13_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 bulkscore=0 suspectscore=0 impostorscore=0 lowpriorityscore=0
 phishscore=0 mlxscore=0 mlxlogscore=854 malwarescore=0 clxscore=1015
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109030001 definitions=main-2109130046
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Move the code that sets up an OpenSSL engine into its own function.

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 src/evmctl.c | 32 +++++++++++++++++++-------------
 1 file changed, 19 insertions(+), 13 deletions(-)

diff --git a/src/evmctl.c b/src/evmctl.c
index ed0ece3..4b6f3fb 100644
--- a/src/evmctl.c
+++ b/src/evmctl.c
@@ -2631,6 +2631,23 @@ static char *get_password(void)
 	return pwd;
 }
 
+static ENGINE *setup_engine(const char *engine_id)
+{
+	ENGINE *eng = ENGINE_by_id(engine_id);
+	if (!eng) {
+		log_err("engine %s isn't available\n", optarg);
+		ERR_print_errors_fp(stderr);
+	} else if (!ENGINE_init(eng)) {
+		log_err("engine %s init failed\n", optarg);
+		ERR_print_errors_fp(stderr);
+		ENGINE_free(eng);
+		eng = NULL;
+	}
+	if (eng)
+		ENGINE_set_default(eng, ENGINE_METHOD_ALL);
+	return eng;
+}
+
 int main(int argc, char *argv[])
 {
 	int err = 0, c, lind;
@@ -2755,19 +2772,8 @@ int main(int argc, char *argv[])
 			verify_list_sig = 1;
 			break;
 		case 139: /* --engine e */
-			eng = ENGINE_by_id(optarg);
-			if (!eng) {
-				log_err("engine %s isn't available\n", optarg);
-				ERR_print_errors_fp(stderr);
-			} else if (!ENGINE_init(eng)) {
-				log_err("engine %s init failed\n", optarg);
-				ERR_print_errors_fp(stderr);
-				ENGINE_free(eng);
-				eng = NULL;
-			}
-			if (eng)
-				ENGINE_set_default(eng, ENGINE_METHOD_ALL);
-			else
+			eng = setup_engine(optarg);
+			if (!eng)
 				goto error;
 			break;
 		case 140: /* --xattr-user */
-- 
2.31.1

