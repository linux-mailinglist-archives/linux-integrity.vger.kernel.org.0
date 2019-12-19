Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CEA86125905
	for <lists+linux-integrity@lfdr.de>; Thu, 19 Dec 2019 02:03:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726742AbfLSBD0 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 18 Dec 2019 20:03:26 -0500
Received: from mga17.intel.com ([192.55.52.151]:19284 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726518AbfLSBDZ (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 18 Dec 2019 20:03:25 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Dec 2019 17:03:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,330,1571727600"; 
   d="scan'208";a="417435276"
Received: from jtreacy-mobl1.ger.corp.intel.com (HELO localhost) ([10.251.82.127])
  by fmsmga006.fm.intel.com with ESMTP; 18 Dec 2019 17:03:22 -0800
Date:   Thu, 19 Dec 2019 03:03:17 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        keyrings@vger.kernel.org, jmorris@namei.org, dhowells@redhat.com
Subject: [GIT PULL] tpmdd updates for Linux v5.5-rc3
Message-ID: <20191219010317.GA3086@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Bunch of fixes for rc3.

/Jarkko

The following changes since commit 37d4e84f765bb3038ddfeebdc5d1cfd7e1ef688f:

  Merge tag 'ceph-for-5.5-rc2' of git://github.com/ceph/ceph-client (2019-12-12 10:56:37 -0800)

are available in the Git repository at:

  git://git.infradead.org/users/jjs/linux-tpmdd.git tpmdd-next-20191219

for you to fetch changes up to 1760eb689ed68c6746744aff2092bff57c78d907:

  tpm/tpm_ftpm_tee: add shutdown call back (2019-12-19 02:31:28 +0200)

----------------------------------------------------------------
tpmdd fixes for Linux v5.5-rc3

----------------------------------------------------------------
Eric Biggers (2):
      KEYS: remove CONFIG_KEYS_COMPAT
      KEYS: asymmetric: return ENOMEM if akcipher_request_alloc() fails

James Bottomley (1):
      security: keys: trusted: fix lost handle flush

Jerry Snitselaar (1):
      tpm_tis: reserve chip for duration of tpm_tis_core_init

Pavel Tatashin (1):
      tpm/tpm_ftpm_tee: add shutdown call back

Tadeusz Struk (3):
      tpm: fix invalid locking in NONBLOCKING mode
      tpm: selftest: add test covering async mode
      tpm: selftest: cleanup after unseal with wrong auth/policy test

 crypto/asymmetric_keys/asym_tpm.c          |  1 +
 crypto/asymmetric_keys/public_key.c        |  1 +
 drivers/char/tpm/tpm-dev-common.c          |  8 +++++++
 drivers/char/tpm/tpm.h                     |  1 -
 drivers/char/tpm/tpm2-cmd.c                |  1 +
 drivers/char/tpm/tpm_ftpm_tee.c            | 22 +++++++++++++++----
 drivers/char/tpm/tpm_tis_core.c            | 35 +++++++++++++++---------------
 include/linux/tpm.h                        |  1 +
 security/keys/Kconfig                      |  4 ----
 security/keys/Makefile                     |  2 +-
 security/keys/compat.c                     |  5 -----
 security/keys/internal.h                   |  4 ++--
 security/keys/trusted-keys/trusted_tpm2.c  |  1 +
 tools/testing/selftests/tpm2/test_smoke.sh |  6 +++++
 tools/testing/selftests/tpm2/tpm2.py       | 19 ++++++++++++++--
 tools/testing/selftests/tpm2/tpm2_tests.py | 13 +++++++++++
 16 files changed, 88 insertions(+), 36 deletions(-)
