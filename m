Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11C2D2489B3
	for <lists+linux-integrity@lfdr.de>; Tue, 18 Aug 2020 17:25:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727043AbgHRPZX (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 18 Aug 2020 11:25:23 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2623 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728042AbgHRPZK (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 18 Aug 2020 11:25:10 -0400
Received: from lhreml722-chm.china.huawei.com (unknown [172.18.7.106])
        by Forcepoint Email with ESMTP id 8C0AB1C8B9E25EB60BAC;
        Tue, 18 Aug 2020 16:25:07 +0100 (IST)
Received: from kstruczy-linux-box (10.204.65.138) by
 lhreml722-chm.china.huawei.com (10.201.108.73) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Tue, 18 Aug 2020 16:25:05 +0100
Received: by kstruczy-linux-box (sSMTP sendmail emulation); Tue, 18 Aug 2020 17:25:08 +0200
From:   <krzysztof.struczynski@huawei.com>
To:     <linux-integrity@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <containers@lists.linux-foundation.org>,
        <linux-security-module@vger.kernel.org>
CC:     Krzysztof Struczynski <krzysztof.struczynski@huawei.com>,
        <zohar@linux.ibm.com>, <stefanb@linux.vnet.ibm.com>,
        <sunyuqiong1988@gmail.com>, <mkayaalp@cs.binghamton.edu>,
        <dmitry.kasatkin@gmail.com>, <serge@hallyn.com>,
        <jmorris@namei.org>, <christian@brauner.io>,
        <silviu.vlasceanu@huawei.com>, <roberto.sassu@huawei.com>
Subject: [RFC PATCH 00/30] ima: Introduce IMA namespace
Date:   Tue, 18 Aug 2020 17:20:07 +0200
Message-ID: <20200818152037.11869-1-krzysztof.struczynski@huawei.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <N>
References: <N>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.204.65.138]
X-ClientProxiedBy: fraeml707-chm.china.huawei.com (10.206.15.35) To
 lhreml722-chm.china.huawei.com (10.201.108.73)
X-CFilter-Loop: Reflected
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Krzysztof Struczynski <krzysztof.struczynski@huawei.com>

IMA has not been designed to work with containers. It handles every
process in the same way, and it cannot distinguish if a process belongs to
a container or not.

Containers use namespaces to make it appear to the processes in the
containers that they have their own isolated instance of the global
resource. For IMA as well, it is desirable to let processes in the
containers have IMA functionality independent from other containers:
separate policy rules, measurement list, additional appraisal keys to
verify the container image, separate audit logs.

As previous work done in this area, this patch series introduces the IMA
namespace, which is a separate instance of IMA to handle a subset of
processes that belong to a container.

The IMA namespace is created using clone3() or unshare() system calls. It
is important to configure the namespace before any process appears in it,
so that the new policy rules apply to the very first process in the
namespace. To achieve that, the intermediate namespace ima_ns_for_children
is used. It stores the configuration and becomes active on the next fork
or when the first process enters it using the setns() system call. The
similar process is used for the time namespace.

The IMA namespace can be configured using the new securityfs directory
entries that allow the user to set the policy rules, x509 certificate for
appraisal and pass IMA configuration parameters normally included in the
kernel command line parameters. It is intended to extend the clone_args to
allow configuration from clone3() syscall.

To inform other containers about an action made by a given container, a
linked list of IMA namespaces has been implemented. The state/policy of
those containers is evaluated to see if read-write violations (ToMToU,
open-writer) should be recorded in the respective measurement list. Any
change to the files shared across containers is recorded in the namespaced
inode's integrity cache when the file is freed.

To isolate the measurement list and the appraisal keys, the following
decisions were made:

The measurement list remains global, with the assumption that there is
only one TPM in the system. Each IMA namespace has a unique ID, that
allows to track measurements per IMA namespace. Processes in one
namespace, have access only to the measurements from that namespace. The
exception is made for the initial IMA namespace, whose processes have
access to all entries.

The appraisal keys of all IMA namespaces are stored in the IMA system
keyring. Each key is linked to the respective IMA namespace using the key
domain tag. The process that belongs to one IMA namespace, cannot
add/replace/modify a key that belongs to another IMA namespace.

To give access to the IMA securityfs directory entries to the container's
owner, read and write (when needed) permissions are given to the "other"
users not in the file's group 'o'. The access to the files is controlled
by IMA, and given only to the user that has SYS_ADMIN capabilities in the
user namespace owning the IMA namespace. The processes from one IMA
namespace have access to the data from that namespace only. This mechanism
can be changed in the future. The one alternative is to create per IMA
namespace entries, similar to the AppArmour file system.

This work is inspired by Stefan Berger's, Mehmet Kayaalp's, Yuqiong Sun's
and Mimi Zohar's series of patches:
https://lore.kernel.org/patchwork/cover/899419/

Patches are logically divided into 5 groups. That order is not yet
reflected in the commit order. This will be fixed as soon as possible.

1. Base mechanism for the IMA namespace; patches: 1-3, 6-8, 15

   Add a new IMA namespace. Add a new CLONE_NEWIMA flag. Create and
   configure IMA analogously to the time namespace, using the intermediate
   ima_ns_for_children. Add the IMA namespace to the IMA subsystem API.

   Create a list of active IMA namespaces.

   Add a reader counter to the integrity inode data to detect violations
   correctly.

2. Policy; patches: 4, 5, 9, 18, 20-22

   Replace global policy data with the per IMA namespace policies.

   Record read-write violations (ToMToU, open-writer) across namespaces.
   Record modifications to the files shared across containers when the
   files are freed.

   Set the owning user namespace of the IMA namespace, to the user
   namespace of the first process born into the new IMA namespace.

   Remap IDs in the policy rules, if the rules were loaded before the user
   namespace mapping was defined.

3. IMA-measurement; patches: 10-14, 17, 29

   Link measurement list entries to the respective IMA namespaces using
   the IMA namespace ID. Include the namespace ID in the digest entry
   lookup.

   Add a new measurement list template that includes IMA namespace ID.

   Add a dummy boot aggregate entry for non-root IMA namespaces.

   Show the measurement list data only for the IMA namespace the process
   belongs to, unless it is the root IMA namespace.

4. IMA-appraisal; patches: 23-28

   Modify keyring search mechanism to include the key domain tag in the
   search criteria for both, direct lookup and the iterative search. Allow
   to set the key domain tag separately from the key type using the
   KEY_ALLOC* flags.

   Add the key domain to the IMA namespace, so that the key is linked to
   the namespace.

   Add the key domain tag to the integrity module's API. Use the new API
   to load the IMA namespace's key to the system IMA keyring.

5. Configuration; patches: 16, 19, 30

   Add the new entries in the IMA securityfs directory. Parse and validate
   configuration data. Apply the new configuration when the first process
   is born in the new IMA namespace.

   Extend read/write permissions to the IMA securityfs entries to the
   other users not in the file's group 'o'. Allow access only to the users
   that have the SYS_ADMIN caps in the user namespace owning the given IMA
   namespace.

Krzysztof Struczynski (30):
  ima: Introduce ima namespace
  ima: Add a list of the installed ima namespaces
  ima: Bind ima namespace to the file descriptor
  ima: Add ima policy related data to the ima namespace
  ima: Add methods for parsing ima policy configuration string
  ima: Add ima namespace to the ima subsystem APIs
  ima: Extend the APIs in the integrity subsystem
  ima: Add integrity inode related data to the ima namespace
  ima: Enable per ima namespace policy settings
  ima: Add ima namespace ID to the ima ML related structures
  ima: Keep track of the measurment list per ima namespace
  ima: Check ima namespace ID during digest entry lookup
  ima: Add a new ima template that includes namespace ID
  ima: Add per namespace view of the measurement list
  ima: Add a reader counter to the integrity inode data
  ima: Extend permissions to the ima securityfs entries
  ima: Add the violation counter to the namespace
  ima: Change the owning user namespace of the ima namespace if
    necessary
  ima: Configure the new ima namespace from securityfs
  ima: Parse per ima namespace policy file
  user namespace: Add function that checks if the UID map is defined
  ima: Remap IDs of subject based rules if necessary
  keys: Add domain tag to the keyring search criteria
  keys: Include key domain tag in the iterative search
  keys: Allow to set key domain tag separately from the key type
  ima: Add key domain to the ima namespace
  integrity: Add key domain tag to the search criteria
  ima: Load per ima namespace x509 certificate
  ima: Add dummy boot aggregate to per ima namespace measurement list
  ima: Set ML template per ima namespace

 crypto/asymmetric_keys/asymmetric_type.c     |  20 +-
 fs/file_table.c                              |   6 +-
 fs/proc/namespaces.c                         |   4 +
 include/linux/digsig.h                       |  11 +-
 include/linux/fs.h                           |   3 +
 include/linux/ima.h                          |  99 ++-
 include/linux/integrity.h                    |  31 +
 include/linux/key-type.h                     |   1 +
 include/linux/key.h                          |  27 +-
 include/linux/nsproxy.h                      |   3 +
 include/linux/proc_ns.h                      |   5 +-
 include/linux/user_namespace.h               |   7 +
 include/uapi/linux/sched.h                   |   1 +
 init/Kconfig                                 |  12 +
 kernel/fork.c                                |  24 +-
 kernel/kexec_file.c                          |   7 +
 kernel/nsproxy.c                             |  34 +-
 kernel/ucount.c                              |   1 +
 kernel/user_namespace.c                      |  11 +
 lib/digsig.c                                 |  11 +-
 security/integrity/digsig.c                  |  46 +-
 security/integrity/digsig_asymmetric.c       |  20 +-
 security/integrity/iint.c                    | 126 +++-
 security/integrity/ima/Makefile              |   1 +
 security/integrity/ima/ima.h                 | 134 +++-
 security/integrity/ima/ima_api.c             |  31 +-
 security/integrity/ima/ima_appraise.c        | 105 ++-
 security/integrity/ima/ima_asymmetric_keys.c |  12 +-
 security/integrity/ima/ima_fs.c              | 272 ++++++-
 security/integrity/ima/ima_init.c            |  47 +-
 security/integrity/ima/ima_kexec.c           |   4 +-
 security/integrity/ima/ima_main.c            | 323 +++++++--
 security/integrity/ima/ima_ns.c              | 718 +++++++++++++++++++
 security/integrity/ima/ima_policy.c          | 397 +++++++---
 security/integrity/ima/ima_queue.c           |  69 +-
 security/integrity/ima/ima_queue_keys.c      |  11 +-
 security/integrity/ima/ima_template.c        |  44 +-
 security/integrity/ima/ima_template_lib.c    |  13 +
 security/integrity/ima/ima_template_lib.h    |   2 +
 security/integrity/integrity.h               |  42 +-
 security/keys/key.c                          |  20 +
 security/keys/keyring.c                      |  25 +-
 security/security.c                          |   2 +-
 43 files changed, 2405 insertions(+), 377 deletions(-)
 create mode 100644 security/integrity/ima/ima_ns.c


base-commit: fc80c51fd4b23ec007e88d4c688f2cac1b8648e7
prerequisite-patch-id: 409c4abf4ee18e7d43eda995ff0db7879d3d0f5c
-- 
2.20.1

