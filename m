Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B33FD62ECB4
	for <lists+linux-integrity@lfdr.de>; Fri, 18 Nov 2022 05:05:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241108AbiKREFk (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 17 Nov 2022 23:05:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240965AbiKREEz (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 17 Nov 2022 23:04:55 -0500
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D90F627F6;
        Thu, 17 Nov 2022 20:04:39 -0800 (PST)
From:   =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=weissschuh.net;
        s=mail; t=1668744275;
        bh=fAGK24L9+iydhX7H00KM/0PHDgztpBEk6tzt350ufR8=;
        h=From:To:Cc:Subject:Date:From;
        b=EgvqcFByBaYQgQOf+1WfzijlC9DG05S7F8J3ZT/Edz7WiO1FqTSga1Tjz4wD8rRGn
         RSX5plpFbjBhsplqVCY7DU/OgCRViSPnO+8/JRThIvpWhBIdpOHHePCiS2TzlIUPfY
         epdVFSgZOqIhjXckrT7LAUDVEyviHdKa0Jhpi/kE=
To:     =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
        David Howells <dhowells@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Eric Snowberg <eric.snowberg@oracle.com>
Cc:     =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
        keyrings@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Pearson <markpearson@lenovo.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: [PATCH v3 0/3] certs: Prevent spurious errors on repeated blacklisting
Date:   Fri, 18 Nov 2022 05:03:40 +0100
Message-Id: <20221118040343.2958-1-linux@weissschuh.net>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=ed25519-sha256; t=1668744217; l=1889; i=linux@weissschuh.net; s=20211113; h=from:subject; bh=fAGK24L9+iydhX7H00KM/0PHDgztpBEk6tzt350ufR8=; b=3O0IBdZlVc6afEe2yx3amLABDPmdlKOQ0y6Q1NdHBkNU7gqi3rWClo0U7FTRwF/FLxB0ldCATBYB TuAwo1R4B98AXFpXj1OhL9UhDl1AFmBytmhkd6jvpCP119VmKIF+
X-Developer-Key: i=linux@weissschuh.net; a=ed25519; pk=9LP6KM4vD/8CwHW7nouRBhWLyQLcK1MkP6aTZbzUlj4=
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

When the blacklist keyring was changed to allow updates from the root
user it gained an ->update() function that disallows all updates.
When the a hash is blacklisted multiple times from the builtin or
firmware-provided blacklist this spams prominent logs during boot:

[    0.890814] blacklist: Problem blacklisting hash (-13)

This affects the firmware of various vendors. Reported have been at least:
* Samsung: https://askubuntu.com/questions/1436856/
* Acer: https://ubuntuforums.org/showthread.php?t=2478840
* MSI: https://forum.archlabslinux.com/t/blacklist-problem-blacklisting-hash-13-errors-on-boot/6674/7
* Micro-Star: https://bbs.archlinux.org/viewtopic.php?id=278860
* Lenovo: https://lore.kernel.org/lkml/c8c65713-5cda-43ad-8018-20f2e32e4432@t-8ch.de/

Changelog:

v1: https://lore.kernel.org/all/20221104014704.3469-1-linux@weissschuh.net/
v1 -> v2:
 * Improve logging message to include the failed hash
 * Add key_create() function without update semantics
 * Use key_create() from mark_raw_hash_blacklisted() and log specific message
   on -EEXIST

v2: https://lore.kernel.org/lkml/20221109025019.1855-1-linux@weissschuh.net/
v2 -> v3:
 * Clarify commit titles and messages
 * Drop the change to BLACKLIST_KEY_PERM from patch 3, as it was an artifact
   of some obsolete version of the patch and not needed

Only the first patch has been marked for stable as otherwise the whole of
key_create() would need to be applied to stable.

Thomas Weißschuh (3):
  certs: log hash value on blacklist error
  KEYS: Add key_create()
  certs: don't try to update blacklist keys

 certs/blacklist.c   |  21 ++++---
 include/linux/key.h |   8 +++
 security/keys/key.c | 149 +++++++++++++++++++++++++++++++++-----------
 3 files changed, 132 insertions(+), 46 deletions(-)


base-commit: 84368d882b9688bfac77ce48d33b1e20a4e4a787
-- 
2.38.1

