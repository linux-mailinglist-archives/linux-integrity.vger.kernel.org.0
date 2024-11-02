Return-Path: <linux-integrity+bounces-3997-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 550859BA11F
	for <lists+linux-integrity@lfdr.de>; Sat,  2 Nov 2024 16:22:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89D4F1C20A74
	for <lists+linux-integrity@lfdr.de>; Sat,  2 Nov 2024 15:22:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C57F519F409;
	Sat,  2 Nov 2024 15:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eO+6t00x"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94A96185936;
	Sat,  2 Nov 2024 15:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730560955; cv=none; b=PrbFyrQZrvLvsjQaYQmDkwA3t4mpnZNpalY1mzvf7Qz0LaX1MjEQthwrLqTKPqEVovFPUDsofa1l635waSaDC3NL4oPWVqexADhsyzNWhVd10P9nfPGfjiWjjo/iPHhRaOTzBsD/R8UKFpFZnMoRA6EgR2B5efEL5w5EyNFYCjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730560955; c=relaxed/simple;
	bh=+4yeJxoy5TzGQqmW3McZmSpFQX3YOt4rUr10ONB5YiQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eUyQ7UrADNh0HeadZPnIOYqveZy49xaM+pXhidjcXtCA1EbI+pA+pHq/as/csf3zE/Hyo3oUIBpQBJeBgr1tmVFZN7EdIQ1+qRjfR9Urq/OYIfH0JQmzyDBiAHeNtzFgv1flh9tYrJGdiHpUHweY6sKJnQyQy24UVtGE3XhhzTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eO+6t00x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B5C4C4CEC3;
	Sat,  2 Nov 2024 15:22:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730560953;
	bh=+4yeJxoy5TzGQqmW3McZmSpFQX3YOt4rUr10ONB5YiQ=;
	h=From:To:Cc:Subject:Date:From;
	b=eO+6t00xX0YhLMMhRO26+9fkaMsLU5Y4BmIyqZbLZwpG91Q+k+/yGXCjK5fhToNYU
	 PSPkmeqcU2msZwcIKl/bibFTaNZ035cbsbEJpo62C8cpik1X/9Vb/6k6yewXr5cRYV
	 JVZTQbUbenVSgaWAUifboNqWFA5yACbonOJr421WeMyhIKuiGjrq6nAZWdG8kxtG62
	 fVJtHLfSdRyE35ePHMBaQcebRg5S+1rmBZdXh4ZvjF67eKyWIqvLsvDrTW9YJGjEhO
	 NOqNULhnlZZZEw9g4lyRzn1Fy/rS5zxqippnRL9Ssoqk5iqYZbG7PSIIBuZbKbBg/1
	 of29dsyZxYilg==
From: Jarkko Sakkinen <jarkko@kernel.org>
To: 
Cc: x86@kernel.org,
	Jarkko Sakkinen <jarkko@kernel.org>,
	"Daniel P. Smith" <dpsmith@apertussolutions.com>,
	Ross Philipson <ross.philipson@oracle.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Huewe <peterhuewe@gmx.de>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	linux-integrity@vger.kernel.org (open list:TPM DEVICE DRIVER),
	linux-kernel@vger.kernel.org (open list)
Subject: [RFC PATCH 0/4] Alternative TPM patches for Trenchboot
Date: Sat,  2 Nov 2024 17:22:17 +0200
Message-ID: <20241102152226.2593598-1-jarkko@kernel.org>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is my alternative patch set to the TPM patches included into
Trenchboot series v11. I don't mind to which tree these are
picked in the end. All the patches also have my sob's, so in that
sense things are also cleared up.

At least slmodule needs to be patched in the series given that
tpm_chip_set_locality() returns zero on success.

It is not really my problem but I'm also wondering how the
initialization order is managed. What if e.g. IMA happens to
initialize before slmodule?

Cc: Daniel P. Smith <dpsmith@apertussolutions.com>
Cc: Ross Philipson <ross.philipson@oracle.com>
Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>

Daniel P. Smith (2):
  tpm, tpm_tis: Close all localities
  tpm, tpm_tis: Address positive localities in
    tpm_tis_request_locality()

Ross Philipson (2):
  tpm, tpm_tis: allow to set locality to a different value
  tpm: sysfs: Show locality used by kernel

 drivers/char/tpm/tpm-chip.c     | 33 ++++++++++++++++++++++++++++++++-
 drivers/char/tpm/tpm-sysfs.c    | 10 ++++++++++
 drivers/char/tpm/tpm_tis_core.c | 18 ++++++++++++++++--
 include/linux/tpm.h             | 10 ++++++++++
 4 files changed, 68 insertions(+), 3 deletions(-)

-- 
2.47.0


