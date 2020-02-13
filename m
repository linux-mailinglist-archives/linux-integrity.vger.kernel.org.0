Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D346C15CC3C
	for <lists+linux-integrity@lfdr.de>; Thu, 13 Feb 2020 21:23:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727799AbgBMUXi (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 13 Feb 2020 15:23:38 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:31436 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727519AbgBMUXh (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 13 Feb 2020 15:23:37 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01DKLDss008442;
        Thu, 13 Feb 2020 15:23:32 -0500
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com [169.47.144.27])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2y4wuua2fw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 Feb 2020 15:23:32 -0500
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
        by ppma05wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 01DKKO6Q005790;
        Thu, 13 Feb 2020 20:23:31 GMT
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com [9.57.198.26])
        by ppma05wdc.us.ibm.com with ESMTP id 2y5bbygvby-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 Feb 2020 20:23:31 +0000
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com [9.57.199.109])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 01DKNVSi14746566
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 13 Feb 2020 20:23:31 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3FD7F112061;
        Thu, 13 Feb 2020 20:23:31 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2840C112063;
        Thu, 13 Feb 2020 20:23:31 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu, 13 Feb 2020 20:23:31 +0000 (GMT)
From:   Stefan Berger <stefanb@linux.vnet.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     aik@ozlabs.ru, david@gibson.dropbear.id.au,
        linux-kernel@vger.kernel.org, nayna@linux.vnet.ibm.com,
        gcwilson@linux.ibm.com, jgg@ziepe.ca,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v2 0/4] Enable vTPM 2.0 for the IBM vTPM driver
Date:   Thu, 13 Feb 2020 15:23:25 -0500
Message-Id: <20200213202329.898607-1-stefanb@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-13_08:2020-02-12,2020-02-13 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 clxscore=1015
 priorityscore=1501 suspectscore=1 lowpriorityscore=0 mlxlogscore=999
 adultscore=0 malwarescore=0 spamscore=0 mlxscore=0 impostorscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002130143
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Stefan Berger <stefanb@linux.ibm.com>

QEMU 5.0 will support the PAPR vTPM device model for TPM 1.2 and TPM 2.0.
This series of patches enables vTPM 2.0 support for the IBM vTPM driver.

Regards,
   Stefan

- v1->v2:
  - Addressed comments to v1; added patch 3 to handle case when
    TPM_OPS_AUTO_STARTUP is not set

Stefan Berger (4):
  tpm: of: Handle IBM,vtpm20 case when getting log parameters
  tpm: ibmvtpm: Wait for buffer to be set before proceeding
  tpm: Implement tpm2_init to call when TPM_OPS_AUTO_STARTUP is not set
  tpm: ibmvtpm: Add support for TPM 2

 drivers/char/tpm/eventlog/of.c   |  8 +++++++-
 drivers/char/tpm/tpm-interface.c |  5 ++++-
 drivers/char/tpm/tpm.h           |  1 +
 drivers/char/tpm/tpm2-cmd.c      | 14 ++++++++++++++
 drivers/char/tpm/tpm_ibmvtpm.c   | 15 ++++++++++++++-
 drivers/char/tpm/tpm_ibmvtpm.h   |  1 +
 6 files changed, 41 insertions(+), 3 deletions(-)

-- 
2.23.0

