Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 166B82162BC
	for <lists+linux-integrity@lfdr.de>; Tue,  7 Jul 2020 01:58:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727834AbgGFX6M (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 6 Jul 2020 19:58:12 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:15640 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727046AbgGFX6L (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 6 Jul 2020 19:58:11 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 066NWhY2048056;
        Mon, 6 Jul 2020 19:58:10 -0400
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com [169.47.144.27])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3249rbxew0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Jul 2020 19:58:10 -0400
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
        by ppma05wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 066NsfJA029261;
        Mon, 6 Jul 2020 23:58:08 GMT
Received: from b01cxnp22033.gho.pok.ibm.com (b01cxnp22033.gho.pok.ibm.com [9.57.198.23])
        by ppma05wdc.us.ibm.com with ESMTP id 322hd8ug98-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Jul 2020 23:58:08 +0000
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com [9.57.199.111])
        by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 066Nw8Bu17105294
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 6 Jul 2020 23:58:08 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 62908AC05B;
        Mon,  6 Jul 2020 23:58:08 +0000 (GMT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4AEF2AC059;
        Mon,  6 Jul 2020 23:58:08 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon,  6 Jul 2020 23:58:08 +0000 (GMT)
From:   Stefan Berger <stefanb@linux.vnet.ibm.com>
To:     linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        jarkko.sakkinen@linux.intel.com, linux-acpi@vger.kernel.org,
        linux-security-module@vger.kernel.org
Cc:     Stefan Berger <stefanb@linux.ibm.com>
Subject: [RESEND,PATCH v9 0/2] tpm2: Make TPM2 logs accessible for non-UEFI firmware
Date:   Mon,  6 Jul 2020 19:58:05 -0400
Message-Id: <20200706235807.3915586-1-stefanb@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-06_20:2020-07-06,2020-07-06 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 priorityscore=1501 spamscore=0 impostorscore=0 lowpriorityscore=0
 cotscore=-2147483648 clxscore=1015 phishscore=0 suspectscore=0
 adultscore=0 mlxlogscore=683 mlxscore=0 malwarescore=0 classifier=spam
 adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2007060163
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

v8->v9:
 - Renamed variable
 - Added R-b

v7->v8:
 - Added empty line.

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

 drivers/char/tpm/eventlog/acpi.c | 63 +++++++++++++++++++++-----------
 include/acpi/actbl3.h            |  7 ++++
 2 files changed, 49 insertions(+), 21 deletions(-)

-- 
2.26.2

