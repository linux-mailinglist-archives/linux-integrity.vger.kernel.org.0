Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6F708123F9E
	for <lists+linux-integrity@lfdr.de>; Wed, 18 Dec 2019 07:32:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726674AbfLRGbx (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 18 Dec 2019 01:31:53 -0500
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:42402 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726671AbfLRGbx (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 18 Dec 2019 01:31:53 -0500
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id C05E78EE18E;
        Tue, 17 Dec 2019 22:31:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1576650712;
        bh=GUJyO358+kRE6fz8d5bwp//amOcyyBhnVFoynpM4evY=;
        h=From:To:Cc:Subject:Date:From;
        b=G+MgoIOYW2P+89W5+NmF1be+OvWxjp/qi70b+mBw89KJ++zbuLivPEgcXbxeSeNbq
         eADKdRQlGXvaSMMGVkdG57WSmGWmfXvVKftGlN9FifU1WLiIzSz/tZR5/ujsI0PRsM
         qn2Oub4BTfc1FwYy8ryxPCv/eeHBhH9j5GdeMvxU=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 24LGnO6xBIA5; Tue, 17 Dec 2019 22:31:52 -0800 (PST)
Received: from jarvis.int.hansenpartnership.com (jarvis.ext.hansenpartnership.com [153.66.160.226])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 47C028EE0DF;
        Tue, 17 Dec 2019 22:31:51 -0800 (PST)
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     linux-integrity@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        David Woodhouse <dwmw2@infradead.org>, keyrings@vger.kernel.org
Subject: [PATCH v3 0/9] TPM 2.0 trusted keys with attached policy
Date:   Wed, 18 Dec 2019 15:31:33 +0900
Message-Id: <20191218063142.23033-1-James.Bottomley@HansenPartnership.com>
X-Mailer: git-send-email 2.16.4
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Since the last respin, I've sent the bug fixes separately, since they
were an artifact of the prior code motion rather than zero day bugs in
the code and redone the series to keep the existing external policy
register setting.  This API is still problematic because it doesn't
scale very well and doesn't interoperate with the in-kernel resource
manager, but it can be made to work.

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

The ASN.1 encoder has been completely reworked to track the lengths of
all the buffers passing through it and to return an error if we run
out of space.

---

James Bottomley (9):
  lib: add asn.1 encoder
  oid_registry: Add TCG defined OIDS for TPM keys
  security: keys: trusted: use ASN.1 tpm2 key format for the blobs
  security: keys: trusted: Make sealed key properly interoperable
  security: keys: trusted: add PCR policy to TPM2 keys
  security: keys: trusted: add ability to specify arbitrary policy
  security: keys: trusted: implement counter/timer policy
  security: keys: trusted fix tpm2 authorizations
  security: keys: trusted: add password based authorizations to policy
    keys

 Documentation/security/keys/trusted-encrypted.rst |  64 +++-
 include/keys/trusted-type.h                       |   7 +-
 include/linux/asn1_encoder.h                      |  24 ++
 include/linux/oid_registry.h                      |   5 +
 include/linux/tpm.h                               |   8 +
 lib/Makefile                                      |   2 +-
 lib/asn1_encoder.c                                | 367 +++++++++++++++++++
 security/keys/Kconfig                             |   2 +
 security/keys/trusted-keys/Makefile               |   2 +-
 security/keys/trusted-keys/tpm2-policy.c          | 420 ++++++++++++++++++++++
 security/keys/trusted-keys/tpm2-policy.h          |  31 ++
 security/keys/trusted-keys/tpm2key.asn1           |  23 ++
 security/keys/trusted-keys/trusted_tpm1.c         |  46 ++-
 security/keys/trusted-keys/trusted_tpm2.c         | 358 ++++++++++++++++--
 14 files changed, 1325 insertions(+), 34 deletions(-)
 create mode 100644 include/linux/asn1_encoder.h
 create mode 100644 lib/asn1_encoder.c
 create mode 100644 security/keys/trusted-keys/tpm2-policy.c
 create mode 100644 security/keys/trusted-keys/tpm2-policy.h
 create mode 100644 security/keys/trusted-keys/tpm2key.asn1

-- 
2.16.4

