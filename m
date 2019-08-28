Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 167089F74B
	for <lists+linux-integrity@lfdr.de>; Wed, 28 Aug 2019 02:27:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726250AbfH1A1k (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 27 Aug 2019 20:27:40 -0400
Received: from linux.microsoft.com ([13.77.154.182]:40020 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726077AbfH1A1k (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 27 Aug 2019 20:27:40 -0400
Received: from nramas-ThinkStation-P520.corp.microsoft.com (unknown [131.107.147.154])
        by linux.microsoft.com (Postfix) with ESMTPSA id 2CAFB20B7187;
        Tue, 27 Aug 2019 17:27:39 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 2CAFB20B7187
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
To:     linux-integrity@vger.kernel.org
Cc:     zohar@linux.ibm.com, jamorris@linux.microsoft.com,
        sashal@kernel.org, kgoldman@us.ibm.com, nramas@linux.microsoft.com
Subject: [PATCH 0/1] KEYS: Measure keys in trusted keyring
Date:   Tue, 27 Aug 2019 17:27:34 -0700
Message-Id: <20190828002735.31025-1-nramas@linux.microsoft.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Created using linux v5.3.0-rc5

Motive:

Motive behind this patch set is to measure the public keys in
the trusted keyring. If CONFIG_SECONDARY_TRUSTED_KEYRING is
enabled then the trusted keys keyring is secondary_trusted_keys.
Otherwise, the trusted keys keyring is builtin_trusted_keys.

Measurement of the trusted keys is an addition to
the existing IMA measurements and not a replacement for it.

The measurement is enabled through the configuration value
CONFIG_IMA_MEASURE_TRUSTED_KEYS. This configuration
is turned OFF by default and have to opted in by the kernel
builder.

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

This patch set to measure the public keys in the trusted keys
keyring is disabled by default and can be enabled with
CONFIG_IMA_MEASURE_TRUSTED_KEYS. When this configuration is
enabled, during boot IMA enumerates keys in the trusted keys
keyring and measures them in the IMA log.

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
CONFIG_IMA_MEASURE_TRUSTED_KEYS, only those enterprises that
require this new measurement can opt-in for it. Since it is disabled
by default, it does not restrict the autonomy of independent users
who are unaffected by attestation.

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

Lakshmi Ramasubramanian (1):
  KEYS: Measure keys in trusted keyring

 certs/system_keyring.c            | 15 ++++++
 include/keys/system_keyring.h     |  4 ++
 include/linux/key.h               | 21 ++++++++
 security/integrity/ima/Kconfig    | 14 ++++++
 security/integrity/ima/ima_init.c | 84 +++++++++++++++++++++++++++++++
 security/keys/keyring.c           | 63 +++++++++++++++++++++++
 6 files changed, 201 insertions(+)

-- 
2.17.1
