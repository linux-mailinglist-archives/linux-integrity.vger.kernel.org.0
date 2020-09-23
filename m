Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E7422760E9
	for <lists+linux-integrity@lfdr.de>; Wed, 23 Sep 2020 21:20:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726665AbgIWTUU (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 23 Sep 2020 15:20:20 -0400
Received: from linux.microsoft.com ([13.77.154.182]:47346 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726613AbgIWTUU (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 23 Sep 2020 15:20:20 -0400
Received: from tusharsu-Ubuntu.lan (c-71-197-163-6.hsd1.wa.comcast.net [71.197.163.6])
        by linux.microsoft.com (Postfix) with ESMTPSA id B023520B7179;
        Wed, 23 Sep 2020 12:20:18 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B023520B7179
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1600888819;
        bh=R6rtlwYSLTn3XJr2MjHNNQ7fwXEqS/pbLD3EewSk0QM=;
        h=From:To:Cc:Subject:Date:From;
        b=Ewsv64sJvwVeKq7RrxP7q1/c4ez0XN0Zndk2P22OObEO57z8YoVA+m8iSCo3X16L2
         BLvcVSpgCE94uNzb1Fr8DfPDIy2q1RNeF7Aq53W0c0WoIwLjIgNU0roIqSJQWd2UOR
         +kIFuxXS3W12SBNkL+EoxxRL9FRixkkdje4DtQ1w=
From:   Tushar Sugandhi <tusharsu@linux.microsoft.com>
To:     zohar@linux.ibm.com, stephen.smalley.work@gmail.com,
        casey@schaufler-ca.com, agk@redhat.com, snitzer@redhat.com,
        gmazyland@gmail.com
Cc:     tyhicks@linux.microsoft.com, sashal@kernel.org, jmorris@namei.org,
        nramas@linux.microsoft.com, linux-integrity@vger.kernel.org,
        selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dm-devel@redhat.com
Subject: [PATCH v4 0/6] IMA: Infrastructure for measurement of critical kernel data
Date:   Wed, 23 Sep 2020 12:20:05 -0700
Message-Id: <20200923192011.5293-1-tusharsu@linux.microsoft.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

There are several kernel components that contain critical data which if
accidentally or maliciously altered, can compromise the security of the
kernel. Example of such components would include LSMs like SELinux, or
AppArmor; or device-mapper targets like dm-crypt, dm-verity etc.

Many of these components do not use the capabilities provided by kernel
integrity subsystem (IMA), and thus they don't use the benefits of
extended TPM PCR quotes and ultimately the benefits of remote attestation.

This series bridges this gap, so that potential kernel components that
contain data critical to the security of the kernel could take advantage
of IMA's measuring and quoting abilities - thus ultimately enabling
remote attestation for their specific data.

System administrators may want to pick and choose which kernel
components they would want to enable for measurements, quoting, and
remote attestation. To enable that, a new IMA policy is introduced.

And lastly, the functionality is exposed through a function
ima_measure_critical_data(). The functionality is generic enough to
measure the data of any kernel component at run-time. To ensure that
only data from supported sources are measured, the kernel component
needs to be added to a compile-time list of supported sources (an
"allowed list of components"). IMA validates the source passed to
ima_measure_critical_data() against this allowed list at run-time.

This series is based on the following repo/branch:

 repo: https://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git
 branch: next-integrity
 commit aa662fc04f5b ("ima: Fix NULL pointer dereference in ima_file_hash")
        
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


Tushar Sugandhi (6):
  IMA: generalize keyring specific measurement constructs
  IMA: conditionally allow empty rule data
  IMA: update process_buffer_measurement to measure buffer hash
  IMA: add policy to measure critical data from kernel components
  IMA: add hook to measure critical data from kernel components
  IMA: validate supported kernel data sources before measurement

 Documentation/ABI/testing/ima_policy         |  11 +-
 include/linux/ima.h                          |   8 ++
 security/integrity/ima/ima.h                 |  37 ++++++-
 security/integrity/ima/ima_api.c             |   8 +-
 security/integrity/ima/ima_appraise.c        |   2 +-
 security/integrity/ima/ima_asymmetric_keys.c |   2 +-
 security/integrity/ima/ima_main.c            |  61 ++++++++++-
 security/integrity/ima/ima_policy.c          | 101 +++++++++++++++----
 security/integrity/ima/ima_queue_keys.c      |   3 +-
 9 files changed, 196 insertions(+), 37 deletions(-)

-- 
2.17.1

