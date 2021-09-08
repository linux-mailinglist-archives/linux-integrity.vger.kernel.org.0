Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C8AA403FC9
	for <lists+linux-integrity@lfdr.de>; Wed,  8 Sep 2021 21:23:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240049AbhIHTY7 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 8 Sep 2021 15:24:59 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:23138 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1350387AbhIHTYz (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 8 Sep 2021 15:24:55 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 188J2XTt013242
        for <linux-integrity@vger.kernel.org>; Wed, 8 Sep 2021 15:23:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=6AkMtgQqhHAmS73eaWRnXRf+UJfmEmzQXx/nBT9u71k=;
 b=oa9/eZZVYqz/0D5jKPEVESF85dalVHMdmGBBRMCAo4nj2tEQAR0jjF1dJ6J5ju8o3N1S
 QGGb10/C+LFX1xLW1MTDjol5S987qkHtQENvAhiK85u0C2MQ495VECS8Phv8G/OVB1ZS
 ftWOAg5F+5sak47JboDIFYiD5E9QtSMjMdqlF9XEOlEGWgQcuXPlDH+PstDbK3RdXzny
 SYubxGwkbUmPw1U7FUzMPThhaUZO3WGeJwRcUFHzfXmLeferzncd8HYLkv6TqcdSXV8+
 IZDuMpL09EADO5NgvF69TqAsA/ixatu0DHjlq+2FCuXRZUKh6EaEGZTrBhDovjiBk32u Kg== 
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3axuwjn2a9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Wed, 08 Sep 2021 15:23:47 -0400
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 188JI6qJ022422
        for <linux-integrity@vger.kernel.org>; Wed, 8 Sep 2021 19:23:46 GMT
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com [9.57.198.26])
        by ppma01dal.us.ibm.com with ESMTP id 3axcnqj3pr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Wed, 08 Sep 2021 19:23:46 +0000
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com [9.57.199.109])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 188JNjG918153804
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 8 Sep 2021 19:23:45 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 60F52112071;
        Wed,  8 Sep 2021 19:23:45 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5D9AF11206D;
        Wed,  8 Sep 2021 19:23:45 +0000 (GMT)
Received: from sbct-2.pok.ibm.com (unknown [9.47.158.152])
        by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed,  8 Sep 2021 19:23:45 +0000 (GMT)
From:   Stefan Berger <stefanb@linux.vnet.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     zohar@linux.ibm.com, Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v3 3/9] evmctl: Implement function for setting up an OpenSSL engine
Date:   Wed,  8 Sep 2021 15:23:37 -0400
Message-Id: <20210908192343.4147739-4-stefanb@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210908192343.4147739-1-stefanb@linux.vnet.ibm.com>
References: <20210908192343.4147739-1-stefanb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Go7_yzx54LNzHRXQB9vaf3nvK8hvDPzp
X-Proofpoint-ORIG-GUID: Go7_yzx54LNzHRXQB9vaf3nvK8hvDPzp
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-09-08_06:2021-09-07,2021-09-08 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 malwarescore=0
 lowpriorityscore=0 bulkscore=0 clxscore=1015 mlxscore=0 mlxlogscore=999
 phishscore=0 impostorscore=0 adultscore=0 priorityscore=1501 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109030001
 definitions=main-2109080120
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Stefan Berger <stefanb@linux.ibm.com>

Implement setup_engine for setting up an OpenSSL engine.

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

