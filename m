Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E83F7281EC9
	for <lists+linux-integrity@lfdr.de>; Sat,  3 Oct 2020 01:00:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725616AbgJBXAD (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 2 Oct 2020 19:00:03 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:11248 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725283AbgJBXAC (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 2 Oct 2020 19:00:02 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 092MhqIb004928
        for <linux-integrity@vger.kernel.org>; Fri, 2 Oct 2020 19:00:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=to : from : subject :
 message-id : date : mime-version : content-type :
 content-transfer-encoding; s=pp1;
 bh=IZJTzXYnHEHGZDT76QAk/HCXUKD1h3nNiiylf4EjbE0=;
 b=NOUluGk7kk3sruyy7mC6EV8H1TsvJ1nes78zEoaLFikt6vV99oLbGlSFZ3jUc1wehFEn
 lfTaJN6WmG3JGr9/u6vzGO959Uu8kOC4VEqPck6m4seyy1GHb1AfuMxIQVf5oJE5XpDf
 6+wWL1WL8YkZ45bvkg3XmqQ03PYv47Hf9kIkFYcFQcruzJiyzXjEcaI2xq8Ua54kkz0U
 VIZOBG0j9FEKUvSXXoftMhXINIOXSmMtBCBD1Fc5+oqsFr+ulroBPwVPRACIF9IcQbkp
 yQXxu2RX1ElTKL0vgYHjxvTFlvsmTcWtjnSjgpx34Doog0Xk5Yzv667MJymPjuAENwWb 7w== 
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0b-001b2d01.pphosted.com with ESMTP id 33xd8mg8d6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Fri, 02 Oct 2020 19:00:01 -0400
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 092Mw9Zo020895
        for <linux-integrity@vger.kernel.org>; Fri, 2 Oct 2020 23:00:01 GMT
Received: from b03cxnp08028.gho.boulder.ibm.com (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
        by ppma04dal.us.ibm.com with ESMTP id 33sw9a7bnu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Fri, 02 Oct 2020 23:00:00 +0000
Received: from b03ledav001.gho.boulder.ibm.com (b03ledav001.gho.boulder.ibm.com [9.17.130.232])
        by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 092MxxWa1114748
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-integrity@vger.kernel.org>; Fri, 2 Oct 2020 22:59:59 GMT
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7ED206E052
        for <linux-integrity@vger.kernel.org>; Fri,  2 Oct 2020 22:59:59 +0000 (GMT)
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5387A6E050
        for <linux-integrity@vger.kernel.org>; Fri,  2 Oct 2020 22:59:59 +0000 (GMT)
Received: from [9.85.170.54] (unknown [9.85.170.54])
        by b03ledav001.gho.boulder.ibm.com (Postfix) with ESMTP
        for <linux-integrity@vger.kernel.org>; Fri,  2 Oct 2020 22:59:59 +0000 (GMT)
To:     Linux Integrity <linux-integrity@vger.kernel.org>
From:   Ken Goldman <kgold@linux.ibm.com>
Subject: [PATCH 1/6] ima-evm-utils: Change env variable TPM_SERVER_TYPE for,
 tpm_server
Message-ID: <0d8f7639-6bbb-8be2-a134-ccb04c17e69b@linux.ibm.com>
Date:   Fri, 2 Oct 2020 18:59:59 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-10-02_14:2020-10-02,2020-10-02 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 impostorscore=0
 suspectscore=0 bulkscore=0 clxscore=1015 malwarescore=0 mlxscore=0
 lowpriorityscore=0 adultscore=0 phishscore=0 priorityscore=1501
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2010020171
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

The default value raw is appropriate for 'swtpm'.  tpm_server
uses the Microsoft packet encapsulation, so the env variable
must have the value mssim.

Signed-off-by: Ken Goldman <kgoldman@us.ibm.com>
---
  tests/boot_aggregate.test | 3 +++
  1 file changed, 3 insertions(+)

diff --git a/tests/boot_aggregate.test b/tests/boot_aggregate.test
index 1c7b1f2..0c58469 100755
--- a/tests/boot_aggregate.test
+++ b/tests/boot_aggregate.test
@@ -35,6 +35,7 @@ else
  	export TPM_COMMAND_PORT=2321
  	export TPM_PLATFORM_PORT=2322
  	export TPM_SERVER_NAME="localhost"
+        # swtpm uses the raw, unencapsulated packet format
  	export TPM_SERVER_TYPE="raw"

  fi
@@ -73,6 +74,8 @@ swtpm_start() {
  			SWTPM_PPID=$!
  		fi
  	elif [ -n "${swtpm}" ]; then
+	        # tpm_server uses the Microsoft simulator encapsulated packet 
format
+                export TPM_SERVER_TYPE="mssim"
  		pgrep swtpm
  		if [ $? -eq 0 ]; then
  			echo "INFO: Software TPM (tpm_server) already running"
-- 
2.25.1

