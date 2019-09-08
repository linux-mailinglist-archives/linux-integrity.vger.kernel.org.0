Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5A7EAACA1B
	for <lists+linux-integrity@lfdr.de>; Sun,  8 Sep 2019 02:10:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727885AbfIHAK3 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sat, 7 Sep 2019 20:10:29 -0400
Received: from mga01.intel.com ([192.55.52.88]:34383 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727850AbfIHAK3 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 7 Sep 2019 20:10:29 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Sep 2019 17:10:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,478,1559545200"; 
   d="scan'208";a="174625058"
Received: from andriiza-mobl.ger.corp.intel.com ([10.252.38.198])
  by orsmga007.jf.intel.com with ESMTP; 07 Sep 2019 17:10:24 -0700
Message-ID: <c253ca7292b397f1352d2ee00fce0b011f84abff.camel@linux.intel.com>
Subject: KEYS-TRUSTED git
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     linux-integrity@vger.kernel.org
Cc:     zohar@linux.ibm.com, jejb@linux.ibm.com, dhowells@redhat.com,
        sumit.garg@linaro.org
Date:   Sun, 08 Sep 2019 03:10:23 +0300
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.2-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

It seems that at least vast majority of the trusted keys patches flow
through my tree to the mainline. Still, it is undocumented in the
MAINTAINERS file.

So, should I just add my TPM tree as the upstream there? Or should I
just create a new GIT for trusted keys? My TPM PR goes to Linux ATM.
Should my trusted keys PR go to David instead? That would definitely
require own tree.

With Sumit's recent work trusted keys is turning more than just being
TPM keys so now it is a good time to consider the flow... Sumit, I'm
sorry that I haven't added your first series yet. I need to first sync
up how we are going to move forward.

/Jarkko

