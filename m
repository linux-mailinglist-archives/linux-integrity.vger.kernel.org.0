Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5C685151B46
	for <lists+linux-integrity@lfdr.de>; Tue,  4 Feb 2020 14:27:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727269AbgBDN1Z (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 4 Feb 2020 08:27:25 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:2524 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727209AbgBDN1Z (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 4 Feb 2020 08:27:25 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 014DOb7P025299;
        Tue, 4 Feb 2020 08:27:18 -0500
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2xxp0fuhea-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 04 Feb 2020 08:27:17 -0500
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 014DP0iP012190;
        Tue, 4 Feb 2020 13:27:17 GMT
Received: from b03cxnp08026.gho.boulder.ibm.com (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
        by ppma02dal.us.ibm.com with ESMTP id 2xw0y6qxav-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 04 Feb 2020 13:27:17 +0000
Received: from b03ledav006.gho.boulder.ibm.com (b03ledav006.gho.boulder.ibm.com [9.17.130.237])
        by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 014DRF3531719882
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 4 Feb 2020 13:27:15 GMT
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 33594C605B;
        Tue,  4 Feb 2020 13:27:15 +0000 (GMT)
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 852C1C6055;
        Tue,  4 Feb 2020 13:27:14 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTP;
        Tue,  4 Feb 2020 13:27:14 +0000 (GMT)
From:   Stefan Berger <stefanb@linux.vnet.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     aik@ozlabs.ru, david@gibson.dropbear.id.au,
        linux-kernel@vger.kernel.org, nayna@linux.vnet.ibm.com,
        gcwilson@linux.ibm.com, Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH 0/3] Enable vTPM 2.0 for the IBM vTPM driver
Date:   Tue,  4 Feb 2020 08:27:03 -0500
Message-Id: <20200204132706.3220416-1-stefanb@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-04_04:2020-02-04,2020-02-04 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 suspectscore=1 malwarescore=0 adultscore=0 mlxscore=0
 impostorscore=0 bulkscore=0 mlxlogscore=951 clxscore=1011 spamscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1911200001 definitions=main-2002040095
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Stefan Berger <stefanb@linux.ibm.com>

QEMU 5.0 will support the PAPR vTPM device model for TPM 1.2 and TPM 2.0.
This series of patches enables vTPM 2.0 support for the IBM vTPM driver.

Regards,
   Stefan

Stefan Berger (3):
  tpm: of: Handle IBM,vtpm20 case when getting log parameters
  tpm: ibmvtpm: Wait for buffer to be set before proceeding
  tpm: ibmvtpm: Add support for TPM 2

 drivers/char/tpm/eventlog/of.c |  3 ++-
 drivers/char/tpm/tpm_ibmvtpm.c | 17 ++++++++++++++++-
 drivers/char/tpm/tpm_ibmvtpm.h |  1 +
 3 files changed, 19 insertions(+), 2 deletions(-)

-- 
2.23.0

