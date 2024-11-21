Return-Path: <linux-integrity+bounces-4179-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B6989D4A4B
	for <lists+linux-integrity@lfdr.de>; Thu, 21 Nov 2024 10:57:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01C061F2259F
	for <lists+linux-integrity@lfdr.de>; Thu, 21 Nov 2024 09:57:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3DE11AAE37;
	Thu, 21 Nov 2024 09:57:33 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0FC4169AE4;
	Thu, 21 Nov 2024 09:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732183053; cv=none; b=mP9KkkrfmcEuGdbJsVViQ6mHT5XuViZ8AK3O2AVNZC0jEeKEtoyZiP/uBFSaeWtK2nQf2z839QrItXxfqHVG6v2nPaTOI4BjmgxJjDW7nOc1JP9dyAtW+N/s5kd0MrZW2dHWeZ6pUwThUU18SuTmoypihYTaQirsIpDJEVxnbkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732183053; c=relaxed/simple;
	bh=mXE/tvgFt0bXqhIgNFNLrntXXGNOV3Lq+zjQqIpTj3s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=XkpR7zOA0vK6wcwEvNy5aX93KBuw1x1Np2BLyh6ctZRGJakQsGa0Bo3Ide7Omj89PGHRxWbSKt6bWj3/mvcAcHEW1y3hTqUknBs1Gw3USojCsGxGWajA03YYHHSDYvtAIGVkgFLH5oeVn1PKd3PgbnV8hyTUR6fG8jn/5YZ0yV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2fb4af0b6beso11986861fa.3;
        Thu, 21 Nov 2024 01:57:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732183050; x=1732787850;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bTMbqsnoMNGLibkdcP7u5QI9+AWxB+kh9RGVzPPW/zM=;
        b=EPpl5iuGFI9ecX+jeCjYlksMf7z2mEAVNm2zkkNEVOOSTG1BHa0n8fBmwu+I2WdYc4
         j55+EncyDKix9z1oplNRW95ZPEolHHZ1gTTufMafHGIOsjaPzXqcJCJ2hMqL33IMtbMC
         Zij3m7ew1ATB0n1fP+CEIzimoiW8YhuaDx4hDiIFbZJMEmmGTG/M2ONatnOq527HlACB
         DsaOVXu7LPQ6DKOiY2xBppx2+K7JTC2ykzTgmc4T2U4FA0Eg9xxLE6CDKAWZ07IhlTol
         UbybmHcFdykGBSeYGN6GDWfH5AukQT/8RoS+0AIpHlPb20KaILwf9uOOhepWyzXncqM8
         3DCA==
X-Forwarded-Encrypted: i=1; AJvYcCU/uC+2dtvBDYG2ssbHQeS0PYcBB9Rl5o2iAoDnWkfCV+EBHEv/Y+Fokaif8AjhAwvi52Z3/lMx/pirzJE1EVo=@vger.kernel.org, AJvYcCWVEFktrF5RaWMr6uTxFLPg98fg683gDLFeULgTvFUUEVryqkvRqbjLgWadjmUPYnixVBS9rV1cfef88d2H@vger.kernel.org, AJvYcCWq4aO7by5hgA0hpzReMsAlRLwNuCkLf78rYH366w0bEMlEDGN+kw+8DiUsMe+0v6xxLHVKJLOZqF0SZrL50spdXPl4TBmA@vger.kernel.org
X-Gm-Message-State: AOJu0YweNL2njmy0tRnzGcJ6SgOHrBg5ooNCUgixlAR8m0qYaA8bd+x+
	zkeEv5ngrbBW8UN4/Rf1G9qBMe/H8wtN4rilrSTRY+1HJWQUEJ1z
X-Google-Smtp-Source: AGHT+IEQ/3h1gmcyg8y0A2e1lAMy5tgKib+tZmeEdbSDdDb77Bea91wE6C/Db4iqDbt6Va8idVgQoQ==
X-Received: by 2002:a2e:a549:0:b0:2fb:5014:aad4 with SMTP id 38308e7fff4ca-2ff8db2c665mr54822141fa.9.1732183049765;
        Thu, 21 Nov 2024 01:57:29 -0800 (PST)
Received: from localhost (fwdproxy-lla-008.fbsv.net. [2a03:2880:30ff:8::face:b00c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa4f436c412sm60692166b.179.2024.11.21.01.57.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2024 01:57:28 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
Date: Thu, 21 Nov 2024 01:57:12 -0800
Subject: [PATCH v2] ima: kexec: silence RCU list traversal warning
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241121-ima_rcu-v2-1-4d48630cf2c6@debian.org>
X-B4-Tracking: v=1; b=H4sIAPcDP2cC/2XMMQ7CIBQA0KuQPxcDCFKZvIdpDMK3/YNgQImm4
 e7Grq5veCtULIQVHFuhYKNKOYFjamAQFp9m5BTBMVBCaSmF5nT3lxJeHHHcRz/aKIyAgcGj4I3
 e23SeBgYL1Wcuny1u8qf/R5NcciON1QcRzFHYU8Qr+bTLZYap9/4FUVfrFp8AAAA=
X-Change-ID: 20241104-ima_rcu-ee83da87d050
To: Mimi Zohar <zohar@linux.ibm.com>, 
 Roberto Sassu <roberto.sassu@huawei.com>, 
 Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, 
 Eric Snowberg <eric.snowberg@oracle.com>, Paul Moore <paul@paul-moore.com>, 
 James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
 "Eric W. Biederman" <ebiederm@xmission.com>, 
 Andrew Morton <akpm@linux-foundation.org>
Cc: Mimi Zohar <zohar@linux.vnet.ibm.com>, linux-integrity@vger.kernel.org, 
 linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel-team@meta.com, Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1865; i=leitao@debian.org;
 h=from:subject:message-id; bh=mXE/tvgFt0bXqhIgNFNLrntXXGNOV3Lq+zjQqIpTj3s=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBnPwQHUPDLWuedaB6ehCHozdKpH5lLrUX4VJvc1
 /GUz1Fu5AGJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCZz8EBwAKCRA1o5Of/Hh3
 bfoWD/9V3QR+gu4NonzlOTUolGXozhUyVj7t/ynvxnIY6gQw/KFarveBDzIE1Gf8QDp9T4BOn6a
 BqXlKNssfsh7V4K+L8O7P09b4OfdjF6g2drULQ9qYB3V9Rz/7vLr2j9/FLcKl/C7IVJjYXGVuVU
 TQNIGc9+QDuEqbMZZPqCdnjmYliKGOKoHoDTfJSohLHxukbDrrd4vIVYPMfSVbwDbZyxvJ83LzS
 hEs4koOdH/3Uw2HNLg0R/v1VR74kiox/8HnBB9c6+bXjNmHOXBzBsMFBBu54Ke6Pa4iKbaKwJKA
 LhgLzP45Q6/QOiQWQE0E7C0PSTNtRdrDckrUG+ICzrYdIzCCPa9ya4q3KI8QOCMIHWsXjp7UC+F
 XaCJXzI7LJyfRmFHcCWcpQwXMHwpZrajVK9SPeXGNFCBg1oqp96ZDLxxxrIsoOLf7R45BfWXxwC
 1Gsw05C2ojyzjnyTq/0pjxv4bj6d0E5Z5ETaAhFtSbyCx8m5yZDeQScSf3bF9uT//qaQAzhGBM/
 d9zEDWZJKl24s+PPNLSFBm2zCOycfEMMWYtxSwxlxJtnRMEYhGJVjqFQdevxHxxfkuhuDjyvUlN
 ZFtbyZeLUB/WtuewnrW4V1MkYfQk76pAixhTvmRamBlfe5EZ1WCuVGIdAYbrSnoncRpL/EmbX9a
 8Wq/wQAs4j41rgg==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

The ima_measurements list is append-only and doesn't require
rcu_read_lock() protection. However, lockdep issues a warning when
traversing RCU lists without the read lock:

  security/integrity/ima/ima_kexec.c:40 RCU-list traversed in non-reader section!!

Fix this by using the variant of list_for_each_entry_rcu() with the last
argument set to true. This tells the RCU subsystem that traversing this
append-only list without the read lock is intentional and safe.

This change silences the lockdep warning while maintaining the correct
semantics for the append-only list traversal.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
Changes in v2:
- Do not hold the RCU read lock, but, annotate list_for_each_entry_rcu()
  that is OK to traverse the list without the RCU read lock.
- Link to v1: https://lore.kernel.org/r/20241104-ima_rcu-v1-1-5157460c5907@debian.org
---
 security/integrity/ima/ima_kexec.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/security/integrity/ima/ima_kexec.c b/security/integrity/ima/ima_kexec.c
index 52e00332defed39774c9e23e045f1377cfa30d0c..9d45f4d26f731658a79b94b9f95f4dcc4dcb6325 100644
--- a/security/integrity/ima/ima_kexec.c
+++ b/security/integrity/ima/ima_kexec.c
@@ -37,7 +37,8 @@ static int ima_dump_measurement_list(unsigned long *buffer_size, void **buffer,
 
 	memset(&khdr, 0, sizeof(khdr));
 	khdr.version = 1;
-	list_for_each_entry_rcu(qe, &ima_measurements, later) {
+	/* This is an append-only list, no need to hold the RCU read lock */
+	list_for_each_entry_rcu(qe, &ima_measurements, later, true) {
 		if (file.count < file.size) {
 			khdr.count++;
 			ima_measurements_show(&file, qe);

---
base-commit: ac24e26aa08fe026804f678599f805eb13374a5d
change-id: 20241104-ima_rcu-ee83da87d050

Best regards,
-- 
Breno Leitao <leitao@debian.org>


