Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C4D6376A8B
	for <lists+linux-integrity@lfdr.de>; Fri,  7 May 2021 21:14:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229524AbhEGTPX (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 7 May 2021 15:15:23 -0400
Received: from mx2.suse.de ([195.135.220.15]:54924 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229470AbhEGTPW (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 7 May 2021 15:15:22 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 6E953AEE5;
        Fri,  7 May 2021 19:14:21 +0000 (UTC)
From:   Petr Vorel <pvorel@suse.cz>
To:     ltp@lists.linux.it
Cc:     Petr Vorel <pvorel@suse.cz>, Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Tushar Sugandhi <tusharsu@linux.microsoft.com>,
        linux-integrity@vger.kernel.org
Subject: [PATCH v4 0/3] IMA: Add test for dm-crypt measurement
Date:   Fri,  7 May 2021 21:14:11 +0200
Message-Id: <20210507191414.14795-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Mimi, Lakshmi, Tushar,

rebased v3 [1], hope everything correct.
Could you please review and test it?

v3->v4:
* rewritten "IMA: Generalize key measurement tests"
* new commit "ima_keys.sh: Check policy only once"


Kind regards,
Petr

[1] https://patchwork.ozlabs.org/project/ltp/list/?series=230766&state=*

Petr Vorel (2):
  ima_keys.sh: Check policy only once
  IMA: Generalize key measurement tests

Tushar Sugandhi (1):
  IMA: Add test for dm-crypt measurement

 .../kernel/security/integrity/ima/README.md   | 20 +++++
 .../security/integrity/ima/datafiles/Makefile |  2 +-
 .../ima/datafiles/ima_dm_crypt/Makefile       | 11 +++
 .../ima_dm_crypt/ima_dm_crypt.policy          |  1 +
 .../integrity/ima/tests/ima_dm_crypt.sh       | 47 +++++++++++
 .../security/integrity/ima/tests/ima_keys.sh  | 84 +++----------------
 .../security/integrity/ima/tests/ima_setup.sh | 76 ++++++++++++++++-
 7 files changed, 168 insertions(+), 73 deletions(-)
 create mode 100644 testcases/kernel/security/integrity/ima/datafiles/ima_dm_crypt/Makefile
 create mode 100644 testcases/kernel/security/integrity/ima/datafiles/ima_dm_crypt/ima_dm_crypt.policy
 create mode 100755 testcases/kernel/security/integrity/ima/tests/ima_dm_crypt.sh

-- 
2.31.1

