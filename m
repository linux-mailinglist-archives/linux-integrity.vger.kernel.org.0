Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6E0248BF33
	for <lists+linux-integrity@lfdr.de>; Tue, 13 Aug 2019 19:05:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726126AbfHMRFc (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 13 Aug 2019 13:05:32 -0400
Received: from mga01.intel.com ([192.55.52.88]:16662 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726094AbfHMRFb (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 13 Aug 2019 13:05:31 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Aug 2019 10:05:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,382,1559545200"; 
   d="scan'208";a="177857549"
Received: from hgenzken-mobl.ger.corp.intel.com (HELO localhost) ([10.252.53.32])
  by fmsmga007.fm.intel.com with ESMTP; 13 Aug 2019 10:05:29 -0700
Date:   Tue, 13 Aug 2019 20:05:28 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        jmorris@namei.org, roberto.sassu@huawei.com
Subject: [GIT PULL] tpmdd fixes for Linux v5.3-rc4
Message-ID: <20190813170528.6w6s5d6ka4lzpzq5@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: NeoMutt/20180716
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi

One more bug fix for the next release.

/Jarkko

The following changes since commit d45331b00ddb179e291766617259261c112db872:

  Linux 5.3-rc4 (2019-08-11 13:26:41 -0700)

are available in the Git repository at:

  git://git.infradead.org/users/jjs/linux-tpmdd.git tags/tpmdd-next-20190813

for you to fetch changes up to 2d6c25215ab26bb009de3575faab7b685f138e92:

  KEYS: trusted: allow module init if TPM is inactive or deactivated (2019-08-13 19:59:23 +0300)

----------------------------------------------------------------
tpmdd fixes for Linux v5.3-rc4

----------------------------------------------------------------
Roberto Sassu (1):
      KEYS: trusted: allow module init if TPM is inactive or deactivated

 security/keys/trusted.c | 13 -------------
 1 file changed, 13 deletions(-)
