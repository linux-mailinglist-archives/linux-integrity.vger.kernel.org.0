Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2F58290CA9
	for <lists+linux-integrity@lfdr.de>; Fri, 16 Oct 2020 22:18:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393410AbgJPUSJ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 16 Oct 2020 16:18:09 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:64538 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2393400AbgJPUSJ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 16 Oct 2020 16:18:09 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 09GK3FvV177055;
        Fri, 16 Oct 2020 16:18:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references; s=pp1;
 bh=bA/j4834Ycjb9zhyqjQKucoWLwNhGdKBoRRwJdiMg7k=;
 b=faCF4HxCa8o3e0MjQ+oxm01H150oNEmmTJChLyqvIL2yKOsYdtcFK9JQsfmm7nx3Ef0q
 XeD9JgRdBF+uAszPDrZNvlm0QliG0S0rzR3U5KtKcoDNoXBtx35Q+vaEUhqtO4zxGbXF
 VW9RfhXWNpymqPNMUL5kl/h1S3PeFwi+4qFRvtpOdAMG2JDCD/ZVFux9UqKQpDICkV7i
 tSg2+AnATOXUo5teQhnu+UgmhbDnR5ApgGRyosEin8EzBCYxsxFwB+RqPXZ0UqPPWr/1
 qhOP2OfFCL0M/s0wbsRTVvH0FDH6GPBbK6FuZ4aWGY6tbrwMi+hMd6Jxxl15xGS5Hmcs vA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 347hpa9cyg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 16 Oct 2020 16:18:06 -0400
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 09GK3HKj177245;
        Fri, 16 Oct 2020 16:18:06 -0400
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com with ESMTP id 347hpa9cxn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 16 Oct 2020 16:18:06 -0400
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 09GKHnfU012533;
        Fri, 16 Oct 2020 20:18:04 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma06fra.de.ibm.com with ESMTP id 34347h3f2y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 16 Oct 2020 20:18:04 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 09GKI1E823396648
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 16 Oct 2020 20:18:01 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0EEB942047;
        Fri, 16 Oct 2020 20:18:01 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E1CB94203F;
        Fri, 16 Oct 2020 20:17:59 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com.com (unknown [9.160.113.249])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 16 Oct 2020 20:17:59 +0000 (GMT)
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     Ken Goldman <kgold@linux.ibm.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Bruno Meneguele <bmeneg@redhat.com>,
        Petr Vorel <pvorel@suse.cz>
Subject: [ima-evm-utils][PATCH 3/3] travis: properly kill the software TPM
Date:   Fri, 16 Oct 2020 16:17:45 -0400
Message-Id: <20201016201745.124355-4-zohar@linux.ibm.com>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20201016201745.124355-1-zohar@linux.ibm.com>
References: <20201016201745.124355-1-zohar@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-10-16_10:2020-10-16,2020-10-16 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=816
 bulkscore=0 clxscore=1015 priorityscore=1501 lowpriorityscore=0
 adultscore=0 spamscore=0 impostorscore=0 phishscore=0 suspectscore=1
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010160145
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Send "tsstpmcmd -stop" to properly stop the tpm_server.  Send SIGTERM
to stop the swtpm process.

Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
---
 tests/boot_aggregate.test | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/tests/boot_aggregate.test b/tests/boot_aggregate.test
index ab061d5e5845..42ed7b4cfb3a 100755
--- a/tests/boot_aggregate.test
+++ b/tests/boot_aggregate.test
@@ -41,14 +41,12 @@ else
 
 fi
 
-# Only stop this test's software TPM.  Preferred method: "tsstpmcmd -stop"
+# Only stop this test's software TPM
 cleanup() {
-	if [ -n "${SWTPM_PPID}" ]; then
-		if [ -f "${TSSDIR}/tsstpmcmd" ]; then
-			"${TSSDIR}/tsstpmcmd" -stop
-		else
-			pkill -P "${SWTPM_PPID}"
-		fi
+	if [ -n "${SWTPM_PID}" ]; then
+		kill -SIGTERM "${SWTPM_PID}"
+	elif [ -n "${TPMSERVER_PID}" ]; then
+		"${TSSDIR}/tsstpmcmd" -stop
 	fi
 }
 
@@ -72,7 +70,7 @@ swtpm_start() {
 			echo -n "INFO: Starting software TPM: ${swtpm}"
 			mkdir -p ./myvtpm
 			${swtpm} socket --tpmstate dir=./myvtpm --tpm2 --ctrl type=tcp,port=2322 --server type=tcp,port=2321 --flags not-need-init > /dev/null 2>&1 &
-			SWTPM_PPID=$!
+			SWTPM_PID=$!
 		fi
 	elif [ -n "${tpm_server}" ]; then
 		# tpm_server uses the Microsoft simulator encapsulated packet format
@@ -84,7 +82,7 @@ swtpm_start() {
 		else
 			echo "INFO: Starting software TPM: ${tpm_server}"
 			${tpm_server} > /dev/null 2>&1 &
-			SWTPM_PPID=$!
+			TPMSERVER_PID=$!
 		fi
 	fi
 	return 0
-- 
2.18.4

