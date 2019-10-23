Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1B997E0F10
	for <lists+linux-integrity@lfdr.de>; Wed, 23 Oct 2019 02:18:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732528AbfJWASc (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 22 Oct 2019 20:18:32 -0400
Received: from linux.microsoft.com ([13.77.154.182]:45238 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727154AbfJWAS0 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 22 Oct 2019 20:18:26 -0400
Received: from nramas-ThinkStation-P520.corp.microsoft.com (unknown [131.107.174.108])
        by linux.microsoft.com (Postfix) with ESMTPSA id 2682E20106BF;
        Tue, 22 Oct 2019 17:18:24 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 2682E20106BF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1571789904;
        bh=yN+05eDxlyUx+/PSnyI5Tf50fzgj6nYfjELjevr3FFI=;
        h=From:To:Cc:Subject:Date:From;
        b=P8bvY4cvKZSjlaVvNSM+9d/74tuzUvvblCk/oKsfWq7wWqhZP0CjN5q7qDe2eZ2vj
         EPu40TA456SIvJbqzz1KibHRB7LV2ccHvFJKlPetnsi9pXZgf8q66VL2BZlOte4Pmo
         1F78hCiXlyvS/8OD4PTQJThjeMrVTiZVN6PVTqaM=
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
To:     zohar@linux.ibm.com, dhowells@redhat.com, casey@schaufler-ca.com,
        sashal@kernel.org, jamorris@linux.microsoft.com,
        linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        keyrings@vger.kernel.org
Cc:     nramas@linux.microsoft.com
Subject: [PATCH v1 0/6] KEYS: measure keys when they are created or updated
Date:   Tue, 22 Oct 2019 17:18:12 -0700
Message-Id: <20191023001818.3684-1-nramas@linux.microsoft.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Problem Statement:

Keys created or updated in the system are currently not being measured.
Therefore an attestation service, for instance, would not be able to
attest whether or not the trusted keys keyring(s), for instance, contain
only known good (trusted) keys.

ima measures system files, command line arguments passed to kexec, and
boot aggregate. It can be used to measure keys as well. But there is
no mechanism available in the kernel for ima to know when a key is
created or updated.

This change aims to address measuring keys created or updated
in the system.

To achieve the above the following changes have been made:

 - A new LSM function namely, security_key_create_or_update, has
   been added. This function is called by key_create_or_update
   function when a new key is created or an existing key is updated.
   This call is made when the key has been instantiated and linked
   to the target keyring.

   security_key_create_or_update is passed the target keyring, key,
   key creation flags, and a boolean flag indicating whether
   the key was newly created or an existing key was updated.

 - Added a new ima hook namely, ima_post_key_create_or_update, which
   measures the key. The measurement can be controlled through ima policy.

   In this change set a new ima policy BUILTIN_TRUSTED_KEYS has been
   added to measure keys added to the builtin_trusted_keys keyring.
   In future, this can be extended to measure keys added to
   other keyrings.

Change Log:

  v1:

  => LSM function for key_create_or_update. It calls ima.
  => Added ima hook for measuring keys
  => ima measures keys based on ima policy.

  v0:

  => Added LSM hook for key_create_or_update.
  => Measure keys added to builtin or secondary trusted keys keyring.

Background:

Currently ima measures file hashes and .ima signatures. ima signatures
are validated against keys in the ".ima" keyring. If the kernel is built
with CONFIG_IMA_KEYRINGS_PERMIT_SIGNED_BY_BUILTIN_OR_SECONDARY enabled,
then all keys in ".ima" keyring must be signed by a key in
".builtin_trusted_keys" or ".secondary_trusted_keys" keyrings.

Although ima supports the above configuration, not having an insight
into what keys are present in these trusted keys keyrings would prevent
an attestation service from validating a client machine.
 
On systems with CONFIG_IMA_KEYRINGS_PERMIT_SIGNED_BY_BUILTIN_OR_SECONDARY
enabled, measuring keys in the  ".builtin_trusted_keys" keyring provides
a mechanism to attest that the client's system binaries are indeed signed
by signers that chain to known trusted keys.

Without this change, to attest the clients one needs to maintain
an "allowed list" of file hashes of all versions of all client binaries
that are deployed on the clients in the enterprise. That is a huge
operational challenge in a large scale environment of clients with
heterogenous builds. This also limits scalability and agility of
rolling out frequent client binary updates.

Testing performed:

  * Booted the kernel with this change.
  * Executed keyctl tests from the Linux Test Project (LTP)
  * Added a new key to a keyring and verified "key create" code path.
    => In this case added a key to builtin_trusted_keys keyring.
    => Verified ima measured this key only when a policy is set.
  * Added the same key again and verified "key update" code path.
    => Add the same key to builtin_trusted_keys keyring.
    => Verified ima measured the key only when a policy is set.
  * Forced the LSM function security_key_create_or_update to
    return an error and verified that the key was not added to
    the keyring ("keyctl list <keyring>" does not list the key).

Questions and concerns raised by reviewers on this patch set:

Question 1:
Is "Signed with a trusted key" equal to "Trusted file"?
Doesn't the service need the hashes of the system files to determine
whether a file is trusted or not?
"Signed with a trusted key" does not equal "Trusted"

Answer:
Agree "Signed with a trusted key" may not equal "Trusted".
To address this, the attesting service can maintain a small
manageable set of bad hashes (a "Blocked list") and a list of
trusted keys expected in client's .builtin_trusted_keys" keyring.
Using this data, the service can detect the presence of
"Disallowed (untrusted) version of client binaries".

Question 2:
Providing more data to the service (such as ".builtin_trusted_keys"),
empowers the service  to deny access to clients (block clients).
IMA walks a fine line in enforcing and measuring file integrity.
This patchset breaches that fine line and in doing so brings back
the fears of trusted computing.

Answer:
Any new measurement we add in IMA will provide more data to service
and can enable it to deny access to clients. It is not clear why this patch
set would breach the fine line between measuring and enforcing.
Since this patch set is disabled by default and enabled through
CONFIG_IMA_MEASURE_TRUSTED_KEYS, only those enterprises that
require this new measurement can opt-in for it. Since it is disabled
by default, it does not restrict the autonomy of independent users
who are unaffected by attestation.

Question 3:
IMA log already contains a pointer to the IMA keys used for signature
verification. Why does the service need to care what keys were used
to sign (install) the IMA keys? What is gained by measuring the keys
in the ".builtin_trusted_keys"


Answer:
To attest the clients using the current IMA log, service needs to maintain
hashes of all the deployed versions of all the system binaries for their
enterprise. This will introduce a very high operational overhead in
a large scale environment of clients with heterogenous builds.
This limits scalability and agility of rolling out frequent client
binary updates.


On the other hand, with the current patch set, we will have IMA
validate the file signature on the clients and the service validate
that the IMA keys were installed using trusted keys.


This provides a chain of trust:
    => IMA Key validates file signature on the client
    => Built-In trusted key attests IMA key on the client
    => Attestation service attests the Built-In trusted keys
         reported by the client in the IMA log


This approach, therefore, would require the service to maintain
a manageble set of trusted keys that it receives from a trusted source.
And, verify if the clients only have keys from that set of trusted keys.

Question 4:
Where will the attestation service receive the keys to validate against?

Answer:
Attestation service will receive the keys from a trusted source such as
the enterprise build services that provides the client builds.
The service will use this set of keys to verify that the keys reported by
the clients in the IMA log contains only keys from this trusted list.


Question 5:
What is changing in the IMA log through this patch set?


Answer:
This patch set does not remove any data that is currently included
in the IMA log. It only adds more data to the IMA log - the data on
".builtin_trusted_keys"

Lakshmi Ramasubramanian (6):
  KEYS: Helper function to check if the given keyring is
    builtin_trusted_keys
  ima: Refactored process_buffer_measurement function so that it can
    measure any buffer (and not just KEXEC_CMDLINE one)
  KEYS: ima hook to measure builtin_trusted_keys
  KEYS: ima functions to queue and dequeue keys to measure
  KEYS: measure queued keys
  KEYS: measure keys when they are created or updated

 Documentation/ABI/testing/ima_policy |   1 +
 certs/system_keyring.c               |   5 +
 include/keys/system_keyring.h        |   2 +
 include/linux/ima.h                  |  15 ++-
 include/linux/security.h             |  13 ++-
 security/integrity/ima/ima.h         |  19 ++++
 security/integrity/ima/ima_api.c     |   1 +
 security/integrity/ima/ima_init.c    |  11 +-
 security/integrity/ima/ima_main.c    |  52 ++++++---
 security/integrity/ima/ima_policy.c  |   5 +-
 security/integrity/ima/ima_queue.c   | 160 +++++++++++++++++++++++++++
 security/keys/key.c                  |  78 +++++++++++--
 security/security.c                  |  10 ++
 13 files changed, 344 insertions(+), 28 deletions(-)

-- 
2.17.1

