Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3F855AF4F4
	for <lists+linux-integrity@lfdr.de>; Tue,  6 Sep 2022 21:55:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230186AbiIFTzP (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 6 Sep 2022 15:55:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230183AbiIFTxJ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 6 Sep 2022 15:53:09 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBD82B0893
        for <linux-integrity@vger.kernel.org>; Tue,  6 Sep 2022 12:50:56 -0700 (PDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 286Jhh8I012023;
        Tue, 6 Sep 2022 19:50:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=rSlLZ3DNSq6UVeaMkxAYlwRnw4cxT8C5DM0colvrAEQ=;
 b=r1Y6II2+jEywDUzff0XffnkRarVzaZyWJ9Hyyht6/ZuCSWq0OkcPeolyV6BYlF/G743u
 vtNLsOSb54PlTFAG+eTxrealXt4XEfMxbm5wXEaelJDO0tXvCSn39r0FAcg93CijcnQ8
 O+NG+6fDeoDg01d/9TktjJhZtBAcNprUpGl2fO+AAr/xSmDJ8OKczTGRV1BfrbijXQHr
 rrupmJ3EjAJTF4gG5BMCnhJvuvOuH0btXbskf0HATWKVQScnqmRbNGeBVgZa20zkudFf
 ANXvwutK2ngd4SwUjvwAzn/XWFLEXBt0cPOKg1xwUloDmcXbSV16OadsaQmfrCYjkZMq xg== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3jecm505yj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 06 Sep 2022 19:50:52 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 286JoAE1006463;
        Tue, 6 Sep 2022 19:50:50 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma03ams.nl.ibm.com with ESMTP id 3jbxj8v6g7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 06 Sep 2022 19:50:49 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 286Jol3Y41877856
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 6 Sep 2022 19:50:47 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0F31B11C04A;
        Tue,  6 Sep 2022 19:50:47 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CE73011C04C;
        Tue,  6 Sep 2022 19:50:45 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com.com (unknown [9.211.107.58])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  6 Sep 2022 19:50:45 +0000 (GMT)
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.ibm.com>, Petr Vorel <pvorel@suse.cz>,
        Vitaly Chikunov <vt@altlinux.org>,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH ima-evm-utils v2 09/12] Fix potential use after free in read_tpm_banks()
Date:   Tue,  6 Sep 2022 15:50:18 -0400
Message-Id: <20220906195021.854090-10-zohar@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220906195021.854090-1-zohar@linux.ibm.com>
References: <20220906195021.854090-1-zohar@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: UoDokO9yYN8sMvA2OiFkZd1qbKex8zMy
X-Proofpoint-ORIG-GUID: UoDokO9yYN8sMvA2OiFkZd1qbKex8zMy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-06_09,2022-09-06_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 bulkscore=0 priorityscore=1501 malwarescore=0 spamscore=0 impostorscore=0
 phishscore=0 mlxlogscore=958 adultscore=0 lowpriorityscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2209060090
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On failure to read TPM 2.0 bank PCRs 'errmsg' is not properly set to
NULL after being freed.  Fix potential use after free.

Fixes: 3472f9ba9c05 ("ima-evm-utils: read the PCRs for the requested TPM banks")
Reviewed-by: Petr Vorel <pvorel@suse.cz>
Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
---
 src/evmctl.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/src/evmctl.c b/src/evmctl.c
index fa588e0caba2..a497b1a468d6 100644
--- a/src/evmctl.c
+++ b/src/evmctl.c
@@ -2075,6 +2075,7 @@ static int read_tpm_banks(int num_banks, struct tpm_bank_info *bank)
 				log_debug("Failed to read %s PCRs: (%s)\n",
 					  bank[i].algo_name, errmsg);
 				free(errmsg);
+				errmsg = NULL;
 				bank[i].supported = 0;
 			}
 		}
-- 
2.31.1

