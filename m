Return-Path: <linux-integrity+bounces-5580-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49357A7A94D
	for <lists+linux-integrity@lfdr.de>; Thu,  3 Apr 2025 20:25:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0EFD417600A
	for <lists+linux-integrity@lfdr.de>; Thu,  3 Apr 2025 18:25:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96D51251780;
	Thu,  3 Apr 2025 18:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="cScnM1Fo";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="cK10crev";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="cScnM1Fo";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="cK10crev"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C785EEAFA
	for <linux-integrity@vger.kernel.org>; Thu,  3 Apr 2025 18:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743704728; cv=none; b=CWdsauVLLqlVOKhM+wvr6TGqUdIrZgeu8BKZ4VesJ/KhUUNCMW3bmT/ozXq2esxzxnTDM3RZpdV7H2KRLojtmi4vmuO8wV2jX9fJGy6QggUj5A9iZbESc8k1Dc7S7eiJj8Ob+JezcsVYUoUeCEd9p00Nrs1i08xohb2BDsp9OOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743704728; c=relaxed/simple;
	bh=4U7Y4TPzjdvwwWwbTnsBFI7iUaIV2E7tt6vh6whq3WM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ot4xKt5Hpblf+N+4YlN95eVwr9yYCLBq83zhlzbrfzAoFngxd/hBFGfUAQEDuFJvkeLja7/gTuNElmnZi+vJIP920gsrpOOgt5tR5AeEaWMkTaDcLoE6wDaMb1A0eJKJ76mn0WiEamz0Pf5cAK8WY8B7iTZvrMl03MSKnaORAiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=cScnM1Fo; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=cK10crev; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=cScnM1Fo; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=cK10crev; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from kitsune.suse.cz (unknown [10.100.12.127])
	by smtp-out1.suse.de (Postfix) with ESMTP id D656421179;
	Thu,  3 Apr 2025 18:25:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1743704724; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zcub6AXHtOqkOPyJyMCA+ii3fMPs0JO17FsFZGM4v2E=;
	b=cScnM1Foyg6ZxlKP3iJojJZNFFZrH6oG19ZtpSlfda43mjBFQZG4lvviRyxFfnivYDplwc
	0kScRmyjs8yCxtIyLdPutBOkJIB4sI7tJaP8odKkx6hqV9Dqj2dEH4aYfY6GVZxifRKMo3
	ke5jPHIRTvy/53Q8YfFUK7vUCFXKlT0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1743704724;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zcub6AXHtOqkOPyJyMCA+ii3fMPs0JO17FsFZGM4v2E=;
	b=cK10crevpA8ZlP29uLSegL1Tn/9FGKwhb+ApVtqr4XguCBn9A8d9wuaVHMdZszpUfh0Jk8
	jQnH5ItKbNIwjvAw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1743704724; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zcub6AXHtOqkOPyJyMCA+ii3fMPs0JO17FsFZGM4v2E=;
	b=cScnM1Foyg6ZxlKP3iJojJZNFFZrH6oG19ZtpSlfda43mjBFQZG4lvviRyxFfnivYDplwc
	0kScRmyjs8yCxtIyLdPutBOkJIB4sI7tJaP8odKkx6hqV9Dqj2dEH4aYfY6GVZxifRKMo3
	ke5jPHIRTvy/53Q8YfFUK7vUCFXKlT0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1743704724;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zcub6AXHtOqkOPyJyMCA+ii3fMPs0JO17FsFZGM4v2E=;
	b=cK10crevpA8ZlP29uLSegL1Tn/9FGKwhb+ApVtqr4XguCBn9A8d9wuaVHMdZszpUfh0Jk8
	jQnH5ItKbNIwjvAw==
From: Michal Suchanek <msuchanek@suse.de>
To: 
Cc: Michal Suchanek <msuchanek@suse.de>,
	Peter Huewe <peterhuewe@gmx.de>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jonathan McDowell <noodles@earth.li>
Subject: [PATCH] tpm: tis: Increase the default for timeout B
Date: Thu,  3 Apr 2025 20:25:05 +0200
Message-ID: <20250403182519.8412-1-msuchanek@suse.de>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <Z-6Gau3aCB7B3pB9@earth.li>
References: <Z-6Gau3aCB7B3pB9@earth.li>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_COUNT_ZERO(0.00)[0];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FREEMAIL_CC(0.00)[suse.de,gmx.de,kernel.org,ziepe.ca,vger.kernel.org,earth.li];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmx.de]
X-Spam-Score: -2.80
X-Spam-Flag: NO

With some Infineon chips the timeouts in tpm_tis_send_data (both B and
C) can reach up to about 2250 ms.

Timeout C is retried since
commit de9e33df7762 ("tpm, tpm_tis: Workaround failed command reception on Infineon devices")

Timeout B still needs to be extended.

Link: https://lore.kernel.org/linux-integrity/Z5pI07m0Muapyu9w@kitsune.suse.cz/
Signed-off-by: Michal Suchanek <msuchanek@suse.de>
---
V2: Only extend timeout B
---
 drivers/char/tpm/tpm_tis_core.h | 2 +-
 include/linux/tpm.h             | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/char/tpm/tpm_tis_core.h b/drivers/char/tpm/tpm_tis_core.h
index 970d02c337c7..c272c25eb9d4 100644
--- a/drivers/char/tpm/tpm_tis_core.h
+++ b/drivers/char/tpm/tpm_tis_core.h
@@ -54,7 +54,7 @@ enum tis_int_flags {
 enum tis_defaults {
 	TIS_MEM_LEN = 0x5000,
 	TIS_SHORT_TIMEOUT = 750,	/* ms */
-	TIS_LONG_TIMEOUT = 2000,	/* 2 sec */
+	TIS_LONG_TIMEOUT = 4000,	/* 4 sec */
 	TIS_TIMEOUT_MIN_ATML = 14700,	/* usecs */
 	TIS_TIMEOUT_MAX_ATML = 15000,	/* usecs */
 };
diff --git a/include/linux/tpm.h b/include/linux/tpm.h
index 6c3125300c00..3db0b6a87d45 100644
--- a/include/linux/tpm.h
+++ b/include/linux/tpm.h
@@ -224,7 +224,7 @@ enum tpm2_const {
 
 enum tpm2_timeouts {
 	TPM2_TIMEOUT_A          =    750,
-	TPM2_TIMEOUT_B          =   2000,
+	TPM2_TIMEOUT_B          =   4000,
 	TPM2_TIMEOUT_C          =    200,
 	TPM2_TIMEOUT_D          =     30,
 	TPM2_DURATION_SHORT     =     20,
-- 
2.47.1


