Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B615288D54
	for <lists+linux-integrity@lfdr.de>; Fri,  9 Oct 2020 17:52:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389453AbgJIPwC (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 9 Oct 2020 11:52:02 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:16770 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2388745AbgJIPwC (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 9 Oct 2020 11:52:02 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 099FXEde017988
        for <linux-integrity@vger.kernel.org>; Fri, 9 Oct 2020 11:52:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=to : from : subject :
 message-id : date : mime-version : content-type :
 content-transfer-encoding; s=pp1;
 bh=4AAjb3PftdUw7W8InFz6aUjFPOmEncf+UEBNT5Y+qV4=;
 b=SCMnM4p3pCCe+L3DcdR5Lbl/eV2aimUkdZgImheAnMWB+GGhRqxnk5vPNMCKfgWEKR3Q
 RIuvoYnGjeBPvwvyExYjdySNF9dEU754767HLnbzHob990IrI6dpyhBJOG43mz5IpTZg
 On/C/IKFlbDmbF3iZdK0SRn/WyleKrUmDYpmsm8SPHELacoZHdPE9k2yaqjgg4yC23JC
 OwDQCweLy1qopUOcJp2UDes/eb8MGuoEStgJOuwRB9rgs7c9BPgD3LwXqpIddiW5ZPeV
 KAFhNR/VMVFXMrJqjMrGUGbbl2GP9OgypP7hPjT1j/HJMIoK8w77qMVS/YFqGXmiRGLj pA== 
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0b-001b2d01.pphosted.com with ESMTP id 342t4xsv87-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Fri, 09 Oct 2020 11:52:01 -0400
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 099FlkE5031332
        for <linux-integrity@vger.kernel.org>; Fri, 9 Oct 2020 15:52:01 GMT
Received: from b03cxnp08028.gho.boulder.ibm.com (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
        by ppma02dal.us.ibm.com with ESMTP id 3429hrg0dq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Fri, 09 Oct 2020 15:52:00 +0000
Received: from b03ledav006.gho.boulder.ibm.com (b03ledav006.gho.boulder.ibm.com [9.17.130.237])
        by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 099Fpxba48366010
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-integrity@vger.kernel.org>; Fri, 9 Oct 2020 15:51:59 GMT
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 88115C6055
        for <linux-integrity@vger.kernel.org>; Fri,  9 Oct 2020 15:51:59 +0000 (GMT)
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 59643C6059
        for <linux-integrity@vger.kernel.org>; Fri,  9 Oct 2020 15:51:59 +0000 (GMT)
Received: from [9.85.186.165] (unknown [9.85.186.165])
        by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTP
        for <linux-integrity@vger.kernel.org>; Fri,  9 Oct 2020 15:51:59 +0000 (GMT)
To:     Linux Integrity <linux-integrity@vger.kernel.org>
From:   Ken Goldman <kgold@linux.ibm.com>
Subject: [PATCH 4/5] ima-evm-utils: Correct spelling errors
Message-ID: <73653f1c-a611-7b36-9804-7a7fdc2de00a@linux.ibm.com>
Date:   Fri, 9 Oct 2020 11:51:58 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-10-09_06:2020-10-09,2020-10-09 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 impostorscore=0
 clxscore=1015 phishscore=0 lowpriorityscore=0 mlxlogscore=999 spamscore=0
 bulkscore=0 malwarescore=0 mlxscore=0 suspectscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010090112
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

In comments and error messages.  No impact to code.

Signed-off-by: Ken Goldman <kgoldman@us.ibm.com>
---
  tests/boot_aggregate.test | 4 ++--
  1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/boot_aggregate.test b/tests/boot_aggregate.test
index b109a32..9967de2 100755
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

