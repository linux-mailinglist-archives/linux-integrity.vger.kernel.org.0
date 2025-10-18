Return-Path: <linux-integrity+bounces-7485-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 77F8CBECE24
	for <lists+linux-integrity@lfdr.de>; Sat, 18 Oct 2025 13:17:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F27CB4E5DBD
	for <lists+linux-integrity@lfdr.de>; Sat, 18 Oct 2025 11:17:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57587288525;
	Sat, 18 Oct 2025 11:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O9nxeiSU"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F9E7CA6F;
	Sat, 18 Oct 2025 11:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760786264; cv=none; b=LfdMQvvmqtkHjajLvsSL/If8U+mu5w7B5WRWyANlo8ve4uTjJOnGhyUBcPT+dGnm+efIGI5V20UhOoZ1CW2NJcyUXy7iD/3EPXJXJkU8eji87n1XEpfvHiWzGxlq0Q8LYND/AFQk+oDifgh5US2kcI0LtfdRr8vwjgeHkSinxHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760786264; c=relaxed/simple;
	bh=9FR12VMYDjxBy4vb0oRe+nky0EbxkvtfvCfka9JYYHM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=La4Jzc2WccO7Qj6gCXEs0mXVSu0BYVoK8ihDhE9JF3vRLE2xXaFyymm8I0Bh41iy8mY7oL2Oie1shdTrlLhgyFrG/M0NupE6O+0enoqgO+u44RBIrsLfUMkILLqyGryX6bVbbkz5Q/f6CBGLND3pUmB23V7VaH/S/2EB9G6qPiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O9nxeiSU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56220C4CEF8;
	Sat, 18 Oct 2025 11:17:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760786263;
	bh=9FR12VMYDjxBy4vb0oRe+nky0EbxkvtfvCfka9JYYHM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=O9nxeiSU1KwXgDNjZNP5m5Ntu8NZudhDS3t2JGPvxXoTOtCtql8Tk8CIrRvRaK7W3
	 H2vQHZci8zICvy3VAXdtYvotosxKfG9tAQ1GJZxG4uCFR7UHJOz/HF6yq66bfD2fC+
	 NhYP8C2vc5TY1d/mLJcSKEV6RqdYo+x1wTz93oHyzEmm3Y6UFD/njCFCKFBdGuVxV1
	 79hkPciKAFQGUXBosvpTH3sW1Mp/q42nwjfKjVHqeSwWryfBHnVWGYVI8Ji/DKpv+q
	 hyM0gvW7I4pL2vCPC6E2DTU/WI1YCsDKY5l9w6FBSQsu28IUP/foxX/qQoljDeFVDd
	 LI4huTIPw2gZQ==
From: Jarkko Sakkinen <jarkko@kernel.org>
To: linux-integrity@vger.kernel.org
Cc: keyring@vger.kernel.org,
	dpsmith@apertussolutions.com,
	ross.philipson@oracle.com,
	Jonathan McDowell <noodles@earth.li>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>,
	Peter Huewe <peterhuewe@gmx.de>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v6 02/10] tpm: Use -EPERM as fallback error code in tpm_ret_to_err
Date: Sat, 18 Oct 2025 14:17:17 +0300
Message-Id: <20251018111725.3116386-3-jarkko@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251018111725.3116386-1-jarkko@kernel.org>
References: <20251018111725.3116386-1-jarkko@kernel.org>
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
v6:
- No changes.
v5:
- No changes.
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
index eb0ff071bcae..0e9e043f728c 100644
--- a/include/linux/tpm.h
+++ b/include/linux/tpm.h
@@ -456,8 +456,10 @@ static inline ssize_t tpm_ret_to_err(ssize_t ret)
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


