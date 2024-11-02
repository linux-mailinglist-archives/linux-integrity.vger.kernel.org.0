Return-Path: <linux-integrity+bounces-4001-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CE769BA127
	for <lists+linux-integrity@lfdr.de>; Sat,  2 Nov 2024 16:23:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3809B1C21351
	for <lists+linux-integrity@lfdr.de>; Sat,  2 Nov 2024 15:23:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A90A1AB512;
	Sat,  2 Nov 2024 15:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OPHB5x7a"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DA721AB50D;
	Sat,  2 Nov 2024 15:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730560976; cv=none; b=GgR/V1binuNqwO/oI2Nz0D+bvkgxyTv2Agn4Je7bLERATe0vUU39irb7QLBITUEmrI5st3xcvL2L+9K6iZ8sfH17Bzk93STsHWPFXbj8ykT5qKpo00Oq8EAEIbaVbhpXB+V/xP5tI3QHSPZ5gTW+x/iVZPbRteKgICw29Gxc9gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730560976; c=relaxed/simple;
	bh=e+MpOC0Ch/mh7XcLQQJX783++tlbidsB+xGwfq076W0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mXVP3892B6TaZjnWOkNg2kNb/+6+VzSWY1LDz/6HD4Rhho3AUXlUVXMNf8huLhleWGL2xcatVop6akjA7rtXvFuUmcKGLNL9n60lLnKLNV6ORuxDkw4M8ULcUY+INZSvjCjpYqvUiDa5Yb2lzDF+hA7sVfm8+8LL5hV5H/k2CQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OPHB5x7a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65A0CC4CED2;
	Sat,  2 Nov 2024 15:22:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730560975;
	bh=e+MpOC0Ch/mh7XcLQQJX783++tlbidsB+xGwfq076W0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OPHB5x7aU1Vm6EJLBbZp+gsIV6EjRGnpKZ7ClfOBgi7GQb8kIth++a/WH7fAbOrPv
	 +N1zRpVpXoyEqgJ8v/XPa0SOePssaQ9iMTEzCmbN3Izgp3RfqjmL8jqRJcKb194IL1
	 bmAseRBRT5x2vRUCQvGhzFXy/0q4YKiSAngaaandWbq/kNgH9aiKy0ZAbU8J0mwGFI
	 USy6HxLLhKRWnwrXdjgT5LfnvQG8W3juMLUtOqOLqV4HnvXUpFNMTGA86fnvnkYupU
	 kkcfKT5AVa9OPtnLI38t6ItjeQpEewKKO1IKx20nPHgvkleCSxmmlm5Y3aUQ6Wrqta
	 9fyXn5lkRHQAA==
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Peter Huewe <peterhuewe@gmx.de>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>
Cc: x86@kernel.org,
	"Daniel P. Smith" <dpsmith@apertussolutions.com>,
	Ross Philipson <ross.philipson@oracle.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-integrity@vger.kernel.org (open list:TPM DEVICE DRIVER),
	linux-kernel@vger.kernel.org (open list)
Subject: [RFC PATCH 4/4] tpm: sysfs: Show locality used by kernel
Date: Sat,  2 Nov 2024 17:22:21 +0200
Message-ID: <20241102152226.2593598-5-jarkko@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241102152226.2593598-1-jarkko@kernel.org>
References: <20241102152226.2593598-1-jarkko@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ross Philipson <ross.philipson@oracle.com>

Expose the locality used by kernel to sysfs.

Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
---
 drivers/char/tpm/tpm-sysfs.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/char/tpm/tpm-sysfs.c b/drivers/char/tpm/tpm-sysfs.c
index 94231f052ea7..2da5857e223b 100644
--- a/drivers/char/tpm/tpm-sysfs.c
+++ b/drivers/char/tpm/tpm-sysfs.c
@@ -309,6 +309,14 @@ static ssize_t tpm_version_major_show(struct device *dev,
 }
 static DEVICE_ATTR_RO(tpm_version_major);
 
+static ssize_t locality_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct tpm_chip *chip = to_tpm_chip(dev);
+
+	return sprintf(buf, "%u\n", chip->kernel_locality);
+}
+static DEVICE_ATTR_RO(locality);
+
 #ifdef CONFIG_TCG_TPM2_HMAC
 static ssize_t null_name_show(struct device *dev, struct device_attribute *attr,
 			      char *buf)
@@ -336,6 +344,7 @@ static struct attribute *tpm1_dev_attrs[] = {
 	&dev_attr_durations.attr,
 	&dev_attr_timeouts.attr,
 	&dev_attr_tpm_version_major.attr,
+	&dev_attr_locality.attr,
 	NULL,
 };
 
@@ -344,6 +353,7 @@ static struct attribute *tpm2_dev_attrs[] = {
 #ifdef CONFIG_TCG_TPM2_HMAC
 	&dev_attr_null_name.attr,
 #endif
+	&dev_attr_locality.attr,
 	NULL
 };
 
-- 
2.47.0


