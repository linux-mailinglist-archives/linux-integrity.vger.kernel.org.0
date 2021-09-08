Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2CBA403FC7
	for <lists+linux-integrity@lfdr.de>; Wed,  8 Sep 2021 21:23:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233358AbhIHTY5 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 8 Sep 2021 15:24:57 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:25782 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1350363AbhIHTYz (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 8 Sep 2021 15:24:55 -0400
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 188J38G9169349
        for <linux-integrity@vger.kernel.org>; Wed, 8 Sep 2021 15:23:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=9n30euOzcCAjMwq0mwEJRhi+xXhekyNHYt00fUhShWE=;
 b=L14nNSF1h471+egfmGfNV8rgXWlYlE5lJ4FoIIST+1UJCPJvs53Cw+YqEmWGuH/YhLK3
 QvREC5aJ7+HHpD1lczf0IxHWZjfGDgArkgiXZjXdd/5GHSknLGUIb3az80swDbjG/wt2
 U/cquBSV1GiimO0NcVU052u/ylFk3dh50bU97HoRLq39msyK4WXHV9Z4fscjJooCM1w2
 0VV8g+Zb5RsoTTLjk9SFovZNfQa1IP0vNO/bBn+7g9mFzZUWhUxBQw0M0CTwNi4mT0G4
 9BQ73CRa+R/f4wI3AYcVp744Yyhs2lpsJ8YqX4o2Q/y69cSAdopYt6xSpUObjNBr37wV +g== 
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3ay222sppm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Wed, 08 Sep 2021 15:23:47 -0400
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 188JI4q5003492
        for <linux-integrity@vger.kernel.org>; Wed, 8 Sep 2021 19:23:46 GMT
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com [9.57.198.26])
        by ppma03dal.us.ibm.com with ESMTP id 3axcnja3sp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Wed, 08 Sep 2021 19:23:46 +0000
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com [9.57.199.109])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 188JNj4q12190062
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 8 Sep 2021 19:23:45 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 780E211206D;
        Wed,  8 Sep 2021 19:23:45 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6BBF111206E;
        Wed,  8 Sep 2021 19:23:45 +0000 (GMT)
Received: from sbct-2.pok.ibm.com (unknown [9.47.158.152])
        by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed,  8 Sep 2021 19:23:45 +0000 (GMT)
From:   Stefan Berger <stefanb@linux.vnet.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     zohar@linux.ibm.com, Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v3 4/9] evmctl: Define and use an ENGINE field in libimaevm_params
Date:   Wed,  8 Sep 2021 15:23:38 -0400
Message-Id: <20210908192343.4147739-5-stefanb@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210908192343.4147739-1-stefanb@linux.vnet.ibm.com>
References: <20210908192343.4147739-1-stefanb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: v_of7EENdF1jHRUlPqeKGLiupjWOq23Y
X-Proofpoint-ORIG-GUID: v_of7EENdF1jHRUlPqeKGLiupjWOq23Y
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-09-08_06:2021-09-07,2021-09-08 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 priorityscore=1501 suspectscore=0 mlxlogscore=794 malwarescore=0
 clxscore=1015 bulkscore=0 mlxscore=0 adultscore=0 lowpriorityscore=0
 spamscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109030001 definitions=main-2109080120
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Stefan Berger <stefanb@linux.ibm.com>

Extend the global libimaevm_params structure with an ENGINE field 'eng'
and use it in place of the local ENGINE variable in main().

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 src/evmctl.c | 11 +++++------
 src/imaevm.h |  2 ++
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/src/evmctl.c b/src/evmctl.c
index 4b6f3fb..625a511 100644
--- a/src/evmctl.c
+++ b/src/evmctl.c
@@ -2651,7 +2651,6 @@ static ENGINE *setup_engine(const char *engine_id)
 int main(int argc, char *argv[])
 {
 	int err = 0, c, lind;
-	ENGINE *eng = NULL;
 	unsigned long keyid;
 	char *eptr;
 
@@ -2772,8 +2771,8 @@ int main(int argc, char *argv[])
 			verify_list_sig = 1;
 			break;
 		case 139: /* --engine e */
-			eng = setup_engine(optarg);
-			if (!eng)
+			imaevm_params.eng = setup_engine(optarg);
+			if (!imaevm_params.eng)
 				goto error;
 			break;
 		case 140: /* --xattr-user */
@@ -2849,9 +2848,9 @@ int main(int argc, char *argv[])
 	}
 
 error:
-	if (eng) {
-		ENGINE_finish(eng);
-		ENGINE_free(eng);
+	if (imaevm_params.eng) {
+		ENGINE_finish(imaevm_params.eng);
+		ENGINE_free(imaevm_params.eng);
 #if OPENSSL_API_COMPAT < 0x10100000L
 		ENGINE_cleanup();
 #endif
diff --git a/src/imaevm.h b/src/imaevm.h
index 491f136..8792aa2 100644
--- a/src/imaevm.h
+++ b/src/imaevm.h
@@ -48,6 +48,7 @@
 #include <errno.h>
 #include <sys/types.h>
 #include <openssl/rsa.h>
+#include <openssl/engine.h>
 
 #ifdef USE_FPRINTF
 #define do_log(level, fmt, args...)	\
@@ -197,6 +198,7 @@ struct libimaevm_params {
 	const char *keyfile;
 	const char *keypass;
 	uint32_t keyid;		/* keyid overriding value, unless 0. (Host order.) */
+	ENGINE *eng;
 };
 
 struct RSA_ASN1_template {
-- 
2.31.1

