Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9105F466FCA
	for <lists+linux-integrity@lfdr.de>; Fri,  3 Dec 2021 03:31:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378072AbhLCCfF (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 2 Dec 2021 21:35:05 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:11026 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240566AbhLCCfE (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 2 Dec 2021 21:35:04 -0500
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B31IeFR034047;
        Fri, 3 Dec 2021 02:31:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=juHOmmAk7xR37tIFt7o512ZDHR3uEIdWNBuQ5ivlYyY=;
 b=p+OCEtar2eE/Wc8x7PhR6rjT9aWWHoZ/bJiLtSgFQyOIt6zWDcNKqzawGJD6yQ3aMomc
 n2mt+VXujz8Lo8votJ4CvG0Iql1RC69XXu96N1OE+mpmntbB7PtiqlI5Y2rkuX912SEM
 nzhZVZAO7X1fLixeFRaf7LmD8wVmpoEuxuAk4ZUrQs8jkNMYCYc1W6B8aWU/9PbDOXVc
 WSnTv/1WZ5oGsEEI+Rl5+2aWPZqSs5mnO/Qc9mDIiscBj6vOL7JYQl7uXOh+A1oFGi4/
 C7L2vCMBRLT1usOyFfqOmXhYDnuprjpLcVnii4uCJJZwpUXTQCrS71Nl2bJQIOU7nghl 5Q== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cq9eu91pa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Dec 2021 02:31:29 +0000
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1B32HN4u006820;
        Fri, 3 Dec 2021 02:31:28 GMT
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com [169.63.121.186])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cq9eu91p0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Dec 2021 02:31:28 +0000
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
        by ppma03wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1B32SLWi014564;
        Fri, 3 Dec 2021 02:31:27 GMT
Received: from b03cxnp08026.gho.boulder.ibm.com (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
        by ppma03wdc.us.ibm.com with ESMTP id 3cn3k3k4sk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Dec 2021 02:31:27 +0000
Received: from b03ledav001.gho.boulder.ibm.com (b03ledav001.gho.boulder.ibm.com [9.17.130.232])
        by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1B32VPWq41615768
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 3 Dec 2021 02:31:25 GMT
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4D3DB6E059;
        Fri,  3 Dec 2021 02:31:25 +0000 (GMT)
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1F2866E05D;
        Fri,  3 Dec 2021 02:31:24 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b03ledav001.gho.boulder.ibm.com (Postfix) with ESMTP;
        Fri,  3 Dec 2021 02:31:23 +0000 (GMT)
From:   Stefan Berger <stefanb@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     zohar@linux.ibm.com, serge@hallyn.com,
        christian.brauner@ubuntu.com, containers@lists.linux.dev,
        dmitry.kasatkin@gmail.com, ebiederm@xmission.com,
        krzysztof.struczynski@huawei.com, roberto.sassu@huawei.com,
        mpeters@redhat.com, lhinds@redhat.com, lsturman@redhat.com,
        puiterwi@redhat.com, jejb@linux.ibm.com, jamjoom@us.ibm.com,
        linux-kernel@vger.kernel.org, paul@paul-moore.com, rgb@redhat.com,
        linux-security-module@vger.kernel.org, jmorris@namei.org,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [RFC v2 00/19] ima: Namespace IMA with audit support in IMA-ns
Date:   Thu,  2 Dec 2021 21:30:59 -0500
Message-Id: <20211203023118.1447229-1-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 0EK4HKMpon8NZH4l2kTpFl-pDNb6BxFB
X-Proofpoint-ORIG-GUID: 5w3h-Zfycv5jWrWjnpdxERRtlFTna9ut
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-02_16,2021-12-02_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 lowpriorityscore=0 bulkscore=0 phishscore=0 clxscore=1015 spamscore=0
 priorityscore=1501 mlxscore=0 mlxlogscore=999 impostorscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112030012
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

The goal of this series of patches is to start with the namespacing of
IMA and support auditing within an IMA namespace (IMA-ns) as the first
step.

In this series the IMA namespace is piggy backing on the user namespace
and therefore an IMA namespace gets created when a user namespace is
created. The advantage of this is that the user namespace can provide
the keys infrastructure that IMA appraisal support will need later on.

We chose the goal of supporting auditing within an IMA namespace since it
requires the least changes to IMA. Following this series, auditing within
an IMA namespace can be activated by a user running the following lines
that rely on a statically linked busybox to be installed on the host for
execution within the minimal container environment:

mkdir -p rootfs/{bin,mnt,proc}
cp /sbin/busybox rootfs/bin
PATH=/bin unshare --user --map-root-user --mount-proc --pid --fork \
  --root rootfs busybox sh -c \
 "busybox mount -t securityfs /mnt /mnt; \
  busybox echo 'audit func=BPRM_CHECK mask=MAY_EXEC' > /mnt/ima/policy; \
  busybox cat /mnt/ima/policy"

Following the audit log on the host the last line cat'ing the IMA policy
inside the namespace would have been audited. Unfortunately the auditing
line is not distinguishable from one stemming from actions on the host.
The hope here is that Richard Brigg's container id support for auditing
would help resolve the problem.

The following lines added to a suitable IMA policy on the host would
cause the execution of the commands inside the container (by uid 1000)
to be measured and audited as well on the host, thus leading to two
auditing messages for the 'busybox cat' above and log entries in IMA's
system log.

echo -e "measure func=BPRM_CHECK mask=MAY_EXEC uid=1000\n" \
        "audit func=BPRM_CHECK mask=MAY_EXEC uid=1000\n" \
    > /sys/kernel/security/ima/policy

The goal of supporting measurement and auditing by the host, of actions
occurring within IMA namespaces, is that users, particularly root,
should not be able to evade the host's IMA policy just by spawning
new IMA namespaces, running programs there, and discarding the namespaces
again. This is achieved through 'hierarchical processing' of file
accesses that are evaluated against the policy of the namespace where
the action occurred and against all namespaces' and their policies leading
back to the root IMA namespace (init_ima_ns).

The patch series adds support for a virtualized SecurityFS with a few
new API calls that are used by IMA namespacing so that only the data
relevant to the IMA namespace are shown. The files and directories of
other security subsystems (TPM, evm, Tomoyo, safesetid) are not showing
up when secruityfs is mounted inside a user namespace.

Much of the code leading up to the virtualization of SecurityFS deals
with moving IMA's variables from various files into the IMA namespace
structure called 'ima_namespace'. When it comes to determining the
current IMA namespace I took the approach to get the current IMA
namespace (get_current_ns()) on the top level and pass the pointer all
the way down to those functions that now need access to the ima_namespace
to get to their variables. This later on comes in handy once hierarchical
processing is implemented in this series where we walk the list of
namespaces backwards and again need to pass the pointer into functions.

A side-effect of IMA being a child of the user namespace becomes apparent
when virtualizing SecurityFS which has the effect that the filesystem code
needs to take an additional reference to the user namespace (for the keyed
filesystem), which in turn leads to the problem that the one additional
reference doesn't allow the user namespace to be deleted. The work-around
for this is to introduce an early teardown reference counter and related
IMA function that gets invoked when the user namespace reference counter
has reached a certain value, '1'. Freeing the filesystem then finally also
leads to the deletion of the user namespace.

This patch also introduces CAP_INTEGRITY_ADMIN as a subset of
CAP_SYS_ADMIN's capabilities that allows access to the IMA policy via
reduced capabilities. We would again later on use this capability to allow
users to set file extended attributes for IMA appraisal support.

The basis for this series of patches is Linux v5.15.
My tree with these patches is here:
https://github.com/stefanberger/linux-ima-namespaces/tree/v5.15%2Bimans.20211119.v4

Regards,
   Stefan

v2:
 - Folllwed Christian's suggestion to virtualize securitytfs; no more securityfs_ns
 - Followed James's advice for late 'population' of securityfs for IMA namespaces
 - Squashed 2 patches dealing with capabilities
 - Added missing 'depends on USER_NS' to Kconfig
 - Added missing 'static' to several functions

Denis Semakin (1):
  capabilities: Introduce CAP_INTEGRITY_ADMIN

Mehmet Kayaalp (2):
  ima: Define ns_status for storing namespaced iint data
  ima: Namespace audit status flags

Stefan Berger (16):
  ima: Add IMA namespace support
  ima: Move delayed work queue and variables into ima_namespace
  ima: Move IMA's keys queue related variables into ima_namespace
  ima: Move policy related variables into ima_namespace
  ima: Move ima_htable into ima_namespace
  ima: Move measurement list related variables into ima_namespace
  ima: Only accept AUDIT rules for IMA non-init_ima_ns namespaces for
    now
  ima: Implement hierarchical processing of file accesses
  securityfs: Prefix global variables with securityfs_
  securityfs: Pass static variables as parameters from top level
    functions
  securityfs: Extend securityfs with namespacing support
  ima: Move some IMA policy and filesystem related variables into
    ima_namespace
  ima: Use integrity_admin_ns_capable() to check corresponding
    capability
  userns: Introduce a refcount variable for calling early teardown
    function
  ima/userns: Define early teardown function for IMA namespace
  ima: Setup securityfs for IMA namespace

 include/linux/capability.h                   |   6 +
 include/linux/ima.h                          | 129 ++++++++++
 include/linux/security.h                     |  15 ++
 include/linux/user_namespace.h               |  21 +-
 include/uapi/linux/capability.h              |   7 +-
 init/Kconfig                                 |  13 +
 kernel/user.c                                |   9 +-
 kernel/user_namespace.c                      |  16 ++
 security/inode.c                             | 239 ++++++++++++++++---
 security/integrity/ima/Makefile              |   4 +-
 security/integrity/ima/ima.h                 | 147 ++++++++----
 security/integrity/ima/ima_api.c             |  33 ++-
 security/integrity/ima/ima_appraise.c        |  26 +-
 security/integrity/ima/ima_asymmetric_keys.c |   8 +-
 security/integrity/ima/ima_fs.c              | 215 ++++++++++++++---
 security/integrity/ima/ima_init.c            |  14 +-
 security/integrity/ima/ima_init_ima_ns.c     |  77 ++++++
 security/integrity/ima/ima_main.c            | 128 ++++++----
 security/integrity/ima/ima_ns.c              | 119 +++++++++
 security/integrity/ima/ima_ns_status.c       | 132 ++++++++++
 security/integrity/ima/ima_policy.c          | 142 ++++++-----
 security/integrity/ima/ima_queue.c           |  75 +++---
 security/integrity/ima/ima_queue_keys.c      |  73 +++---
 security/integrity/ima/ima_template.c        |   4 +-
 security/selinux/include/classmap.h          |   4 +-
 25 files changed, 1324 insertions(+), 332 deletions(-)
 create mode 100644 security/integrity/ima/ima_init_ima_ns.c
 create mode 100644 security/integrity/ima/ima_ns.c
 create mode 100644 security/integrity/ima/ima_ns_status.c

-- 
2.31.1

