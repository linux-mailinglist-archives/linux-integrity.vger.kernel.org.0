Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3595B3E4CF7
	for <lists+linux-integrity@lfdr.de>; Mon,  9 Aug 2021 21:22:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235934AbhHITWa (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 9 Aug 2021 15:22:30 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:21486 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231302AbhHITW3 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 9 Aug 2021 15:22:29 -0400
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 179JLbLH178999;
        Mon, 9 Aug 2021 15:22:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=Op+VvbVQlcmo8g+h/17oYfjT+xbWUGgdgkGfd8/ZmkQ=;
 b=O6jTU1+tN7Lqk/7FMrOF8s+tum0/MiG6Drwae0V20MjlmJVFZVViLV4mrVQfEGr6xIWD
 QZKx5o7Vz2h7g5kCyOdfSeqSY2RUe8i8V/LN3r4rHhKeXxZJqAT8uEUy6fBmfDtPz+oT
 o5mvb4g71Tq0OtkoZgxAbCRA2hnqSeydkvfoyBZG+rCX0EODxufGW/FpUEJP8F2pKjYO
 lOJDB9/tk65acSoCvruyVq0tDNSlkA5CL6PQT7bv3G+g95VLQNQuyHv8kUJ6Tq2yPsDq
 DcoPW8FTzunlXzb6onynq9XLPNMNZzJN/FxyBDtLtrw2IsNzF/ziS/+ZzsPp0eMdWkMX +w== 
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3ab9x9gref-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 09 Aug 2021 15:22:07 -0400
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 179JCie9032482;
        Mon, 9 Aug 2021 19:22:06 GMT
Received: from b03cxnp07027.gho.boulder.ibm.com (b03cxnp07027.gho.boulder.ibm.com [9.17.130.14])
        by ppma02dal.us.ibm.com with ESMTP id 3a9htc4w1g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 09 Aug 2021 19:22:06 +0000
Received: from b03ledav002.gho.boulder.ibm.com (b03ledav002.gho.boulder.ibm.com [9.17.130.233])
        by b03cxnp07027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 179JM5RF34603438
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 9 Aug 2021 19:22:05 GMT
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0A7BF136065;
        Mon,  9 Aug 2021 19:22:05 +0000 (GMT)
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6AB3F136063;
        Mon,  9 Aug 2021 19:22:04 +0000 (GMT)
Received: from sbct-2.. (unknown [9.47.158.152])
        by b03ledav002.gho.boulder.ibm.com (Postfix) with ESMTP;
        Mon,  9 Aug 2021 19:22:04 +0000 (GMT)
From:   Stefan Berger <stefanb@linux.vnet.ibm.com>
To:     jarkko@kernel.org
Cc:     nasastry@in.ibm.com, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v4 0/2] ibmvtpm: Avoid error message when process gets signal while waiting
Date:   Mon,  9 Aug 2021 15:21:57 -0400
Message-Id: <20210809192159.2176580-1-stefanb@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: TyQzl6YUCvsx2i6jjYNiJNW3ulnEqV9Z
X-Proofpoint-GUID: TyQzl6YUCvsx2i6jjYNiJNW3ulnEqV9Z
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-09_07:2021-08-06,2021-08-09 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 lowpriorityscore=0 mlxscore=0 clxscore=1015 priorityscore=1501 bulkscore=0
 mlxlogscore=859 spamscore=0 adultscore=0 phishscore=0 suspectscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108090135
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

v4:
 - Reverted order of patches

v3:
 - Split into two patches

Stefan Berger (2):
  tpm: ibmvtpm: Avoid error message when process gets signal while
    waiting
  tpm: ibmvtpm: Rename tpm_process_cmd to tpm_status and define flag

 drivers/char/tpm/tpm_ibmvtpm.c | 31 ++++++++++++++++++-------------
 drivers/char/tpm/tpm_ibmvtpm.h |  3 ++-
 2 files changed, 20 insertions(+), 14 deletions(-)

-- 
2.31.1

