Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 33151BD5A9
	for <lists+linux-integrity@lfdr.de>; Wed, 25 Sep 2019 02:02:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2411134AbfIYACS (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 24 Sep 2019 20:02:18 -0400
Received: from mga03.intel.com ([134.134.136.65]:12839 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2411144AbfIYACS (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 24 Sep 2019 20:02:18 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Sep 2019 17:02:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,545,1559545200"; 
   d="scan'208";a="218812189"
Received: from wujunyox-mobl3.ger.corp.intel.com (HELO localhost) ([10.249.38.101])
  by fmsmga002.fm.intel.com with ESMTP; 24 Sep 2019 17:02:14 -0700
Date:   Wed, 25 Sep 2019 03:02:14 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        jmorris@namei.org
Subject: [GIT PULL] tpmdd fixes for Linux v5.4-rc1
Message-ID: <20190925000214.GA23372@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi

These are bug fixes for bugs found after my v5.4 PR.

/Jarkko

The following changes since commit 4c07e2ddab5b6b57dbcb09aedbda1f484d5940cc:

  Merge tag 'mfd-next-5.4' of git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd (2019-09-23 19:37:49 -0700)

are available in the Git repository at:

  git://git.infradead.org/users/jjs/linux-tpmdd.git tags/tpmdd-next-20190925

for you to fetch changes up to e13cd21ffd50a07b55dcc4d8c38cedf27f28eaa1:

  tpm: Wrap the buffer from the caller to tpm_buf in tpm_send() (2019-09-25 02:43:57 +0300)

----------------------------------------------------------------
tpmdd fixes for Linux v5.4

----------------------------------------------------------------
Denis Efremov (1):
      MAINTAINERS: keys: Update path to trusted.h

Jarkko Sakkinen (2):
      selftests/tpm2: Add the missing TEST_FILES assignment
      tpm: Wrap the buffer from the caller to tpm_buf in tpm_send()

Petr Vorel (1):
      selftests/tpm2: Add log and *.pyc to .gitignore

Roberto Sassu (1):
      KEYS: trusted: correctly initialize digests and fix locking issue

 MAINTAINERS                           |  2 +-
 drivers/char/tpm/tpm-interface.c      | 23 +++++++++++------------
 security/keys/trusted.c               |  5 +++++
 tools/testing/selftests/.gitignore    |  2 ++
 tools/testing/selftests/tpm2/Makefile |  1 +
 5 files changed, 20 insertions(+), 13 deletions(-)
