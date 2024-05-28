Return-Path: <linux-integrity+bounces-2678-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D85898D1812
	for <lists+linux-integrity@lfdr.de>; Tue, 28 May 2024 12:05:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92FFD28B8DD
	for <lists+linux-integrity@lfdr.de>; Tue, 28 May 2024 10:05:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 803A513D513;
	Tue, 28 May 2024 10:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f4bN+Rz9"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 543D469D2F;
	Tue, 28 May 2024 10:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716890693; cv=none; b=MYrRUOP1I0cajaiFysSPdAM54SopN80ithmz6YWcL9uSeEtOYGguJqCBL3BqpguGKKzAa61sKdNYuhM6L+8BH8DGPUQOinfo5qekujx+Q774ZexopaG4POdy7CiXq8PMAAKXC0Y6DNIpVx4bmCRXBpylb35QmZxss9NKPyTBHVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716890693; c=relaxed/simple;
	bh=uiTAACoC7dhJK1x+7mh42oTHf7D3Vob975kEmytMw5M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gvmduAupteUUNTnE5SD3VP9vgdulbSisyisX5cONggRMUiiDW/WKVKYLEHzAosRe4P3J2GdryW+jGU66IXGMtkT9HZyA+41klvS/20VeW71SXrweQVujllvlzlwHP6OrykaFy/Nn6qnNt+8TKISbUzZUnH4fUYEdw5EDJhoh614=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f4bN+Rz9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9953FC3277B;
	Tue, 28 May 2024 10:04:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716890693;
	bh=uiTAACoC7dhJK1x+7mh42oTHf7D3Vob975kEmytMw5M=;
	h=From:To:Cc:Subject:Date:From;
	b=f4bN+Rz9RIH/RW0MZZx7QfzfxMn675h47eaTYJeJDpkLnzIIu/La8i5Dxom2O6BEE
	 +TlyMUfRTKOAdzYH7oy1LDNo9b3TP08GJrQbAzA1gHIJTx1miVIT6ZxeYWkSez2lHw
	 KDWGeJzYwpWRGFZ/EN0nsn0fo24advAxcn0+gGQtBya3yvCoeMp1v+lP6F5qPzYybI
	 o+Hf7zzH40Kj/5Q7hWeDhshDZb+y5+4vLoS4xlDZMVk/Nmi0Zi+vYCnEUElcbIcDgR
	 MpwARknUZYYvN2jiFe18C6biybEaFTTw9zsWbcU8KpNyS6fquEqH7rdF67jLdW6HN+
	 jrJPOwaK17/Dg==
From: Jarkko Sakkinen <jarkko@kernel.org>
To: linux-integrity@vger.kernel.org
Cc: keyrings@vger.kernel.org,
	James.Bottomley@HansenPartnership.com,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Peter Huewe <peterhuewe@gmx.de>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] tpm: Enable TCG_TPM2_HMAC by default only for X86_64
Date: Tue, 28 May 2024 13:04:48 +0300
Message-ID: <20240528100448.4364-1-jarkko@kernel.org>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Given the not fully root caused performance issues on non-x86 platforms,
enable the feature by default only for x86-64. That is the platform it
brings the most value and has gone most of the QA. Can be reconsidered
later and can be obviously opt-in enabled too on any arch.

Link: https://lore.kernel.org/linux-integrity/bf67346ef623ff3c452c4f968b7d900911e250c3.camel@gmail.com/#t
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
---
 drivers/char/tpm/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/char/tpm/Kconfig b/drivers/char/tpm/Kconfig
index e63a6a17793c..cf0be8a7939d 100644
--- a/drivers/char/tpm/Kconfig
+++ b/drivers/char/tpm/Kconfig
@@ -29,7 +29,7 @@ if TCG_TPM
 
 config TCG_TPM2_HMAC
 	bool "Use HMAC and encrypted transactions on the TPM bus"
-	default y
+	default X86_64
 	select CRYPTO_ECDH
 	select CRYPTO_LIB_AESCFB
 	select CRYPTO_LIB_SHA256
-- 
2.45.1


