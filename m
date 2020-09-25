Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44683278FCD
	for <lists+linux-integrity@lfdr.de>; Fri, 25 Sep 2020 19:44:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729620AbgIYRoq (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 25 Sep 2020 13:44:46 -0400
Received: from mx2.suse.de ([195.135.220.15]:60960 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726368AbgIYRoq (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 25 Sep 2020 13:44:46 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 26C30B20D;
        Fri, 25 Sep 2020 17:44:45 +0000 (UTC)
From:   Petr Vorel <pvorel@suse.cz>
To:     ltp@lists.linux.it
Cc:     Petr Vorel <pvorel@suse.cz>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        linux-integrity@vger.kernel.org
Subject: [PATCH 0/4] TPM 2.0 fixes in IMA tests
Date:   Fri, 25 Sep 2020 19:44:35 +0200
Message-Id: <20200925174439.9534-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi,

finally managed to fix most of the problems with TPM 2.0 and non-sha1
algorithms supported by 6f1a1d103b48 ima: ("Switch to ima_hash_algo for
boot aggregate") from v5.8-rc1.

I still have problem with boot aggregate (test1) which fails with TPM
2.0 on kernel < v5.8-rc1.

Any idea what's wrong?

Otherwise I'm quite confident with changes, I'd prefer to get it merge
to this release. But that'd require to be reviewed and tested ASAP
(ideally during Monday).

Kind regards,
Petr

Petr Vorel (4):
  IMA: Move get_algorithm_digest(), set_digest_index() to ima_setup.sh
  IMA: Rewrite ima_boot_aggregate.c to new API
  ima_tpm.sh: Fix calculating boot aggregate
  ima_tpm.sh: Fix calculating PCR aggregate

 .../integrity/ima/src/ima_boot_aggregate.c    | 110 ++++----
 .../integrity/ima/tests/ima_measurements.sh   |  62 +----
 .../security/integrity/ima/tests/ima_setup.sh |  70 ++++++
 .../security/integrity/ima/tests/ima_tpm.sh   | 238 +++++++++++++-----
 4 files changed, 311 insertions(+), 169 deletions(-)

-- 
2.28.0

