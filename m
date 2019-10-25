Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E5F38E5470
	for <lists+linux-integrity@lfdr.de>; Fri, 25 Oct 2019 21:36:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725775AbfJYTgn (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 25 Oct 2019 15:36:43 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:60138 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726212AbfJYTgg (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 25 Oct 2019 15:36:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1572032194;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=WY4DqfThBC4KF0edM6YYGs6wiTpVUS+SZXP71BDtiMc=;
        b=AevmlaZf5tgcK+YclBERySM042j0TK/95eaXVmy1JOiqzN/nZiTvAHFFgtzg+dcGVYrxuu
        6gdZOOs0pA6iy1yvDVDr7ShvksmnxyHf5UY8KnAfu4uTRjSxNNl7PjSJ5bqDHS3LVt5P8z
        X+Kgep6GMgYzSKwMowpRIAGF/ytGrYo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-136-yS2I6GnMO_CAHk_1PF2FmQ-1; Fri, 25 Oct 2019 15:36:31 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 34C6180183D;
        Fri, 25 Oct 2019 19:36:30 +0000 (UTC)
Received: from cantor.redhat.com (ovpn-117-192.phx2.redhat.com [10.3.117.192])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D3BB63D8F;
        Fri, 25 Oct 2019 19:36:29 +0000 (UTC)
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-integrity@vger.kernel.org
Subject: [PATCH] tpm: Update mailing list contact information in sysfs-class-tpm
Date:   Fri, 25 Oct 2019 12:36:28 -0700
Message-Id: <20191025193628.31004-1-jsnitsel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: yS2I6GnMO_CAHk_1PF2FmQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

All of the entries in Documentation/ABI/stable/sysfs-class-tpm
point to the old tpmdd-devel mailing list. This patch
updates the entries to point to linux-intergrity.

Cc: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc: Peter Huewe <peterhuewe@gmx.de>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-integrity@vger.kernel.org
Signed-off-by: Jerry Snitselaar <jsnitsel@redhat.com>
---
 Documentation/ABI/stable/sysfs-class-tpm | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/Documentation/ABI/stable/sysfs-class-tpm b/Documentation/ABI/s=
table/sysfs-class-tpm
index c6bd02bafafd..e0116d42e4a0 100644
--- a/Documentation/ABI/stable/sysfs-class-tpm
+++ b/Documentation/ABI/stable/sysfs-class-tpm
@@ -1,7 +1,7 @@
 What:=09=09/sys/class/tpm/tpmX/device/
 Date:=09=09April 2005
 KernelVersion:=092.6.12
-Contact:=09tpmdd-devel@lists.sf.net
+Contact:=09linux-integrity@vger.kernel.org
 Description:=09The device/ directory under a specific TPM instance exposes
 =09=09the properties of that TPM chip
=20
@@ -9,7 +9,7 @@ Description:=09The device/ directory under a specific TPM i=
nstance exposes
 What:=09=09/sys/class/tpm/tpmX/device/active
 Date:=09=09April 2006
 KernelVersion:=092.6.17
-Contact:=09tpmdd-devel@lists.sf.net
+Contact:=09linux-integrity@vger.kernel.org
 Description:=09The "active" property prints a '1' if the TPM chip is accep=
ting
 =09=09commands. An inactive TPM chip still contains all the state of
 =09=09an active chip (Storage Root Key, NVRAM, etc), and can be
@@ -21,7 +21,7 @@ Description:=09The "active" property prints a '1' if the =
TPM chip is accepting
 What:=09=09/sys/class/tpm/tpmX/device/cancel
 Date:=09=09June 2005
 KernelVersion:=092.6.13
-Contact:=09tpmdd-devel@lists.sf.net
+Contact:=09linux-integrity@vger.kernel.org
 Description:=09The "cancel" property allows you to cancel the currently
 =09=09pending TPM command. Writing any value to cancel will call the
 =09=09TPM vendor specific cancel operation.
@@ -29,7 +29,7 @@ Description:=09The "cancel" property allows you to cancel=
 the currently
 What:=09=09/sys/class/tpm/tpmX/device/caps
 Date:=09=09April 2005
 KernelVersion:=092.6.12
-Contact:=09tpmdd-devel@lists.sf.net
+Contact:=09linux-integrity@vger.kernel.org
 Description:=09The "caps" property contains TPM manufacturer and version i=
nfo.
=20
 =09=09Example output:
@@ -46,7 +46,7 @@ Description:=09The "caps" property contains TPM manufactu=
rer and version info.
 What:=09=09/sys/class/tpm/tpmX/device/durations
 Date:=09=09March 2011
 KernelVersion:=093.1
-Contact:=09tpmdd-devel@lists.sf.net
+Contact:=09linux-integrity@vger.kernel.org
 Description:=09The "durations" property shows the 3 vendor-specific values
 =09=09used to wait for a short, medium and long TPM command. All
 =09=09TPM commands are categorized as short, medium or long in
@@ -69,7 +69,7 @@ Description:=09The "durations" property shows the 3 vendo=
r-specific values
 What:=09=09/sys/class/tpm/tpmX/device/enabled
 Date:=09=09April 2006
 KernelVersion:=092.6.17
-Contact:=09tpmdd-devel@lists.sf.net
+Contact:=09linux-integrity@vger.kernel.org
 Description:=09The "enabled" property prints a '1' if the TPM chip is enab=
led,
 =09=09meaning that it should be visible to the OS. This property
 =09=09may be visible but produce a '0' after some operation that
@@ -78,7 +78,7 @@ Description:=09The "enabled" property prints a '1' if the=
 TPM chip is enabled,
 What:=09=09/sys/class/tpm/tpmX/device/owned
 Date:=09=09April 2006
 KernelVersion:=092.6.17
-Contact:=09tpmdd-devel@lists.sf.net
+Contact:=09linux-integrity@vger.kernel.org
 Description:=09The "owned" property produces a '1' if the TPM_TakeOwnershi=
p
 =09=09ordinal has been executed successfully in the chip. A '0'
 =09=09indicates that ownership hasn't been taken.
@@ -86,7 +86,7 @@ Description:=09The "owned" property produces a '1' if the=
 TPM_TakeOwnership
 What:=09=09/sys/class/tpm/tpmX/device/pcrs
 Date:=09=09April 2005
 KernelVersion:=092.6.12
-Contact:=09tpmdd-devel@lists.sf.net
+Contact:=09linux-integrity@vger.kernel.org
 Description:=09The "pcrs" property will dump the current value of all Plat=
form
 =09=09Configuration Registers in the TPM. Note that since these
 =09=09values may be constantly changing, the output is only valid
@@ -109,7 +109,7 @@ Description:=09The "pcrs" property will dump the curren=
t value of all Platform
 What:=09=09/sys/class/tpm/tpmX/device/pubek
 Date:=09=09April 2005
 KernelVersion:=092.6.12
-Contact:=09tpmdd-devel@lists.sf.net
+Contact:=09linux-integrity@vger.kernel.org
 Description:=09The "pubek" property will return the TPM's public endorseme=
nt
 =09=09key if possible. If the TPM has had ownership established and
 =09=09is version 1.2, the pubek will not be available without the
@@ -161,7 +161,7 @@ Description:=09The "pubek" property will return the TPM=
's public endorsement
 What:=09=09/sys/class/tpm/tpmX/device/temp_deactivated
 Date:=09=09April 2006
 KernelVersion:=092.6.17
-Contact:=09tpmdd-devel@lists.sf.net
+Contact:=09linux-integrity@vger.kernel.org
 Description:=09The "temp_deactivated" property returns a '1' if the chip h=
as
 =09=09been temporarily deactivated, usually until the next power
 =09=09cycle. Whether a warm boot (reboot) will clear a TPM chip
@@ -170,7 +170,7 @@ Description:=09The "temp_deactivated" property returns =
a '1' if the chip has
 What:=09=09/sys/class/tpm/tpmX/device/timeouts
 Date:=09=09March 2011
 KernelVersion:=093.1
-Contact:=09tpmdd-devel@lists.sf.net
+Contact:=09linux-integrity@vger.kernel.org
 Description:=09The "timeouts" property shows the 4 vendor-specific values
 =09=09for the TPM's interface spec timeouts. The use of these
 =09=09timeouts is defined by the TPM interface spec that the chip
--=20
2.23.0

