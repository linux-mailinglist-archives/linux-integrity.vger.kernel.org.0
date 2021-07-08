Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 430EB3C16C8
	for <lists+linux-integrity@lfdr.de>; Thu,  8 Jul 2021 18:04:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230089AbhGHQGy (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 8 Jul 2021 12:06:54 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:19184 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229592AbhGHQGy (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 8 Jul 2021 12:06:54 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 168G3Kc4180421
        for <linux-integrity@vger.kernel.org>; Thu, 8 Jul 2021 12:04:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=q+u1QYndk8VNUqqTvbln2SXKKJ0Y/Y9aklSZMqgqQXs=;
 b=oivyEQ3UapsDR5iJS4HvmjeHfjYFmiLJlLSX+o5FUVJDAZoxrOoZ4GHU6y4QEWLVrMXy
 pquBaqQNdMrPqS5DBgsxDgYLA1G2R7cMA18SeIXURA4kJAptHNS9DjCYgBO8iZh6B4GO
 F3LH0u2V+W1CQgmwmKYXhQehkeR3YsbUZH31gHyuj3nfJfj+uazp5OxOw4UyPKG4/v+F
 0y9ZyiuQZSceO5U2uXP02FLXXS8u78Ppj0CC0rHksHDMTzakV0Nlb57KflJTqPnwwG89
 sLVVFNWqVVowtJjOin7xNEoGO/TEwsQP36z+L2XtLS/6/WdRFQMNddCDMvAT9QlrCoa+ Gg== 
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com [169.47.144.27])
        by mx0b-001b2d01.pphosted.com with ESMTP id 39nhkhx42g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Thu, 08 Jul 2021 12:04:11 -0400
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
        by ppma05wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 168Fx5j0027118
        for <linux-integrity@vger.kernel.org>; Thu, 8 Jul 2021 16:04:10 GMT
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com [9.57.198.25])
        by ppma05wdc.us.ibm.com with ESMTP id 39jfhd7c8e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Thu, 08 Jul 2021 16:04:10 +0000
Received: from b01ledav002.gho.pok.ibm.com (b01ledav002.gho.pok.ibm.com [9.57.199.107])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 168G4AEu38207918
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 8 Jul 2021 16:04:10 GMT
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 02DE1124060;
        Thu,  8 Jul 2021 16:04:10 +0000 (GMT)
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DF9FC124052;
        Thu,  8 Jul 2021 16:04:09 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.47.158.155])
        by b01ledav002.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu,  8 Jul 2021 16:04:09 +0000 (GMT)
From:   Stefan Berger <stefanb@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     zohar@linux.ibm.com, Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH ima-evm-utils v2 0/4] libimaevm: Remove digest calculations not supported by IMA
Date:   Thu,  8 Jul 2021 12:04:04 -0400
Message-Id: <20210708160408.2779849-1-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: iTNG1U1nq4Xnnts3limKWYSXul2-VTOa
X-Proofpoint-ORIG-GUID: iTNG1U1nq4Xnnts3limKWYSXul2-VTOa
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-08_10:2021-07-08,2021-07-08 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 priorityscore=1501 mlxlogscore=686 impostorscore=0 spamscore=0
 malwarescore=0 suspectscore=0 bulkscore=0 phishscore=0 mlxscore=0
 clxscore=1015 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2104190000 definitions=main-2107080086
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Remove digest calculations over directories, symbolic links, and device files
since those and related signature verifications are not supported by IMA in
the kernel.

Regards,
   Stefan

v2:
  - added patch 1/4 that removes filering on IMA unsupported file types
  - added Mimi's R-b tags to other patches


Stefan Berger (4):
  evmctl: Remove filtering support for file types unsupported by IMA
  libimaevm: Remove calculation of a digest over a device file
  libimaevm: Remove calculation of a digest over a directory
  libimaevm: Remove calculation of a digest over a symbolic link

 README          |  2 +-
 src/evmctl.c    | 13 +---------
 src/libimaevm.c | 68 -------------------------------------------------
 3 files changed, 2 insertions(+), 81 deletions(-)

-- 
2.31.1

