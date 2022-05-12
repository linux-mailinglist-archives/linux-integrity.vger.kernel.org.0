Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B47B524BE7
	for <lists+linux-integrity@lfdr.de>; Thu, 12 May 2022 13:43:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353094AbiELLnO (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 12 May 2022 07:43:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351802AbiELLnN (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 12 May 2022 07:43:13 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCCD65BD24;
        Thu, 12 May 2022 04:43:12 -0700 (PDT)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24CBPdXq011183;
        Thu, 12 May 2022 11:43:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=VZbIDCul7T2Ww8sJEjj+xsE0H5qsntMAXBtOrgZzbxc=;
 b=S/CuAKWCxf4DvZrmjW8ErAmyX+2RgVqP653ujCC+/oz9Yea6zi3WgMM/D78DgB516PPB
 hSnt3c4PHd9wsojQpPjjI5sEb9dW7JMSnd1gWwcqsLD+yIt5LdLJ8C/klDiU5ma6mBSG
 d9tgWeCj5pkGCwHRyX3eZarpLl+Jluj0AspN4ERGneGQE046di/R1mzKLeVz194qYGpR
 IHSUNyuUO3xM9cZRWMQJqYS43Xr+GfjNLxHhMe6Dq/E1+u6XXP199JDN1u5LsrL6xMDN
 tlocHV5Y7TKZ+N1TX9daCOXiAyHzjVVM2eAl86hq3tCkvPXYpBr6CkQJM8/BlAJidUqm Lw== 
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com [169.55.91.170])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3g11bug8tc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 May 2022 11:43:12 +0000
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
        by ppma02wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 24CBbIb7031987;
        Thu, 12 May 2022 11:43:11 GMT
Received: from b03cxnp08028.gho.boulder.ibm.com (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
        by ppma02wdc.us.ibm.com with ESMTP id 3fwgda2wna-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 May 2022 11:43:11 +0000
Received: from b03ledav003.gho.boulder.ibm.com (b03ledav003.gho.boulder.ibm.com [9.17.130.234])
        by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 24CBhARV43516172
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 May 2022 11:43:10 GMT
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0CC496A05D;
        Thu, 12 May 2022 11:43:10 +0000 (GMT)
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A9D776A054;
        Thu, 12 May 2022 11:43:09 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b03ledav003.gho.boulder.ibm.com (Postfix) with ESMTP;
        Thu, 12 May 2022 11:43:09 +0000 (GMT)
From:   Stefan Berger <stefanb@linux.ibm.com>
To:     zohar@linux.ibm.com, linux-integrity@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH] evm: Return INTEGRITY_PASS for enum integrity_status value '0'
Date:   Thu, 12 May 2022 07:43:07 -0400
Message-Id: <20220512114307.3669972-1-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: FVgjLTIpGbMgE3v2a1Jhhqrluafzcg5W
X-Proofpoint-ORIG-GUID: FVgjLTIpGbMgE3v2a1Jhhqrluafzcg5W
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-12_02,2022-05-12_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=787 phishscore=0
 adultscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0
 clxscore=1015 priorityscore=1501 mlxscore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2205120052
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Return INTEGRITY_PASS for the enum integrity_status rather than 0.

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 security/integrity/evm/evm_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/integrity/evm/evm_main.c b/security/integrity/evm/evm_main.c
index 7d87772f0ce6..cc88f02c7562 100644
--- a/security/integrity/evm/evm_main.c
+++ b/security/integrity/evm/evm_main.c
@@ -436,7 +436,7 @@ static enum integrity_status evm_verify_current_integrity(struct dentry *dentry)
 	struct inode *inode = d_backing_inode(dentry);
 
 	if (!evm_key_loaded() || !S_ISREG(inode->i_mode) || evm_fixmode)
-		return 0;
+		return INTEGRITY_PASS;
 	return evm_verify_hmac(dentry, NULL, NULL, 0, NULL);
 }
 
-- 
2.35.1

