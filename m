Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CC2531127E
	for <lists+linux-integrity@lfdr.de>; Fri,  5 Feb 2021 21:30:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233112AbhBESrn (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 5 Feb 2021 13:47:43 -0500
Received: from services.gouders.net ([141.101.32.176]:55088 "EHLO
        services.gouders.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233147AbhBESqU (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 5 Feb 2021 13:46:20 -0500
Received: from lena.gouders.net (ltea-047-066-017-037.pools.arcor-ip.net [47.66.17.37])
        (authenticated bits=0)
        by services.gouders.net (8.14.8/8.14.8) with ESMTP id 115KND7O010254
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
        Fri, 5 Feb 2021 21:23:13 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gouders.net; s=gnet;
        t=1612556594; bh=VzsV7TZd0UrfqDIc1n/qtEk7Hk2n9pTW0l4lu5esQ4k=;
        h=From:To:Cc:Subject:Date;
        b=OTVAtZAcikfUuINA6xINEDIbYerJWM+6LoQVnNF/+/Th9OivWsflmhAEJ7CiyuyF2
         N343Tb/wMFdtJ96RmftinxotvCPP7rQDYJV5UXbgdtqr2v7y6YAijaF72I0XIqY6x6
         M1BK5fsO+l22zLdCxkfFwT93g092IxYfTF022s3c=
From:   Dirk Gouders <dirk@gouders.net>
To:     Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Dirk Gouders <dirk@gouders.net>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/1] tpm_tis: handle -EPROBE_DEFER in tpm_tis_plat_probe()
Date:   Fri,  5 Feb 2021 21:20:21 +0100
Message-Id: <20210205202022.4515-1-dirk@gouders.net>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hello,

I noticed that the tpm_tis driver behaves different depending on
wether it was compiled builtin or as a module.

At least on my hardware, if builtin it always falls back to polling mode
without notification which I do not understand considering the current
efforts to fix interrupt probing[1].

The builtin case could be fixed by handling -EPROBE_DEFER.  With a
temporary dev_dbg() call added and James Bottomley's
"[PATCH v2 4/5] tpm_tis: fix IRQ probing [1]" applied my kernel log
looks like this:

[    2.671629] tpm_tis STM0125:00: Waiting for interrupt...
[    2.851920] tpm_tis STM0125:00: Waiting for interrupt...
[    2.852627] tpm_tis STM0125:00: Waiting for interrupt...
[    2.908286] tpm_tis STM0125:00: Waiting for interrupt...
[    3.340223] tpm_tis STM0125:00: Waiting for interrupt...
[    3.407238] tpm_tis STM0125:00: Waiting for interrupt...
[    3.408178] tpm_tis STM0125:00: Waiting for interrupt...
[    3.408994] tpm_tis STM0125:00: Waiting for interrupt...
[    3.487694] tpm_tis STM0125:00: Waiting for interrupt...
[    3.773769] tpm_tis STM0125:00: Waiting for interrupt...
[    3.868590] tpm_tis STM0125:00: Waiting for interrupt...
[    3.923855] tpm_tis STM0125:00: Waiting for interrupt...
[    4.235670] tpm_tis STM0125:00: Waiting for interrupt...
[    4.852556] tpm_tis STM0125:00: Waiting for interrupt...
[    6.767544] tpm_tis STM0125:00: 2.0 TPM (device-id 0x0, rev-id 78)
[    6.767567] tpm_tis STM0125:00: TPM interface capabilities (0x30000415):
[    6.767569] tpm_tis STM0125:00: 	Interrupt Level Low
[    6.767570] tpm_tis STM0125:00: 	Locality Change Int Support
[    6.767570] tpm_tis STM0125:00: 	Data Avail Int Support


Of course, this patch should not be added before Jarkko's fix [2], because
builtin drivers would then hit the WARN_ONCE(), as well.

Dirk


[1] https://lore.kernel.org/linux-integrity/20201001180925.13808-5-James.Bottomley@HansenPartnership.com/
[2] https://lore.kernel.org/linux-integrity/3936843b-c0da-dd8c-8aa9-90aa3b49d525@linux.ibm.com/T/#t

Dirk Gouders (1):
  tpm_tis: handle -EPROBE_DEFER in tpm_tis_plat_probe()

 drivers/char/tpm/tpm_tis.c | 3 +++
 1 file changed, 3 insertions(+)

-- 
2.26.2

