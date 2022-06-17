Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E82D854F8B0
	for <lists+linux-integrity@lfdr.de>; Fri, 17 Jun 2022 15:56:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381052AbiFQN4e (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 17 Jun 2022 09:56:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382523AbiFQN4d (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 17 Jun 2022 09:56:33 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D4693C4B8
        for <linux-integrity@vger.kernel.org>; Fri, 17 Jun 2022 06:56:32 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 199F7218B1;
        Fri, 17 Jun 2022 13:56:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1655474191; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=Wx9PR0zxToLAnkqcqQWh0unZcw78nGJEcwqaAdch5E8=;
        b=qcVAUjFrsOkRCo8RtMbYYzqtlEI6XbGPkdvYCbifJbWV+3cOOG8avBj1NCI2EuLAHjPVAL
        L4v6LrXpUKHxQSlKipQ8U0U+6sL8vOjPkHFneCPMUM1K1VeJv4hW+oOt1ngTeuqyqEtceV
        B7qjH2m+BNnOVtT1tJb7wxYDegqMD0I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1655474191;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=Wx9PR0zxToLAnkqcqQWh0unZcw78nGJEcwqaAdch5E8=;
        b=4pp8iSHNAopoJ6LyY0DSUlWdlTg9GmVpLK/zs/PDmLlIdm2mRxmLvalec9i7UX859nFgIn
        CTIP2rzs9CyGPtCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D956813458;
        Fri, 17 Jun 2022 13:56:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id h9uvMg6IrGKfIAAAMHmgww
        (envelope-from <pvorel@suse.cz>); Fri, 17 Jun 2022 13:56:30 +0000
From:   Petr Vorel <pvorel@suse.cz>
To:     linux-integrity@vger.kernel.org
Cc:     Petr Vorel <pvorel@suse.cz>, Mimi Zohar <zohar@linux.ibm.com>
Subject: [PATCH 1/1] ci/ubuntu: impish -> jammy
Date:   Fri, 17 Jun 2022 15:56:25 +0200
Message-Id: <20220617135625.2370-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Ubuntu 21.10 impish EOL in 2027-04 (next month).
Replace it with the latest stable release (EOL 2027-04).

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Hi Mimi,

Tested: https://github.com/pevik/ima-evm-utils/actions/runs/2515784254

It's also a question whether use 20.04 LTS focal instead of 18.04 LTS
bionic. I guess we'd like to cover everything: bleeding edge, used
distros and very old and still used distros. bionic EOL next year
(2023-04).

I'll try to have look on Alpine failure sometimes on July.

Kind regards,
Petr

 .github/workflows/ci.yml | 2 +-
 .travis.yml              | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/.github/workflows/ci.yml b/.github/workflows/ci.yml
index 5e4498e..dc06fce 100644
--- a/.github/workflows/ci.yml
+++ b/.github/workflows/ci.yml
@@ -59,7 +59,7 @@ jobs:
               CC: gcc
               TSS: tpm2-tss
 
-          - container: "ubuntu:impish"
+          - container: "ubuntu:jammy"
             env:
               CC: gcc
               TSS: ibmtss
diff --git a/.travis.yml b/.travis.yml
index d6b3c5e..5741116 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -40,7 +40,7 @@ matrix:
           compiler: gcc
 
         - os: linux
-          env: DISTRO=ubuntu:impish TSS=ibmtss COMPILE_SSL=openssl-3.0.0-beta1
+          env: DISTRO=ubuntu:jammy TSS=ibmtss COMPILE_SSL=openssl-3.0.0-beta1
           compiler: gcc
 
         - os: linux
-- 
2.36.1

