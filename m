Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EAC52CF8C3
	for <lists+linux-integrity@lfdr.de>; Sat,  5 Dec 2020 02:47:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726508AbgLEBpQ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 4 Dec 2020 20:45:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:53228 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726210AbgLEBpP (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 4 Dec 2020 20:45:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607132629;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6yJeqxIEHIleweaVW/dUcRgU3WNyCS7QJx1HMI0RKzA=;
        b=E+vmUMgZtPMtMwAfS9SkaKA8irIAmRnLTIrDSCpLg6PdDXsWCGHNppAgKQvnBv3CC5sKVW
        v54Uavq/LZJCHJFpd+pFuXZHLcD9UTYRhLOGeK0bu4j2y999+Kztm1q9UEa7iFF0nNXUF/
        XHyBEYNaijIz41ML+dH5KormIaLgnF4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-282-dWcFxQouP0-k3JQfcGHuAQ-1; Fri, 04 Dec 2020 20:43:48 -0500
X-MC-Unique: dWcFxQouP0-k3JQfcGHuAQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9903D180A099;
        Sat,  5 Dec 2020 01:43:46 +0000 (UTC)
Received: from cantor.redhat.com (ovpn-114-119.phx2.redhat.com [10.3.114.119])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0EAD760936;
        Sat,  5 Dec 2020 01:43:46 +0000 (UTC)
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-integrity@vger.kernel.org, intel-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Peter Huewe <peterhuewe@gmx.de>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        Matthew Garrett <mjg59@google.com>,
        Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v3 4/4] tpm_tis: Disable Interrupts on the ThinkPad L490
Date:   Fri,  4 Dec 2020 18:43:40 -0700
Message-Id: <20201205014340.148235-5-jsnitsel@redhat.com>
In-Reply-To: <20201205014340.148235-1-jsnitsel@redhat.com>
References: <20201205014340.148235-1-jsnitsel@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

The interrupt storm detection code detects the issue on the ThinkPad
T490s, but the L490 still hangs at initialization. So swap out the
T490s for the L490 in the dmi check.

Cc: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Peter Huewe <peterhuewe@gmx.de>
Cc: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: Matthew Garrett <mjg59@google.com>
Cc: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Jerry Snitselaar <jsnitsel@redhat.com>
---
 drivers/char/tpm/tpm_tis.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/char/tpm/tpm_tis.c b/drivers/char/tpm/tpm_tis.c
index 4ed6e660273a..7322e0986a83 100644
--- a/drivers/char/tpm/tpm_tis.c
+++ b/drivers/char/tpm/tpm_tis.c
@@ -77,10 +77,10 @@ static int tpm_tis_disable_irq(const struct dmi_system_id *d)
 static const struct dmi_system_id tpm_tis_dmi_table[] = {
 	{
 		.callback = tpm_tis_disable_irq,
-		.ident = "ThinkPad T490s",
+		.ident = "ThinkPad L490",
 		.matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
-			DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad T490s"),
+			DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad L490"),
 		},
 	},
 	{}
-- 
2.27.0

