Return-Path: <linux-integrity+bounces-3314-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A8D495201E
	for <lists+linux-integrity@lfdr.de>; Wed, 14 Aug 2024 18:36:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFE0728A960
	for <lists+linux-integrity@lfdr.de>; Wed, 14 Aug 2024 16:36:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8DCB1B8E98;
	Wed, 14 Aug 2024 16:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=earth.li header.i=@earth.li header.b="KtUVRdbB"
X-Original-To: linux-integrity@vger.kernel.org
Received: from the.earth.li (the.earth.li [93.93.131.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12A8C2BB1C;
	Wed, 14 Aug 2024 16:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.93.131.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723653393; cv=none; b=VwmhG3v/AsODA677uyQLqhRJpYZxNhAMz3THnbxviaPbG181EmTK9VoF6bfco2wPZZA4GZiP2FR0LCPu/ubT2CD/6DVKP1y7J9yM8yyyeKRQN/uIbh+iNBheyOmxyvkdRnBHJHUAZWZCQsRaxSM5xQEc65u2kwYBAEvmUW0tTI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723653393; c=relaxed/simple;
	bh=SD4ky/IGZ61AUsL3mlyIH0wAdX/QeyBja3qwrblQLCk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=eRoqu+ZcMsq0O9slq1HAr10PoNS4eNxZnFMB/9zDaw5wbx9RdqxRz/9DTRkcl1mhXbnaT6ApKfrRvY+uNMY73/YcGUfnPklvdJG2LVgaGzubvXdA1VoDGjT1ERE41OO8xxHBho7gIEyj6gYqerE+V2kPzeLQU/fSOiBuUd7M4Og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=earth.li; spf=pass smtp.mailfrom=earth.li; dkim=pass (2048-bit key) header.d=earth.li header.i=@earth.li header.b=KtUVRdbB; arc=none smtp.client-ip=93.93.131.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=earth.li
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=earth.li
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=earth.li;
	s=the; h=Content-Type:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Sender:
	Reply-To:Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date
	:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
	List-Owner:List-Archive; bh=+XpfXLOB0tocY50bNKQJ2ipYCYlbg8wHXzHAW0qFiAM=; b=K
	tUVRdbBqDrp0jrRi3gCXjpHNOU9kRO3WNVkVqYqw0ngYhOY2gbAynfhM9pmiKrfedRcYtgni6X3RG
	yjdSUqqp3E1ecKDiM1VViWZjsZbHf4wa7LfPhla1GeDD7NGV4hqL0wt8lm+0hlpbMdN6QgkWHOz2g
	DLPllvyTrehK8BlxclvadOrAxU+T6k7eZzdlTdKA3W9/WBsEb3NEoiGYJa7e4LJMyrt1RyFpL08qw
	qF7vzUDqkdqnPi3LRFSqVnUIHvvZFxhD7v/KgxMdtpQQycLjYFG75RxbZvBTMxrqo/FzR2t8mOe7V
	bEKGG40AhrE+q4edmoC5bvfJnu2bMqL0Q==;
Received: from noodles by the.earth.li with local (Exim 4.96)
	(envelope-from <noodles@earth.li>)
	id 1seGiK-00BLyg-26;
	Wed, 14 Aug 2024 17:19:08 +0100
Date: Wed, 14 Aug 2024 17:19:08 +0100
From: Jonathan McDowell <noodles@earth.li>
To: linux-integrity@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Jarkko Sakkinen <jarkko@kernel.org>,
	Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>
Subject: [RFC] [PATCH] tpm: Clean up TPM space after command failure
Message-ID: <ZrzY_LWIXABkqd-S@earth.li>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

We've been seeing a problem where TPM commands time out, which if
they're the last command before the TPM device is closed causes a leak
of transient handles. They can be seen and cleaned up (with a flush
context) if the /dev/tpm0 device is used instead of /dev/tpmrm0, but it
seems like we should be doing this automatically on the transmit error
path. Patch below adds a tpm2_flush_space on error to avoid this.

Does this seem reasonable? The other query is whether tpm2_del_space
should cleanup the contexts as well, rather than just the sessions.

(Obviously in an ideal world we wouldn't see the timeouts at all, and
I'm still trying to work on getting to the bottom of these, which are
generally infrequent, but happening enough across our fleet that we were
able to observe this handle leak.)

From: Jonathan McDowell <noodles@meta.com>

tpm_dev_transmit prepares the TPM space before attempting command
transmission. However if the command fails no rollback of this
preparation is done. This can result in transient handles being leaked
if the device is subsequently closed with no further commands performed.

Fix this by flushing the space in the event of command transmission
failure.

Signed-off-by: Jonathan McDowell <noodles@meta.com>

---
 drivers/char/tpm/tpm-dev-common.c | 2 ++
 1 file changed, 2 insertions(+)

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
-- 
2.46.0


