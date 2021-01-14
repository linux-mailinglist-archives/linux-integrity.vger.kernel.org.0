Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A21BA2F6465
	for <lists+linux-integrity@lfdr.de>; Thu, 14 Jan 2021 16:25:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729619AbhANPVX (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 14 Jan 2021 10:21:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729307AbhANPVX (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 14 Jan 2021 10:21:23 -0500
Received: from smtp-8fae.mail.infomaniak.ch (smtp-8fae.mail.infomaniak.ch [IPv6:2001:1600:4:17::8fae])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26942C06179E
        for <linux-integrity@vger.kernel.org>; Thu, 14 Jan 2021 07:19:51 -0800 (PST)
Received: from smtp-2-0001.mail.infomaniak.ch (unknown [10.5.36.108])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4DGnyv17ylzMprrf;
        Thu, 14 Jan 2021 16:19:03 +0100 (CET)
Received: from localhost (unknown [23.97.221.149])
        by smtp-2-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4DGnys0Ff7zlh8TH;
        Thu, 14 Jan 2021 16:19:00 +0100 (CET)
From:   =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To:     David Howells <dhowells@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Jarkko Sakkinen <jarkko@kernel.org>
Cc:     =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
        "David S . Miller" <davem@davemloft.net>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        James Morris <jmorris@namei.org>,
        =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@linux.microsoft.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        "Serge E . Hallyn" <serge@hallyn.com>, keyrings@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: [PATCH v3 00/10] Enable root to update the blacklist keyring
Date:   Thu, 14 Jan 2021 16:18:59 +0100
Message-Id: <20210114151909.2344974-1-mic@digikod.net>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

This third patch series includes back three fix patches taken from the first
series (and cherry-picked from David Howells's tree [1]), and one cosmetic fix
from Alex Shi which helps avoid future conflicts.  I also added some Acked-by
and improved comments.  As requested, this series is based on v5.11-rc3.

The goal of these patches is to add a new configuration option to enable the
root user to load signed keys in the blacklist keyring.  This keyring is useful
to "untrust" certificates or files.  Enabling to safely update this keyring
without recompiling the kernel makes it more usable.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/log/?h=keys-fixes

Previous patch series:
https://lore.kernel.org/lkml/20201211190330.2586116-1-mic@digikod.net/

Regards,

Alex Shi (1):
  certs/blacklist: fix kernel doc interface issue

David Howells (1):
  certs: Fix blacklist flag type confusion

Mickaël Salaün (8):
  certs: Fix blacklisted hexadecimal hash string check
  PKCS#7: Fix missing include
  certs: Replace K{U,G}IDT_INIT() with GLOBAL_ROOT_{U,G}ID
  certs: Make blacklist_vet_description() more strict
  certs: Factor out the blacklist hash creation
  certs: Check that builtin blacklist hashes are valid
  certs: Allow root user to append signed hashes to the blacklist
    keyring
  tools/certs: Add print-cert-tbs-hash.sh

 MAINTAINERS                                   |   2 +
 certs/.gitignore                              |   1 +
 certs/Kconfig                                 |  10 +
 certs/Makefile                                |  15 +-
 certs/blacklist.c                             | 217 ++++++++++++++----
 certs/system_keyring.c                        |   5 +-
 crypto/asymmetric_keys/x509_public_key.c      |   3 +-
 include/keys/system_keyring.h                 |  14 +-
 include/linux/key.h                           |   1 +
 include/linux/verification.h                  |   2 +
 scripts/check-blacklist-hashes.awk            |  37 +++
 security/integrity/ima/ima_mok.c              |   4 +-
 .../platform_certs/keyring_handler.c          |  26 +--
 security/keys/key.c                           |   2 +
 tools/certs/print-cert-tbs-hash.sh            |  91 ++++++++
 15 files changed, 345 insertions(+), 85 deletions(-)
 create mode 100755 scripts/check-blacklist-hashes.awk
 create mode 100755 tools/certs/print-cert-tbs-hash.sh


base-commit: 7c53f6b671f4aba70ff15e1b05148b10d58c2837
-- 
2.30.0

