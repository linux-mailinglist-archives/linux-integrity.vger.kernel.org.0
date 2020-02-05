Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D4F3615292B
	for <lists+linux-integrity@lfdr.de>; Wed,  5 Feb 2020 11:34:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727771AbgBEKe3 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 5 Feb 2020 05:34:29 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:2365 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727234AbgBEKe3 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 5 Feb 2020 05:34:29 -0500
Received: from lhreml702-cah.china.huawei.com (unknown [172.18.7.106])
        by Forcepoint Email with ESMTP id 582EEB0DCAD44BEDC7FD;
        Wed,  5 Feb 2020 10:34:27 +0000 (GMT)
Received: from roberto-HP-EliteDesk-800-G2-DM-65W.huawei.com (10.204.65.160)
 by smtpsuk.huawei.com (10.201.108.43) with Microsoft SMTP Server (TLS) id
 14.3.408.0; Wed, 5 Feb 2020 10:34:18 +0000
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     <zohar@linux.ibm.com>, <James.Bottomley@HansenPartnership.com>,
        <jarkko.sakkinen@linux.intel.com>
CC:     <linux-integrity@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <silviu.vlasceanu@huawei.com>,
        Roberto Sassu <roberto.sassu@huawei.com>
Subject: [PATCH v2 0/8] ima: support stronger algorithms for attestation
Date:   Wed, 5 Feb 2020 11:33:09 +0100
Message-ID: <20200205103317.29356-1-roberto.sassu@huawei.com>
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

Second, it uses the default IMA hash algorithm to calculate the boot
aggregate, assuming that the corresponding PCR bank is currently allocated.
Otherwise, it finds the SHA256 PCR bank (mandatory for TPM 2.0 in TCG PC
Client specification). Lastly, if that bank was not found, it selects the
first PCR bank. If the TPM algorithm ID of the first PCR bank is not mapped
to a crypto ID, boot_aggregate is set to zero.

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
swtpm from Stefan Berger, but at the moment it is necessary to change the
ACPI parser in drivers/char/tpm/event_log/acpi.c to accept TPM 2.0 and to
return EFI_TCG2_EVENT_LOG_FORMAT_TCG_2.

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

v1:
- move ima_sha1_idx and ima_hash_algo_idx to ima_crypto.c
- introduce ima_num_template_digests (suggested by Mimi)
- determine ima_num_template_digests before allocating ima_algo_array
  (suggested by Mimi)
- replace kmalloc_array() with kcalloc() in ima_init_crypto() (suggested by
  Mimi)
- check if ima_tpm_chip is NULL

Roberto Sassu (8):
  tpm: Initialize crypto_id of allocated_banks to HASH_ALGO__LAST
  ima: Switch to ima_hash_algo for boot aggregate
  ima: Evaluate error in init_ima()
  ima: Store template digest directly in ima_template_entry
  ima: Switch to dynamically allocated buffer for template digests
  ima: Allocate and initialize tfm for each PCR bank
  ima: Calculate and extend PCR with digests in ima_template_entry
  ima: Use ima_hash_algo for collision detection in the measurement list

 drivers/char/tpm/tpm2-cmd.c           |   2 +
 security/integrity/ima/ima.h          |   8 +-
 security/integrity/ima/ima_api.c      |  20 +--
 security/integrity/ima/ima_crypto.c   | 244 ++++++++++++++++++++++----
 security/integrity/ima/ima_fs.c       |   4 +-
 security/integrity/ima/ima_init.c     |  22 ++-
 security/integrity/ima/ima_main.c     |   3 +
 security/integrity/ima/ima_queue.c    |  36 ++--
 security/integrity/ima/ima_template.c |  22 ++-
 9 files changed, 288 insertions(+), 73 deletions(-)

-- 
2.17.1

