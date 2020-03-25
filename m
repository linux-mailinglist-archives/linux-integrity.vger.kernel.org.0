Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4A9B619261C
	for <lists+linux-integrity@lfdr.de>; Wed, 25 Mar 2020 11:49:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726139AbgCYKtP (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 25 Mar 2020 06:49:15 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2587 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726103AbgCYKtP (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 25 Mar 2020 06:49:15 -0400
Received: from lhreml702-cah.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id D3B41D71D1F25870776E;
        Wed, 25 Mar 2020 10:49:11 +0000 (GMT)
Received: from roberto-HP-EliteDesk-800-G2-DM-65W.huawei.com (10.204.65.160)
 by smtpsuk.huawei.com (10.201.108.43) with Microsoft SMTP Server (TLS) id
 14.3.408.0; Wed, 25 Mar 2020 10:49:01 +0000
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     <zohar@linux.ibm.com>, <James.Bottomley@HansenPartnership.com>
CC:     <linux-integrity@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <silviu.vlasceanu@huawei.com>,
        Roberto Sassu <roberto.sassu@huawei.com>
Subject: [PATCH v4 0/7] ima: support stronger algorithms for attestation
Date:   Wed, 25 Mar 2020 11:47:05 +0100
Message-ID: <20200325104712.25694-1-roberto.sassu@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.204.65.160]
X-CFilter-Loop: Reflected
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

IMA extends Platform Configuration Registers (PCRs) of the TPM to give a
proof to a remote verifier that the measurement list contains all
measurements done by the kernel and that the list was not maliciously
modified by an attacker.

IMA was originally designed to extend PCRs with a SHA1 digest, provided
with the measurement list, and was subsequently updated to extend all PCR
banks in case a TPM 2.0 is used. Non-SHA1 PCR banks are not supposed to be
used for remote attestation, as they are extended with a SHA1 digest padded
with zeros, which does not increase the strength.

This patch set addresses this issue by extending PCRs with the digest of
the measurement entry calculated with the crypto subsystem. The list of
algorithms used to calculate the digest are taken from
ima_tpm_chip->allocated_banks, returned by the TPM driver. The SHA1 digest
is always calculated, as SHA1 still remains the default algorithm for the
template digest in the measurement list.

This patch set also makes two additional modifications related to the usage
of hash algorithms. First, since now the template digest for the default
IMA algorithm is always calculated, this is used for hash collision
detection, to check if there are duplicate measurement entries.

Second, it uses the IMA default hash algorithm to calculate the boot
aggregate, assuming that the corresponding PCR bank is currently allocated.
If it does not find it, it selects the SHA256 PCR bank for TPM 2.0 and SHA1
for TPM 1.2 (their use is mandatory according to TCG PC Client
specification). Ultimately, it selects SHA1 also for TPM 2.0 if the SHA256
PCR bank is not found.

This patch set does not yet modify the format of the measurement list to
provide the digests passed to the TPM. However, reconstructing the value of
the quoted PCR is still possible for the verifier by calculating the digest
on measurement data found in binary_runtime_measurements.

attest-tools (https://github.com/euleros/attest-tools, branch 0.2-devel)
has the ability to parse the BIOS and IMA event logs, and to compare
boot_aggregate with the digest of final PCR values obtained by performing
in software the PCR extend operation with digests in the BIOS event log.

To perform the test, it is necessary to have a complete BIOS event log and
to apply the boot_aggregate patches. It would be possible to use qemu and
swtpm from Stefan Berger, but at the moment I had to change the ACPI parser
in drivers/char/tpm/event_log/acpi.c to accept TPM 2.0 and to return
EFI_TCG2_EVENT_LOG_FORMAT_TCG_2.

Create req.json with this content:
---
{
  "reqs":{
    "dummy|verify":"",
    "ima_boot_aggregate|verify":""
  }
}
---

With the requirements above, attest-tools verifies boot_aggregate and
accepts any other entry in the event logs.

On server side run:
# attest_ra_server -p 10 -r req.json -s -i

-s disables TPM signature verification
-i allows IMA violations

To enable TPM signature verification it is necessary to have a valid AK
certificate. It can be obtained by following the instructions at:

https://github.com/euleros/attest-tools/blob/0.2-devel/README

On client side run:
# echo test > aik_cert.pem
# echo aik_cert.pem > list_privacy_ca
# attest_ra_client -A

The commands above generate an AK and tell attest-tools to use a dummy AK
certificate.

# attest_ra_client -s <server IP> -q -p 10 -P <PCR algo> -b -i

The command above sends the TPM quote and the event logs to the RA server
and gets the response (successful/failed verification).

-b includes the BIOS event log from securityfs
-i includes the IMA event log from securityfs

To check that IMA extends non-SHA1 PCR banks with an appropriate digest,
use -P sha256, so that attest_ra_client selects the SHA256 PCR bank. To
check that boot_aggregate is calculated properly, set ima_hash=sha256 in
the kernel command line.

Changelog

v3:
- Remove option to select the first PCR bank and select SHA1 as fallback
  choice also for TPM 2.0 (suggested by Mimi)
- improve comment for ima_extra_slots (suggested by Mimi)
- declare local variable digests in ima_alloc_init_template() and
  ima_restore_template_data() (suggested by Mimi)

v2:
- add NR_BANKS macro to return zero if ima_tpm_chip is NULL
- replace ima_num_template_digests with
  NR_BANKS(ima_tpm_chip) + ima_extra_slots (suggested by Mimi)
- add __ro_after_init to declaration of ima_sha1_idx ima_hash_algo_idx and
  ima_extra_slots (suggested by Mimi)
- declare ima_init_ima_crypto() as static (reported by kbuild test robot)
- use ima_sha1_idx and ima_hash_algo_idx to access ima_algo_array elements
  in ima_init_crypto()

v1:
- move ima_sha1_idx and ima_hash_algo_idx to ima_crypto.c
- introduce ima_num_template_digests (suggested by Mimi)
- determine ima_num_template_digests before allocating ima_algo_array
  (suggested by Mimi)
- replace kmalloc_array() with kcalloc() in ima_init_crypto() (suggested by
  Mimi)
- check if ima_tpm_chip is NULL

Roberto Sassu (7):
  ima: Switch to ima_hash_algo for boot aggregate
  ima: Evaluate error in init_ima()
  ima: Store template digest directly in ima_template_entry
  ima: Switch to dynamically allocated buffer for template digests
  ima: Allocate and initialize tfm for each PCR bank
  ima: Calculate and extend PCR with digests in ima_template_entry
  ima: Use ima_hash_algo for collision detection in the measurement list

 security/integrity/ima/ima.h          |  10 +-
 security/integrity/ima/ima_api.c      |  22 +--
 security/integrity/ima/ima_crypto.c   | 248 ++++++++++++++++++++++----
 security/integrity/ima/ima_fs.c       |   4 +-
 security/integrity/ima/ima_init.c     |  22 ++-
 security/integrity/ima/ima_main.c     |   3 +
 security/integrity/ima/ima_queue.c    |  36 ++--
 security/integrity/ima/ima_template.c |  25 ++-
 8 files changed, 297 insertions(+), 73 deletions(-)

-- 
2.17.1

