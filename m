Return-Path: <linux-integrity+bounces-6769-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 049EDB188AE
	for <lists+linux-integrity@lfdr.de>; Fri,  1 Aug 2025 23:26:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A7BA1C82110
	for <lists+linux-integrity@lfdr.de>; Fri,  1 Aug 2025 21:26:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E1BE28D829;
	Fri,  1 Aug 2025 21:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PMG8srM3"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 117F814AD2B;
	Fri,  1 Aug 2025 21:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754083579; cv=none; b=p6K93vLVvThZiMzjKWJywg5HVKlcoqhYimc2OusXXzxHN9MDOFXg3fo9izv/De45bD8z5UgLTeCDqoRE5z6SsAHYIaCZcZU8TFZ/mVVWjaygm/1EQj7wOFis5M30fRg+e/kq9SEScZnpvk3QCth+B3YbKtoWFlBegh/fYNYgbu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754083579; c=relaxed/simple;
	bh=f4b9XfkA3nNYriclhoabu7l9n3q5dohUeAnWJVMju7Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Bs9TcNABMJnkMC/7+hO/RKTAyjNV/EdKaSMnfruFS81MFTB4wGIlUuJqORHUswDhtYMrc48xKzP0cpT7yUWpxc4gBtmn4QCXuK4oWUcCs2NpsfNBUbjtme9QoS3DrJGDqn2rEC4H3xOqib8uxwqRXNwAVB5P3Vm0AtjCBzP7zAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PMG8srM3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D238C4CEE7;
	Fri,  1 Aug 2025 21:26:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754083578;
	bh=f4b9XfkA3nNYriclhoabu7l9n3q5dohUeAnWJVMju7Y=;
	h=From:To:Cc:Subject:Date:From;
	b=PMG8srM364lN4emJ3qvQpxqV+4ACvg5A7le4FrKzBNOaJt8fiQo1JA6rbBGVC3xj2
	 Ys3M83cQ8llW0FSW4EtdvUvUJD8F7bIr9FB4NeELwNl+7zHfIQ38wjqnRfEgWJOdQr
	 Di9OzrOJJ5SS6evzfiTyuDPPwnogO48oEwoBQPhag0Ms3U+NXlUiq/6OHaBVvq3pR4
	 5Fkn2K1cWtQTmpw8+HEeXZIbLIYwtUeCRSNrlcVBFqPWHKIjDCGLyM/wdDirDaSeIu
	 Tj7xtAvTySiUe+kPrEkBHIM6NG789CDLCjX46dnb7uGlJ+rlpAtvr29pX5HzCymtvt
	 5HuMiACNvlC6Q==
From: Eric Biggers <ebiggers@kernel.org>
To: Peter Huewe <peterhuewe@gmx.de>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	linux-integrity@vger.kernel.org
Cc: Jason Gunthorpe <jgg@ziepe.ca>,
	James Bottomley <James.Bottomley@HansenPartnership.com>,
	linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Eric Biggers <ebiggers@kernel.org>
Subject: [PATCH v2 0/2] tpm: Clean up HMAC validation and computation
Date: Fri,  1 Aug 2025 14:24:20 -0700
Message-ID: <20250801212422.9590-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Patch 1 updates the tpm driver to compare HMAC values in constant time.

Patch 2 simplifies the HMAC computation in the tpm driver by using the
library API instead of an open-coded HMAC implementation.  Note that
this depends on the HMAC library API that was merged for v6.17-rc1.

Changed in v2:
  - Updated commit message of patch 1 to no longer characterize it as a
    fix.  Explained why the side channel seems to have been benign.

Eric Biggers (2):
  tpm: Compare HMAC values in constant time
  tpm: Use HMAC-SHA256 library instead of open-coded HMAC

 drivers/char/tpm/Kconfig         |   1 +
 drivers/char/tpm/tpm2-sessions.c | 104 +++++++++----------------------
 2 files changed, 31 insertions(+), 74 deletions(-)


base-commit: d6084bb815c453de27af8071a23163a711586a6c
-- 
2.50.1


