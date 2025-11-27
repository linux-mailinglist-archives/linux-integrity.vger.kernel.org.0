Return-Path: <linux-integrity+bounces-7710-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C99C4C90342
	for <lists+linux-integrity@lfdr.de>; Thu, 27 Nov 2025 22:42:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B6A053514F2
	for <lists+linux-integrity@lfdr.de>; Thu, 27 Nov 2025 21:42:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2734F31B83B;
	Thu, 27 Nov 2025 21:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jK9TOBH7"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F289F30AAB3;
	Thu, 27 Nov 2025 21:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764279717; cv=none; b=jYgpQM34kUSMtYi9mpD/8gBTEQgUb779F/T54ohqNcSPwZOD3PMD/uYOV8z2pxN3ouftEgOi6GCWlYdQktdd3HXTtPDTeTKmofVeSc59ZEeG7xTKcuz56Hd+cH0ABsp0tvt1CX+6ltB8fHMgn/L5f00uLvbiHmYxwrrTP32iyqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764279717; c=relaxed/simple;
	bh=tEyJ6dw59J8ou/E0Bw9PD5e7nxZq1Pz360DudnLHLtM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=onGpdDkDJaiOaIlMSKF1sraMt2eThn87xndoqkbYAjmEtbI7SyWqcaCZRiyMNTC+Y/N2Df+6blzSSgOssdmAP5InlOvj+qfyxdcH+Nc9Vya8t2225CEVTZa36zv7EmgtKWpg9hf787RE7ZeY4T5dKOpqRJHTpatX3RGqjJu4lpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jK9TOBH7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45131C4CEF8;
	Thu, 27 Nov 2025 21:41:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764279716;
	bh=tEyJ6dw59J8ou/E0Bw9PD5e7nxZq1Pz360DudnLHLtM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jK9TOBH7RDH8jAIklJOZvhqkkg/D2XA7qct3CUoRM+YEeTf7DorXsxt+tQy8OslTk
	 4VlEL6HNpxEQEi6EiPx5bbsmNe+pKPmEF7FK8horvYBECrzFDIHlxPJMqXXLhbZv1F
	 vaWnQv9aZf6JE5wGjmdt3+9UB9JwpMbxYEIZGJolMXBZ0oy+kdmInnGyXKaUoIZ21y
	 nttsoKvsVZqYge6BQ1hLQfQByvhwfq/vB002re3uY1ag4L3GSS0FAIIOO5fMNHjZPW
	 zOdkWDSlLk4wMSPHRry3dxatpyhGESHY5Z/dLfEu5nOdU+5qNp142wYkwqfX1Dzif9
	 L/qsB7eLRZlRA==
From: Jarkko Sakkinen <jarkko@kernel.org>
To: linux-integrity@vger.kernel.org
Cc: ross.philipson@oracle.com,
	Jonathan McDowell <noodles@earth.li>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>,
	Peter Huewe <peterhuewe@gmx.de>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v8 02/11] tpm: Use -EPERM as fallback error code in tpm_ret_to_err
Date: Thu, 27 Nov 2025 23:41:27 +0200
Message-ID: <20251127214138.3760029-3-jarkko@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251127214138.3760029-1-jarkko@kernel.org>
References: <20251127214138.3760029-1-jarkko@kernel.org>
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
2.52.0


