Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74F2F1FBD92
	for <lists+linux-integrity@lfdr.de>; Tue, 16 Jun 2020 20:09:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731239AbgFPSI4 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 16 Jun 2020 14:08:56 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:9356 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727083AbgFPSIz (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 16 Jun 2020 14:08:55 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05GI3N3C020675
        for <linux-integrity@vger.kernel.org>; Tue, 16 Jun 2020 14:08:54 -0400
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0a-001b2d01.pphosted.com with ESMTP id 31q15gkxtu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Tue, 16 Jun 2020 14:08:54 -0400
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 05GI5chf026611
        for <linux-integrity@vger.kernel.org>; Tue, 16 Jun 2020 18:08:53 GMT
Received: from b03cxnp08028.gho.boulder.ibm.com (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
        by ppma03dal.us.ibm.com with ESMTP id 31nbyukeux-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Tue, 16 Jun 2020 18:08:53 +0000
Received: from b03ledav003.gho.boulder.ibm.com (b03ledav003.gho.boulder.ibm.com [9.17.130.234])
        by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 05GI8o0A16974290
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 Jun 2020 18:08:50 GMT
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AF97F6A04D;
        Tue, 16 Jun 2020 18:08:50 +0000 (GMT)
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3441E6A04F;
        Tue, 16 Jun 2020 18:08:50 +0000 (GMT)
Received: from DESKTOP-AV6EVPG.localdomain (unknown [9.160.15.214])
        by b03ledav003.gho.boulder.ibm.com (Postfix) with ESMTP;
        Tue, 16 Jun 2020 18:08:49 +0000 (GMT)
From:   Maurizio Drocco <maurizio.drocco@ibm.com>
To:     zohar@linux.ibm.com
Cc:     linux-integrity@vger.kernel.org, maurizio.drocco@ibm.com
Subject: [PATCH] ima_evm_utils: tests: boot_aggregate.test spans PCRs 0-9
Date:   Tue, 16 Jun 2020 10:28:30 -0400
Message-Id: <20200616142830.16781-1-maurizio.drocco@ibm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <1592327991.11061.205.camel@linux.ibm.com>
References: <1592327991.11061.205.camel@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-16_10:2020-06-16,2020-06-16 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 spamscore=0
 cotscore=-2147483648 lowpriorityscore=0 clxscore=1015 suspectscore=1
 adultscore=0 mlxscore=0 priorityscore=1501 malwarescore=0 phishscore=0
 mlxlogscore=742 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006160127
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

display_pcrs() should include PCRS 8 - 9 as they are non-zeros on some
systems. boot_aggregate may span PCRs 0 - 9 so check()'s info message
should be fixed accordingly.

Signed-off-by: Maurizio Drocco <maurizio.drocco@ibm.com>
---
 tests/boot_aggregate.test | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tests/boot_aggregate.test b/tests/boot_aggregate.test
index 39bd058..8a5581f 100755
--- a/tests/boot_aggregate.test
+++ b/tests/boot_aggregate.test
@@ -81,12 +81,12 @@ swtpm_init() {
 
 # In VERBOSE mode, display the calculated TPM PCRs for the different banks.
 display_pcrs() {
-	local PCRMAX=7
+	local PCRMAX=9
 	local banks=("sha1" "sha256")
 	local i;
 
 	for bank in "${banks[@]}"; do
-		echo "INFO: Displaying ${bank} TPM bank (PCRs 0 - 7)"
+		echo "INFO: Displaying ${bank} TPM bank (PCRs 0 - 9)"
 		for i in $(seq 0 $PCRMAX); do
 			rc=0
 			pcr=$("${TSSDIR}/tsspcrread" -halg "${bank}" -ha "${i}" -ns)
@@ -107,7 +107,7 @@ display_pcrs() {
 # Verify that the last "boot_aggregate" record in the IMA measurement
 # list matches.
 check() {
-	echo "INFO: Calculating the boot_aggregate (PCRs 0 - 7) for multiple banks"
+	echo "INFO: Calculating the boot_aggregate (PCRs 0 - 9) for multiple banks"
 	bootaggr=$(evmctl ima_boot_aggregate)
 	if [ $? -ne 0 ]; then
 		echo "${CYAN}SKIP: evmctl ima_boot_aggregate: $bootaggr${NORM}"
-- 
2.17.1

