Return-Path: <linux-integrity+bounces-9442-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oJ5PHL3A+WlADAMAu9opvQ
	(envelope-from <linux-integrity+bounces-9442-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Tue, 05 May 2026 12:04:45 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D5024CA664
	for <lists+linux-integrity@lfdr.de>; Tue, 05 May 2026 12:04:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 202C6309D593
	for <lists+linux-integrity@lfdr.de>; Tue,  5 May 2026 09:56:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA07C342526;
	Tue,  5 May 2026 09:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="FXdmqVg0"
X-Original-To: linux-integrity@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67E1C342523;
	Tue,  5 May 2026 09:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777974867; cv=none; b=dPWPl9LyPu9vlzFtH3eGfzx5/fkw/Mf0LxlzitYlJxKjzwqlsLy/b6wWxc0h/kZ1SyIBC1aYD9ioUOYdKUxlVG5XCRsa54Vzd6eI7MQs1pMSQDJFf8FiHh7Jzog1+g4lG9ik7je44dg4bZmllLcD+TW/OV1L7gWoNLgdadeEAtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777974867; c=relaxed/simple;
	bh=4nvhu4KAJ7LtpMJY0gVvOuCsbzZGn/1A4ku8YNtiEaI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=I/lALe1HHE0XM+AfR4doPI+clVC8knmddNyfjMZFL6cEroW7+S2BggBNp7umY4ImQkoJf6j3lQeN9tNHEPsn4qmR5aXq+etBucavNwXvaSI1hqR1/ly2HDDp08fXv8TXuECMXftF7+o+R5glhKT1NDpSgT4sKigK07MIIRQaTkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=FXdmqVg0; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 730B02936;
	Tue,  5 May 2026 02:54:20 -0700 (PDT)
Received: from e129823.cambridge.arm.com (e129823.arm.com [10.1.197.6])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 69B913F836;
	Tue,  5 May 2026 02:54:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1777974865; bh=4nvhu4KAJ7LtpMJY0gVvOuCsbzZGn/1A4ku8YNtiEaI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FXdmqVg0kNK0cAin2OYhyQqWd8VwTfkngKBLCMskRN2gyzf3RJ+xeiof/NVsfvkT8
	 ZNqhtZTJU1kx5Cmk56yDdgmon5C+VSHFrDes2B19O9lBz+CrHalxT5FH/MUZdSvtLp
	 07d8SFQSfMTNWwDEnF2EgLYSwOxuOhf/xgNu50oY=
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: linux-integrity@vger.kernel.org,
	keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev
Cc: jarkko@kernel.org,
	zohar@linux.ibm.com,
	roberto.sassu@huawei.com,
	dmitry.kasatkin@gmail.com,
	eric.snowberg@oracle.com,
	paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com,
	maz@kernel.org,
	oupton@kernel.org,
	joey.gouly@arm.com,
	suzuki.poulose@arm.com,
	yuzenghui@huawei.com,
	catalin.marinas@arm.com,
	will@kernel.org,
	sudeep.holla@kernel.org,
	Yeoreum Yun <yeoreum.yun@arm.com>
Subject: [RFC PATCH 3/3] security: integrity: call load_uefi_certs() at late_initcall_sync
Date: Tue,  5 May 2026 10:54:09 +0100
Message-Id: <20260505095409.1948371-4-yeoreum.yun@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260505095409.1948371-1-yeoreum.yun@arm.com>
References: <20260505095409.1948371-1-yeoreum.yun@arm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 1D5024CA664
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[arm.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[arm.com:s=foss];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,linux.ibm.com,huawei.com,gmail.com,oracle.com,paul-moore.com,namei.org,hallyn.com,arm.com];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-9442-lists,linux-integrity=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yeoreum.yun@arm.com,linux-integrity@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[arm.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-integrity];
	NEURAL_HAM(-0.00)[-0.996];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,arm.com:email,arm.com:dkim,arm.com:mid]

In the arm64 pKVM environment, all FF-A requests fail until the FF-A
driver is initialized, as the FF-A version is not negotiated with the
hypervisor beforehand.

When FF-A is built-in and pKVM is enabled, pKVM
finalises its initialization at the device_initcall_sync level,
while the FF-A driver is initialized later at the late_initcall stage
via deferred probe.

When the EFI variable service runs with StandaloneMm, it uses
FFA_DIRECT_MSG to access EFI variables. As a result,
load_uefi_certs() always fails in this environment.

To address this issue, defer load_uefi_certs() to the
late_initcall_sync level.

Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
---
 security/integrity/platform_certs/load_uefi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/integrity/platform_certs/load_uefi.c b/security/integrity/platform_certs/load_uefi.c
index c0d6948446c3..cc2b879df5b6 100644
--- a/security/integrity/platform_certs/load_uefi.c
+++ b/security/integrity/platform_certs/load_uefi.c
@@ -235,4 +235,4 @@ static int __init load_uefi_certs(void)
 
 	return rc;
 }
-late_initcall(load_uefi_certs);
+late_initcall_sync(load_uefi_certs);
-- 
LEVI:{C3F47F37-75D8-414A-A8BA-3980EC8A46D7}


