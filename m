Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 697281FB943
	for <lists+linux-integrity@lfdr.de>; Tue, 16 Jun 2020 18:03:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732496AbgFPQCf (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 16 Jun 2020 12:02:35 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:42456 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732363AbgFPQCd (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 16 Jun 2020 12:02:33 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 1CADD8EE2A2;
        Tue, 16 Jun 2020 09:02:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1592323353;
        bh=O6krlYQQz+UkxS0mXwz3JwoCS7CCDjDc27drY2jBIA0=;
        h=From:To:Cc:Subject:Date:From;
        b=ZvV/zFcDnjgJP6VcrRx/e1YzyAw69Xnm6fPrlzj+1qrcBwwrflwKvvPRN7lHTj/3z
         b2NCCBSVl+Cv80als0AEnKmx1KdJNP/j+MMl34+jOzE6jiWlNNsxyUdrF5X96pJNqk
         SWF6X9NiD60MqvI3ahLEaeU61uegbS00DqNOlHOM=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id dK8B4gWMng2a; Tue, 16 Jun 2020 09:02:33 -0700 (PDT)
Received: from jarvis.int.hansenpartnership.com (jarvis.ext.hansenpartnership.com [153.66.160.226])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 705718EE188;
        Tue, 16 Jun 2020 09:02:32 -0700 (PDT)
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     linux-integrity@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        David Woodhouse <dwmw2@infradead.org>,
        keyrings@vger.kernel.org, David Howells <dhowells@redhat.com>
Subject: [PATCH v10 0/8] TPM 2.0 trusted keys with attached policy
Date:   Tue, 16 Jun 2020 09:02:21 -0700
Message-Id: <20200616160229.8018-1-James.Bottomley@HansenPartnership.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

This is pretty much the same as the last time around except for a
couple of folded lines and some added reviews/acks.

General cover letter:

This patch updates the trusted key code to export keys in the ASN.1
format used by current TPM key tools (openssl_tpm2_engine and
openconnect).  It also simplifies the use of policy with keys because
the ASN.1 format is designed to carry a description of how to
construct the policy, with the result that simple policies (like
authorization and PCR locking) can now be constructed and used in the
kernel, bringing the TPM 2.0 policy use into line with how TPM 1.2
works.

The key format is designed to be compatible with our two openssl
engine implementations as well as with the format used by openconnect.
I've added seal/unseal to my engine so I can use it for
interoperability testing and I'll later use this for sealed symmetric
keys via engine:

https://git.kernel.org/pub/scm/linux/kernel/git/jejb/openssl_tpm2_engine.git/

James

---

James Bottomley (8):
  lib: add ASN.1 encoder
  oid_registry: Add TCG defined OIDS for TPM keys
  security: keys: trusted: fix TPM2 authorizations
  security: keys: trusted: use ASN.1 TPM2 key format for the blobs
  security: keys: trusted: Make sealed key properly interoperable
  security: keys: trusted: add PCR policy to TPM2 keys
  security: keys: trusted: add ability to specify arbitrary policy
  security: keys: trusted: implement counter/timer policy

 .../security/keys/trusted-encrypted.rst       |  64 ++-
 include/keys/trusted-type.h                   |   7 +-
 include/linux/asn1_encoder.h                  |  32 ++
 include/linux/oid_registry.h                  |   5 +
 include/linux/tpm.h                           |   8 +
 lib/Kconfig                                   |   3 +
 lib/Makefile                                  |   1 +
 lib/asn1_encoder.c                            | 454 +++++++++++++++++
 security/keys/Kconfig                         |   3 +
 security/keys/trusted-keys/Makefile           |   2 +-
 security/keys/trusted-keys/tpm2-policy.c      | 463 ++++++++++++++++++
 security/keys/trusted-keys/tpm2-policy.h      |  31 ++
 security/keys/trusted-keys/tpm2key.asn1       |  23 +
 security/keys/trusted-keys/trusted_tpm1.c     |  57 ++-
 security/keys/trusted-keys/trusted_tpm2.c     | 370 +++++++++++++-
 15 files changed, 1487 insertions(+), 36 deletions(-)
 create mode 100644 include/linux/asn1_encoder.h
 create mode 100644 lib/asn1_encoder.c
 create mode 100644 security/keys/trusted-keys/tpm2-policy.c
 create mode 100644 security/keys/trusted-keys/tpm2-policy.h
 create mode 100644 security/keys/trusted-keys/tpm2key.asn1

-- 
2.26.2

