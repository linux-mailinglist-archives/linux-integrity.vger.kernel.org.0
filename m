Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B1ECCB053A
	for <lists+linux-integrity@lfdr.de>; Wed, 11 Sep 2019 23:29:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728336AbfIKV3d (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 11 Sep 2019 17:29:33 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:42804 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728319AbfIKV3d (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 11 Sep 2019 17:29:33 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x8BLHhIP132004
        for <linux-integrity@vger.kernel.org>; Wed, 11 Sep 2019 17:29:32 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2uy7gqjc6x-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Wed, 11 Sep 2019 17:29:32 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Wed, 11 Sep 2019 22:29:30 +0100
Received: from b06avi18626390.portsmouth.uk.ibm.com (9.149.26.192)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 11 Sep 2019 22:29:27 +0100
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x8BLT1Ee38535424
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 Sep 2019 21:29:01 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9819A11C04A;
        Wed, 11 Sep 2019 21:29:26 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0F45711C050;
        Wed, 11 Sep 2019 21:29:26 +0000 (GMT)
Received: from dhcp-9-31-103-196.watson.ibm.com (unknown [9.31.103.196])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 11 Sep 2019 21:29:25 +0000 (GMT)
Subject: [GIT PULL] integrity subsystem updates for v5.4
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-security-module <linux-security-module@vger.kernel.org>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Date:   Wed, 11 Sep 2019 17:29:25 -0400
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19091121-0008-0000-0000-00000314850B
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19091121-0009-0000-0000-00004A32F24B
Message-Id: <1568237365.5783.39.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-09-11_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=13 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1909110188
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Linus,

The major feature in this pull request is IMA support for measuring
and appraising appended file signatures.  In addition are a couple of
bug fixes and code cleanup to use struct_size().

In addition to the PE/COFF and IMA xattr signatures, the kexec kernel
image may be signed with an appended signature, using the same
scripts/sign-file tool that is used to sign kernel modules.
 Similarly, the initramfs may contain an appended signature.

(Stephen is carrying a patch to address a merge conflict with the
security tree.)

thanks,

Mimi

The following changes since commit 609488bc979f99f805f34e9a32c1e3b71179d10b:

  Linux 5.3-rc2 (2019-07-28 12:47:02 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git next-integrity

for you to fetch changes up to 2a7f0e53daf29ca6dc9fbe2a27158f13474ec1b5:

  ima: ima_api: Use struct_size() in kzalloc() (2019-08-29 14:23:30 -0400)

----------------------------------------------------------------
Gustavo A. R. Silva (2):
      ima: use struct_size() in kzalloc()
      ima: ima_api: Use struct_size() in kzalloc()

Mimi Zohar (2):
      ima: initialize the "template" field with the default template
      sefltest/ima: support appended signatures (modsig)

Sascha Hauer (2):
      ima: always return negative code for error
      ima: fix freeing ongoing ahash_request

Stephen Rothwell (1):
      MODSIGN: make new include file self contained

Thiago Jung Bauermann (11):
      MODSIGN: Export module signature definitions
      PKCS#7: Refactor verify_pkcs7_signature()
      PKCS#7: Introduce pkcs7_get_digest()
      integrity: Select CONFIG_KEYS instead of depending on it
      ima: Add modsig appraise_type option for module-style appended signatures
      ima: Factor xattr_verify() out of ima_appraise_measurement()
      ima: Implement support for module-style appended signatures
      ima: Collect modsig
      ima: Define ima-modsig template
      ima: Store the measurement again when appraising a modsig
      ima: Fix use after free in ima_read_modsig()

 Documentation/ABI/testing/ima_policy               |   6 +-
 Documentation/security/IMA-templates.rst           |   3 +
 arch/s390/Kconfig                                  |   2 +-
 arch/s390/kernel/machine_kexec_file.c              |  24 +--
 certs/system_keyring.c                             |  61 +++++--
 crypto/asymmetric_keys/pkcs7_verify.c              |  33 ++++
 include/crypto/pkcs7.h                             |   4 +
 include/linux/module.h                             |   3 -
 include/linux/module_signature.h                   |  46 +++++
 include/linux/verification.h                       |  10 ++
 init/Kconfig                                       |   6 +-
 kernel/Makefile                                    |   1 +
 kernel/module.c                                    |   1 +
 kernel/module_signature.c                          |  46 +++++
 kernel/module_signing.c                            |  56 +-----
 scripts/Makefile                                   |   2 +-
 security/integrity/Kconfig                         |   2 +-
 security/integrity/digsig.c                        |  43 ++++-
 security/integrity/ima/Kconfig                     |  13 ++
 security/integrity/ima/Makefile                    |   1 +
 security/integrity/ima/ima.h                       |  60 ++++++-
 security/integrity/ima/ima_api.c                   |  27 ++-
 security/integrity/ima/ima_appraise.c              | 194 ++++++++++++++-------
 security/integrity/ima/ima_crypto.c                |  10 +-
 security/integrity/ima/ima_main.c                  |  24 ++-
 security/integrity/ima/ima_modsig.c                | 168 ++++++++++++++++++
 security/integrity/ima/ima_policy.c                |  71 ++++++--
 security/integrity/ima/ima_template.c              |  31 +++-
 security/integrity/ima/ima_template_lib.c          |  64 ++++++-
 security/integrity/ima/ima_template_lib.h          |   4 +
 security/integrity/integrity.h                     |  20 +++
 .../selftests/kexec/test_kexec_file_load.sh        |  38 +++-
 32 files changed, 871 insertions(+), 203 deletions(-)
 create mode 100644 include/linux/module_signature.h
 create mode 100644 kernel/module_signature.c
 create mode 100644 security/integrity/ima/ima_modsig.c

