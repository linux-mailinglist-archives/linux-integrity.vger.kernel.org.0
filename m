Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D53C409F88
	for <lists+linux-integrity@lfdr.de>; Tue, 14 Sep 2021 00:18:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235035AbhIMWTk (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 13 Sep 2021 18:19:40 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:63360 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234858AbhIMWTj (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 13 Sep 2021 18:19:39 -0400
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.0.43) with SMTP id 18DKvE1E010490
        for <linux-integrity@vger.kernel.org>; Mon, 13 Sep 2021 18:18:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=+22RQXL1IrHLHzhsHQRIgRC1yc3CfDZdsNRcsWSz4v0=;
 b=CERkwcKGAylkG/P/11YhmoV/mJGALiU6+XN9k3KZXD8AeKEwG9wI8VldGx9k6uZUeFUn
 VQO3SoHVEnKmZlyEiOV7PEgNVpHOtxE5z8NHxCQpB3v6QuCMEmz4M++m3VTb6FEOjJzk
 JgbeZh9i/bbDJtbPK8oDdN8bs9zs10jJeq2tUH0syosF04YyQKt4X6w/5jxi4uXC/GPb
 oaeAmuW427axbD7586aflz2KjUKosqqta29fsivX+kjb6smJZ05GLIfHMY14YC4cV3EH
 e/IizhnSiUkC3pte3DK3IvB+10u4zjXyIIJZYLsBLDaedJBCPQen0mCC5PmeCND36Msv vA== 
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3b232su98w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Mon, 13 Sep 2021 18:18:23 -0400
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 18DMHgC6019690
        for <linux-integrity@vger.kernel.org>; Mon, 13 Sep 2021 22:18:22 GMT
Received: from b03cxnp07027.gho.boulder.ibm.com (b03cxnp07027.gho.boulder.ibm.com [9.17.130.14])
        by ppma01dal.us.ibm.com with ESMTP id 3b0m3c56xr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Mon, 13 Sep 2021 22:18:22 +0000
Received: from b03ledav005.gho.boulder.ibm.com (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
        by b03cxnp07027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 18DMIKiP19661234
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Sep 2021 22:18:20 GMT
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B3DB2BE068;
        Mon, 13 Sep 2021 22:18:20 +0000 (GMT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6F7B3BE05D;
        Mon, 13 Sep 2021 22:18:20 +0000 (GMT)
Received: from sbct-2.pok.ibm.com (unknown [9.47.158.152])
        by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTP;
        Mon, 13 Sep 2021 22:18:20 +0000 (GMT)
From:   Stefan Berger <stefanb@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     zohar@linux.ibm.com, Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v4 0/9] ima-evm-utils: Add support for signing with pkcs11 URIs
Date:   Mon, 13 Sep 2021 18:18:04 -0400
Message-Id: <20210913221813.2554880-1-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: v3Adfy0sNONh26mSfGyGTYyRQAmq2vAF
X-Proofpoint-ORIG-GUID: v3Adfy0sNONh26mSfGyGTYyRQAmq2vAF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-11_02,2021-09-09_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 priorityscore=1501 mlxscore=0 phishscore=0
 lowpriorityscore=0 spamscore=0 bulkscore=0 malwarescore=0 mlxlogscore=999
 clxscore=1015 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109030001 definitions=main-2109130045
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

This series of patches adds support for signing with pkcs11 URIs so that
pkcs11-enabled devices can also be used for file signing.

Extend the existing sign_verify.test with tests for the new pkcs11 URI support. 
Use SoftHSM, when available, as a pkcs11 device for testing.

  Stefan

v4:
  - Addressed Mimi's comments on v3

v3:
  - Used commit messages Mimi suggested
  - 7/9: Split off imported script into own patch
  - 8/9: Added missing EVMCTL_ENGINE variable that allowed to enable Debian
         and Ubuntu testing in 9/9; improvements on setup and teardown
         functions
  - 9/9: Installation of required packages on Debian and Ubuntu

Stefan Berger (9):
  evmctl: Implement support for EVMCTL_KEY_PASSWORD environment variable
  evmctl: Handle failure to initialize the openssl engine
  evmctl: Implement function for setting up an OpenSSL engine
  evmctl: Define and use an ENGINE field in libimaevm_params
  evmctl: use the pkcs11 engine for pkcs11: prefixed URIs
  libimaevm: Add support for pkcs11 private keys for signing a v2 hash
  tests: Import softhsm_setup script to enable pkcs11 test case
  tests: Extend sign_verify test with pkcs11-specific test
  tests: Get the packages for pkcs11 testing on the CI/CD system

 README                 |   5 +
 ci/alt.sh              |   3 +
 ci/debian.sh           |   3 +-
 ci/fedora.sh           |   8 ++
 ci/tumbleweed.sh       |   3 +
 src/evmctl.c           |  54 +++++---
 src/imaevm.h           |   2 +
 src/libimaevm.c        |  47 +++++--
 tests/functions.sh     |  45 ++++++-
 tests/ima_hash.test    |   2 +-
 tests/sign_verify.test |  52 ++++++--
 tests/softhsm_setup    | 293 +++++++++++++++++++++++++++++++++++++++++
 12 files changed, 473 insertions(+), 44 deletions(-)
 create mode 100755 tests/softhsm_setup

-- 
2.31.1

