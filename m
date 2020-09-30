Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CA6B27EE20
	for <lists+linux-integrity@lfdr.de>; Wed, 30 Sep 2020 18:02:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728076AbgI3QCV (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 30 Sep 2020 12:02:21 -0400
Received: from mx2.suse.de ([195.135.220.15]:50400 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725385AbgI3QCU (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 30 Sep 2020 12:02:20 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id DC417AE02;
        Wed, 30 Sep 2020 16:02:19 +0000 (UTC)
From:   Petr Vorel <pvorel@suse.cz>
To:     ltp@lists.linux.it
Cc:     Petr Vorel <pvorel@suse.cz>, Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        linux-integrity@vger.kernel.org
Subject: [PATCH v4 0/4] TPM 2.0 fixes in IMA tests
Date:   Wed, 30 Sep 2020 18:02:10 +0200
Message-Id: <20200930160214.29358-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Mimi, Lakshmi,

changes v3->v4:

test1:
* require 1.3.1 instead of 1.3 (simplification)

test2
* use --ignore-violations if evmctl >= 1.3.1 available
* check error only for 1.3.1, for others check only the result
* check for ima_policy=tcb (or ima_tcb) and require 1.3.1 if used
(to get --ignore-violations)

Kind regards,
Petr

Petr Vorel (4):
  IMA: Move get_algorithm_digest(), set_digest_index() to ima_setup.sh
  IMA: Rewrite ima_boot_aggregate.c to new API
  ima_tpm.sh: Fix calculating boot aggregate
  ima_tpm.sh: Fix calculating PCR aggregate

 .../integrity/ima/src/ima_boot_aggregate.c    | 113 ++++---
 .../integrity/ima/tests/ima_measurements.sh   |  62 +---
 .../security/integrity/ima/tests/ima_setup.sh |  84 +++++-
 .../security/integrity/ima/tests/ima_tpm.sh   | 284 ++++++++++++++----
 4 files changed, 371 insertions(+), 172 deletions(-)

-- 
2.28.0

