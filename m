Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 780B520A7C0
	for <lists+linux-integrity@lfdr.de>; Thu, 25 Jun 2020 23:50:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391217AbgFYVuH (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 25 Jun 2020 17:50:07 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:5758 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2391209AbgFYVuG (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 25 Jun 2020 17:50:06 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05PLXWtv120012;
        Thu, 25 Jun 2020 17:50:04 -0400
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0a-001b2d01.pphosted.com with ESMTP id 31vxqkhqre-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 25 Jun 2020 17:50:04 -0400
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 05PLk3iA023067;
        Thu, 25 Jun 2020 21:50:02 GMT
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com [9.57.198.29])
        by ppma01dal.us.ibm.com with ESMTP id 31uuruu3mb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 25 Jun 2020 21:50:02 +0000
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com [9.57.199.106])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 05PLo1uE41288188
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 25 Jun 2020 21:50:01 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4F03A28065;
        Thu, 25 Jun 2020 21:50:01 +0000 (GMT)
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 30D312805C;
        Thu, 25 Jun 2020 21:50:01 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu, 25 Jun 2020 21:50:01 +0000 (GMT)
From:   Stefan Berger <stefanb@linux.vnet.ibm.com>
To:     linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        jarkko.sakkinen@linux.intel.com, linux-acpi@vger.kernel.org,
        linux-security-module@vger.kernel.org
Cc:     Stefan Berger <stefanb@linux.ibm.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH v7 1/2] acpi: Extend TPM2 ACPI table with missing log fields
Date:   Thu, 25 Jun 2020 17:49:59 -0400
Message-Id: <20200625215000.2052086-2-stefanb@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200625215000.2052086-1-stefanb@linux.vnet.ibm.com>
References: <20200625215000.2052086-1-stefanb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-25_19:2020-06-25,2020-06-25 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 bulkscore=0 phishscore=0 clxscore=1015 lowpriorityscore=0 mlxlogscore=999
 malwarescore=0 impostorscore=0 priorityscore=1501 cotscore=-2147483648
 spamscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006250125
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Stefan Berger <stefanb@linux.ibm.com>

Recent extensions of the TPM2 ACPI table added 3 more fields
including 12 bytes of start method specific parameters and Log Area
Minimum Length (u32) and Log Area Start Address (u64). So, we define
a new structure acpi_tpm2_phy that holds these optional new fields.
The new fields allow non-UEFI systems to access the TPM2's log.

The specification that has the new fields is the following:
  TCG ACPI Specification
  Family "1.2" and "2.0"
  Version 1.2, Revision 8

https://trustedcomputinggroup.org/wp-content/uploads/TCG_ACPIGeneralSpecification_v1.20_r8.pdf

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
Cc: linux-acpi@vger.kernel.org
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
---
 include/acpi/actbl3.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/acpi/actbl3.h b/include/acpi/actbl3.h
index b0b163b9efc6..bdcac69fa6bd 100644
--- a/include/acpi/actbl3.h
+++ b/include/acpi/actbl3.h
@@ -415,6 +415,13 @@ struct acpi_table_tpm2 {
 	/* Platform-specific data follows */
 };
 
+/* Optional trailer for revision 4 holding platform-specific data */
+struct acpi_tpm2_phy {
+	u8  start_method_specific[12];
+	u32 log_area_minimum_length;
+	u64 log_area_start_address;
+};
+
 /* Values for start_method above */
 
 #define ACPI_TPM2_NOT_ALLOWED                       0
-- 
2.26.2

