Return-Path: <linux-integrity+bounces-7727-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AAFDC90AD5
	for <lists+linux-integrity@lfdr.de>; Fri, 28 Nov 2025 03:55:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B6E8C4E8A83
	for <lists+linux-integrity@lfdr.de>; Fri, 28 Nov 2025 02:54:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF9C0285CA4;
	Fri, 28 Nov 2025 02:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pcidIvAC"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E9E928312D;
	Fri, 28 Nov 2025 02:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764298477; cv=none; b=ned0urMcUtLaTOdaRjoYFz7E8KWkBH8jEHthyszDMAGN4PlQJDSpxgc7HsDkywOIUDgM2N6+0eCavGvM3CspTtXxO+hVAbB6P4QRcPgNNhdxfZlCNQxdL9uajrp2U/SkyHFgUQ8obEzxABMZCXj7qHOomLAxwDkbuyVOUfeyRpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764298477; c=relaxed/simple;
	bh=uOIEuSunE38kel4/llCCCylnNxKaEVaG6d8iug+BmyQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=frd5xe62VrD1QIQU1wDTJwAeASm2fZgMg1nnZv+PWIV8v23ze/DzxKNVTqm/qDRymFe3zm4C9dvcBSS+OCuO19bUjjnwWDNsHMiWd7ATD5bTSwwlAZ78D5lUCILxo5r9Zkh8GNXXmkB5b6ZRtjCax6eeSk+pj0VrZXOiJ9Hg6XQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pcidIvAC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4418C4CEF8;
	Fri, 28 Nov 2025 02:54:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764298477;
	bh=uOIEuSunE38kel4/llCCCylnNxKaEVaG6d8iug+BmyQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pcidIvACMyCLvXGKZsMeq2aYgBUFgHgtupABQzDEhTb86GKaD+naAPl/Mo4QT66z4
	 XVBVPAfvJiIGOWLhHf+WZYQB1364qVXRfFElOQ7G9TAWnX2FWQx9laG4qms3f9VO/x
	 nNGJXbzNfqeTiGqfJoIcnE+p2ieOvUuCv2Gr/1/fGgiId9KHLynnOG1E0Y76rQawXm
	 KKLCfYnFI66Lj7xAa5bgzMB7vydcqCVizVGYWWTqZN+xba1/ZreP0S2R9Z4qIA25dM
	 TPG+7jRcSTIFCiBBjMe5ny3nAUfeWte5opUpSxcuzFDqX7/f9B+sdrTph2JMUiGnuw
	 7mh8lKGivhNjg==
From: Jarkko Sakkinen <jarkko@kernel.org>
To: linux-integrity@vger.kernel.org
Cc: ross.philipson@oracle.com,
	Jonathan McDowell <noodles@earth.li>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	stable@vger.kernel.org,
	James Bottomley <James.Bottomley@HansenPartnership.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	David Howells <dhowells@redhat.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v9 4/8] KEYS: trusted: Fix a memory leak in tpm2_load_cmd
Date: Fri, 28 Nov 2025 04:53:56 +0200
Message-ID: <20251128025402.4147024-5-jarkko@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251128025402.4147024-1-jarkko@kernel.org>
References: <20251128025402.4147024-1-jarkko@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

'tpm2_load_cmd' allocates a tempoary blob indirectly via 'tpm2_key_decode'
but it is not freed in the failure paths. Address this by wrapping the blob
into with a cleanup helper.

Cc: stable@vger.kernel.org # v5.13+
Fixes: f2219745250f ("security: keys: trusted: use ASN.1 TPM2 key format for the blobs")
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
---
v9:
- Fixed up the commit message. It was not up to date and referred to wrong
  function.
- Simplified the patch considereably. It was not optimally small.
v8:
- No changes.
v7:
- Fix compiler warning.
v6:
- A new patch in this version.
---
 security/keys/trusted-keys/trusted_tpm2.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/security/keys/trusted-keys/trusted_tpm2.c b/security/keys/trusted-keys/trusted_tpm2.c
index 4467e880ebd5..225b8c9932bf 100644
--- a/security/keys/trusted-keys/trusted_tpm2.c
+++ b/security/keys/trusted-keys/trusted_tpm2.c
@@ -366,6 +366,7 @@ static int tpm2_load_cmd(struct tpm_chip *chip,
 			 struct trusted_key_options *options,
 			 u32 *blob_handle)
 {
+	u8 *blob_ref __free(kfree) = NULL;
 	struct tpm_buf buf;
 	unsigned int private_len;
 	unsigned int public_len;
@@ -379,6 +380,9 @@ static int tpm2_load_cmd(struct tpm_chip *chip,
 		/* old form */
 		blob = payload->blob;
 		payload->old_format = 1;
+	} else {
+		/* Bind for cleanup: */
+		blob_ref = blob;
 	}
 
 	/* new format carries keyhandle but old format doesn't */
@@ -443,8 +447,6 @@ static int tpm2_load_cmd(struct tpm_chip *chip,
 			(__be32 *) &buf.data[TPM_HEADER_SIZE]);
 
 out:
-	if (blob != payload->blob)
-		kfree(blob);
 	tpm_buf_destroy(&buf);
 
 	return tpm_ret_to_err(rc);
-- 
2.52.0


