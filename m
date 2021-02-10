Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 878DB3165F6
	for <lists+linux-integrity@lfdr.de>; Wed, 10 Feb 2021 13:05:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229702AbhBJMFl (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 10 Feb 2021 07:05:41 -0500
Received: from smtp-bc0d.mail.infomaniak.ch ([45.157.188.13]:57043 "EHLO
        smtp-bc0d.mail.infomaniak.ch" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229863AbhBJMEj (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 10 Feb 2021 07:04:39 -0500
Received: from smtp-2-0001.mail.infomaniak.ch (unknown [10.5.36.108])
        by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4DbJM90QZBzMqW88;
        Wed, 10 Feb 2021 13:03:49 +0100 (CET)
Received: from localhost (unknown [23.97.221.149])
        by smtp-2-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4DbJM65mq6zlh8Tk;
        Wed, 10 Feb 2021 13:03:46 +0100 (CET)
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
Subject: [PATCH v6 0/5] Enable root to update the blacklist keyring
Date:   Wed, 10 Feb 2021 13:04:05 +0100
Message-Id: <20210210120410.471693-1-mic@digikod.net>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

This new patch series is a rebase on David Howells's keys-misc branch.
This mainly fixes UEFI DBX and the new Eric Snowberg's feature to import
asymmetric keys to the blacklist keyring.
I successfully tested this patch series with the 186 entries from
https://uefi.org/sites/default/files/resources/dbxupdate_x64.bin (184
binary hashes and 2 certificates).

The goal of these patches is to add a new configuration option to enable the
root user to load signed keys in the blacklist keyring.  This keyring is useful
to "untrust" certificates or files.  Enabling to safely update this keyring
without recompiling the kernel makes it more usable.

This can be applied on top of David Howells's keys-next branch:
https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/log/?h=keys-next
Git commits can be found in https://github.com/l0kod/linux branch
dyn-auth-blacklist-v6 commit fcf976b74ffcd4551683e6b70dbf5fb102cf9906 .

Previous patch series:
https://lore.kernel.org/lkml/20210128191705.3568820-1-mic@digikod.net/

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


base-commit: 5bcd72358a7d7794ade0452ed12919b8c4d6ffc7
-- 
2.30.0

