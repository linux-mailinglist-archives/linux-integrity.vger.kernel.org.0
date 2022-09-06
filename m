Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E8515AF4E3
	for <lists+linux-integrity@lfdr.de>; Tue,  6 Sep 2022 21:55:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230461AbiIFTyc (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 6 Sep 2022 15:54:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230273AbiIFTwc (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 6 Sep 2022 15:52:32 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35CEE3ECD5
        for <linux-integrity@vger.kernel.org>; Tue,  6 Sep 2022 12:50:43 -0700 (PDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 286In0gm001873;
        Tue, 6 Sep 2022 19:50:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=uWLeXhP1nQa9n08fNdCBj9KE2PnzA4suUwdxGdPNvUU=;
 b=oktGiJdrcY95w88wzyHsmVpVP/NZAAoVx8JR4LCDXzFsippN5dMGAX+cS3/YEpEnX04b
 HzXLHFSZWgUV4ZLuYt/E74NT1AcUe0N4qMHphNJT+gHxEoixGP1EmoPMQtd7Txx8h7v0
 mjgLJxWfxP9rgQUnhIdU8bFAimAZKL8q8XLDodFImDYe1Zvm31cadb1DmEpZz5058emC
 VGfj6d0mAf5oXfKIsw60QP1xrsHTkY7Qoa57/QljH+0KC6Lwv/BQs3e24UE0AsewUu1/
 8gqy45zr8gVosXJK3XcfTLWyGE3a0H/sOp1guE/llxcj/yoImh52lVKJSHMfBGUMp9Nm Ow== 
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3jebth9md2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 06 Sep 2022 19:50:36 +0000
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 286JoYIl001094;
        Tue, 6 Sep 2022 19:50:34 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma01fra.de.ibm.com with ESMTP id 3jbxj8u37p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 06 Sep 2022 19:50:33 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 286JoU1U37618144
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 6 Sep 2022 19:50:30 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A2F5711C04A;
        Tue,  6 Sep 2022 19:50:30 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2137111C04C;
        Tue,  6 Sep 2022 19:50:29 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com.com (unknown [9.211.107.58])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  6 Sep 2022 19:50:28 +0000 (GMT)
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.ibm.com>, Petr Vorel <pvorel@suse.cz>,
        Vitaly Chikunov <vt@altlinux.org>,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH ima-evm-utils v2 00/12] address deprecated warnings
Date:   Tue,  6 Sep 2022 15:50:09 -0400
Message-Id: <20220906195021.854090-1-zohar@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: h9DbcGivVGDZHjHxgaCpLid-x8sw3PBJ
X-Proofpoint-GUID: h9DbcGivVGDZHjHxgaCpLid-x8sw3PBJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-06_09,2022-09-06_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 priorityscore=1501 lowpriorityscore=0 suspectscore=0 spamscore=0
 mlxscore=0 phishscore=0 malwarescore=0 mlxlogscore=999 bulkscore=0
 impostorscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2207270000 definitions=main-2209060090
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

Mimi Zohar (12):
  travis: use the distro OpenSSL version on jammy
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

 .travis.yml               |   4 +-
 acinclude.m4              |   2 +-
 configure.ac              |  15 ++-
 m4/manpage-docbook-xsl.m4 |   2 +-
 src/Makefile.am           |  18 +++
 src/evmctl.c              | 237 +++++++++++++++++++++++++++++---------
 src/imaevm.h              |   2 +
 src/libimaevm.c           |  29 ++++-
 tests/functions.sh        |  14 ++-
 tests/ima_hash.test       |   9 ++
 tests/install-openssl3.sh |   2 +-
 tests/sign_verify.test    |  27 ++++-
 12 files changed, 288 insertions(+), 73 deletions(-)

-- 
2.31.1

