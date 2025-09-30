Return-Path: <linux-integrity+bounces-7332-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 111F2BAEAC9
	for <lists+linux-integrity@lfdr.de>; Wed, 01 Oct 2025 00:18:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E24E4A57F2
	for <lists+linux-integrity@lfdr.de>; Tue, 30 Sep 2025 22:17:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5658D2C3261;
	Tue, 30 Sep 2025 22:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C/NnzVpu"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 276042C3254;
	Tue, 30 Sep 2025 22:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759270645; cv=none; b=ervBlKauCih8hFinXf9DW9TEMGRIrhhXDJJFinxD9owH70Gyki02mdrNf/XqtE+NPDj8YjoydKmCmj/vZ6zuIwez5f2aJP9snF7jv+baQNfBjFdFE1yw3PhRpt2eLRcrMlrwTBZcXCdSlixjCI2PSHr5/EwRGMSBugOwjJw1g+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759270645; c=relaxed/simple;
	bh=bckcfrg9BpURZ9y6e+g34AqIEljGGhxdspkyF/Yt9ac=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ScaPmW7wcOG+5CUTEBZBdcsSinxaKYw1UnrP3lBqdjwgUinlRg4QV4RSyK5tQ4GwBM8DCgLM2smYqG4mEL/rAcjf+ettfdN/nyB0wDMuCztsIzkPJ3gtR+3HLOWQCDz/YC99F6likq+NUy8MZEVGtnTJp7Gk+tDX6fnjJkJr8L8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C/NnzVpu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EFE0C4CEF0;
	Tue, 30 Sep 2025 22:17:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759270644;
	bh=bckcfrg9BpURZ9y6e+g34AqIEljGGhxdspkyF/Yt9ac=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=C/NnzVpur5wACgGYzeEvbOvb5dUZt1LpEJfglnoVV/HFbsEBrfVTC7tggzrM7qgLh
	 Q7wIP/qWNKOzMJNLr9wJcok/uiFzkEMeMxxSoUJaifG2inSiONB2xluQUFPer4MmRf
	 dDTab1rvxUJCvfNgafdn+BAwPXY62xreaiDe6kyMlsfuzDUA6UJym2Ymq9+0thTLpS
	 CdTBLdj0C7QlCGUNqfrjXrrQesk/HwLgAcQOrJIGLr06xQoY84NAWmlcdSaaU3srSN
	 9oNHtKN1U1GiMftLE1P3I4EXJLQybw8p38h8+RYoM+9w7WhlPmZwKxGaJOnCdnuT13
	 3UJ8NW7l7Q+gA==
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
Subject: [PATCH v4 2/9] tpm: Use -EPERM as fallback error code in tpm_ret_to_err
Date: Wed,  1 Oct 2025 01:17:00 +0300
Message-Id: <20250930221707.1373912-3-jarkko@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250930221707.1373912-1-jarkko@kernel.org>
References: <20250930221707.1373912-1-jarkko@kernel.org>
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


