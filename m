Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C6AC3116071
	for <lists+linux-integrity@lfdr.de>; Sun,  8 Dec 2019 06:06:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725306AbfLHFGn (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 8 Dec 2019 00:06:43 -0500
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:57870 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725268AbfLHFGm (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 8 Dec 2019 00:06:42 -0500
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 66DDA8EE111;
        Sat,  7 Dec 2019 21:06:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1575781602;
        bh=6/hLvZGgBTinh2E5n3Ka44hNEdmXiQoSiAitLYmcqSo=;
        h=Subject:From:To:Cc:Date:From;
        b=Styk0r6mnWh0i0YkVJJwXEwulyKGdZaHqPpb0ibZ9i4uhy2vBmKte4lTB6BIc543u
         XgiavTweQwjOhErwbGv5lDAtrNe3iBJj6pRZvADE07vQd/bYnT1O1DtFwIdPMivcvZ
         8Ze/JXkD897gOehx7DnEUDrGCXeyW9z1elyXbeNY=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id HHzJxMdzTr3m; Sat,  7 Dec 2019 21:06:42 -0800 (PST)
Received: from jarvis.lan (unknown [50.35.76.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id E0CF48EE109;
        Sat,  7 Dec 2019 21:06:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1575781602;
        bh=6/hLvZGgBTinh2E5n3Ka44hNEdmXiQoSiAitLYmcqSo=;
        h=Subject:From:To:Cc:Date:From;
        b=Styk0r6mnWh0i0YkVJJwXEwulyKGdZaHqPpb0ibZ9i4uhy2vBmKte4lTB6BIc543u
         XgiavTweQwjOhErwbGv5lDAtrNe3iBJj6pRZvADE07vQd/bYnT1O1DtFwIdPMivcvZ
         8Ze/JXkD897gOehx7DnEUDrGCXeyW9z1elyXbeNY=
Message-ID: <1575781600.14069.8.camel@HansenPartnership.com>
Subject: [PATCH 0/8] Fix TPM 2.0 trusted keys
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     linux-integrity@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Date:   Sat, 07 Dec 2019 21:06:40 -0800
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

This fixes a wide array of problems with the current TPM 2.0
implementation of trusted keys.  Since policy based trusted keys never
worked in the current implementation, I've rewritten the policy
implementation to make it easier to use and so the trusted key handler
can understand what elements of a policy are failing and why.

Apart from fixing bugs like volatile object leakage, I've changed the
output format to use the standardised ASN.1 coding for TPM2 keys,
meaning they should interoperate with userspace TPM2 key
implementations.  Apart from interoperability, another advantage of the
existing key format is that it carries all parameters like parent and
hash with it and it is capable of carrying policy directives in a way
that mean they're tied permanently to the key (no having to try to
remember what the policy was and reconstruct it from userspace).  This
actually allows us to support the TPM 1.2 commands like pcrinfo easily
in 2.0.

The big problem with this patch is still that we can't yet combine
policy with authorization because that requires proper session
handling, but at least with this rewrite it becomes possible (whereas
it was never possible with the old external policy session code). 
Thus, when we have the TPM 2.0 security patch upstream, we'll be able
to use the session logic from that patch to imlement authorizations.

James

---

James Bottomley (8):
  security: keys: trusted: flush the key handle after use
  lib: add asn.1 encoder
  oid_registry: Add TCG defined OIDS for TPM keys
  security: keys: trusted: use ASN.1 tpm2 key format for the blobs
  security: keys: trusted: Make sealed key properly interoperable
  security: keys: trusted: add PCR policy to TPM2 keys
  security: keys: trusted: add ability to specify arbitrary policy
  security: keys: trusted: implement counter/timer policy

 Documentation/security/keys/trusted-encrypted.rst |  70 +++-
 drivers/char/tpm/tpm.h                            |   1 -
 drivers/char/tpm/tpm2-cmd.c                       |   1 +
 include/keys/trusted-type.h                       |   6 +-
 include/linux/asn1_encoder.h                      |  21 ++
 include/linux/oid_registry.h                      |   5 +
 include/linux/tpm.h                               |   8 +
 lib/Makefile                                      |   2 +-
 lib/asn1_encoder.c                                | 201 +++++++++++
 security/keys/Kconfig                             |   2 +
 security/keys/trusted-keys/Makefile               |   2 +-
 security/keys/trusted-keys/tpm2-policy.c          | 409 ++++++++++++++++++++++
 security/keys/trusted-keys/tpm2-policy.h          |  31 ++
 security/keys/trusted-keys/tpm2key.asn1           |  23 ++
 security/keys/trusted-keys/trusted_tpm1.c         |  40 +--
 security/keys/trusted-keys/trusted_tpm2.c         | 285 +++++++++++++--
 16 files changed, 1050 insertions(+), 57 deletions(-)
 create mode 100644 include/linux/asn1_encoder.h
 create mode 100644 lib/asn1_encoder.c
 create mode 100644 security/keys/trusted-keys/tpm2-policy.c
 create mode 100644 security/keys/trusted-keys/tpm2-policy.h
 create mode 100644 security/keys/trusted-keys/tpm2key.asn1

-- 
2.16.4

