Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E83EE32341B
	for <lists+linux-integrity@lfdr.de>; Wed, 24 Feb 2021 00:10:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232598AbhBWXID (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 23 Feb 2021 18:08:03 -0500
Received: from mx2.suse.de ([195.135.220.15]:52104 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233946AbhBWXAS (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 23 Feb 2021 18:00:18 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id AFF4EAC69;
        Tue, 23 Feb 2021 22:59:37 +0000 (UTC)
From:   Petr Vorel <pvorel@suse.cz>
To:     ltp@lists.linux.it
Cc:     Petr Vorel <pvorel@suse.cz>, Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Tushar Sugandhi <tusharsu@linux.microsoft.com>, agk@redhat.com,
        snitzer@redhat.com, gmazyland@gmail.com,
        linux-integrity@vger.kernel.org, dm-devel@redhat.com
Subject: [PATCH v3 0/2] IMA: Add test for dm-crypt measurement
Date:   Tue, 23 Feb 2021 23:59:28 +0100
Message-Id: <20210223225930.27095-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi!

I updated Tushar's patchset to speedup things.

Changes v2->v3
* rename function s/check_ima_ascii_log_for_policy/test_policy_measurement/
* move tst_res TPASS/TFAIL into test_policy_measurement()
* drop template=ima-buf (see Lakshmi's patch [1] and discussion about
  it, it will be removed from ima_keys.sh as well)
* moved ima_dm_crypt.sh specific changes to second commit
* further API and style related cleanup

Could you please check this patchset?

Kind regards,
Petr

[1] https://patchwork.ozlabs.org/project/ltp/patch/20210222023421.12576-1-nramas@linux.microsoft.com/

Tushar Sugandhi (2):
  IMA: Generalize key measurement tests
  IMA: Add test for dm-crypt measurement

 runtest/ima                                   |  1 +
 .../kernel/security/integrity/ima/README.md   | 20 ++++++
 .../integrity/ima/tests/ima_dm_crypt.sh       | 41 +++++++++++
 .../security/integrity/ima/tests/ima_keys.sh  | 58 ++-------------
 .../security/integrity/ima/tests/ima_setup.sh | 71 +++++++++++++++++++
 5 files changed, 139 insertions(+), 52 deletions(-)
 create mode 100755 testcases/kernel/security/integrity/ima/tests/ima_dm_crypt.sh

-- 
2.30.1

