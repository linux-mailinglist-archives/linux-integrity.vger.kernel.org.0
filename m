Return-Path: <linux-integrity+bounces-9525-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WE/BDwpWA2qQ4wEAu9opvQ
	(envelope-from <linux-integrity+bounces-9525-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Tue, 12 May 2026 18:32:10 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BD394524BCB
	for <lists+linux-integrity@lfdr.de>; Tue, 12 May 2026 18:32:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B38193147FD4
	for <lists+linux-integrity@lfdr.de>; Tue, 12 May 2026 16:16:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42D7F3CC332;
	Tue, 12 May 2026 16:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fxWD6aW4"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FF053C98BE;
	Tue, 12 May 2026 16:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778602587; cv=none; b=EdqDrFxnBBdj2XIiLi7mwe0afMr24WKIsSR7aZIWPaFO3dhRn+HkCvxe7s3KMyZQ8UHV6A/KOXA+anRuPf8Hnp3kvi9qRHUKwQdnMIRnLOTLu+gHL4FuGBjY+SMt2i5IB5fS/+7VYmwiO7iDpgUHO0/uMT4VffFn7Epl46eCIXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778602587; c=relaxed/simple;
	bh=F8HlQwbMO4eyeNJMSbZpp+Tm7Vi9mQe/nxIZTC2RdBk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qglP6pwXzUJMyiF8zb7EZKWjJzUnWLR7dZB9H7bulirrHrRG/xMs45g8xuggWRrR9mm4SmOZR6sFnEpZ35nyEkakBRur+hzJUqcpcs62DcDtuwwbhuNQnrgEwiPsdkBdff99AfnwKc+k+sm+NbmEuvhnRhb0SiFX92s4hJ+2PXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fxWD6aW4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2471C2BCC7;
	Tue, 12 May 2026 16:16:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778602586;
	bh=F8HlQwbMO4eyeNJMSbZpp+Tm7Vi9mQe/nxIZTC2RdBk=;
	h=From:To:Cc:Subject:Date:From;
	b=fxWD6aW4FJ55ui3vuQoOlO8O0sW2rtK/9oNySoDlt8zCLap46UZWAm1COyVB9Cf89
	 /w4y/PrKC+Ws+2xp6ac7Phu3+WkwseoFS0GK5XBrO8rYH94xa0XFzniJeWnLE5tXOd
	 NRc64OduVL5BRWhwsOJ3tfcWEzROeACbRosS8JmB1R8eQts9VQA3W4vWefOzHpPlSb
	 UgKFB8oSza6yHb7+vsRm35ZajYaj33F6rmbtdWYZucSFOcwfQjoQj73SlJL0pJRaGX
	 qMi7jI852mjGd9PCJ5G9byj6Wm30FFNq1rRN0HqGTkyU3LNzDKRIUr9tpyCMd+gufP
	 yBsMUhWKgot3w==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
 linux-integrity@vger.kernel.org,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 LKML <linux-kernel@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>
Subject: [PATCH v1] tpm_crb: Check ACPI_COMPANION() against NULL during probe
Date: Tue, 12 May 2026 18:16:23 +0200
Message-ID: <2848144.mvXUDI8C0e@rafael.j.wysocki>
Organization: Linux Kernel Development
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: BD394524BCB
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	CTE_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmx.de,ziepe.ca,vger.kernel.org,linux.intel.com];
	TAGGED_FROM(0.00)[bounces-9525-lists,linux-integrity=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rafael@kernel.org,linux-integrity@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-integrity];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,rafael.j.wysocki:mid]
X-Rspamd-Action: no action

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

Every platform driver can be forced to match a device that doesn't match
its list of device IDs because of device_match_driver_override(), so
platform drivers that rely on the existence of a device's ACPI companion
object need to verify its presence.

Accordingly, add a requisite ACPI_COMPANION() check against NULL to the
tpm_crb driver.

Fixes: 48fe2cddc85c ("tpm_crb: Convert ACPI driver to a platform one")
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/char/tpm/tpm_crb.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

--- a/drivers/char/tpm/tpm_crb.c
+++ b/drivers/char/tpm/tpm_crb.c
@@ -786,8 +786,8 @@ static int crb_map_pluton(struct device
 static int crb_acpi_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
-	struct acpi_device *device = ACPI_COMPANION(dev);
 	struct acpi_table_tpm2 *buf;
+	struct acpi_device *device;
 	struct crb_priv *priv;
 	struct tpm_chip *chip;
 	struct tpm2_crb_smc *crb_smc;
@@ -797,6 +797,10 @@ static int crb_acpi_probe(struct platfor
 	u32 sm;
 	int rc;
 
+	device = ACPI_COMPANION(dev);
+	if (!device)
+		return -ENODEV;
+
 	status = acpi_get_table(ACPI_SIG_TPM2, 1,
 				(struct acpi_table_header **) &buf);
 	if (ACPI_FAILURE(status) || buf->header.length < sizeof(*buf)) {




