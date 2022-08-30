Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AC895A58AC
	for <lists+linux-integrity@lfdr.de>; Tue, 30 Aug 2022 03:00:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229524AbiH3BAI (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 29 Aug 2022 21:00:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbiH3BAH (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 29 Aug 2022 21:00:07 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62FF93FA3C
        for <linux-integrity@vger.kernel.org>; Mon, 29 Aug 2022 18:00:00 -0700 (PDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27U0etQN001199;
        Tue, 30 Aug 2022 00:59:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=LCU/Y4G+DwpOS8Eeq+DVCdPW43VrvBb2xlhnMsLP+gc=;
 b=aNtYMFsDwZJdljZYHidJ34zh3gu1b5pntFMo1M0fyTE/mPJ3wGHkgzJALN1cy8EJNQyb
 i976cyefkGmd6LdnN0fv5D02k7oyD/ynROWd/ICou9vRM0iP5jRwJtbCRPj4of0Uzae7
 1718Y5kVV0UWhRHsYcdNUdNxIB++AN6ArXTf9qolOSj9jVvjWCovYV/mysxvF1UhOQo8
 LchSE2I04+ac4Eg/F3+Wns2HvTslG8gRq9LcktMcRnG9B9BwBKfA7OYmMUKKoZSNuWob
 kFPEM685oGVJ1FX6/XXG91I8/aUTivjzQI7FPJkNyfv50jI8pp+T+fKKPTtNIl1jqx6y Tg== 
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3j97wvs3ny-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 Aug 2022 00:59:52 +0000
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 27U0r6Tf008864;
        Tue, 30 Aug 2022 00:59:49 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma02fra.de.ibm.com with ESMTP id 3j7aw8t5hn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 Aug 2022 00:59:49 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 27U0xki432965018
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Aug 2022 00:59:46 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 24A2AA404D;
        Tue, 30 Aug 2022 00:59:46 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 95A8AA4040;
        Tue, 30 Aug 2022 00:59:44 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com.com (unknown [9.211.117.120])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 30 Aug 2022 00:59:44 +0000 (GMT)
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.ibm.com>, Petr Vorel <pvorel@suse.cz>,
        Vitaly Chikunov <vt@altlinux.org>,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [RFC PATCH ima-evm-utils 00/11] address deprecated warnings
Date:   Mon, 29 Aug 2022 20:59:25 -0400
Message-Id: <20220830005936.189922-1-zohar@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 4cG05lEQORM7rharABe-mHe42YfQP4Jj
X-Proofpoint-GUID: 4cG05lEQORM7rharABe-mHe42YfQP4Jj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-29_13,2022-08-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 phishscore=0 mlxlogscore=999 clxscore=1011 mlxscore=0
 malwarescore=0 bulkscore=0 lowpriorityscore=0 impostorscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208290107
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

OpenSSL v3 deprecates "engine" support, causing a lot of warnings.  Since
turning off engine support affects PKCS11 and Streebog, define a
"--enable-engine" configuration option.

In addition address some static analysis warnings and other cleanup.

Mimi Zohar (11):
  travis: use the distro OpenSSL version on jammy
  travis: update dist=focal
  Update configure.ac to address a couple of obsolete warnings
  Deprecate IMA signature version 1
  Replace the low level SHA1 calls when calculating the TPM 1.2 PCRs
  Replace the low level HMAC calls when calculating the EVM HMAC
  Add missing EVP_MD_CTX_free() call in calc_evm_hash()
  Deprecate use of OpenSSL 3 "engine" support
  Fix potential use after free in read_tpm_banks()
  Limit the file hash algorithm name length
  Missing template data size lower bounds checking

 .travis.yml               |   4 +-
 acinclude.m4              |   2 +-
 configure.ac              |  25 ++++-
 m4/manpage-docbook-xsl.m4 |   2 +-
 src/Makefile.am           |  18 ++++
 src/evmctl.c              | 219 ++++++++++++++++++++++++++++----------
 src/imaevm.h              |   2 +
 src/libimaevm.c           |  29 ++++-
 tests/functions.sh        |  11 +-
 tests/ima_hash.test       |   9 ++
 tests/sign_verify.test    |  28 +++--
 11 files changed, 277 insertions(+), 72 deletions(-)

-- 
2.31.1

