Return-Path: <linux-integrity+bounces-5227-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFEC0A5C010
	for <lists+linux-integrity@lfdr.de>; Tue, 11 Mar 2025 13:05:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 643807A5E21
	for <lists+linux-integrity@lfdr.de>; Tue, 11 Mar 2025 12:03:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8434C255E3E;
	Tue, 11 Mar 2025 12:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="knkli6TZ"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtpbgeu2.qq.com (smtpbgeu2.qq.com [18.194.254.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 189982571A9;
	Tue, 11 Mar 2025 12:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.194.254.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741694597; cv=none; b=ZjXj7HKkh9sGyIRV7/4nk8rkD7UyQNX/PuTYfstBTZXKVCf0Mx98WMf4m4Qxuo4nrf2u8kXCZT5SIeMdLUL//QrwTs8Tro36BCLTfGnSeqZpLemmzS43XFmB8V9aVeqPz4nFY25Jbo45uMRJcsYHSasVuRge938dUPMIT+F63nA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741694597; c=relaxed/simple;
	bh=/B8LOU3EPY1bvUwmU8M98LiZ3McvkPIlMaG0ADq5cyg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UqmAs4IuPw8tXbdyFsPDR5ggCBjpsYDuCrDicBFFbFXkeCoJ/E20mJNVCvVxeT4Dw/Eh8QY79JntORIs44km0PZ06WtgiZIOZlG0D7g8Do2+OS3x0uB87B1iHZeLfOodt+nAoBUR3rm2eA8WO/FHnPr6OnZVfILZzDRO6fsjWxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=knkli6TZ; arc=none smtp.client-ip=18.194.254.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1741694546;
	bh=oObmgM37XdbiQEyrtFB9Jj1DhC5YLB/am9mUi1LXOns=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=knkli6TZ+5PJBWNzp+Iti66jQAiAEVTgCST5b6xekTevysV6Z6J9q+8hJEbwKNckH
	 Ht6cNBfHmXfxNSysn+lVznTbi+REMvQ3sNvCEQwDegt0nhwD2GTpU81yBYWuB6Asa/
	 kLECI6rKt1zl3czofYW6oo3NJ5J/TeINLqJ8AgxY=
X-QQ-mid: bizesmtpip3t1741694495tnu5g36
X-QQ-Originating-IP: yWSAeIPiqtPNf0ao2bIbG/CqRwF5BLPwY+Yu8R3vs9E=
Received: from localhost.localdomain ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 11 Mar 2025 20:01:33 +0800 (CST)
X-QQ-SSF: 0002000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 9260470800203559345
From: WangYuli <wangyuli@uniontech.com>
To: peterhuewe@gmx.de,
	jarkko@kernel.org,
	jgg@ziepe.ca,
	ardb@kernel.org,
	wangyuli@uniontech.com,
	gourry@gourry.net
Cc: linux-kernel@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	zhanjun@uniontech.com,
	niecheng1@uniontech.com,
	guanwentao@uniontech.com,
	Chen Linxuan <chenlinxuan@uniontech.com>
Subject: [PATCH] tpm: eventlog: Declare mapping_size __maybe_unused
Date: Tue, 11 Mar 2025 20:01:15 +0800
Message-ID: <10590A3A04DA011F+20250311120115.1451048-1-wangyuli@uniontech.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpip:uniontech.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: OMEqDAhtxLq6no6jefPyEAD/MxqyCdljrmScj8nUuWAmYnc/wXs7Sb60
	lvTARDenBsaf4xypNWFzSybp4uAtBzKHI37tuB9nlSA2An5e7wx6HvFOqHy5GCi9fBW25gZ
	nVHyEI1d7qUYB7KXsBoN0P9mH0vchHqJYIiq81mXN5+pFLu4I9mFlpi+SqDsnaKnaLbcDhD
	ZBR2cAUrY9hkpYW3mu7f+w49AelsHy+udAjUOVZlraYNqzh6wITMd7ZXXGvb72W4t7BYuuy
	Q0TcYfBJL0ZtiAImBnkc0Dn06Xk7bmYl6JVkSeUFLeRqyi3niBhSo9hhxP7oz01yI6D36v9
	KIqAl4HA8/O8cIRct4Ds3pl9XQH3ZAhRrWwS6EOpWoV6KzzKXjsAH6NSXXEbIeS5ZSyqY4o
	6HYpS0E/C2VkZ3ztqnpln6eyUXUIQ0KE9KKfQ0OtRkk1CsnWvVF6mj00w3zxuYvZ55RsgTd
	LgiX+vdY3ArFbBvMuvh4KydctytgHPSvR7pBVZyqjgaKi1bLwFyc5QYJWtayj7eIiFhzGH2
	wPovdwjq0KDbRn3XwkjTFbNdpiFIktRijZO9PEjJqxQR+MxxMem95HPim90BHF36IIY3O/i
	eEpYBqRqqkiFtlKIWRKpErCRRPs71ALt7y7qtZ4a6nmJ12wfJU4BYQ4srHkb5PSjfAV9kK6
	990ngbTwGhCK//tjZy5l9+Vvb8sjYHnsIvqigvU4QuU8Dk6ID9Jel2y1reioOILUs+t9XSW
	FZORhmLTGjV1/5pLBVjSlGiDs+KYD0bkbev3eBtucOEdtnvP1qzd9WyV2cxDqklYbwHcJbU
	6gdzT57QRY8J4UDbiFX/8OOcuEIrmxEgE9KpDk6YWr03pKDCbJVVPdViUaEQ0jhM3MvqPaz
	Fv3MZNmJ9JDwoH3XT+4XQ/APpQmAZH65T5pZ8v3MmXd2RUGs5g0dHgSldjw6CTpodU2uVkw
	YcgaBpj0lEvlyOmybTdgRP3fijPbU0ae9cSLYDYz2HJ0nAw6looFYqpGMD901+laf/z3osi
	La87hJdGc+HoKcD1IsuQn3N9WCYSTJNhxkRC6q4UPzj8VHqVkNJ/pM8lGrZBfJJm3rXrS1e
	Olu7Yuza+zH
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
X-QQ-RECHKSPAM: 0

Given that when CONFIG_EFI is not enabled, do_mapping is inherently
false. Thus, the mapping_size variable is set but remains unused,
resulting in a compilation warning.

Simply annotating it with __maybe_unused will resolve this compilation
warning.

[ Fix follow errors with clang-19 when W=1e: ]
  In file included from drivers/char/tpm/tpm1-cmd.c:21:
  ./include/linux/tpm_eventlog.h:167:6: error: variable 'mapping_size' set but not used [-Werror,-Wunused-but-set-variable]
    167 |         int mapping_size;
        |             ^
  1 error generated.
  make[8]: *** [scripts/Makefile.build:207: drivers/char/tpm/tpm1-cmd.o] Error 1
  make[8]: *** Waiting for unfinished jobs....
  In file included from drivers/char/tpm/tpm-dev-common.c:19:
  In file included from drivers/char/tpm/tpm.h:28:
  ./include/linux/tpm_eventlog.h:167:6: error: variable 'mapping_size' set but not used [-Werror,-Wunused-but-set-variable]
    167 |         int mapping_size;
        |             ^
  1 error generated.
  make[8]: *** [scripts/Makefile.build:207: drivers/char/tpm/tpm-dev-common.o] Error 1
  In file included from drivers/char/tpm/tpm2-cmd.c:14:
  In file included from drivers/char/tpm/tpm.h:28:
  ./include/linux/tpm_eventlog.h:167:6: error: variable 'mapping_size' set but not used [-Werror,-Wunused-but-set-variable]
    167 |         int mapping_size;
        |             ^
  1 error generated.
  In file included from drivers/char/tpm/tpm-dev.c:16:
  In file included from drivers/char/tpm/tpm-dev.h:6:
  In file included from drivers/char/tpm/tpm.h:28:
  ./include/linux/tpm_eventlog.h:167:6: error: variable 'mapping_size' set but not used [-Werror,-Wunused-but-set-variable]
    167 |         int mapping_size;
        |             ^
  1 error generated.
  make[8]: *** [scripts/Makefile.build:207: drivers/char/tpm/tpm-dev.o] Error 1
  make[8]: *** [scripts/Makefile.build:207: drivers/char/tpm/tpm2-cmd.o] Error 1
  make[8]: *** [scripts/Makefile.build:207: drivers/char/tpm/tpmrm-dev.o] Error 1
  In file included from drivers/char/tpm/tpm-chip.c:24:
  ./include/linux/tpm_eventlog.h:167:6: error: variable 'mapping_size' set but not used [-Werror,-Wunused-but-set-variable]
    167 |         int mapping_size;
        |             ^
  1 error generated.
  In file included from drivers/char/tpm/tpm-sysfs.c:16:
  In file included from drivers/char/tpm/tpm.h:28:
  ./include/linux/tpm_eventlog.h:167:6: error: variable 'mapping_size' set but not used [-Werror,-Wunused-but-set-variable]
    167 |         int mapping_size;
        |             ^
  1 error generated.
  make[8]: *** [scripts/Makefile.build:207: drivers/char/tpm/tpm-chip.o] Error 1
  make[8]: *** [scripts/Makefile.build:207: drivers/char/tpm/tpm-sysfs.o] Error 1
  In file included from drivers/char/tpm/tpm2-sessions.c:71:
  In file included from drivers/char/tpm/tpm.h:28:
  ./include/linux/tpm_eventlog.h:167:6: error: variable 'mapping_size' set but not used [-Werror,-Wunused-but-set-variable]
    167 |         int mapping_size;
        |             ^
  1 error generated.
  make[8]: *** [scripts/Makefile.build:207: drivers/char/tpm/tpm2-sessions.o] Error 1
  In file included from drivers/char/tpm/tpm-interface.c:28:
  ./include/linux/tpm_eventlog.h:167:6: error: variable 'mapping_size' set but not used [-Werror,-Wunused-but-set-variable]
    167 |         int mapping_size;
        |             ^
  1 error generated.
  make[8]: *** [scripts/Makefile.build:207: drivers/char/tpm/tpm-interface.o] Error 1
  In file included from drivers/char/tpm/tpm2-space.c:16:
  In file included from drivers/char/tpm/tpm.h:28:
  ./include/linux/tpm_eventlog.h:167:6: error: variable 'mapping_size' set but not used [-Werror,-Wunused-but-set-variable]
    167 |         int mapping_size;
        |             ^
  1 error generated.
  make[8]: *** [scripts/Makefile.build:207: drivers/char/tpm/tpm2-space.o] Error 1
  In file included from drivers/char/tpm/eventlog/tpm1.c:24:
  ./include/linux/tpm_eventlog.h:167:6: error: variable 'mapping_size' set but not used [-Werror,-Wunused-but-set-variable]
    167 |         int mapping_size;
        |             ^
  1 error generated.
  make[8]: *** [scripts/Makefile.build:207: drivers/char/tpm/eventlog/tpm1.o] Error 1
  In file included from drivers/char/tpm/eventlog/common.c:20:
  ./include/linux/tpm_eventlog.h:167:6: error: variable 'mapping_size' set but not used [-Werror,-Wunused-but-set-variable]
    167 |         int mapping_size;
        |             ^
  1 error generated.
  make[8]: *** [scripts/Makefile.build:207: drivers/char/tpm/eventlog/common.o] Error 1
  In file included from drivers/char/tpm/eventlog/tpm2.c:20:
  ./include/linux/tpm_eventlog.h:167:6: error: variable 'mapping_size' set but not used [-Werror,-Wunused-but-set-variable]
    167 |         int mapping_size;
        |             ^
  1 error generated.
  make[8]: *** [scripts/Makefile.build:207: drivers/char/tpm/eventlog/tpm2.o] Error 1
  In file included from drivers/char/tpm/tpm_vtpm_proxy.c:24:
  In file included from drivers/char/tpm/tpm.h:28:
  ./include/linux/tpm_eventlog.h:167:6: error: variable 'mapping_size' set but not used [-Werror,-Wunused-but-set-variable]
    167 |         int mapping_size;
        |             ^
  1 error generated.
  make[8]: *** [scripts/Makefile.build:207: drivers/char/tpm/tpm_vtpm_proxy.o] Error 1
  make[7]: *** [scripts/Makefile.build:465: drivers/char/tpm] Error 2
  make[6]: *** [scripts/Makefile.build:465: drivers/char] Error 2
  make[6]: *** Waiting for unfinished jobs....

Suggested-by: Chen Linxuan <chenlinxuan@uniontech.com>
Signed-off-by: WangYuli <wangyuli@uniontech.com>
---
 include/linux/tpm_eventlog.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/tpm_eventlog.h b/include/linux/tpm_eventlog.h
index 891368e82558..7ca58b2e96e8 100644
--- a/include/linux/tpm_eventlog.h
+++ b/include/linux/tpm_eventlog.h
@@ -164,7 +164,7 @@ static __always_inline u32 __calc_tpm2_event_size(struct tcg_pcr_event2_head *ev
 	struct tcg_efi_specid_event_head *efispecid;
 	struct tcg_event_field *event_field;
 	void *mapping = NULL;
-	int mapping_size;
+	__maybe_unused int mapping_size;
 	void *marker;
 	void *marker_start;
 	u32 halg_size;
-- 
2.47.2


