Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DB6C414833
	for <lists+linux-integrity@lfdr.de>; Wed, 22 Sep 2021 13:53:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235849AbhIVLyp (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 22 Sep 2021 07:54:45 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:51080 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235802AbhIVLyp (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 22 Sep 2021 07:54:45 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id F17CA1FE19;
        Wed, 22 Sep 2021 11:53:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1632311594; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=TGtrqKiRUpXJHrlx24ZmORPtDKfX+2fas7t8ipwXb3w=;
        b=ZoZ8CbsAT1/kC4Alj1Vn6dOeHFKQarSP0ZvzCabdmyM4YCso2AvLzTTw7sJzxY08nZQghE
        5Zq4l+Iy1PCVY1SbpmaupXif130ENCso2ERMEWbmZhm5SlmTx0ML6serlIJVu6oYcW2BTU
        i676heN27ZxUhhCpzgOxI5Z7pF9X8m4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1632311594;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=TGtrqKiRUpXJHrlx24ZmORPtDKfX+2fas7t8ipwXb3w=;
        b=EA2k0AZLV4Ml7NdNeruVorN748CxBDO+3IDK/pskilk62/kINxrFiDk1usZldEQRj3C/VF
        ySX8HRnraS1viYCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A68FB13D76;
        Wed, 22 Sep 2021 11:53:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 9tp4JioZS2F9CgAAMHmgww
        (envelope-from <pvorel@suse.cz>); Wed, 22 Sep 2021 11:53:14 +0000
From:   Petr Vorel <pvorel@suse.cz>
To:     ltp@lists.linux.it
Cc:     Petr Vorel <pvorel@suse.cz>, Alex Henrie <alexh@vpitech.com>,
        alexhenrie24@gmail.com, linux-integrity@vger.kernel.org,
        Mimi Zohar <zohar@linux.ibm.com>
Subject: [PATCH v6 0/3] IMA: Add tests for uid, gid, fowner, and fgroup options
Date:   Wed, 22 Sep 2021 13:53:07 +0200
Message-Id: <20210922115310.5927-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi,

I've fixed Alex's v5.

changes v5->v6:
* add test_file parameter to ima_check() (using global for function is ugly)
* keep $TEST_FILE in ima_measurements.sh ]
* add verify_measurement() (DRY)

Alex Henrie (3):
  IMA: Move check_policy_writable() to ima_setup.sh and rename it
  IMA: Move ima_check to ima_setup.sh
  IMA: Add tests for uid, gid, fowner, and fgroup options

 runtest/ima                                   |  1 +
 .../integrity/ima/tests/ima_conditionals.sh   | 62 +++++++++++++++++++
 .../integrity/ima/tests/ima_measurements.sh   | 31 +---------
 .../integrity/ima/tests/ima_policy.sh         | 16 +----
 .../security/integrity/ima/tests/ima_setup.sh | 38 ++++++++++++
 5 files changed, 106 insertions(+), 42 deletions(-)
 create mode 100755 testcases/kernel/security/integrity/ima/tests/ima_conditionals.sh

-- 
2.33.0

