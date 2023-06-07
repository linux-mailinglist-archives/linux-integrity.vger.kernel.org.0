Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40B977265A2
	for <lists+linux-integrity@lfdr.de>; Wed,  7 Jun 2023 18:17:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233438AbjFGQRM (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 7 Jun 2023 12:17:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233845AbjFGQRG (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 7 Jun 2023 12:17:06 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A0561702;
        Wed,  7 Jun 2023 09:17:00 -0700 (PDT)
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 357GA3pX009984;
        Wed, 7 Jun 2023 16:16:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=YZNtjkkI9T51uNcuuhbSntzn8dpZVDQh6dU0E8G27dQ=;
 b=CE14uwG5Ps5OFwQMmqGxpxamABQajge+q+jee3zu9bWt5OsKt03HmLY2W8o1ncOIR0z3
 q+xRJU+YCaj1Ct0xUtuL16ZPY3/v2DG5Xf6VG3vJqnbZmw18+UM9Vc5m6x+eFyh9BGEt
 lZLm+YV22weH/po6Gj0FPc+KZek9hR3LHKMC89HiVuwSXOYjeHo20O7gtiU7u7ci7ZrV
 5EJKLw2qY2Jmz7aosw4e4nnE8mQ3CUxZYTDgxVoB0St8WHjSUACgUel73KaKBbBKnKQn
 q2YylOeK0UFlv0GPAJBDquJSu9SlogKZPHty8gLyh2+rraiN+sPtduyyYWzWxzkYaTja xw== 
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3r2vub0tpm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 07 Jun 2023 16:16:55 +0000
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 357ER2ka008966;
        Wed, 7 Jun 2023 16:16:55 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([9.208.129.113])
        by ppma01dal.us.ibm.com (PPS) with ESMTPS id 3r2a776utg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 07 Jun 2023 16:16:55 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
        by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 357GGrwi2163248
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 7 Jun 2023 16:16:53 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 65E8A58058;
        Wed,  7 Jun 2023 16:16:53 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1561D58057;
        Wed,  7 Jun 2023 16:16:53 +0000 (GMT)
Received: from sbct-2.pok.ibm.com (unknown [9.47.158.152])
        by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Wed,  7 Jun 2023 16:16:52 +0000 (GMT)
From:   Stefan Berger <stefanb@linux.ibm.com>
To:     linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        jarkko@kernel.org
Cc:     Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH] tpm: Check for availability of chip->ops before requesting locality
Date:   Wed,  7 Jun 2023 12:16:47 -0400
Message-Id: <20230607161647.3257117-1-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Y4TG5f6hfxaRpR5DOFOqZaz_Iugeg7wk
X-Proofpoint-ORIG-GUID: Y4TG5f6hfxaRpR5DOFOqZaz_Iugeg7wk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-07_07,2023-06-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 spamscore=0 malwarescore=0 phishscore=0 suspectscore=0
 mlxlogscore=882 impostorscore=0 adultscore=0 mlxscore=0 lowpriorityscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306070137
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

When executing kexec on ppc64 tpm_class_shutdown() is called before
tpm_chip_unregister() and therefore chip->ops is NULL when
tpm_amd_is_rng_defective() is called. Check for chip->ops before
requesting the locality in tpm_amd_is_rng_defective() to avoid a
crash.

Fixes: bd8621ca1510 ("tpm: Add !tpm_amd_is_rng_defective() to the hwrng_unregister() call site")
Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 drivers/char/tpm/tpm-chip.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
index cd48033b804a..bc1ec1632fd8 100644
--- a/drivers/char/tpm/tpm-chip.c
+++ b/drivers/char/tpm/tpm-chip.c
@@ -524,7 +524,7 @@ static bool tpm_amd_is_rng_defective(struct tpm_chip *chip)
 	u64 version;
 	int ret;
 
-	if (!(chip->flags & TPM_CHIP_FLAG_TPM2))
+	if (!chip->ops || !(chip->flags & TPM_CHIP_FLAG_TPM2))
 		return false;
 
 	ret = tpm_request_locality(chip);
-- 
2.39.1

