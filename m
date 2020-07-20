Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 466812262AE
	for <lists+linux-integrity@lfdr.de>; Mon, 20 Jul 2020 17:00:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726546AbgGTPAo (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 20 Jul 2020 11:00:44 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:47924 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726506AbgGTPAo (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 20 Jul 2020 11:00:44 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 74DC18EE266;
        Mon, 20 Jul 2020 08:00:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1595257243;
        bh=Wums6czHbjILb816qWai4AmdL6F6tspGsAyiQ4gV8Rw=;
        h=From:To:Cc:Subject:Date:From;
        b=XMVPS3HK0+3YpV/go6JYZIALT3oAGqFxNRvfGO6chU8XtfTwl/REcKC+Kga5sRa8T
         q7zYoxya/u1h7br4FILkAEDmA+EUfktJ+9HEp9gVpMmOjhJoLoenqWfNXOVbXiKa5m
         a2xNX9XEPNh9q4+XfTpIDbWYlT+h/GsT5TM1hJLc=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Bpk6NytiK6Jj; Mon, 20 Jul 2020 08:00:43 -0700 (PDT)
Received: from jarvis.lan (jarvis.ext.hansenpartnership.com [153.66.160.226])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 004AE8EE223;
        Mon, 20 Jul 2020 08:00:42 -0700 (PDT)
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     linux-integrity@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Subject: [PATCH 0/1] add sysfs exports for TPM 2 PCR registers
Date:   Mon, 20 Jul 2020 08:00:37 -0700
Message-Id: <20200720150038.9082-1-James.Bottomley@HansenPartnership.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

At last year's plumbers conference it was agreed in principle to
export TPM 2 PCRs via sysfs.  We also agreed we should conform to
sysfs rules of one value per file, which rules out the "pcrs" file
format of TPM 1.2 which has every PCR value in the same file.

I added these files using device groups, so one group per bank hash of
the TPM.  Using an emulator which supports a variety of hashes, you
can see the structure of the group files:

root@testdeb:~# ls -F /sys/class/tpm/tpm0/
dev      pcr-sha1/    pcr-sha384/  power/      tpm_version_major
device@  pcr-sha256/  pcr-sha512/  subsystem@  uevent

As a future enhancement, we could use the group is_visible function to
remove files corresponding to PCRs which don't exist.  The reason this
isn't present is that so far I've never seen a TPM with a missing PCR.

James

---

James Bottomley (1):
  tpm: add sysfs exports for all banks of PCR registers

 drivers/char/tpm/tpm-sysfs.c | 178 +++++++++++++++++++++++++++++++++++
 include/linux/tpm.h          |   8 +-
 2 files changed, 185 insertions(+), 1 deletion(-)

-- 
2.26.2

