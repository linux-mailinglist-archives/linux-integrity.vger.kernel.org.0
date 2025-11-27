Return-Path: <linux-integrity+bounces-7691-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D2A40C8EA28
	for <lists+linux-integrity@lfdr.de>; Thu, 27 Nov 2025 14:56:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B79594E9E26
	for <lists+linux-integrity@lfdr.de>; Thu, 27 Nov 2025 13:55:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C9B2330B01;
	Thu, 27 Nov 2025 13:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ua0pOkP3"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54DBF33033C;
	Thu, 27 Nov 2025 13:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764251703; cv=none; b=KKJHTOKcvSScA7nnGcQu0ZtLfHmqmFwDlOs67jvrz89jQvwkIcsNHmcB9wGF1VmKzYPKX+9jXFwYjpMASKxf0qrnUMTSnDkKwbHuBX3fF/pJOuBWXE9KZ2PGvJL5ozdGvK66wKiw8rn4nkANTW18oNKFYEXAnLYunzVMOPnkZps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764251703; c=relaxed/simple;
	bh=tEyJ6dw59J8ou/E0Bw9PD5e7nxZq1Pz360DudnLHLtM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uGPL78P9wBy65ic+YRHPwns1KdOnx44LH4D1o5grovUSY410BIPeO+MN2uOrek9VmJMj0BrGkP5oCwB4JhTlB3CV3ww95+nfKAOwXg7A+slWLwCfCQ79o1AVny4prXdh+tOSzPxsHRrfSIM31XZY3D+kjeb4zEH+gtiX4EBC53Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ua0pOkP3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C859C4CEF8;
	Thu, 27 Nov 2025 13:55:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764251702;
	bh=tEyJ6dw59J8ou/E0Bw9PD5e7nxZq1Pz360DudnLHLtM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ua0pOkP3SVZO+ECQEPJt8EjIpZvNCckuLYme3ZhgKrSv/nUnp237uKBJ5qtivuuy+
	 oeBk7uUQ+F9i3Hybn6T/gnk8wElOy37fB88E3z7/jHX2dpkTlQw389yL4a8v7MMbjC
	 iwqpjT7aUshQD5PpOygB+e4/c9YBQEJ7MO4ilVNgQOqDyT5UmJEDq8kCXWFbmPjL72
	 dZuMQ0Ay0uE134Js5JKcfpIGWOjzCl8dHW0w9oHG6RhSFAUkBNHbYo0d9ANWpbowyQ
	 p9xF/qMDSmunYnHRCswQqaCxmQ29gP++YF6YMa5X4wyEFZwbGN1mk/QXmGMs/lpSG4
	 jAawneOeReqnQ==
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
Subject: [PATCH v7 02/11] tpm: Use -EPERM as fallback error code in tpm_ret_to_err
Date: Thu, 27 Nov 2025 15:54:34 +0200
Message-ID: <20251127135445.2141241-3-jarkko@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251127135445.2141241-1-jarkko@kernel.org>
References: <20251127135445.2141241-1-jarkko@kernel.org>
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


