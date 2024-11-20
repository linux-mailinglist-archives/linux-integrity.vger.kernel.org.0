Return-Path: <linux-integrity+bounces-4174-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E6CE59D3D03
	for <lists+linux-integrity@lfdr.de>; Wed, 20 Nov 2024 15:06:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A16471F24146
	for <lists+linux-integrity@lfdr.de>; Wed, 20 Nov 2024 14:06:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F13B1A9B53;
	Wed, 20 Nov 2024 14:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NBa8yCes"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A77719E804;
	Wed, 20 Nov 2024 14:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732111560; cv=none; b=bClkG1U2UMGH15vkPwWkzDYBOMRy7lDTGonKqpMoPtuaRZte28Zdyx0rAmmzrtk9BQ7MIh1rITec2rkMcpvYXLEBuVkT2O1i3hobwg09lmYPr5Ug8CzCLJAwTxQZSm3oxE7QOMt7ta9niEx6gmDZzV4YpzR8d+WYjGfNZoMZnSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732111560; c=relaxed/simple;
	bh=HYcC5iQohpS0422w+sO97UhmlkFG/7wWxasXzHZTQsc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lBPSa6MOMKMhHcT+J4sogW6stjlUvM/XYOPE5f/iWswazdIFJEXcQg+G3Uiz6RLLB8I0UBZLbuWFexmOYBhWC6l0sg40893Umm0iDSteGa8nl+/CrlT+jd74LGdhzvLgvY++B4NFT0kz0H508ttbTpp2PiksCs5paP9PsZEtjrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NBa8yCes; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52923C4CECD;
	Wed, 20 Nov 2024 14:05:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732111559;
	bh=HYcC5iQohpS0422w+sO97UhmlkFG/7wWxasXzHZTQsc=;
	h=From:To:Cc:Subject:Date:From;
	b=NBa8yCeschXE6Q/lUePeYIj6VUmnebQDk43vC/1AXqLsaK5iKl8FwPb1HmuHa44zM
	 3YDEZDFSQU4LpyQG6QRXFMGP3DbKOSzWeUMR4lToClAfE1i5hrLjJ0fXZSdZSBH235
	 lgHMBWuAKagRgPTMTIQ+/rk3wl4Jx1di4zabNlh7u8wfPUd5aq9qmsI5hYFMfr45Lq
	 gIjKybSBReVjjZJRw2tAx7T/uvylhD37rSBzs+jQrjH3XV79xeQsPSAVF9Q4AxFOe8
	 me6v3uHV/XRiHOARrfLYovjszFpHjN7ZIe5iTN83CSimo7OFhyGFehbeTL6/NcaoZ/
	 H5r/nDGC+MIhw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	Sasha Levin <sashal@kernel.org>,
	dmitry.kasatkin@gmail.com,
	paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com,
	linux-integrity@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: [PATCH AUTOSEL 6.11 01/10] integrity: Use static_assert() to check struct sizes
Date: Wed, 20 Nov 2024 09:05:26 -0500
Message-ID: <20241120140556.1768511-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11.9
Content-Transfer-Encoding: 8bit

From: "Gustavo A. R. Silva" <gustavoars@kernel.org>

[ Upstream commit 08ae3e5f5fc8edb9bd0c7ef9696ff29ef18b26ef ]

Commit 38aa3f5ac6d2 ("integrity: Avoid -Wflex-array-member-not-at-end
warnings") introduced tagged `struct evm_ima_xattr_data_hdr` and
`struct ima_digest_data_hdr`. We want to ensure that when new members
need to be added to the flexible structures, they are always included
within these tagged structs.

So, we use `static_assert()` to ensure that the memory layout for
both the flexible structure and the tagged struct is the same after
any changes.

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
Tested-by: Roberto Sassu <roberto.sassu@huawei.com>
Reviewed-by: Roberto Sassu <roberto.sassu@huawei.com>
Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 security/integrity/integrity.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/security/integrity/integrity.h b/security/integrity/integrity.h
index 660f76cb69d37..c2c2da6911233 100644
--- a/security/integrity/integrity.h
+++ b/security/integrity/integrity.h
@@ -37,6 +37,8 @@ struct evm_ima_xattr_data {
 	);
 	u8 data[];
 } __packed;
+static_assert(offsetof(struct evm_ima_xattr_data, data) == sizeof(struct evm_ima_xattr_data_hdr),
+	      "struct member likely outside of __struct_group()");
 
 /* Only used in the EVM HMAC code. */
 struct evm_xattr {
@@ -65,6 +67,8 @@ struct ima_digest_data {
 	);
 	u8 digest[];
 } __packed;
+static_assert(offsetof(struct ima_digest_data, digest) == sizeof(struct ima_digest_data_hdr),
+	      "struct member likely outside of __struct_group()");
 
 /*
  * Instead of wrapping the ima_digest_data struct inside a local structure
-- 
2.43.0


