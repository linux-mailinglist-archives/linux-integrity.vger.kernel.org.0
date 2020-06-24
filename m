Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61CC62069F5
	for <lists+linux-integrity@lfdr.de>; Wed, 24 Jun 2020 04:11:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387694AbgFXCLO (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 23 Jun 2020 22:11:14 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:56540 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730898AbgFXCLN (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 23 Jun 2020 22:11:13 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05O24Ku6111303;
        Tue, 23 Jun 2020 22:11:11 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 31uuy52pfd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 23 Jun 2020 22:11:10 -0400
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 05O24hF9113140;
        Tue, 23 Jun 2020 22:11:10 -0400
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com with ESMTP id 31uuy52pet-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 23 Jun 2020 22:11:10 -0400
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 05O220bV011038;
        Wed, 24 Jun 2020 02:11:08 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma06fra.de.ibm.com with ESMTP id 31uuspr1e2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 24 Jun 2020 02:11:08 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 05O2B5XL58261768
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Jun 2020 02:11:06 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D9AF511C050;
        Wed, 24 Jun 2020 02:11:05 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B0B4411C05E;
        Wed, 24 Jun 2020 02:11:04 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.163.175])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 24 Jun 2020 02:11:04 +0000 (GMT)
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.ibm.com>, Petr Vorel <pvorel@suse.cz>,
        Maurizio Drocco <maurizio.drocco@ibm.com>,
        Bruno Meneguele <bmeneg@redhat.com>
Subject: [PATCH] ima-evm-utils: tests: fix finding the "boot_aggregate" value
Date:   Tue, 23 Jun 2020 22:10:52 -0400
Message-Id: <1592964652-30446-1-git-send-email-zohar@linux.ibm.com>
X-Mailer: git-send-email 2.7.5
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-23_17:2020-06-23,2020-06-23 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 cotscore=-2147483648 lowpriorityscore=0 mlxlogscore=999 spamscore=0
 clxscore=1015 malwarescore=0 suspectscore=1 priorityscore=1501
 impostorscore=0 bulkscore=0 mlxscore=0 phishscore=0 classifier=spam
 adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006240012
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Searching for the last "boot_aggregate" record in the measurement list
could inadvertently match a filename containing the string
"boot_aggregate".  Prevent this from happening.

Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
---
 tests/boot_aggregate.test | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/boot_aggregate.test b/tests/boot_aggregate.test
index 3e961ce5f9aa..fe0c9aa1898e 100755
--- a/tests/boot_aggregate.test
+++ b/tests/boot_aggregate.test
@@ -121,7 +121,7 @@ check() {
 		if [ "$VERBOSE" != "0" ]; then
 			echo "$hash"
 		fi
-		if grep -e "boot_aggregate$" -e "boot_aggregate.$" "${ASCII_RUNTIME_MEASUREMENTS}" | tail -n 1 | grep -q "${hash}"; then
+		if grep -e " boot_aggregate$" -e " boot_aggregate.$" "${ASCII_RUNTIME_MEASUREMENTS}" | tail -n 1 | grep -q "${hash}"; then
 			echo "${GREEN}SUCCESS: boot_aggregate ${hash} found${NORM}"
 			return "$OK"
 		fi
-- 
2.7.5

