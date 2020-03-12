Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5051D183591
	for <lists+linux-integrity@lfdr.de>; Thu, 12 Mar 2020 16:55:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726677AbgCLPzq (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 12 Mar 2020 11:55:46 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:23642 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726395AbgCLPzq (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 12 Mar 2020 11:55:46 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02CFqR3W096163;
        Thu, 12 Mar 2020 11:55:39 -0400
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2yqpyau4ct-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 Mar 2020 11:55:38 -0400
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 02CFlDjs028676;
        Thu, 12 Mar 2020 15:53:34 GMT
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com [9.57.198.26])
        by ppma03dal.us.ibm.com with ESMTP id 2ypjxs9fhu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 Mar 2020 15:53:34 +0000
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com [9.57.199.110])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 02CFrXMb13632070
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Mar 2020 15:53:33 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 29F01AE05F;
        Thu, 12 Mar 2020 15:53:33 +0000 (GMT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 11089AE062;
        Thu, 12 Mar 2020 15:53:33 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu, 12 Mar 2020 15:53:33 +0000 (GMT)
From:   Stefan Berger <stefanb@linux.vnet.ibm.com>
To:     jarkko.sakkinen@linux.intel.com, linux-integrity@vger.kernel.org
Cc:     aik@ozlabs.ru, david@gibson.dropbear.id.au,
        linux-kernel@vger.kernel.org, nayna@linux.vnet.ibm.com,
        gcwilson@linux.ibm.com, jgg@ziepe.ca,
        Stefan Berger <stefanb@linux.ibm.com>,
        Nayna Jain <nayna@linux.ibm.com>
Subject: [PATCH v7 1/3] tpm: of: Handle IBM,vtpm20 case when getting log parameters
Date:   Thu, 12 Mar 2020 11:53:30 -0400
Message-Id: <20200312155332.671464-2-stefanb@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200312155332.671464-1-stefanb@linux.vnet.ibm.com>
References: <20200312155332.671464-1-stefanb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-03-12_07:2020-03-11,2020-03-12 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 spamscore=0
 suspectscore=0 impostorscore=0 malwarescore=0 mlxlogscore=999 adultscore=0
 phishscore=0 mlxscore=0 bulkscore=0 lowpriorityscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2003120082
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Stefan Berger <stefanb@linux.ibm.com>

A vTPM 2.0 is identified by 'IBM,vtpm20' in the 'compatible' node in
the device tree. Handle it in the same way as 'IBM,vtpm'.

The vTPM 2.0's log is written in little endian format so that for this
aspect we can rely on existing code.

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
Acked-by: Nayna Jain <nayna@linux.ibm.com>
Tested-by: Nayna Jain <nayna@linux.ibm.com>
---
 drivers/char/tpm/eventlog/of.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/char/tpm/eventlog/of.c b/drivers/char/tpm/eventlog/of.c
index af347c190819..a9ce66d09a75 100644
--- a/drivers/char/tpm/eventlog/of.c
+++ b/drivers/char/tpm/eventlog/of.c
@@ -51,7 +51,8 @@ int tpm_read_log_of(struct tpm_chip *chip)
 	 * endian format. For this reason, vtpm doesn't need conversion
 	 * but physical tpm needs the conversion.
 	 */
-	if (of_property_match_string(np, "compatible", "IBM,vtpm") < 0) {
+	if (of_property_match_string(np, "compatible", "IBM,vtpm") < 0 &&
+	    of_property_match_string(np, "compatible", "IBM,vtpm20") < 0) {
 		size = be32_to_cpup((__force __be32 *)sizep);
 		base = be64_to_cpup((__force __be64 *)basep);
 	} else {
-- 
2.23.0

