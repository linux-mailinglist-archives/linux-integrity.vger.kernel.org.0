Return-Path: <linux-integrity+bounces-3329-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E03095485A
	for <lists+linux-integrity@lfdr.de>; Fri, 16 Aug 2024 13:56:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33D641F23030
	for <lists+linux-integrity@lfdr.de>; Fri, 16 Aug 2024 11:56:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFFC61ABEB4;
	Fri, 16 Aug 2024 11:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=earth.li header.i=@earth.li header.b="WFHHZ5OD"
X-Original-To: linux-integrity@vger.kernel.org
Received: from the.earth.li (the.earth.li [93.93.131.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8586E1AD3EF;
	Fri, 16 Aug 2024 11:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.93.131.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723809359; cv=none; b=XISJ+klktLmPhkBenpMYtbdelLWvJSToYI+t5F5gHXcCswoVLbfxueZspn6qFjpRGaSxtTsiaUdOlIydIq7Z8Fbqaq/0O3IDb5bNSTiaa0tFd5P6XJ7t7sRIzvZ0DPsdGGfXeuEyvgW5riwbiIZOkurnMxsKgGkzRED90RCF05w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723809359; c=relaxed/simple;
	bh=P1zQUaopEBnPUj03ntwAXsb5a66WDUioes3LPXmeLK8=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S+WDsMaaNhgzVhQQxdCGllZuJDSIO7f/tiCHWtD2gdq7uFHvseYAsa+pwzM1ReImxjmnzNomvgeW8DfyKY1yfiUP8wyEcx5jqbFb+nKkOByA3lVocxqijqYqo41QEy//dx9xvJ+k+mPOb6YXiAy9Mh4TGPTMIxM8Cw3sYC3tf8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=earth.li; spf=pass smtp.mailfrom=earth.li; dkim=pass (2048-bit key) header.d=earth.li header.i=@earth.li header.b=WFHHZ5OD; arc=none smtp.client-ip=93.93.131.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=earth.li
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=earth.li
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=earth.li;
	s=the; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:
	To:From:Date:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=Wl3ZHAqgIGZLTckXRyqpTcjRcs19ZwdEjD9GnraGpIQ=; b=WFHHZ5ODphxCrj5bFJ1/Qx94Qh
	Ii2eCi++8hZZcvTgw0OvHOh35JGxiCkEyOjf9cJHEWhqvS4So7/L0dytvcf05cIJIiBrgOjvfl1eJ
	EdDjIdUq/Xq22AO6xinXXML8OgebMYMQ4Mh3fkV/DuTahu+QJmyR9T8zDgdDeGAh8Fu047O1IxMKn
	jxKbe5qfvpzh37ZUKMphsCJIxeq9chMiMLG9t0WOJg/srvWycABjwSdXLqWjnoI9cCnjoq8Vxa3/p
	U7WBGH7Kl1g3iVRVoLKk6lJNEhHpPM9Uwe3qFN3nI2hkAMpHdcImH+qtGwLSRxOdg1bjg8X7uaunR
	uOejhPdg==;
Received: from noodles by the.earth.li with local (Exim 4.96)
	(envelope-from <noodles@earth.li>)
	id 1sevYY-00EUiR-2M;
	Fri, 16 Aug 2024 12:55:46 +0100
Date: Fri, 16 Aug 2024 12:55:46 +0100
From: Jonathan McDowell <noodles@earth.li>
To: Jarkko Sakkinen <jarkko@kernel.org>, Peter Huewe <peterhuewe@gmx.de>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] tpm: Clean up TPM space after command failure
Message-ID: <Zr8-QijwOpDLkol3@earth.li>
References: <ZrzY_LWIXABkqd-S@earth.li>
 <D3GPGYHWPGFL.1S13HXY9ALZCU@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D3GPGYHWPGFL.1S13HXY9ALZCU@kernel.org>

From: Jonathan McDowell <noodles@meta.com>

tpm_dev_transmit prepares the TPM space before attempting command
transmission. However if the command fails no rollback of this
preparation is done. This can result in transient handles being leaked
if the device is subsequently closed with no further commands performed.

Fix this by flushing the space in the event of command transmission
failure.

Fixes: 745b361e989a ("tpm: infrastructure for TPM spaces")
Signed-off-by: Jonathan McDowell <noodles@meta.com>
---
v2:
 - Add 'Fixes:'
 - Cc James as one of the original authors
 - Add space sanity check in tpm2_flush_space

 drivers/char/tpm/tpm-dev-common.c | 2 ++
 drivers/char/tpm/tpm2-space.c     | 3 +++
 2 files changed, 5 insertions(+)

diff --git a/drivers/char/tpm/tpm-dev-common.c b/drivers/char/tpm/tpm-dev-common.c
index 30b4c288c1bb..c3fbbf4d3db7 100644
--- a/drivers/char/tpm/tpm-dev-common.c
+++ b/drivers/char/tpm/tpm-dev-common.c
@@ -47,6 +47,8 @@ static ssize_t tpm_dev_transmit(struct tpm_chip *chip, struct tpm_space *space,
 
 	if (!ret)
 		ret = tpm2_commit_space(chip, space, buf, &len);
+	else
+		tpm2_flush_space(chip);
 
 out_rc:
 	return ret ? ret : len;
diff --git a/drivers/char/tpm/tpm2-space.c b/drivers/char/tpm/tpm2-space.c
index 4892d491da8d..25a66870c165 100644
--- a/drivers/char/tpm/tpm2-space.c
+++ b/drivers/char/tpm/tpm2-space.c
@@ -169,6 +169,9 @@ void tpm2_flush_space(struct tpm_chip *chip)
 	struct tpm_space *space = &chip->work_space;
 	int i;
 
+	if (!space)
+		return;
+
 	for (i = 0; i < ARRAY_SIZE(space->context_tbl); i++)
 		if (space->context_tbl[i] && ~space->context_tbl[i])
 			tpm2_flush_context(chip, space->context_tbl[i]);
-- 
2.46.0


