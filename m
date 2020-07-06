Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D261C215E25
	for <lists+linux-integrity@lfdr.de>; Mon,  6 Jul 2020 20:19:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729718AbgGFST6 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 6 Jul 2020 14:19:58 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:2600 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729550AbgGFST6 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 6 Jul 2020 14:19:58 -0400
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 066I3Y5t113845;
        Mon, 6 Jul 2020 14:19:57 -0400
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com [169.55.85.253])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3248r70mvg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Jul 2020 14:19:57 -0400
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
        by ppma01wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 066IGLdi032484;
        Mon, 6 Jul 2020 18:19:55 GMT
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com [9.57.198.26])
        by ppma01wdc.us.ibm.com with ESMTP id 322hd89gcf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Jul 2020 18:19:55 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 066IJt0p36503914
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 6 Jul 2020 18:19:55 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 31FB6B2064;
        Mon,  6 Jul 2020 18:19:55 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 05F09B205F;
        Mon,  6 Jul 2020 18:19:54 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon,  6 Jul 2020 18:19:54 +0000 (GMT)
From:   Stefan Berger <stefanb@linux.vnet.ibm.com>
To:     linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        jarkko.sakkinen@linux.intel.com, linux-acpi@vger.kernel.org,
        linux-security-module@vger.kernel.org
Cc:     Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v9 0/2] tpm2: Make TPM2 logs accessible for non-UEFI firmware
Date:   Mon,  6 Jul 2020 14:19:51 -0400
Message-Id: <20200706181953.3592084-1-stefanb@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-06_16:2020-07-06,2020-07-06 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=683
 impostorscore=0 cotscore=-2147483648 spamscore=0 priorityscore=1501
 phishscore=0 lowpriorityscore=0 suspectscore=0 clxscore=1015 bulkscore=0
 mlxscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2007060125
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

