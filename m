Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE9FE2D4AE5
	for <lists+linux-integrity@lfdr.de>; Wed,  9 Dec 2020 20:49:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387885AbgLITnF (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 9 Dec 2020 14:43:05 -0500
Received: from linux.microsoft.com ([13.77.154.182]:47428 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387871AbgLITnE (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 9 Dec 2020 14:43:04 -0500
Received: from tusharsu-Ubuntu.lan (c-71-197-163-6.hsd1.wa.comcast.net [71.197.163.6])
        by linux.microsoft.com (Postfix) with ESMTPSA id 10D4220B717A;
        Wed,  9 Dec 2020 11:42:22 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 10D4220B717A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1607542942;
        bh=Zr4aBdcUR5WHi+qPdkh15pCn3FZfZd01vCUp9B+ZYDU=;
        h=From:To:Cc:Subject:Date:From;
        b=Eo89UdhJglMuGxPxIwfsM2YQYWI3W0lOkZySOtWUPTbU6x3u7c35q9fJsUOytpaAJ
         yvD8wSW9Mwv9gXpqCz96Dt3YDP6oWrOIoRv5CIAsP994Wl2yhJ7RYwPyAVBWl+eACs
         3WMO9/Syr2d2oXQaalun96JueEQhwwwo76Q3hd8w=
From:   Tushar Sugandhi <tusharsu@linux.microsoft.com>
To:     zohar@linux.ibm.com, stephen.smalley.work@gmail.com,
        casey@schaufler-ca.com, agk@redhat.com, snitzer@redhat.com,
        gmazyland@gmail.com, paul@paul-moore.com
Cc:     tyhicks@linux.microsoft.com, sashal@kernel.org, jmorris@namei.org,
        nramas@linux.microsoft.com, linux-integrity@vger.kernel.org,
        selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dm-devel@redhat.com
Subject: [PATCH v7 0/8] IMA: support for measuring kernel integrity critical data
Date:   Wed,  9 Dec 2020 11:42:04 -0800
Message-Id: <20201209194212.5131-1-tusharsu@linux.microsoft.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

IMA measures files and buffer data such as keys, command-line arguments
passed to the kernel on kexec system call, etc. While these measurements
are necessary for monitoring and validating the integrity of the system,
they are not sufficient. Various data structures, policies, and states
stored in kernel memory also impact the integrity of the system.
Several kernel subsystems contain such integrity critical data -
e.g. LSMs like SELinux, AppArmor etc. or device-mapper targets like
dm-crypt, dm-verity, dm-integrity etc. These kernel subsystems help
protect the integrity of a device. Their integrity critical data is not
expected to change frequently during run-time. Some of these structures
cannot be defined as __ro_after_init, because they are initialized later.

For a given device, various external services/infrastructure tools
(including the attestation service) interact with it - both during the
setup and during rest of the device run-time. They share sensitive data
and/or execute critical workload on that device. The external services
may want to verify the current run-time state of the relevant kernel
subsystems before fully trusting the device with business critical
data/workload. For instance, verifying that SELinux is in "enforce" mode
along with the expected policy, disks are encrypted with a certain
configuration, secure boot is enabled etc.

This series provides the necessary IMA functionality for kernel
subsystems to ensure their configuration can be measured:
  - by kernel subsystems themselves,
  - in a tamper resistant way,
  - and re-measured - triggered on state/configuration change.

This patch set:
  - defines a new IMA hook ima_measure_critical_data() to measure
    integrity critical data,
  - limits the critical data being measured based on a label,
  - defines a builtin critical data measurement policy,
  - and includes an SELinux consumer of the new IMA critical data hook.

This series is based on the following repo/branch:

 repo: https://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git
 branch: next-integrity
 commit 207cdd565dfc ("ima: Don't modify file descriptor mode on the fly")

Change Log v7:    
Incorporated feedback from Mimi on v6 of this series.
 - Updated cover letter and patch descriptions as per Mimi's feedback.
 - Changed references to variable names and policy documentation from
   plural "data_sources" to singular "data_source".
 - Updated SELinux patch to measure only policy, instead of policy and
   state. The state measurement will be upstreamed through a separate
   patch.
 - Updated admin-guide/kernel-parameters.txt to document support for
   critical_data in builtin policy.

Change Log v6:
Incorporated feedback from Mimi on v5 of this series.
 - Got rid of patch 5 from the v5 of the series.(the allow list for data
   sources)
 - Updated function descriptions, changed variable names etc.
 - Moved the input param event_data_source in ima_measure_critical_data()
   to a new patch. (patch 6/8 of this series)
 - Split patch 4 from v5 of the series into two patches (patch 4/8 and 
   patch 5/8)
 - Updated cover letter and patch descriptions as per feedback.

Change Log v5:
(1) Incorporated feedback from Stephen on the last SeLinux patch.
 SeLinux Patch: https://patchwork.kernel.org/patch/11801585/
 - Freed memory in the reverse order of allocation in 
   selinux_measure_state().
 - Used scnprintf() instead of snprintf() to create the string for
   selinux state.
 - Allocated event name passed to ima_measure_critical_data() before
   gathering selinux state and policy information for measuring.

(2) Incorporated feedback from Mimi on v4 of this series.
 V4 of this Series: https://patchwork.kernel.org/project/linux-integrity/list/?series=354437

 - Removed patch "[v4,2/6] IMA: conditionally allow empty rule data"
 - Reversed the order of following patches.
      [v4,4/6] IMA: add policy to measure critical data from kernel components
      [v4,5/6] IMA: add hook to measure critical data from kernel components
   and renamed them to remove "from kernel components"
 - Added a new patch to this series - 
       IMA: add critical_data to built-in policy rules

 - Added the next version of SeLinux patch (mentioned above) to this
   series 
       selinux: measure state and hash of the policy using IMA

 - Updated cover-letter description to give broader perspective of the
   feature, rearranging paragraphs, removing unnecessary info, clarifying
   terms etc.
 - Got rid of opt_list param from ima_match_rule_data().
 - Updated the documentation to remove sources that don't yet exist.
 - detailed IMA hook description added to ima_measure_critical_data(),
   as well as elaborating terms event_name, event_data_source. 
 - "data_sources:=" is not a mandatory policy option for 
   func=CRITICAL_DATA anymore. If not present, all the data sources
   specified in __ima_supported_kernel_data_sources will be measured.


Lakshmi Ramasubramanian (2):
  IMA: define a builtin critical data measurement policy
  selinux: include a consumer of the new IMA critical data hook

Tushar Sugandhi (6):
  IMA: generalize keyring specific measurement constructs
  IMA: add support to measure buffer data hash
  IMA: define a hook to measure kernel integrity critical data
  IMA: add policy rule to measure critical data
  IMA: limit critical data measurement based on a label
  IMA: extend critical data hook to limit the measurement based on a
    label

 Documentation/ABI/testing/ima_policy          |   5 +-
 .../admin-guide/kernel-parameters.txt         |   5 +-
 include/linux/ima.h                           |   8 ++
 security/integrity/ima/ima.h                  |   8 +-
 security/integrity/ima/ima_api.c              |   8 +-
 security/integrity/ima/ima_appraise.c         |   2 +-
 security/integrity/ima/ima_asymmetric_keys.c  |   2 +-
 security/integrity/ima/ima_main.c             |  81 +++++++++++-
 security/integrity/ima/ima_policy.c           | 122 ++++++++++++++----
 security/integrity/ima/ima_queue_keys.c       |   3 +-
 security/selinux/Makefile                     |   2 +
 security/selinux/include/security.h           |  11 +-
 security/selinux/measure.c                    |  86 ++++++++++++
 security/selinux/ss/services.c                |  71 ++++++++--
 14 files changed, 364 insertions(+), 50 deletions(-)
 create mode 100644 security/selinux/measure.c

-- 
2.17.1

