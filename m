Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 797D6365F41
	for <lists+linux-integrity@lfdr.de>; Tue, 20 Apr 2021 20:30:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233604AbhDTSbD (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 20 Apr 2021 14:31:03 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:6594 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233541AbhDTSbA (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 20 Apr 2021 14:31:00 -0400
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13KI2tCl032959
        for <linux-integrity@vger.kernel.org>; Tue, 20 Apr 2021 14:30:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=/u3f/L3yI5zUDGReL6WmgPoW+QaaRxi44Hfub7ohcM8=;
 b=N0vvNU+Aa5dxN2eMMEMo7Mdf5/yU0pOX9ZxWnqQvEcDpjN/zABtUWCYKCfgF9N2FeSn7
 C5VxVlV+kIiAY9v3EBIM9NDO8Ka6b521ePpgAPQvJhW0EugkUyBtpBoBu5b4zzZakxRo
 xcdDKLgNRIfI6YlrrDNK4TMH+cf4QHhd441xsZjg30c3AkLdD7xEFZ85wbKq8S519NH1
 oE7qReND2J+eRrOgAIs+p8zQM4nvNHvonhH0d/VjbaO7fNZqgNDs4PvMUO5L5PjudH5T
 xEqLwwmhhLSLVHrPOme6/xmtV1R2iHRKz0Jz3MCjkjlqMxOMhWrDuhVVNYUBcN/X4YNj RA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3823dv9n2d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Tue, 20 Apr 2021 14:30:24 -0400
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 13KI3dwK035919
        for <linux-integrity@vger.kernel.org>; Tue, 20 Apr 2021 14:30:24 -0400
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com [169.47.144.27])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3823dv9n1r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 20 Apr 2021 14:30:24 -0400
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
        by ppma05wdc.us.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 13KIMnJf006484;
        Tue, 20 Apr 2021 18:30:22 GMT
Received: from b03cxnp07029.gho.boulder.ibm.com (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
        by ppma05wdc.us.ibm.com with ESMTP id 37yqa948cp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 20 Apr 2021 18:30:22 +0000
Received: from b03ledav001.gho.boulder.ibm.com (b03ledav001.gho.boulder.ibm.com [9.17.130.232])
        by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 13KIULhv18219298
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 20 Apr 2021 18:30:21 GMT
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A5A536E052;
        Tue, 20 Apr 2021 18:30:21 +0000 (GMT)
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5367F6E04C;
        Tue, 20 Apr 2021 18:30:21 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.47.158.155])
        by b03ledav001.gho.boulder.ibm.com (Postfix) with ESMTP;
        Tue, 20 Apr 2021 18:30:21 +0000 (GMT)
From:   Stefan Berger <stefanb@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     zohar@linux.ibm.com, dmitry.kasatkin@gmail.com,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH 0/3] ima-evm-utils: Implement function to only create IMA signature
Date:   Tue, 20 Apr 2021 14:30:12 -0400
Message-Id: <20210420183015.861644-1-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: TRmP_XLqh93Txbf6caiBgDMuGAGBzF3V
X-Proofpoint-GUID: U5ePkoRlwJd6MR2Wu_D0bUEy62e5aNND
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-20_08:2021-04-20,2021-04-20 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 clxscore=1015 bulkscore=0 phishscore=0 adultscore=0 malwarescore=0
 mlxlogscore=869 spamscore=0 priorityscore=1501 impostorscore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104200123
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

This series of patches implements imaevm_create_ima_signature, a function that
only creates an IMA v2 signature but does not write it into an xattr. This API
fullfills a requirement of rpm-ostree where a tool is being built to sign all
files from something similar to a tar byte stream, though where files are written
to temporary files for signing purpose but the signature itself should not be
written into the filesystem's xattr but simply returned via the API.

  Stefan

Stefan Berger (3):
  libimaevm: Implement imaevm_create_ima_signature
  tests: Add program to create IMA signature with new API call
  libimaevm: Have sign_hash_v2 call sign_hash_v2_pkey after reading key
    file

 src/imaevm.h                 |   2 +
 src/libimaevm.c              | 191 ++++++++++++++++++++++++++++++-----
 tests/Makefile.am            |   6 ++
 tests/create_ima_signature.c | 111 ++++++++++++++++++++
 tests/sign_verify.test       |  21 +++-
 5 files changed, 304 insertions(+), 27 deletions(-)
 create mode 100644 tests/create_ima_signature.c

-- 
2.30.2

