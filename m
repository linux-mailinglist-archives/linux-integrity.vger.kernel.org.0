Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76E75403FC8
	for <lists+linux-integrity@lfdr.de>; Wed,  8 Sep 2021 21:23:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350363AbhIHTY6 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 8 Sep 2021 15:24:58 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:57912 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240049AbhIHTYz (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 8 Sep 2021 15:24:55 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 188J2eQb025948
        for <linux-integrity@vger.kernel.org>; Wed, 8 Sep 2021 15:23:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=mZCzfBEFWvrrxbmY6kSgybfGFs5Du2nN0BMt9UGj8IY=;
 b=mzaoQJJhuE7CH+lNiRPM8jiZ0bmex4bgA/DHOhNC/FAkRSRR0qTSsPhe6KT5WPjSjR8m
 GkH/wdFt1PC2j48YHPhMWIBJMoPKPTgdB1HPxpIoDIHc9Psr0nKgI3OmPckn8jy9GZpW
 UIfQxZZnjDCo+zifmziNj9gNpkcBKefa2haefxU1gVEz/yrVIRlOTZHJuFUWKKqw0UB2
 vk5rMuIkHN1XIsjV1Shvwhb4h/1SCUEh2EO1qvQTwgGkb2tTYjJY3GAUkusTUBaxNB2m
 yyulFJ9iwn0YPUyj+LqmQuGYjzWrz5wxf8FB02ww44mTxWx4s9lpnAmk+6Symuc8/pRN Zg== 
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3axt80fna2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Wed, 08 Sep 2021 15:23:47 -0400
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 188JI7Mp022447
        for <linux-integrity@vger.kernel.org>; Wed, 8 Sep 2021 19:23:46 GMT
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com [9.57.198.26])
        by ppma01dal.us.ibm.com with ESMTP id 3axcnqj3pj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Wed, 08 Sep 2021 19:23:46 +0000
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com [9.57.199.109])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 188JNjrA11338252
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 8 Sep 2021 19:23:45 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2E05211206B;
        Wed,  8 Sep 2021 19:23:45 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 296F6112066;
        Wed,  8 Sep 2021 19:23:45 +0000 (GMT)
Received: from sbct-2.pok.ibm.com (unknown [9.47.158.152])
        by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed,  8 Sep 2021 19:23:45 +0000 (GMT)
From:   Stefan Berger <stefanb@linux.vnet.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     zohar@linux.ibm.com, Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v3 0/9] ima-evm-utils: Add support for signing with pkcs11 URIs
Date:   Wed,  8 Sep 2021 15:23:34 -0400
Message-Id: <20210908192343.4147739-1-stefanb@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: lgLVXQKy85mhv4hDHhf0j1rMRn3_yz58
X-Proofpoint-ORIG-GUID: lgLVXQKy85mhv4hDHhf0j1rMRn3_yz58
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-09-08_06:2021-09-07,2021-09-08 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 impostorscore=0 mlxlogscore=999 spamscore=0 mlxscore=0 lowpriorityscore=0
 malwarescore=0 clxscore=1015 suspectscore=0 priorityscore=1501 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109030001
 definitions=main-2109080120
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Stefan Berger <stefanb@linux.ibm.com>

This series of patches adds support for signing with pkcs11 URIs so that
pkcs11-enabled devices can also be used for file signing.

A test program is provided setting up SoftHSM for test cases to use. I added
two test cases for testing with SoftHSM.

  Stefan

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
 tests/functions.sh     |  45 +++++++
 tests/sign_verify.test |  52 ++++++--
 tests/softhsm_setup    | 297 +++++++++++++++++++++++++++++++++++++++++
 11 files changed, 478 insertions(+), 41 deletions(-)
 create mode 100755 tests/softhsm_setup

-- 
2.31.1

