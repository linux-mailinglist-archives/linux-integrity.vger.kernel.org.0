Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1CB1518359A
	for <lists+linux-integrity@lfdr.de>; Thu, 12 Mar 2020 16:56:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727303AbgCLP4o (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 12 Mar 2020 11:56:44 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:56332 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726571AbgCLP4o (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 12 Mar 2020 11:56:44 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02CFqMTq095906;
        Thu, 12 Mar 2020 11:55:36 -0400
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com [169.55.85.253])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2yqpyau4a1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 Mar 2020 11:55:35 -0400
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
        by ppma01wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 02CFlGWq019512;
        Thu, 12 Mar 2020 15:53:33 GMT
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com [9.57.198.26])
        by ppma01wdc.us.ibm.com with ESMTP id 2ypjxr5yvr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 Mar 2020 15:53:33 +0000
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com [9.57.199.110])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 02CFrXqQ13632068
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Mar 2020 15:53:33 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0D1DEAE05C;
        Thu, 12 Mar 2020 15:53:33 +0000 (GMT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E8337AE05F;
        Thu, 12 Mar 2020 15:53:32 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu, 12 Mar 2020 15:53:32 +0000 (GMT)
From:   Stefan Berger <stefanb@linux.vnet.ibm.com>
To:     jarkko.sakkinen@linux.intel.com, linux-integrity@vger.kernel.org
Cc:     aik@ozlabs.ru, david@gibson.dropbear.id.au,
        linux-kernel@vger.kernel.org, nayna@linux.vnet.ibm.com,
        gcwilson@linux.ibm.com, jgg@ziepe.ca,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v7 0/3] Enable vTPM 2.0 for the IBM vTPM driver
Date:   Thu, 12 Mar 2020 11:53:29 -0400
Message-Id: <20200312155332.671464-1-stefanb@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.24.1
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

QEMU 5.0 will support the PAPR vTPM device model for TPM 1.2 and TPM 2.0.
This series of patches enables vTPM 2.0 support for the IBM vTPM driver.

Regards,
   Stefan

- v6->v7:
  - reverted changes in 1/3 due to xtensa not supporting API call;
    removed Jarrko's Acked-by
  - Added Nayna's Acked-by adn Tested-by to all patches

- v5->v6:
  - Nits in commit texts

- v4->v5:
  - Added error path in case tpm2_get_cc_attrs_tbl() fails

- v3->v4:
  - Dropped patch 3; getting command code attributes table in IBM driver

- v2->v3:
  - Added fixes tag to patch 2/4; the race seems to have existed
    since the driver was first added
  - Renamed tpm2_init to tpm2_init_commands in 3/4

- v1->v2:
  - Addressed comments to v1; added patch 3 to handle case when
    TPM_OPS_AUTO_STARTUP is not set



Stefan Berger (3):
  tpm: of: Handle IBM,vtpm20 case when getting log parameters
  tpm: ibmvtpm: Wait for buffer to be set before proceeding
  tpm: ibmvtpm: Add support for TPM2

 drivers/char/tpm/eventlog/of.c |  3 ++-
 drivers/char/tpm/tpm.h         |  1 +
 drivers/char/tpm/tpm2-cmd.c    |  2 +-
 drivers/char/tpm/tpm_ibmvtpm.c | 17 +++++++++++++++++
 drivers/char/tpm/tpm_ibmvtpm.h |  1 +
 5 files changed, 22 insertions(+), 2 deletions(-)

-- 
2.23.0

