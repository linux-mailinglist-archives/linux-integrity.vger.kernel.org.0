Return-Path: <linux-integrity+bounces-7809-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A55ACA5F1D
	for <lists+linux-integrity@lfdr.de>; Fri, 05 Dec 2025 04:02:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B2AE3304E513
	for <lists+linux-integrity@lfdr.de>; Fri,  5 Dec 2025 03:02:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5140018D658;
	Fri,  5 Dec 2025 03:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EbPBQl+p"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26FFD78C9C;
	Fri,  5 Dec 2025 03:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764903738; cv=none; b=Cp5O7mLdIWQy/A1LjTHATw9LuLLjmIoHA+4I14i7DSx+g258cdrtkz6nEWnY6FJIjGXhfmKsI3VTW8ZM+4uiayFItZVlGnWLa6FO62U8kjZtpVrwNzFyln51XzW0lZRtLVxtO1KywbAfv94ZfW1tYvG5WZsm0UtZckh7MY4qjo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764903738; c=relaxed/simple;
	bh=+Ej7KhjqG1eMha76fSOp9vTt+OyHa2xYaKIwSE1P4Go=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UQGCjfer/jUrZJ2gdopRa9ra0Y0+5h08foAbRGs5w4BtHNWGEAUT207DWzQJ80g+jEPJvk9Sv9B94GijMu5LcfelhO9j7S6R+gBKvy9VkL6WHyjfY7hhyEg+AroGdcEAT6aMiwNgsnD7lssYVXAuTwWUgVNPnH92/psGFgbw/e0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EbPBQl+p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C101C4CEFB;
	Fri,  5 Dec 2025 03:02:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764903737;
	bh=+Ej7KhjqG1eMha76fSOp9vTt+OyHa2xYaKIwSE1P4Go=;
	h=From:To:Cc:Subject:Date:From;
	b=EbPBQl+plLsvbH67MJ77B+GbmJaI3LRyV4CGjahO7wM2hnS3dY7UVWKZS+Zm7kX5H
	 wbL8MmFDSnokeLvSTk1a/gFJTJp4nHJVaqQe7WYcEL/u8e6tvuKarB6t4jKkf/wmLd
	 piVrickvliR3elOad0k+gLu4Hjxuy6nZpaGod+/A4wGdFZb7wsAw7jsVoZUiKw4ovL
	 XF0Y2cOuOF5hkgpZieFRNvQLf63wKzjIu4UD5slcYMxfiZTTHyciK28b1MKu7v61QA
	 eXTEbvbP/MNhy1fIqM9ilQ+16fVbGph/EOfryKm4YoD3IQOu9BkVh5wmapzVbDQTFu
	 IwUh8ALCyrdCg==
From: Jarkko Sakkinen <jarkko@kernel.org>
To: linux-integrity@vger.kernel.org
Cc: Jarkko Sakkinen <jarkko@kernel.org>,
	Peter Huewe <peterhuewe@gmx.de>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 0/2] KEYS: trusted: Optimize tpm2_read_public() calls
Date: Fri,  5 Dec 2025 05:02:03 +0200
Message-ID: <20251205030205.140842-1-jarkko@kernel.org>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The main goal is fairly straight-forwrd here.

The aim of these patches is optimize the number of tpm2_read_public()
calls to the bare minimum.

Jarkko Sakkinen (2):
  KEYS: trusted: Re-orchestrate tpm2_read_public() calls
  KEYS: trusted: Store parent's name to the encoded keys

 drivers/char/tpm/tpm2-cmd.c               |   3 +-
 drivers/char/tpm/tpm2-sessions.c          |  95 +++-------
 include/linux/tpm.h                       |  10 +-
 security/keys/trusted-keys/tpm2key.asn1   |  17 +-
 security/keys/trusted-keys/trusted_tpm2.c | 207 +++++++++++++++-------
 5 files changed, 195 insertions(+), 137 deletions(-)

-- 
2.52.0


