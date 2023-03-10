Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62C7D6B3CBB
	for <lists+linux-integrity@lfdr.de>; Fri, 10 Mar 2023 11:47:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230021AbjCJKrk (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 10 Mar 2023 05:47:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229941AbjCJKrj (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 10 Mar 2023 05:47:39 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E328B1115A
        for <linux-integrity@vger.kernel.org>; Fri, 10 Mar 2023 02:47:37 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 95BCF21B46;
        Fri, 10 Mar 2023 10:47:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1678445256; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=c14xiGcgDvIR9XPC1AgwE7dl+0TgZy5SaXpiseN4Zyk=;
        b=FXw3k929hBP2SdGGpfTDn9jCZSokrfRkpDR/Gtx4aEjuh50U/5VWEIgPiesvcysPddcxpO
        e2iLcqAdW0YOuyVrENOT3apEzSuaFA2d06M7SSMsrABfZCoRGfxXCDnm9I9VyaDGbVWn9S
        xC6nVS89tQB3NaQf9viVJk9dllIJ9Og=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1678445256;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=c14xiGcgDvIR9XPC1AgwE7dl+0TgZy5SaXpiseN4Zyk=;
        b=va8z1q9POea5giaAKlXh2K81KWim58aSth06ddOI8JwHaMkyT2pz+3/gacvUdJA4uamUN+
        ckGF4o453ZOC+eCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6EC5E13592;
        Fri, 10 Mar 2023 10:47:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id NgPLGcgKC2SDZQAAMHmgww
        (envelope-from <pvorel@suse.cz>); Fri, 10 Mar 2023 10:47:36 +0000
From:   Petr Vorel <pvorel@suse.cz>
To:     linux-integrity@vger.kernel.org
Cc:     Petr Vorel <pvorel@suse.cz>, Mimi Zohar <zohar@linux.ibm.com>
Subject: [PATCH ima-evm-utils] fsverity.test: Add /usr/sbin into $PATH
Date:   Fri, 10 Mar 2023 11:47:29 +0100
Message-Id: <20230310104729.32078-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Unlike GitHub CI, tests which run by packaging tools often run as non-root,
thus required tools aren't visible:

./functions.sh: line 45: type: mkfs: not found
mkfs is required for test
./functions.sh: line 45: type: blkid: not found
blkid is required for test
./functions.sh: line 45: type: e2fsck: not found
e2fsck is required for test
./functions.sh: line 45: type: tune2fs: not found
tune2fs is required for test

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Hi Mimi,

some would maybe appreciate option to skip all tests,
but this is enough for me.

Kind regards,
Petr

 tests/fsverity.test | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/fsverity.test b/tests/fsverity.test
index 01d5c35..a274158 100755
--- a/tests/fsverity.test
+++ b/tests/fsverity.test
@@ -30,7 +30,7 @@
 # custom policy rules might take precedence.
 
 cd "$(dirname "$0")" || exit 1
-PATH=../src:../fsverity-utils:$PATH
+PATH=../src:../fsverity-utils:/usr/sbin:$PATH
 source ./functions.sh
 
 # Base VERBOSE on the environment variable, if set.
-- 
2.39.2

