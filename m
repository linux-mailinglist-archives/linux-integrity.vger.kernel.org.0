Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CADA52715FD
	for <lists+linux-integrity@lfdr.de>; Sun, 20 Sep 2020 18:40:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726305AbgITQkq (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 20 Sep 2020 12:40:46 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:42364 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726267AbgITQkq (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 20 Sep 2020 12:40:46 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id D063D8EE1C3;
        Sun, 20 Sep 2020 09:40:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1600620045;
        bh=/Ze12EtUxnwGSeaXuXqJRStFilVms5jX7H4ECW5pAlc=;
        h=From:To:Cc:Subject:Date:From;
        b=SUnxPdBhf9x3iMOi13Egfnq2Q/xjhetzo22pDltCtuGbausBGA1jg4iEC21t2i/Nd
         mst0IpTiVyH0nOLBG2/VuObwkwP5sn8MeqeG6PHvUsXnk447W/r6Y4P6IfFnu1AUhv
         /OrM3Rztu+d1p8fgmTa7zkWZF6zSLOEOAic08Pi0=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id oC-RavACU7-8; Sun, 20 Sep 2020 09:40:45 -0700 (PDT)
Received: from jarvis.int.hansenpartnership.com (jarvis.ext.hansenpartnership.com [153.66.160.226])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 0BFE38EE107;
        Sun, 20 Sep 2020 09:40:45 -0700 (PDT)
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     linux-integrity@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        David Woodhouse <dwmw2@infradead.org>,
        keyrings@vger.kernel.org, David Howells <dhowells@redhat.com>
Subject: [PATCH v12 0/3] Trusted Key policy for TPM 2.0
Date:   Sun, 20 Sep 2020 09:40:33 -0700
Message-Id: <20200920164036.11667-1-James.Bottomley@HansenPartnership.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Updated commit message

Original cover letter:

This is a lockstep patch with the prior trusted key rework patch (so
requires it as a percursor).  Now the key format is ASN.1, the policy
statements needed to unseal the key can be coded into the key file
itself meaning the kernel can now construct and use the policy session
necessary rather than the user having to do it.  This makes using TPM
2.0 keys with policy much easier.

The current implementation only has a limited subset of the full TPM
2.0 policy commands, but it is enough to implement keys locked to PCR
values and expiring keys.  The main missing feature is support for the
TPM2_PolicyOR statement, which means all current policy has to be AND
chains (key doesn't unlock unless every policy statement succeeds).

James

---

*** BLURB HERE ***

James Bottomley (3):
  security: keys: trusted: add PCR policy to TPM2 keys
  security: keys: trusted: add ability to specify arbitrary policy
  security: keys: trusted: implement counter/timer policy

 .../security/keys/trusted-encrypted.rst       |  83 +++-
 include/keys/trusted-type.h                   |   5 +-
 include/linux/tpm.h                           |   6 +
 security/keys/Kconfig                         |   2 +
 security/keys/trusted-keys/Makefile           |   2 +-
 security/keys/trusted-keys/tpm2-policy.c      | 465 ++++++++++++++++++
 security/keys/trusted-keys/tpm2-policy.h      |  31 ++
 security/keys/trusted-keys/tpm2key.asn1       |  13 +
 security/keys/trusted-keys/trusted_tpm1.c     |  23 +-
 security/keys/trusted-keys/trusted_tpm2.c     | 120 ++++-
 10 files changed, 735 insertions(+), 15 deletions(-)
 create mode 100644 security/keys/trusted-keys/tpm2-policy.c
 create mode 100644 security/keys/trusted-keys/tpm2-policy.h

-- 
2.26.2

