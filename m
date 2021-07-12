Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCB513C619C
	for <lists+linux-integrity@lfdr.de>; Mon, 12 Jul 2021 19:12:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230255AbhGLRPL (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 12 Jul 2021 13:15:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235102AbhGLRPK (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 12 Jul 2021 13:15:10 -0400
X-Greylist: delayed 523 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 12 Jul 2021 10:12:22 PDT
Received: from smtp-42aa.mail.infomaniak.ch (smtp-42aa.mail.infomaniak.ch [IPv6:2001:1600:4:17::42aa])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E9D2C0613DD
        for <linux-integrity@vger.kernel.org>; Mon, 12 Jul 2021 10:12:22 -0700 (PDT)
Received: from smtp-2-0000.mail.infomaniak.ch (unknown [10.5.36.107])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4GNqpw1W3mzMpxcH;
        Mon, 12 Jul 2021 19:03:36 +0200 (CEST)
Received: from localhost (unknown [23.97.221.149])
        by smtp-2-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4GNqpt2yXqzlh8TM;
        Mon, 12 Jul 2021 19:03:34 +0200 (CEST)
From:   =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To:     David Howells <dhowells@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Jarkko Sakkinen <jarkko@kernel.org>
Cc:     =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Snowberg <eric.snowberg@oracle.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        James Morris <jmorris@namei.org>,
        =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@linux.microsoft.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Tyler Hicks <tyhicks@linux.microsoft.com>,
        keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: [PATCH v8 0/5] Enable root to update the blacklist keyring
Date:   Mon, 12 Jul 2021 19:03:08 +0200
Message-Id: <20210712170313.884724-1-mic@digikod.net>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi,

This new patch series is a rebase on v5.14-rc1 .  David or Jarkko, if
it's still OK with you, could you please push this to linux-next?

I successfully tested this patch series with the 211 entries from
https://uefi.org/sites/default/files/resources/dbxupdate_x64.bin

The goal of these patches is to add a new configuration option to enable the
root user to load signed keys in the blacklist keyring.  This keyring is useful
to "untrust" certificates or files.  Enabling to safely update this keyring
without recompiling the kernel makes it more usable.

Previous patch series:
https://lore.kernel.org/lkml/20210312171232.2681989-1-mic@digikod.net/

Regards,

Mickaël Salaün (5):
  tools/certs: Add print-cert-tbs-hash.sh
  certs: Check that builtin blacklist hashes are valid
  certs: Make blacklist_vet_description() more strict
  certs: Factor out the blacklist hash creation
  certs: Allow root user to append signed hashes to the blacklist
    keyring

 MAINTAINERS                                   |   2 +
 certs/.gitignore                              |   1 +
 certs/Kconfig                                 |  17 +-
 certs/Makefile                                |  17 +-
 certs/blacklist.c                             | 218 ++++++++++++++----
 crypto/asymmetric_keys/x509_public_key.c      |   3 +-
 include/keys/system_keyring.h                 |  14 +-
 scripts/check-blacklist-hashes.awk            |  37 +++
 .../platform_certs/keyring_handler.c          |  26 +--
 tools/certs/print-cert-tbs-hash.sh            |  91 ++++++++
 10 files changed, 346 insertions(+), 80 deletions(-)
 create mode 100755 scripts/check-blacklist-hashes.awk
 create mode 100755 tools/certs/print-cert-tbs-hash.sh


base-commit: e73f0f0ee7541171d89f2e2491130c7771ba58d3
-- 
2.32.0

