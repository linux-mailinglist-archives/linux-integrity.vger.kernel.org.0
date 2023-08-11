Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C48C779B7D
	for <lists+linux-integrity@lfdr.de>; Sat, 12 Aug 2023 01:40:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237258AbjHKXkP (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 11 Aug 2023 19:40:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237257AbjHKXkL (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 11 Aug 2023 19:40:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE8C810F5
        for <linux-integrity@vger.kernel.org>; Fri, 11 Aug 2023 16:40:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5D6B167BFE
        for <linux-integrity@vger.kernel.org>; Fri, 11 Aug 2023 23:40:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1867AC433D9;
        Fri, 11 Aug 2023 23:40:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691797209;
        bh=QP5pGF3PO9EU2FA/xvRlheSZKOUjrm1q1NzOo0tPlNg=;
        h=From:To:Cc:Subject:Date:From;
        b=iXMlQ9lm3NrgiRF8VVeDDQFJ7Y3aMICJnxQ+QsFj1gNyVQL6yXg+G2qCT19MhefUG
         wcA1GeOuxmI3MnkcOnppc3GCzpBhyP+DR3BYa0QwUjm9f0Oe/E9DCbgwE4gjJ8gSYE
         lOxn6Mm/CqCEzI09gfsfgpQ5rR4F8RQ98++FdcWN79o6WttSoprtidCPnXlAlNG4jM
         WoSPffXwXB14PIfDR9Mnrww7+Umc6mhpnRZcRL8/Tj7fdxNyIyNxpaP8WNLmcQIsFY
         aUa/qs3uZLZCpJzkpefdaDeCtQvcTRFBWTmgJT0qkoaewuViIr50FwNz4TRPflLA7j
         8oGggbMQJiJLw==
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     linux-integrity@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jarkko Sakkinen <jarkko@kernel.org>
Subject: [PATCH 0/2] tpm_tis: opt-in interrupts
Date:   Sat, 12 Aug 2023 02:40:00 +0300
Message-Id: <20230811234002.2656180-1-jarkko@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hopefully the last IRQ fixes for some time.

Jarkko Sakkinen (1):
  tpm_tis: Opt-in interrupts

Peter Ujfalusi (1):
  tpm: tpm_tis: Fix UPX-i11 DMI_MATCH condition

 drivers/char/tpm/tpm_tis.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

-- 
2.39.2

