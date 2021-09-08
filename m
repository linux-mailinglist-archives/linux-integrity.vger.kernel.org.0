Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6B1F403FC3
	for <lists+linux-integrity@lfdr.de>; Wed,  8 Sep 2021 21:23:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350413AbhIHTYz (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 8 Sep 2021 15:24:55 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:5762 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230049AbhIHTYz (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 8 Sep 2021 15:24:55 -0400
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 188J389u169367
        for <linux-integrity@vger.kernel.org>; Wed, 8 Sep 2021 15:23:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=3s/Cuvk8uFIzO4GGeYBnXau1uPAT/SpUS2j5rArZATo=;
 b=CcqOuEOhiyPH9s81d2D89JB26Hg/tcniWan+CCbzhoZjxZfmdg7OwU3ZjzlH/cmNy4HA
 KAUazO20+aw80WRnJaaSwbZJOdHgs94VCNxbGuqJYyHzkg3ba/wu5L2hbu/WME+BGzMP
 N3qSlydjFWGQv649nRg6l8cVdsM/p7sszJQvdGY0A4MAxnfpcPl3Img26WWqS1mGw6BC
 5qWKNUPQN2pe00ymGFfZKo9zdTxhfo0g+NqwjDyGMe+ZwOR6op7h1aTf2aR//cuUgIL+
 xif+ZK4Vw6ZdXHlgyPx8UyLx7ubqB0G1v8TlXCRYVrZ+YsxMn/XJ58HhHA1+NfOSJKQ3 DQ== 
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3ay222sppk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Wed, 08 Sep 2021 15:23:46 -0400
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 188JI5FO003511
        for <linux-integrity@vger.kernel.org>; Wed, 8 Sep 2021 19:23:46 GMT
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com [9.57.198.26])
        by ppma03dal.us.ibm.com with ESMTP id 3axcnja3sh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Wed, 08 Sep 2021 19:23:46 +0000
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com [9.57.199.109])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 188JNjG618284988
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 8 Sep 2021 19:23:45 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4FFD711206E;
        Wed,  8 Sep 2021 19:23:45 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 37A0211206D;
        Wed,  8 Sep 2021 19:23:45 +0000 (GMT)
Received: from sbct-2.pok.ibm.com (unknown [9.47.158.152])
        by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed,  8 Sep 2021 19:23:45 +0000 (GMT)
From:   Stefan Berger <stefanb@linux.vnet.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     zohar@linux.ibm.com, Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v3 1/9] evmctl: Implement support for EVMCTL_KEY_PASSWORD environment variable
Date:   Wed,  8 Sep 2021 15:23:35 -0400
Message-Id: <20210908192343.4147739-2-stefanb@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210908192343.4147739-1-stefanb@linux.vnet.ibm.com>
References: <20210908192343.4147739-1-stefanb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: hVE9t6ZhyL5A26tnRMSmSAz8KjthVafA
X-Proofpoint-ORIG-GUID: hVE9t6ZhyL5A26tnRMSmSAz8KjthVafA
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-09-08_06:2021-09-07,2021-09-08 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 priorityscore=1501 suspectscore=0 mlxlogscore=999 malwarescore=0
 clxscore=1015 bulkscore=0 mlxscore=0 adultscore=0 lowpriorityscore=0
 spamscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109030001 definitions=main-2109080120
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Stefan Berger <stefanb@linux.ibm.com>

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

