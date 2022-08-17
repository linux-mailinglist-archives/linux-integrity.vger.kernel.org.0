Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B53C597751
	for <lists+linux-integrity@lfdr.de>; Wed, 17 Aug 2022 22:05:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241692AbiHQUD6 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 17 Aug 2022 16:03:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241681AbiHQUD4 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 17 Aug 2022 16:03:56 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E02F32A274;
        Wed, 17 Aug 2022 13:03:53 -0700 (PDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27HJa2kt007348;
        Wed, 17 Aug 2022 20:03:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=hkP6vkzG1UzEeJ5qw6RixMD6hdOhHsYT208NFv3dvTM=;
 b=cmoLyAzv3lt2dgSxmyesxjcpkn3qOTR3b+zmNpxqYLYKmmSQnKtRPpfensDUPZs+H8Ti
 UsU7rm8YLoiCEa+JHoCgBJqfkDJ/lrd1B3wg9xLpiQRRYOyLaORi8Q+fF2gDURh/Y9JP
 NB11/ffh+tTIzLsmOjuIbtgDEaMq/shRIpj9v36t3/vqpnDPlXBBn7SsP+KNeMTwNiP/
 F4QKF2PycvQgh9shsmfGUsoVoVC00bpA7umE21Oyf6NHNS52uEigqLBWh7E9rgdORHF1
 kNAXR2KadA9eQ4eBaEGYOrPmx72ByduLqS2AzA9HvFnR7Wz6/OiIjmoAeMOunrSsupPH 5A== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3j15hkjspa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 17 Aug 2022 20:03:41 +0000
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 27HK0AFN011324;
        Wed, 17 Aug 2022 20:03:40 GMT
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com [169.55.91.170])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3j15hkjsnq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 17 Aug 2022 20:03:40 +0000
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
        by ppma02wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 27HJZul9022737;
        Wed, 17 Aug 2022 20:03:39 GMT
Received: from b03cxnp08028.gho.boulder.ibm.com (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
        by ppma02wdc.us.ibm.com with ESMTP id 3hx3ka2mhj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 17 Aug 2022 20:03:39 +0000
Received: from b03ledav001.gho.boulder.ibm.com (b03ledav001.gho.boulder.ibm.com [9.17.130.232])
        by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 27HK3cPk9306666
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 17 Aug 2022 20:03:38 GMT
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C4E896E054;
        Wed, 17 Aug 2022 20:03:38 +0000 (GMT)
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CAE446E04E;
        Wed, 17 Aug 2022 20:03:37 +0000 (GMT)
Received: from slate16.aus.stglabs.ibm.com (unknown [9.160.23.1])
        by b03ledav001.gho.boulder.ibm.com (Postfix) with ESMTP;
        Wed, 17 Aug 2022 20:03:37 +0000 (GMT)
From:   Eddie James <eajames@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Alexander.Steffen@infineon.com,
        jgg@ziepe.ca, jarkko@kernel.org, peterhuewe@gmx.de, joel@jms.id.au,
        Eddie James <eajames@linux.ibm.com>
Subject: [PATCH] tpm: tis_i2c: Fix sanity check interrupt enable mask
Date:   Wed, 17 Aug 2022 15:03:33 -0500
Message-Id: <20220817200333.305264-1-eajames@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 03ACpAjt4_Dw7t6To8DmMaTFR1wcpBWC
X-Proofpoint-ORIG-GUID: ru2K3RYWGUsaCpUC9xEEwhTC9JXc9bdr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-17_13,2022-08-16_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 lowpriorityscore=0 malwarescore=0 clxscore=1011 mlxlogscore=910
 impostorscore=0 phishscore=0 priorityscore=1501 spamscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208170075
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

The sanity check mask for TPM_INT_ENABLE register was off by 8 bits,
resulting in failure to probe if the TPM_INT_ENABLE register was a
valid value.

Fixes: bbc23a07b072 ("tpm: Add tpm_tis_i2c backend for tpm_tis_core")
Signed-off-by: Eddie James <eajames@linux.ibm.com>
---
 drivers/char/tpm/tpm_tis_i2c.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/char/tpm/tpm_tis_i2c.c b/drivers/char/tpm/tpm_tis_i2c.c
index 0692510dfcab..635a69dfcbbd 100644
--- a/drivers/char/tpm/tpm_tis_i2c.c
+++ b/drivers/char/tpm/tpm_tis_i2c.c
@@ -49,7 +49,7 @@
 
 /* Masks with bits that must be read zero */
 #define TPM_ACCESS_READ_ZERO 0x48
-#define TPM_INT_ENABLE_ZERO 0x7FFFFF6
+#define TPM_INT_ENABLE_ZERO 0x7FFFFF60
 #define TPM_STS_READ_ZERO 0x23
 #define TPM_INTF_CAPABILITY_ZERO 0x0FFFF000
 #define TPM_I2C_INTERFACE_CAPABILITY_ZERO 0x80000000
-- 
2.31.1

