Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C13FC1A3BB3
	for <lists+linux-integrity@lfdr.de>; Thu,  9 Apr 2020 23:10:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727331AbgDIVKw (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 9 Apr 2020 17:10:52 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:59036 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727001AbgDIVKw (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 9 Apr 2020 17:10:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586466651;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=13H0K4dB2cqnGtOdNGKDe+uxTmNmKZm+0tiaDnce01o=;
        b=X4T8nc2l7ni/XpJONcFx6RhU2Ns0PFkUeaV/Zkt2pBMFj3WRs4uDAZz4fqhWOvn2eou2Xl
        BZ8FByr+lPJTzCAFFCDmhpmSc7x6XbgeC8o/pEv+ntILkv9kjuEQMOaxdn3k1RzkmXt3Z5
        BLLmM5GkiEiwJTFow8S6QTWroTw0BiQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-275-8Q2e6E_YNA22FYZkyaeN4A-1; Thu, 09 Apr 2020 17:10:50 -0400
X-MC-Unique: 8Q2e6E_YNA22FYZkyaeN4A-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9C30B8017F5;
        Thu,  9 Apr 2020 21:10:48 +0000 (UTC)
Received: from x1.localdomain.com (ovpn-112-34.ams2.redhat.com [10.36.112.34])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9D4BE5C545;
        Thu,  9 Apr 2020 21:10:46 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Jerry Snitselaar <jsnitsel@redhat.com>,
        Stefan Berger <stefanb@linux.ibm.com>
Cc:     Hans de Goede <hdegoede@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-integrity@vger.kernel.org
Subject: [PATCH] tpm_tis_core: Disable broken IRQ handling code
Date:   Thu,  9 Apr 2020 23:10:44 +0200
Message-Id: <20200409211044.21625-1-hdegoede@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Content-Transfer-Encoding: quoted-printable
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Since commit dda8b2af395b ("tpm: Revert "tpm_tis_core: Set
TPM_CHIP_FLAG_IRQ before probing for interrupts"") we no longer set
the TPM_CHIP_FLAG_IRQ ever.

So the whole IRQ probing code is not useful, worse we rely on the
IRQ-test path of tpm_tis_send() to call disable_interrupts() if
interrupts do not work, but that path never gets entered because we
never set the TPM_CHIP_FLAG_IRQ.

So the remaining IRQ probe code calls request_irq() and never calls
free_irq() even when the interrupt is not working.

On some systems, e.g. the Lenovo X1 8th gen,  the interrupt we try
to use and never free creates an interrupt storm followed by
an "irq XX: nobody cared" oops.

Since it is non-functional at the moment anyways, lets just completely
disable the IRQ code in tpm_tis_core for now.

Fixes: dda8b2af395b ("tpm: Revert "tpm_tis_core: Set TPM_CHIP_FLAG_IRQ be=
fore probing for interrupts"")
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Note I'm working with Lenovo to try and get to the bottom of this.
---
 drivers/char/tpm/tpm_tis_core.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_c=
ore.c
index 27c6ca031e23..647a4a4ccd0c 100644
--- a/drivers/char/tpm/tpm_tis_core.c
+++ b/drivers/char/tpm/tpm_tis_core.c
@@ -697,6 +697,7 @@ static bool tpm_tis_req_canceled(struct tpm_chip *chi=
p, u8 status)
 	}
 }
=20
+#if 0 /* See the comment in tpm_tis_core_init */
 static irqreturn_t tis_int_handler(int dummy, void *dev_id)
 {
 	struct tpm_chip *chip =3D dev_id;
@@ -838,6 +839,7 @@ static void tpm_tis_probe_irq(struct tpm_chip *chip, =
u32 intmask)
 					     original_int_vec))
 		return;
 }
+#endif
=20
 void tpm_tis_remove(struct tpm_chip *chip)
 {
@@ -1048,6 +1050,14 @@ int tpm_tis_core_init(struct device *dev, struct t=
pm_tis_data *priv, int irq,
 	/* INTERRUPT Setup */
 	init_waitqueue_head(&priv->read_queue);
 	init_waitqueue_head(&priv->int_queue);
+/*
+ * Interrupt support is broken ATM, we never set TPM_CHIP_FLAG_IRQ.
+ * The below code still registers an interrupt handler even though we ne=
ver
+ * wait for the wait_queues it signals. On some systems the interrupt we=
 try
+ * to use creates an interrupt storm followed by an "irq XX: nobody care=
d"
+ * oops. So disable this code for now.
+ */
+#if 0
 	if (irq !=3D -1) {
 		/* Before doing irq testing issue a command to the TPM in polling mode
 		 * to make sure it works. May as well use that command to set the
@@ -1069,6 +1079,7 @@ int tpm_tis_core_init(struct device *dev, struct tp=
m_tis_data *priv, int irq,
 			tpm_tis_probe_irq(chip, intmask);
 		}
 	}
+#endif
=20
 	rc =3D tpm_chip_register(chip);
 	if (rc)
--=20
2.26.0

