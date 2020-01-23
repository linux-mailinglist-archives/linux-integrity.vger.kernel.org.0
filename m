Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A3B0314605B
	for <lists+linux-integrity@lfdr.de>; Thu, 23 Jan 2020 02:32:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726083AbgAWBcM (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 22 Jan 2020 20:32:12 -0500
Received: from linux.microsoft.com ([13.77.154.182]:55864 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725911AbgAWBcM (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 22 Jan 2020 20:32:12 -0500
Received: from nramas-ThinkStation-P520.corp.microsoft.com (unknown [131.107.174.108])
        by linux.microsoft.com (Postfix) with ESMTPSA id 6D9312007679;
        Wed, 22 Jan 2020 17:32:11 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 6D9312007679
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1579743131;
        bh=ybWxbWJoAxOFI4m8oIsd6jXbfNUgRqtqlDATjCgMlmU=;
        h=From:To:Cc:Subject:Date:From;
        b=Wx32loep/PQbGBJCJMpl4SSFtw0ajmJK1+12g90t4qz/dOwq8Hf5AyX2HK35jh17b
         bzAuCdFHg69SSBjS2EGc2pS9tLhS8nwATJ7n+7z20u4aahzahugYe8tE8dfrlyfSBn
         nmZbAIj7Qgl4gfFpcJJrxxk3fgXkN46mI39exC8U=
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
To:     zohar@linux.ibm.com, James.Bottomley@HansenPartnership.com,
        linux-integrity@vger.kernel.org
Cc:     sashal@kernel.org, dhowells@redhat.com,
        linux-kernel@vger.kernel.org, keyrings@vger.kernel.org
Subject: [PATCH v9 0/3] IMA: Deferred measurement of keys
Date:   Wed, 22 Jan 2020 17:32:03 -0800
Message-Id: <20200123013206.8499-1-nramas@linux.microsoft.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

The IMA subsystem supports measuring asymmetric keys when the key is
created or updated[1]. But keys created or updated before a custom IMA
policy is loaded are currently not measured.  This includes keys added,
for instance, to either the .ima or .builtin_trusted_keys keyrings, which
happens early in the boot process.

Measuring the early boot keys, by design, requires loading a custom IMA
policy.  This change adds support for queuing keys created or updated
before a custom IMA policy is loaded.  The queued keys are processed when
a custom policy is loaded.  Keys created or updated after a custom policy
is loaded are measured immediately (not queued).  In the case when a
custom policy is not loaded within 5 minutes of IMA initialization, the
queued keys are freed.

[1] https://lore.kernel.org/linux-integrity/20191211164707.4698-1-nramas@linux.microsoft.com/

Changelog:

  v9

  => Rebased the changes to v5.5-rc7
  => Defined an intermediate Kconfig boolean option namely
     IMA_QUEUE_EARLY_BOOT_KEYS to declare the deferred key
     measurement functions.
  => Use delayed workqueue to free the queued keys when a custom IMA
     policy is not loaded.

  v8

  => Rebased the changes to linux-next
  => Need to apply the following patch first
  https://lore.kernel.org/linux-integrity/20200108160508.5938-1-nramas@linux.microsoft.com/

  v7

  => Updated cover letter per Mimi's suggestions.
  => Updated "Reported-by" tag to be specific about
     the issues fixed in the patch.

  v6

  => Replaced mutex with a spinlock to sychronize access to
     queued keys. This fixes the problem reported by
     "kernel test robot <rong.a.chen@intel.com>"
     https://lore.kernel.org/linux-integrity/2a831fe9-30e5-63b4-af10-a69f327f7fb7@linux.microsoft.com/T/#t
  => Changed ima_queue_key() to a static function. This fixes
     the issue reported by "kbuild test robot <lkp@intel.com>"
     https://lore.kernel.org/linux-integrity/1577370464.4487.10.camel@linux.ibm.com/
  => Added the patch to free the queued keys if a custom IMA policy
     was not loaded to this patch set.

  v5

  => Removed temp keys list in ima_process_queued_keys()

  v4

  => Check and set ima_process_keys flag with mutex held.

  v3

  => Defined ima_process_keys flag to be static.
  => Set ima_process_keys with ima_keys_mutex held.
  => Added a comment in ima_process_queued_keys() function
     to state the use of temporary list for keys.

  v2

  => Rebased the changes to v5.5-rc1
  => Updated function names, variable names, and code comments
     to be less verbose.

  v1

  => Code cleanup

  v0

  => Based changes on v5.4-rc8
  => The following patchsets should be applied in that order
     https://lore.kernel.org/linux-integrity/1572492694-6520-1-git-send-email-zohar@linux.ibm.com
     https://lore.kernel.org/linux-integrity/20191204224131.3384-1-nramas@linux.microsoft.com/
  => Added functions to queue and dequeue keys, and process
     the queued keys when custom IMA policies are applied.

Lakshmi Ramasubramanian (3):
  IMA: Define workqueue for early boot key measurements
  IMA: Call workqueue functions to measure queued keys
  IMA: Defined delayed workqueue to free the queued keys

 security/integrity/ima/Kconfig               |   5 +
 security/integrity/ima/Makefile              |   1 +
 security/integrity/ima/ima.h                 |  24 +++
 security/integrity/ima/ima_asymmetric_keys.c |   8 +
 security/integrity/ima/ima_init.c            |   8 +-
 security/integrity/ima/ima_policy.c          |   3 +
 security/integrity/ima/ima_queue_keys.c      | 171 +++++++++++++++++++
 7 files changed, 219 insertions(+), 1 deletion(-)
 create mode 100644 security/integrity/ima/ima_queue_keys.c

-- 
2.17.1

