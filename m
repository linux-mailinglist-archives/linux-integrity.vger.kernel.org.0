Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FE9F228452
	for <lists+linux-integrity@lfdr.de>; Tue, 21 Jul 2020 17:56:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728180AbgGUP4V (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 21 Jul 2020 11:56:21 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:35560 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726892AbgGUP4V (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 21 Jul 2020 11:56:21 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id C62148EE269;
        Tue, 21 Jul 2020 08:56:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1595346980;
        bh=xDMEpcXwBQ0toxBF98Z56FUA+LIpf3og/xo5IlneqXo=;
        h=From:To:Cc:Subject:Date:From;
        b=KZQIsaqZR+dj2uEAkCnsSMH9J6XyM5bxvDn5QHmSe5JGzb58BHpKXzyl2kCyJfdsP
         oo+teRo27UXbOoCX7coAbgXm0mTwD3q8JAoWc2cQe78K5JeeHfUlKn4QUmY9Btjxwb
         7VGI7b7r6mIW6ahWWGJP7zuL/3nKKTJsfWuuACzU=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id BUdQqFHFRqKp; Tue, 21 Jul 2020 08:56:20 -0700 (PDT)
Received: from jarvis.lan (jarvis.ext.hansenpartnership.com [153.66.160.226])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 6AFE38EE207;
        Tue, 21 Jul 2020 08:56:20 -0700 (PDT)
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     linux-integrity@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Subject: [PATCH v2 0/1] add sysfs exports for TPM 2 PCR registers
Date:   Tue, 21 Jul 2020 08:56:14 -0700
Message-Id: <20200721155615.12625-1-James.Bottomley@HansenPartnership.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

v2 to fix the failure on TPM 1.2

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

 drivers/char/tpm/tpm-sysfs.c | 180 +++++++++++++++++++++++++++++++++++
 include/linux/tpm.h          |   8 +-
 2 files changed, 187 insertions(+), 1 deletion(-)

-- 
2.26.2

