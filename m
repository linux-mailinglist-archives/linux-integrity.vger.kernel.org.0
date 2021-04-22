Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48E093687DE
	for <lists+linux-integrity@lfdr.de>; Thu, 22 Apr 2021 22:26:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236949AbhDVU10 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 22 Apr 2021 16:27:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236877AbhDVU1Z (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 22 Apr 2021 16:27:25 -0400
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [IPv6:2607:fcd0:100:8a00::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FFD7C06174A;
        Thu, 22 Apr 2021 13:26:50 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 1E3E0128064B;
        Thu, 22 Apr 2021 13:26:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1619123210;
        bh=lpKpLvDQXs9Q1NT+GrGlV26p58c3MffiY5+OKf1+e+w=;
        h=Message-ID:Subject:From:To:Date:From;
        b=XBoHKLeABmtc9VSExXGpBUJcNmTiYYY7Xq9XID6UBEfeBWQ3h4jbjKNaJmgNY1lWG
         Qc2MfKVCNIK2xWGVsvBMvLrTJi1Q0kcJ8Ek3V8iuFfHTyWq6MTIf37GSpoZfvv1Oix
         9OBXbN+pkT4lfvrw1nf8e+udS6PdeBQY/c8C9cmg=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id lZCDzqQ8o4I4; Thu, 22 Apr 2021 13:26:50 -0700 (PDT)
Received: from jarvis.int.hansenpartnership.com (unknown [IPv6:2601:600:8280:66d1::527])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 7A749128064A;
        Thu, 22 Apr 2021 13:26:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1619123209;
        bh=lpKpLvDQXs9Q1NT+GrGlV26p58c3MffiY5+OKf1+e+w=;
        h=Message-ID:Subject:From:To:Date:From;
        b=hJxS7DxFsB1c1iCdADorsimylaRFA8On+fYLM5W1mPU8jdwBM+Rh94rTLkQw23t/i
         9yH/Wo2QDtRRFhTVCZB6mdk9MCkdyAy+hamWthEbnYAKYYVAmSQT8Gwa72KjJV2/Sx
         JAIN7UBo068NKIDvPSE73EQgTZVoOiFxqpq9JMKo=
Message-ID: <3315246e429b385bbd08c8a509843e99dcc829e3.camel@HansenPartnership.com>
Subject: [GIT PULL] KEYS: trusted fixes for 5.12-rc7
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Mimi Zohar <zohar@linux.ibm.com>, jarkko@kernel.org,
        linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        David Howells <dhowells@redhat.com>
Date:   Thu, 22 Apr 2021 13:26:48 -0700
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

This is an urgent regression fix for a tpm patch set that went in this
merge window. It looks like a rebase before the original pull request
lost a tpm_try_get_ops() so we have a lock imbalance in our code which
is causing oopses.  The original patch was correct on the mailing list.

I'm sending this in agreement with Mimi (as joint maintainers of
trusted keys) because Jarkko is off communing with the Reindeer or
whatever it is Finns do when on holiday.

git://git.kernel.org/pub/scm/linux/kernel/git/jejb/tpmdd.git fixes

The short changelog is:

James Bottomley (1):
      KEYS: trusted: Fix TPM reservation for seal/unseal

And the diffstat:

 security/keys/trusted-keys/trusted_tpm2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

With full diff below.

James

---

diff --git a/security/keys/trusted-keys/trusted_tpm2.c b/security/keys/trusted-keys/trusted_tpm2.c
index e2a0ed5d02f0..c87c4df8703d 100644
--- a/security/keys/trusted-keys/trusted_tpm2.c
+++ b/security/keys/trusted-keys/trusted_tpm2.c
@@ -79,7 +79,7 @@ int tpm2_seal_trusted(struct tpm_chip *chip,
 	if (i == ARRAY_SIZE(tpm2_hash_map))
 		return -EINVAL;
 
-	rc = tpm_buf_init(&buf, TPM2_ST_SESSIONS, TPM2_CC_CREATE);
+	rc = tpm_try_get_ops(chip);
 	if (rc)
 		return rc;
 

