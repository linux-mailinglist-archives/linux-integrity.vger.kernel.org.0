Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56268409F89
	for <lists+linux-integrity@lfdr.de>; Tue, 14 Sep 2021 00:18:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235133AbhIMWTk (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 13 Sep 2021 18:19:40 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:10674 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S234971AbhIMWTk (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 13 Sep 2021 18:19:40 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.0.43) with SMTP id 18DLRBOG011389
        for <linux-integrity@vger.kernel.org>; Mon, 13 Sep 2021 18:18:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=UaalS2r22WhdD/r8737Is/aW7BvuJpNTRAHHqhGcYIU=;
 b=aZEj8DokKxjfFNYjVR2QJAYwRr22ixDTUa+lDRXMve5smSpWqJUW8X/x/p6VYxd1joG9
 blZZWWKa0dYb2ryJajAx8W9IR5kG65rBJymY+3MAkMI7PoXGBZE3j3vPq4t/NT80+VGN
 ecdiTA1YCKf4jG2yzGFJrfMumSGNuK7Iv3znkEQFqL1KQtU3UA9rD+41LMNkwMoy8II1
 hq6dT4wq2S4PKoqLWrKF6U92p2juvq/q5SC4ylo6NmPrr/7+mmJp5n8TvAAGayTSlO3Q
 oXnUZyAIRUPkML6Dk7D5uKwZdgiWS+wkt2ULzzq1b1zlcOTF8KmFTjLEtkSArYHRvzfL iw== 
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3b232akacs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Mon, 13 Sep 2021 18:18:23 -0400
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 18DMHkG0020845
        for <linux-integrity@vger.kernel.org>; Mon, 13 Sep 2021 22:18:22 GMT
Received: from b03cxnp08025.gho.boulder.ibm.com (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
        by ppma03dal.us.ibm.com with ESMTP id 3b0m3adawu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Mon, 13 Sep 2021 22:18:22 +0000
Received: from b03ledav005.gho.boulder.ibm.com (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
        by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 18DMILaQ51577312
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Sep 2021 22:18:21 GMT
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1D72CBE058;
        Mon, 13 Sep 2021 22:18:21 +0000 (GMT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CB5D7BE05D;
        Mon, 13 Sep 2021 22:18:20 +0000 (GMT)
Received: from sbct-2.pok.ibm.com (unknown [9.47.158.152])
        by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTP;
        Mon, 13 Sep 2021 22:18:20 +0000 (GMT)
From:   Stefan Berger <stefanb@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     zohar@linux.ibm.com, Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v4 1/9] evmctl: Implement support for EVMCTL_KEY_PASSWORD environment variable
Date:   Mon, 13 Sep 2021 18:18:05 -0400
Message-Id: <20210913221813.2554880-2-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210913221813.2554880-1-stefanb@linux.ibm.com>
References: <20210913221813.2554880-1-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: jD2dw7k690TNvs0BSodwGHbGE4953idw
X-Proofpoint-ORIG-GUID: jD2dw7k690TNvs0BSodwGHbGE4953idw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.687,Hydra:6.0.235,FMLib:17.0.607.475
 definitions=2020-10-13_15,2020-10-13_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 spamscore=0 impostorscore=0 mlxscore=0 mlxlogscore=999 lowpriorityscore=0
 malwarescore=0 bulkscore=0 priorityscore=1501 clxscore=1015 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109030001
 definitions=main-2109130042
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

If the user did not use the --pass option to provide a key password,
get the key password from the EVMCTL_KEY_PASSWORD environment variable.

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 README       | 4 ++++
 src/evmctl.c | 6 ++++++
 2 files changed, 10 insertions(+)

diff --git a/README b/README
index 87cd3b5..1cc027f 100644
--- a/README
+++ b/README
@@ -70,6 +70,10 @@ OPTIONS
   -v                 increase verbosity level
   -h, --help         display this help and exit
 
+Environment variables:
+
+EVMCTL_KEY_PASSWORD  : Private key password to use; do not use --pass option
+
 
 INTRODUCTION
 ------------
diff --git a/src/evmctl.c b/src/evmctl.c
index a8065bb..58f8e66 100644
--- a/src/evmctl.c
+++ b/src/evmctl.c
@@ -2530,6 +2530,9 @@ static void usage(void)
 		"      --ignore-violations ignore ToMToU measurement violations\n"
 		"  -v                 increase verbosity level\n"
 		"  -h, --help         display this help and exit\n"
+		"\n"
+		"Environment variables:\n\n"
+		"EVMCTL_KEY_PASSWORD  : Private key password to use; do not use --pass option\n"
 		"\n");
 }
 
@@ -2813,6 +2816,9 @@ int main(int argc, char *argv[])
 		}
 	}
 
+	if (!imaevm_params.keypass)
+		imaevm_params.keypass = getenv("EVMCTL_KEY_PASSWORD");
+
 	if (argv[optind] == NULL)
 		usage();
 	else
-- 
2.31.1

