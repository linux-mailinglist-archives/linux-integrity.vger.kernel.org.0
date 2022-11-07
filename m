Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A430861FAEA
	for <lists+linux-integrity@lfdr.de>; Mon,  7 Nov 2022 18:14:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231302AbiKGROm (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 7 Nov 2022 12:14:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232445AbiKGROl (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 7 Nov 2022 12:14:41 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F4071CB38;
        Mon,  7 Nov 2022 09:14:40 -0800 (PST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A7GVWUq010003;
        Mon, 7 Nov 2022 17:14:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=kdALMMXxbkxzLHn276hXvIKGsTAIHW3diqQ49ApReSU=;
 b=cRHeeDJ302tr+BRwwyg/64M8HgerBPriwwnJ0m0vKxQM/azAaUUn7H/iC5uLAR8k7zlm
 AeU9Xp3IRqBHipw4XHoL7UNF3kletXE04y/hm8A66Cv49MOg+1n+JeTQjTu4AZKYZhrJ
 TVNcgJ6zwa1rfh6TXHzpSKqiYtBlHFRijb9Ec9faBX6wto6u4bnwfWNv/SAael2o/eu1
 KaPumcZG/LBSLVItS0rQdhazE+eEXjmLgv35YfvGr4Xn81iH/cLPq5nCLSuTBvlyGvrI
 TvCBtM/utQYKXaoRhDag3kerssIDbRGvjfHJXVp8RMAGt801GDeo0m3f/2N3FzcDCJlc yg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3kp1w8k5bf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 07 Nov 2022 17:14:32 +0000
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2A7EwjqK010163;
        Mon, 7 Nov 2022 17:14:32 GMT
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3kp1w8k5at-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 07 Nov 2022 17:14:32 +0000
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2A7H51aO018021;
        Mon, 7 Nov 2022 17:14:31 GMT
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com [9.57.198.26])
        by ppma02dal.us.ibm.com with ESMTP id 3kngnd5825-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 07 Nov 2022 17:14:31 +0000
Received: from smtpav01.wdc07v.mail.ibm.com ([9.208.128.113])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2A7HEUS023593568
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 7 Nov 2022 17:14:30 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CFD3558066;
        Mon,  7 Nov 2022 17:14:29 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B36ED5806C;
        Mon,  7 Nov 2022 17:14:28 +0000 (GMT)
Received: from slate16.aus.stglabs.ibm.com (unknown [9.65.228.202])
        by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Mon,  7 Nov 2022 17:14:28 +0000 (GMT)
From:   Eddie James <eajames@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, peterhuewe@gmx.de, jarkko@kernel.org,
        jgg@ziepe.ca, joel@jms.id.au, Eddie James <eajames@linux.ibm.com>
Subject: [PATCH v2] tpm: Add flag to use default cancellation policy
Date:   Mon,  7 Nov 2022 11:14:23 -0600
Message-Id: <20221107171423.51019-1-eajames@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: hNEq05GQKO2g2wofjFjkh_5Thp3_ml6Z
X-Proofpoint-ORIG-GUID: 9ZmhVW84EwKhEtmf1VRKBf_1DMl19ZiS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-07_08,2022-11-07_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 adultscore=0
 mlxscore=0 clxscore=1011 lowpriorityscore=0 bulkscore=0 impostorscore=0
 phishscore=0 priorityscore=1501 spamscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211070137
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
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
Changes since v1:
 - Update switch statement with default: break;

 drivers/char/tpm/tpm_tis_core.c | 20 ++++++++++++--------
 drivers/char/tpm/tpm_tis_core.h |  1 +
 drivers/char/tpm/tpm_tis_i2c.c  |  1 +
 3 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
index 757623bacfd5..3f98e587b3e8 100644
--- a/drivers/char/tpm/tpm_tis_core.c
+++ b/drivers/char/tpm/tpm_tis_core.c
@@ -682,15 +682,19 @@ static bool tpm_tis_req_canceled(struct tpm_chip *chip, u8 status)
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
+		default:
+			break;
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
index 45f388127f4b..91451ee1ef8d 100644
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

