Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7C292051D0
	for <lists+linux-integrity@lfdr.de>; Tue, 23 Jun 2020 14:07:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732566AbgFWMHn (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 23 Jun 2020 08:07:43 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:53122 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732333AbgFWMHm (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 23 Jun 2020 08:07:42 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05NC2K1K015116;
        Tue, 23 Jun 2020 08:06:38 -0400
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com [169.63.121.186])
        by mx0a-001b2d01.pphosted.com with ESMTP id 31uhcqr422-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 23 Jun 2020 08:06:38 -0400
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
        by ppma03wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 05NBuFk6001568;
        Tue, 23 Jun 2020 12:06:38 GMT
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com [9.57.198.26])
        by ppma03wdc.us.ibm.com with ESMTP id 31sa38eywe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 23 Jun 2020 12:06:38 +0000
Received: from b01ledav002.gho.pok.ibm.com (b01ledav002.gho.pok.ibm.com [9.57.199.107])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 05NC6bSD16122874
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 23 Jun 2020 12:06:37 GMT
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B403212405A;
        Tue, 23 Jun 2020 12:06:37 +0000 (GMT)
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9AE72124054;
        Tue, 23 Jun 2020 12:06:37 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b01ledav002.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue, 23 Jun 2020 12:06:37 +0000 (GMT)
From:   Stefan Berger <stefanb@linux.vnet.ibm.com>
To:     linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        jarkko.sakkinen@linux.intel.com, linux-acpi@vger.kernel.org,
        linux-security-module@vger.kernel.org
Cc:     Stefan Berger <stfeanb@linux.ibm.com>
Subject: [PATCH v5 0/2] tpm2: Make TPM2 logs accessible for non-UEFI firmware
Date:   Tue, 23 Jun 2020 08:06:34 -0400
Message-Id: <20200623120636.1453470-1-stefanb@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-23_06:2020-06-23,2020-06-23 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 suspectscore=0 mlxlogscore=715 spamscore=0 bulkscore=0 lowpriorityscore=0
 cotscore=-2147483648 mlxscore=0 priorityscore=1501 malwarescore=0
 clxscore=1011 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006230088
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Stefan Berger <stfeanb@linux.ibm.com>

This series of patches extends the existing TPM2 ACPI table with additional
fields found in the TPM2 TCG ACPI specification (reference is in the patch)
that allow access to the log's address and its size. We then modify the
code that so far only enables access to a TPM 1.2's log for a TPM2 as well.
This then enables access to the TPM2's log on non-UEFI system that for example
run SeaBIOS.

   Stefan

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

 drivers/char/tpm/eventlog/acpi.c | 56 ++++++++++++++++++++------------
 drivers/char/tpm/tpm_crb.c       | 13 ++++++--
 drivers/char/tpm/tpm_tis.c       |  4 ++-
 include/acpi/actbl3.h            |  5 +--
 4 files changed, 51 insertions(+), 27 deletions(-)

-- 
2.26.2

