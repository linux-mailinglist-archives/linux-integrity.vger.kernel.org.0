Return-Path: <linux-integrity+bounces-9685-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8M0HOmkrFmqdigcAu9opvQ
	(envelope-from <linux-integrity+bounces-9685-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Wed, 27 May 2026 01:23:21 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 654165DD818
	for <lists+linux-integrity@lfdr.de>; Wed, 27 May 2026 01:23:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BE28F301FD7E
	for <lists+linux-integrity@lfdr.de>; Tue, 26 May 2026 23:23:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D7522264D6;
	Tue, 26 May 2026 23:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Eh+seoan"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE7CB3B0AEF
	for <linux-integrity@vger.kernel.org>; Tue, 26 May 2026 23:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779837796; cv=none; b=nK+CP6vnDdbHUf7/M3VpYUu6XL2sWWNpvZKuPKfzJItQ6DIwY1dVN6Cb3OmpQrsvIlScBozRyQeoXDPnACwz3EOmN6Rog0kkUOMhD8+ZUvXDD+TVZeWHOE5wzXiHh/QD5MovYTuxQ45HNZIR9w8NrYC8YIixxPJd2JH4iQQHnvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779837796; c=relaxed/simple;
	bh=ogD5kXGjWxCb0cPPbagTIFvwME8O8QomX8mEaNfCZDI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pUplcok1csRz2vQMMcLCmMxrH/FnINLl/+fdplwZUi5WRRA/Bu+DcXM6NBHR4AsPt+l/JphX75aJV2DsltgrZmGNugrOxWOMrr0RWNd6c+V2ww+N5tpcbT0m4LKyB2fUbW6AHRjdPV0NcH9Xude7OPHzyf4eVAl27lkLmoghpL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Eh+seoan; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2b9fcf7c91bso126045095ad.0
        for <linux-integrity@vger.kernel.org>; Tue, 26 May 2026 16:23:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779837795; x=1780442595; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DwZTd4s8kkFy/kiH4vgLJxWW7N4uonmfOEXaaUwbujg=;
        b=Eh+seoan5z78qPv5nOfMGV3b4KmC80SS0yHzrGyVwcMttIBZpYUxceVo6xSHMJ5ZMS
         X+NYKuVkj8jZndVMQJXNMeVq2ep2yM1CZiJ14pCcHgYmoMMofs26YrR46Wlt1oWMZHWd
         FNt3ontRnxtLC/FFTub9kwCfecTzhDNOflAXKSN11es88dOLTDqxBeWh0DDdGy/o2C65
         ax3ptU/isRkjRj0WxWgFBpx9Qg6ufOctIY3FHPpPzWmAqyI90o3KH5WRy06uhOOGwgWk
         ic8ii+Ddxwr7yvTWsSszh92sM8aHc8RBtXdmsy7GnTp7nDfWTiM0sj2DD3hKzXqaeX6c
         B/Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779837795; x=1780442595;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DwZTd4s8kkFy/kiH4vgLJxWW7N4uonmfOEXaaUwbujg=;
        b=i6W76WSVnBCrgN3OJPOvM+dvzWVklbKi3mQEDpcl0N01dmwkMg1GCvhYVlqGMN2ngA
         pWExGbshDEZsjLzYa4L9R9Nzubyqp1y5E0w9boxZsqcrNq3abTy+px6yaBtX0YUJ32L1
         QeJ29A++QncDs40gmanqePZ2p+qOb2m4c2aRXla/KgGV7Ujqi6tQyPa7izsHgPgvSknA
         3ewlg0v/KWML32lsvaBLuDY3Qnu+JgYsKfVNvG/NrRMzJ/uQvfV1hxY9dmdyL1C2z0Gt
         FEt/0tQ5SHi6tzYBoD++t2b95aGWb8kSq4WQahylfufhWGIPDYDNRxfHcQ8a7sDpij3g
         L4Tg==
X-Forwarded-Encrypted: i=1; AFNElJ94IOao2yao6SY0UGtyPST3/2SgmvYTIPr57YaHfsSGce+7ZAX4eALpwoJHbMjfxS4gqSJokHgGVFNBt1XJSG0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0zrMMDxhaNdS7lM/aMQwMTNazi+aiTpJqAJqpndpbsp0U4D+/
	aiXsx8rOHb+z/bqOG0WhylpBVKPgCoadhQz/lLsxSfGDxmCJaTXsswoK
X-Gm-Gg: Acq92OG8g2Hi1ZrqL5IoZ0IJ6NoNDhIBi4J0Gk5cP7llMgQML+xGsa92b6FnUaUBn+/
	spN1Gvfm/Z1qIaGrOsWcXthv9z2C8HSuw5WLJFxofl52p6xmBjGGRx93bdUGfwZqFU4gYdb/W53
	hXZ3ADiEzJyhNdHJ7xC5Q8aiJOAVJZrvflKJxsYLDlJgBI2kPL4UwpoK7ZPeqQMEhSsOt93LPct
	uX3uKh3gr8d0B4ERCYbTt6JrKXi4sZfXTerh4u2ghCS94ZOX2bQHG6wAowC1tA6KevFWkC0G90s
	WKezmpyXcZMQ3I5SOKq5I+QxYWQRD8ZnI/k+yNbWa0j5hh96PVzaIKoWvyuU4oNQHBdhey6HuHu
	/Tiusysmg+24ilYGj2J0wJlyX1IEbwsLLa7PXNDdg4XOtRxPKV0grT5q9l5AcdziycDY/UiJYxm
	njNfRmzFcDXrFzTB7o6UUcybOc3NNBYLgVO5Ao10N3l+l5ld1CrbfEG3hHt/tdDzhy7A==
X-Received: by 2002:a17:902:e548:b0:2ba:78a6:7dec with SMTP id d9443c01a7336-2beb05c07aemr238188645ad.13.1779837795124;
        Tue, 26 May 2026 16:23:15 -0700 (PDT)
Received: from harvey.lan (c-73-83-32-130.hsd1.wa.comcast.net. [73.83.32.130])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2beb5903bcasm142501045ad.77.2026.05.26.16.23.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 16:23:12 -0700 (PDT)
From: Jim Broadus <jbroadus@gmail.com>
To: jarkko@kernel.org,
	linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: peterhuewe@gmx.de,
	jgg@ziepe.ca,
	Jim Broadus <jbroadus@gmail.com>
Subject: [PATCH v3 0/2] tpm: tpm_tis: Fix probe of some older TPMs
Date: Tue, 26 May 2026 16:22:42 -0700
Message-ID: <20260526232245.5409-1-jbroadus@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260519154530.6386-1-jbroadus@gmail.com>
References: <20260519154530.6386-1-jbroadus@gmail.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmx.de,ziepe.ca,gmail.com];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-9685-lists,linux-integrity=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jbroadus@gmail.com,linux-integrity@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-integrity];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 654165DD818
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Changes v3:
- Renamed the series from "Add optional delay after relinquish" to
  "Fix probe of some older TPMs"
- Addressed review comment, saving entire did_vid in priv structure.
- Use did_vid value to identify problem TPM and apply quirk.
Changes v2:
- Move delay from tpm_tis_relinquish_locality to
  __tpm_tis_relinquish_locality.

Link to v2: https://lore.kernel.org/all/20260519154530.6386-1-jbroadus@gmail.com/

Jim Broadus (2):
  tpm: tpm_tis: store entire did_vid
  tpm: tpm_tis: Add settle time for some TPMs

 drivers/char/tpm/tpm_tis_core.c | 28 ++++++++++++++++++++--------
 drivers/char/tpm/tpm_tis_core.h |  3 ++-
 2 files changed, 22 insertions(+), 9 deletions(-)

-- 
2.54.0


