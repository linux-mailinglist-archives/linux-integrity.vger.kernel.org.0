Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 28F9F144DFA
	for <lists+linux-integrity@lfdr.de>; Wed, 22 Jan 2020 09:53:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725911AbgAVIxm (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 22 Jan 2020 03:53:42 -0500
Received: from mga03.intel.com ([134.134.136.65]:1625 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725862AbgAVIxm (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 22 Jan 2020 03:53:42 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Jan 2020 00:53:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,348,1574150400"; 
   d="scan'208";a="282907476"
Received: from rscales-mobl2.ger.corp.intel.com (HELO localhost) ([10.251.84.164])
  by fmsmga001.fm.intel.com with ESMTP; 22 Jan 2020 00:53:37 -0800
Date:   Wed, 22 Jan 2020 10:53:35 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        jmorris@namei.org, jsnitsel@redhat.com
Subject: [GIT PULL] tpmdd updates for Linux v5.6
Message-ID: <20200122085335.GA9383@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi,

This update adds a new sysfs file for querying TPM major version,
which can be used by the user space the TPM protocol used to
communicate with the chip.

/Jarkko

The following changes since commit d96d875ef5dd372f533059a44f98e92de9cf0d42:

  Merge tag 'fixes_for_v5.5-rc8' of git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs (2020-01-20 11:24:13 -0800)

are available in the Git repository at:

  git://git.infradead.org/users/jjs/linux-tpmdd.git tags/tpmdd-next-20200122

for you to fetch changes up to 7084eddf6be94e73f8298c1a28078b91536f2975:

  tpm: Add tpm_version_major sysfs file (2020-01-22 10:46:51 +0200)

----------------------------------------------------------------
tpmdd updates for Linux v5.6

----------------------------------------------------------------
Jerry Snitselaar (2):
      tpm: Update mailing list contact information in sysfs-class-tpm
      tpm: Add tpm_version_major sysfs file

 Documentation/ABI/stable/sysfs-class-tpm | 33 ++++++++++++++++++++-----------
 drivers/char/tpm/tpm-sysfs.c             | 34 +++++++++++++++++++++++++-------
 2 files changed, 49 insertions(+), 18 deletions(-)
