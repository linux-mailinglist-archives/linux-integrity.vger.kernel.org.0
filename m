Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 698C33C16CD
	for <lists+linux-integrity@lfdr.de>; Thu,  8 Jul 2021 18:04:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229592AbhGHQG4 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 8 Jul 2021 12:06:56 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:28667 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229992AbhGHQGz (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 8 Jul 2021 12:06:55 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 168G35kG010199
        for <linux-integrity@vger.kernel.org>; Thu, 8 Jul 2021 12:04:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=OheOjOvjFCHWUFxL8esB+H/tHA6Itrq2T6gbh1QiIU8=;
 b=OcTjg9h9UuTABDPZbNQyIExHD6bctlJX81QhbpoWZCriB+XiH3ylIfV87aHF6s2GI1r9
 gNMGexvCVTQZxuzmk/hNfXYtos8FdvpH8QKodCbHdehrU685bzdTqokjoM9QUzxREt2U
 xjMpBbjrhYbg7Ol8B59jKzQjHMEjtcd0BztM4FabHmnnKBfZEqcrlR2h5KXGd2RJWLOM
 Zm3AoHiqEa+NKu6nRoDW6B5TvbFcmBWeNoAvclJ/SiAuAWOvcnyMcmNT4WSCU8jhRAWs
 lqvC1wPe1taamnzy15B9GgbqXslB/LRnmsWIPIMtoScDCzhC16EkS5Oqmdi/Qypc7gwP UA== 
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com [169.63.121.186])
        by mx0a-001b2d01.pphosted.com with ESMTP id 39p2yf3ecv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Thu, 08 Jul 2021 12:04:12 -0400
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
        by ppma03wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 168FvhlS016608
        for <linux-integrity@vger.kernel.org>; Thu, 8 Jul 2021 16:04:11 GMT
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com [9.57.198.25])
        by ppma03wdc.us.ibm.com with ESMTP id 39jfhd79rj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Thu, 08 Jul 2021 16:04:11 +0000
Received: from b01ledav002.gho.pok.ibm.com (b01ledav002.gho.pok.ibm.com [9.57.199.107])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 168G4AlJ32244012
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 8 Jul 2021 16:04:10 GMT
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 15BE0124064;
        Thu,  8 Jul 2021 16:04:10 +0000 (GMT)
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 082EC124062;
        Thu,  8 Jul 2021 16:04:10 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.47.158.155])
        by b01ledav002.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu,  8 Jul 2021 16:04:09 +0000 (GMT)
From:   Stefan Berger <stefanb@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     zohar@linux.ibm.com, Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH ima-evm-utils v2 1/4] evmctl: Remove filtering support for file types unsupported by IMA
Date:   Thu,  8 Jul 2021 12:04:05 -0400
Message-Id: <20210708160408.2779849-2-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210708160408.2779849-1-stefanb@linux.ibm.com>
References: <20210708160408.2779849-1-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 8upYi8Qw0CeXuPqSzqzQb_mQBtYEDUkR
X-Proofpoint-GUID: 8upYi8Qw0CeXuPqSzqzQb_mQBtYEDUkR
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-08_09:2021-07-08,2021-07-08 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 lowpriorityscore=0 bulkscore=0 spamscore=0 priorityscore=1501
 clxscore=1015 malwarescore=0 mlxlogscore=999 impostorscore=0 adultscore=0
 mlxscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2107080083
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Remove support for filtering on file types unsupported by IMA from evmctl.
This now prevents func(de->d_name) to be invoked on symlinks, block device
files, etc. since signature verification on those file types is not
supported by IMA in the kernel.

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 README       |  2 +-
 src/evmctl.c | 13 +------------
 2 files changed, 2 insertions(+), 13 deletions(-)

diff --git a/README b/README
index 321045d..2ccac46 100644
--- a/README
+++ b/README
@@ -51,7 +51,7 @@ OPTIONS
   -o, --portable     generate portable EVM signatures
   -p, --pass         password for encrypted signing key
   -r, --recursive    recurse into directories (sign)
-  -t, --type         file types to fix 'fdsxm' (f: file, d: directory, s: block/char/symlink)
+  -t, --type         file types to fix 'fxm' (f: file)
                      x - skip fixing if both ima and evm xattrs exist (use with caution)
                      m - stay on the same filesystem (like 'find -xdev')
   -n                 print result to stdout instead of setting xattr
diff --git a/src/evmctl.c b/src/evmctl.c
index 7a6f202..04f14af 100644
--- a/src/evmctl.c
+++ b/src/evmctl.c
@@ -142,10 +142,6 @@ typedef int (*find_cb_t)(const char *path);
 static int find(const char *path, int dts, find_cb_t func);
 
 #define REG_MASK	(1 << DT_REG)
-#define DIR_MASK	(1 << DT_DIR)
-#define LNK_MASK	(1 << DT_LNK)
-#define CHR_MASK	(1 << DT_CHR)
-#define BLK_MASK	(1 << DT_BLK)
 
 struct command cmds[];
 static void print_usage(struct command *cmd);
@@ -668,10 +664,6 @@ static int get_file_type(const char *path, const char *search_type)
 		switch (search_type[i]) {
 		case 'f':
 			dts |= REG_MASK; break;
-		case 'd':
-			dts |= DIR_MASK; break;
-		case 's':
-			dts |= BLK_MASK | CHR_MASK | LNK_MASK; break;
 		case 'x':
 			check_xattr = true; break;
 		case 'm':
@@ -1371,9 +1363,6 @@ static int find(const char *path, int dts, find_cb_t func)
 		return -1;
 	}
 
-	if (dts & DIR_MASK)
-		func(path);
-
 	closedir(dir);
 
 	return 0;
@@ -2517,7 +2506,7 @@ static void usage(void)
 		"  -o, --portable     generate portable EVM signatures\n"
 		"  -p, --pass         password for encrypted signing key\n"
 		"  -r, --recursive    recurse into directories (sign)\n"
-		"  -t, --type         file types to fix 'fdsxm' (f: file, d: directory, s: block/char/symlink)\n"
+		"  -t, --type         file types to fix 'fxm' (f: file)\n"
 		"                     x - skip fixing if both ima and evm xattrs exist (use with caution)\n"
 		"                     m - stay on the same filesystem (like 'find -xdev')\n"
 		"  -n                 print result to stdout instead of setting xattr\n"
-- 
2.31.1

