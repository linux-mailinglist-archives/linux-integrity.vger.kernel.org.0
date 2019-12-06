Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EEE9B114A80
	for <lists+linux-integrity@lfdr.de>; Fri,  6 Dec 2019 02:29:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726088AbfLFB3n (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 5 Dec 2019 20:29:43 -0500
Received: from linux.microsoft.com ([13.77.154.182]:47348 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725959AbfLFB3m (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 5 Dec 2019 20:29:42 -0500
Received: from nramas-ThinkStation-P520.corp.microsoft.com (unknown [131.107.174.108])
        by linux.microsoft.com (Postfix) with ESMTPSA id EE1F82010BBB;
        Thu,  5 Dec 2019 17:29:41 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com EE1F82010BBB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1575595782;
        bh=KYKqmpyu2/KqQw/Kgh5Hw9D6cv4w2gT1WEMOUZ51dOU=;
        h=From:To:Cc:Subject:Date:From;
        b=Fc8OwaK3Uno1CtieRVB5j2+9/MR0KfBD4iqD6bdydfWV/06dTYbAc326ZmZNyCZ+P
         HcjAxnPxr5RQNMuaI4YZxAttMv+WHChxbziMLS4o6DCd1lWdAPCPIVmIZE2vvMv51m
         J1LE/HZBwRrty/aOxKrOlHHfaoALuSF+cPzqE+LM=
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
To:     zohar@linux.ibm.com, linux-integrity@vger.kernel.org
Cc:     eric.snowberg@oracle.com, dhowells@redhat.com,
        mathew.j.martineau@linux.intel.com, matthewgarrett@google.com,
        sashal@kernel.org, jamorris@linux.microsoft.com,
        linux-kernel@vger.kernel.org, keyrings@vger.kernel.org
Subject: [PATCH v1 0/2] IMA: Deferred measurement of keys
Date:   Thu,  5 Dec 2019 17:29:34 -0800
Message-Id: <20191206012936.2814-1-nramas@linux.microsoft.com>
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

[1] https://lore.kernel.org/linux-integrity/20191204224131.3384-1-nramas@linux.microsoft.com/

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
  IMA: Define workqueue for early boot "key" measurements
  IMA: Call workqueue functions to measure queued keys

 security/integrity/ima/ima.h                 |  15 +++
 security/integrity/ima/ima_asymmetric_keys.c | 134 +++++++++++++++++++
 security/integrity/ima/ima_policy.c          |   6 +
 3 files changed, 155 insertions(+)

-- 
2.17.1

