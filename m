Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74857267B9F
	for <lists+linux-integrity@lfdr.de>; Sat, 12 Sep 2020 19:39:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725873AbgILRjt (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sat, 12 Sep 2020 13:39:49 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:55356 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725838AbgILRjn (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 12 Sep 2020 13:39:43 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id C37F78EE0E2;
        Sat, 12 Sep 2020 10:39:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1599932380;
        bh=lZoKIcHJzNF1n4MVQoK0VGjx8PjuimYQzyD3wkP6gcs=;
        h=From:To:Cc:Subject:Date:From;
        b=LyhqhZrHQkfKMtrLTkrxKHl0MH1MW/RbavraGB9n3qTp3UU7HCV3RkXFauR/eMpwB
         NGVbPHFkcqrEzZkU2cDOvh5ArFuJ88eWWZZF55IflBogSk2+7dmrICpK+JBdlO2puO
         U2khunVWLGHA/WTKycxIq9/+66sxOCk2+SZhWNjM=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id TwerNGbJ6bQv; Sat, 12 Sep 2020 10:39:40 -0700 (PDT)
Received: from jarvis.int.hansenpartnership.com (jarvis.ext.hansenpartnership.com [153.66.160.226])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 3C8A78EE07B;
        Sat, 12 Sep 2020 10:39:40 -0700 (PDT)
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     linux-integrity@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        David Woodhouse <dwmw2@infradead.org>,
        keyrings@vger.kernel.org, David Howells <dhowells@redhat.com>
Subject: [PATCH v11 0/3] Trusted Key policy for TPM 2.0
Date:   Sat, 12 Sep 2020 10:39:35 -0700
Message-Id: <20200912173938.9714-1-James.Bottomley@HansenPartnership.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

This is a lockstep patch with the prior trusted key rework patch.  Now
the key format is ASN.1, the policy statements needed to unseal the
key can be coded into the key file itself meaning the kernel can now
construct and use the policy session necessary rather than the user
having to do it.  This makes using TPM 2.0 keys with policy much easier.

The current implementation only has a limited subset of the full TPM
2.0 policy commands, but it is enough to implement keys locked to PCR
values and expiring keys.  The main missing feature is support for the
TPM2_PolicyOR statement, which means all current policy has to be AND
chains (key doesn't unlock unless every policy statement succeeds).

James

---

James Bottomley (3):
  security: keys: trusted: add PCR policy to TPM2 keys
  security: keys: trusted: add ability to specify arbitrary policy
  security: keys: trusted: implement counter/timer policy

 .../security/keys/trusted-encrypted.rst       |  83 +++-
 include/keys/trusted-type.h                   |   5 +-
 include/linux/tpm.h                           |   6 +
 security/keys/Kconfig                         |   2 +
 security/keys/trusted-keys/Makefile           |   2 +-
 security/keys/trusted-keys/tpm2-policy.c      | 463 ++++++++++++++++++
 security/keys/trusted-keys/tpm2-policy.h      |  31 ++
 security/keys/trusted-keys/tpm2key.asn1       |  13 +
 security/keys/trusted-keys/trusted_tpm1.c     |  23 +-
 security/keys/trusted-keys/trusted_tpm2.c     | 120 ++++-
 10 files changed, 733 insertions(+), 15 deletions(-)
 create mode 100644 security/keys/trusted-keys/tpm2-policy.c
 create mode 100644 security/keys/trusted-keys/tpm2-policy.h

-- 
2.26.2

