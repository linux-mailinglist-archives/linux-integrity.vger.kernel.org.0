Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A2D2622233
	for <lists+linux-integrity@lfdr.de>; Wed,  9 Nov 2022 03:50:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229988AbiKICug (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 8 Nov 2022 21:50:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229867AbiKICuf (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 8 Nov 2022 21:50:35 -0500
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B62F1F9DD;
        Tue,  8 Nov 2022 18:50:34 -0800 (PST)
From:   =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=weissschuh.net;
        s=mail; t=1667962230;
        bh=sRBb1yoX5FkhrIkmhhnkMlMgMwZoHsWyWpPUUDhCe1A=;
        h=From:To:Cc:Subject:Date:From;
        b=ak7T7+oRpA3erDu1wQ3UgJ9+njLjl0ooywpMrO9E2TQReGV77M6io1GeUyqJ5PjKz
         KsFSLoEJBCcoKbzoaBQj2DZUdon7iKxJ3a1ecUWBtEl0Q8VwU1zB2MUSQh3oib1U4I
         Be939Vqs0G3jizW1V4dcRC4kcVxgKCxzow/spxBs=
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
Subject: [PATCH v2 0/3] certs: Prevent spurious errors on repeated blacklisting
Date:   Wed,  9 Nov 2022 03:50:16 +0100
Message-Id: <20221109025019.1855-1-linux@weissschuh.net>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=ed25519-sha256; t=1667962214; l=1370; s=20211113; h=from:subject; bh=sRBb1yoX5FkhrIkmhhnkMlMgMwZoHsWyWpPUUDhCe1A=; b=/FQehqL8oo8cDEvahT+bddamTe3EHhG1k4Xm2iu/e0fdzh+kZ3cQJr+iQWeiWRrEF0sxCWqO/6Z7 0noAI3i7CYaMUGKPSch6B469ssLVsPrwFF2X98m1zrCHluYkpWDD
X-Developer-Key: i=linux@weissschuh.net; a=ed25519; pk=9LP6KM4vD/8CwHW7nouRBhWLyQLcK1MkP6aTZbzUlj4=
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
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

This series is an extension of the following single patch:
https://lore.kernel.org/all/20221104014704.3469-1-linux@weissschuh.net/

Only the first patch has been marked for stable as otherwise the whole of
key_create() would need to be applied to stable.

Thomas Weißschuh (3):
  certs: log more information on blacklist error
  KEYS: Add key_create()
  certs: don't try to update blacklist keys

 certs/blacklist.c   |  23 ++++---
 include/linux/key.h |   8 +++
 security/keys/key.c | 149 +++++++++++++++++++++++++++++++++-----------
 3 files changed, 133 insertions(+), 47 deletions(-)


base-commit: f141df371335645ce29a87d9683a3f79fba7fd67
-- 
2.38.1

