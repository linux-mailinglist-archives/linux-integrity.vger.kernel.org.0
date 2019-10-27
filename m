Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 50B0AE64E9
	for <lists+linux-integrity@lfdr.de>; Sun, 27 Oct 2019 19:38:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727754AbfJ0SiL (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 27 Oct 2019 14:38:11 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:49271 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727749AbfJ0SiL (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 27 Oct 2019 14:38:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1572201490;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=Os/NUKwFnOoKRh5OwekjEysO6Hpxh7Ew1oBZlni5GEM=;
        b=Lv1EDx79uDmf56syKIgMnFTcECOWmGgcCGvz4Dbl0g+/yAmwkQ9x10NR7BXDjR7v/TNd6L
        Ay798zeGLn+uuryzwmTgptBfaQZraJ687Jm/BJd3iGS0OoDVBDGS1TrynS5AsO3mkIA5kG
        9mfS/S0aY0nY7dEQ+q0DdyfOf9NRsrk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-46-81Y-X_ioMlS9RXZCF6y9Nw-1; Sun, 27 Oct 2019 14:38:06 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8C0121005500;
        Sun, 27 Oct 2019 18:38:05 +0000 (UTC)
Received: from cantor.redhat.com (ovpn-117-192.phx2.redhat.com [10.3.117.192])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2B33160923;
        Sun, 27 Oct 2019 18:38:05 +0000 (UTC)
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-integrity@vger.kernel.org
Subject: [PATCH v3] tpm: Add version_major sysfs file
Date:   Sun, 27 Oct 2019 11:38:00 -0700
Message-Id: <20191027183800.11824-1-jsnitsel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: 81Y-X_ioMlS9RXZCF6y9Nw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Easily determining what TCG version a tpm device implements
has been a pain point for userspace for a long time, so
add a sysfs file to report the TCG version of a tpm device.

Also add an entry to Documentation/ABI/stable/sysfs-class-tpm
describing the new file.

Cc: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc: Peter Huewe <peterhuewe@gmx.de>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-integrity@vger.kernel.org
Signed-off-by: Jerry Snitselaar <jsnitsel@redhat.com>
---
v3: - Change file name to version_major.
v2: - Fix TCG usage in commit message.
    - Add entry to sysfs-class-tpm in Documentation/ABI/stable

 Documentation/ABI/stable/sysfs-class-tpm | 11 ++++++++
 drivers/char/tpm/tpm-sysfs.c             | 34 +++++++++++++++++++-----
 2 files changed, 38 insertions(+), 7 deletions(-)

diff --git a/Documentation/ABI/stable/sysfs-class-tpm b/Documentation/ABI/s=
table/sysfs-class-tpm
index c0e23830f56a..116f8d3a8ddc 100644
--- a/Documentation/ABI/stable/sysfs-class-tpm
+++ b/Documentation/ABI/stable/sysfs-class-tpm
@@ -183,3 +183,14 @@ Description:=09The "timeouts" property shows the 4 ven=
dor-specific values
 =09=09The four timeout values are shown in usecs, with a trailing
 =09=09"[original]" or "[adjusted]" depending on whether the values
 =09=09were scaled by the driver to be reported in usec from msecs.
+
+What:=09=09/sys/class/tpm/tpmX/version_major
+Date:=09=09October 2019
+KernelVersion:=095.5
+Contact:=09linux-integrity@vger.kernel.org
+Description:=09The "version_major" property shows the TCG spec version
+=09=09implemented by the TPM device.
+
+=09=09Example output:
+
+=09=092.0
diff --git a/drivers/char/tpm/tpm-sysfs.c b/drivers/char/tpm/tpm-sysfs.c
index edfa89160010..6993ef00f256 100644
--- a/drivers/char/tpm/tpm-sysfs.c
+++ b/drivers/char/tpm/tpm-sysfs.c
@@ -309,7 +309,17 @@ static ssize_t timeouts_show(struct device *dev, struc=
t device_attribute *attr,
 }
 static DEVICE_ATTR_RO(timeouts);
=20
-static struct attribute *tpm_dev_attrs[] =3D {
+static ssize_t version_major_show(struct device *dev,
+=09=09=09=09  struct device_attribute *attr, char *buf)
+{
+=09struct tpm_chip *chip =3D to_tpm_chip(dev);
+
+=09return sprintf(buf, "%s\n", chip->flags & TPM_CHIP_FLAG_TPM2
+=09=09       ? "2.0" : "1.2");
+}
+static DEVICE_ATTR_RO(version_major);
+
+static struct attribute *tpm12_dev_attrs[] =3D {
 =09&dev_attr_pubek.attr,
 =09&dev_attr_pcrs.attr,
 =09&dev_attr_enabled.attr,
@@ -320,18 +330,28 @@ static struct attribute *tpm_dev_attrs[] =3D {
 =09&dev_attr_cancel.attr,
 =09&dev_attr_durations.attr,
 =09&dev_attr_timeouts.attr,
+=09&dev_attr_version_major.attr,
 =09NULL,
 };
=20
-static const struct attribute_group tpm_dev_group =3D {
-=09.attrs =3D tpm_dev_attrs,
+static struct attribute *tpm20_dev_attrs[] =3D {
+=09&dev_attr_version_major.attr,
+=09NULL
+};
+
+static const struct attribute_group tpm12_dev_group =3D {
+=09.attrs =3D tpm12_dev_attrs,
+};
+
+static const struct attribute_group tpm20_dev_group =3D {
+=09.attrs =3D tpm20_dev_attrs,
 };
=20
 void tpm_sysfs_add_device(struct tpm_chip *chip)
 {
-=09if (chip->flags & TPM_CHIP_FLAG_TPM2)
-=09=09return;
-
 =09WARN_ON(chip->groups_cnt !=3D 0);
-=09chip->groups[chip->groups_cnt++] =3D &tpm_dev_group;
+=09if (chip->flags & TPM_CHIP_FLAG_TPM2)
+=09=09chip->groups[chip->groups_cnt++] =3D &tpm20_dev_group;
+=09else
+=09=09chip->groups[chip->groups_cnt++] =3D &tpm12_dev_group;
 }
--=20
2.23.0

