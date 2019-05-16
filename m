Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1FB9C20FE2
	for <lists+linux-integrity@lfdr.de>; Thu, 16 May 2019 23:13:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727086AbfEPVM7 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 16 May 2019 17:12:59 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:44910 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726464AbfEPVM7 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 16 May 2019 17:12:59 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4GKvOAW018407
        for <linux-integrity@vger.kernel.org>; Thu, 16 May 2019 17:12:58 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2shdeuvv9e-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Thu, 16 May 2019 17:12:57 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Thu, 16 May 2019 22:12:56 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 16 May 2019 22:12:54 +0100
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x4GLCrri39321776
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 May 2019 21:12:53 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9E1A211C050;
        Thu, 16 May 2019 21:12:53 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E2B6D11C052;
        Thu, 16 May 2019 21:12:52 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.95.241])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 16 May 2019 21:12:52 +0000 (GMT)
Subject: [PATCH] ima: skip verifying TPM 2.0 PCR values
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     linux-integrity <linux-integrity@vger.kernel.org>
Cc:     ltp@lists.linux.it, Petr Vorel <pvorel@suse.cz>
Date:   Thu, 16 May 2019 17:12:42 -0400
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19051621-4275-0000-0000-00000335964D
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19051621-4276-0000-0000-000038451F7A
Message-Id: <1558041162.3971.2.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-16_16:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905160129
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

TPM 1.2 exported the PCRs.  Reading the TPM 2.0 PCRs requires a
userspace application.  For now, skip this test.

Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
---
 testcases/kernel/security/integrity/ima/tests/ima_tpm.sh | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/testcases/kernel/security/integrity/ima/tests/ima_tpm.sh b/testcases/kernel/security/integrity/ima/tests/ima_tpm.sh
index 0ffc3c02247d..ebe4b4c360e4 100755
--- a/testcases/kernel/security/integrity/ima/tests/ima_tpm.sh
+++ b/testcases/kernel/security/integrity/ima/tests/ima_tpm.sh
@@ -88,6 +88,14 @@ test2()
 	tst_res TINFO "verify PCR values"
 	tst_check_cmds evmctl
 
+	local tpm_description="/sys/class/tpm/tpm0/device/description"
+	if [ -f "$tpm_description" ]; then
+		if grep -q "^\TPM 2.0" $tpm_description; then
+			tst_res TCONF "TPM 2.0 enabled, but not supported"
+			return 0
+		fi
+	fi
+
 	tst_res TINFO "evmctl version: $(evmctl --version)"
 
 	local pcrs_path="/sys/class/tpm/tpm0/device/pcrs"
-- 
2.7.5

