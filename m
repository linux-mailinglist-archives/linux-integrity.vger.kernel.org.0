Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58660463B09
	for <lists+linux-integrity@lfdr.de>; Tue, 30 Nov 2021 17:07:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238164AbhK3QK4 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 30 Nov 2021 11:10:56 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:4768 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239087AbhK3QK4 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 30 Nov 2021 11:10:56 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AUFQEZE010596;
        Tue, 30 Nov 2021 16:07:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=1tG4UPxflRCGsvtzJK/baf4fuhdUR/gAxjVMyDnrrdg=;
 b=WtQQQ/aRd64PmFITtYyd8d46kZZvrBseb5nXTL2G1SND7Ep3NNbY4MCKNs9b/lwnClk4
 +J8ryQVMBqOaVhURkDWCFTWb9nlLAbRkTs4YJ4zsuvcN6YgbV1od3pl+AKTiEf6edLC5
 ZFJvJSU7gNkATqp7LnaA4WFnN/7iPP+ZJhx+4x62TQ9jsM8HsukD14X3D88igKOW+fEu
 I8DiMCehydbv6h8fR+LxYK3O5zUx5UUl1nqVhpezxhQAoVQMJcM3erKyp0r2o855za/j
 ei0WD4zWSpDes5Aum0oNwgQZwJ+xIICvwtF3xkuYurYsxkH+9+/3yEypZxDtqiZjlZFg NQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cnphjs53f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 Nov 2021 16:07:14 +0000
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1AUFkiFJ007448;
        Tue, 30 Nov 2021 16:07:13 GMT
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com [169.55.91.170])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cnphjs52n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 Nov 2021 16:07:13 +0000
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
        by ppma02wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1AUG2jN5009857;
        Tue, 30 Nov 2021 16:07:12 GMT
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com [9.57.198.27])
        by ppma02wdc.us.ibm.com with ESMTP id 3ckcab7thx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 Nov 2021 16:07:12 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1AUG7Agu59310570
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Nov 2021 16:07:10 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 85D1AB2065;
        Tue, 30 Nov 2021 16:07:10 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5C3AFB208A;
        Tue, 30 Nov 2021 16:07:10 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue, 30 Nov 2021 16:07:10 +0000 (GMT)
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
Subject: [RFC 00/20] ima: Namespace IMA with audit support in IMA-ns
Date:   Tue, 30 Nov 2021 11:06:34 -0500
Message-Id: <20211130160654.1418231-1-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: wNEjFmUdielYUMZRC6lOkG4i6XraKxGe
X-Proofpoint-ORIG-GUID: wTiseAbjXvqvWsjcW5KmxyzlWMqN8HbG
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-30_09,2021-11-28_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 spamscore=0
 priorityscore=1501 mlxscore=0 adultscore=0 mlxlogscore=999 malwarescore=0
 suspectscore=0 lowpriorityscore=0 bulkscore=0 impostorscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111300084
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
 "busybox mount -t securityfs_ns /mnt /mnt; \
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

The patch series adds support for virtualizing SecurityFS and introduces
a derivative of SecurityFS called 'securityfs_ns' whose goal is to
only display the data relevant to the IMA namespace rather than showing
files and directories of other security subsystems (TPM, evm, Tomoyo,
safesetid) that use the existing SecurityFS and that would show
if one was to bind-mount SecurityFS into a mount namespace.

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


Denis Semakin (2):
  capabilities: Introduce CAP_INTEGRITY_ADMIN
  ima: Use integrity_admin_ns_capable() to check corresponding
    capability

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
  securityfs: Build securityfs_ns for namespacing support
  ima: Move some IMA policy and filesystem related variables into
    ima_namespace
  ima: Use ns_capable() for namespace policy access
  userns: Introduce a refcount variable for calling early teardown
    function
  ima/userns: Define early teardown function for IMA namespace
  ima: Setup securityfs_ns for IMA namespace

 include/linux/capability.h                   |   6 +
 include/linux/ima.h                          | 132 ++++++++-
 include/linux/security.h                     |  18 ++
 include/linux/user_namespace.h               |  21 +-
 include/uapi/linux/capability.h              |   7 +-
 include/uapi/linux/magic.h                   |   1 +
 init/Kconfig                                 |  12 +
 kernel/user.c                                |   9 +-
 kernel/user_namespace.c                      |  16 +
 security/inode.c                             | 290 ++++++++++++++++---
 security/integrity/ima/Makefile              |   4 +-
 security/integrity/ima/ima.h                 | 147 ++++++----
 security/integrity/ima/ima_api.c             |  33 ++-
 security/integrity/ima/ima_appraise.c        |  26 +-
 security/integrity/ima/ima_asymmetric_keys.c |   8 +-
 security/integrity/ima/ima_fs.c              | 236 +++++++++++++--
 security/integrity/ima/ima_init.c            |  14 +-
 security/integrity/ima/ima_init_ima_ns.c     |  77 +++++
 security/integrity/ima/ima_main.c            | 128 +++++---
 security/integrity/ima/ima_ns.c              | 119 ++++++++
 security/integrity/ima/ima_ns_status.c       | 132 +++++++++
 security/integrity/ima/ima_policy.c          | 142 +++++----
 security/integrity/ima/ima_queue.c           |  75 +++--
 security/integrity/ima/ima_queue_keys.c      |  73 ++---
 security/integrity/ima/ima_template.c        |   4 +-
 security/selinux/include/classmap.h          |   4 +-
 26 files changed, 1394 insertions(+), 340 deletions(-)
 create mode 100644 security/integrity/ima/ima_init_ima_ns.c
 create mode 100644 security/integrity/ima/ima_ns.c
 create mode 100644 security/integrity/ima/ima_ns_status.c

-- 
2.31.1

