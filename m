Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 734C85B0A70
	for <lists+linux-integrity@lfdr.de>; Wed,  7 Sep 2022 18:44:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229718AbiIGQoU (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 7 Sep 2022 12:44:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229707AbiIGQoO (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 7 Sep 2022 12:44:14 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1455874CDC;
        Wed,  7 Sep 2022 09:43:57 -0700 (PDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 287FQok3027611;
        Wed, 7 Sep 2022 16:43:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=XKzpQ3NKsCgBVgEiqJa1ooTwl86JBBLgdI0DdILcKrM=;
 b=o3RkMLcKXjb4Z+YWIxUmBm2/zCkMkTvYb1rT5wL+e63WzmUwK4TdPQtSs2WrG/8jslvl
 QJxTX0KRiX8T14UzjMw/+Q1HIiQOT4MkQQ5YVLwbLJeK4L/igmg5VjdJB9BEpyf/pHXI
 LutUqCHg2kAMljlg/1kozurdRrRJ7ioJvHiXMzEX5uYO2iD9/r6LMX6zg+tEFf/Fz5xE
 UrlBBorN0Fq5NeQZ3PIykik0RmoNObz/CH73O2NmFibISBvfj6c+Qfpc4KtGPXizWwsW
 0JaLBFbMO+lIIJl8sVvHMTJi3vzVeAovblyWR+JY1tDktlrnNL9UKYgZgvi8Il7tntj5 TQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3jewxnjfnb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 07 Sep 2022 16:43:22 +0000
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 287FSkCR032420;
        Wed, 7 Sep 2022 16:43:22 GMT
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3jewxnjfn0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 07 Sep 2022 16:43:22 +0000
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 287GKWlL006145;
        Wed, 7 Sep 2022 16:43:21 GMT
Received: from b01cxnp22033.gho.pok.ibm.com (b01cxnp22033.gho.pok.ibm.com [9.57.198.23])
        by ppma03dal.us.ibm.com with ESMTP id 3jbxja9pje-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 07 Sep 2022 16:43:21 +0000
Received: from b01ledav002.gho.pok.ibm.com (b01ledav002.gho.pok.ibm.com [9.57.199.107])
        by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 287GhKdL2884252
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 7 Sep 2022 16:43:20 GMT
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C236E124054;
        Wed,  7 Sep 2022 16:43:20 +0000 (GMT)
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 29603124053;
        Wed,  7 Sep 2022 16:43:20 +0000 (GMT)
Received: from slate16.aus.stglabs.ibm.com (unknown [9.65.226.72])
        by b01ledav002.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed,  7 Sep 2022 16:43:20 +0000 (GMT)
From:   Eddie James <eajames@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, peterhuewe@gmx.de, jarkko@kernel.or,
        jgg@ziepe.ca, joel@jms.id.au, Alexander.Steffen@infineon.com,
        Eddie James <eajames@linux.ibm.com>
Subject: [PATCH] tpm: Add flag to use default cancellation policy
Date:   Wed,  7 Sep 2022 11:43:17 -0500
Message-Id: <20220907164317.80617-1-eajames@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: HU3f8M9Mz5uMtN5kL1buHpIC64LP2Rwn
X-Proofpoint-ORIG-GUID: 04oVuitsB1EDcgZu-hL2iO7n6Sg7qlLb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-07_08,2022-09-07_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 adultscore=0
 priorityscore=1501 mlxscore=0 clxscore=1011 phishscore=0 spamscore=0
 suspectscore=0 impostorscore=0 malwarescore=0 mlxlogscore=999
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2209070064
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

The check for cancelled request depends on the VID of the chip, but
some chips share VID which shouldn't share their cancellation
behavior. This is the case for the Nuvoton NPCT75X, which should use
the default cancellation check, not the Winbond one.
To avoid changing the existing behavior, add a new flag to indicate
that the chip should use the default cancellation check and set it
for the I2C TPM2 TIS driver.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
---
 drivers/char/tpm/tpm_tis_core.c | 18 ++++++++++--------
 drivers/char/tpm/tpm_tis_core.h |  1 +
 drivers/char/tpm/tpm_tis_i2c.c  |  1 +
 3 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
index 757623bacfd5..175e75337395 100644
--- a/drivers/char/tpm/tpm_tis_core.c
+++ b/drivers/char/tpm/tpm_tis_core.c
@@ -682,15 +682,17 @@ static bool tpm_tis_req_canceled(struct tpm_chip *chip, u8 status)
 {
 	struct tpm_tis_data *priv = dev_get_drvdata(&chip->dev);
 
-	switch (priv->manufacturer_id) {
-	case TPM_VID_WINBOND:
-		return ((status == TPM_STS_VALID) ||
-			(status == (TPM_STS_VALID | TPM_STS_COMMAND_READY)));
-	case TPM_VID_STM:
-		return (status == (TPM_STS_VALID | TPM_STS_COMMAND_READY));
-	default:
-		return (status == TPM_STS_COMMAND_READY);
+	if (!test_bit(TPM_TIS_DEFAULT_CANCELLATION, &priv->flags)) {
+		switch (priv->manufacturer_id) {
+		case TPM_VID_WINBOND:
+			return ((status == TPM_STS_VALID) ||
+				(status == (TPM_STS_VALID | TPM_STS_COMMAND_READY)));
+		case TPM_VID_STM:
+			return (status == (TPM_STS_VALID | TPM_STS_COMMAND_READY));
+		}
 	}
+
+	return status == TPM_STS_COMMAND_READY;
 }
 
 static irqreturn_t tis_int_handler(int dummy, void *dev_id)
diff --git a/drivers/char/tpm/tpm_tis_core.h b/drivers/char/tpm/tpm_tis_core.h
index 66a5a13cd1df..b68479e0de10 100644
--- a/drivers/char/tpm/tpm_tis_core.h
+++ b/drivers/char/tpm/tpm_tis_core.h
@@ -86,6 +86,7 @@ enum tis_defaults {
 enum tpm_tis_flags {
 	TPM_TIS_ITPM_WORKAROUND		= BIT(0),
 	TPM_TIS_INVALID_STATUS		= BIT(1),
+	TPM_TIS_DEFAULT_CANCELLATION	= BIT(2),
 };
 
 struct tpm_tis_data {
diff --git a/drivers/char/tpm/tpm_tis_i2c.c b/drivers/char/tpm/tpm_tis_i2c.c
index 0692510dfcab..6722588e0217 100644
--- a/drivers/char/tpm/tpm_tis_i2c.c
+++ b/drivers/char/tpm/tpm_tis_i2c.c
@@ -329,6 +329,7 @@ static int tpm_tis_i2c_probe(struct i2c_client *dev,
 	if (!phy->io_buf)
 		return -ENOMEM;
 
+	set_bit(TPM_TIS_DEFAULT_CANCELLATION, &phy->priv.flags);
 	phy->i2c_client = dev;
 
 	/* must precede all communication with the tpm */
-- 
2.31.1

