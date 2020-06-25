Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CC1320A7BB
	for <lists+linux-integrity@lfdr.de>; Thu, 25 Jun 2020 23:50:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390614AbgFYVuE (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 25 Jun 2020 17:50:04 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:58046 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390020AbgFYVuE (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 25 Jun 2020 17:50:04 -0400
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05PLWoMX011642;
        Thu, 25 Jun 2020 17:50:03 -0400
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0a-001b2d01.pphosted.com with ESMTP id 31ux03y1q7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 25 Jun 2020 17:50:02 -0400
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 05PLk62X018500;
        Thu, 25 Jun 2020 21:50:02 GMT
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com [9.57.198.29])
        by ppma03dal.us.ibm.com with ESMTP id 31uurw32jt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 25 Jun 2020 21:50:01 +0000
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com [9.57.199.106])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 05PLo1mK41288186
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 25 Jun 2020 21:50:01 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2ADE42805A;
        Thu, 25 Jun 2020 21:50:01 +0000 (GMT)
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0A94228065;
        Thu, 25 Jun 2020 21:50:01 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu, 25 Jun 2020 21:50:00 +0000 (GMT)
From:   Stefan Berger <stefanb@linux.vnet.ibm.com>
To:     linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        jarkko.sakkinen@linux.intel.com, linux-acpi@vger.kernel.org,
        linux-security-module@vger.kernel.org
Cc:     Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v7 0/2] tpm2: Make TPM2 logs accessible for non-UEFI firmware
Date:   Thu, 25 Jun 2020 17:49:58 -0400
Message-Id: <20200625215000.2052086-1-stefanb@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-25_19:2020-06-25,2020-06-25 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 clxscore=1015
 lowpriorityscore=0 phishscore=0 impostorscore=0 cotscore=-2147483648
 bulkscore=0 adultscore=0 mlxlogscore=641 mlxscore=0 priorityscore=1501
 spamscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006250125
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Stefan Berger <stefanb@linux.ibm.com>

This series of patches adds an optional extensions for the TPM2 ACPI table
with additional fields found in the TPM2 TCG ACPI specification (reference
is in the patch) that allow access to the log's address and its size. We
then modify the code that so far only enables access to a TPM 1.2's log for
a TPM2 as well. This then enables access to the TPM2's log on non-UEFI
system that for example run SeaBIOS.

   Stefan

v6->v7:
 - Added empty lines and R-b.

v5->v6:
 - Moved extensions of TPM2 table into acpi_tpm2_phy.

v4->v5:
 - Added R-bs and A-bs.

v3->v4:
  - Repost as one series

v2->v3:
  - Split the series into two separate patches
  - Added comments to ACPI table fields
  - Added check for null pointer to log area and zero log size

v1->v2:
  - Repost of the series



Stefan Berger (2):
  acpi: Extend TPM2 ACPI table with missing log fields
  tpm: Add support for event log pointer found in TPM2 ACPI table

 drivers/char/tpm/eventlog/acpi.c | 62 +++++++++++++++++++++-----------
 include/acpi/actbl3.h            |  7 ++++
 2 files changed, 48 insertions(+), 21 deletions(-)

-- 
2.26.2

