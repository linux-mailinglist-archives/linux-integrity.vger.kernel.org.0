Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67233255E58
	for <lists+linux-integrity@lfdr.de>; Fri, 28 Aug 2020 18:00:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728374AbgH1QAs (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 28 Aug 2020 12:00:48 -0400
Received: from linux.microsoft.com ([13.77.154.182]:44728 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728187AbgH1QAe (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 28 Aug 2020 12:00:34 -0400
Received: from localhost.localdomain (c-73-42-176-67.hsd1.wa.comcast.net [73.42.176.67])
        by linux.microsoft.com (Postfix) with ESMTPSA id 1A8A520B7178;
        Fri, 28 Aug 2020 09:00:32 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 1A8A520B7178
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1598630432;
        bh=9nE+PsjwfQS+D6IahYRzHVUgseWRlLvBJtDDOfDrxAE=;
        h=From:To:Cc:Subject:Date:From;
        b=KyS3WibpFvtlwHm9qmDOeuHV6J8X1UW0M7WHcB4XY8VbYwqwghFXQ2/31MUX37SRx
         md4w+ZOsPBj5HS9qfAzMWriNx2XL/4H+jAMD9aKjxTx/fS0eckBshhUMr91wasM+cQ
         7IeDsrf6tl//9XoOpWnsKNz4F3V7QrTBrIByFF6k=
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
To:     zohar@linux.ibm.com, stephen.smalley.work@gmail.com,
        casey@schaufler-ca.com
Cc:     tyhicks@linux.microsoft.com, tusharsu@linux.microsoft.com,
        sashal@kernel.org, jmorris@namei.org,
        linux-integrity@vger.kernel.org, selinux@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/3] IMA: Generalize early boot data measurement
Date:   Fri, 28 Aug 2020 09:00:18 -0700
Message-Id: <20200828160021.11537-1-nramas@linux.microsoft.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

The current implementation of early boot measurement in the IMA
subsystem is very specific to asymmetric keys. It does not handle
early boot measurement of data from other subsystems such as
Linux Security Module (LSM), Device-Mapper, etc. As a result, data
provided by these subsystems during system boot are not measured by IMA.

This patch series makes the early boot key measurement functions generic
such that they can be used to measure any early boot data. The functions
in ima_queue_keys.c are refactored to a new file ima_queue_data.c.
The kernel configuration CONFIG_IMA_QUEUE_EARLY_BOOT_KEYS is renamed to
CONFIG_IMA_QUEUE_EARLY_BOOT_DATA so it can be used for enabling any
early boot data measurement. Since measurement of asymmetric keys is
the first consumer of early boot measurement, this kernel configuration
is enabled if IMA_MEASURE_ASYMMETRIC_KEYS and SYSTEM_TRUSTED_KEYRING are
both enabled.

The IMA hook to measure kernel critical data ima_measure_critical_data()
is updated to utilize early boot measurement support.

This series is based on the following repo/branch:
 repo: https://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git
 branch: next-integrity
 commit d012a7190fc1 ("Linux 5.9-rc2") 

This patch is dependent on the following patch series:
	https://patchwork.kernel.org/patch/11709527/
	https://patchwork.kernel.org/patch/11742047/

Change Log:
  v2:
    => Split the patches to first rename the file and functions,
       and then introduce new arguments, followed by adding queuing
       support in ima_measure_critical_data().

Lakshmi Ramasubramanian (3):
  IMA: Generalize early boot measurement of asymmetric keys
  IMA: Support measurement of generic data during early boot
  IMA: Support early boot measurement of critical data

 security/integrity/ima/Kconfig               |   2 +-
 security/integrity/ima/Makefile              |   2 +-
 security/integrity/ima/ima.h                 |  39 ++--
 security/integrity/ima/ima_asymmetric_keys.c |   7 +-
 security/integrity/ima/ima_init.c            |   2 +-
 security/integrity/ima/ima_main.c            |  10 +
 security/integrity/ima/ima_policy.c          |   2 +-
 security/integrity/ima/ima_queue_data.c      | 191 +++++++++++++++++++
 security/integrity/ima/ima_queue_keys.c      | 175 -----------------
 9 files changed, 232 insertions(+), 198 deletions(-)
 create mode 100644 security/integrity/ima/ima_queue_data.c
 delete mode 100644 security/integrity/ima/ima_queue_keys.c

-- 
2.28.0

