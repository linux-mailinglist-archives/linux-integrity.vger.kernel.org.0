Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B36E93DF67E
	for <lists+linux-integrity@lfdr.de>; Tue,  3 Aug 2021 22:40:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229876AbhHCUkn (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 3 Aug 2021 16:40:43 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:62544 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229551AbhHCUkn (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 3 Aug 2021 16:40:43 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 173KX53x042414
        for <linux-integrity@vger.kernel.org>; Tue, 3 Aug 2021 16:40:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=2iCRaPts+4QcZTu0zyvS1XehVK0Zxp0Z+hBBfgLl6T0=;
 b=jHlag/E8D+PLbi+n1P8u8nBZvXd81C2uI6iNT4QwZm/Vs/KpgUKvk7I7b50XIZILSPhI
 bU89t9d98pFdRSU0L4GVskejr3C4sz+vNq4cWmmhnh1dpZHe3KzymtdXimR5QKVic0sq
 STaUruVUrltnbjtAmrWwPSD22bglgq0vpcK8s8me6MVjVL2t3hzGnVZRZOys9I+1FG1l
 LV3x3RPl0wtYxyBS48kliZkHk0YnoSegQq1gKprJxP91ASqALdouGjUrOvplKywHbw3R
 RcLXs73bjNs1gxg4hSHdKm4JW/5HZ5JBnZZhHYf/QrJM32mszdkjpPMkn6/YC6LJWhiU SA== 
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3a6ffkgwhb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Tue, 03 Aug 2021 16:40:31 -0400
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 173KcinI015068
        for <linux-integrity@vger.kernel.org>; Tue, 3 Aug 2021 20:40:30 GMT
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com [9.57.198.24])
        by ppma04dal.us.ibm.com with ESMTP id 3a4x5dcgjt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Tue, 03 Aug 2021 20:40:30 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 173KeTi115204752
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 3 Aug 2021 20:40:29 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 73119B206C;
        Tue,  3 Aug 2021 20:40:29 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8E51AB2064;
        Tue,  3 Aug 2021 20:40:28 +0000 (GMT)
Received: from eve.home (unknown [9.211.130.149])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue,  3 Aug 2021 20:40:28 +0000 (GMT)
From:   Ken Goldman <kgoldman@us.ibm.com>
To:     zohar@linux.ibm.com, maroon@lists.linux.ibm.com,
        linux-integrity@vger.kernel.org
Cc:     kgold@linux.ibm.com, Ken Goldman <kgoldman@us.ibm.com>
Subject: [PATCH v5 ima-evm-utils 0/3] Add alternative calls to IBM TSS library
Date:   Tue,  3 Aug 2021 16:40:05 -0400
Message-Id: <20210803204008.29612-1-kgoldman@us.ibm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: sWJ1nsFa3hC_ZdQ5GeHvxQI8U3rByXDs
X-Proofpoint-GUID: sWJ1nsFa3hC_ZdQ5GeHvxQI8U3rByXDs
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-03_05:2021-08-03,2021-08-03 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 mlxscore=0
 malwarescore=0 clxscore=1011 mlxlogscore=843 phishscore=0 adultscore=0
 impostorscore=0 bulkscore=0 lowpriorityscore=0 priorityscore=1501
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108030128
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

This patch set adds calls to C code.  This should be more stable and
easier to maintain.  INSTALL instructions are updated.

While the code is being touched, it changes the PCR handle from
a signed int to a uint32_t, removing the need for error checking.

Ken Goldman (3):
  Expand the INSTALL instructions.
  Change PCR iterator from int to uint32_t
  Create alternative tpm2_pcr_read() that uses IBM TSS

 INSTALL              |  27 +++++-
 configure.ac         |   8 ++
 src/Makefile.am      |  15 +++-
 src/evmctl.c         |  12 ++-
 src/pcr.h            |   2 +-
 src/pcr_ibmtss.c     | 192 +++++++++++++++++++++++++++++++++++++++++++
 src/pcr_tss.c        |   5 +-
 src/pcr_tsspcrread.c |   6 +-
 8 files changed, 253 insertions(+), 14 deletions(-)
 create mode 100644 src/pcr_ibmtss.c

-- 
2.25.1

