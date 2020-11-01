Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAE1A2A2214
	for <lists+linux-integrity@lfdr.de>; Sun,  1 Nov 2020 23:27:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727366AbgKAW0h (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 1 Nov 2020 17:26:37 -0500
Received: from linux.microsoft.com ([13.77.154.182]:41958 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727081AbgKAW0h (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 1 Nov 2020 17:26:37 -0500
Received: from tusharsu-Ubuntu.lan (c-71-197-163-6.hsd1.wa.comcast.net [71.197.163.6])
        by linux.microsoft.com (Postfix) with ESMTPSA id 18EAE20B4905;
        Sun,  1 Nov 2020 14:26:35 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 18EAE20B4905
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1604269595;
        bh=WKX3QB46xa8E3s1P7/tqGrnQWnDqQ2+xdJnkN9CdMlc=;
        h=From:To:Cc:Subject:Date:From;
        b=S2Y+i/ZgfC4U9KRX1JoQvlLoKBFHeEAd/HgpiLyAeHmE5Tb+SHaQsHAwsNV41dFLA
         Z8LdKsJG2shWC2gDRfK/e/ymri+ze5xJBV8Qlgpein5m3Gl4rIJD/nlaa0Qy4X8aIQ
         8p8W7/8eAqyS1JPK/Ql0IdOoho020345LjZqFU+Q=
From:   Tushar Sugandhi <tusharsu@linux.microsoft.com>
To:     zohar@linux.ibm.com, stephen.smalley.work@gmail.com,
        casey@schaufler-ca.com, agk@redhat.com, snitzer@redhat.com,
        gmazyland@gmail.com, paul@paul-moore.com
Cc:     tyhicks@linux.microsoft.com, sashal@kernel.org, jmorris@namei.org,
        nramas@linux.microsoft.com, linux-integrity@vger.kernel.org,
        selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dm-devel@redhat.com
Subject: [PATCH v5 0/7] IMA: Infrastructure for measurement of critical kernel data
Date:   Sun,  1 Nov 2020 14:26:19 -0800
Message-Id: <20201101222626.6111-1-tusharsu@linux.microsoft.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

There are several kernel subsystems that contain critical data which if
accidentally or maliciously altered, can compromise the integrity of the
system. Examples of such subsystems would include LSMs like SELinux, or
AppArmor; or device-mapper targets like dm-crypt, dm-verity etc. 
"critical data" in this context is kernel subsystem specific information
that is stored in kernel memory. Examples of critical data could be
kernel in-memory r/o structures, hash of the memory structures, or
data that represents a linux kernel subsystem state.

This patch set defines a new IMA hook namely CRITICAL_DATA, and a
function ima_measure_critical_data() - to measure the critical data. 
Kernel subsystems can use this functionality, to take advantage of IMA's
measuring and quoting abilities - thus ultimately enabling remote
attestation for the subsystem specific information stored in the kernel
memory.

The functionality is generic enough to measure the data of any kernel
subsystem at run-time. To ensure that only data from supported sources
are measured, the kernel subsystem needs to be added to a compile-time
list of supported sources (an "allowed list of components"). IMA
validates the source passed to ima_measure_critical_data() against this
allowed list at run-time.

System administrators may want to pick and choose which kernel
subsystem information they would want to enable for measurements,
quoting, and remote attestation. To enable that, a new IMA policy is
introduced.

This patch set also addresses the need for the kernel subsystems to
measure their data before a custom IMA policy is loaded - by providing
a builtin IMA policy.

And lastly, the use of the overall functionality is demonstrated by
measuring the kernel in-memory data for one such subsystem - SeLinux.

This series is based on the following repo/branch:

 repo: https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git
 branch: next
 commit 3650b228f83a ("Linux 5.10-rc1")


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

Change Log v4:
Incorporated feedback from Mimi on v3.
 - Split patch #1 into two patches to move introduction of bool
   allow_empty_opt_list into the 2nd patch.
 - Reverted return type of process_buffer_measurement() from int to void
   which got rid of patch #2 from the v3 of the series.
 - Renamed the policy "critical_kernel_data_sources" to "data_sources".
 - Updated process_buffer_measurement() to avoid code and variable
   duplication in the if(measure_buf_hash) block.
 - Changed return type of ima_measure_critical_data() from int to void.
 - Updated patch description for patch #3 and #4 as per Mimi's feedback.

Change Log v3:
Incorporated feedback from Mimi on v2.
 - Renamed the policy "data_sources" to
   "critical_kernel_data_sources".
 - Added "critical_kernel_data_sources" description in
   Documentation/ima-policy.
 - Split CRITICAL_DATA + critical_kernel_data_sources into two separate
   patches.
 - Merged hook ima_measure_critical_data() + CRITICAL_DATA into a single
   patch.
 - Added functionality to validate data sources before measurement.

Change Log v2:
 - Reverted the unnecessary indentations in existing #define.
 - Updated the description to replace the word 'enlightened' with
   'supported'.
 - Reverted the unnecessary rename of attribute size to buf_len.
 - Introduced a boolean parameter measure_buf_hash as per community
   feedback to support measuring hash of the buffer, instead of the
   buffer itself.

Lakshmi Ramasubramanian (2):
  IMA: add critical_data to the built-in policy rules
  selinux: measure state and hash of the policy using IMA

Tushar Sugandhi (5):
  IMA: generalize keyring specific measurement constructs
  IMA: update process_buffer_measurement to measure buffer hash
  IMA: add hook to measure critical data
  IMA: add policy to measure critical data
  IMA: validate supported kernel data sources before measurement

 Documentation/ABI/testing/ima_policy         |  10 +-
 include/linux/ima.h                          |   8 +
 security/integrity/ima/ima.h                 |  38 ++++-
 security/integrity/ima/ima_api.c             |   8 +-
 security/integrity/ima/ima_appraise.c        |   2 +-
 security/integrity/ima/ima_asymmetric_keys.c |   2 +-
 security/integrity/ima/ima_main.c            |  79 +++++++++-
 security/integrity/ima/ima_policy.c          | 143 ++++++++++++++---
 security/integrity/ima/ima_queue_keys.c      |   3 +-
 security/selinux/Makefile                    |   2 +
 security/selinux/hooks.c                     |   3 +
 security/selinux/include/security.h          |  11 +-
 security/selinux/measure.c                   | 157 +++++++++++++++++++
 security/selinux/selinuxfs.c                 |   9 ++
 security/selinux/ss/services.c               |  71 +++++++--
 15 files changed, 499 insertions(+), 47 deletions(-)
 create mode 100644 security/selinux/measure.c

-- 
2.17.1

