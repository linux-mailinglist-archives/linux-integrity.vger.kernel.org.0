Return-Path: <linux-integrity+bounces-6854-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AC98FB2758C
	for <lists+linux-integrity@lfdr.de>; Fri, 15 Aug 2025 04:20:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D30511C87616
	for <lists+linux-integrity@lfdr.de>; Fri, 15 Aug 2025 02:20:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59CD42882C2;
	Fri, 15 Aug 2025 02:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ApS/dgpr"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EB8D1922FA;
	Fri, 15 Aug 2025 02:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755224409; cv=none; b=EZG3n0C+sgYjyBcuofZ14ck7tcuxn/FsnvhtlhUAG6R4cf4RhuhqhQzjzvFablz9KBzxUtm7zLmYsbi59AeNhI9h6CHzCxPdrOGQ/jGqmLmfnWHowENDIbdOwEQ4ZdbBw1zjg7X/eAYHhVsmSgl98aZl+gxmx6oChBvGPiTE4rE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755224409; c=relaxed/simple;
	bh=4sjLsHvOkPMiyTw27pkrG82NlUySG918DWVIbSI4Xxg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UOnhHjbyMjeW1fq4R38GUg5A5OEscczeWEFhDL+/RN8CWa7D6BGK10CcbHs3EHXMqX3VljDnKQaeuKqwlaQFHxRwTzsn1zimmq1E7CUyDR5XSFbxeOVJITFQRdK3gIYwaUlhOXY8FzbhUBzJGvt1WhycenaCtdItlZbxp+v6g5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ApS/dgpr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 929D7C4CEF7;
	Fri, 15 Aug 2025 02:20:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755224408;
	bh=4sjLsHvOkPMiyTw27pkrG82NlUySG918DWVIbSI4Xxg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ApS/dgprC2p/oACYUT2pBm2kDpYRbQFR2pWYw4/kXxHKpuZvclOTL1n9kp6M13cYV
	 WCb0ew6J/wrvn+4t7p6xovPH2ooTVqvJOf1Fh33A00zL+FthjMejNWTayWYa/kUl0S
	 b0e+5U9N/RlQjQyebnaBSolUXCOaT3SVklJtZWQmqyWT1j9tFIREikP1RPzlMjn5Uy
	 4TBL/SmNwEy2vRtUot6EC2BMEeekOVlgkbsRACYugEVD/ZGmJhaBx2eg/JVGEAKOxn
	 FsnkM157B/poSMZrSZIXeb768rwbeRv5Yc4ANM/9oLjv4F4SZjYGPp0zURxQ3CYvUV
	 UTMuhRZzNHP5w==
From: Eric Biggers <ebiggers@kernel.org>
To: linux-integrity@vger.kernel.org,
	Mimi Zohar <zohar@linux.ibm.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Cc: Eric Snowberg <eric.snowberg@oracle.com>,
	linux-crypto@vger.kernel.org,
	Eric Biggers <ebiggers@kernel.org>
Subject: [PATCH 1/2] integrity: Select CRYPTO from INTEGRITY_ASYMMETRIC_KEYS
Date: Thu, 14 Aug 2025 19:17:32 -0700
Message-ID: <20250815021733.25689-2-ebiggers@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250815021733.25689-1-ebiggers@kernel.org>
References: <20250815021733.25689-1-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Select CRYPTO from INTEGRITY_ASYMMETRIC_KEYS, since
INTEGRITY_ASYMMETRIC_KEYS selects several options that depend on CRYPTO.

This unblocks the removal of the CRYPTO selection from SIGNATURE.
SIGNATURE (lib/digsig.c) itself will no longer need CRYPTO, but
INTEGRITY_ASYMMETRIC_KEYS was depending on it indirectly via the chain
SIGNATURE => INTEGRITY_SIGNATURE => INTEGRITY_ASYMMETRIC_KEYS.

Signed-off-by: Eric Biggers <ebiggers@kernel.org>
---
 security/integrity/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/security/integrity/Kconfig b/security/integrity/Kconfig
index 3c45f4f3455fb..916d4f2bfc441 100644
--- a/security/integrity/Kconfig
+++ b/security/integrity/Kconfig
@@ -34,10 +34,11 @@ config INTEGRITY_ASYMMETRIC_KEYS
 	bool "Enable asymmetric keys support"
 	depends on INTEGRITY_SIGNATURE
 	default n
 	select ASYMMETRIC_KEY_TYPE
 	select ASYMMETRIC_PUBLIC_KEY_SUBTYPE
+	select CRYPTO
 	select CRYPTO_RSA
 	select X509_CERTIFICATE_PARSER
 	help
 	  This option enables digital signature verification using
 	  asymmetric keys.
-- 
2.50.1


