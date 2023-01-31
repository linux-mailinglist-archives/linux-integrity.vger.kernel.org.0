Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3CB768248E
	for <lists+linux-integrity@lfdr.de>; Tue, 31 Jan 2023 07:40:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230320AbjAaGk2 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 31 Jan 2023 01:40:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230166AbjAaGkY (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 31 Jan 2023 01:40:24 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7653F3D08E;
        Mon, 30 Jan 2023 22:40:22 -0800 (PST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30V61vmT020628;
        Tue, 31 Jan 2023 06:40:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=7zg1tUagYbEpIMwYaXEmmouyBNZUUmpuXixmXYcdebM=;
 b=Hj/m3V/eDiNJ6GAoheF0uw1PKkW2pZUcMaNufLFk2BXfQyTswe9Ft3rNR4h7cw7w3Tew
 D3NHohzCeMsfkIGXayvZuw5qX3vwj74ywfi2SpPxH0hfDoWyHbXTnj9H0iq5NJhQ3Kva
 8f0r43HC9FwjD7mtapWF3XMa1nTqLaUpFNHEGmIcYr0lKpuYQ6e86a0JTzW/09TgXhMC
 WSq6pk3QbJY/IpyVZfcHouumEbps0pfjqOWb56CkzNFhY94JGBfD51AjVOcUEw8JOEc3
 CIGc+NPJfRb+ZOmelJBgIfTSc5LZttZPXJeehSDBe2hsjwMz3eAw4mWEJaotLSqGysy3 bw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3newc40rr8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 31 Jan 2023 06:40:12 +0000
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 30V6LWAC024564;
        Tue, 31 Jan 2023 06:40:12 GMT
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3newc40rq6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 31 Jan 2023 06:40:12 +0000
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 30ULAuql009758;
        Tue, 31 Jan 2023 06:40:10 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
        by ppma05fra.de.ibm.com (PPS) with ESMTPS id 3ncvt7j7gj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 31 Jan 2023 06:40:10 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
        by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 30V6e6ZO21168558
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 31 Jan 2023 06:40:07 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7906C20043;
        Tue, 31 Jan 2023 06:40:06 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id ED13720040;
        Tue, 31 Jan 2023 06:40:05 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
        by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Tue, 31 Jan 2023 06:40:05 +0000 (GMT)
Received: from jarvis-ozlabs-ibm-com.au.ibm.com (unknown [9.192.255.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.au.ibm.com (Postfix) with ESMTPSA id CD50960637;
        Tue, 31 Jan 2023 17:40:03 +1100 (AEDT)
From:   Andrew Donnellan <ajd@linux.ibm.com>
To:     linuxppc-dev@lists.ozlabs.org, linux-integrity@vger.kernel.org
Cc:     ruscur@russell.cc, bgray@linux.ibm.com, nayna@linux.ibm.com,
        gcwilson@linux.ibm.com, gjoyce@linux.ibm.com, brking@linux.ibm.com,
        stefanb@linux.ibm.com, sudhakar@linux.ibm.com,
        erichte@linux.ibm.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, zohar@linux.ibm.com, joel@jms.id.au,
        npiggin@gmail.com
Subject: [PATCH v5 01/25] powerpc/pseries: Fix handling of PLPKS object flushing timeout
Date:   Tue, 31 Jan 2023 17:39:04 +1100
Message-Id: <20230131063928.388035-2-ajd@linux.ibm.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230131063928.388035-1-ajd@linux.ibm.com>
References: <20230131063928.388035-1-ajd@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: S2wY0vyD_i2FSYgExCoAfbgNmFCWVKLS
X-Proofpoint-GUID: jr7wMDhLwNuLCtfdDOuV9dTx4h3gCUCk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-31_02,2023-01-30_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 phishscore=0 priorityscore=1501 adultscore=0 mlxlogscore=999 clxscore=1015
 suspectscore=0 bulkscore=0 impostorscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301310059
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
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

