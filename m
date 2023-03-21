Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 959EB6C2A43
	for <lists+linux-integrity@lfdr.de>; Tue, 21 Mar 2023 07:14:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229646AbjCUGOd (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 21 Mar 2023 02:14:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230119AbjCUGOc (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 21 Mar 2023 02:14:32 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAFDC3C1A;
        Mon, 20 Mar 2023 23:14:30 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32KM4dTS019776;
        Tue, 21 Mar 2023 06:14:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2022-7-12; bh=ZOl7fW9E2m8w3D6IDDukX+qWzbE312TtGl5lZIx8pKo=;
 b=tA+wig2GQBjRAPOb/j4orpZUCSj2sGk3N+LvFrwSqIsJp7xjrhGF2SNXqpToE0vILCqZ
 OVFhzL8GlNxMpPdG2mJRaRB3z/5Uwp1HK7dMe/XBY1uorztI56XOMMgPastqUmwca7Sh
 Ms2ElgdLw/mf80k9L7rl/S5dGQIuCJr+DSYqos4f3je2ZIkgkjMhSonX3GOYZJ4cspZq
 SalTQ8m1K1oZj6VbkCW4A6d6ktIT/Cq0GcooRSj9aBcBmY+tywBGuoKfp4vejJHnl5Xu
 Iu+bJEJbf3CqE3cZS8VCEncFfNYEHlRokUX0WMyMHlY+kMVP1pN7PRbj3Y35asUmJdx9 UA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pd3qdn890-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Mar 2023 06:14:23 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32L5YTHh006382;
        Tue, 21 Mar 2023 06:14:22 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3pd3r58mg1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Mar 2023 06:14:22 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 32L6EL2J032882;
        Tue, 21 Mar 2023 06:14:21 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3pd3r58mfr-1;
        Tue, 21 Mar 2023 06:14:21 +0000
From:   Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Cc:     error27@gmail.com,
        Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH next] tpm: Fix a possible dereference of ERR_PTR in tpm_init()
Date:   Mon, 20 Mar 2023 23:14:15 -0700
Message-Id: <20230321061416.626561-1-harshit.m.mogalapalli@oracle.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-21_03,2023-03-20_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 mlxscore=0
 mlxlogscore=999 malwarescore=0 suspectscore=0 adultscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303150002
 definitions=main-2303210048
X-Proofpoint-GUID: RS7UITh5dQhsbbRicWWnSQx0DUOHpg34
X-Proofpoint-ORIG-GUID: RS7UITh5dQhsbbRicWWnSQx0DUOHpg34
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Smatch reports:
	drivers/char/tpm/tpm-interface.c:470 tpm_init() error:
	'tpm_class' dereferencing possible ERR_PTR()

If class_create() returns error pointer, we are dereferencing a possible
error pointer. Fix this by moving the dereference post error handling.

Fixes: a010eb881243 ("tpm: fix up the tpm_class shutdown_pre pointer when created")
Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
---
This is based on static analysis, only compile tested.
---
 drivers/char/tpm/tpm-interface.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
index 43e23a04433a..4463d0018290 100644
--- a/drivers/char/tpm/tpm-interface.c
+++ b/drivers/char/tpm/tpm-interface.c
@@ -467,12 +467,13 @@ static int __init tpm_init(void)
 	int rc;
 
 	tpm_class = class_create("tpm");
-	tpm_class->shutdown_pre = tpm_class_shutdown;
 	if (IS_ERR(tpm_class)) {
 		pr_err("couldn't create tpm class\n");
 		return PTR_ERR(tpm_class);
 	}
 
+	tpm_class->shutdown_pre = tpm_class_shutdown;
+
 	tpmrm_class = class_create("tpmrm");
 	if (IS_ERR(tpmrm_class)) {
 		pr_err("couldn't create tpmrm class\n");
-- 
2.38.1

