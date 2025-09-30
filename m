Return-Path: <linux-integrity+bounces-7343-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B29FBAEBFC
	for <lists+linux-integrity@lfdr.de>; Wed, 01 Oct 2025 01:20:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19A1D3AF3B4
	for <lists+linux-integrity@lfdr.de>; Tue, 30 Sep 2025 23:20:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED6AA2D0C78;
	Tue, 30 Sep 2025 23:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aconPwAQ"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD3AD1A2C0B;
	Tue, 30 Sep 2025 23:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759274415; cv=none; b=jc1d17nexWODtqDB6hTWAoDlp9ruuYwJsYjIGdWE/0KKz40RwqrKBrJlT55NVESZKcrhib2rguchsLjYS975qaYGck+777EZaiBYN0V/HCJ13juiUl0cW8EQt9KjmUGl3fF0F0P/q5Kmj6Q1wVo/37X0G3uZw6pooOSJQs6vxYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759274415; c=relaxed/simple;
	bh=bckcfrg9BpURZ9y6e+g34AqIEljGGhxdspkyF/Yt9ac=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MIuNHSdl0CK2COVD/oqoni/UYOtrvXoMjah48G1kHexhysobfjqb7wGEBm3Ojy4v/++Umf0gVdIY2uHpMX44S5D6uBauuncMFBD5VDtGcMdxNhkoxkSiXQIXuPqvITvQl+sAeP4SvTMqM/8Cxo0JvQOCAgW8NbhTx+eEaKaN0hY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aconPwAQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C07B4C113CF;
	Tue, 30 Sep 2025 23:20:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759274414;
	bh=bckcfrg9BpURZ9y6e+g34AqIEljGGhxdspkyF/Yt9ac=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aconPwAQsKkj0Y3IxtRmFwSzgO3pvGY5qpH5Ge26Hyy5viYw1746sO4+o5WWXLLnx
	 q0KKD+FJR4o92/vmdGddHOm966gsa7iDuU/PcSubl+PVBcQvgPUm6z8SmCLH0g3n5m
	 3oVw24TYWqHk63F07BKdIB86mXp4RsK5+NfrvQgvdKMfrzK2y9YqbIb1L+Sg4K5URU
	 ncVVkUnSKxiakDPPgdVjQQHSk9yqlhVS+YxgEFfA++js8sv/sE6TaHpMBTG44e/rft
	 Kw3eyb77+n4Ep8aXaCnKP9+5A9z3x8Y32F1Vs4G3IgiEJRqKSPyPZSymvZ/gXL+2pK
	 ZN7V/WKBEwbgg==
From: Jarkko Sakkinen <jarkko@kernel.org>
To: linux-integrity@vger.kernel.org
Cc: dpsmith@apertussolutions.com,
	ross.philipson@oracle.com,
	Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Peter Huewe <peterhuewe@gmx.de>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	David Howells <dhowells@redhat.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	linux-kernel@vger.kernel.org (open list),
	keyrings@vger.kernel.org (open list:KEYS/KEYRINGS),
	linux-security-module@vger.kernel.org (open list:SECURITY SUBSYSTEM)
Subject: [PATCH v5 2/9] tpm: Use -EPERM as fallback error code in tpm_ret_to_err
Date: Wed,  1 Oct 2025 02:19:51 +0300
Message-Id: <20250930231958.1437783-3-jarkko@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250930231958.1437783-1-jarkko@kernel.org>
References: <20250930231958.1437783-1-jarkko@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>

Using -EFAULT as the tpm_ret_to_err() fallback error code causes makes it
incompatible on how trusted keys transmute TPM return codes.

Change the fallback as -EPERM in order to gain compatibility with trusted
keys. In addition, map TPM_RC_HASH to -EINVAL in order to be compatible
with tpm2_seal_trusted() return values.

Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
---
v4:
- No changes.
v3:
- Removed fixes tag as it hardly categorizes as a bug fix.
v2:
- Split trusted_tpm2 change to a separate patch.
---
 include/linux/tpm.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/linux/tpm.h b/include/linux/tpm.h
index f998dca4ea07..dff558140c69 100644
--- a/include/linux/tpm.h
+++ b/include/linux/tpm.h
@@ -457,8 +457,10 @@ static inline ssize_t tpm_ret_to_err(ssize_t ret)
 		return 0;
 	case TPM2_RC_SESSION_MEMORY:
 		return -ENOMEM;
+	case TPM2_RC_HASH:
+		return -EINVAL;
 	default:
-		return -EFAULT;
+		return -EPERM;
 	}
 }
 
-- 
2.39.5


