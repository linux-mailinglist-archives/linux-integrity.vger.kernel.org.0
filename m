Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17B103E485E
	for <lists+linux-integrity@lfdr.de>; Mon,  9 Aug 2021 17:10:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235293AbhHIPK6 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 9 Aug 2021 11:10:58 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:5522 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S235200AbhHIPK5 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 9 Aug 2021 11:10:57 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 179F4bVS083393
        for <linux-integrity@vger.kernel.org>; Mon, 9 Aug 2021 11:10:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=3s/Cuvk8uFIzO4GGeYBnXau1uPAT/SpUS2j5rArZATo=;
 b=dXdnrKhRjjpLi8uy63V5bt7+y17VcCyDFtJy9DNrIxWy60iL6u49/4bEWwiqumW0E70y
 S1vaUnPyK/BsKNZp6oTnDeHcGAuW47T/AfOgr8fdwWy0VPYrC4fy/Bp/kHbmuei/bAOM
 WPkk4ECDXNHVyDoDOzqEkEMTEhKW0NBbiQfGZgWyGJKNa0En5YSPCvWub7kOoRhjgNM8
 0cGzN8pxiXa0R23/PUZMou1djKd0kUXYRkuW6DzE5T47Zt6PI8UeWDJcL8j5RiEWKNxa
 mTYEbE4Bp6TuiJZY61HCiqHCLjkSjIrNc17NJDQmrmBC4EZ70/xMrP0OBh72suErc1nE hQ== 
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com [169.63.121.186])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3aax4072cw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Mon, 09 Aug 2021 11:10:34 -0400
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
        by ppma03wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 179F3f6e029625
        for <linux-integrity@vger.kernel.org>; Mon, 9 Aug 2021 15:10:30 GMT
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com [9.57.198.26])
        by ppma03wdc.us.ibm.com with ESMTP id 3a9htauwsb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Mon, 09 Aug 2021 15:10:30 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 179FATaQ9372104
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 9 Aug 2021 15:10:29 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5B3367E2EE;
        Mon,  9 Aug 2021 15:10:29 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4C7ED7E2ED;
        Mon,  9 Aug 2021 15:10:29 +0000 (GMT)
Received: from sbct-2.. (unknown [9.47.158.152])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon,  9 Aug 2021 15:10:29 +0000 (GMT)
From:   Stefan Berger <stefanb@linux.vnet.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     zohar@linux.ibm.com, Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH 1/4] evmctl: Implement support for EVMCTL_KEY_PASSWORD environment variable
Date:   Mon,  9 Aug 2021 11:10:23 -0400
Message-Id: <20210809151026.195038-2-stefanb@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210809151026.195038-1-stefanb@linux.vnet.ibm.com>
References: <20210809151026.195038-1-stefanb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: reqOZOtPpA2cJSyuwncaBFoe2SOijuL0
X-Proofpoint-GUID: reqOZOtPpA2cJSyuwncaBFoe2SOijuL0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-09_05:2021-08-06,2021-08-09 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 lowpriorityscore=0 suspectscore=0 priorityscore=1501 spamscore=0
 impostorscore=0 clxscore=1015 mlxlogscore=999 malwarescore=0 mlxscore=0
 adultscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108090111
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

