Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BC9F4170D32
	for <lists+linux-integrity@lfdr.de>; Thu, 27 Feb 2020 01:27:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728056AbgB0A1D (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 26 Feb 2020 19:27:03 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:58796 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727987AbgB0A1D (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 26 Feb 2020 19:27:03 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01R0KHul132601;
        Wed, 26 Feb 2020 19:26:57 -0500
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com [169.47.144.26])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ydcp5asju-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 Feb 2020 19:26:57 -0500
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
        by ppma04wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 01R0NBCt013507;
        Thu, 27 Feb 2020 00:26:56 GMT
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com [9.57.198.24])
        by ppma04wdc.us.ibm.com with ESMTP id 2ydcmks5vp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Feb 2020 00:26:56 +0000
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com [9.57.199.106])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 01R0Qt5e49873184
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Feb 2020 00:26:55 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9E5C028058;
        Thu, 27 Feb 2020 00:26:55 +0000 (GMT)
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 854E928059;
        Thu, 27 Feb 2020 00:26:55 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu, 27 Feb 2020 00:26:55 +0000 (GMT)
From:   Stefan Berger <stefanb@linux.vnet.ibm.com>
To:     jarkko.sakkinen@linux.intel.com, linux-integrity@vger.kernel.org
Cc:     aik@ozlabs.ru, david@gibson.dropbear.id.au,
        linux-kernel@vger.kernel.org, nayna@linux.vnet.ibm.com,
        gcwilson@linux.ibm.com, jgg@ziepe.ca,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v3 0/4]  Enable vTPM 2.0 for the IBM vTPM driver
Date:   Wed, 26 Feb 2020 19:26:50 -0500
Message-Id: <20200227002654.7536-1-stefanb@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-26_09:2020-02-26,2020-02-26 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1015
 adultscore=0 bulkscore=0 mlxscore=0 phishscore=0 impostorscore=0
 lowpriorityscore=0 suspectscore=0 mlxlogscore=999 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002270000
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Stefan Berger <stefanb@linux.ibm.com>

QEMU 5.0 will support the PAPR vTPM device model for TPM 1.2 and TPM 2.0.
This series of patches enables vTPM 2.0 support for the IBM vTPM driver.

Regards,
   Stefan

- v2->v3:
  - Added fixes tag to patch 2/4; the race seems to have existed
    since the driver was first added
  - Renamed tpm2_init to tpm2_init_commands in 3/4

- v1->v2:
  - Addressed comments to v1; added patch 3 to handle case when
    TPM_OPS_AUTO_STARTUP is not set


Stefan Berger (4):
  tpm: of: Handle IBM,vtpm20 case when getting log parameters
  tpm: ibmvtpm: Wait for buffer to be set before proceeding
  tpm: Implement tpm2_init_commands to use in non-auto startup case
  tpm: ibmvtpm: Add support for TPM 2

 drivers/char/tpm/eventlog/of.c   |  8 +++++++-
 drivers/char/tpm/tpm-interface.c |  5 ++++-
 drivers/char/tpm/tpm.h           |  1 +
 drivers/char/tpm/tpm2-cmd.c      | 14 ++++++++++++++
 drivers/char/tpm/tpm_ibmvtpm.c   | 13 +++++++++++++
 drivers/char/tpm/tpm_ibmvtpm.h   |  1 +
 6 files changed, 40 insertions(+), 2 deletions(-)

-- 
2.23.0

