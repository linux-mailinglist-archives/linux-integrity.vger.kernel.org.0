Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 987BF3E5C17
	for <lists+linux-integrity@lfdr.de>; Tue, 10 Aug 2021 15:46:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241821AbhHJNq0 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 10 Aug 2021 09:46:26 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:63104 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241837AbhHJNqZ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 10 Aug 2021 09:46:25 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17ADZpqA188520
        for <linux-integrity@vger.kernel.org>; Tue, 10 Aug 2021 09:46:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=3s/Cuvk8uFIzO4GGeYBnXau1uPAT/SpUS2j5rArZATo=;
 b=b0z+eOqyfUYAParHB64WWQCy9YBaZjVYo8bsEjlonU6Y0LfyaSoOc5zmsaVk7VHEAy2u
 Zo6SS1aDy3KwngC7lFmp0fSptsAUwxhgJ+YeAif9A4xoOuzeclFUT4uZpq0I2rWp5r8T
 fT6c7gUIUWOKy0h63dgS3NQWo1SeoQ5tZ7E4FLSf8nJ66tcoCmyKdrw3rWWHqrNRQsHA
 SfF98NrI9cluBWJ1v4j5Dr9gmNV/83KFwDZfK1oyHJ5qCxfj+u42q4L6wh4mbYaB/55m
 iajG1lCb4kYisGkphwfcVW4irBI7VnXBzMbE09958C5cXz75wwvaxnfEeH7D3ynCW7Pj xg== 
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3abr2umm7j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Tue, 10 Aug 2021 09:46:03 -0400
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 17ADgnpq026060
        for <linux-integrity@vger.kernel.org>; Tue, 10 Aug 2021 13:46:03 GMT
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com [9.57.198.29])
        by ppma02dal.us.ibm.com with ESMTP id 3a9htdbcf2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Tue, 10 Aug 2021 13:46:01 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 17ADjxU339649762
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Aug 2021 13:45:59 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 03FC3B2075;
        Tue, 10 Aug 2021 13:45:59 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E2FEFB2083;
        Tue, 10 Aug 2021 13:45:58 +0000 (GMT)
Received: from sbct-2.. (unknown [9.47.158.152])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue, 10 Aug 2021 13:45:58 +0000 (GMT)
From:   Stefan Berger <stefanb@linux.vnet.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     zohar@linux.ibm.com, Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v2 1/8] evmctl: Implement support for EVMCTL_KEY_PASSWORD environment variable
Date:   Tue, 10 Aug 2021 09:45:50 -0400
Message-Id: <20210810134557.2444863-2-stefanb@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210810134557.2444863-1-stefanb@linux.vnet.ibm.com>
References: <20210810134557.2444863-1-stefanb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 2ZIic322O3sZRMLzlFsw3sXENVgx6Pqh
X-Proofpoint-ORIG-GUID: 2ZIic322O3sZRMLzlFsw3sXENVgx6Pqh
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-10_05:2021-08-10,2021-08-10 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 spamscore=0 bulkscore=0 suspectscore=0 mlxlogscore=999 lowpriorityscore=0
 phishscore=0 priorityscore=1501 clxscore=1015 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108100087
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

