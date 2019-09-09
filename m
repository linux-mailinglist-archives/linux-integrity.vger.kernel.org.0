Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CA6CDAD8BC
	for <lists+linux-integrity@lfdr.de>; Mon,  9 Sep 2019 14:17:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404834AbfIIMQx (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 9 Sep 2019 08:16:53 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:48050 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2404832AbfIIMQw (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 9 Sep 2019 08:16:52 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 6E8478EE180;
        Mon,  9 Sep 2019 05:16:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1568031412;
        bh=A4wO046/2GXXt4hgSTTGToYKR3Su1LXB/mUtb9Xom3U=;
        h=Subject:From:To:Cc:Date:From;
        b=V57AIN2QFFSA2qS6cMyM/XLS44bcn94woPkECenIfuOFhV6QfYozDdE7LxfBCN24a
         VfsEjHtZIom7OIVWbtdZ6PF8QE+mS660fFxc9Y/T591pBumucsP7xJ5I/ek3mf6Dvb
         8fTdy/T0c6kb3lnZX6S8W79AXDMN5vE/eT+CR+/A=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id hDGJeiVB2gl1; Mon,  9 Sep 2019 05:16:52 -0700 (PDT)
Received: from [192.168.6.117] (unknown [148.69.85.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 228358EE105;
        Mon,  9 Sep 2019 05:16:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1568031412;
        bh=A4wO046/2GXXt4hgSTTGToYKR3Su1LXB/mUtb9Xom3U=;
        h=Subject:From:To:Cc:Date:From;
        b=V57AIN2QFFSA2qS6cMyM/XLS44bcn94woPkECenIfuOFhV6QfYozDdE7LxfBCN24a
         VfsEjHtZIom7OIVWbtdZ6PF8QE+mS660fFxc9Y/T591pBumucsP7xJ5I/ek3mf6Dvb
         8fTdy/T0c6kb3lnZX6S8W79AXDMN5vE/eT+CR+/A=
Message-ID: <1568031408.6613.29.camel@HansenPartnership.com>
Subject: [PATCH v6 00/12] add integrity and security to TPM2 transactions
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     linux-integrity@vger.kernel.org
Cc:     linux-crypto@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Date:   Mon, 09 Sep 2019 13:16:48 +0100
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Link to previous cover letter:

https://lore.kernel.org/linux-integrity/1540193596.3202.7.camel@HansenPartnership.com/

This is marked v6 instead of v5 because I did a v5 after feedback on v4
but didn't get around to posting it and then had to rework the whole of
the kernel space handling while I was on holiday.  I also added the
documentation of how the whole thing works and the rationale for doing
it in tpm-security.rst (patch 11).  The main reason for doing this now
is so we have something to discuss at Plumbers.

The new patch set implements the various splits requested, but the main
changes are that the kernel space is gone and is replaced by a context
save and restore of the generated null seed.  This is easier to handle
than a full kernel space given the new threading for TPM spaces, but
conceptually it is still very like a space.  I've also made whether
integrity and encryption is turned on a Kconfig option.

James

---

James Bottomley (12):
  tpm-buf: move from static inlines to real functions
  tpm-buf: add handling for TPM2B types
  tpm-buf: add cursor based functions for response parsing
  tpm2-space: export the context save and load commands
  tpm2-sessions: Add full HMAC and encrypt/decrypt session handling
  tpm-buf: add tpm_buf_parameters()
  tpm2: add hmac checks to tpm2_pcr_extend()
  tpm2: add session encryption protection to tpm2_get_random()
  trusted keys: Add session encryption protection to the seal/unseal
    path
  tpm: add the null key name as a tpm2 sysfs variable
  Documentation: add tpm-security.rst
  tpm2-sessions: NOT FOR COMMITTING add sessions testing

 Documentation/security/tpm/tpm-security.rst |  204 +++++
 drivers/char/tpm/Kconfig                    |   11 +
 drivers/char/tpm/Makefile                   |    4 +
 drivers/char/tpm/tpm-buf.c                  |  202 +++++
 drivers/char/tpm/tpm-chip.c                 |    1 +
 drivers/char/tpm/tpm-sysfs.c                |   27 +-
 drivers/char/tpm/tpm.h                      |  117 +--
 drivers/char/tpm/tpm2-cmd.c                 |  202 +++--
 drivers/char/tpm/tpm2-sessions-test.c       |  795 ++++++++++++++++++
 drivers/char/tpm/tpm2-sessions.c            | 1204 +++++++++++++++++++++++++++
 drivers/char/tpm/tpm2-sessions.h            |  138 +++
 drivers/char/tpm/tpm2-space.c               |    8 +-
 include/linux/tpm.h                         |   29 +
 13 files changed, 2787 insertions(+), 155 deletions(-)
 create mode 100644 Documentation/security/tpm/tpm-security.rst
 create mode 100644 drivers/char/tpm/tpm-buf.c
 create mode 100644 drivers/char/tpm/tpm2-sessions-test.c
 create mode 100644 drivers/char/tpm/tpm2-sessions.c
 create mode 100644 drivers/char/tpm/tpm2-sessions.h

-- 
2.16.4

