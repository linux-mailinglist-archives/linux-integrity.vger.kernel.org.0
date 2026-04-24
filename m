Return-Path: <linux-integrity+bounces-9317-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MJefKsdW62nkKwAAu9opvQ
	(envelope-from <linux-integrity+bounces-9317-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Fri, 24 Apr 2026 13:40:55 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CD5745DE8E
	for <lists+linux-integrity@lfdr.de>; Fri, 24 Apr 2026 13:40:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6020530157DC
	for <lists+linux-integrity@lfdr.de>; Fri, 24 Apr 2026 11:39:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C16413BE624;
	Fri, 24 Apr 2026 11:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dig6Aj/2"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DE4F3ACA4B
	for <linux-integrity@vger.kernel.org>; Fri, 24 Apr 2026 11:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777030795; cv=none; b=SdH1Z88OC/kCCUHODLRir6VHmIEU+zxJRZBTS2DQKx9b3PMIuffAGGZouhhQwg1YIKq8G4qrqQljDjlq0KgiDm5KdBK7DPB/U+CaSRpfOD66efbk5yTlCSkFexmwoorc+l4K3gtYbAn8bi7kDmZzOYCWR2KsuY/F2v99ytIo3g8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777030795; c=relaxed/simple;
	bh=Mn8baejszrg8TBBwgRqdVIVk2uHyhbJN3nmGuxlJh1I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=RtiTPQ5jCjXCCq5h9x18dRMmLnFs9XHDKIQsdVRHGHBsbyuAjrCbTmxkH9giH/bHEBpwAPpzN1+HSNnHtU0PXyIOJx2b14ffhiPBzDGC/LI/ZeT4D/7spLptBo3pi11kHKRpVz0+ni+JfSpM/L3O6lIDDyLLZ6XJTVGHQQeAp4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dig6Aj/2; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2b4583f0a1aso49111915ad.3
        for <linux-integrity@vger.kernel.org>; Fri, 24 Apr 2026 04:39:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777030794; x=1777635594; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9ycQfsCwJU6aj5y3c9itCmneMe/paG5gWp/wWLRcNhI=;
        b=dig6Aj/2VdAZ8VmJDRgXYMIVoFNuliTvOX9hXkRdpsI9uEiRJC2dQC4DRUPX+17JbJ
         IYH+vyVtekzdjpCxTkTAt2F2rod4ZvIvKHo0QPjr7gceJY/x0CUeZTifWbXbMEvvpO43
         mP+3mu9Rh/7JoptvosYcpL+YAsHROPob8xIDlaRfWC9XPV+oEdlR0GqEvvlBv9e1wxra
         zHThyI/MmsGdFowxu5wWEF9iH5A6RuiF9yxN9x90pP2fMl8UiUBW/C5/oqRoqlaP0Z8a
         IvcQYFGxtiUsKdjZ6Vjaj6uCIh6A3/mxMKY+WSWbiNF7xmm4Ijawe0egwEIF43mfNesh
         4tqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777030794; x=1777635594;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9ycQfsCwJU6aj5y3c9itCmneMe/paG5gWp/wWLRcNhI=;
        b=OkWhM6gVMxaSOR1K7R03aFOW9GKc7EvKgi1BAZ8Q9G/8p72QE92q7E7bLuxUE2WChx
         IrYsgDle0mnvkQ7jXtHlvuBmrv/arggCY8QWbhramnS1aNITq9WdYVp8kBngHIptDaR7
         rAwBFAxrhlj3eI93ymiAoCjt6ojD4h1WREwbM5efhJIvQ+eNdIIJGjmvxg+7Xxzwchb7
         uuMPyXqACKjiWmhWH10IdxIyqUlR1MaWOkkxJLnNQKkmcQgkylPKPFPcUSZwAcVtBd1m
         fXzFjE1YKZYzN5DeIIjiyuBi1VGVj5V+6ViVNj+K5L2ttxNllmGRUfF4mKgSxEapoIJ9
         0Upw==
X-Gm-Message-State: AOJu0YzyDLU+2rDjWg3pUCQyXg+UkXYRhdWlFUl7Dmm+vphLpVX7x3P5
	7whFpMeonH5rMrlWocD6kXYL4p4KkM9hrGonpDBg4gqvT/j3j30tj3nC
X-Gm-Gg: AeBDievT6eTu4JPB7NFgpaa6g/f6RSGaQtfy5OgxP0l6tezuQI/u5aq1rl8zpJcpY8L
	WiQ9qYPUcTox4wE6D3p3iKuy2piVxqet191pM1Rj3jvIrCBsmr27EzOma4KvQclTQTbpVN98Rm8
	8zMj5w/TouJPDVIjFyZ7MsVF0lA5RiEci6DOJ6r1L7iIyRy57Hui3ZaDRn3G2NPtKPdmrBorrpr
	islM/UAEK7i4H/hitDWgokGc8vCRgpUBewQRpb4c7q+zFa4zY2thzOpZlhauhBi/+cgc07dQnpx
	B25tT8Oloe9PYmHJT0RpfUCFwqYK/viov4k/rN3VbLBtm2Cv9bITJ2oN+xHYNBQO32B+kfGwamd
	AmqOxi9O+zBKRd+6/c1ezwvefXoPRX28tWI1GVDHsRLLTC37el3LZW91YavDJKGP6IoFp0+Vb+/
	x1pMghwKpo1O4wKjX9aCjNzUBIl7g6IRoRZU2nOe3e3I7ISVZjaDwjdg8=
X-Received: by 2002:a17:903:1a88:b0:2b4:5b9e:4edd with SMTP id d9443c01a7336-2b5f9e9a500mr337105715ad.9.1777030793817;
        Fri, 24 Apr 2026 04:39:53 -0700 (PDT)
Received: from kam-mbp.juniper.net ([136.226.244.181])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b5faa3073asm213824545ad.27.2026.04.24.04.39.51
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 24 Apr 2026 04:39:53 -0700 (PDT)
From: Kamlesh Kumar <kamlesh0hrs@gmail.com>
X-Google-Original-From: Kamlesh Kumar <kam@juniper.net>
To: zohar@linux.ibm.com,
	stefanb@linux.ibm.com
Cc: linux-integrity@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kamlesh Kumar <kam@juniper.net>
Subject: [PATCH] ima: Fix sigv3 signature handling for EVM_IMA_XATTR_DIGSIG
Date: Fri, 24 Apr 2026 17:09:46 +0530
Message-Id: <20260424113946.16561-1-kam@juniper.net>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4CD5745DE8E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-9317-lists,linux-integrity=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kamlesh0hrs@gmail.com,linux-integrity@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[linux-integrity];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

ima_get_hash_algo() only recognizes version 2 signatures when the xattr
type is EVM_IMA_XATTR_DIGSIG. Since sigv3 signatures also use
EVM_IMA_XATTR_DIGSIG as the xattr type, version 3 must be accepted as
well to correctly determine the hash algorithm.

Additionally, ima_validate_rule() does not include IMA_SIGV3_REQUIRED in
the allowed flags bitmask for MODULE_CHECK, KEXEC_KERNEL_CHECK, and
KEXEC_INITRAMFS_CHECK hook functions. As a result, policy rules with
"appraise_type=sigv3" are rejected for these functions.

Add version 3 to the accepted versions in ima_get_hash_algo() for
EVM_IMA_XATTR_DIGSIG, and add IMA_SIGV3_REQUIRED to the allowed flags
for MODULE_CHECK, KEXEC_KERNEL_CHECK, and KEXEC_INITRAMFS_CHECK in
ima_validate_rule().

Signed-off-by: Kamlesh Kumar <kam@juniper.net>
---
 security/integrity/ima/ima_appraise.c | 5 +++--
 security/integrity/ima/ima_policy.c   | 3 ++-
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
index de963b9f3634..2dd231567710 100644
--- a/security/integrity/ima/ima_appraise.c
+++ b/security/integrity/ima/ima_appraise.c
@@ -195,8 +195,9 @@ enum hash_algo ima_get_hash_algo(const struct evm_ima_xattr_data *xattr_value,
 		return sig->hash_algo;
 	case EVM_IMA_XATTR_DIGSIG:
 		sig = (typeof(sig))xattr_value;
-		if (sig->version != 2 || xattr_len <= sizeof(*sig)
-		    || sig->hash_algo >= HASH_ALGO__LAST)
+		if ((sig->version != 2 && sig->version != 3) ||
+		    xattr_len <= sizeof(*sig) ||
+		    sig->hash_algo >= HASH_ALGO__LAST)
 			return ima_hash_algo;
 		return sig->hash_algo;
 	case IMA_XATTR_DIGEST_NG:
diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index f7f940a76922..b1c010e8eb13 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -1313,7 +1313,8 @@ static bool ima_validate_rule(struct ima_rule_entry *entry)
 				     IMA_GID | IMA_EGID |
 				     IMA_FGROUP | IMA_DIGSIG_REQUIRED |
 				     IMA_PERMIT_DIRECTIO | IMA_MODSIG_ALLOWED |
-				     IMA_CHECK_BLACKLIST | IMA_VALIDATE_ALGOS))
+				     IMA_CHECK_BLACKLIST | IMA_VALIDATE_ALGOS |
+				     IMA_SIGV3_REQUIRED))
 			return false;
 
 		break;

base-commit: 82bbd447199ff1441031d2eaf9afe041550cf525
-- 
2.34.1


