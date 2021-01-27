Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F16A3063B8
	for <lists+linux-integrity@lfdr.de>; Wed, 27 Jan 2021 20:07:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344047AbhA0THH (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 27 Jan 2021 14:07:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343828AbhA0THG (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 27 Jan 2021 14:07:06 -0500
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [IPv6:2607:fcd0:100:8a00::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75A0EC061573;
        Wed, 27 Jan 2021 11:06:26 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 66155128091C;
        Wed, 27 Jan 2021 11:06:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1611774384;
        bh=KiPWfGJKqybM4q2/yr4jro/rDoO/N7d5tgY0R+IvV6E=;
        h=From:To:Subject:Date:Message-Id:From;
        b=Sc/JUYqiNKPvXz90GEPmgt1veF70z0F8IcRHFwOKCnFOuUz/WX0zAg8f1hmv82CQi
         a/3Q9wiWZy+/0pg2O1i/OWwj14iSxayyXC8b94flNkk84hfUTjAetVp8GyKXajwxk6
         qqICBJYeW2xltzYGV/Gv77MYi9CCD19Gf7E/ay68=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id h11yB5BUYa7x; Wed, 27 Jan 2021 11:06:24 -0800 (PST)
Received: from jarvis.int.hansenpartnership.com (jarvis.ext.hansenpartnership.com [153.66.160.226])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id DE75D1280440;
        Wed, 27 Jan 2021 11:06:23 -0800 (PST)
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     linux-integrity@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        keyrings@vger.kernel.org, David Howells <dhowells@redhat.com>
Subject: [PATCH v15 0/5] TPM 2.0 trusted key rework
Date:   Wed, 27 Jan 2021 11:06:12 -0800
Message-Id: <20210127190617.17564-1-James.Bottomley@HansenPartnership.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

v15: fix 0day sign issue and add reviews and testeds

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
 security/keys/Kconfig                         |   3 +
 security/keys/trusted-keys/Makefile           |   4 +-
 security/keys/trusted-keys/tpm2key.asn1       |  11 +
 security/keys/trusted-keys/trusted_tpm1.c     |  34 +-
 security/keys/trusted-keys/trusted_tpm2.c     | 269 ++++++++++-
 13 files changed, 846 insertions(+), 32 deletions(-)
 create mode 100644 include/linux/asn1_encoder.h
 create mode 100644 lib/asn1_encoder.c
 create mode 100644 security/keys/trusted-keys/tpm2key.asn1

-- 
2.26.2

