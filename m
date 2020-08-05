Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F87523C2AE
	for <lists+linux-integrity@lfdr.de>; Wed,  5 Aug 2020 02:44:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726515AbgHEAnh (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 4 Aug 2020 20:43:37 -0400
Received: from linux.microsoft.com ([13.77.154.182]:38356 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726166AbgHEAnh (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 4 Aug 2020 20:43:37 -0400
Received: from localhost.localdomain (c-73-42-176-67.hsd1.wa.comcast.net [73.42.176.67])
        by linux.microsoft.com (Postfix) with ESMTPSA id A3C9E20B4908;
        Tue,  4 Aug 2020 17:43:35 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A3C9E20B4908
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1596588215;
        bh=witi/8JgEwCGp4a82OugmSroOHn6fU6ZrDmuPHmc6HA=;
        h=From:To:Cc:Subject:Date:From;
        b=mbl18OTNOVFV4KGyTveIpOvWT76NAPgnoQTp+HNsvL+V1Wh93+uDm/iPpGQQx4MOP
         mvnPqk3lk3OLjyRIS86q00dUrKxDoFOJeS4pkvu5Ai18R5SgpHZCWwhZbg9hotxR2x
         raeuw5fP19jFqOUzgBbpWlpWXXCY0ibLeoVokZ5w=
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
To:     zohar@linux.ibm.com, stephen.smalley.work@gmail.com,
        casey@schaufler-ca.com
Cc:     tyhicks@linux.microsoft.com, sashal@kernel.org, jmorris@namei.org,
        linux-integrity@vger.kernel.org, selinux@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 0/4] LSM: Measure security module data
Date:   Tue,  4 Aug 2020 17:43:27 -0700
Message-Id: <20200805004331.20652-1-nramas@linux.microsoft.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Critical data structures of security modules are currently not measured.
Therefore an attestation service, for instance, would not be able to
attest whether the security modules are always operating with the policies
and configuration that the system administrator had setup. The policies
and configuration for the security modules could be tampered with by
malware by exploiting kernel vulnerabilities or modified through some
inadvertent actions on the system. Measuring such critical data would
enable an attestation service to better assess the state of the system.

IMA subsystem measures system files, command line arguments passed to
kexec, boot aggregate, keys, etc. It can be used to measure critical
data structures of security modules as well.

This change aims to address measuring critical data structures
of security modules when they are initialized and when they are
updated at runtime.

This series is based on commit 3db0d0c276a7 ("integrity: remove
redundant initialization of variable ret") in next-integrity

Change log:

  v6:
      => Use kvmalloc for payload data for early boot data measurement
         since payload size may exceed the limit supported by kmalloc.
      => Fixed IMA policy rule match error when checking for IMA hook
         func LSM_STATE and LSM_POLICY.
      => Enable early boot data measurement and IMA hook func
         LSM_STATE and LSM_POLICY when SELinux is enabled.

  v5:
      => Append timestamp to "event name" string in the call to
         the IMA hooks so that LSM data is always measured by IMA.
      => Removed workqueue patch that was handling periodic checking
         of the LSM data. This change will be introduced as a separate
         patch set while keeping this patch set focussed on measuring
         the LSM data on initialization and on updates at runtime.
      => Handle early boot measurement of LSM data.

  v4:
      => Added LSM_POLICY func and IMA hook to measure LSM policy.
      => Pass SELinux policy data, instead of the hash of the policy,
         to the IMA hook to measure.
      => Include "initialized" flag in SELinux measurement.
         Also, measure SELinux state even when initialization is not yet
         completed. But measure SELinux policy only after initialization.

  v3:
      => Loop through policy_capabilities to build the state data
         to measure instead of hardcoding to current set of
         policy capabilities.
      => Added error log messages for failure conditions.

  v2:
      => Pass selinux_state struct as parameter to the function
         that measures SELinux data.
      => Use strings from selinux_policycap_names array for SELinux
         state measurement.
      => Refactored security_read_policy() to alloc kernel or user
         virtual memory and then read the SELinux policy.

  v1:
      => Per Stephen Smalley's suggestion added selinux_state booleans
         and hash of SELinux policy in the measured data for SELinux.
      => Call IMA hook from the security module directly instead of
         redirecting through the LSM.

Lakshmi Ramasubramanian (4):
  IMA: Add func to measure LSM state and policy
  IMA: Define IMA hooks to measure LSM state and policy
  LSM: Define SELinux function to measure state and policy
  IMA: Handle early boot data measurement

 Documentation/ABI/testing/ima_policy         |   9 +
 include/linux/ima.h                          |  14 ++
 security/integrity/ima/Kconfig               |   5 +-
 security/integrity/ima/Makefile              |   2 +-
 security/integrity/ima/ima.h                 |  45 +++--
 security/integrity/ima/ima_api.c             |   2 +-
 security/integrity/ima/ima_asymmetric_keys.c |   6 +-
 security/integrity/ima/ima_init.c            |   2 +-
 security/integrity/ima/ima_main.c            |  64 ++++++-
 security/integrity/ima/ima_policy.c          |  36 +++-
 security/integrity/ima/ima_queue_data.c      | 190 +++++++++++++++++++
 security/integrity/ima/ima_queue_keys.c      | 174 -----------------
 security/selinux/Makefile                    |   2 +
 security/selinux/hooks.c                     |   1 +
 security/selinux/include/security.h          |  15 ++
 security/selinux/measure.c                   | 150 +++++++++++++++
 security/selinux/selinuxfs.c                 |   3 +
 security/selinux/ss/services.c               |  71 ++++++-
 18 files changed, 569 insertions(+), 222 deletions(-)
 create mode 100644 security/integrity/ima/ima_queue_data.c
 delete mode 100644 security/integrity/ima/ima_queue_keys.c
 create mode 100644 security/selinux/measure.c

-- 
2.27.0

