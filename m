Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC52F5BA163
	for <lists+linux-integrity@lfdr.de>; Thu, 15 Sep 2022 21:34:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229838AbiIOTdV (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 15 Sep 2022 15:33:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbiIOTdJ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 15 Sep 2022 15:33:09 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 775F29D13A;
        Thu, 15 Sep 2022 12:33:08 -0700 (PDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28FI29Ss024638;
        Thu, 15 Sep 2022 19:32:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=TuMMtW1BAfphcpMxBx1JsHZJgEly9+o2/qDtppvj05E=;
 b=O93TaGVoIAXgOzM+xPl+wyckSMxpxPnKqOaTQ7QF5RoRZGuYge1YvygEMjNabbQB3XHp
 y5SQafo/BDU4C8ggAsHZThsFh0sbvbputC9zPlv6+QpDRtFDll2h9SnGEKAUyBV6pkba
 swbJYblMaUTNnL3BFrHUQfl9mp+fjbat64AI1SLUJLcAajsk0j0PtELrIyWC3rbB69So
 vqEeadMOYY8FhayzYXGUj0A47/Hb2vyVIT3JRU8UkBA+OYIH+EENcsA+Zht5DrySgDJI
 snjzPRkXSlVgiIBuYqkl1Y5BivPS/vcg6cYbj4ZVB5fIr9Zt70lLgyAXkOVzxXThkoVR 7w== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3jm8yn2nwf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Sep 2022 19:32:37 +0000
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 28FJRIOQ008803;
        Thu, 15 Sep 2022 19:32:37 GMT
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com [169.47.144.26])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3jm8yn2nvg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Sep 2022 19:32:37 +0000
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
        by ppma04wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 28FJK1kL027123;
        Thu, 15 Sep 2022 19:32:35 GMT
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com [9.57.198.29])
        by ppma04wdc.us.ibm.com with ESMTP id 3jm91r8cvb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Sep 2022 19:32:35 +0000
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com [9.57.199.110])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 28FJWY2r2753058
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 15 Sep 2022 19:32:35 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DD306AE062;
        Thu, 15 Sep 2022 19:32:34 +0000 (GMT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BC9E7AE05C;
        Thu, 15 Sep 2022 19:32:34 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu, 15 Sep 2022 19:32:34 +0000 (GMT)
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
Subject: [PATCH v14 00/26] ima: Namespace IMA with audit support in IMA-ns
Date:   Thu, 15 Sep 2022 15:31:55 -0400
Message-Id: <20220915193221.1728029-1-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.37.2
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: yq5f5jBIEXlX7I4RttLK7T4XW5vL-ciT
X-Proofpoint-GUID: wcqITmyHJ-vOk4e9xXIcwsyGx38XbgLV
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-15_10,2022-09-14_04,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 suspectscore=0
 bulkscore=0 lowpriorityscore=0 spamscore=0 priorityscore=1501
 clxscore=1011 phishscore=0 mlxlogscore=999 mlxscore=0 impostorscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2209150119
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
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
an IMA namespace can be activated by a root running the following lines
that rely on a statically linked busybox to be installed on the host for
execution within the minimal container environment:

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

git fetch https://github.com/stefanberger/linux-ima-namespaces v6.0-rc5+imans.v14.posted

Regards,
   Stefan



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
 security/integrity/ima/ima_appraise.c        |  42 +-
 security/integrity/ima/ima_asymmetric_keys.c |   8 +-
 security/integrity/ima/ima_fs.c              | 255 +++++++++---
 security/integrity/ima/ima_init.c            |  19 +-
 security/integrity/ima/ima_init_ima_ns.c     |  65 ++++
 security/integrity/ima/ima_kexec.c           |  15 +-
 security/integrity/ima/ima_main.c            | 238 +++++++++---
 security/integrity/ima/ima_ns.c              |  61 +++
 security/integrity/ima/ima_ns_status.c       | 385 +++++++++++++++++++
 security/integrity/ima/ima_policy.c          | 314 ++++++++++-----
 security/integrity/ima/ima_queue.c           |  63 ++-
 security/integrity/ima/ima_queue_keys.c      |  11 +-
 security/integrity/ima/ima_template.c        |   5 +-
 security/integrity/integrity.h               |  39 +-
 security/security.c                          |   2 +-
 28 files changed, 1659 insertions(+), 359 deletions(-)
 create mode 100644 security/integrity/ima/ima_init_ima_ns.c
 create mode 100644 security/integrity/ima/ima_ns.c
 create mode 100644 security/integrity/ima/ima_ns_status.c


base-commit: 80e78fcce86de0288793a0ef0f6acf37656ee4cf
prerequisite-patch-id: 593c4930403a507f88e8cb15ecd32b592ff900b2
-- 
2.36.1

