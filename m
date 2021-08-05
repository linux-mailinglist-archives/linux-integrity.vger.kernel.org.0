Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44F533E1E2B
	for <lists+linux-integrity@lfdr.de>; Thu,  5 Aug 2021 23:53:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235225AbhHEVx0 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 5 Aug 2021 17:53:26 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:44626 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230489AbhHEVxZ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 5 Aug 2021 17:53:25 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 175LlUVi074391;
        Thu, 5 Aug 2021 17:53:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=3viWmys/6KCGWuLJRazlUh8H93bdCeaG8kwOG3zhiJM=;
 b=srozVB8y5Im8zcP+X6v8EaeyNqBoOnoTdYMjy09J55SfYkN6Ch92LB/Begg0v6/t07pz
 esd141AM696X3KT2ctJZKqCgVl1qsk1QdV3saV1K0bmBUDeJ3tDmH/tc37/eHrpL6+ik
 9IT1tBKIzhWiy5oZCSL4xJA5i9c7cXmLP8yrGrHYKpDX2+PYbAPtpkA0YVds0yBlfqoU
 jUefbmCgUqO8X1t8kdQrFExZYN6ff4Xs7Kz7P0/7FSEScsUIGQSzamxPcBOlr7DLrD66
 Qggvvmm23GGVV07Z6L8kVIMdZ5odC6X4JjSIl4bYTgXlVvihiMs6hWzgsbY0YIYzKvlD SA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3a87f6v2ru-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 05 Aug 2021 17:53:10 -0400
Received: from m0098393.ppops.net (m0098393.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 175LnGGB077569;
        Thu, 5 Aug 2021 17:53:10 -0400
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3a87f6v2rk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 05 Aug 2021 17:53:10 -0400
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 175LplFu009383;
        Thu, 5 Aug 2021 21:53:09 GMT
Received: from b03cxnp08027.gho.boulder.ibm.com (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
        by ppma01dal.us.ibm.com with ESMTP id 3a4x5gpdqs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 05 Aug 2021 21:53:09 +0000
Received: from b03ledav001.gho.boulder.ibm.com (b03ledav001.gho.boulder.ibm.com [9.17.130.232])
        by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 175Lr6bG8192502
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 5 Aug 2021 21:53:06 GMT
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 21C0D6E050;
        Thu,  5 Aug 2021 21:53:06 +0000 (GMT)
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9F3736E059;
        Thu,  5 Aug 2021 21:53:05 +0000 (GMT)
Received: from sbct-2.. (unknown [9.47.158.152])
        by b03ledav001.gho.boulder.ibm.com (Postfix) with ESMTP;
        Thu,  5 Aug 2021 21:53:05 +0000 (GMT)
From:   Stefan Berger <stefanb@linux.vnet.ibm.com>
To:     jarkko@kernel.org
Cc:     peterhuewe@gmx.de, jgg@ziepe.ca, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v3 0/2] ibmvtpm: Avoid error message when process gets signal while waiting
Date:   Thu,  5 Aug 2021 17:52:54 -0400
Message-Id: <20210805215256.1293987-1-stefanb@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: qRLBZbLr_uKbNwgS7TTgqGFZ4EVfYIjF
X-Proofpoint-GUID: c7U6Xehts8VAFxWqyb806z2664p04Nbr
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-05_11:2021-08-05,2021-08-05 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 priorityscore=1501 bulkscore=0 phishscore=0 mlxlogscore=981
 suspectscore=0 impostorscore=0 clxscore=1015 mlxscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108050127
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Stefan Berger <stefanb@linux.ibm.com>

This series of patches fixes an issue related to the ibmvtpm driver causing
unnecessary kernel log messages when a process is interrupted while waiting
for the TPM to respond. The aborted wait causes the core TPM driver to emit
the log message. The solution is to convert the driver to use the normal
polling loop to wait for TPM responses.

   Stefan

v3:
 - Split into two patches

Stefan Berger (2):
  tpm: ibmvtpm: Rename tpm_process_cmd to tpm_status and define flag
  tpm: ibmvtpm: Avoid error message when process gets signal while
    waiting

 drivers/char/tpm/tpm_ibmvtpm.c | 31 ++++++++++++++++++-------------
 drivers/char/tpm/tpm_ibmvtpm.h |  3 ++-
 2 files changed, 20 insertions(+), 14 deletions(-)

-- 
2.31.1

