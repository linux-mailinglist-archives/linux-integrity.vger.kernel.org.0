Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7224E615306
	for <lists+linux-integrity@lfdr.de>; Tue,  1 Nov 2022 21:18:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230189AbiKAUSb (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 1 Nov 2022 16:18:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230188AbiKAUS2 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 1 Nov 2022 16:18:28 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 872932648
        for <linux-integrity@vger.kernel.org>; Tue,  1 Nov 2022 13:18:22 -0700 (PDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A1Ishuu027865;
        Tue, 1 Nov 2022 20:18:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=6A+eT4IL3qJRoRmsyPvYEvxV935vjyK6+vlcXH3DPUM=;
 b=f/FcQYpAfBUlbGt1rUepPGadZ3kKAAiSa18YBAMuyyS0oisSPPIG64Ejy8JFnv28uMXt
 OUOhftDXD0+0g+3C0aU23q1Kz9l5Q0v7a5rsKwDw8A3/oVuLg2wBbNbkwRAvak8pTMt7
 SU1vTMwEWjOFQfC8B5uYIZ5BIiYbpCSTyAx31bRCiNOHr5YKTb/5Edb0qMZ1s5ndfVVS
 jY8cD0ZlT+wzLgypWUZ4p+icPyjkE8x9kwsHn7ar+o9MlgChOX827Ar5VmFCxLuT9lk+
 7Z4qLA14/xUbZhthUw5QtMRsKp61iDfdonwoYuzfknWsMrQYGKqFXjGEX6N/s+G6HISO cA== 
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kjtw3g4bx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Nov 2022 20:18:13 +0000
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2A1K5G2p025185;
        Tue, 1 Nov 2022 20:18:11 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma01fra.de.ibm.com with ESMTP id 3kgut9bwbe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Nov 2022 20:18:11 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2A1KI8wP47055294
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 1 Nov 2022 20:18:08 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E9BD7A4054;
        Tue,  1 Nov 2022 20:18:07 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 26874A405C;
        Tue,  1 Nov 2022 20:18:07 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com.com (unknown [9.160.14.52])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  1 Nov 2022 20:18:07 +0000 (GMT)
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.ibm.com>, Petr Vorel <pvorel@suse.cz>,
        Vitaly Chikunov <vt@altlinux.org>,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH ima-evm-utils v4 00/17] address deprecated warnings 
Date:   Tue,  1 Nov 2022 16:17:46 -0400
Message-Id: <20221101201803.372652-1-zohar@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: C_CPOxLIcNto3G1gAKjWfFY0UdOtwk2G
X-Proofpoint-GUID: C_CPOxLIcNto3G1gAKjWfFY0UdOtwk2G
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-01_10,2022-11-01_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 adultscore=0 suspectscore=0 phishscore=0 priorityscore=1501
 mlxlogscore=999 clxscore=1011 bulkscore=0 spamscore=0 impostorscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211010143
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
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

Changelog v4:
Based on Vitaly's comments:
- instead of setting errno to zero, define a macro to log a message
with the errno and reset errno.
- verify ENGINE_init symbol is defined in libcrypto.
- disable engine support if either OPENSSL_NO_DYNAMIC_ENGINE or
OPENSSL_NO_ENGINE variables are defined.
- Rename CONFIG_ENGINE to CONFIG_IMA_EVM_ENGINE

Changelog v3:
- Make the SM2/SM3 tests dependent on the OpenSSL v3, rather than
compiling OpenSSL v3, based on Vitaly's suggestion.
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

Mimi Zohar (17):
  Revert "Reset 'errno' after failure to open or access a file"
  log and reset 'errno' after failure to open non-critical files
  Log and reset 'errno' on lsetxattr failure
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
  Base sm2/sm3 test on openssl version installed
  Compile a newer version of OpenSSL
  Build OpenSSL without engine support
  Fix d2i_x509_fp failure

 .github/workflows/ci.yml  |  10 +-
 .travis.yml               |  10 +-
 acinclude.m4              |   2 +-
 build.sh                  |   8 ++
 configure.ac              |  16 ++-
 m4/manpage-docbook-xsl.m4 |   2 +-
 src/Makefile.am           |  18 +++
 src/evmctl.c              | 282 ++++++++++++++++++++++++++------------
 src/imaevm.h              |   6 +
 src/libimaevm.c           |  44 ++++--
 tests/install-openssl3.sh |   9 +-
 tests/sign_verify.test    |  25 ++--
 12 files changed, 311 insertions(+), 121 deletions(-)

-- 
2.31.1

