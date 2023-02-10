Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37D596919CA
	for <lists+linux-integrity@lfdr.de>; Fri, 10 Feb 2023 09:11:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231139AbjBJIL0 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 10 Feb 2023 03:11:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231160AbjBJIL0 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 10 Feb 2023 03:11:26 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C67128186C;
        Fri, 10 Feb 2023 00:10:56 -0800 (PST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31A7g23B032432;
        Fri, 10 Feb 2023 08:09:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=7zg1tUagYbEpIMwYaXEmmouyBNZUUmpuXixmXYcdebM=;
 b=Gzzn6R9KnBbWBHaeMpe4zakfa7MFfUqL3sVNM3051/PrXKHq5hVtyGnnMMI0CDy1N74E
 wmtRbm1xEKE6DCJLx5RF8zjrHBS8Q5dBVjf3tT5jALlQ8GJSrdmQczxnh9rZn30RNxo5
 lNx4yhSb0WNGwHYWeDmaQ0FOgAYhtkPKrBQJOjwzLiFZ4ZFKbA874oOk51IFDP+WRWr5
 MxrULUmizxAxenNquOGlvrn+Ey84jDTvilqrpedgb2M1nnxc78slgM4yRE4OaBEPYOS1
 O1BJfznTX6d9PvC2WBhWYMdQH7J4d955So6eiF+F70i/zPquC2ghAnNboF6IXkrCNSne rQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nnhrurs40-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Feb 2023 08:09:24 +0000
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 31A89N0M032741;
        Fri, 10 Feb 2023 08:09:23 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nnhrurs29-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Feb 2023 08:09:23 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 31A7STPI001883;
        Fri, 10 Feb 2023 08:04:20 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
        by ppma03ams.nl.ibm.com (PPS) with ESMTPS id 3nhf06q4vb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Feb 2023 08:04:20 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
        by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 31A84I2F48103776
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Feb 2023 08:04:18 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 320BC2004D;
        Fri, 10 Feb 2023 08:04:18 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A2B8C20040;
        Fri, 10 Feb 2023 08:04:17 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
        by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Fri, 10 Feb 2023 08:04:17 +0000 (GMT)
Received: from jarvis-ozlabs-ibm-com.ozlabs.ibm.com (haven.au.ibm.com [9.192.254.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.au.ibm.com (Postfix) with ESMTPSA id 92BC660636;
        Fri, 10 Feb 2023 19:04:14 +1100 (AEDT)
From:   Andrew Donnellan <ajd@linux.ibm.com>
To:     linuxppc-dev@lists.ozlabs.org, linux-integrity@vger.kernel.org
Cc:     ruscur@russell.cc, bgray@linux.ibm.com, nayna@linux.ibm.com,
        gcwilson@linux.ibm.com, gjoyce@linux.ibm.com, brking@linux.ibm.com,
        stefanb@linux.ibm.com, sudhakar@linux.ibm.com,
        erichte@linux.ibm.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, zohar@linux.ibm.com, joel@jms.id.au,
        npiggin@gmail.com
Subject: [PATCH v6 01/26] powerpc/pseries: Fix handling of PLPKS object flushing timeout
Date:   Fri, 10 Feb 2023 19:03:36 +1100
Message-Id: <20230210080401.345462-2-ajd@linux.ibm.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230210080401.345462-1-ajd@linux.ibm.com>
References: <20230210080401.345462-1-ajd@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: KXKcxuAaROLEymt3alQtN3kv5ee9U7Dc
X-Proofpoint-GUID: -RiFzNjfoW1aW979Yxpu3ldlF3f9WTss
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-10_03,2023-02-09_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 impostorscore=0
 lowpriorityscore=0 adultscore=0 mlxlogscore=999 malwarescore=0 mlxscore=0
 spamscore=0 bulkscore=0 suspectscore=0 priorityscore=1501 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302100070
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

plpks_confirm_object_flushed() uses the H_PKS_CONFIRM_OBJECT_FLUSHED hcall
to check whether changes to an object in the Platform KeyStore have been
flushed to non-volatile storage.

The hcall returns two output values, the return code and the flush status.
plpks_confirm_object_flushed() polls the hcall until either the flush
status has updated, the return code is an error, or a timeout has been
exceeded.

While we're still polling, the hcall is returning H_SUCCESS (0) as the
return code. In the timeout case, this means that upon exiting the polling
loop, rc is 0, and therefore 0 is returned to the user.

Handle the timeout case separately and return ETIMEDOUT if triggered.

Fixes: 2454a7af0f2a ("powerpc/pseries: define driver for Platform KeyStore")
Reported-by: Benjamin Gray <bgray@linux.ibm.com>
Signed-off-by: Andrew Donnellan <ajd@linux.ibm.com>
Tested-by: Russell Currey <ruscur@russell.cc>
Reviewed-by: Russell Currey <ruscur@russell.cc>
Signed-off-by: Russell Currey <ruscur@russell.cc>

---

v3: Merge plpks fixes and signed update series with secvar series

    Neaten how we return at the end of the function (ruscur)

v4: Move up in series (npiggin)
---
 arch/powerpc/platforms/pseries/plpks.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/plpks.c b/arch/powerpc/platforms/pseries/plpks.c
index 4edd1585e245..9e85b6d85b0b 100644
--- a/arch/powerpc/platforms/pseries/plpks.c
+++ b/arch/powerpc/platforms/pseries/plpks.c
@@ -248,6 +248,7 @@ static int plpks_confirm_object_flushed(struct label *label,
 					struct plpks_auth *auth)
 {
 	unsigned long retbuf[PLPAR_HCALL_BUFSIZE] = { 0 };
+	bool timed_out = true;
 	u64 timeout = 0;
 	u8 status;
 	int rc;
@@ -259,22 +260,26 @@ static int plpks_confirm_object_flushed(struct label *label,
 
 		status = retbuf[0];
 		if (rc) {
+			timed_out = false;
 			if (rc == H_NOT_FOUND && status == 1)
 				rc = 0;
 			break;
 		}
 
-		if (!rc && status == 1)
+		if (!rc && status == 1) {
+			timed_out = false;
 			break;
+		}
 
 		usleep_range(PKS_FLUSH_SLEEP,
 			     PKS_FLUSH_SLEEP + PKS_FLUSH_SLEEP_RANGE);
 		timeout = timeout + PKS_FLUSH_SLEEP;
 	} while (timeout < PKS_FLUSH_MAX_TIMEOUT);
 
-	rc = pseries_status_to_err(rc);
+	if (timed_out)
+		return -ETIMEDOUT;
 
-	return rc;
+	return pseries_status_to_err(rc);
 }
 
 int plpks_write_var(struct plpks_var var)
-- 
2.39.1

