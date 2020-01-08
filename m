Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5487C134779
	for <lists+linux-integrity@lfdr.de>; Wed,  8 Jan 2020 17:16:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729257AbgAHQQ3 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 8 Jan 2020 11:16:29 -0500
Received: from mga03.intel.com ([134.134.136.65]:31564 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728899AbgAHQQ2 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 8 Jan 2020 11:16:28 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Jan 2020 08:16:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,410,1571727600"; 
   d="scan'208";a="211584654"
Received: from dkurtaev-mobl.ccr.corp.intel.com (HELO localhost) ([10.252.22.167])
  by orsmga007.jf.intel.com with ESMTP; 08 Jan 2020 08:16:25 -0800
Date:   Wed, 8 Jan 2020 18:16:25 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        jmorris@namei.org, Tadeusz Struk <tadeusz.struk@intel.com>,
        Laura Abbott <labbott@redhat.com>
Subject: [GIT PULL] tpmdd fixes for Linux v5.5-rc6 part 2
Message-ID: <20200108161625.GA16812@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

One critical bug fix (the faulting commit is in previous rc) for the
release.

/Jarkko

The following changes since commit ae6088216ce4b99b3a4aaaccd2eb2dd40d473d42:

  Merge tag 'trace-v5.5-rc5' of git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace (2020-01-06 15:38:38 -0800)

are available in the Git repository at:

  git://git.infradead.org/users/jjs/linux-tpmdd.git tags/tpmdd-next-20200108

for you to fetch changes up to a430e67d9a2c62a8c7b315b99e74de02018d0a96:

  tpm: Handle negative priv->response_len in tpm_common_read() (2020-01-08 18:11:09 +0200)

----------------------------------------------------------------
tpmdd fixes for Linux v5.5-rc6 part 2

----------------------------------------------------------------
Tadeusz Struk (1):
      tpm: Handle negative priv->response_len in tpm_common_read()

 drivers/char/tpm/tpm-dev-common.c | 2 +-
 drivers/char/tpm/tpm-dev.h        | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)
