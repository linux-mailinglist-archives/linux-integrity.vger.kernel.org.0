Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C7BE36CBAE
	for <lists+linux-integrity@lfdr.de>; Tue, 27 Apr 2021 21:31:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238468AbhD0TcW (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 27 Apr 2021 15:32:22 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:5588 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236934AbhD0TcW (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 27 Apr 2021 15:32:22 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13RJJAsT054265
        for <linux-integrity@vger.kernel.org>; Tue, 27 Apr 2021 15:31:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=ML8ijF5DZKlSWwRtjaLmgRL2c7aLHCK6d2OXr4I+CGg=;
 b=kkchoccF4022D8bbjJjeLVgm2t0zK1Pu4tuEHezobFLRusSqP4eEYzVDKWpaYJoZGi5w
 ybERhNNMW8YIN9k9QgHdb5aRnucwPpe/1zHwqRYMhXmZzoj1PikzMFBwNrZOJ2xKZQSg
 KS9Q0uNfRWx1mEfE0CpaYwEvDVKxjGenkm4tW4CZEzeoGLPfWhT1iwbb8JrSZJ1pmXi2
 RncM3876RJ+UWFg6zKPcwmCxkKB1jLbonoPCd4/MxOWO9LZSLKhF0hqorTPsEFprs6eh
 cr6oI4owNekhwuhz/MXdzA7IJzRtd54jXGFFxY8T4uVfx5tc++BnWw58aSDF/0Qf4ayr 5w== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 386qtesrbs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Tue, 27 Apr 2021 15:31:38 -0400
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 13RJKdAL062510
        for <linux-integrity@vger.kernel.org>; Tue, 27 Apr 2021 15:31:38 -0400
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com [169.55.85.253])
        by mx0a-001b2d01.pphosted.com with ESMTP id 386qtesrbe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 27 Apr 2021 15:31:38 -0400
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
        by ppma01wdc.us.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 13RJRawl019810;
        Tue, 27 Apr 2021 19:31:37 GMT
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com [9.57.198.27])
        by ppma01wdc.us.ibm.com with ESMTP id 384ay9fp8c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 27 Apr 2021 19:31:37 +0000
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com [9.57.199.110])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 13RJVZqs39256536
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 27 Apr 2021 19:31:36 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E3C10AE05F;
        Tue, 27 Apr 2021 19:31:35 +0000 (GMT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CD791AE060;
        Tue, 27 Apr 2021 19:31:35 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.47.158.155])
        by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue, 27 Apr 2021 19:31:35 +0000 (GMT)
From:   Stefan Berger <stefanb@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     zohar@linux.ibm.com, dmitry.kasatkin@gmail.com,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v2 0/3] ima-evm-utils: Implement function to only create IMA signature
Date:   Tue, 27 Apr 2021 15:31:30 -0400
Message-Id: <20210427193133.1718367-1-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: gXWR47etAikJnyIDKe9H9tpymmy82sve
X-Proofpoint-ORIG-GUID: wW6a7jb8vhdRrpPwkbqsRqoVFybl-YJI
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-27_10:2021-04-27,2021-04-27 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 mlxlogscore=937 mlxscore=0 spamscore=0 phishscore=0
 adultscore=0 clxscore=1015 bulkscore=0 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104270126
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

v2:
 - use imaevm_calc_hash to also cover hash calculations of links,
   directories etc.
  
Stefan Berger (3):
  libimaevm: Implement imaevm_create_ima_signature
  tests: Add program to create IMA signature with new API call
  libimaevm: Have sign_hash_v2 call sign_hash_v2_pkey after reading key
    file

 src/imaevm.h                 |   2 +
 src/libimaevm.c              | 148 ++++++++++++++++++++++++++++-------
 tests/Makefile.am            |   6 ++
 tests/create_ima_signature.c | 111 ++++++++++++++++++++++++++
 tests/sign_verify.test       |  21 ++++-
 5 files changed, 257 insertions(+), 31 deletions(-)
 create mode 100644 tests/create_ima_signature.c

-- 
2.30.2

