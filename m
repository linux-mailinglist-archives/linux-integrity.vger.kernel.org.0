Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9688A4E537F
	for <lists+linux-integrity@lfdr.de>; Wed, 23 Mar 2022 14:47:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240837AbiCWNs4 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 23 Mar 2022 09:48:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234803AbiCWNsz (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 23 Mar 2022 09:48:55 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F5407DA84
        for <linux-integrity@vger.kernel.org>; Wed, 23 Mar 2022 06:47:26 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id C27A61F387;
        Wed, 23 Mar 2022 13:47:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1648043244; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=Yb8sVHPqcKJcrYK+l7id3C3vel4hY85C4TVlrztmXqs=;
        b=KayDYj0X4HMj+FqjSwy62laBQ2N9NyRMuvXj1EKxrZq8/pb6tuNL8/rGJbOMJ0ylTMt0vI
        PVzIAEc6c0pnpRzH5VOgyX07yusilPbob+o2eJ6ky8RHoCJG0gWl+chXRJ/0/8X9OIuj6q
        RlLyS2QQTVfYxydCZiYdbmKtF+JdouQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1648043244;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=Yb8sVHPqcKJcrYK+l7id3C3vel4hY85C4TVlrztmXqs=;
        b=s7zFmBilYOExEORaSQrddop7CSYYZHln3KyvAR1OYS84oIyabovNYNRJ7lBdFkpeukG8iW
        YXzvLsokRvMM3BBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9B5B513302;
        Wed, 23 Mar 2022 13:47:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id zSVQJOwkO2JwNAAAMHmgww
        (envelope-from <pvorel@suse.cz>); Wed, 23 Mar 2022 13:47:24 +0000
From:   Petr Vorel <pvorel@suse.cz>
To:     linux-integrity@vger.kernel.org
Cc:     Petr Vorel <pvorel@suse.cz>, Mimi Zohar <zohar@linux.ibm.com>
Subject: [PATCH v2 1/1] ci/GitHub: Remove CentOS 8
Date:   Wed, 23 Mar 2022 14:47:20 +0100
Message-Id: <20220323134720.18556-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.35.1
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

It EOL in 12/2021 and CI is failing due removed repo:

CentOS Linux 8 - AppStream                      232  B/s |  38  B     00:00
Error: Failed to download metadata for repo 'appstream': Cannot prepare internal mirrorlist: No URLs in mirrorlist

Removing only from GitHub Actions, because Mimi Zohar reported Travis
can use centos:stream8.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 .github/workflows/ci.yml | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/.github/workflows/ci.yml b/.github/workflows/ci.yml
index 4316ede..5e4498e 100644
--- a/.github/workflows/ci.yml
+++ b/.github/workflows/ci.yml
@@ -80,11 +80,6 @@ jobs:
               CC: gcc
               TSS: tpm2-tss
 
-          - container: "centos:latest"
-            env:
-              CC: gcc
-              TSS: tpm2-tss
-
           - container: "debian:testing"
             env:
               CC: clang
-- 
2.35.1

