Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 45B9615CC4B
	for <lists+linux-integrity@lfdr.de>; Thu, 13 Feb 2020 21:25:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727894AbgBMUXi (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 13 Feb 2020 15:23:38 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:57654 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727594AbgBMUXh (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 13 Feb 2020 15:23:37 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01DKL6RS059959;
        Thu, 13 Feb 2020 15:23:33 -0500
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com [169.63.121.186])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2y4qytdy66-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 Feb 2020 15:23:33 -0500
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
        by ppma03wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 01DKKVik016210;
        Thu, 13 Feb 2020 20:23:31 GMT
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com [9.57.198.26])
        by ppma03wdc.us.ibm.com with ESMTP id 2y5bc00va6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 Feb 2020 20:23:31 +0000
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com [9.57.199.109])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 01DKNVY014746568
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 13 Feb 2020 20:23:31 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5CDE5112061;
        Thu, 13 Feb 2020 20:23:31 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 45863112062;
        Thu, 13 Feb 2020 20:23:31 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu, 13 Feb 2020 20:23:31 +0000 (GMT)
From:   Stefan Berger <stefanb@linux.vnet.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     aik@ozlabs.ru, david@gibson.dropbear.id.au,
        linux-kernel@vger.kernel.org, nayna@linux.vnet.ibm.com,
        gcwilson@linux.ibm.com, jgg@ziepe.ca,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v2 1/4] tpm: of: Handle IBM,vtpm20 case when getting log parameters
Date:   Thu, 13 Feb 2020 15:23:26 -0500
Message-Id: <20200213202329.898607-2-stefanb@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200213202329.898607-1-stefanb@linux.vnet.ibm.com>
References: <20200213202329.898607-1-stefanb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-13_08:2020-02-12,2020-02-13 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 phishscore=0
 priorityscore=1501 suspectscore=1 mlxlogscore=999 lowpriorityscore=0
 impostorscore=0 spamscore=0 bulkscore=0 adultscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002130143
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
---
 drivers/char/tpm/eventlog/of.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/char/tpm/eventlog/of.c b/drivers/char/tpm/eventlog/of.c
index af347c190819..a31a625ad44e 100644
--- a/drivers/char/tpm/eventlog/of.c
+++ b/drivers/char/tpm/eventlog/of.c
@@ -17,6 +17,12 @@
 #include "../tpm.h"
 #include "common.h"
 
+static const char * const compatibles[] = {
+	"IBM,vtpm",
+	"IBM,vtpm20",
+	NULL
+};
+
 int tpm_read_log_of(struct tpm_chip *chip)
 {
 	struct device_node *np;
@@ -51,7 +57,7 @@ int tpm_read_log_of(struct tpm_chip *chip)
 	 * endian format. For this reason, vtpm doesn't need conversion
 	 * but physical tpm needs the conversion.
 	 */
-	if (of_property_match_string(np, "compatible", "IBM,vtpm") < 0) {
+	if (!of_device_compatible_match(np, compatibles)) {
 		size = be32_to_cpup((__force __be32 *)sizep);
 		base = be64_to_cpup((__force __be64 *)basep);
 	} else {
-- 
2.23.0

