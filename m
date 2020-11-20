Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 209C62BB1F1
	for <lists+linux-integrity@lfdr.de>; Fri, 20 Nov 2020 19:06:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729002AbgKTSEg (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 20 Nov 2020 13:04:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728505AbgKTSEg (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 20 Nov 2020 13:04:36 -0500
Received: from smtp-8fac.mail.infomaniak.ch (smtp-8fac.mail.infomaniak.ch [IPv6:2001:1600:4:17::8fac])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C20DC0617A7
        for <linux-integrity@vger.kernel.org>; Fri, 20 Nov 2020 10:04:36 -0800 (PST)
Received: from smtp-2-0001.mail.infomaniak.ch (unknown [10.5.36.108])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4Cd4FF3WcZzlhSjB;
        Fri, 20 Nov 2020 19:04:33 +0100 (CET)
Received: from localhost (unknown [94.23.54.103])
        by smtp-2-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4Cd4FD09NRzlh8T4;
        Fri, 20 Nov 2020 19:04:31 +0100 (CET)
From:   =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To:     David Howells <dhowells@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>
Cc:     =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
        "David S . Miller" <davem@davemloft.net>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        James Morris <jmorris@namei.org>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@linux.microsoft.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        "Serge E . Hallyn" <serge@hallyn.com>, keyrings@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: [PATCH v1 0/9] Enable root to update the blacklist keyring
Date:   Fri, 20 Nov 2020 19:04:17 +0100
Message-Id: <20201120180426.922572-1-mic@digikod.net>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi,

This patch series mainly add a new configuration option to enable the
root user to load signed keys in the blacklist keyring.  This keyring is
useful to "untrust" certificates or files.  Enabling to safely update
this keyring without recompiling the kernel makes it more usable.

Regards,

Mickaël Salaün (9):
  certs: Fix blacklisted hexadecimal hash string check
  certs: Make blacklist_vet_description() more strict
  certs: Factor out the blacklist hash creation
  certs: Check that builtin blacklist hashes are valid
  PKCS#7: Fix missing include
  certs: Fix blacklist flag type confusion
  certs: Allow root user to append signed hashes to the blacklist
    keyring
  certs: Replace K{U,G}IDT_INIT() with GLOBAL_ROOT_{U,G}ID
  tools/certs: Add print-cert-tbs-hash.sh

 MAINTAINERS                                   |   2 +
 certs/.gitignore                              |   1 +
 certs/Kconfig                                 |  10 +
 certs/Makefile                                |  15 +-
 certs/blacklist.c                             | 210 +++++++++++++-----
 certs/system_keyring.c                        |   5 +-
 crypto/asymmetric_keys/x509_public_key.c      |   3 +-
 include/keys/system_keyring.h                 |  14 +-
 include/linux/verification.h                  |   2 +
 scripts/check-blacklist-hashes.awk            |  37 +++
 .../platform_certs/keyring_handler.c          |  26 +--
 tools/certs/print-cert-tbs-hash.sh            |  91 ++++++++
 12 files changed, 335 insertions(+), 81 deletions(-)
 create mode 100755 scripts/check-blacklist-hashes.awk
 create mode 100755 tools/certs/print-cert-tbs-hash.sh


base-commit: 09162bc32c880a791c6c0668ce0745cf7958f576
-- 
2.29.2

