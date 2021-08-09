Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F3B13E485F
	for <lists+linux-integrity@lfdr.de>; Mon,  9 Aug 2021 17:10:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235200AbhHIPK6 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 9 Aug 2021 11:10:58 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:12302 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S235284AbhHIPK6 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 9 Aug 2021 11:10:58 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 179F5AIG091941
        for <linux-integrity@vger.kernel.org>; Mon, 9 Aug 2021 11:10:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=zFEMoJLZGZADlTQ0QJP0/CUk+e6Ws1o5OA7estzf9Y8=;
 b=k2ffV758/txHjzT2IN6P/ZF85INN+YMR83Qj7dZew1EGdALm9M6iGGysn0jYIbjrmMt0
 DKfFKBrSGHENmCB2txzRTy1/L31aoBI6Xhhn/4bip8/JDfl0N155miKzOhydiDrRdxN+
 PZrL8/ywm62YaE1DRJOuuhdlaPSrd8hlVNh+kW/Xdh78gT0tM+i8Y29WDeM53EBNtTj6
 1Drm2jww3omgaKuTk0Wa/sC03VgqmFnN7Qmqu66z6SNnfiSl4f+XdcWAsVEBZA4NG9oo
 +L/Rzv+4Bcwd7OFIPFFn6CnzlBxrNNwUBStvxnb5E6TmpaVFdxVJDRudsMRjvoCSWcCg 3w== 
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com [169.47.144.27])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3aa78bh3ah-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Mon, 09 Aug 2021 11:10:34 -0400
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
        by ppma05wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 179F2Zwn005069
        for <linux-integrity@vger.kernel.org>; Mon, 9 Aug 2021 15:10:31 GMT
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com [9.57.198.26])
        by ppma05wdc.us.ibm.com with ESMTP id 3a9htakytt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Mon, 09 Aug 2021 15:10:31 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 179FAT0o6750658
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 9 Aug 2021 15:10:29 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4C07A7E2E8;
        Mon,  9 Aug 2021 15:10:29 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 30CE97E2EE;
        Mon,  9 Aug 2021 15:10:27 +0000 (GMT)
Received: from sbct-2.. (unknown [9.47.158.152])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon,  9 Aug 2021 15:10:27 +0000 (GMT)
From:   Stefan Berger <stefanb@linux.vnet.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     zohar@linux.ibm.com, Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH 0/4] ima-evm-utils: Add support for signing with pkcs11 URIs
Date:   Mon,  9 Aug 2021 11:10:22 -0400
Message-Id: <20210809151026.195038-1-stefanb@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: JRgZZDVJpXtfHo8sfx7f4zjavHx2GMU3
X-Proofpoint-GUID: JRgZZDVJpXtfHo8sfx7f4zjavHx2GMU3
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-09_05:2021-08-06,2021-08-09 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 adultscore=0
 priorityscore=1501 suspectscore=0 clxscore=1015 spamscore=0 phishscore=0
 malwarescore=0 lowpriorityscore=0 mlxscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108090111
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Stefan Berger <stefanb@linux.ibm.com>

This series of patches adds support for signing with pkcs11 URIs and the
keyid explicityly provided via a command line option.
A test program is provided setting up softhsm for test cases to use.

   Stefan

Stefan Berger (4):
  evmctl: Implement support for EVMCTL_KEY_PASSWORD environment variable
  libimaevm: Add support for pkcs11 private keys for signing a v2 hash
  tests: Extend sign_verify test with pkcs11 specific test
  tests: Get the packages for pkcs11 testing on the CI/CD system

 README                 |   5 +
 ci/alt.sh              |   3 +
 ci/fedora.sh           |   8 ++
 ci/tumbleweed.sh       |   3 +
 src/evmctl.c           |   7 +
 src/libimaevm.c        |  59 +++++++--
 tests/functions.sh     |  26 ++++
 tests/sign_verify.test |  50 +++++--
 tests/softhsm_setup    | 290 +++++++++++++++++++++++++++++++++++++++++
 9 files changed, 426 insertions(+), 25 deletions(-)
 create mode 100755 tests/softhsm_setup

-- 
2.31.1

