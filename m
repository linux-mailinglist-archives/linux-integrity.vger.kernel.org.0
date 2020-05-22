Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A06F11DEC9B
	for <lists+linux-integrity@lfdr.de>; Fri, 22 May 2020 17:58:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730326AbgEVP6K (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 22 May 2020 11:58:10 -0400
Received: from mga01.intel.com ([192.55.52.88]:44577 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730197AbgEVP6K (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 22 May 2020 11:58:10 -0400
IronPort-SDR: kzZO4hNQgtnHm9zy2XtkNZfjq79tHzZbaVlIbnSLwS7AO1ZNr7z6o8JVwt3HylXpYIm9+tmqIe
 MGWPZeoUIhXQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2020 08:58:08 -0700
IronPort-SDR: pkK/fLJCumwrB+oyEPmtCK6vCTNlGzgU8s2v3iqTADOPYUBjuVlau2cK9bmkOEsbr+pAUrX7Wi
 y0YDZuyjMvKw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,422,1583222400"; 
   d="scan'208";a="440893711"
Received: from omillerx-mobl.ger.corp.intel.com (HELO localhost) ([10.249.43.59])
  by orsmga005.jf.intel.com with ESMTP; 22 May 2020 08:58:06 -0700
Date:   Fri, 22 May 2020 18:58:06 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        jmorris@namei.org, dhowells@redhat.com
Subject: [GIT PULL] tpmdd updates for Linux v5.8
Message-ID: <20200522155806.GA9053@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi,

Updates for Linux v5.8.

/Jarkko

The following changes since commit 051143e1602d90ea71887d92363edd539d411de5:

  Merge tag 'apparmor-pr-2020-05-21' of git://git.kernel.org/pub/scm/linux/kernel/git/jj/linux-apparmor (2020-05-21 16:43:35 -0700)

are available in the Git repository at:

  git://git.infradead.org/users/jjs/linux-tpmdd.git tags/tpmdd-next-20200522

for you to fetch changes up to ab91c2a89f86be2898cee208d492816ec238b2cf:

  tpm: eventlog: Replace zero-length array with flexible-array member (2020-05-22 18:50:12 +0300)

----------------------------------------------------------------
tpmdd updates for Linux v5.8

----------------------------------------------------------------
Andy Shevchenko (1):
      tpm/tpm_ftpm_tee: Use UUID API for exporting the UUID

Gustavo A. R. Silva (1):
      tpm: eventlog: Replace zero-length array with flexible-array member

 drivers/char/tpm/eventlog/tpm2.c | 12 +++++-------
 drivers/char/tpm/tpm_ftpm_tee.c  |  2 +-
 include/linux/tpm_eventlog.h     |  2 +-
 3 files changed, 7 insertions(+), 9 deletions(-)
