Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47C0C3E5C16
	for <lists+linux-integrity@lfdr.de>; Tue, 10 Aug 2021 15:46:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241833AbhHJNqY (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 10 Aug 2021 09:46:24 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:8874 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241830AbhHJNqX (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 10 Aug 2021 09:46:23 -0400
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17ADZN6J034187
        for <linux-integrity@vger.kernel.org>; Tue, 10 Aug 2021 09:46:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=LQpCswoKrv2lHbvMbb3m8hnx5lKXxbg0Z5lNQadq41E=;
 b=c5NHk+XG262w4pcSW541iFdzYx8xqTyVGOuIZRmrb1XfXJB2on4yZpoywe9befFuuCcL
 sU4cACvw62QO7O4aNshGsMcni3tg/nV6P2nDe6iDOEvse+WSpskML1d6OG30TpXo3ZLJ
 6W/frWizHOwC8v/jN8XNLIYeof4+WPosblqZkfdJravnDutMHYOFRr2ExfTjQo1s9GHX
 0en7tRw//n+Vo4IzRRvFYnhrg1jc2SefilK05ZOumhygbvv3mnQASGg0sig0gBNkxwty
 nstd4+gohHM3CoFHIhaGrb0lEtODKZzp4FSOTbX2CeIi0er/ZLiFFh9wm43NH35hMdKV OA== 
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3ab9xa86rx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Tue, 10 Aug 2021 09:46:01 -0400
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 17ADfvCq018809
        for <linux-integrity@vger.kernel.org>; Tue, 10 Aug 2021 13:46:00 GMT
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com [9.57.198.29])
        by ppma04dal.us.ibm.com with ESMTP id 3a9htcuf81-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Tue, 10 Aug 2021 13:46:00 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 17ADjxcY30343622
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Aug 2021 13:45:59 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E1E2FB2082;
        Tue, 10 Aug 2021 13:45:58 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CDF46B2075;
        Tue, 10 Aug 2021 13:45:58 +0000 (GMT)
Received: from sbct-2.. (unknown [9.47.158.152])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue, 10 Aug 2021 13:45:58 +0000 (GMT)
From:   Stefan Berger <stefanb@linux.vnet.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     zohar@linux.ibm.com, Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v2 0/8] ima-evm-utils: Add support for signing with pkcs11 URIs
Date:   Tue, 10 Aug 2021 09:45:49 -0400
Message-Id: <20210810134557.2444863-1-stefanb@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: OkdN-9-8PRcNLyu96MkXlZ-Fh8NUh_RW
X-Proofpoint-GUID: OkdN-9-8PRcNLyu96MkXlZ-Fh8NUh_RW
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-10_05:2021-08-10,2021-08-10 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 lowpriorityscore=0 mlxscore=0 clxscore=1015 priorityscore=1501 bulkscore=0
 mlxlogscore=999 spamscore=0 adultscore=0 phishscore=0 suspectscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108100087
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Stefan Berger <stefanb@linux.ibm.com>

This series of patches adds support for signing with pkcs11 URIs and the
keyid explicitly provided via a command line option.
A test program is provided setting up softhsm for test cases to use. Tests
are passing on gitub actions with some distros not enabled (Debian, Ubuntu)
where I could not reproduce the github actions failure on the same type of
container locally (debian:stable).

   Stefan
   
v2:
  - Use global imaevm_params.eng field for the ENGINE
  - Fix bug on engine initialization in existing code

Stefan Berger (8):
  evmctl: Implement support for EVMCTL_KEY_PASSWORD environment variable
  evmctl: Handle engine initialization properly
  evmctl: Move code setting up engine to own funtion
  evmctl: Extend libimaevm_params with ENGINE field and use it
  evmctl: Setup the pkcs11 engine if key has pkcs11: prefix
  libimaevm: Add support for pkcs11 private keys for signing a v2 hash
  tests: Extend sign_verify test with pkcs11-specific test
  tests: Get the packages for pkcs11 testing on the CI/CD system

 README                 |   5 +
 ci/alt.sh              |   3 +
 ci/fedora.sh           |   8 ++
 ci/tumbleweed.sh       |   3 +
 src/evmctl.c           |  54 +++++---
 src/imaevm.h           |   2 +
 src/libimaevm.c        |  47 +++++--
 tests/functions.sh     |  26 ++++
 tests/sign_verify.test |  50 +++++--
 tests/softhsm_setup    | 290 +++++++++++++++++++++++++++++++++++++++++
 10 files changed, 448 insertions(+), 40 deletions(-)
 create mode 100755 tests/softhsm_setup

-- 
2.31.1

