Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B6476C1093
	for <lists+linux-integrity@lfdr.de>; Mon, 20 Mar 2023 12:17:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230368AbjCTLRo (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 20 Mar 2023 07:17:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231229AbjCTLRL (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 20 Mar 2023 07:17:11 -0400
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [96.44.175.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 196164EDF
        for <linux-integrity@vger.kernel.org>; Mon, 20 Mar 2023 04:15:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1679310956;
        bh=exZ+3P/94LPmSvcJJ78/XPU0RxAl6qqxpEcxgrN5IKE=;
        h=Message-ID:Subject:From:To:Date:From;
        b=B+fRDkVHfqQu9yghWAZh/gPeO8rpj5MoLKDEIUuNU3ZqWRq6dZc7epu03v33Cpcok
         KE2mUv0n82q6Wt2yzUotkp9JPQdmS9zq7onuQsdW8ovXbmXsQFtwW8WRWPp32qwMN1
         +ra+iByt6JyLd7hR2u0soI1zx5K7b/CuVWjL7xLU=
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 675C91285E71;
        Mon, 20 Mar 2023 07:15:56 -0400 (EDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id PYQ_y0O1JCG4; Mon, 20 Mar 2023 07:15:56 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1679310956;
        bh=exZ+3P/94LPmSvcJJ78/XPU0RxAl6qqxpEcxgrN5IKE=;
        h=Message-ID:Subject:From:To:Date:From;
        b=B+fRDkVHfqQu9yghWAZh/gPeO8rpj5MoLKDEIUuNU3ZqWRq6dZc7epu03v33Cpcok
         KE2mUv0n82q6Wt2yzUotkp9JPQdmS9zq7onuQsdW8ovXbmXsQFtwW8WRWPp32qwMN1
         +ra+iByt6JyLd7hR2u0soI1zx5K7b/CuVWjL7xLU=
Received: from [172.20.7.43] (96-86-69-187-static.hfc.comcastbusiness.net [96.86.69.187])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id B83D412819BC;
        Mon, 20 Mar 2023 07:15:55 -0400 (EDT)
Message-ID: <de3ee520780be213c421685805c751dcda0754df.camel@HansenPartnership.com>
Subject: tpm: fix build break in tpm-chip.c caused by AMD fTPM quirk
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     linux-integrity@vger.kernel.org
Cc:     Jarkko Sakkinen <jarkko@kernel.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Mario Limonciello <mario.limonciello@amd.com>
Date:   Mon, 20 Mar 2023 07:15:52 -0400
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

The test for the AMD fTPM problem, which just went in, actually uses
the wrong function template for request_locality().  It's missing an
argument so the build breaks:

drivers/char/tpm/tpm-chip.c:568:8: error: too few arguments to function ‘tpm_request_locality’
  ret = tpm_request_locality(chip);
        ^~~~~~~~~~~~~~~~~~~~
drivers/char/tpm/tpm-chip.c:43:12: note: declared here
 static int tpm_request_locality(struct tpm_chip *chip, int locality)
            ^~~~~~~~~~~~~~~~~~~~

Fix this by requesting zero locality.

Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
Fixes: f1324bbc4011 ("tpm: disable hwrng for fTPM on some AMD designs")

---

diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
index c04d101c7779..fee061780468 100644
--- a/drivers/char/tpm/tpm-chip.c
+++ b/drivers/char/tpm/tpm-chip.c
@@ -565,7 +565,7 @@ static bool tpm_amd_is_rng_defective(struct tpm_chip *chip)
 	if (!(chip->flags & TPM_CHIP_FLAG_TPM2))
 		return false;
 
-	ret = tpm_request_locality(chip);
+	ret = tpm_request_locality(chip, 0);
 	if (ret)
 		return false;
 

