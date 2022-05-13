Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 805315268A9
	for <lists+linux-integrity@lfdr.de>; Fri, 13 May 2022 19:42:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357536AbiEMRlZ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 13 May 2022 13:41:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378054AbiEMRlX (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 13 May 2022 13:41:23 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E46CA37016;
        Fri, 13 May 2022 10:41:22 -0700 (PDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24DFoNNJ029518;
        Fri, 13 May 2022 17:41:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=A3XnZQ6YpqtO40TftLuafxyiFzB/TUNuZXRH/RS1lUA=;
 b=aOOfdG8AoetdKnbZYcbjpcNC8Kn5L1qGs2fU2/qt06OfJwEoK3yhf7DIcfFYNvP8BJ9e
 Jwlr6DNc3WdLTa61chZsWcuj8OCbAy+cVdF+xoHtoRiTNSCTmJcjez0f2vFKb8yZjHQV
 O+ZDgluG19oCx4VpXEUCSjAMMqxw3+GwzlV143xtA8O8romhCFxC2h6CMmJFsSejm5KE
 iiujvw9ecT8L2itRcsQ1HOzGvidVVVwqDMzWUEnj87vSQ/eunJMQ8tWz6fk3T6dkmB4v
 WGgVGcgAEU+ZoD6Nqmla+dYOT9z4KZVWl7Chw1h6dxdy4lfAcNN420rCBKl9izvPcZpN 4A== 
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3g1tay21a8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 13 May 2022 17:41:22 +0000
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 24DHI1VG021464;
        Fri, 13 May 2022 17:41:21 GMT
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com [9.57.198.24])
        by ppma04dal.us.ibm.com with ESMTP id 3fwgdaxrvh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 13 May 2022 17:41:21 +0000
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com [9.57.199.106])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 24DHfKKM53674246
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 13 May 2022 17:41:20 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9867E28068;
        Fri, 13 May 2022 17:41:20 +0000 (GMT)
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 81C742805C;
        Fri, 13 May 2022 17:41:20 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTP;
        Fri, 13 May 2022 17:41:20 +0000 (GMT)
From:   Stefan Berger <stefanb@linux.ibm.com>
To:     zohar@linux.ibm.com, linux-integrity@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH] evm: Clean up some variables
Date:   Fri, 13 May 2022 13:41:05 -0400
Message-Id: <20220513174105.3684229-1-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: L6-_QRwc0t-i2i1oIRntaZXFSyDdfc3Z
X-Proofpoint-GUID: L6-_QRwc0t-i2i1oIRntaZXFSyDdfc3Z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-13_09,2022-05-13_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 priorityscore=1501 mlxscore=0 mlxlogscore=999 lowpriorityscore=0
 spamscore=0 malwarescore=0 phishscore=0 impostorscore=0 clxscore=1015
 suspectscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2202240000 definitions=main-2205130074
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Make hmac_tfm static since it's not used anywhere else besides the file
it is in.

Remove declaration of hash_tfm since it doesn't exist.

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 security/integrity/evm/evm.h        | 3 ---
 security/integrity/evm/evm_crypto.c | 2 +-
 2 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/security/integrity/evm/evm.h b/security/integrity/evm/evm.h
index 0d44f41d16f8..f8b8c5004fc7 100644
--- a/security/integrity/evm/evm.h
+++ b/security/integrity/evm/evm.h
@@ -38,9 +38,6 @@ extern int evm_initialized;
 
 extern int evm_hmac_attrs;
 
-extern struct crypto_shash *hmac_tfm;
-extern struct crypto_shash *hash_tfm;
-
 /* List of EVM protected security xattrs */
 extern struct list_head evm_config_xattrnames;
 
diff --git a/security/integrity/evm/evm_crypto.c b/security/integrity/evm/evm_crypto.c
index 0450d79afdc8..a733aff02006 100644
--- a/security/integrity/evm/evm_crypto.c
+++ b/security/integrity/evm/evm_crypto.c
@@ -26,7 +26,7 @@
 static unsigned char evmkey[MAX_KEY_SIZE];
 static const int evmkey_len = MAX_KEY_SIZE;
 
-struct crypto_shash *hmac_tfm;
+static struct crypto_shash *hmac_tfm;
 static struct crypto_shash *evm_tfm[HASH_ALGO__LAST];
 
 static DEFINE_MUTEX(mutex);
-- 
2.35.1

