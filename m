Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A70A6197F5D
	for <lists+linux-integrity@lfdr.de>; Mon, 30 Mar 2020 17:15:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728123AbgC3PPl (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 30 Mar 2020 11:15:41 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:5566 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725268AbgC3PPl (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 30 Mar 2020 11:15:41 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02UF4jAg033441;
        Mon, 30 Mar 2020 11:15:39 -0400
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com [169.55.91.170])
        by mx0b-001b2d01.pphosted.com with ESMTP id 301ygv18fd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Mar 2020 11:15:38 -0400
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
        by ppma02wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 02UFFGRl013176;
        Mon, 30 Mar 2020 15:15:38 GMT
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com [9.57.198.27])
        by ppma02wdc.us.ibm.com with ESMTP id 301x76hn06-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Mar 2020 15:15:38 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 02UFFbcQ52363576
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 30 Mar 2020 15:15:37 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CE65CB2067;
        Mon, 30 Mar 2020 15:15:37 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B6A3CB205F;
        Mon, 30 Mar 2020 15:15:37 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon, 30 Mar 2020 15:15:37 +0000 (GMT)
From:   Stefan Berger <stefanb@linux.vnet.ibm.com>
To:     linux-integrity@vger.kernel.org, jarkko.sakkinen@linux.intel.com,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-security-module@vger.kernel.org
Cc:     Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v2 0/3] tpm2: Make TPM2 logs accessible for non-UEFI firmware
Date:   Mon, 30 Mar 2020 11:15:33 -0400
Message-Id: <20200330151536.871700-1-stefanb@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-03-30_06:2020-03-30,2020-03-30 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 spamscore=0 lowpriorityscore=0 suspectscore=0 clxscore=1011
 priorityscore=1501 impostorscore=0 adultscore=0 bulkscore=0
 mlxlogscore=933 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2003020000 definitions=main-2003300139
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

v1->v2:
  - Repost of the series

Stefan Berger (3):
  acpi: Extend TPM2 ACPI table with missing log fields
  tpm: Rearrange ACPI log code to easier extend for TPM2 case
  tpm: Add support for ACPI logs from TPM2 ACPI table

 drivers/char/tpm/eventlog/acpi.c | 54 ++++++++++++++++++++++++----------------
 drivers/char/tpm/tpm_crb.c       | 13 +++++++---
 drivers/char/tpm/tpm_tis.c       |  4 ++-
 include/acpi/actbl3.h            |  5 ++--
 4 files changed, 49 insertions(+), 27 deletions(-)

-- 
2.14.5

