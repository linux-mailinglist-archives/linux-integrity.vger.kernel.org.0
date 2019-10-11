Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EFAE2D46B6
	for <lists+linux-integrity@lfdr.de>; Fri, 11 Oct 2019 19:35:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728710AbfJKRfy (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 11 Oct 2019 13:35:54 -0400
Received: from linux.microsoft.com ([13.77.154.182]:53890 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728461AbfJKRfy (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 11 Oct 2019 13:35:54 -0400
Received: from nramas-ThinkStation-P520.corp.microsoft.com (unknown [131.107.147.154])
        by linux.microsoft.com (Postfix) with ESMTPSA id EDB5720B71C6;
        Fri, 11 Oct 2019 10:35:51 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com EDB5720B71C6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1570815352;
        bh=FccJirpsFmgu7vJrKSezCDq4PXuW5ffcNAsNTq5wTgY=;
        h=From:To:Cc:Subject:Date:From;
        b=iewrAmnhW45vVZIXS8rw62/QdRVXJ8vWxHHd7wTyC4epQkt/MnwKRTmOytLXg88rs
         GC/B5mrTcERKVXYom0kfzd3MWxtEBVQGI4kMH7VNxHEP058fKEz36WnkK9ZV9+7FtB
         3xaI40KfrwE4s/ADtNAVOV7H+maLLucPGZg7Pdhk=
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
To:     linux-integrity@vger.kernel.org, zohar@linux.ibm.com,
        sashal@kernel.org, jamorris@linux.microsoft.com,
        kgoldman@us.ibm.com, mjg59@google.com, dhowells@redhat.com
Cc:     balajib@linux.microsoft.com, prsriva@linux.microsoft.com,
        jorhand@linux.microsoft.com, patatash@linux.microsoft.com
Subject: [PATCH v0 0/2] KEYS: Measure keys added to builtin or secondary trusted keys keyring
Date:   Fri, 11 Oct 2019 10:35:45 -0700
Message-Id: <20191011173547.3200-1-nramas@linux.microsoft.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Created using linux v5.3.0

Motive:

Motive behind this patch set is to measure the public keys added to
the trusted keys keyring (builtin or secondary trusted keys keyring).
This feature can be enabled through CONFIG_IMA and through
the IMA Hook TRUSTED_KEYS.

Measurement of the trusted keys is an addition to
the existing IMA measurements and not a replacement for it.

Background:

Currently IMA measures file hashes and .ima signatures. IMA signatures
are validated against keys in ".ima" keyring. If the kernel is built with
CONFIG_IMA_KEYRINGS_PERMIT_SIGNED_BY_BUILTIN_OR_SECONDARY enabled,
then all keys in ".ima" keyring must be signed by a key in
".builtin_trusted_keys" or ".secondary_trusted_keys" keyrings.

On systems with CONFIG_IMA_KEYRINGS_PERMIT_SIGNED_BY_BUILTIN_OR_SECONDARY
enabled, measuring keys in the  trusted keyring provides a mechanism
to attest that the client's system binaries are indeed signed by signers
that chain to known trusted keys.

Without this patch set, to attest the clients one needs to maintain
an "allowed list" of file hashes of all versions of all client binaries
that are deployed on the clients in the enterprise. That is a huge
operational challenge in a large scale environment of clients with
heterogenous builds. This also limits scalability and agility of
rolling out frequent client binary updates.

Current patch:

This patch set to measure the public keys added to the trusted keys
keyring can be enabled through CONFIG_IMA and through the IMA Hook
TRUSTED_KEYS. A new LSM hook has been added that will be invoked
when a new key is created. If CONFIG_IMA is enabled, the IMA function
to measure the key is called. This function will measure the key if
  => The key is being added to builtin or secondary trusted keys keyring
  => The key is an asymmetric key
  => IMA hook TRUSTED_KEYS is enabled through ima policy.

Questions and concerns raised by reviewers on the patch set:

Question 1:
Is "Signed with a trusted key" equal to "Trusted file"?
Doesn't the service need the hashes of the system files to determine
whether a file is trusted or not?

"Signed with a trusted key" does not equal "Trusted"

Answer:
Agree "Signed with a trusted key" may not equal "Trusted".
To address this, the attesting service can maintain a small
manageable set of bad hashes (a "Blocked list") and a list of
trusted keys expected in client's trusted keys keyring.
Using this data, the service can detect the presence of
"Disallowed (untrusted) version of client binaries".

Question 2:
Providing more data to the service (such as the keys in trusted keyring)
empowers the service to deny access to clients (block clients).
IMA walks a fine line in enforcing and measuring file integrity.
This patchset breaches that fine line and in doing so brings back
the fears of trusted computing.

Answer:
Any new measurement we add in IMA will provide more data to service
and can enable it to deny access to clients. It is not clear why
this patch set would breach the fine line between measuring
and enforcing.

Since this patch set is disabled by default and enabled through
CONFIG_IMA and through the IMA hook TRUSTED_KEYS, only those
enterprises that require this new measurement can opt-in for it.
Since it is disabled by default, it does not restrict the autonomy
of independent users who are unaffected by attestation.

Question 3:
IMA log already contains a pointer to the IMA keys used for signature
verification. Why does the service need to care what keys were used
to sign (install) the IMA keys? What is gained by measuring the keys
in the trusted keyring?

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
    => Key in the trusted keyring attests IMA key on the client
    => Attestation service attests the trusted keys
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
keys in the trusted keyring

Lakshmi Ramasubramanian (2):
  Measure keys added to builtin or secondary trusted keys keyring
  LSM Hook for key_create_or_update

 Documentation/ABI/testing/ima_policy |   1 +
 certs/system_keyring.c               |  14 ++
 include/keys/system_keyring.h        |   2 +
 include/linux/ima.h                  |  10 ++
 include/linux/lsm_hooks.h            |  15 ++
 include/linux/security.h             |  12 ++
 security/integrity/ima/ima.h         |  14 ++
 security/integrity/ima/ima_api.c     |   2 +-
 security/integrity/ima/ima_init.c    |  11 +-
 security/integrity/ima/ima_main.c    | 230 ++++++++++++++++++++++-----
 security/integrity/ima/ima_policy.c  |   4 +-
 security/keys/key.c                  |  12 ++
 security/security.c                  |  14 ++
 13 files changed, 295 insertions(+), 46 deletions(-)

-- 
2.17.1
