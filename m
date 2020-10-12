Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2815A28C55C
	for <lists+linux-integrity@lfdr.de>; Tue, 13 Oct 2020 01:44:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388814AbgJLXoc (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 12 Oct 2020 19:44:32 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:28142 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388759AbgJLXoc (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 12 Oct 2020 19:44:32 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 09CNWwqs097073
        for <linux-integrity@vger.kernel.org>; Mon, 12 Oct 2020 19:44:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=4AAjb3PftdUw7W8InFz6aUjFPOmEncf+UEBNT5Y+qV4=;
 b=G692nCwepP+uFgn7wL2VgLUEQ+UPqElVeV3P+5t4zubsMvGqTnOCm0h4KwKZ1ykhZMTV
 snCJJ9j0nRL1F0GGA6Ne12HygFqbDA553jAXDrgsa7LfAgiFI0VTglO86y77Ek9+5ikH
 SRFxf7DYlZ1Y79Uqzq/W+SCD+Z2XAqn55YnzATzmb0emJ4YVEmKRLyRq3pF4962T1Sin
 CX8lfzrlWSkrr7fzB85cvqDghRwrpZadV42ViPozX1ZaIOFxdYFqb+ufcD8CBDO5p+YJ
 K6weqSIHwshhZCTFy7HfdzzO8jEYsnOpayBVPTsQyZulCmzz5rctqi4yEWr9OfVlZsrT Kg== 
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0a-001b2d01.pphosted.com with ESMTP id 34500v98fr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Mon, 12 Oct 2020 19:44:31 -0400
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 09CNgTEX021740
        for <linux-integrity@vger.kernel.org>; Mon, 12 Oct 2020 23:44:31 GMT
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com [9.57.198.28])
        by ppma04dal.us.ibm.com with ESMTP id 3434k901c9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Mon, 12 Oct 2020 23:44:31 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 09CNiTaM40829280
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 12 Oct 2020 23:44:29 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8894BB205F;
        Mon, 12 Oct 2020 23:44:29 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 16180B2064;
        Mon, 12 Oct 2020 23:44:29 +0000 (GMT)
Received: from eve.home (unknown [9.85.142.21])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon, 12 Oct 2020 23:44:28 +0000 (GMT)
From:   Ken Goldman <kgoldman@us.ibm.com>
To:     Linux Integrity <linux-integrity@vger.kernel.org>
Cc:     Mimi Zohar <zohar@linux.ibm.com>, Ken Goldman <kgoldman@us.ibm.com>
Subject: [PATCH v2 4/5] ima-evm-utils: Correct spelling errors
Date:   Mon, 12 Oct 2020 19:44:15 -0400
Message-Id: <20201012234416.20995-5-kgoldman@us.ibm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201012234416.20995-1-kgoldman@us.ibm.com>
References: <20201012234416.20995-1-kgoldman@us.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-10-12_18:2020-10-12,2020-10-12 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 clxscore=1015 phishscore=0 lowpriorityscore=0 mlxscore=0 adultscore=0
 spamscore=0 malwarescore=0 bulkscore=0 mlxlogscore=992 impostorscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010120171
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

