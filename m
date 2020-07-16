Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A4A0222A3B
	for <lists+linux-integrity@lfdr.de>; Thu, 16 Jul 2020 19:45:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729422AbgGPRoE (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 16 Jul 2020 13:44:04 -0400
Received: from linux.microsoft.com ([13.77.154.182]:54454 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727844AbgGPRoD (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 16 Jul 2020 13:44:03 -0400
Received: from localhost.localdomain (c-73-42-176-67.hsd1.wa.comcast.net [73.42.176.67])
        by linux.microsoft.com (Postfix) with ESMTPSA id AB67F20B4909;
        Thu, 16 Jul 2020 10:44:02 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com AB67F20B4909
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1594921442;
        bh=MdDEgRa6UippolxJcPeM/hQSOUKo4WoMK9t77dGEGj4=;
        h=From:To:Cc:Subject:Date:From;
        b=Sizm3BjAMdT+PRCjC/4fBmtejMVd9kz3DIU9iy2Q4czaTO87PTmEixfWJ9pEmrdht
         yqFEEOJb6ZH3+z7G+dVldRusRL+U5fXKxiMoqbrPjyTHVG91aV96s59BavSqRZxUmx
         MhnjQz01m6B4uHKYOpLg1WqoWO+ODELcOKmUNmXQ=
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
To:     zohar@linux.ibm.com, stephen.smalley.work@gmail.com,
        casey@schaufler-ca.com
Cc:     jmorris@namei.org, linux-integrity@vger.kernel.org,
        selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/5] LSM: Measure security module state
Date:   Thu, 16 Jul 2020 10:43:46 -0700
Message-Id: <20200716174351.20128-1-nramas@linux.microsoft.com>
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
malware by exploiting Kernel vulnerabilities or modified through some
inadvertent actions on the system. Measuring such critical data would
enable an attestation service to better assess the state of the system.

IMA subsystem measures system files, command line arguments passed to
kexec, boot aggregate, keys, etc. It can be used to measure critical
data structures of security modules as well.

This change aims to address measuring critical data structures
of security modules when they are initialized, when they are updated
at runtime, and also periodically to detect any tampering.

This change set is based off of Linux Kernel version 5.8-rc5.

The following patch needs to be applied first before applying
the patches in this patch set:

    https://patchwork.kernel.org/patch/11612989/

Change log:

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

Lakshmi Ramasubramanian (5):
  IMA: Add LSM_STATE func to measure LSM data
  IMA: Define an IMA hook to measure LSM data
  LSM: Add security_measure_data in lsm_info struct
  LSM: Define SELinux function to measure security state
  LSM: Define workqueue for measuring security module state

 Documentation/ABI/testing/ima_policy |   6 +-
 include/linux/ima.h                  |   4 +
 include/linux/lsm_hooks.h            |   3 +
 security/integrity/ima/ima.h         |   1 +
 security/integrity/ima/ima_api.c     |   2 +-
 security/integrity/ima/ima_main.c    |  17 +++
 security/integrity/ima/ima_policy.c  |  29 ++++-
 security/security.c                  |  74 ++++++++++++-
 security/selinux/Makefile            |   2 +
 security/selinux/hooks.c             |   4 +
 security/selinux/include/security.h  |  26 +++++
 security/selinux/measure.c           | 158 +++++++++++++++++++++++++++
 security/selinux/selinuxfs.c         |   1 +
 security/selinux/ss/services.c       |  66 +++++++++--
 14 files changed, 376 insertions(+), 17 deletions(-)
 create mode 100644 security/selinux/measure.c

-- 
2.27.0

