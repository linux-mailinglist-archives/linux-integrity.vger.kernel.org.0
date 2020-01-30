Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CA69814D8CD
	for <lists+linux-integrity@lfdr.de>; Thu, 30 Jan 2020 11:18:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726922AbgA3KSe (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 30 Jan 2020 05:18:34 -0500
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:57826 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726873AbgA3KSd (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 30 Jan 2020 05:18:33 -0500
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id A549B8EE148;
        Thu, 30 Jan 2020 02:18:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1580379512;
        bh=7YnAx4EHEZTTdZnHqRU48n8TTOB3Yf0i2q86l+1UBN0=;
        h=From:To:Cc:Subject:Date:From;
        b=QhFwCN1w1mvdBD58N5rwnEttGHQ3EsTa4/mOfa3+Kz69baYbP39H1mqTzTeygfdPL
         e5uCgywm2jCr4pfC1JI1H67pqtvJsQMH/718/xxAo5+pPH8SqOjpDrm6ufkcTWRaX0
         qOLtl4cf1vHNdPEZNCSdP1E3F8mlobKiJxhDlbEs=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id nzoYwI-b43fc; Thu, 30 Jan 2020 02:18:30 -0800 (PST)
Received: from jarvis.int.hansenpartnership.com (jarvis.ext.hansenpartnership.com [153.66.160.226])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 8E99B8EE0CD;
        Thu, 30 Jan 2020 02:18:28 -0800 (PST)
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     linux-integrity@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        David Woodhouse <dwmw2@infradead.org>, keyrings@vger.kernel.org
Subject: [PATCH v5 0/6] TPM 2.0 trusted keys with attached policy
Date:   Thu, 30 Jan 2020 11:18:06 +0100
Message-Id: <20200130101812.6271-1-James.Bottomley@HansenPartnership.com>
X-Mailer: git-send-email 2.16.4
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

This is mainly a respin to add more spacing as Jarkko requested.
However, I also added the seal/unseal operations to the
openssl_tpm2_engine (next branch):

https://git.kernel.org/pub/scm/linux/kernel/git/jejb/openssl_tpm2_engine.git/

With the result that the kernel code completely failed the
interoperability checks because the ASN.1 format requires the TPM2B
length prepended to the public and private blobs.  I corrected this in
patch 4 and now all the interoperability tests are passing.

General cover letter:

This patch updates the trusted key code to export keys in the ASN.1
format used by current TPM key tools (openssl_tpm2_engine and
openconnect).  It also simplifies the use of policy with keys because
the ASN.1 format is designed to carry a description of how to
construct the policy, with the result that simple policies (like
authorization and PCR locking) can now be constructed and used in the
kernel, bringing the TPM 2.0 policy use into line with how TPM 1.2
works.

James

---

James Bottomley (6):
  lib: add ASN.1 encoder
  oid_registry: Add TCG defined OIDS for TPM keys
  security: keys: trusted fix tpm2 authorizations
  security: keys: trusted: use ASN.1 TPM2 key format for the blobs
  security: keys: trusted: add ability to specify arbitrary policy
  security: keys: trusted: implement counter/timer policy

 Documentation/security/keys/trusted-encrypted.rst |  64 ++-
 include/keys/trusted-type.h                       |   7 +-
 include/linux/asn1_encoder.h                      |  32 ++
 include/linux/oid_registry.h                      |   5 +
 include/linux/tpm.h                               |   8 +
 lib/Makefile                                      |   2 +-
 lib/asn1_encoder.c                                | 431 ++++++++++++++++++++
 security/keys/Kconfig                             |   2 +
 security/keys/trusted-keys/Makefile               |   2 +-
 security/keys/trusted-keys/tpm2-policy.c          | 463 ++++++++++++++++++++++
 security/keys/trusted-keys/tpm2-policy.h          |  31 ++
 security/keys/trusted-keys/tpm2key.asn1           |  23 ++
 security/keys/trusted-keys/trusted_tpm1.c         |  50 ++-
 security/keys/trusted-keys/trusted_tpm2.c         | 370 +++++++++++++++--
 14 files changed, 1454 insertions(+), 36 deletions(-)
 create mode 100644 include/linux/asn1_encoder.h
 create mode 100644 lib/asn1_encoder.c
 create mode 100644 security/keys/trusted-keys/tpm2-policy.c
 create mode 100644 security/keys/trusted-keys/tpm2-policy.h
 create mode 100644 security/keys/trusted-keys/tpm2key.asn1

-- 
2.16.4

