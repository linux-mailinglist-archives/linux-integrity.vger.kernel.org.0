Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 331FCEA896
	for <lists+linux-integrity@lfdr.de>; Thu, 31 Oct 2019 02:19:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726620AbfJaBTS (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 30 Oct 2019 21:19:18 -0400
Received: from linux.microsoft.com ([13.77.154.182]:34394 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725927AbfJaBTR (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 30 Oct 2019 21:19:17 -0400
Received: from nramas-ThinkStation-P520.corp.microsoft.com (unknown [131.107.174.108])
        by linux.microsoft.com (Postfix) with ESMTPSA id 88B6B20B7192;
        Wed, 30 Oct 2019 18:19:16 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 88B6B20B7192
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1572484756;
        bh=1U4vf2uAye9W2bnNquDS5GATd7rd++vcdhzACrEjRHM=;
        h=From:To:Cc:Subject:Date:From;
        b=oiuxWzMkyWakiJYgcZeuI3V/EHK44/chvBL7NpfKQW/88r/AdQyeoyldKISH9qDws
         igffZRZYPv9jcSwzxV/O6WOWriCM9XnW8+t565GShIL2GwjeQd4S09N1Jtc6RCN22C
         Laa6JBDhb5Z86LANooi1bnSJW9zRx9bRRfFYV5sc=
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
To:     zohar@linux.ibm.com, dhowells@redhat.com,
        matthewgarrett@google.com, sashal@kernel.org,
        jamorris@linux.microsoft.com, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, keyrings@vger.kernel.org
Cc:     prsriva@linux.microsoft.com
Subject: [PATCH v3 0/9] KEYS: Measure keys when they are created or updated
Date:   Wed, 30 Oct 2019 18:19:01 -0700
Message-Id: <20191031011910.2574-1-nramas@linux.microsoft.com>
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

IMA measures system files, command line arguments passed to kexec,
boot aggregate, etc. It can be used to measure keys as well.
But there is no mechanism available in the kernel for IMA to
know when a key is created or updated.

This change aims to address measuring keys created or updated
in the system.

To achieve the above the following changes have been made:

 - Added a new IMA hook namely, ima_post_key_create_or_update, which
   measures the key. This IMA hook is called from key_create_or_update
   function. The key measurement can be controlled through IMA policy.

   In this change set a new IMA policy function KEYRING_CHECK has been
   added to measure keys. The policy can optionally specify a set of
   keyrings to measure. By default all keyrings are included in
   the measurement when KEYRING_CHECK policy is specified.

   # measure all keys
   measure func=KEYRING_CHECK

   # measure keys on the IMA keyring
   measure func=KEYRING_CHECK keyring=".ima"

   # measure keys on the BUILTIN and IMA keyrings into a different PCR
   measure func=KEYRING_CHECK keyring=".builtin_trusted_keys|.ima" pcr=11

Testing performed:

  * Booted the kernel with this change.
  * Executed keyctl tests from the Linux Test Project (LTP)
  * All keys are measured when only KEYRING_CHECK is set.
  * Only keys added to the given keyrings are measured
    when keyrings option is set.
  * Keys are not measured when KEYRING_CHECK is not set.
  * Key is queued for measurement if IMA is not yet initialized
    and processed when IMA is initialized.
  * Key is measured rightaway when IMA is initialized.
  * Added a new key to a keyring and verified "key create" code path.
    => In this case added a key to .ima keyring.
  * Added the same key again and verified "key update" code path.
    => Add the same key to .ima keyring.

Change Log:

  v3:

  => Added KEYRING_CHECK for measuring keys. This can optionally specify
     keyrings to measure.
  => Updated ima_get_action() and related functions to return
     the keyrings if specified in the policy.
  => process_buffer_measurement() function is updated to take keyring
     as a parameter. The key will be measured if the policy includes
     the keyring in the list of measured keyrings. If the policy does not
     specify any keyrings then all keys are measured.

  v2:

  => Per suggestion from Mimi reordered the patch set to first
     enable measuring keys added or updated in the system.
     And, then scope the measurement to keys added to 
     builtin_trusted_keys keyring through ima policy.
  => Removed security_key_create_or_update function and instead
     call ima hook, to measure the key, directly from 
     key_create_or_update function.

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

Lakshmi Ramasubramanian (9):
  KEYS: Defined an IMA hook to measure keys on key create or update
  KEYS: Defined functions to queue and dequeue keys for measurement
  KEYS: Added KEYRING_CHECK policy for key measurement
  KEYS: Updated IMA policy functions for handling key measurement
  KEYS: Updated ima_get_action() to return keyrings if specified in the
    policy
  KEYS: Measure key if the IMA policy allows measurement for the given
    keyring
  KEYS: Queue key for measurement if IMA is not yet initialized. Measure
    queued keys when IMA initialization is completed
  KEYS: Added a boolean flag for IMA initialization status.
    ima_policy_flag cannot be relied upon for knowing IMA initialization
    status because ima_policy_flag can be set to 0 when IMA is
    initialized, but there is no IMA policy configured.
  KEYS: Call the IMA hook to measure key when a new key is created or an
    existing key is updated

 Documentation/ABI/testing/ima_policy  | 15 +++++
 include/linux/ima.h                   |  7 ++
 security/integrity/ima/ima.h          | 27 ++++++--
 security/integrity/ima/ima_api.c      |  7 +-
 security/integrity/ima/ima_appraise.c |  2 +-
 security/integrity/ima/ima_init.c     | 10 ++-
 security/integrity/ima/ima_main.c     | 57 ++++++++++++++--
 security/integrity/ima/ima_policy.c   | 42 +++++++++++-
 security/integrity/ima/ima_queue.c    | 93 +++++++++++++++++++++++++++
 security/keys/key.c                   |  9 +++
 10 files changed, 254 insertions(+), 15 deletions(-)

-- 
2.17.1

