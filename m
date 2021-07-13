Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88B2F3C76ED
	for <lists+linux-integrity@lfdr.de>; Tue, 13 Jul 2021 21:24:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230145AbhGMT13 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 13 Jul 2021 15:27:29 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:3924 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229478AbhGMT13 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 13 Jul 2021 15:27:29 -0400
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16DJ406a196505
        for <linux-integrity@vger.kernel.org>; Tue, 13 Jul 2021 15:24:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=yFZqCrLQhiO80BieLdaTsJ/w6Ae5Vk0qhVcF2LBgZDE=;
 b=rG+CCNl+X9cqKjKqxWjf3dIyCEnARrWFwGO1rix+0XDeiWfwpsWbkWISKJ3/sw3qVPdA
 4FhQIs4lfwqp5mHi99096MJRP8Gwv6eZBtlNkXwCbMmFaSYmuZaxaR2OCOe+zTnc54Y6
 n79/SHtc6dtfunSKcz4plXAW99x2Zr8DmctN/sBBrxrpZASkqe49rJVolJBhUcq9QePJ
 PCKIJ2KbeX18EPR+PN+BtaetPbuVI+kS3d+N+Kmy9eQ7OIaTJ60A55DbJ1GBgoLjhkTk
 kzHPboH8qbArVMWU1tyL0WzZVjX53KOjd8OE7VN4rYyvMNb/dwWlCa83emKHDaz2S/so /Q== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 39sc2x9mqt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Tue, 13 Jul 2021 15:24:38 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 16DJC0KC020486
        for <linux-integrity@vger.kernel.org>; Tue, 13 Jul 2021 19:24:37 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma04ams.nl.ibm.com with ESMTP id 39q3689ehs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Tue, 13 Jul 2021 19:24:37 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 16DJOX5933554756
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 13 Jul 2021 19:24:33 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C49B7AE051;
        Tue, 13 Jul 2021 19:24:33 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F2A3FAE04D;
        Tue, 13 Jul 2021 19:24:32 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com.com (unknown [9.160.12.130])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 13 Jul 2021 19:24:32 +0000 (GMT)
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.ibm.com>
Subject: [PATCH ima-evm-utils] Fix NULL pointer warning
Date:   Tue, 13 Jul 2021 15:24:13 -0400
Message-Id: <20210713192413.699857-1-zohar@linux.ibm.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: tiNwor0McMngQx8ex4QvmOxF9I9J_yBW
X-Proofpoint-ORIG-GUID: tiNwor0McMngQx8ex4QvmOxF9I9J_yBW
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-13_12:2021-07-13,2021-07-13 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 malwarescore=0
 spamscore=0 bulkscore=0 priorityscore=1501 lowpriorityscore=0 phishscore=0
 mlxlogscore=999 mlxscore=0 adultscore=0 suspectscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2107130121
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Static analysis reported an "invalid operation involving NULL pointer"
warning.  Although the code properly exits the loop without ever
using the variable, test the pointer isn't NULL before incrementing
it.

Fixes: 80d3fda6083f ("ima-evm-utils: Check for tsspcrread in runtime")
Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
---
 src/utils.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/src/utils.c b/src/utils.c
index ce2cc285a930..fd9b4a84189f 100644
--- a/src/utils.c
+++ b/src/utils.c
@@ -77,7 +77,8 @@ int get_cmd_path(const char *prog_name, char *buf, size_t buf_len)
 		if (buf_len - size > ret && file_exist(buf))
 			return 0;
 
-		start = end + 1;
+		if (end != NULL)
+			start = end + 1;
 
 	} while (end != NULL);
 
-- 
2.27.0

