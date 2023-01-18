Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C309E671401
	for <lists+linux-integrity@lfdr.de>; Wed, 18 Jan 2023 07:27:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229754AbjARG1F (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 18 Jan 2023 01:27:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbjARGWB (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 18 Jan 2023 01:22:01 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1389C4DCEB;
        Tue, 17 Jan 2023 22:11:26 -0800 (PST)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30I3XOk4014752;
        Wed, 18 Jan 2023 06:11:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=jaBuioqTuCG+mB+2YphoSleBbEkQb92LPZoTaBRbVD0=;
 b=pe7KwPbKxf2R5PIya7iPGntJ7fbpZ5oFbzX43tPzKDWFoe6jSeJe6oFAaC0dTOV2tq68
 Jmh+Qb1F5Yn3wdF8JarQE/XCawvG7XL+qKvZZ/VVA4ntDZH1WWNC5ACx0Sr9yOQbTPdN
 k91majsphhOLoUKr+6sU7HouLxJcAUJaRz6LwZR0+MW6ui7m5yRJn/29k+gmGP9lR+va
 i6kgyTQWOfBZU2LLiHW7PPV4KHVaLyFsd+P35/Os1AJOA7k92ajB7VPVD3Niq24zqa1J
 FwETFC8yqz0t5hMgdcCHG90R79iXVusRTdtu3O7kNjy6+RqybKm2RgXmpuUYF244Wygh wA== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3n68ycaq5b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 Jan 2023 06:11:17 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 30HMNxWr004735;
        Wed, 18 Jan 2023 06:11:15 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
        by ppma04ams.nl.ibm.com (PPS) with ESMTPS id 3n3m16mtng-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 Jan 2023 06:11:15 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
        by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 30I6BDWN39977256
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Jan 2023 06:11:13 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 579812005A;
        Wed, 18 Jan 2023 06:11:13 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D08262004B;
        Wed, 18 Jan 2023 06:11:12 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
        by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 18 Jan 2023 06:11:12 +0000 (GMT)
Received: from jarvis-ozlabs-ibm-com.ozlabs.ibm.com (haven.au.ibm.com [9.192.254.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.au.ibm.com (Postfix) with ESMTPSA id 6CFF2606DB;
        Wed, 18 Jan 2023 17:11:08 +1100 (AEDT)
From:   Andrew Donnellan <ajd@linux.ibm.com>
To:     linuxppc-dev@lists.ozlabs.org, linux-integrity@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, gcwilson@linux.ibm.com,
        linux-kernel@vger.kernel.org, nayna@linux.ibm.com,
        ruscur@russell.cc, zohar@linux.ibm.com, mpe@ellerman.id.au,
        gjoyce@linux.ibm.com, sudhakar@linux.ibm.com, bgray@linux.ibm.com,
        erichte@linux.ibm.com
Subject: [PATCH v3 13/24] powerpc/pseries: Fix handling of PLPKS object flushing timeout
Date:   Wed, 18 Jan 2023 17:10:38 +1100
Message-Id: <20230118061049.1006141-14-ajd@linux.ibm.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230118061049.1006141-1-ajd@linux.ibm.com>
References: <20230118061049.1006141-1-ajd@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: DkUeaYkhQ5qClh6lHifxupBx838typ0h
X-Proofpoint-ORIG-GUID: DkUeaYkhQ5qClh6lHifxupBx838typ0h
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-18_01,2023-01-17_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 spamscore=0 mlxscore=0 bulkscore=0 phishscore=0
 adultscore=0 mlxlogscore=999 priorityscore=1501 clxscore=1015
 suspectscore=0 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2212070000 definitions=main-2301180051
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
---
 arch/powerpc/platforms/pseries/plpks.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/plpks.c b/arch/powerpc/platforms/pseries/plpks.c
index 5bdc093de6fb..6d1303e4862d 100644
--- a/arch/powerpc/platforms/pseries/plpks.c
+++ b/arch/powerpc/platforms/pseries/plpks.c
@@ -234,6 +234,7 @@ static int plpks_confirm_object_flushed(struct label *label,
 					struct plpks_auth *auth)
 {
 	unsigned long retbuf[PLPAR_HCALL_BUFSIZE] = { 0 };
+	bool timed_out = true;
 	u64 timeout = 0;
 	u8 status;
 	int rc;
@@ -245,22 +246,26 @@ static int plpks_confirm_object_flushed(struct label *label,
 
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
 
 		usleep_range(PLPKS_FLUSH_SLEEP,
 			     PLPKS_FLUSH_SLEEP + PLPKS_FLUSH_SLEEP_RANGE);
 		timeout = timeout + PLPKS_FLUSH_SLEEP;
 	} while (timeout < PLPKS_MAX_TIMEOUT);
 
-	rc = pseries_status_to_err(rc);
+	if (timed_out)
+		return -ETIMEDOUT;
 
-	return rc;
+	return pseries_status_to_err(rc);
 }
 
 int plpks_write_var(struct plpks_var var)
-- 
2.39.0

