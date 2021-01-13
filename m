Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B8902F5607
	for <lists+linux-integrity@lfdr.de>; Thu, 14 Jan 2021 02:57:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727421AbhANBUO (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 13 Jan 2021 20:20:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726787AbhANBT7 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 13 Jan 2021 20:19:59 -0500
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [IPv6:2607:fcd0:100:8a00::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12CE7C061794;
        Wed, 13 Jan 2021 15:26:36 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id C996A1280507;
        Wed, 13 Jan 2021 15:26:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1610580395;
        bh=A4tTySHUmA3iIsjYOH6q0S4Z4LhKvBiJ468wy5vYyrc=;
        h=From:To:Subject:Date:Message-Id:From;
        b=k9Fs24PjJWtAWePoGdSqxs+J0LWvSD/J5qdUhFX0oQKbpzo3Hz6AcBL+j8n2/xUks
         vQWU98m/qNSEzKR2ifS4ZUaoHxJgdVe1jWQPcONM46tX9CPxOGlMrC37fsMvrBPpac
         vdFiSvr+EhlaBucQc/7YSKcjAzdQUqeGe9EeCKZI=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id XXUN0Q7HCIYO; Wed, 13 Jan 2021 15:26:35 -0800 (PST)
Received: from jarvis.int.hansenpartnership.com (jarvis.ext.hansenpartnership.com [153.66.160.226])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 6BEFC12804FC;
        Wed, 13 Jan 2021 15:26:35 -0800 (PST)
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     linux-integrity@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        Jarkko Sakkinen <jarkko@kernel.org>, linux-api@vger.kernel.org
Subject: [PATCH v5 0/2] add sysfs exports for TPM 2 PCR registers
Date:   Wed, 13 Jan 2021 15:26:32 -0800
Message-Id: <20210113232634.23242-1-James.Bottomley@HansenPartnership.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

This represents v5 which has the spelling mistake fixed and the WARN
on unrecognized TPM hash algorithm becoming a dev_err.

We've had a fairly extensive discussion and iterated to agreement on
the output format, which becomes our ABI being one single compact hex
representation of the hash value per file according to sysfs rules,
with the file hierarchy going under

  /sys/class/tpm/tmp<x>/pcr-<hash>/<pcr number>

So to get the value of PCR 7 in the sha256 bank of the default TPM I'd do

   cat /sys/class/tpm/tpm0/pcr-sha256/7
   2ED93F199692DC6788EFA6A1FE74514AB9760B2A6CEEAEF6C808C13E4ABB0D42

If you need the binary hash of a set of PCRs, as is required for TPM
policy statements that lock to PCRs, you'd use something like:

  cat /sys/class/tpm/tpm0/pcr-sha256/{1,6,7}|xxd -r -p|sha256sum

Which produces the binary hash of PCRs 1, 6 and 7 in that order.

Note that this patch also adds the sha1 bank for TPM 1.2 in the same
manner (one file per PCR) but does not remove the existing pcrs file
which has the space separated all PCRs in one file format of

  PCR-00: 7D 29 CB 08 0C 0F C4 16 7A 0E 9A F7 C6 D3 97 CD C1 21 A7 69 
  PCR-01: 9C B6 79 4C E4 4B 62 97 4C AB 55 13 1A 2F 7E AE 09 B3 30 BE 
  ...

James

---

James Bottomley (2):
  tpm: add sysfs exports for all banks of PCR registers
  ABI: add sysfs description for tpm exports of PCR registers

 Documentation/ABI/stable/sysfs-class-tpm |  14 ++
 drivers/char/tpm/tpm-sysfs.c             | 179 +++++++++++++++++++++++
 include/linux/tpm.h                      |   9 +-
 3 files changed, 201 insertions(+), 1 deletion(-)

-- 
2.26.2

