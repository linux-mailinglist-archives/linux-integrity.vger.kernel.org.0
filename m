Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FB7648466C
	for <lists+linux-integrity@lfdr.de>; Tue,  4 Jan 2022 18:05:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235685AbiADRFD (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 4 Jan 2022 12:05:03 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:64362 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235631AbiADRE6 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 4 Jan 2022 12:04:58 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 204Fh82F023009;
        Tue, 4 Jan 2022 17:04:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=EsxvluwOSv2mM7fi63RNyyg0yw8+zQfSCfPdx6g/8Ok=;
 b=ejB9RpIk7V1mB+ee7T2cfWhTK3hPPyQVqTOJFEpAlUHq9+Qd/VcOCPS6Of5FxhLh7kYt
 Kgq0crUNz9M70zLOCX0WdvEgaKwWT2BBfPagnggjsm/Q4IBcbHoj7QV/eh00aXWJFpsv
 GeUltck2EYkmUv235NmWPr4iUFt8Hr5Ksq+pYKUgaOTieaoFWspsoPLr4YUjse9UbLBm
 UrZsxD3IrcEZb91SDKEWdb4S//JmlY0QCW8wyVU8ibIOjKe1F5ms4DFFxvDyVqZmicgn
 CA3U7sw9w8GZgR/DcZpBAChTh68RFu75xBJ056q3xQb7gX7HIIPbPtUhMtLQSqXv5Y48 2g== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3dckgp0csq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 04 Jan 2022 17:04:31 +0000
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 204H0fMq030987;
        Tue, 4 Jan 2022 17:04:31 GMT
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com [169.55.85.253])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3dckgp0csb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 04 Jan 2022 17:04:31 +0000
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
        by ppma01wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 204H2eXG008776;
        Tue, 4 Jan 2022 17:04:30 GMT
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com [9.57.198.27])
        by ppma01wdc.us.ibm.com with ESMTP id 3daekaf111-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 04 Jan 2022 17:04:29 +0000
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com [9.57.199.111])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 204H4TfV36503990
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 4 Jan 2022 17:04:29 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 097EEAC059;
        Tue,  4 Jan 2022 17:04:29 +0000 (GMT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DDCB7AC060;
        Tue,  4 Jan 2022 17:04:28 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue,  4 Jan 2022 17:04:28 +0000 (GMT)
From:   Stefan Berger <stefanb@linux.vnet.ibm.com>
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
Subject: [PATCH v8 00/19] ima: Namespace IMA with audit support in IMA-ns
Date:   Tue,  4 Jan 2022 12:03:57 -0500
Message-Id: <20220104170416.1923685-1-stefanb@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.31.1
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ljZWy1RDYMvqv0OJKTZcFywMI4tngGDM
X-Proofpoint-ORIG-GUID: Dfi_SvISXWBb0I-pZT1d9atKMT_6iaEx
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-04_08,2022-01-04_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 adultscore=0 spamscore=0 mlxlogscore=999 mlxscore=0 clxscore=1015
 lowpriorityscore=0 impostorscore=0 priorityscore=1501 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2201040114
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Stefan Berger <stefanb@linux.ibm.com>

The goal of this series of patches is to start with the namespacing of
IMA and support auditing within an IMA namespace (IMA-ns) as the first
step.

In this series the IMA namespace is piggy backing on the user namespace
and therefore an IMA namespace is created when a user namespace is
created, although this is done late when SecurityFS is mounted inside
a user namespace. The advantage of piggy backing on the user namespace
is that the user namespace can provide the keys infrastructure that IMA
appraisal support will need later on.

We chose the goal of supporting auditing within an IMA namespace since it
requires the least changes to IMA. Following this series, auditing within
an IMA namespace can be activated by a user running the following lines
that rely on a statically linked busybox to be installed on the host for
execution within the minimal container environment:

mkdir -p rootfs/{bin,mnt,proc}
cp /sbin/busybox rootfs/bin
cp /sbin/busybox rootfs/bin/busybox2
echo >> rootfs/bin/busybox2
PATH=/bin unshare --user --map-root-user --mount-proc --pid --fork \
  --root rootfs busybox sh -c \
 "busybox mount -t securityfs /mnt /mnt; \
  busybox echo 'audit func=BPRM_CHECK mask=MAY_EXEC' > /mnt/ima/policy; \
  busybox2 cat /mnt/ima/policy"

[busybox2 is used to demonstrate 2 audit messages; see below]

Following the audit log on the host the last line cat'ing the IMA policy
inside the namespace would have been audited. Unfortunately the auditing
line is not distinguishable from one stemming from actions on the host.
The hope here is that Richard Brigg's container id support for auditing
would help resolve the problem.

The following lines added to a suitable IMA policy on the host would
cause the execution of the commands inside the container (by uid 1000)
to be measured and audited as well on the host, thus leading to two
auditing messages for the 'busybox2 cat' above and log entries in IMA's
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
capability to allow users to set file extended attributes for IMA
appraisal support.

My tree with these patches is here:

git fetch https://github.com/stefanberger/linux-ima-namespaces v5.16-rc8+imans.v8.posted

Regards,
   Stefan

Links to previous postings:
v1: https://lore.kernel.org/linux-integrity/20211130160654.1418231-1-stefanb@linux.ibm.com/T/#t
v2: https://lore.kernel.org/linux-integrity/20211203023118.1447229-1-stefanb@linux.ibm.com/T/#t
v3: https://lore.kernel.org/linux-integrity/6240b686-89cf-2e31-1c1b-ebdcf1e972c1@linux.ibm.com/T/#t
v4: https://lore.kernel.org/linux-integrity/20211207202127.1508689-1-stefanb@linux.ibm.com/T/#t
v5: https://lore.kernel.org/linux-integrity/20211208221818.1519628-1-stefanb@linux.ibm.com/T/#t
v6: https://lore.kernel.org/linux-integrity/20211210194736.1538863-1-stefanb@linux.ibm.com/T/#t
v7: https://lore.kernel.org/linux-integrity/20211217100659.2iah5prshavjk6v6@wittgenstein/T/#t

v8:
 - Rearranged patches to support lazy creation of IMA namespaces
 - Fixed issue related to re-auditing of a modified file. This required the
   introduction of ns_status structure connected to list starting on an iint
 - Fixed issue related to display of uid and gid in IMA policy to show uid
   and gid values relative to the user namespace
 - Handling of error code during hierarchical processing

v7:
 - Dropped 2 patches related to key queues; using &init_ima_ns for all calls
   from functions related to key queues where calls need ima_namespace
 - Moved ima_namespace to security/integrity/ima/ima.h
 - Extended API descriptions with ns parameter where needed
 - Using init_ima_ns in functions related to appraisal and xattrs
 - SecurityFS: Using ima_ns_from_file() to get ns pointer 
 - Reformatted to 80 columns per line

v6:
 - Removed kref and pointer to user_ns in ima_namespace (patch 1)
 - Moved only the policy file dentry into ima_namespace; other dentries are on
   stack now and can be discarded
 - Merged James's patch simplifying securityfs_remove and dropping dget()
 - Added patch with Christian's suggestion to tie opened SecurityFS file to
   the user/IMA namespace it belongs to
 - Passing missing ima_namespace parameter in functions in ima_kexec.c (ppc64)
 - Reverted v5's change to patch 4 related to protection of ima_namespace

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
  integrity/ima: Define ns_status for storing namespaced iint data
  ima: Namespace audit status flags

Stefan Berger (17):
  securityfs: Extend securityfs with namespacing support
  ima: Define ima_namespace structure and implement basic functions
  ima: Move policy related variables into ima_namespace
  ima: Move ima_htable into ima_namespace
  ima: Move measurement list related variables into ima_namespace
  ima: Move some IMA policy and filesystem related variables into
    ima_namespace
  ima: Move dentry into ima_namespace and others onto stack
  ima: Use mac_admin_ns_capable() to check corresponding capability
  ima: Only accept AUDIT rules for non-init_ima_ns namespaces for now
  ima: Implement hierarchical processing of file accesses
  ima: Implement ima_free_policy_rules() for freeing of an ima_namespace
  userns: Add pointer to ima_namespace to user_namespace
  ima: Add functions for creation and freeing of an ima_namespace
  ima: Enable re-auditing of modified files
  ima: Setup securityfs for IMA namespace
  ima: Show owning user namespace's uid and gid when displaying policy
  ima: Enable IMA namespaces

 include/linux/capability.h                   |   6 +
 include/linux/ima.h                          |  44 +++
 include/linux/user_namespace.h               |   4 +
 init/Kconfig                                 |  13 +
 kernel/user.c                                |   4 +
 kernel/user_namespace.c                      |   2 +
 security/inode.c                             |  81 ++++-
 security/integrity/iint.c                    |  13 +
 security/integrity/ima/Makefile              |   3 +-
 security/integrity/ima/ima.h                 | 215 ++++++++++--
 security/integrity/ima/ima_api.c             |  34 +-
 security/integrity/ima/ima_appraise.c        |  28 +-
 security/integrity/ima/ima_asymmetric_keys.c |   4 +-
 security/integrity/ima/ima_fs.c              | 147 +++++---
 security/integrity/ima/ima_init.c            |  19 +-
 security/integrity/ima/ima_init_ima_ns.c     |  47 +++
 security/integrity/ima/ima_kexec.c           |  15 +-
 security/integrity/ima/ima_main.c            | 212 +++++++++---
 security/integrity/ima/ima_ns.c              |  83 +++++
 security/integrity/ima/ima_ns_status.c       | 335 +++++++++++++++++++
 security/integrity/ima/ima_policy.c          | 196 ++++++-----
 security/integrity/ima/ima_queue.c           |  61 ++--
 security/integrity/ima/ima_queue_keys.c      |  11 +-
 security/integrity/ima/ima_template.c        |   5 +-
 security/integrity/integrity.h               |   4 +
 25 files changed, 1288 insertions(+), 298 deletions(-)
 create mode 100644 security/integrity/ima/ima_init_ima_ns.c
 create mode 100644 security/integrity/ima/ima_ns.c
 create mode 100644 security/integrity/ima/ima_ns_status.c

-- 
2.31.1

