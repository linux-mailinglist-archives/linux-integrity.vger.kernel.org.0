Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A54523F3F1
	for <lists+linux-integrity@lfdr.de>; Fri,  7 Aug 2020 22:47:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728653AbgHGUrA (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 7 Aug 2020 16:47:00 -0400
Received: from mx2.suse.de ([195.135.220.15]:49210 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728479AbgHGUrA (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 7 Aug 2020 16:47:00 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id ADC03AC41;
        Fri,  7 Aug 2020 20:47:17 +0000 (UTC)
From:   Petr Vorel <pvorel@suse.cz>
To:     ltp@lists.linux.it
Cc:     Petr Vorel <pvorel@suse.cz>,
        Lachlan Sneff <t-josne@linux.microsoft.com>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        linux-integrity@vger.kernel.org
Subject: [PATCH v2 0/4] IMA: verify measurement of certificate imported into a keyring
Date:   Fri,  7 Aug 2020 22:46:48 +0200
Message-Id: <20200807204652.5928-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi,

sending enhanced Lachlan's version.
I haven't tested this patchset, could please anybody test it?

Kind regards,
Petr

Lachlan Sneff (1):
  IMA: Add a test to verify measurement of certificate imported into a
    keyring

Petr Vorel (3):
  IMA/ima_keys.sh Fix policy content check usage
  IMA: Refactor datafiles directory
  IMA/ima_keys.sh: Enhance policy checks

 .../kernel/security/integrity/ima/README.md   |  12 ++-
 .../security/integrity/ima/datafiles/Makefile |  10 +-
 .../ima/datafiles/ima_kexec/Makefile          |  11 ++
 .../datafiles/{ => ima_kexec}/kexec.policy    |   0
 .../integrity/ima/datafiles/ima_keys/Makefile |  11 ++
 .../datafiles/{ => ima_keys}/keycheck.policy  |   2 +-
 .../ima/datafiles/ima_keys/x509_ima.der       | Bin 0 -> 650 bytes
 .../ima/datafiles/ima_policy/Makefile         |  11 ++
 .../datafiles/{ => ima_policy}/measure.policy |   0
 .../{ => ima_policy}/measure.policy-invalid   |   0
 .../security/integrity/ima/tests/ima_keys.sh  |  96 +++++++++++++++---
 11 files changed, 129 insertions(+), 24 deletions(-)
 create mode 100644 testcases/kernel/security/integrity/ima/datafiles/ima_kexec/Makefile
 rename testcases/kernel/security/integrity/ima/datafiles/{ => ima_kexec}/kexec.policy (100%)
 create mode 100644 testcases/kernel/security/integrity/ima/datafiles/ima_keys/Makefile
 rename testcases/kernel/security/integrity/ima/datafiles/{ => ima_keys}/keycheck.policy (59%)
 create mode 100644 testcases/kernel/security/integrity/ima/datafiles/ima_keys/x509_ima.der
 create mode 100644 testcases/kernel/security/integrity/ima/datafiles/ima_policy/Makefile
 rename testcases/kernel/security/integrity/ima/datafiles/{ => ima_policy}/measure.policy (100%)
 rename testcases/kernel/security/integrity/ima/datafiles/{ => ima_policy}/measure.policy-invalid (100%)

-- 
2.28.0

