Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B04F279A7A
	for <lists+linux-integrity@lfdr.de>; Sat, 26 Sep 2020 17:52:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729722AbgIZPwZ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sat, 26 Sep 2020 11:52:25 -0400
Received: from linux.microsoft.com ([13.77.154.182]:54114 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725208AbgIZPwY (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 26 Sep 2020 11:52:24 -0400
Received: from localhost.localdomain (c-73-42-176-67.hsd1.wa.comcast.net [73.42.176.67])
        by linux.microsoft.com (Postfix) with ESMTPSA id F21CA20B7178;
        Sat, 26 Sep 2020 08:52:23 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com F21CA20B7178
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1601135544;
        bh=dOXzAiTlwjJdsSlMcZPnNWnWoLZ5/Ww2sAa0YGXf7VA=;
        h=From:To:Cc:Subject:Date:From;
        b=iAUJajNR7L4kc+FbAQqbCviW9e7QjEoDcpFms6n2wTBVVhZWMTjaOHYZly96L0YhF
         pupZFiiTC4inAZIrcUdI5x9O6y1gcVGUlvWPzhUemYzK8eB04a9oSwS7fdWMlfIBGr
         HVj+WZXi5EYC6azMi0/JNyFPB85j3GxncjColhDk=
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
To:     zohar@linux.ibm.com
Cc:     tyhicks@linux.microsoft.com, tusharsu@linux.microsoft.com,
        sashal@kernel.org, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/3] IMA: Generalize early boot data measurement
Date:   Sat, 26 Sep 2020 08:52:16 -0700
Message-Id: <20200926155219.5561-1-nramas@linux.microsoft.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

The current implementation of early boot measurement in the IMA
subsystem is specific to asymmetric keys. It does not handle
early boot measurement of data from other subsystems such as
Linux Security Module (LSM), Device-Mapper, etc. As a result, data
provided by these subsystems during system boot are not measured by IMA.

This patch series makes the early boot key measurement functions generic
such that they can be used to measure any early boot data. The functions
in ima_queue_keys.c are refactored to a new file ima_queue_data.c.
The kernel configuration CONFIG_IMA_QUEUE_EARLY_BOOT_KEYS is removed
and instead a new function namely ima_queuing_enabled() is added to
check if the subsystems using early boot data measurement are enabled.
Since measurement of asymmetric keys is the first consumer of early
boot measurement, enable queuing if CONFIG_IMA_MEASURE_ASYMMETRIC_KEYS
and CONFIG_SYSTEM_TRUSTED_KEYRING are both enabled.

The IMA hook to measure kernel critical data ima_measure_critical_data()
is updated to utilize early boot measurement support.

This series is based on the following repo/branch:
 https://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git
 branch: next-integrity
 commit aa662fc04f5b ("ima: Fix NULL pointer dereference in ima_file_hash") 

This patch is dependent on the following patch series:
	https://patchwork.kernel.org/patch/11795559/

Lakshmi Ramasubramanian (3):
  IMA: Generalize early boot measurement of asymmetric keys
  IMA: Support measurement of generic data during early
  IMA: Support early boot measurement of critical data

 security/integrity/ima/Kconfig               |   6 -
 security/integrity/ima/Makefile              |   3 +-
 security/integrity/ima/ima.h                 |  29 ++-
 security/integrity/ima/ima_asymmetric_keys.c |   7 +-
 security/integrity/ima/ima_init.c            |   2 +-
 security/integrity/ima/ima_main.c            |  10 +
 security/integrity/ima/ima_policy.c          |   2 +-
 security/integrity/ima/ima_queue_data.c      | 200 +++++++++++++++++++
 security/integrity/ima/ima_queue_keys.c      | 175 ----------------
 9 files changed, 229 insertions(+), 205 deletions(-)
 create mode 100644 security/integrity/ima/ima_queue_data.c
 delete mode 100644 security/integrity/ima/ima_queue_keys.c

-- 
2.28.0

