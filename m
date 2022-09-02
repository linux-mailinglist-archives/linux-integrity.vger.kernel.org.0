Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A2715AB689
	for <lists+linux-integrity@lfdr.de>; Fri,  2 Sep 2022 18:29:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236393AbiIBQ3K (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 2 Sep 2022 12:29:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236111AbiIBQ3I (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 2 Sep 2022 12:29:08 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB69CD9E8B
        for <linux-integrity@vger.kernel.org>; Fri,  2 Sep 2022 09:28:57 -0700 (PDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 282GGDl9005308;
        Fri, 2 Sep 2022 16:28:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=Zt3sWI0QpSHd2a3AJyT/LrG2hO4XVV2uqw30w0Hd1K8=;
 b=GoFhisUlyRsjMqt1ik0+eBIjkuPrut/Bt9zExUlx4R67y+qHTsyghjNTFaACLSiHsip8
 cShQP/GOUHwPPWRrv8HXWHNd4HzneueT9RR9ZHKsPnteZ0CGq8VX78aXUTBNFbjgQJV4
 IQEJIFLgibk576HuwbxLTlO02RyNmqddP++ioeAyFmc65OjpnY3gy7PfpjHJh6LzK/lm
 bjBgLAZkyp0lCXpb3mSDvPF1cA0ENFekcAK1GizanGW6MbZ29ftw8x1M8/K63PjK3sNr
 WZNRSKLX1UyU05Q2XyTCjKz4yyA+oHqrJ3goiZNe6eWEizebhKte9btz89KmpEv+o3YH nA== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3jbn730ak4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 02 Sep 2022 16:28:51 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 282G7vEW022477;
        Fri, 2 Sep 2022 16:28:49 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma04ams.nl.ibm.com with ESMTP id 3j7aw90d74-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 02 Sep 2022 16:28:49 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 282GSkwR39321954
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 2 Sep 2022 16:28:46 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2707652050;
        Fri,  2 Sep 2022 16:28:46 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com.com (unknown [9.211.132.193])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 9D3645204F;
        Fri,  2 Sep 2022 16:28:44 +0000 (GMT)
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.ibm.com>, Petr Vorel <pvorel@suse.cz>,
        Vitaly Chikunov <vt@altlinux.org>,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH ima-evm-utils 00/11] address deprecated warnings
Date:   Fri,  2 Sep 2022 12:28:25 -0400
Message-Id: <20220902162836.554839-1-zohar@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: qTIfOV11YGhNKLYTQbinrK45A_ZeKima
X-Proofpoint-ORIG-GUID: qTIfOV11YGhNKLYTQbinrK45A_ZeKima
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-09-02_04,2022-08-31_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 phishscore=0
 mlxscore=0 suspectscore=0 impostorscore=0 malwarescore=0
 lowpriorityscore=0 bulkscore=0 clxscore=1015 mlxlogscore=999
 priorityscore=1501 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2207270000 definitions=main-2209020078
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

Changelog:
- Based on Stefan's comments, removed deprecated functions when not
used and added missing word. Updated the usage and options accordingly.
- Based on Vitaly's comments, explicitly require "--disable-engine"
configuration to compile ima-evm-utils without OpenSSL v3 engine support
and typo.
- Based on Petr's comments, addressed the "return 77" by removing it,
  updated the travis patch description, and added his Reviewed-by tags.

Mimi Zohar (11):
  travis: use the distro OpenSSL version on jammy
  travis: update dist=focal
  Update configure.ac to address a couple of obsolete warnings
  Deprecate IMA signature version 1
  Replace the low level SHA1 calls when calculating the TPM 1.2 PCRs
  Replace the low level HMAC calls when calculating the EVM HMAC
  Add missing EVP_MD_CTX_free() call in calc_evm_hash()
  Deprecate use of OpenSSL v3 "engine" support
  Fix potential use after free in read_tpm_banks()
  Limit the file hash algorithm name length
  Missing template data size lower bounds checking

 .travis.yml               |   4 +-
 acinclude.m4              |   2 +-
 configure.ac              |  23 +++-
 m4/manpage-docbook-xsl.m4 |   2 +-
 src/Makefile.am           |  18 +++
 src/evmctl.c              | 223 +++++++++++++++++++++++++++++---------
 src/imaevm.h              |   2 +
 src/libimaevm.c           |  27 ++++-
 tests/functions.sh        |  14 ++-
 tests/ima_hash.test       |   9 ++
 tests/sign_verify.test    |  28 ++++-
 11 files changed, 280 insertions(+), 72 deletions(-)

-- 
2.31.1

