Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92CC32B9E2A
	for <lists+linux-integrity@lfdr.de>; Fri, 20 Nov 2020 00:27:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726449AbgKSX0X (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 19 Nov 2020 18:26:23 -0500
Received: from linux.microsoft.com ([13.77.154.182]:32888 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726118AbgKSX0V (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 19 Nov 2020 18:26:21 -0500
Received: from tusharsu-Ubuntu.lan (c-71-197-163-6.hsd1.wa.comcast.net [71.197.163.6])
        by linux.microsoft.com (Postfix) with ESMTPSA id 16CDC20B717A;
        Thu, 19 Nov 2020 15:26:20 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 16CDC20B717A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1605828380;
        bh=dhlGnEZlGpNxq/A2IMzUae7PuZI1BlOtVKzTk5lmd1s=;
        h=From:To:Cc:Subject:Date:From;
        b=hWq0U1w8fiqVnTCLDdVLlNEBgB2TZllSK/m2fskO7R2e1ifrdJjHrRkbdrvTLJaek
         42D7skHa70nlzAJXPr802Ak0JXS2VrUufBD0A/zB00OiuhkVQVsb/0SpKOXxXrrLdM
         5xP5Z5oQdvw03JnleuaRqO0GRSH4vQ42ZcSYKfKo=
From:   Tushar Sugandhi <tusharsu@linux.microsoft.com>
To:     zohar@linux.ibm.com, stephen.smalley.work@gmail.com,
        casey@schaufler-ca.com, agk@redhat.com, snitzer@redhat.com,
        gmazyland@gmail.com, paul@paul-moore.com
Cc:     tyhicks@linux.microsoft.com, sashal@kernel.org, jmorris@namei.org,
        nramas@linux.microsoft.com, linux-integrity@vger.kernel.org,
        selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dm-devel@redhat.com
Subject: [PATCH v6 0/8] IMA: support for measuring kernel integrity critical data
Date:   Thu, 19 Nov 2020 15:26:03 -0800
Message-Id: <20201119232611.30114-1-tusharsu@linux.microsoft.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Kernel integrity critical data can be defined as the in-memory kernel
data which if accidentally or maliciously altered, can compromise the
integrity of the system.

There are several kernel subsystems that contain integrity critical
data - e.g. LSMs like SELinux, or AppArmor; or device-mapper targets
like dm-crypt, dm-verity etc. Examples of critical data could be kernel
in-memory r/o structures, hash of the memory structures, or data that
represents a linux kernel subsystem state.

This patch set defines a new IMA hook namely ima_measure_critical_data()
to measure the critical data. Kernel subsystems can use this
functionality, to take advantage of IMA's measuring and quoting 
abilities - thus ultimately enabling remote attestation for the
subsystem specific information stored in the kernel memory.

The functionality is generic enough to measure the data, from the kernel
subsystems, that is required to protect the integrity of the kernel at
runtime.

System administrators may want to limit the critical data being
measured, quoted, and attested. To enable that, a new IMA policy
condition is defined.

This patch set also addresses the need for measuring kernel critical
data early, before a custom IMA policy is loaded - by providing a
builtin IMA policy.

And lastly, the series provides the first consumer of the new IMA hook -
namely SeLinux.

This series is based on the following repo/branch:

 repo: https://github.com/torvalds/linux
 branch: master
 commit 09162bc32c88 ("Linux 5.10-rc4")

This series also has a dependency on the following patch
https://patchwork.kernel.org/patch/11901423/

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
  IMA: add a built-in policy rule for critical data measurement
  selinux: measure state and hash of the policy using IMA

Tushar Sugandhi (6):
  IMA: generalize keyring specific measurement constructs
  IMA: add support to measure buffer data hash
  IMA: define a hook to measure kernel integrity critical data
  IMA: add policy rule to measure critical data
  IMA: extend policy to add data sources as a critical data measurement
    constraint
  IMA: add support to critical data hook to limit data sources for
    measurement

 Documentation/ABI/testing/ima_policy         |  10 +-
 include/linux/ima.h                          |   8 +
 security/integrity/ima/ima.h                 |   8 +-
 security/integrity/ima/ima_api.c             |   8 +-
 security/integrity/ima/ima_appraise.c        |   2 +-
 security/integrity/ima/ima_asymmetric_keys.c |   2 +-
 security/integrity/ima/ima_main.c            |  81 +++++++++-
 security/integrity/ima/ima_policy.c          | 123 ++++++++++++---
 security/integrity/ima/ima_queue_keys.c      |   3 +-
 security/selinux/Makefile                    |   2 +
 security/selinux/hooks.c                     |   3 +
 security/selinux/include/security.h          |  11 +-
 security/selinux/measure.c                   | 157 +++++++++++++++++++
 security/selinux/selinuxfs.c                 |   8 +
 security/selinux/ss/services.c               |  71 +++++++--
 15 files changed, 448 insertions(+), 49 deletions(-)
 create mode 100644 security/selinux/measure.c

-- 
2.17.1

