Return-Path: <linux-integrity+bounces-7284-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C5AB5BA7E6F
	for <lists+linux-integrity@lfdr.de>; Mon, 29 Sep 2025 06:00:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FC5E18933BF
	for <lists+linux-integrity@lfdr.de>; Mon, 29 Sep 2025 04:00:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63EB12206AC;
	Mon, 29 Sep 2025 04:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aXJs7gRa"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FF8321578F;
	Mon, 29 Sep 2025 03:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759118400; cv=none; b=BtqPNY0HUQcP2z8w3Rb+eDweCJx5PGMxmEG4vC1YnqRsuFBlneaRPkFt7NUIvWytm0908EmRaQntFnFfujgE0HYhgrsg8n2WuQDdh+xN9vRsvzBITSOIbs9V9UYiFhK8FW6vQL3i+mtjsDvQu7a2cBSYJ2iflS7hONMv41mS2gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759118400; c=relaxed/simple;
	bh=32+Zkv7IC1rnLrmW1JNVh4wEzCsKly1ozoVFx6a8iEA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nQRSpk/J3ZkiPCkZwtCwpw9bpb7Q3D2IiMfSyqA9Oj561aWS08qmcWhALlDJo8Sm5AVZ5Si1tw0hSMvk1sgXOfr4Ht/r28a3KgZb5tyS+AvmbP2ehFXjijl81T2PoATbiOt+zUT0zykUnYtcbi1ENUASa7gCPBmxnC9DvnF3i4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aXJs7gRa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D9CFC4CEF4;
	Mon, 29 Sep 2025 03:59:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759118399;
	bh=32+Zkv7IC1rnLrmW1JNVh4wEzCsKly1ozoVFx6a8iEA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aXJs7gRaWXupf261neT8cATN+gcXW6uGuXdpWgUrq17uNY6Yl41Q+Wm+30rPozOTr
	 dT0blkTLj4uP7i59ZSJhY4MXoutYelo9UtDPKy3F+S+hH+JDadE8aZjJmH5Y75IEX3
	 VoPpdSKm/qwOFqJIb2mMBJILqRvLCAH+SocpgXuLo6orzncpUBDCkEdBzGA+DFfQmP
	 E4Teg6/jH8CSiXjfPvW0yqyzdo6IjTsvXqYw26uEgfqBAMao6+tTeajVu21aUx2/7r
	 IkuD2KnAvUmM47NvcoR2ossBUFG8HFeRGcIG7Lu49oQLZ4ZIolyGk/lW6cndPD+58Y
	 sjT4ayhXtBIqw==
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
	Stefano Garzarella <sgarzare@redhat.com>,
	linux-kernel@vger.kernel.org (open list),
	keyrings@vger.kernel.org (open list:KEYS/KEYRINGS),
	linux-security-module@vger.kernel.org (open list:SECURITY SUBSYSTEM)
Subject: [PATCH v2 2/9] tpm: Use -EPERM as fallback error code in tpm_ret_to_err
Date: Mon, 29 Sep 2025 06:59:31 +0300
Message-Id: <20250929035938.1773341-3-jarkko@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250929035938.1773341-1-jarkko@kernel.org>
References: <20250929035938.1773341-1-jarkko@kernel.org>
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

Fixes: 539fbab37881 ("tpm: Mask TPM RC in tpm2_start_auth_session()")
Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>
---
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


