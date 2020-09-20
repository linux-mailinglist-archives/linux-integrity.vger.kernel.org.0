Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFAC82715F0
	for <lists+linux-integrity@lfdr.de>; Sun, 20 Sep 2020 18:33:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726311AbgITQd6 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 20 Sep 2020 12:33:58 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:42102 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726267AbgITQd6 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 20 Sep 2020 12:33:58 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id C7B238EE1C3;
        Sun, 20 Sep 2020 09:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1600619637;
        bh=dJCCx6emeShuTI19LmYiADaWvZz8J6xU7s7ioY2/PWc=;
        h=From:To:Cc:Subject:Date:From;
        b=hMkn+c0RZQxqVoLC+NVqpuaI/dVXB2Xp6AMILPLmVNuC4K3LJskqkeiFy9iaxqQ/i
         osIY4BzcABasQiwshex3YwWcgwzFnurAZfCvcOYyuqTsI8YTMjsKoz+cSwpbRFaUmW
         m9o6LTokLaSmuimWFm29MkHZn/zv9IJenLuJIhTc=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Mn5rpNTaX-qV; Sun, 20 Sep 2020 09:33:57 -0700 (PDT)
Received: from jarvis.int.hansenpartnership.com (jarvis.ext.hansenpartnership.com [153.66.160.226])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 3EB1F8EE107;
        Sun, 20 Sep 2020 09:33:57 -0700 (PDT)
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     linux-integrity@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        David Woodhouse <dwmw2@infradead.org>,
        keyrings@vger.kernel.org, David Howells <dhowells@redhat.com>
Subject: [PATCH v12 0/5] TPM 2.0 trusted key rework
Date:   Sun, 20 Sep 2020 09:33:46 -0700
Message-Id: <20200920163351.11293-1-James.Bottomley@HansenPartnership.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Update to fix blobauth parsing problem.

General cover letter minus policy bit:

This patch updates the trusted key code to export keys in the ASN.1
format used by current TPM key tools (openssl_tpm2_engine and
openconnect).  The current code will try to load keys containing
policy, but being unable to formulate the policy commands necessary to
load them, the unseal will always fail unless the policy is executed
in user space and a pre-formed policy session passed in.

The key format is designed to be compatible with our two openssl
engine implementations as well as with the format used by openconnect.
I've added seal/unseal to my engine so I can use it for
interoperability testing and I'll later use this for sealed symmetric
keys via engine:

https://git.kernel.org/pub/scm/linux/kernel/git/jejb/openssl_tpm2_engine.git/

James

---

James Bottomley (5):
  lib: add ASN.1 encoder
  oid_registry: Add TCG defined OIDS for TPM keys
  security: keys: trusted: fix TPM2 authorizations
  security: keys: trusted: use ASN.1 TPM2 key format for the blobs
  security: keys: trusted: Make sealed key properly interoperable

 .../security/keys/trusted-encrypted.rst       |  58 +++
 include/keys/trusted-type.h                   |   2 +
 include/linux/asn1_encoder.h                  |  32 ++
 include/linux/oid_registry.h                  |   5 +
 include/linux/tpm.h                           |   2 +
 lib/Kconfig                                   |   3 +
 lib/Makefile                                  |   1 +
 lib/asn1_encoder.c                            | 454 ++++++++++++++++++
 security/keys/Kconfig                         |   1 +
 security/keys/trusted-keys/Makefile           |   2 +-
 security/keys/trusted-keys/tpm2key.asn1       |  11 +
 security/keys/trusted-keys/trusted_tpm1.c     |  34 +-
 security/keys/trusted-keys/trusted_tpm2.c     | 266 +++++++++-
 13 files changed, 840 insertions(+), 31 deletions(-)
 create mode 100644 include/linux/asn1_encoder.h
 create mode 100644 lib/asn1_encoder.c
 create mode 100644 security/keys/trusted-keys/tpm2key.asn1

-- 
2.26.2

