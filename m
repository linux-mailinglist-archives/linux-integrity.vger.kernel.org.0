Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EAE05B7EF3
	for <lists+linux-integrity@lfdr.de>; Wed, 14 Sep 2022 04:30:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229564AbiINCaR (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 13 Sep 2022 22:30:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbiINCaQ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 13 Sep 2022 22:30:16 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0873C422DB
        for <linux-integrity@vger.kernel.org>; Tue, 13 Sep 2022 19:30:10 -0700 (PDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28E2N9xu027456;
        Wed, 14 Sep 2022 02:30:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=WhIESxgKkG755sYznuDycFeDUYbfVliB6wTwOSOd8wU=;
 b=WjxWGr7ia0e4J4U5qhVN+MBOoXtiTFyJ6FNr8NYv1FmChbGXjhhjlE121CYWQfpCN3Z4
 ajHKe+jRNton7DiXQog1XnLJkMMyALkhT/0R8PRK4dSQHhHrLzc+3vo3dQp9h+BuMF0+
 c0jLUA7tBGHdCzB630elkvjaETOktx1Zf5a5Uudw45AmGOWankTmHptjukSLXsQ9Cv2k
 DUS1vfmu0TkyVTBKRZf6im0kobZ+m8QlVhqpHZXmGhJOScoN8txjLRTpM9dh7M8oybd0
 psi88ygjopc0ZPJAu7aqnSNLqoVMJ352EMdPV/myuQtpsC20r7sBBtSlFSSzIghTktHV bg== 
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3jk64jr46j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Sep 2022 02:30:06 +0000
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 28E2L43t006420;
        Wed, 14 Sep 2022 02:30:04 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma06fra.de.ibm.com with ESMTP id 3jjymmr82a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Sep 2022 02:30:04 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 28E2U1sM34144558
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Sep 2022 02:30:01 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EDAF8A4051;
        Wed, 14 Sep 2022 02:30:00 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 35B15A4040;
        Wed, 14 Sep 2022 02:30:00 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com.com (unknown [9.160.29.234])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 14 Sep 2022 02:30:00 +0000 (GMT)
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.ibm.com>, Petr Vorel <pvorel@suse.cz>,
        Vitaly Chikunov <vt@altlinux.org>,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH ima-evm-utils v3 00/15] address deprecated warnings 
Date:   Tue, 13 Sep 2022 22:29:41 -0400
Message-Id: <20220914022956.1359218-1-zohar@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: KEKC0frFvLkR4zDNejmtKs146vyn-3dI
X-Proofpoint-ORIG-GUID: KEKC0frFvLkR4zDNejmtKs146vyn-3dI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-13_12,2022-09-13_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 impostorscore=0
 mlxscore=0 mlxlogscore=999 bulkscore=0 suspectscore=0 spamscore=0
 priorityscore=1501 clxscore=1015 lowpriorityscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2208220000 definitions=main-2209140008
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Between travis/ci and OpenSSL v3 a large number of deprecated warnings
are being emitted when compiling ima-evm-utils.  Start addressing these
deprecated warnings by replacing the low level SHA1 and HMAC calls with
the EVP_ functions.  IMA signature version 1 also uses low level calls,
but instead of fixing it, deprecate it as nobody should be using it
anyway.

OpenSSL v3 "engine" support is deprecated and replaced with "providers".
Engine support will continue to work for a while, but results in
deprecated declaration and other messages.  Define a "--disable-engine"
and the equivalent "--enable-engine=no" configuration option.

Changelog v3:
- Make the SM2/SM3 tests dependent on the OpenSSL v3, rather than
compiling OpenSSL v3.
- Re-use the existing infrastructure for compiling OpenSSL to compile
OpenSSL without engine support.  ima-evm-utils compiles cleanly without
any deprecated messages.
- Instead of using the distro OpenSSL version on jammy, compile OpenSSL
to test building ima-evm-utils without OpenSSL engine support.
- Make sure the keyfile is a regular file before using it.
- Based on Vitaly's suggestion: undefine CONFIG_ENGINE when OpenSSL
engine support is not configured, run the tests normally without
checking whether engine support is configured.
- Add Stefan's Reviewed-by tags.


Changelog v2:
- Based on Vitaly's comments, base enabling engine support on
OPENSSL_NO_ENGINE/OPENSSL_NO_DYNAMIC_ENGINE support.  Also don't limit
disabling ima-evm-utils engine support to v3, make it generic.
- Added Stefan's Reviewed-by tags.

Changelog v1:
- Based on Stefan's comments, removed deprecated functions when not
used and added missing word. Updated the usage and options accordingly.
- Based on Vitaly's comments, explicitly require "--disable-engine"
configuration to compile ima-evm-utils without OpenSSL v3 engine support
and typo.
- Based on Petr's comments, addressed the "return 77" by removing it,
  updated the travis patch description, and added his Reviewed-by tags.

Mimi Zohar (15):
  travis: update dist=focal
  Update configure.ac to address a couple of obsolete warnings
  Deprecate IMA signature version 1
  Replace the low level SHA1 calls when calculating the TPM 1.2 PCRs
  Replace the low level HMAC calls when calculating the EVM HMAC
  Add missing EVP_MD_CTX_free() call in calc_evm_hash()
  Disable use of OpenSSL "engine" support
  Fix potential use after free in read_tpm_banks()
  Limit the file hash algorithm name length
  Missing template data size lower bounds checking
  Limit configuring OpenSSL engine support
  Base sm2/sm3 test on openssl version installed
  Compile a newer version of OpenSSL
  Build OpenSSL without engine support
  Fix d2i_x509_fp failure

 .github/workflows/ci.yml  |  10 +-
 .travis.yml               |  10 +-
 acinclude.m4              |   2 +-
 build.sh                  |   8 ++
 configure.ac              |  15 ++-
 m4/manpage-docbook-xsl.m4 |   2 +-
 src/Makefile.am           |  18 +++
 src/evmctl.c              | 228 +++++++++++++++++++++++++++++---------
 src/imaevm.h              |   6 +
 src/libimaevm.c           |  40 ++++++-
 tests/functions.sh        |   2 +-
 tests/ima_hash.test       |   1 +
 tests/install-openssl3.sh |   9 +-
 tests/sign_verify.test    |  23 ++--
 14 files changed, 289 insertions(+), 85 deletions(-)

-- 
2.31.1

