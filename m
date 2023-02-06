Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A963268BF4A
	for <lists+linux-integrity@lfdr.de>; Mon,  6 Feb 2023 15:04:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230379AbjBFOEA (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 6 Feb 2023 09:04:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbjBFODq (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 6 Feb 2023 09:03:46 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E058144A2;
        Mon,  6 Feb 2023 06:03:44 -0800 (PST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 316DqMru023158;
        Mon, 6 Feb 2023 14:03:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=1EUSpSwZ/cNq+glOBnLL8eivYCOmicZNM+ow58YBN54=;
 b=k03gbqHCK/Xj7yARKEXM+PqKE7x+AR88GNKF2BNmqqbFnFz0yWb3QwRvpvjzMg7SJkzl
 hmK3/q6Ygdtpupoio7ehYUPqnZZxbP9FCuEM+Nw/frC4bsVwjQvR8Lb6gaX5dhcNaq84
 5f+W9p9PYkGMXnmiEXMnSP13M8oNxbWJUCIYE9W1nkw/I0YoVjxmr1eoF+3CrK9R9rKZ
 ddcYwiLREiMgwr8CVt5TbTMGzXq3l7WgRrw/G+KkVNJGuQxikeuFGCfsqaToPf+2ovas
 zwuTm2K6nwh1QWK50xxNVKvv9NQC7Vsowbdlr0bRTphhnpwMVuhyrGi9fJh7+wQ/oOHQ CQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nk1abkhef-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Feb 2023 14:03:06 +0000
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 316Dqb2I024728;
        Mon, 6 Feb 2023 14:03:06 GMT
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nk1abkhc5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Feb 2023 14:03:05 +0000
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 316C2OjU017708;
        Mon, 6 Feb 2023 14:03:02 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([9.208.130.99])
        by ppma03dal.us.ibm.com (PPS) with ESMTPS id 3nhf07dq26-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Feb 2023 14:03:02 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
        by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 316E31AJ32178642
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 6 Feb 2023 14:03:01 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E30595805B;
        Mon,  6 Feb 2023 14:03:00 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 267375805C;
        Mon,  6 Feb 2023 14:02:59 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Mon,  6 Feb 2023 14:02:59 +0000 (GMT)
From:   Stefan Berger <stefanb@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     zohar@linux.ibm.com, serge@hallyn.com, brauner@kernel.org,
        containers@lists.linux.dev, dmitry.kasatkin@gmail.com,
        ebiederm@xmission.com, krzysztof.struczynski@huawei.com,
        roberto.sassu@huawei.com, mpeters@redhat.com, lhinds@redhat.com,
        lsturman@redhat.com, puiterwi@redhat.com, jejb@linux.ibm.com,
        jamjoom@us.ibm.com, linux-kernel@vger.kernel.org,
        paul@paul-moore.com, rgb@redhat.com,
        linux-security-module@vger.kernel.org, jmorris@namei.org,
        jpenumak@redhat.com, Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v15 00/26] ima: Namespace IMA with audit support in IMA-ns
Date:   Mon,  6 Feb 2023 09:02:27 -0500
Message-Id: <20230206140253.3755945-1-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.39.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: etLHJI7JroFO-HMeyUr2YZxeNfDNFl82
X-Proofpoint-GUID: G166JLVswEkgR3nSpUGc27BA9jDXlAf3
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-06_07,2023-02-06_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 adultscore=0
 lowpriorityscore=0 malwarescore=0 suspectscore=0 bulkscore=0
 impostorscore=0 spamscore=0 mlxscore=0 priorityscore=1501 phishscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302060121
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

The goal of this series of patches is to start with the namespacing of
IMA and support auditing within an IMA namespace (IMA-ns) as the first
step.

In this series the IMA namespace is piggybacking on the user namespace
and therefore an IMA namespace is created when a user namespace is
created, although this is done late when SecurityFS is mounted inside
a user namespace. The advantage of piggybacking on the user namespace
is that the user namespace can provide the keys infrastructure that IMA
appraisal support will need later on.

We chose the goal of supporting auditing within an IMA namespace since it
requires the least changes to IMA. Following this series, auditing within
an IMA namespace can be activated by 'root' running the following lines
that rely on a statically linked busybox to be installed on the host for
execution within the minimal container environment. Note that root in
the user namespace, or when entering the namespace using nsenter, must have
the CAP_AUDIT_WRITE capability to be able to set the IMA audit rules in the
namespace.

As root (since audit rules may now only be set by root):

mkdir -p rootfs/{bin,mnt,proc}
cp /sbin/busybox rootfs/bin
cp /sbin/busybox rootfs/bin/busybox2
echo >> rootfs/bin/busybox2
PATH=/bin unshare --user --map-root-user --mount-proc --pid --fork \
  --root rootfs busybox sh -c \
 "busybox mount -t securityfs /mnt /mnt; \
  busybox echo 1 > /mnt/ima/active; \
  busybox echo 'audit func=BPRM_CHECK mask=MAY_EXEC' > /mnt/ima/policy; \
  busybox2 cat /mnt/ima/policy"

[busybox2 is used to demonstrate 2 audit messages; see below]

Following the audit log on the host the last line cat'ing the IMA policy
inside the namespace would have been audited. Unfortunately the auditing
line is not distinguishable from one stemming from actions on the host.
The hope here is that Richard Brigg's container id support for auditing
would help resolve the problem.

In the above the writing of '1' to the 'active' file is used to activate
the IMA namespace. Future extensions to IMA namespaces will make use of
the configuration stage after the mounting of securityfs and before the
activation to for example choose the measurement log template.

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

Much of the code following the virtualization of SecurityFS deals
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

git fetch https://github.com/stefanberger/linux-ima-namespaces v6.2-rc7+imans.v15.posted

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
v8: https://lore.kernel.org/all/20220104170416.1923685-1-stefanb@linux.vnet.ibm.com/#r
v9: https://lore.kernel.org/linux-integrity/?t=20220131234353
v10: https://lore.kernel.org/linux-integrity/20220201203735.164593-1-stefanb@linux.ibm.com/T/#t
v11: https://lore.kernel.org/linux-integrity/20220302134703.1273041-1-stefanb@linux.ibm.com/T/#mcf159fd2132e27514b2089fbf32d6cfb2d363403
v12: https://lore.kernel.org/lkml/8ba32888-32ad-cf92-49e6-15d432331bba@linux.ibm.com/
v13: https://lore.kernel.org/linux-integrity/20220707144800.828288-1-stefanb@linux.ibm.com/T/#t
v14: https://lore.kernel.org/linux-integrity/eb7608dc-1eed-5824-8d4e-012bfc0dde1c@linux.ibm.com/T/#t

v15:
 - Applied fix for memory leak in error path (17/26)
 - Gated setting of IMA audit rules in namespace with CAP_AUDIT_WRITE
 - Rebased on v6.2-rc6; notes in individual patches
 - Test suite now also with tests using UML:
     https://github.com/stefanberger/ima-namespaces-tests

v14:
 - Rebased on v6.0-rc5

v13:
 - Applied Serge's tags and suggestions

v12:
 - Fixed issues detected by kernel test robot
 - Fixed other minor issues
 - WIP test suite: https://github.com/stefanberger/ima-namespaces-tests

v11:
 - Added Mimi's R-b's; addressed issues from v10
 - Emission of informational audit messages is limited to init_ima_ns
 - IMA policy audit rules can now only be set by root to avoid flooding of
   audit log by users
 - Switch to lazy lsm policy updates for better performance
 - Use ima_ns_flags to set IMA_NS_ACTIVE flag indicating active namespace
   rather than atomic_t
 - Moved patch 'Setup securityfs for IMA namespace' back towards end again
 - WIP test suite: https://github.com/stefanberger/ima-namespaces-tests

v10:
 - Added A-b's; addressed issues from v9
 - Added 2 patches to support freeing of iint after namespace deletion
 - Added patch to return error code from securityfs functions
 - Added patch to limit number of policy rules in IMA-ns to 1024

v9:
 - Rearranged order of patch that adds IMA-ns pointer to user_ns to be before
   hierarchical processing patch
 - Renamed ns_status variables from status to ns_status to avoid clashes
 - Added bug fixing patches to top
 - Added patch 'Move arch_policy_entry into ima_namespace'
 - Added patch 'Move ima_lsm_policy_notifier into ima_namespace'
 - Addressed comments to v8
 - Added change comments to individual patches
 - Formatted code following checkpatch.pl --strict

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
 - Followed Christian's suggestion to virtualize securitytfs; no more securityfs_ns
 - Followed James's advice for late 'population' of securityfs for IMA namespaces
 - Squashed 2 patches dealing with capabilities
 - Added missing 'depends on USER_NS' to Kconfig
 - Added missing 'static' to several functions


Christian Brauner (1):
  securityfs: rework dentry creation

Mehmet Kayaalp (2):
  integrity/ima: Define ns_status for storing namespaced iint data
  ima: Namespace audit status flags

Stefan Berger (23):
  securityfs: Extend securityfs with namespacing support
  ima: Define ima_namespace struct and start moving variables into it
  ima: Move arch_policy_entry into ima_namespace
  ima: Move ima_htable into ima_namespace
  ima: Move measurement list related variables into ima_namespace
  ima: Move some IMA policy and filesystem related variables into
    ima_namespace
  ima: Move IMA securityfs files into ima_namespace or onto stack
  ima: Move ima_lsm_policy_notifier into ima_namespace
  ima: Switch to lazy lsm policy updates for better performance
  ima: Define mac_admin_ns_capable() as a wrapper for ns_capable()
  ima: Only accept AUDIT rules for non-init_ima_ns namespaces for now
  userns: Add pointer to ima_namespace to user_namespace
  ima: Implement hierarchical processing of file accesses
  ima: Implement ima_free_policy_rules() for freeing of an ima_namespace
  ima: Add functions for creating and freeing of an ima_namespace
  integrity: Add optional callback function to integrity_inode_free()
  ima: Remove unused iints from the integrity_iint_cache
  ima: Setup securityfs for IMA namespace
  ima: Introduce securityfs file to activate an IMA namespace
  ima: Show owning user namespace's uid and gid when displaying policy
  ima: Limit number of policy rules in non-init_ima_ns
  ima: Restrict informational audit messages to init_ima_ns
  ima: Enable IMA namespaces

 include/linux/capability.h                   |   6 +
 include/linux/fs.h                           |   5 +
 include/linux/ima.h                          |  36 ++
 include/linux/integrity.h                    |   8 +-
 include/linux/user_namespace.h               |   9 +
 init/Kconfig                                 |  14 +
 kernel/user.c                                |   4 +
 kernel/user_namespace.c                      |   2 +
 security/inode.c                             |  83 +++-
 security/integrity/iint.c                    |  26 +-
 security/integrity/ima/Makefile              |   3 +-
 security/integrity/ima/ima.h                 | 256 ++++++++++--
 security/integrity/ima/ima_api.c             |  44 ++-
 security/integrity/ima/ima_appraise.c        |  46 ++-
 security/integrity/ima/ima_asymmetric_keys.c |   8 +-
 security/integrity/ima/ima_fs.c              | 255 +++++++++---
 security/integrity/ima/ima_init.c            |  19 +-
 security/integrity/ima/ima_init_ima_ns.c     |  69 ++++
 security/integrity/ima/ima_kexec.c           |  15 +-
 security/integrity/ima/ima_main.c            | 238 +++++++++---
 security/integrity/ima/ima_ns.c              |  61 +++
 security/integrity/ima/ima_ns_status.c       | 385 +++++++++++++++++++
 security/integrity/ima/ima_policy.c          | 323 +++++++++++-----
 security/integrity/ima/ima_queue.c           |  63 ++-
 security/integrity/ima/ima_queue_keys.c      |  11 +-
 security/integrity/ima/ima_template.c        |   5 +-
 security/integrity/integrity.h               |  39 +-
 security/security.c                          |   2 +-
 28 files changed, 1672 insertions(+), 363 deletions(-)
 create mode 100644 security/integrity/ima/ima_init_ima_ns.c
 create mode 100644 security/integrity/ima/ima_ns.c
 create mode 100644 security/integrity/ima/ima_ns_status.c


base-commit: 4ec5183ec48656cec489c49f989c508b68b518e3
-- 
2.37.3

