Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2113824B1AF
	for <lists+linux-integrity@lfdr.de>; Thu, 20 Aug 2020 11:08:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726132AbgHTJIl (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 20 Aug 2020 05:08:41 -0400
Received: from mx2.suse.de ([195.135.220.15]:39516 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725819AbgHTJIj (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 20 Aug 2020 05:08:39 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 8B77EB75B;
        Thu, 20 Aug 2020 09:09:04 +0000 (UTC)
From:   Petr Vorel <pvorel@suse.cz>
To:     ltp@lists.linux.it
Cc:     Petr Vorel <pvorel@suse.cz>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        linux-integrity@vger.kernel.org
Subject: [LTP v4 0/5] IMA: verify measurement of certificate imported into a keyring
Date:   Thu, 20 Aug 2020 11:08:19 +0200
Message-Id: <20200820090824.3033-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Mimi, Lakshmi,

changes v3->v4:
* Add new commit to add another policy dependency (template=ima-buf) and
and fix missing '.' in grep pattern
* Add cleanup function for test2: remove key with keyctl clear ID
instead of running keyctl new_session > /dev/null which was reported
as problematic (and still affects other tests which are run after this one)
* Update check_keys_policy() and checking the policy in general
* Remove new line when working policy to find keyrings and templates
* Replace tr with sed

I still kept keyctl new_session > /dev/null. Should I remove it?
Works for me without it, but that would probably require a cleanup.

Kind regards,
Petr

Lachlan Sneff (1):
  IMA: Add a test to verify measurement of certificate imported into a
    keyring

Petr Vorel (4):
  IMA/ima_keys.sh: Fix policy content check usage
  IMA/ima_keys.sh: Require template=ima-buf, fix grep pattern
  IMA: Refactor datafiles directory
  IMA/ima_keys.sh: Enhance policy checks

 .../kernel/security/integrity/ima/README.md   |  12 +-
 .../security/integrity/ima/datafiles/Makefile |  10 +-
 .../ima/datafiles/ima_kexec/Makefile          |  11 ++
 .../datafiles/{ => ima_kexec}/kexec.policy    |   0
 .../integrity/ima/datafiles/ima_keys/Makefile |  11 ++
 .../datafiles/{ => ima_keys}/keycheck.policy  |   2 +-
 .../ima/datafiles/ima_keys/x509_ima.der       | Bin 0 -> 650 bytes
 .../ima/datafiles/ima_policy/Makefile         |  11 ++
 .../datafiles/{ => ima_policy}/measure.policy |   0
 .../{ => ima_policy}/measure.policy-invalid   |   0
 .../security/integrity/ima/tests/ima_keys.sh  | 115 +++++++++++++++---
 11 files changed, 142 insertions(+), 30 deletions(-)
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

