Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6A3C2163DD
	for <lists+linux-integrity@lfdr.de>; Tue,  7 Jul 2020 04:21:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727038AbgGGCVV (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 6 Jul 2020 22:21:21 -0400
Received: from mga07.intel.com ([134.134.136.100]:30154 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726681AbgGGCVV (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 6 Jul 2020 22:21:21 -0400
IronPort-SDR: q+yYQk3py6SreB3YnA4yB2GAJPF0gfBEyUmEMMlERsF8XIo6TnvOzdEduVikvQizjHQfw0Pxnw
 T9SvP3o0hfGA==
X-IronPort-AV: E=McAfee;i="6000,8403,9674"; a="212501153"
X-IronPort-AV: E=Sophos;i="5.75,321,1589266800"; 
   d="scan'208";a="212501153"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2020 19:21:20 -0700
IronPort-SDR: 1Tb4ZIn9NzcwMF4xQ2bPjw67O91GeE9Y169FBPjDXnsqgupoHxzuNpW7UHgtoTloBTsROnrXsH
 jSYcU1ake7WA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,321,1589266800"; 
   d="scan'208";a="297198340"
Received: from pakumpul-mobl.ger.corp.intel.com (HELO localhost) ([10.252.52.16])
  by orsmga002.jf.intel.com with ESMTP; 06 Jul 2020 19:21:16 -0700
Date:   Tue, 7 Jul 2020 05:21:14 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        jmorris@namei.org, dhowells@redhat.com, peterhuewe@gmx.de
Subject: [GIT PULL] tpmdd updates for Linux v5.8-rc5
Message-ID: <20200707022114.GA112019@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi,

I quote directly the commit message to explain this PR:

    Revert commit e918e570415c ("tpm_tis: Remove the HID IFX0102")

    Removing IFX0102 from tpm_tis was not a right move because both tpm_tis
    and tpm_infineon use the same device ID. Revert the commit and add a
    remark about a bug caused by commit 93e1b7d42e1e ("[PATCH] tpm: add HID
    module parameter").

A real fix requires quirks added to both drivers. It can probably wait
until v5.9 as the bug has existed since 2006.

/Jarkko

The following changes since commit 786a2aa281f4c4ba424ea8b8ea1e85ab62c4a57c:

  Revert commit e918e570415c ("tpm_tis: Remove the HID IFX0102") (2020-07-07 04:25:17 +0300)

are available in the Git repository at:

  git://git.infradead.org/users/jjs/linux-tpmdd.git tags/tpmdd-next-v5.8-rc5

for you to fetch changes up to 786a2aa281f4c4ba424ea8b8ea1e85ab62c4a57c:

  Revert commit e918e570415c ("tpm_tis: Remove the HID IFX0102") (2020-07-07 04:25:17 +0300)

----------------------------------------------------------------
tpmdd updates for Linux v5.8-rc5

----------------------------------------------------------------
