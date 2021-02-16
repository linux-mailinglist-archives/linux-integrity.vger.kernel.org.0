Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A966131CB79
	for <lists+linux-integrity@lfdr.de>; Tue, 16 Feb 2021 14:53:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230031AbhBPNw7 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 16 Feb 2021 08:52:59 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:45598 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230018AbhBPNww (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 16 Feb 2021 08:52:52 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 11GDW3gF007984;
        Tue, 16 Feb 2021 08:52:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : content-type : mime-version :
 content-transfer-encoding; s=pp1;
 bh=sOLgDYNkVv+hmSQaf8FRmXUqwoLBNq8nnbihEXVtCiM=;
 b=TX7hHkDnhXv/bnvoNDuD3iy1MC5pxbD7rLRlI7IrG3lJgvaZcOpqiC70yDq5ql49sLfM
 GPBsTlOePa1yiz0aK46+/flbPdl5FQ0p6Uom0F5Kzut7rfJqSN3gEiKMo85OGgQiy7As
 2aDKIq19CHFuz9TO/amcUKKcEWzY7ylzkBMHGl4H9VUKXEdM7yEwdhFLexoM2q+MMYjy
 IKY2zzJERL6jSdNtHt4ul/tyI+X2M/aiNQzlP9QZuM0N2KqLRf7VrxW0sID/6pG43zvK
 ZlIT2A+HpqasWr1UijzfhSLt7FH35zZvs/LuBsI+unRXUGSSmD6d4x5a7BPYG3mww5Le 3w== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36revrrts7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 16 Feb 2021 08:52:07 -0500
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 11GDlcwT031410;
        Tue, 16 Feb 2021 13:52:05 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma04ams.nl.ibm.com with ESMTP id 36p6d8atje-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 16 Feb 2021 13:52:05 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 11GDq3jg48562558
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 Feb 2021 13:52:03 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 30E97A404D;
        Tue, 16 Feb 2021 13:52:03 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6A27AA4053;
        Tue, 16 Feb 2021 13:52:02 +0000 (GMT)
Received: from sig-9-65-197-51.ibm.com (unknown [9.65.197.51])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 16 Feb 2021 13:52:02 +0000 (GMT)
Message-ID: <d42636f6983ac73e8c36f727225b213688780d14.camel@linux.ibm.com>
Subject: [GIT PULL] integrity subsystem updates for v5.12
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-integrity <linux-integrity@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Date:   Tue, 16 Feb 2021 08:52:01 -0500
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-14.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-02-16_02:2021-02-16,2021-02-16 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 malwarescore=0 mlxlogscore=999 priorityscore=1501
 phishscore=0 adultscore=0 spamscore=0 clxscore=1011 impostorscore=0
 bulkscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102160122
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Linus,
  
New is IMA support for measuring kernel critical data, as per usual
based on policy.   The first example measures the in memory SELinux
policy.  The second example measures the kernel version.

In addition are four bug fixes to address memory leaks and a missing
"static"
function declaration.

[FYI: Stephen is carrying a manual merge of the pidfd tree with the
integrity tree.]

thanks,

Mimi


The following changes since commit 7c53f6b671f4aba70ff15e1b05148b10d58c2837:

  Linux 5.11-rc3 (2021-01-10 14:34:50 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git tags/integrity-v5.12

for you to fetch changes up to f6692213b5045dc461ce0858fb18cf46f328c202:

  integrity: Make function integrity_add_key() static (2021-02-12 11:11:59 -0500)

----------------------------------------------------------------
integrity-v5.12

----------------------------------------------------------------
Dinghao Liu (1):
      evm: Fix memleak in init_desc

Lakshmi Ramasubramanian (4):
      IMA: define a builtin critical data measurement policy
      selinux: include a consumer of the new IMA critical data hook
      ima: Free IMA measurement buffer on error
      ima: Free IMA measurement buffer after kexec syscall

Mimi Zohar (2):
      Merge branch 'measure-critical-data' into next-integrity
      Merge branch 'ima-kexec-fixes' into next-integrity

Raphael Gianotti (1):
      IMA: Measure kernel version in early boot

Tushar Sugandhi (6):
      IMA: generalize keyring specific measurement constructs
      IMA: add support to measure buffer data hash
      IMA: define a hook to measure kernel integrity critical data
      IMA: add policy rule to measure critical data
      IMA: limit critical data measurement based on a label
      IMA: extend critical data hook to limit the measurement based on a label

Wei Yongjun (1):
      integrity: Make function integrity_add_key() static

 Documentation/ABI/testing/ima_policy            |   5 +-
 Documentation/admin-guide/kernel-parameters.txt |   5 +-
 include/linux/ima.h                             |  10 +++
 include/linux/kexec.h                           |   5 ++
 kernel/kexec_file.c                             |   5 ++
 security/integrity/digsig.c                     |   4 +-
 security/integrity/evm/evm_crypto.c             |   7 +-
 security/integrity/ima/ima.h                    |   8 +-
 security/integrity/ima/ima_api.c                |   8 +-
 security/integrity/ima/ima_appraise.c           |   2 +-
 security/integrity/ima/ima_asymmetric_keys.c    |   2 +-
 security/integrity/ima/ima_init.c               |   5 ++
 security/integrity/ima/ima_kexec.c              |   3 +
 security/integrity/ima/ima_main.c               |  59 ++++++++++--
 security/integrity/ima/ima_policy.c             | 115 +++++++++++++++++++-----
 security/integrity/ima/ima_queue_keys.c         |   3 +-
 security/selinux/Makefile                       |   2 +
 security/selinux/ima.c                          |  44 +++++++++
 security/selinux/include/ima.h                  |  24 +++++
 security/selinux/include/security.h             |   3 +-
 security/selinux/ss/services.c                  |  64 +++++++++++--
 21 files changed, 329 insertions(+), 54 deletions(-)
 create mode 100644 security/selinux/ima.c
 create mode 100644 security/selinux/include/ima.h

