Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9350290CA8
	for <lists+linux-integrity@lfdr.de>; Fri, 16 Oct 2020 22:18:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393436AbgJPUSG (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 16 Oct 2020 16:18:06 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:37226 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2393410AbgJPUSF (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 16 Oct 2020 16:18:05 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 09GKDqQv189206;
        Fri, 16 Oct 2020 16:18:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references; s=pp1;
 bh=fFA6PjwwFRZbGt4jZcu5WjSe6BfFIs4cS0eiLo8vMzI=;
 b=KU8LXyk1+CEgpQ8vUeHKiYnrHuB/yKhuq0wdJSVn6lQHmwaab4Yj+qpxhLb4JswsXuE2
 bPYD1JcfNO4RY5V65wJJAMa/1bKIZCe2r/tBXCkKpCZGwrbUWQY6xgwMlqwRm9xKvoLi
 AIEoSVcgRileLBirZ4gjCHkytrWsVcqCBGAOy2iSBtnmxJ0XKne+hWK8kuBK5Xo9Ct5U
 AO80tJhHQvkIwDdHj9L51XtOUEnZH3WV5paY1ADuznL6mMwMxlIrYMnawSD+x4JCFCAG
 eQU/X4zNIiAqnRg7+vEpxqkL/E1HjeesE+i7sO/0SEV9E+Uwo86ihX0gRrGK6aDglWKv lw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 347jcar3c5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 16 Oct 2020 16:18:03 -0400
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 09GKDvkT189373;
        Fri, 16 Oct 2020 16:18:03 -0400
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com with ESMTP id 347jcar3bd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 16 Oct 2020 16:18:02 -0400
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 09GKI0Cc007389;
        Fri, 16 Oct 2020 20:18:00 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma03fra.de.ibm.com with ESMTP id 3434k7ufjp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 16 Oct 2020 20:18:00 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 09GKHvQB30409020
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 16 Oct 2020 20:17:57 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A18844203F;
        Fri, 16 Oct 2020 20:17:57 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C9F6C42041;
        Fri, 16 Oct 2020 20:17:56 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com.com (unknown [9.160.113.249])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 16 Oct 2020 20:17:56 +0000 (GMT)
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     Ken Goldman <kgold@linux.ibm.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Bruno Meneguele <bmeneg@redhat.com>,
        Petr Vorel <pvorel@suse.cz>
Subject: [ima-evm-utils][PATCH 2/3] travis: rename the software tpm variables
Date:   Fri, 16 Oct 2020 16:17:44 -0400
Message-Id: <20201016201745.124355-3-zohar@linux.ibm.com>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20201016201745.124355-1-zohar@linux.ibm.com>
References: <20201016201745.124355-1-zohar@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-10-16_10:2020-10-16,2020-10-16 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 spamscore=0
 lowpriorityscore=0 priorityscore=1501 mlxscore=0 malwarescore=0
 impostorscore=0 bulkscore=0 phishscore=0 adultscore=0 suspectscore=1
 mlxlogscore=834 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010160145
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

The existing variable names swtpm and swtpm1 is confusing.  Rename
"swtpm" to "tpm_server" and "swtpm1" as "swtpm".

Reported-by: Ken Goldman <kgoldman@us.ibm.com>
Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
---
 tests/boot_aggregate.test | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/tests/boot_aggregate.test b/tests/boot_aggregate.test
index edebf1d29f23..ab061d5e5845 100755
--- a/tests/boot_aggregate.test
+++ b/tests/boot_aggregate.test
@@ -54,36 +54,36 @@ cleanup() {
 
 # Try to start a software TPM if needed.
 swtpm_start() {
-	local swtpm swtpm1
+	local tpm_server swtpm
 
-	swtpm="$(which tpm_server)"
-	swtpm1="$(which swtpm)"
-	if [ -z "${swtpm}" ] && [ -z "${swtpm1}" ]; then
+	tpm_server="$(which tpm_server)"
+	swtpm="$(which swtpm)"
+	if [ -z "${tpm_server}" ] && [ -z "${swtpm}" ]; then
 		echo "${CYAN}SKIP: Software TPM (tpm_server and swtpm) not found${NORM}"
 		return "$SKIP"
 	fi
 
-	if [ -n "${swtpm1}" ]; then
-		pgrep swtpm1
+	if [ -n "${swtpm}" ]; then
+		pgrep swtpm
 		if [ $? -eq 0 ]; then
 			echo "INFO: Software TPM (swtpm) already running"
 			return 114
 		else
-			echo "INFO: Starting software TPM: ${swtpm1}"
-			mkdir ./myvtpm
-			${swtpm1} socket --tpmstate dir=./myvtpm --tpm2 --ctrl type=tcp,port=2322 --server type=tcp,port=2321 --flags not-need-init > /dev/null 2>&1 &
+			echo -n "INFO: Starting software TPM: ${swtpm}"
+			mkdir -p ./myvtpm
+			${swtpm} socket --tpmstate dir=./myvtpm --tpm2 --ctrl type=tcp,port=2322 --server type=tcp,port=2321 --flags not-need-init > /dev/null 2>&1 &
 			SWTPM_PPID=$!
 		fi
-	elif [ -n "${swtpm}" ]; then
+	elif [ -n "${tpm_server}" ]; then
 		# tpm_server uses the Microsoft simulator encapsulated packet format
 		export TPM_SERVER_TYPE="mssim"
-		pgrep swtpm
+		pgrep tpm_server
 		if [ $? -eq 0 ]; then
 			echo "INFO: Software TPM (tpm_server) already running"
 			return 114
 		else
-			echo "INFO: Starting software TPM: ${swtpm}"
-			${swtpm} > /dev/null 2>&1 &
+			echo "INFO: Starting software TPM: ${tpm_server}"
+			${tpm_server} > /dev/null 2>&1 &
 			SWTPM_PPID=$!
 		fi
 	fi
-- 
2.18.4

