Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5A5D812D2CE
	for <lists+linux-integrity@lfdr.de>; Mon, 30 Dec 2019 18:38:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727332AbfL3RiU (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 30 Dec 2019 12:38:20 -0500
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:39178 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727236AbfL3RiU (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 30 Dec 2019 12:38:20 -0500
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 210CD8EE15F;
        Mon, 30 Dec 2019 09:38:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1577727499;
        bh=tgmsNP/mt1L5gXrWlnWYxsUhURaOTtBAwX4ahuy9rRE=;
        h=From:To:Cc:Subject:Date:From;
        b=lra8nvXmaabdi/COCw6tIdDxJAjgky60OkYm7tY9hDnU6gqZLhzQoS6oLVEuDMoFo
         YI1+tZvuLzKAl85B2fiyQeI7It9hQ1E1NZEUc1UaPS31g75cbnbroe2KeyYjEoSOm/
         ZGfX8o6sMJZUsWACrSc5a42p2a612dTkufeMYFAA=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id PcpzEdoHbhAE; Mon, 30 Dec 2019 09:38:18 -0800 (PST)
Received: from jarvis.int.hansenpartnership.com (jarvis.ext.hansenpartnership.com [153.66.160.226])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 076BD8EE07B;
        Mon, 30 Dec 2019 09:38:17 -0800 (PST)
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     linux-integrity@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        David Woodhouse <dwmw2@infradead.org>, keyrings@vger.kernel.org
Subject: [PATCH v4 0/9] TPM 2.0 trusted keys with attached policy
Date:   Mon, 30 Dec 2019 09:37:53 -0800
Message-Id: <20191230173802.8731-1-James.Bottomley@HansenPartnership.com>
X-Mailer: git-send-email 2.16.4
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

This is basically a respin to update the ASN.1 interface to pass
pointers in and out instead of updating in place.  The remainder of
the patches haven't changed in substance, but have changed to support
the new ASN.1 encoder API.

General Cover letter description:

I've changed the output format to use the standardised ASN.1 coding
for TPM2 keys, meaning they should interoperate with userspace TPM2
key implementations.  Apart from interoperability, another advantage
of the existing key format is that it carries all parameters like
parent and hash with it and it is capable of carrying policy
directives in a way that mean they're tied permanently to the key (no
having to try to remember what the policy was and reconstruct it from
userspace).  This actually allows us to support the TPM 1.2 commands
like pcrinfo easily in 2.0.

Using the TPM2_PolicyPassword trick, this series now combines
authorization with policy in a flexible way that would allow us to
move to HMAC based authorizations later for TPM security.  In getting
passwords to work, I fixed the tpm2 password format in a separate
patch.  TPM 1.2 only allows fixed length authorizations, but TPM 2.0
allows for variable length passphrases, so we should support that in
the keys.

James

---

James Bottomley (9):
  lib: add asn.1 encoder
  oid_registry: Add TCG defined OIDS for TPM keys
  security: keys: trusted fix tpm2 authorizations
  security: keys: trusted: use ASN.1 tpm2 key format for the blobs
  security: keys: trusted: Make sealed key properly interoperable
  security: keys: trusted: add PCR policy to TPM2 keys
  security: keys: trusted: add ability to specify arbitrary policy
  security: keys: trusted: implement counter/timer policy
  security: keys: trusted: add password based authorizations to policy
    keys

 Documentation/security/keys/trusted-encrypted.rst |  64 +++-
 include/keys/trusted-type.h                       |   7 +-
 include/linux/asn1_encoder.h                      |  32 ++
 include/linux/oid_registry.h                      |   5 +
 include/linux/tpm.h                               |   8 +
 lib/Makefile                                      |   2 +-
 lib/asn1_encoder.c                                | 391 +++++++++++++++++++
 security/keys/Kconfig                             |   2 +
 security/keys/trusted-keys/Makefile               |   2 +-
 security/keys/trusted-keys/tpm2-policy.c          | 433 ++++++++++++++++++++++
 security/keys/trusted-keys/tpm2-policy.h          |  31 ++
 security/keys/trusted-keys/tpm2key.asn1           |  23 ++
 security/keys/trusted-keys/trusted_tpm1.c         |  46 ++-
 security/keys/trusted-keys/trusted_tpm2.c         | 360 ++++++++++++++++--
 14 files changed, 1370 insertions(+), 36 deletions(-)
 create mode 100644 include/linux/asn1_encoder.h
 create mode 100644 lib/asn1_encoder.c
 create mode 100644 security/keys/trusted-keys/tpm2-policy.c
 create mode 100644 security/keys/trusted-keys/tpm2-policy.h
 create mode 100644 security/keys/trusted-keys/tpm2key.asn1

-- 
2.16.4

