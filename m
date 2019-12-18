Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4CAC2124E2A
	for <lists+linux-integrity@lfdr.de>; Wed, 18 Dec 2019 17:44:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727459AbfLRQol (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 18 Dec 2019 11:44:41 -0500
Received: from linux.microsoft.com ([13.77.154.182]:45124 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726955AbfLRQol (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 18 Dec 2019 11:44:41 -0500
Received: from nramas-ThinkStation-P520.corp.microsoft.com (unknown [131.107.174.108])
        by linux.microsoft.com (Postfix) with ESMTPSA id CAE152008713;
        Wed, 18 Dec 2019 08:44:39 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com CAE152008713
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1576687479;
        bh=a7xuBf5Ive82IP27XtSElh0HyfR+06ON7XFvftGE0Wc=;
        h=From:To:Cc:Subject:Date:From;
        b=GbISrtFcZTdmutO/nY95S0wpsX1WmzMUNz9/YnYqFPAbjtRYExPALZudQsVOhLJoC
         MI/Zb169RO5tKVTqAgUJzr2e/in2T55u4v/3JKIR8nMQKb5ZRFFNAHgHcPpFggb2c7
         Uhwj2XWlBvhPBGzkILYNQla1dTqnY6Y0UrZct2Ro=
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
To:     zohar@linux.ibm.com, James.Bottomley@HansenPartnership.com,
        linux-integrity@vger.kernel.org
Cc:     eric.snowberg@oracle.com, dhowells@redhat.com,
        mathew.j.martineau@linux.intel.com, matthewgarrett@google.com,
        sashal@kernel.org, jamorris@linux.microsoft.com,
        linux-kernel@vger.kernel.org, keyrings@vger.kernel.org
Subject: [PATCH v5 0/2] IMA: Deferred measurement of keys
Date:   Wed, 18 Dec 2019 08:44:32 -0800
Message-Id: <20191218164434.2877-1-nramas@linux.microsoft.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

This patchset extends the previous version[1] by adding support for
deferred processing of keys.

With the patchset referenced above, the IMA subsystem supports
measuring asymmetric keys when the key is created or updated.
But keys created or updated before a custom IMA policy is loaded
are currently not measured. This includes keys added to, for instance,
.builtin_trusted_keys which happens early in the boot process.

This change adds support for queuing keys created or updated before
a custom IMA policy is loaded. The queued keys are processed when
a custom policy is loaded. Keys created or updated after a custom policy
is loaded are measured immediately (not queued).

If the kernel is built with both CONFIG_IMA and
CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE enabled then the IMA policy
must be applied as a custom policy. Not providing a custom policy
in the above configuration would result in asymmeteric keys being queued
until a custom policy is loaded. This is by design.

[1] https://lore.kernel.org/linux-integrity/20191211164707.4698-1-nramas@linux.microsoft.com/

Testing performed:

  * Booted the kernel with this change.
  * Added .builtin_trusted_keys in "keyrings=" option in
    the IMA policy and verified the keys added to this
    keyring are measured.
  * Specified only func=KEY_CHECK and not "keyrings=" option,
    and verified the keys added to builtin_trusted_keys keyring
    are processed.
  * Added keys at runtime and verified they are measured
    if the IMA policy permitted.
      => For example, added keys to .ima keyring and verified.

Changelog:

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

Lakshmi Ramasubramanian (2):
  IMA: Define workqueue for early boot key measurements
  IMA: Call workqueue functions to measure queued keys

 security/integrity/ima/ima.h                 |  15 +++
 security/integrity/ima/ima_asymmetric_keys.c | 123 +++++++++++++++++++
 security/integrity/ima/ima_policy.c          |   3 +
 3 files changed, 141 insertions(+)

-- 
2.17.1

