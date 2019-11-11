Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CCAE8F837D
	for <lists+linux-integrity@lfdr.de>; Tue, 12 Nov 2019 00:34:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726877AbfKKXe2 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 11 Nov 2019 18:34:28 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:36791 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726845AbfKKXe1 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 11 Nov 2019 18:34:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573515266;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=Osmocn6A+32FCq+AZZzVX6c3EKPInFHUzdh8/zOxZjQ=;
        b=YG6fITkEizfKxmoaOeh8g/55sqaXCGWtHzPGl30JCV8OA7zKDqRtg6o7rnwSy3sYzTmGXZ
        pl7BYR9uyqAYhDq3GTt7X4F38Y85+vazirpbsisbon3sosLyn2EzHci1JST6CSejo9ACOw
        pDvxYiBwOWxB7tGfNbdcqtuN5J6vgwE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-394-7pYHOyhaMVGIDXctMbS_0Q-1; Mon, 11 Nov 2019 18:34:23 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EEA06800D49;
        Mon, 11 Nov 2019 23:34:21 +0000 (UTC)
Received: from cantor.redhat.com (ovpn-116-116.phx2.redhat.com [10.3.116.116])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AE131100EBBD;
        Mon, 11 Nov 2019 23:34:20 +0000 (UTC)
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     linux-integrity@vger.kernel.org
Cc:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-kernel@vger.kernel.org,
        linux-stable@vger.kernel.org,
        Christian Bundy <christianbundy@fraction.io>
Subject: [PATCH] tpm_tis: turn on TPM before calling tpm_get_timeouts
Date:   Mon, 11 Nov 2019 16:34:18 -0700
Message-Id: <20191111233418.17676-1-jsnitsel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: 7pYHOyhaMVGIDXctMbS_0Q-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

With power gating moved out of the tpm_transmit code we need
to power on the TPM prior to calling tpm_get_timeouts.

Cc: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc: Peter Huewe <peterhuewe@gmx.de>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-kernel@vger.kernel.org
Cc: linux-stable@vger.kernel.org
Fixes: a3fbfae82b4c ("tpm: take TPM chip power gating out of tpm_transmit()=
")
Reported-by: Christian Bundy <christianbundy@fraction.io>
Signed-off-by: Jerry Snitselaar <jsnitsel@redhat.com>
---
 drivers/char/tpm/tpm_tis_core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_cor=
e.c
index 270f43acbb77..cb101cec8f8b 100644
--- a/drivers/char/tpm/tpm_tis_core.c
+++ b/drivers/char/tpm/tpm_tis_core.c
@@ -974,13 +974,14 @@ int tpm_tis_core_init(struct device *dev, struct tpm_=
tis_data *priv, int irq,
 =09=09 * to make sure it works. May as well use that command to set the
 =09=09 * proper timeouts for the driver.
 =09=09 */
+=09=09tpm_chip_start(chip);
 =09=09if (tpm_get_timeouts(chip)) {
 =09=09=09dev_err(dev, "Could not get TPM timeouts and durations\n");
 =09=09=09rc =3D -ENODEV;
+=09=09=09tpm_stop_chip(chip);
 =09=09=09goto out_err;
 =09=09}
=20
-=09=09tpm_chip_start(chip);
 =09=09chip->flags |=3D TPM_CHIP_FLAG_IRQ;
 =09=09if (irq) {
 =09=09=09tpm_tis_probe_irq_single(chip, intmask, IRQF_SHARED,
--=20
2.24.0

