Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D21BB72E3DC
	for <lists+linux-integrity@lfdr.de>; Tue, 13 Jun 2023 15:15:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240496AbjFMNP4 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 13 Jun 2023 09:15:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242107AbjFMNPv (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 13 Jun 2023 09:15:51 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 604021720
        for <linux-integrity@vger.kernel.org>; Tue, 13 Jun 2023 06:15:50 -0700 (PDT)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35DDF11U027361
        for <linux-integrity@vger.kernel.org>; Tue, 13 Jun 2023 13:15:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=4F59C9+ZrATH8uht4z4MZ2LVruUuHai1gDuPd09reEk=;
 b=iVaugnX+cm5ScFOR345ZCHbDYzqwNWEU6YbEcyI5W/ZjTiJrTDt42LgNzRfGjo/9QMgI
 qiEpE1nFav12hL7R5t7XJOrjGSqeLT5M2y21Rqv87AKMi/85VTPHes7lVBjgdQFFOEMh
 VENz5J1xvfYDQbaSucyO6tB2wEHeVdCDV632MfBicbvG9y9uEHf2xEXv886Qee4kXBjH
 JYOfkjNBLV/rB2AeXqs487gTX79hmW5+v1yx687LmFOXjzPsAmLBZ2cCvvk26FZToPCy
 YTdYbp3DxkoFrl5l+4xDZYxebyFOIQcMdiwJVi6O47OMmQ+T9JGkIrmt6WbW11tFvoWO 7w== 
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3r6rcv9f08-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Tue, 13 Jun 2023 13:15:49 +0000
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 35D9UeHa030211
        for <linux-integrity@vger.kernel.org>; Tue, 13 Jun 2023 13:15:48 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([9.208.130.102])
        by ppma03dal.us.ibm.com (PPS) with ESMTPS id 3r4gt4w44v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Tue, 13 Jun 2023 13:15:48 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
        by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 35DDFlxm56295894
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 13 Jun 2023 13:15:47 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 637EF58065;
        Tue, 13 Jun 2023 13:15:47 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 250DF58052;
        Tue, 13 Jun 2023 13:15:47 +0000 (GMT)
Received: from sbct-2.pok.ibm.com (unknown [9.47.158.152])
        by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Tue, 13 Jun 2023 13:15:47 +0000 (GMT)
From:   Stefan Berger <stefanb@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     zohar@linux.ibm.com, Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH ima-evm-utils 2/2] Add note that when -p is used password must not be provided
Date:   Tue, 13 Jun 2023 09:15:42 -0400
Message-Id: <20230613131542.3603874-3-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230613131542.3603874-1-stefanb@linux.ibm.com>
References: <20230613131542.3603874-1-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: XapKIT_UrERYXcnuJXzQWPhooxbx-gt3
X-Proofpoint-GUID: XapKIT_UrERYXcnuJXzQWPhooxbx-gt3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-13_04,2023-06-12_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 priorityscore=1501 adultscore=0 suspectscore=0 lowpriorityscore=0
 mlxlogscore=999 bulkscore=0 phishscore=0 mlxscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306130115
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Add a note to the -p option description in the help screen stating that a
password must not be provided on the command line in this case since it
will be ignored and become the name of the file to sign.

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 README       | 1 +
 src/evmctl.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/README b/README
index 40a61f9..dbed7a5 100644
--- a/README
+++ b/README
@@ -60,6 +60,7 @@ OPTIONS
                      read keyid value from SKID of a x509 cert file
   -o, --portable     generate portable EVM signatures
   -p, --pass         password for encrypted signing key
+                     Do not provide password on command line when using -p
   -r, --recursive    recurse into directories (sign)
   -t, --type         file types to fix 'fxm' (f: file)
                      x - skip fixing if both ima and evm xattrs exist (use with caution)
diff --git a/src/evmctl.c b/src/evmctl.c
index 4b68091..2d0c779 100644
--- a/src/evmctl.c
+++ b/src/evmctl.c
@@ -2834,6 +2834,7 @@ static void usage(void)
 		"                     read keyid value from SKID of a x509 cert file\n"
 		"  -o, --portable     generate portable EVM signatures\n"
 		"  -p, --pass         password for encrypted signing key\n"
+		"                     Do not provide password on command line when using -p\n"
 		"  -r, --recursive    recurse into directories (sign)\n"
 		"  -t, --type         file types to fix 'fxm' (f: file)\n"
 		"                     x - skip fixing if both ima and evm xattrs exist (use with caution)\n"
-- 
2.39.2

