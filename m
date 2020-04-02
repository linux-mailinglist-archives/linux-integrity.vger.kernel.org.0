Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D1C4619CD18
	for <lists+linux-integrity@lfdr.de>; Fri,  3 Apr 2020 00:51:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390050AbgDBWvq (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 2 Apr 2020 18:51:46 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:53218 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2389951AbgDBWvq (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 2 Apr 2020 18:51:46 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 032MYDaO018611;
        Thu, 2 Apr 2020 18:51:42 -0400
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com [169.47.144.26])
        by mx0b-001b2d01.pphosted.com with ESMTP id 305q27avvu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 02 Apr 2020 18:51:42 -0400
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
        by ppma04wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 032MoPH6011527;
        Thu, 2 Apr 2020 22:51:41 GMT
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com [9.57.198.27])
        by ppma04wdc.us.ibm.com with ESMTP id 301x774bhk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 02 Apr 2020 22:51:41 +0000
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com [9.57.199.106])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 032MpfLE53936610
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 2 Apr 2020 22:51:41 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4CBE0283F8;
        Thu,  2 Apr 2020 22:51:41 +0000 (GMT)
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3299B283F5;
        Thu,  2 Apr 2020 22:51:41 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu,  2 Apr 2020 22:51:41 +0000 (GMT)
From:   Stefan Berger <stefanb@linux.vnet.ibm.com>
To:     linux-integrity@vger.kernel.org, jarkko.sakkinen@linux.intel.com,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-security-module@vger.kernel.org
Cc:     Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v4 0/2] tpm2: Make TPM2 logs accessible for non-UEFI firmware
Date:   Thu,  2 Apr 2020 18:51:38 -0400
Message-Id: <20200402225140.922789-1-stefanb@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-02_12:2020-04-02,2020-04-02 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 malwarescore=0
 lowpriorityscore=0 clxscore=1015 suspectscore=0 spamscore=0
 priorityscore=1501 mlxlogscore=807 bulkscore=0 mlxscore=0 adultscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004020164
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Stefan Berger <stefanb@linux.ibm.com>

This series of patches extends the existing TPM2 ACPI table with additional
fields found in the TPM2 TCG ACPI specification (reference is in the patch)
that allow access to the log's address and its size. We then modify the
code that so far only enables access to a TPM 1.2's log for a TPM2 as well.
This then enables access to the TPM2's log on non-UEFI system that for example
run SeaBIOS.

   Stefan

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

 drivers/char/tpm/eventlog/acpi.c | 56 +++++++++++++++++++++++++---------------
 drivers/char/tpm/tpm_crb.c       | 13 +++++++---
 drivers/char/tpm/tpm_tis.c       |  4 ++-
 include/acpi/actbl3.h            |  5 ++--
 4 files changed, 51 insertions(+), 27 deletions(-)

-- 
2.14.5

