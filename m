Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49BC3409F8D
	for <lists+linux-integrity@lfdr.de>; Tue, 14 Sep 2021 00:18:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236437AbhIMWTo (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 13 Sep 2021 18:19:44 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:12632 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235826AbhIMWTm (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 13 Sep 2021 18:19:42 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.0.43) with SMTP id 18DItvT8018771
        for <linux-integrity@vger.kernel.org>; Mon, 13 Sep 2021 18:18:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=zhmRYdcCcVsIcOpbpUFCUxi6e2NtUKHwhpB1aId5qxI=;
 b=KHq1u4FepK8AHGCpAJx+LhEhkkv0bhE+vmoB81tSSgTqyfqhns6UxFD9X0kf0kM7wzDH
 MdTUSaTmd5E7iZh3AdDuDllh3sXkmlbLZPXwu4EpRsxunNaeE7YUbaYy7GhdGmLF7lpk
 iGIPxOxmMhYqlYhqQGYd1N28IkiTIVwfZbfm3IES9S8APw1qsOMxxrOmsObcxiVJSdLe
 KtCZ3KE+FYrZl78a4Df7kpAjSBA99T57n3ThFnZi9t/sntMwvxSVqAh9lWY76xXxkCXr
 00TW78+0P6A8looLGMlJb6kJZQAEDKhFSMruc4ycSIDEdrhzSTtBTcNQ6Kn4aBJP39ue 8w== 
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3b23ha2m5s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Mon, 13 Sep 2021 18:18:25 -0400
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 18DMGoZn032016
        for <linux-integrity@vger.kernel.org>; Mon, 13 Sep 2021 22:18:24 GMT
Received: from b03cxnp08026.gho.boulder.ibm.com (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
        by ppma02dal.us.ibm.com with ESMTP id 3b0m3ad8dc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Mon, 13 Sep 2021 22:18:24 +0000
Received: from b03ledav005.gho.boulder.ibm.com (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
        by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 18DMIM1k35717610
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Sep 2021 22:18:23 GMT
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E153FBE06F;
        Mon, 13 Sep 2021 22:18:22 +0000 (GMT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 82C1EBE05D;
        Mon, 13 Sep 2021 22:18:22 +0000 (GMT)
Received: from sbct-2.pok.ibm.com (unknown [9.47.158.152])
        by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTP;
        Mon, 13 Sep 2021 22:18:22 +0000 (GMT)
From:   Stefan Berger <stefanb@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     zohar@linux.ibm.com, Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v4 5/9] evmctl: use the pkcs11 engine for pkcs11: prefixed URIs
Date:   Mon, 13 Sep 2021 18:18:09 -0400
Message-Id: <20210913221813.2554880-6-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210913221813.2554880-1-stefanb@linux.ibm.com>
References: <20210913221813.2554880-1-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: JztyWFDJPvOcE3HyQT1npBVzPrDayY5_
X-Proofpoint-ORIG-GUID: JztyWFDJPvOcE3HyQT1npBVzPrDayY5_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.687,Hydra:6.0.235,FMLib:17.0.607.475
 definitions=2020-10-13_15,2020-10-13_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 clxscore=1015 impostorscore=0 adultscore=0 suspectscore=0 phishscore=0
 bulkscore=0 mlxscore=0 mlxlogscore=621 malwarescore=0 spamscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109030001 definitions=main-2109130047
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

If the key has the pkcs11: URI prefix then setup the pkcs11 engine
if the user hasn't chosen a specific engine already.

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 src/evmctl.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/src/evmctl.c b/src/evmctl.c
index 625a511..5178643 100644
--- a/src/evmctl.c
+++ b/src/evmctl.c
@@ -2827,6 +2827,14 @@ int main(int argc, char *argv[])
 	if (!imaevm_params.keypass)
 		imaevm_params.keypass = getenv("EVMCTL_KEY_PASSWORD");
 
+	if (imaevm_params.keyfile != NULL &&
+	    imaevm_params.eng == NULL &&
+	    !strncmp(imaevm_params.keyfile, "pkcs11:", 7)) {
+		imaevm_params.eng = setup_engine("pkcs11");
+		if (!imaevm_params.eng)
+			goto error;
+	}
+
 	if (argv[optind] == NULL)
 		usage();
 	else
-- 
2.31.1

