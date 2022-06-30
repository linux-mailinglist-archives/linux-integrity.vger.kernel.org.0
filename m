Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16140560EED
	for <lists+linux-integrity@lfdr.de>; Thu, 30 Jun 2022 04:05:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231216AbiF3CED (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 29 Jun 2022 22:04:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiF3CEC (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 29 Jun 2022 22:04:02 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53D3D32061;
        Wed, 29 Jun 2022 19:04:02 -0700 (PDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25U22036000315;
        Thu, 30 Jun 2022 02:04:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=exBZ8Y35ByIv3jK7eL0z+GX/KE70ys8GCo5ukmKfkRk=;
 b=sA08ls4WgS+2Bg8QeVlmQXTg4hF1g2ZS67gR6Zm2dupGPT5NloB/SNgFP0eq3gkWr/UQ
 PlkvjsnuCam+7150PHmq9Umv7RXIyj2wJ9AKeHL/F3myadWoYwPgPOGLU6UD8DsGLAYl
 Z+GZRL3LZQAI+lFCX2oQrcQuduAznYhFVTCIQwf7Ma671flN9IISGv66ItzP1Cl/If7V
 SABPfZVAFUbU0+luu78z8Wzo0wkrUj7iYd2N6nxht+UcVz6+ERTeTtJ/1OPGa3366sOl
 JcvFKXB5xnDnmdk+NotR5/dxDRnEmo94vBjJCdiBFWGzCSCCxYFT9H5IOQyQVAzYinZm 1A== 
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com [169.47.144.26])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3h12pnr11k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 30 Jun 2022 02:04:01 +0000
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
        by ppma04wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 25U1pGKZ015883;
        Thu, 30 Jun 2022 02:04:00 GMT
Received: from b03cxnp08027.gho.boulder.ibm.com (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
        by ppma04wdc.us.ibm.com with ESMTP id 3gwt0a6xys-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 30 Jun 2022 02:04:00 +0000
Received: from b03ledav003.gho.boulder.ibm.com (b03ledav003.gho.boulder.ibm.com [9.17.130.234])
        by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 25U23xdg11338138
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 Jun 2022 02:03:59 GMT
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9A9EE6A051;
        Thu, 30 Jun 2022 02:03:59 +0000 (GMT)
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 433C46A047;
        Thu, 30 Jun 2022 02:03:59 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b03ledav003.gho.boulder.ibm.com (Postfix) with ESMTP;
        Thu, 30 Jun 2022 02:03:59 +0000 (GMT)
From:   Stefan Berger <stefanb@linux.ibm.com>
To:     zohar@linux.ibm.com, linux-integrity@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH] ima: Defer query for iversion until it is needed
Date:   Wed, 29 Jun 2022 22:03:46 -0400
Message-Id: <20220630020346.1151942-1-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: I_EbhZqzUTVesNv60kAeU5X3dg-bwVgy
X-Proofpoint-ORIG-GUID: I_EbhZqzUTVesNv60kAeU5X3dg-bwVgy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-06-29_24,2022-06-28_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 bulkscore=0 mlxscore=0 adultscore=0 clxscore=1015
 malwarescore=0 spamscore=0 mlxlogscore=999 phishscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206300006
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Defer the query for the iversion until it is needed.

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 security/integrity/ima/ima_api.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/security/integrity/ima/ima_api.c b/security/integrity/ima/ima_api.c
index c1e76282b5ee..4410d45eb281 100644
--- a/security/integrity/ima/ima_api.c
+++ b/security/integrity/ima/ima_api.c
@@ -248,7 +248,6 @@ int ima_collect_measurement(struct integrity_iint_cache *iint,
 	int result = 0;
 	int length;
 	void *tmpbuf;
-	u64 i_version;
 
 	/*
 	 * Always collect the modsig, because IMA might have already collected
@@ -267,7 +266,6 @@ int ima_collect_measurement(struct integrity_iint_cache *iint,
 	 * to an initial measurement/appraisal/audit, but was modified to
 	 * assume the file changed.
 	 */
-	i_version = inode_query_iversion(inode);
 	hash.hdr.algo = algo;
 	hash.hdr.length = hash_digest_size[algo];
 
@@ -304,7 +302,7 @@ int ima_collect_measurement(struct integrity_iint_cache *iint,
 
 	iint->ima_hash = tmpbuf;
 	memcpy(iint->ima_hash, &hash, length);
-	iint->version = i_version;
+	iint->version = inode_query_iversion(inode);
 
 	/* Possibly temporary failure due to type of read (eg. O_DIRECT) */
 	if (!result)
-- 
2.36.1

