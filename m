Return-Path: <linux-integrity+bounces-9491-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wN6CBsoj/mmunAAAu9opvQ
	(envelope-from <linux-integrity+bounces-9491-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Fri, 08 May 2026 19:56:26 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F4074FA482
	for <lists+linux-integrity@lfdr.de>; Fri, 08 May 2026 19:56:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0883D30692BC
	for <lists+linux-integrity@lfdr.de>; Fri,  8 May 2026 17:55:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55073423163;
	Fri,  8 May 2026 17:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ndN56qyU"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76C3B421F0B;
	Fri,  8 May 2026 17:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778262895; cv=none; b=B3yV4ddwwZVviChvE4KHmWKi3Tx6plAqh+P7DQU1hIwNmbhTtqZvXJHF5n45SMbASst+MRgCj2rfPnSISzjw//Ujgk1H8xDoMRwvzcFCyS9aMdQqaiAmTZBWAQUL7NljGghMv/jzTpImjUGKih5OaMGtsNfUVy9wBDWdg0TlXvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778262895; c=relaxed/simple;
	bh=/aEr/2bl24rcHpe9c/rW9BGCQVs8Vg6IaLcMsIwTuCQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PErSkRdHM1P8UQqP7JEkAVwL3mwX+xzfdi4IXzyVT+8ZpMefvwZAmEHBfFUuLL98I8t3j1f1JGdfTTn5WsvRv5kSdGn9M6wBrbKEYIXaMUmsR86QLTHDeCZj8KfFvKN00ifcKBOCQSP/BwPslGTwq9gkkTLl42aGLa3TezaequU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ndN56qyU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4A06C2BCF5;
	Fri,  8 May 2026 17:54:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778262895;
	bh=/aEr/2bl24rcHpe9c/rW9BGCQVs8Vg6IaLcMsIwTuCQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ndN56qyUqTs+ESpRsl3NSQPAcyFXCT94hgHpwL7EIhSbzah5StjeDU8Ll58UtHaBP
	 ma3w2CiGVaFY0Q0zKvvBJCDgbzTAzR8pHAHQWMMGkYqIGUUnGRE7nYiTN13E+E8BaP
	 u4hRvuTDUSHLbemPqVGlGqYYOXCZBHCVDkhsuy5VCoBk1L++sbHclUXnuW8KC3zSfU
	 QT8rSe/GCfm7+M6yX+QckmUCENMJCQffoPQi6xJdxO16CaKfKJKXpdQsOLWGbuC50y
	 EuUxL3jKhuEzg4Mb0O5ZXJqUpzyYR4zRbO4cZF2CaAVKCYOY7AaGIjho7zehSkoHR7
	 IkRIV3aVGllSg==
From: Sudeep Holla <sudeep.holla@kernel.org>
Date: Fri, 08 May 2026 18:54:18 +0100
Subject: [PATCH 4/4] firmware: arm_ffa: Defer probe until pKVM is
 initialized
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260508-b4-ffa_plat_dev-v1-4-c5a30f8cf7b8@kernel.org>
References: <20260508-b4-ffa_plat_dev-v1-0-c5a30f8cf7b8@kernel.org>
In-Reply-To: <20260508-b4-ffa_plat_dev-v1-0-c5a30f8cf7b8@kernel.org>
To: linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-integrity@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 kvmarm@lists.linux.dev
Cc: Sudeep Holla <sudeep.holla@kernel.org>, 
 Yeoreum Yun <yeoreum.yun@arm.com>
X-Mailer: b4 0.15.2
X-Rspamd-Queue-Id: 7F4074FA482
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9491-lists,linux-integrity=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sudeep.holla@kernel.org,linux-integrity@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-integrity];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[arm.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

When protected KVM is enabled, the kernel includes a pKVM FF-A proxy
that sits in front of the normal FF-A driver. The proxy has to perform
its own FF-A version negotiation and setup first, so that it can mediate
subsequent FF-A traffic correctly.

Defer FF-A core probing until pKVM has completed initialization. This
keeps the normal driver from negotiating the FF-A version or performing
other transport setup before the pKVM proxy is ready, and lets the
driver model retry probing once the protected KVM state required by the
FF-A transport is available.

Suggested-by: Yeoreum Yun <yeoreum.yun@arm.com>
Signed-off-by: Sudeep Holla <sudeep.holla@kernel.org>
---
 drivers/firmware/arm_ffa/driver.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/firmware/arm_ffa/driver.c b/drivers/firmware/arm_ffa/driver.c
index e9d7dc71c06d..1fba064c2aba 100644
--- a/drivers/firmware/arm_ffa/driver.c
+++ b/drivers/firmware/arm_ffa/driver.c
@@ -43,6 +43,8 @@
 #include <linux/uuid.h>
 #include <linux/xarray.h>
 
+#include <asm/virt.h>
+
 #include "common.h"
 
 #define FFA_DRIVER_VERSION	FFA_VERSION_1_2
@@ -2039,6 +2041,10 @@ static int ffa_probe(struct platform_device *pdev)
 	u32 buf_sz;
 	size_t rxtx_bufsz = SZ_4K;
 
+	if (IS_BUILTIN(CONFIG_ARM_FFA_TRANSPORT) &&
+	    is_protected_kvm_enabled() && !is_pkvm_initialized())
+		return -EPROBE_DEFER;
+
 	ret = ffa_transport_init(&invoke_ffa_fn);
 	if (ret)
 		return ret;

-- 
2.43.0


