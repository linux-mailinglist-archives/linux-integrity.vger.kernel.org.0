Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1D5B916F0A1
	for <lists+linux-integrity@lfdr.de>; Tue, 25 Feb 2020 21:53:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728367AbgBYUxS (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 25 Feb 2020 15:53:18 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:61582 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729117AbgBYUxS (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 25 Feb 2020 15:53:18 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01PKpxQT105746;
        Tue, 25 Feb 2020 15:53:09 -0500
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com [169.63.121.186])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2yb1asytrw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Feb 2020 15:53:09 -0500
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
        by ppma03wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 01PKgMQ3021084;
        Tue, 25 Feb 2020 20:53:09 GMT
Received: from b03cxnp08027.gho.boulder.ibm.com (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
        by ppma03wdc.us.ibm.com with ESMTP id 2yaux6f2xm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Feb 2020 20:53:09 +0000
Received: from b03ledav002.gho.boulder.ibm.com (b03ledav002.gho.boulder.ibm.com [9.17.130.233])
        by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 01PKr7pH29032846
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Feb 2020 20:53:07 GMT
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 88FEC136059;
        Tue, 25 Feb 2020 20:53:07 +0000 (GMT)
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D1A84136053;
        Tue, 25 Feb 2020 20:53:06 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b03ledav002.gho.boulder.ibm.com (Postfix) with ESMTP;
        Tue, 25 Feb 2020 20:53:06 +0000 (GMT)
From:   Stefan Berger <stefanb@linux.vnet.ibm.com>
To:     jarkko.sakkinen@linux.intel.com, linux-integrity@vger.kernel.org
Cc:     aik@ozlabs.ru, david@gibson.dropbear.id.au,
        linux-kernel@vger.kernel.org, nayna@linux.vnet.ibm.com,
        gcwilson@linux.ibm.com, jgg@ziepe.ca,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v3 0/4]  Enable vTPM 2.0 for the IBM vTPM driver
Date:   Tue, 25 Feb 2020 15:53:01 -0500
Message-Id: <20200225205305.3948001-1-stefanb@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-25_08:2020-02-25,2020-02-25 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 priorityscore=1501 mlxlogscore=999 malwarescore=0 mlxscore=0 adultscore=0
 phishscore=0 bulkscore=0 clxscore=1015 impostorscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002250145
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

