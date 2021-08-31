Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C2703FCFB5
	for <lists+linux-integrity@lfdr.de>; Wed,  1 Sep 2021 00:58:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233859AbhHaW7a (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 31 Aug 2021 18:59:30 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:5878 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232580AbhHaW7a (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 31 Aug 2021 18:59:30 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17VMWfUw109378;
        Tue, 31 Aug 2021 18:58:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : content-type : content-transfer-encoding :
 mime-version; s=pp1; bh=3eVbDvOmZf7XoDA9T/v6+g2s12510lbRLOf9Y6xCU9E=;
 b=PczA32GyQtMXnJcPXovrHBlbGKeFLY/Jf0tqezJUFZ2wG0c7Jl0qzMnve/1UcM62UD81
 bU9ytS8qSWDTnFTfE6vXX7rxmUY/sx6yvLn+IfWD4dre3S8u9cW/aWHy5NFf78tc34tI
 fhV5eZuPA6uio/U+ZpG191zCVe/Vjp2EAfCLdA8syjVPqpkDPPFRsFj4gGVv9pXE6CjM
 BqwU466VB3ekgmo99n0Z7rR3jflD6Q3kQrXVn/UNBXVjcVGYGzWZ/ejiwMbZMjEFhZoY
 TNPxpzAU3swub1eiWBQZFd2Pc4wZ/OI8PW5vtoQsOC7iDwaHEtmBUkSIBpEPsg7WM7k1 cA== 
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3asvd71pka-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 31 Aug 2021 18:58:32 -0400
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 17VMqkXA009374;
        Tue, 31 Aug 2021 22:58:30 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma02fra.de.ibm.com with ESMTP id 3aqcs90tf7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 31 Aug 2021 22:58:30 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 17VMwSmf56754628
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 31 Aug 2021 22:58:28 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F0AEDA4977;
        Tue, 31 Aug 2021 22:58:27 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 115E7A4965;
        Tue, 31 Aug 2021 22:58:27 +0000 (GMT)
Received: from sig-9-65-89-16.ibm.com (unknown [9.65.89.16])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 31 Aug 2021 22:58:26 +0000 (GMT)
Message-ID: <5b3eedc2dcd03a8d16a8fbed3f4c2466521e1bdb.camel@linux.ibm.com>
Subject: [GIT PULL] integrity subsystem updates for v5.15
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-integrity <linux-integrity@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Date:   Tue, 31 Aug 2021 18:58:26 -0400
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-16.el8) 
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: -sKu6JkYQlSk80e_UbLyJ7MvrxmBH7__
X-Proofpoint-GUID: -sKu6JkYQlSk80e_UbLyJ7MvrxmBH7__
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-31_09:2021-08-31,2021-08-31 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 adultscore=0 clxscore=1015 impostorscore=0 mlxscore=0
 phishscore=0 priorityscore=1501 spamscore=0 suspectscore=0 malwarescore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108310122
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Linus,
  
The Integrity pull request for v5.15 contains only IMA changes:

- Limit the allowed hash algorithms when writing security.ima xattrs or
verifying them, based on the IMA policy and the configured hash
algorithms.

- Return the calculated "critical data" measurement hash and size to
avoid code duplication.  (Preparatory change for a proposed LSM.)

[Stephen Rothwell addressed a merge conflict between the new device
mapper "critical data" measurements (drivers/md/dm-ima.c) and extending
the "critical data" measurement function.]

- and a single patch to address a compiler warning.

thanks,

Mimi

The following changes since commit 2734d6c1b1a089fb593ef6a23d4b70903526fe0c:

  Linux 5.14-rc2 (2021-07-18 14:13:49 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git tags/integrity-v5.15

for you to fetch changes up to cb181da161963eddc9de0000de6ab2c7942be219:

  IMA: reject unknown hash algorithms in ima_get_hash_algo (2021-08-23 18:22:00 -0400)

----------------------------------------------------------------
integrity-v5.15

----------------------------------------------------------------
Austin Kim (1):
      IMA: remove -Wmissing-prototypes warning

Mimi Zohar (2):
      Merge branch 'ima-buffer-measurement-changes-v4' into next-integrity
      Merge branch 'restrict-digest-alg-v8' into next-integrity

Roberto Sassu (3):
      ima: Introduce ima_get_current_hash_algo()
      ima: Return int in the functions to measure a buffer
      ima: Add digest and digest_len params to the functions to measure a buffer

THOBY Simon (7):
      IMA: remove the dependency on CRYPTO_MD5
      IMA: block writes of the security.ima xattr with unsupported algorithms
      IMA: add support to restrict the hash algorithms used for file appraisal
      IMA: add a policy option to restrict xattr hash algorithms on appraisal
      IMA: introduce a new policy option func=SETXATTR_CHECK
      IMA: prevent SETXATTR_CHECK policy rules with unavailable algorithms
      IMA: reject unknown hash algorithms in ima_get_hash_algo

 Documentation/ABI/testing/ima_policy         |  15 ++-
 include/linux/ima.h                          |  23 +++-
 security/integrity/ima/Kconfig               |   1 -
 security/integrity/ima/ima.h                 |  24 ++--
 security/integrity/ima/ima_api.c             |   6 +-
 security/integrity/ima/ima_appraise.c        |  78 ++++++++++--
 security/integrity/ima/ima_asymmetric_keys.c |   2 +-
 security/integrity/ima/ima_init.c            |   3 +-
 security/integrity/ima/ima_main.c            |  89 ++++++++++----
 security/integrity/ima/ima_mok.c             |   2 +-
 security/integrity/ima/ima_policy.c          | 174 ++++++++++++++++++++++++---
 security/integrity/ima/ima_queue_keys.c      |   2 +-
 security/selinux/ima.c                       |   6 +-
 13 files changed, 350 insertions(+), 75 deletions(-)

