Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7581A243DFB
	for <lists+linux-integrity@lfdr.de>; Thu, 13 Aug 2020 19:07:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726567AbgHMRHN (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 13 Aug 2020 13:07:13 -0400
Received: from linux.microsoft.com ([13.77.154.182]:35144 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726531AbgHMRHN (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 13 Aug 2020 13:07:13 -0400
Received: from localhost.localdomain (c-73-42-176-67.hsd1.wa.comcast.net [73.42.176.67])
        by linux.microsoft.com (Postfix) with ESMTPSA id 58C3320B4908;
        Thu, 13 Aug 2020 10:07:12 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 58C3320B4908
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1597338432;
        bh=95DHsEY9CvdiB/9545nRyHvogwn3Q7Z8Te8xzKAiku0=;
        h=From:To:Cc:Subject:Date:From;
        b=RnDb9jeBbiFZ60zJ1pesR5FvnWnOixiSe57xx+0IUycLp91wLOXMuRRuDy+ESuRsn
         mtT793uhNd8QAOpmM4dxG4CuMMpKzcOm9H34IwORrt6xK5Ks/ckGkpGH9nfTK60Mlf
         Xo3YGfM5dEu6hiKGijrwAwdAiRFyK5fLwAZAitC4=
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
To:     zohar@linux.ibm.com, stephen.smalley.work@gmail.com,
        casey@schaufler-ca.com
Cc:     tyhicks@linux.microsoft.com, tusharsu@linux.microsoft.com,
        sashal@kernel.org, jmorris@namei.org,
        linux-integrity@vger.kernel.org, selinux@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] SELinux: Measure state and hash of policy using IMA
Date:   Thu, 13 Aug 2020 10:07:05 -0700
Message-Id: <20200813170707.2659-1-nramas@linux.microsoft.com>
X-Mailer: git-send-email 2.28.0
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

This change aims to address measuring critical data structures of
SELinux when they are initialized and when they are updated at runtime.

This series is based on commit 3db0d0c276a7 ("integrity: remove
redundant initialization of variable ret") in next-integrity

This series also has a dependency on the following patch series and
should be applied in the following order:
 https://patchwork.kernel.org/patch/11709527/
 https://patchwork.kernel.org/patch/11711249/


Lakshmi Ramasubramanian (2):
  IMA: Handle early boot data measurement
  SELinux: Measure state and hash of policy using IMA

 security/integrity/ima/Kconfig               |   5 +-
 security/integrity/ima/Makefile              |   2 +-
 security/integrity/ima/ima.h                 |  37 ++--
 security/integrity/ima/ima_asymmetric_keys.c |   6 +-
 security/integrity/ima/ima_init.c            |   2 +-
 security/integrity/ima/ima_main.c            |   9 +
 security/integrity/ima/ima_policy.c          |   2 +-
 security/integrity/ima/ima_queue_data.c      | 190 +++++++++++++++++
 security/integrity/ima/ima_queue_keys.c      | 174 ----------------
 security/selinux/Makefile                    |   2 +
 security/selinux/hooks.c                     |   1 +
 security/selinux/include/security.h          |  15 ++
 security/selinux/measure.c                   | 204 +++++++++++++++++++
 security/selinux/selinuxfs.c                 |   3 +
 security/selinux/ss/services.c               |  71 ++++++-
 15 files changed, 516 insertions(+), 207 deletions(-)
 create mode 100644 security/integrity/ima/ima_queue_data.c
 delete mode 100644 security/integrity/ima/ima_queue_keys.c
 create mode 100644 security/selinux/measure.c

-- 
2.28.0

