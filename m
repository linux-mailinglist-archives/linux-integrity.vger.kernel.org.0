Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 305EC3E5C10
	for <lists+linux-integrity@lfdr.de>; Tue, 10 Aug 2021 15:46:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240201AbhHJNqY (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 10 Aug 2021 09:46:24 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:63326 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241832AbhHJNqX (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 10 Aug 2021 09:46:23 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17ADXtXl167410
        for <linux-integrity@vger.kernel.org>; Tue, 10 Aug 2021 09:46:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=6gqU34acZ3FrQB+YUMS51Wz6t50aFMPuB/Mf+jEtwmc=;
 b=Uf1lfp7p+xDW+xmjO+ZGjOmD0efY+UxPHB0odt6tpWNWCEc3eOl1zkGgQITOwEufm7HL
 0MUIS7fCg3ZX1J9tRAGgVlkLcLPNWAwAiUJmeyWjl8/BZApGRKRbIhjNMU8D8JJ8vISG
 hN5Mbiwh8nmWehg8wQrKwJz1Z5u8fvpsM1u6vLbJUrm7IhEWSgLjgZSbLg8ragJQzNKI
 EwKIUjpqKGpdShzK5BnH4TivV7DYMjtvUkqoSrRW3hme9LkR3w/mH1xYZ3yGMDuzR6i/
 4CZrcxZsPrh5uo+SJ9dYvElyUb2k8ZwHUmd0KmWeYc8nzjNktcOxZrwCUsVFoZFWllV0 Pw== 
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3abq69entc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Tue, 10 Aug 2021 09:46:01 -0400
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 17ADgriu028350
        for <linux-integrity@vger.kernel.org>; Tue, 10 Aug 2021 13:46:00 GMT
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com [9.57.198.29])
        by ppma03dal.us.ibm.com with ESMTP id 3a9htcucuv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Tue, 10 Aug 2021 13:46:00 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 17ADjxEZ39649764
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Aug 2021 13:45:59 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 28AE9B208B;
        Tue, 10 Aug 2021 13:45:59 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 19B5BB207F;
        Tue, 10 Aug 2021 13:45:59 +0000 (GMT)
Received: from sbct-2.. (unknown [9.47.158.152])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue, 10 Aug 2021 13:45:59 +0000 (GMT)
From:   Stefan Berger <stefanb@linux.vnet.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     zohar@linux.ibm.com, Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v2 3/8] evmctl: Move code setting up engine to own funtion
Date:   Tue, 10 Aug 2021 09:45:52 -0400
Message-Id: <20210810134557.2444863-4-stefanb@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210810134557.2444863-1-stefanb@linux.vnet.ibm.com>
References: <20210810134557.2444863-1-stefanb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ww4xcw1M51Ejycuet_vvQykTNTzkhzC3
X-Proofpoint-ORIG-GUID: ww4xcw1M51Ejycuet_vvQykTNTzkhzC3
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-10_05:2021-08-10,2021-08-10 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 adultscore=0
 bulkscore=0 priorityscore=1501 phishscore=0 mlxlogscore=999 clxscore=1015
 malwarescore=0 lowpriorityscore=0 mlxscore=0 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108100087
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Stefan Berger <stefanb@linux.ibm.com>

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

