Return-Path: <linux-integrity+bounces-5336-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E9F99A6A609
	for <lists+linux-integrity@lfdr.de>; Thu, 20 Mar 2025 13:14:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 547233B4E83
	for <lists+linux-integrity@lfdr.de>; Thu, 20 Mar 2025 12:12:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E7D6221DA2;
	Thu, 20 Mar 2025 12:12:10 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from gardel.0pointer.net (gardel.0pointer.net [85.214.157.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26A9321E0A2;
	Thu, 20 Mar 2025 12:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.157.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742472730; cv=none; b=JFhE2S/o4g/p57tyJJPHkX7xaDt/HgFZGNw/5u1K/1msbCdmn+fAMJWor6JPZX9ijDYajosfCGe9V264jYRz8rsV68+i2O/wEyVAtE8/og0FXQbLqdfWEuGq99s2zu057f7c/qoF9ZDB1bFFHKqVII/BUmtjoQs+6puxGNRaIqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742472730; c=relaxed/simple;
	bh=2hjKwq6kk1hx+A8wkZwRF9MYGKvwTO1wp6RDC9xD8Kw=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Ses+iMPv8LnCJecMK/F1QYSbNYNbZCTlN2/I46PqL4K0wv3399wXsPtgsaoMcPoItXaTU4xXR7qiwoVu5oNFLrcDBgQSRIWzXVrtx+7rTlQ0Cng2Q8XhLbdFi0EdiwI/9Tygm6VHuqQ9pQqpCw9xum9fzRA5C0MTGNrCpbF5ptQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0pointer.de; spf=pass smtp.mailfrom=0pointer.de; arc=none smtp.client-ip=85.214.157.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0pointer.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0pointer.de
Received: from gardel-login.0pointer.net (gardel-mail [85.214.157.71])
	by gardel.0pointer.net (Postfix) with ESMTP id D02F4E801C3;
	Thu, 20 Mar 2025 13:02:13 +0100 (CET)
Received: by gardel-login.0pointer.net (Postfix, from userid 1000)
	id 6C4FF160206; Thu, 20 Mar 2025 13:02:13 +0100 (CET)
Date: Thu, 20 Mar 2025 13:02:13 +0100
From: Lennart Poettering <mzxreary@0pointer.de>
To: Jarkko Sakkinen <jarkko@kernel.org>, Mimi Zohar <zohar@linux.ibm.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
	Eric Snowberg <eric.snowberg@oracle.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	"Lee, Chun-Yi" <joeyli.kernel@gmail.com>
Subject: [PATCH] Revert "integrity: Do not load MOK and MOKx when secure boot
 be disabled"
Message-ID: <Z9wDxeRQPhTi1EIS@gardel-login>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

This reverts commit 92ad19559ea9a8ec6f158480934ae26ebfe2c14f.

This original commit this reverts creates a strange situation: it
ensures more restrictive behaviour if SecureBoot is off then when it
is on, which is the opposite of what one would expect.

Typically, one would expect that if SB is off the validation of
resources during the pre-kernel and kernel initialization is less
restrictive, not more restrictive. But this check turned the world on
its head.

I'd like to ask for this commit to be reverted. If SB is on all bets are
off regarding integrity of boot loaders and stuff, hence it makes no
sense to be restrictive here: you cannot regain integrity once you gave
it up once, hence if all bets are off anyway we might as well import any
Mok keys passed to us into the kernel keyring.

Or to say this differently: if an attacker got control of the pre-kernel
boot phase they might as well patch around in the firmware apis to make
the kernel believe it is in SB mode even if it is not. Hence the check
carries no value. It doesn't protect anything in any effective way.

The reason i'd like this check to go is that I'd like a nice way to
insert keys from pre-boot into into the kernel keyring for use with
signed dm-verity, without requiring recompilation of the kernel, and
without SB database games. i.e. i'd like to use a regular, signed
distro kernel, and pass to it additional keys to insert into the
kernel keyring in a reasonable way. The mok stuff would be great for that,
except it all falls apart once SB is off.

You might wonder what signed dm-verity gives me if I have SB off. If
we authenticate the boot phase up to Linux userspace via TPM-based PCR
policies (i.e. measured boot) we can be sure of the boot integrity
without having to rely on SB. But then we'd still like to use
dm-verity based code signing for userspace.
---
 security/integrity/platform_certs/load_uefi.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/security/integrity/platform_certs/load_uefi.c b/security/integrity/platform_certs/load_uefi.c
index d1fdd113450a..7783bcacd26c 100644
--- a/security/integrity/platform_certs/load_uefi.c
+++ b/security/integrity/platform_certs/load_uefi.c
@@ -7,7 +7,6 @@
 #include <linux/err.h>
 #include <linux/efi.h>
 #include <linux/slab.h>
-#include <linux/ima.h>
 #include <keys/asymmetric-type.h>
 #include <keys/system_keyring.h>
 #include "../integrity.h"
@@ -211,10 +210,6 @@ static int __init load_uefi_certs(void)
 		kfree(dbx);
 	}

-	/* the MOK/MOKx can not be trusted when secure boot is disabled */
-	if (!arch_ima_get_secureboot())
-		return 0;
-
 	mokx = get_cert_list(L"MokListXRT", &mok_var, &mokxsize, &status);
 	if (!mokx) {
 		if (status == EFI_NOT_FOUND)
--
2.48.1


Lennart

--
Lennart Poettering, Berlin

