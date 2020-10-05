Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5052528428C
	for <lists+linux-integrity@lfdr.de>; Tue,  6 Oct 2020 00:34:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727203AbgJEWeK (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 5 Oct 2020 18:34:10 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:49288 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725997AbgJEWdn (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 5 Oct 2020 18:33:43 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 095M6gfB093623
        for <linux-integrity@vger.kernel.org>; Mon, 5 Oct 2020 18:33:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=to : from : subject :
 message-id : date : mime-version : content-type :
 content-transfer-encoding; s=pp1;
 bh=gGSkcxbdSw8kG8W1pUThqT6PdaEus3M59SaUGv9eC2g=;
 b=sgIq3BNiE9tyEW6ABVeGB8/wFsyNi+VEOZPnJ2CielM1p9BVo9v23PtZhZCjJoORDtXO
 m6meqgIbdpMAeogVSrRNtNy5rbFSe1/jzsbby4Pl2haZprfuUXV2X3aZUXcspoO1MA2R
 kY3jHqgz+b9TbEtybLDPmg/Yml9DW8RwXQ+hkIG8wjB2d0hXZzyrZ03R0dsVB/asg7oK
 FMNzSxEoWtTRHnta5hdq1HgCnyxEUQDj1iKin8DZ31G8V/o9sTxVGSTQ5vgWGYPRZfwJ
 N9fCY5thaiGRfKgmuhhX0Ed/6nYJpd16LIbEEdHfXXNNrlf0Hvfc/QldJWfyd1WbPcHl nQ== 
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0a-001b2d01.pphosted.com with ESMTP id 340b7nsgnf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Mon, 05 Oct 2020 18:33:42 -0400
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 095MRPpt003780
        for <linux-integrity@vger.kernel.org>; Mon, 5 Oct 2020 22:33:41 GMT
Received: from b03cxnp08027.gho.boulder.ibm.com (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
        by ppma01dal.us.ibm.com with ESMTP id 33xgx97mqj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Mon, 05 Oct 2020 22:33:41 +0000
Received: from b03ledav006.gho.boulder.ibm.com (b03ledav006.gho.boulder.ibm.com [9.17.130.237])
        by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 095MXZQJ27656538
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-integrity@vger.kernel.org>; Mon, 5 Oct 2020 22:33:35 GMT
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 32BA3C6077
        for <linux-integrity@vger.kernel.org>; Mon,  5 Oct 2020 22:33:40 +0000 (GMT)
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 079FDC6079
        for <linux-integrity@vger.kernel.org>; Mon,  5 Oct 2020 22:33:39 +0000 (GMT)
Received: from [9.85.186.165] (unknown [9.85.186.165])
        by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTP
        for <linux-integrity@vger.kernel.org>; Mon,  5 Oct 2020 22:33:39 +0000 (GMT)
To:     Linux Integrity <linux-integrity@vger.kernel.org>
From:   Ken Goldman <kgold@linux.ibm.com>
Subject: [PATCH 5/6] ima-evm-utils: Correct spelling errors
Message-ID: <e2d70e98-682a-3a8b-79da-9d031abf6a5f@linux.ibm.com>
Date:   Mon, 5 Oct 2020 18:33:39 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-10-05_16:2020-10-05,2020-10-05 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 mlxlogscore=999 bulkscore=0 clxscore=1015 priorityscore=1501 adultscore=0
 malwarescore=0 mlxscore=0 lowpriorityscore=0 impostorscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2010050156
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

In comments and error messages.  No impact to code.

Signed-off-by: Ken Goldman <kgoldman@us.ibm.com>
---
  tests/boot_aggregate.test | 4 ++--
  1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/boot_aggregate.test b/tests/boot_aggregate.test
index 0c58469..688f91e 100755
--- a/tests/boot_aggregate.test
+++ b/tests/boot_aggregate.test
@@ -58,7 +58,7 @@ swtpm_start() {
  	swtpm="$(which tpm_server)"
  	swtpm1="$(which swtpm)"
  	if [ -z "${swtpm}" ] && [ -z "${swtpm1}" ]; then
-		echo "${CYAN}SKIP: Softare TPM (tpm_server and swtpm) not found${NORM}"
+		echo "${CYAN}SKIP: Software TPM (tpm_server and swtpm) not found${NORM}"
  		return "$SKIP"
  	fi

@@ -122,7 +122,7 @@ display_pcrs() {
  	done
  }

-# The first entry in the IMA measuremnet list is the "boot_aggregate".
+# The first entry in the IMA measurement list is the "boot_aggregate".
  # For each kexec, an additional "boot_aggregate" will appear in the
  # measurement list, assuming the previous measurement list is carried
  # across the kexec.
-- 
2.25.1

