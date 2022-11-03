Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25CD26187B3
	for <lists+linux-integrity@lfdr.de>; Thu,  3 Nov 2022 19:39:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230307AbiKCSj3 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 3 Nov 2022 14:39:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230262AbiKCSj2 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 3 Nov 2022 14:39:28 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EFFA2BC2
        for <linux-integrity@vger.kernel.org>; Thu,  3 Nov 2022 11:39:23 -0700 (PDT)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A3IKVDF012861;
        Thu, 3 Nov 2022 18:39:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=ttC/KPBaqlcpsBZfOzKLxzlePaVekaSPm0nkrPGYFwI=;
 b=K9RALzff6EOjYzvmjiQC2uheeWFwh/TtF5FHuII19UYlqqUyPsYFVm3UdRJwvAbkkeRY
 JMtBmFJ2FW0STT8FwndV9j0a1gk6IcGhO955j+TUTdV1+bmNCEibJBQ3Je6qozzOnsrv
 KFXRjtVKG7OvWK3o5tZUdPf13wRQ1G03PbsAzGk2iVbKNWD4TXHVSw+wNoEJiKHA5AZG
 9uPWqit1iYXwJVgaORF6wuPWsGndB2A9P27zy7s6JWtCoSCDhMOwQjx2Bw1HC0AjQBA0
 FCFc91Ddn/i8kFeptpXF3XVRrhdbXarI718R8tn7G6IinLqGMNluptJ7EBGU+xIU9GhT Rw== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kme16cth4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Nov 2022 18:39:18 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2A3IaSnA017520;
        Thu, 3 Nov 2022 18:39:15 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma06ams.nl.ibm.com with ESMTP id 3kguej187d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Nov 2022 18:39:15 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2A3IdBCC2032240
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 3 Nov 2022 18:39:12 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DD14142041;
        Thu,  3 Nov 2022 18:39:11 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AB8774203F;
        Thu,  3 Nov 2022 18:39:10 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com.com (unknown [9.160.20.100])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu,  3 Nov 2022 18:39:10 +0000 (GMT)
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.ibm.com>, Petr Vorel <pvorel@suse.cz>,
        Vitaly Chikunov <vt@altlinux.org>,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH ima-evm-utils v5 00/17] address deprecated warnings 
Date:   Thu,  3 Nov 2022 14:38:47 -0400
Message-Id: <20221103183904.103562-1-zohar@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ijO0pm_OZPJISdYcIrcYOYFMPGXxKwPP
X-Proofpoint-ORIG-GUID: ijO0pm_OZPJISdYcIrcYOYFMPGXxKwPP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-03_04,2022-11-03_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 mlxscore=0 phishscore=0 lowpriorityscore=0 mlxlogscore=999 bulkscore=0
 clxscore=1015 adultscore=0 priorityscore=1501 impostorscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211030125
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

Changelog v5:
- Addressed Stefan's comments: add missing error message, update error
message text, identifying SSL major version, and make sure other key
files are regular files.
- Add missing sm2/sm3 "skipped" message.

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
  Make sure the key file is a regular file

 .github/workflows/ci.yml  |  10 +-
 .travis.yml               |  10 +-
 acinclude.m4              |   2 +-
 build.sh                  |   8 ++
 configure.ac              |  16 ++-
 m4/manpage-docbook-xsl.m4 |   2 +-
 src/Makefile.am           |  18 +++
 src/evmctl.c              | 287 ++++++++++++++++++++++++++------------
 src/imaevm.h              |   6 +
 src/libimaevm.c           |  45 ++++--
 tests/install-openssl3.sh |   9 +-
 tests/sign_verify.test    |  30 ++--
 12 files changed, 321 insertions(+), 122 deletions(-)

-- 
2.31.1

