Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30E62290CA7
	for <lists+linux-integrity@lfdr.de>; Fri, 16 Oct 2020 22:18:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393431AbgJPUSC (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 16 Oct 2020 16:18:02 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:13266 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2393410AbgJPUSC (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 16 Oct 2020 16:18:02 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 09GK3XIx153897;
        Fri, 16 Oct 2020 16:18:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references; s=pp1;
 bh=Fz8s+Y6NM8am8v2hGqcyvYJde8tmOV5gt2ucJKoEYQY=;
 b=M/YEApoOrN4LfjvF6usxroZqSp0+AfdoPQjMrF0Z19rm+VZp3nRkUHTfyBNaH7wTEnxc
 vc6rA3HTq7HJ9gqCKIPez7HKCJL8wNUGiORj9sIt/S8mE38No3T7RX3Qc3vQwRy+7RCt
 QidkxHaqapCjs5GXG9D4OVm6uoazchh+4cUmukLRUieq67VGpqfb/znqXqoRurKqdOHX
 VpgkU19F+iO8878AkwsaIrDWG+KbSyGCrHMyICKhu0t9fyFN+l7Gn5ZuQDdCKt55+syV
 1tv4vnAJ/fgaHnTvnXC14JWRT70E9lo0dW62YjBu+uQnotshgAxXTSoNACsV7PkyVs0s pw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 347h5jt8gy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 16 Oct 2020 16:18:00 -0400
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 09GK3g2C154597;
        Fri, 16 Oct 2020 16:17:59 -0400
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 347h5jt8ga-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 16 Oct 2020 16:17:59 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 09GKGXTM025964;
        Fri, 16 Oct 2020 20:17:57 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma03ams.nl.ibm.com with ESMTP id 3434k86p7c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 16 Oct 2020 20:17:57 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 09GKHssc8061432
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 16 Oct 2020 20:17:54 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5FAB042045;
        Fri, 16 Oct 2020 20:17:54 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6621E42041;
        Fri, 16 Oct 2020 20:17:53 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com.com (unknown [9.160.113.249])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 16 Oct 2020 20:17:53 +0000 (GMT)
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     Ken Goldman <kgold@linux.ibm.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Bruno Meneguele <bmeneg@redhat.com>,
        Petr Vorel <pvorel@suse.cz>
Subject: [ima-evm-utils][PATCH 1/3] travis: retry sending tssstartup
Date:   Fri, 16 Oct 2020 16:17:43 -0400
Message-Id: <20201016201745.124355-2-zohar@linux.ibm.com>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20201016201745.124355-1-zohar@linux.ibm.com>
References: <20201016201745.124355-1-zohar@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-10-16_10:2020-10-16,2020-10-16 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=1 phishscore=0
 bulkscore=0 spamscore=0 clxscore=1015 impostorscore=0 priorityscore=1501
 mlxlogscore=999 lowpriorityscore=0 adultscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010160145
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

The software TPM might not be listening for commands yet. Try re-sending
the tssstartup.

Reported-by: Ken Goldman <kgoldman@us.ibm.com>
Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
---
 tests/boot_aggregate.test | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/tests/boot_aggregate.test b/tests/boot_aggregate.test
index d58c54fa1110..edebf1d29f23 100755
--- a/tests/boot_aggregate.test
+++ b/tests/boot_aggregate.test
@@ -97,8 +97,20 @@ swtpm_init() {
 		return "$SKIP"
 	fi
 
-	echo "INFO: Walking ${BINARY_BIOS_MEASUREMENTS} initializing the software TPM"
+	echo "INFO: Sending software TPM startup"
 	"${TSSDIR}/tssstartup"
+	if [ $? -ne 0 ]; then
+		echo "INFO: Retry sending software TPM startup"
+		sleep 1
+		"${TSSDIR}/tssstartup"
+	fi
+
+	if [ $? -ne 0 ]; then
+		echo "INFO: Software TPM startup failed"
+		return "$SKIP"
+	fi
+
+	echo "INFO: Walking ${BINARY_BIOS_MEASUREMENTS} initializing the software TPM"
 #	$(${TSSDIR}/tsseventextend -tpm -if "${BINARY_BIOS_MEASUREMENTS}" -v) 2>&1 > /dev/null
 	"${TSSDIR}/tsseventextend" -tpm -if "${BINARY_BIOS_MEASUREMENTS}" -v > /dev/null 2>&1
 }
-- 
2.18.4

