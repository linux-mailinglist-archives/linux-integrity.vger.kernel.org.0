Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AA911B18BD
	for <lists+linux-integrity@lfdr.de>; Mon, 20 Apr 2020 23:48:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726017AbgDTVsO (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 20 Apr 2020 17:48:14 -0400
Received: from mga02.intel.com ([134.134.136.20]:15689 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725989AbgDTVsO (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 20 Apr 2020 17:48:14 -0400
IronPort-SDR: 9frrKV46KuwmbWblhF+O8cgoMnzwUdhkQAkeunz9nzpO56mxBoyR5RgAwO7XvxPq2F92DBWpuQ
 YxJoJ4T+GBAw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2020 14:48:13 -0700
IronPort-SDR: crFMZitCyHyHevt9Chd0Qsy9sdQY2NzF+PR0zyZTPhWnZADfKIwlmY1kqcGTofnf3Hyd2KUo99
 qh0vCGzONgIg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,407,1580803200"; 
   d="scan'208";a="300405813"
Received: from rpirker-mobl2.ger.corp.intel.com (HELO localhost) ([10.252.46.184])
  by FMSMGA003.fm.intel.com with ESMTP; 20 Apr 2020 14:48:10 -0700
Date:   Tue, 21 Apr 2020 00:48:07 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        jmorris@namei.org, dhowells@redhat.com
Subject: [GIT PULL] tpmdd updates for Linux v5.7-rc3
Message-ID: <20200420214744.GA18862@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

A few bug fixes for rc3.

/Jarkko

The following changes since commit ae83d0b416db002fe95601e7f97f64b59514d936:

  Linux 5.7-rc2 (2020-04-19 14:35:30 -0700)

are available in the Git repository at:

  git://git.infradead.org/users/jjs/linux-tpmdd.git tags/tpmdd-next-20200421

for you to fetch changes up to b160c94be5d2816b62c8ac338605668304242959:

  tpm/tpm_tis: Free IRQ if probing fails (2020-04-21 00:06:13 +0300)

----------------------------------------------------------------
tpmdd updates for Linux v5.6-rc3

----------------------------------------------------------------
George Wilson (1):
      tpm: ibmvtpm: retry on H_CLOSED in tpm_ibmvtpm_send()

Jarkko Sakkinen (1):
      tpm/tpm_tis: Free IRQ if probing fails

Stefan Berger (1):
      tpm: Export tpm2_get_cc_attrs_tbl for ibmvtpm driver as module

Tianjia Zhang (1):
      tpm: fix wrong return value in tpm_pcr_extend

 drivers/char/tpm/tpm-interface.c |   2 +-
 drivers/char/tpm/tpm2-cmd.c      |   1 +
 drivers/char/tpm/tpm_ibmvtpm.c   | 136 +++++++++++++++++++++------------------
 drivers/char/tpm/tpm_tis_core.c  |   8 ++-
 4 files changed, 82 insertions(+), 65 deletions(-)
