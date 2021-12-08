Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBF6F46DE3E
	for <lists+linux-integrity@lfdr.de>; Wed,  8 Dec 2021 23:19:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240714AbhLHWXD (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 8 Dec 2021 17:23:03 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:12196 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S240638AbhLHWWN (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 8 Dec 2021 17:22:13 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B8KQqjm015969;
        Wed, 8 Dec 2021 22:18:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=jLmhCxruyWds63xPW1aVJJRLDDiEfbKyQTtYUDgo0lY=;
 b=ZM3SesI87cMFnyWKeyIKsd2IYlQfvMr5DUPFq7LDfUy3dq1dFDVPvsejs9VF4SHe5CJQ
 vPjC5od1lVytTBpKpUR4Fbkfy93bDDZrEy9T2udpycXGnI8UY6DhQGAHgPD56Z5pLSiI
 llBYpHkEWXmjhtdXRJs1/+KGiTGuGuAUsqvHis5CH509ggF94QoSzkPFdn/lRfpbLWQF
 aQUpmuyT3gBmrYOQ4zNG1skUjZ0X8KRg3hsxgzjklh/+daDKZahNs/b5VFZjr5q7PyfR
 k+4adbR2C0wfeX6NI+UifVav1ty9lA33JhoYYixeAty2F+m7lJxiIrsmy1OoEBKf+QAE Sw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3cu3auadpa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Dec 2021 22:18:26 +0000
Received: from m0098413.ppops.net (m0098413.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1B8MH8eA023550;
        Wed, 8 Dec 2021 22:18:26 GMT
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3cu3auadp4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Dec 2021 22:18:26 +0000
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1B8MDu57020083;
        Wed, 8 Dec 2021 22:18:25 GMT
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com [9.57.198.24])
        by ppma01dal.us.ibm.com with ESMTP id 3cqyycykbw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Dec 2021 22:18:25 +0000
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com [9.57.199.106])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1B8MINI920513170
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 8 Dec 2021 22:18:23 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7B59D28073;
        Wed,  8 Dec 2021 22:18:23 +0000 (GMT)
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 640742806A;
        Wed,  8 Dec 2021 22:18:23 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed,  8 Dec 2021 22:18:23 +0000 (GMT)
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
Subject: [PATCH v5 00/16] ima: Namespace IMA with audit support in IMA-ns
Date:   Wed,  8 Dec 2021 17:18:02 -0500
Message-Id: <20211208221818.1519628-1-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: RPmrg_XxnkC6Xc58Jrhdcbet64WFjjAY
X-Proofpoint-GUID: E3_U1IWkmgJhNM6oYtNvjTwo8CI3AkFR
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-08_08,2021-12-08_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 phishscore=0
 mlxscore=0 priorityscore=1501 mlxlogscore=999 suspectscore=0 clxscore=1015
 lowpriorityscore=0 adultscore=0 bulkscore=0 malwarescore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2112080121
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
new API calls that are used by IMA namespacing. Only the data relevant
to the IMA namespace are shown. The files and directories of other
security subsystems (TPM, evm, Tomoyo, safesetid) are not showing
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

This patch also introduces usage of CAP_MAC_ADMIN to allow access to the
IMA policy via reduced capabilities. We would again later on use this
capability to allow users to set file extended attributes for IMA appraisal
support.

My tree with these patches is here:

git clone https://github.com/stefanberger/linux-ima-namespaces v5.15+imans.v5.posted 

Regards,
   Stefan

v5:
 - Followed Christian's suggestions on patch 1. Also, reverted increased reference
   counter on init_user_ns since ima_ns doesn't take reference to its user_ns.
 - No addtional reference is taken on securityfs dentries for user_ns != init_user_ns.
   Updated documentation and removed cleanup of dentries on superblock kill.
   (patches 12 & 16)
 - Moved else branch to earlier patch (patch 11)
 - Protect ima_namespace by taking reference on user namespace for delayed work queue.
   (patch 4)

v4:
 - For consistency moved 'ns = get_current_ns()' to top of functions
 - Merge in James's latest SecurityFS patch

v3:
 - Further modifications to virtualized SecurityFS following James's posted patch
 - Dropping of early teardown for user_namespaces since not needed anymore

v2:
 - Folllwed Christian's suggestion to virtualize securitytfs; no more securityfs_ns
 - Followed James's advice for late 'population' of securityfs for IMA namespaces
 - Squashed 2 patches dealing with capabilities
 - Added missing 'depends on USER_NS' to Kconfig
 - Added missing 'static' to several functions


Mehmet Kayaalp (2):
  ima: Define ns_status for storing namespaced iint data
  ima: Namespace audit status flags

Stefan Berger (14):
  ima: Add IMA namespace support
  ima: Move delayed work queue and variables into ima_namespace
  ima: Move IMA's keys queue related variables into ima_namespace
  ima: Move policy related variables into ima_namespace
  ima: Move ima_htable into ima_namespace
  ima: Move measurement list related variables into ima_namespace
  ima: Only accept AUDIT rules for IMA non-init_ima_ns namespaces for
    now
  ima: Implement hierarchical processing of file accesses
  securityfs: Only use simple_pin_fs/simple_release_fs for init_user_ns
  securityfs: Extend securityfs with namespacing support
  ima: Move some IMA policy and filesystem related variables into
    ima_namespace
  ima: Use mac_admin_ns_capable() to check corresponding capability
  ima: Move dentries into ima_namespace
  ima: Setup securityfs for IMA namespace

 include/linux/capability.h                   |   6 +
 include/linux/ima.h                          | 138 +++++++++++++++++
 include/linux/user_namespace.h               |   4 +
 init/Kconfig                                 |  13 ++
 kernel/user.c                                |   7 +
 kernel/user_namespace.c                      |   8 +
 security/inode.c                             |  55 +++++--
 security/integrity/ima/Makefile              |   4 +-
 security/integrity/ima/ima.h                 | 145 +++++++++++------
 security/integrity/ima/ima_api.c             |  33 ++--
 security/integrity/ima/ima_appraise.c        |  26 ++--
 security/integrity/ima/ima_asymmetric_keys.c |   8 +-
 security/integrity/ima/ima_fs.c              | 154 +++++++++++--------
 security/integrity/ima/ima_init.c            |  20 +--
 security/integrity/ima/ima_init_ima_ns.c     |  73 +++++++++
 security/integrity/ima/ima_main.c            | 144 +++++++++++------
 security/integrity/ima/ima_ns.c              | 102 ++++++++++++
 security/integrity/ima/ima_ns_status.c       | 132 ++++++++++++++++
 security/integrity/ima/ima_policy.c          | 146 ++++++++++--------
 security/integrity/ima/ima_queue.c           |  75 +++++----
 security/integrity/ima/ima_queue_keys.c      |  81 +++++-----
 security/integrity/ima/ima_template.c        |   4 +-
 22 files changed, 1032 insertions(+), 346 deletions(-)
 create mode 100644 security/integrity/ima/ima_init_ima_ns.c
 create mode 100644 security/integrity/ima/ima_ns.c
 create mode 100644 security/integrity/ima/ima_ns_status.c

-- 
2.31.1

