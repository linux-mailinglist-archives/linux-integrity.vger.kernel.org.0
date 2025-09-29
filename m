Return-Path: <linux-integrity+bounces-7294-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C3975BAA818
	for <lists+linux-integrity@lfdr.de>; Mon, 29 Sep 2025 21:49:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 717A71C4B70
	for <lists+linux-integrity@lfdr.de>; Mon, 29 Sep 2025 19:49:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BAA52571D8;
	Mon, 29 Sep 2025 19:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GpfzvCK9"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BB552566D2;
	Mon, 29 Sep 2025 19:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759175333; cv=none; b=fPmZ4X7bv+fizlP8wxGPqX+UEHyvHOk/hfTR3a7Y4zyxiWJGsYAF6WMFY7rvIDW/4qfGzpjCBm0PUsmIKytDIYvSSJj+u83KQwOVrzVXQhJjI1+o3hI94UfMguJLyBGcbsD5nZbcCyPxTEW0Ttqy7gwyW46da7CGD+DXEZ+R5ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759175333; c=relaxed/simple;
	bh=y3OaLM3RRXRWo8FcLpPqIAHvgevACSH55EW83GjWX/0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GSCJatfgqBqHSCB//kBLXjX1iO9PaOpqomdZsn6DtqAsKS753a1UOtm1y3jmjDIKIGcCJLhSlLbdO3XXvxPfdVVZdIZ4nlKo5T4sb+fD50oGJsPMnwcUAMDabPMbQDVUjdUk0GW90g8sc5mCStv+sFQ8u2PozfcD+0Pg2KglA0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GpfzvCK9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8740C4CEF4;
	Mon, 29 Sep 2025 19:48:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759175333;
	bh=y3OaLM3RRXRWo8FcLpPqIAHvgevACSH55EW83GjWX/0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GpfzvCK99KJFLfvw4lc15UElpTkCfsGgryU8fJ0nrcPf4VTqF8tiVa2H25ky95nxg
	 AGphBGI9JomGqGHpTpWpD65XAjVH1AI3PQKa1eAjWlJOEDG1fSPmM5C5B68vT7Sq7T
	 nfrC1oRDF66+BXzeE+8qFUssGbaq+veEq4Z23IC28HJAGbVUv2H5bnmvuSIZbVPyee
	 20xj4chwaY6esktoBmo3c53iSmII6FPdYm0xosbvbyEvrTP4t9tOrN7S43iloliTY4
	 e2guiYslJkoNmhtBN3Xe+RsOqvvfCNjQ/jMPdU+7eCbNN2rXoeyvKkO2y+GJNcsw2h
	 5TVpo5YCVY17w==
From: Jarkko Sakkinen <jarkko@kernel.org>
To: linux-integrity@vger.kernel.org
Cc: dpsmith@apertussolutions.com,
	ross.philipson@oracle.com,
	Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>,
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
Subject: [PATCH v3 02/10] tpm: Use -EPERM as fallback error code in tpm_ret_to_err
Date: Mon, 29 Sep 2025 22:48:24 +0300
Message-Id: <20250929194832.2913286-3-jarkko@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250929194832.2913286-1-jarkko@kernel.org>
References: <20250929194832.2913286-1-jarkko@kernel.org>
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
---
v3:
- Removed fixes tag as it hardly categorizes as a bug fix.
v2:
- Split trusted_tpm2 change to a separate patch.
---
 include/linux/tpm.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/linux/tpm.h b/include/linux/tpm.h
index fc7df87dfb9a..51846317d662 100644
--- a/include/linux/tpm.h
+++ b/include/linux/tpm.h
@@ -453,8 +453,10 @@ static inline ssize_t tpm_ret_to_err(ssize_t ret)
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


