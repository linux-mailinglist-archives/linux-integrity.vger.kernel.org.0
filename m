Return-Path: <linux-integrity+bounces-7744-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BCA3C95A16
	for <lists+linux-integrity@lfdr.de>; Mon, 01 Dec 2025 04:06:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 601E24E0247
	for <lists+linux-integrity@lfdr.de>; Mon,  1 Dec 2025 03:06:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E26831DE887;
	Mon,  1 Dec 2025 03:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GMkEgRTL";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="PZ8Jk5A2"
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B7A819995E
	for <linux-integrity@vger.kernel.org>; Mon,  1 Dec 2025 03:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764558378; cv=none; b=qLZoHX7XQYMhIXwm17k4/SG13mt0SSOu9GJCagthbJLRm+zWkKAvlowgoiDrnSFED88oslIk1qfx8R8GLUMf1BwjhguDGBPOGSoga72Vy3eUmTy7dRqi/n5GlcVW2OJKBj6xFsvoAJSNnTvo22VlpNPaYZqNwfEVYA5sOL+kYwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764558378; c=relaxed/simple;
	bh=JQob1fIFOHd0zgBafaJjwPrC6CdFgMyJsc+cMbI1z/8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LTLj7IvTZYy+/UCNeveDY6RkYXRxhqab/SwHZk4ucl6/dILvQmb10pCEYORssKHkO149swob9YhkVC9g5CZkA5d0UbaSGQ1c626I38ApL1Nf6Z9D7UW6tLvvKcTOVz9GjKBvcZi2lvsAFfwjxC7A9pPNhFKPiV2qXjc63jvF6To=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GMkEgRTL; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=PZ8Jk5A2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764558375;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=38eKCGFDzi9YXaJFlb8wscW8uVUGQfKn9hJMTWM8MvA=;
	b=GMkEgRTL24hiSWBywNgzAcTxcXeEh0ca4GD1V3zEQdXtXvr7p8J2DXP1RNOro6pSAW8NJR
	Y9xZoJ+F5AiRBg9xrypDB4w44+eu40DwLDyCsOrtAd4Mm+pw3aIQWU2z245+LTLIW6RgQ8
	F1UerAaZ/F5zQyDLEGoOjkoh3NakSRk=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-362-m0EkTrH_Oaq29da1Kw_aSQ-1; Sun, 30 Nov 2025 22:06:12 -0500
X-MC-Unique: m0EkTrH_Oaq29da1Kw_aSQ-1
X-Mimecast-MFC-AGG-ID: m0EkTrH_Oaq29da1Kw_aSQ_1764558371
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-297e5a18652so38671385ad.1
        for <linux-integrity@vger.kernel.org>; Sun, 30 Nov 2025 19:06:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1764558371; x=1765163171; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=38eKCGFDzi9YXaJFlb8wscW8uVUGQfKn9hJMTWM8MvA=;
        b=PZ8Jk5A23lBDBritOLYFZ2DGHVe6kzPsedp+pWbcmPSObdvxWeJosPUxGfAlbzQulK
         LvFLY+YgYG/UIrCaS3h3cT/JoktOaIKr6jyg5CW7hxRuqg0QQJWbrHpN08s3soHDpoGV
         IC3kTUBa81Ayyjkv6Xlgvyg605gwx+vxBFZgDxHblYMXTAjn7ANpWFHHFF8bJ3mi187s
         6+9L+W30bU/Sq/sK0wh+1h+F8qMjtZYF9U+A9zytWr8bi2u2MRWkxEPI4lrKttxmXLut
         pQfSdtgtFtTnY7UtPkhwQZHcz+ItqIRzDU4SF0cDWMEJXkU/mNo6+7/PT2dtpFmoJ2H/
         qqMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764558371; x=1765163171;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=38eKCGFDzi9YXaJFlb8wscW8uVUGQfKn9hJMTWM8MvA=;
        b=GHIyMhwXGQ6WSXmEHSskC7De97+Hqjbl1bBtLLbVQ8g0gUmJO06cmm5VGJnpZ7hTDU
         bl45g7YugC5NYPYoq+bX+w5ShVpKd7atUb/EJzlZRtodaxdCXD4bg+NMyCg0zxZkOwUg
         bcC6qaiKur1qs2Fm7OUQdKc5K6DxyQwnJz/3OFSMz8y8bYa12t/e3QwRgp/0fTeFUNgz
         tpuBJ/CNeZaeR5/Uu/WMe7oFa0kWJqCHhiKxHSOn5whcEWLu2Q8IqJfB/gyCSShcD/ZK
         QNq9tEGDC0d/ft+dUGnCUFCDAGXb58Q/hEKIHU8s3MydL3d0Lp+EG+WYPkYEUS8WMJz0
         +EuQ==
X-Gm-Message-State: AOJu0Yyd1okbBBL6/ogQHTmyYAbRtA0c0SqVqrP7AJxPowiezuoafGbQ
	6h7Zd83zSon6ikGKPmUdjxPTjCWOJgVh25U+UBkQ3VArdH2FL8Jyz4DeULGSEOItiIoRD8W4ebZ
	M3CbCacYWxiT/f8HTD/FXhfgP+b2LeO7QxHUg8I4MFLfuTQWkgfLGh6OUOjDky0hUd/YPOw==
X-Gm-Gg: ASbGncsaqAutI7u1x1QbT4GLo+7flFL0wyjC6DzCcZ/0sbUJf0qTYlNDN99/EYmYCud
	dIoNRw74MvtNLtDw2Nc0l18Q4LMxpgf9dKmSqWytZW8kH/xlUoL+i0Ie/SXiOxx+R9u0Uz3rzZG
	gjXaX3uuUFlMdwBVMINMP9gWeOUeTXqKQETpGsnwO36RJCWUeiZ6haZLL2B3zPMbdYjHZZUOMQs
	dHERRpzK1mvNyYX0bLXSGIas7rPW4eOWdtYdsbUV2Qw4pAM1j0OLEklJLI/hGY6iZY7PfIVphUi
	p5KQ0853gJHwckWTOCHfsudCRZEwJLORA4REENoj8MIE1fSnfEva8+BAU6SQ8V4qXwtz5D6KLsS
	U
X-Received: by 2002:a17:902:f788:b0:267:a1f1:9b23 with SMTP id d9443c01a7336-29b6c3e5524mr368030965ad.18.1764558370870;
        Sun, 30 Nov 2025 19:06:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFb1AfSKXtOAPR9LAt0sVNrvR3EMUitw1jOBkDMrMtNSwVwZgBH54JasyLl3tbolo7V0xtUeA==
X-Received: by 2002:a17:902:f788:b0:267:a1f1:9b23 with SMTP id d9443c01a7336-29b6c3e5524mr368030275ad.18.1764558370055;
        Sun, 30 Nov 2025 19:06:10 -0800 (PST)
Received: from localhost ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3475ff57b47sm9183994a91.5.2025.11.30.19.06.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Nov 2025 19:06:09 -0800 (PST)
From: Coiby Xu <coxu@redhat.com>
To: linux-modules@vger.kernel.org
Cc: linux-integrity@vger.kernel.org,
	kernel test robot <lkp@intel.com>,
	Aaron Tomlin <atomlin@atomlin.com>,
	Daniel Gomez <da.gomez@samsung.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Daniel Gomez <da.gomez@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	linux-kernel@vger.kernel.org (open list:MODULE SUPPORT)
Subject: [PATCH v2] module: Only declare set_module_sig_enforced when CONFIG_MODULE_SIG=y
Date: Mon,  1 Dec 2025 11:06:05 +0800
Message-ID: <20251201030606.2295399-1-coxu@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251031080949.2001716-1-coxu@redhat.com>
References: <20251031080949.2001716-1-coxu@redhat.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently if set_module_sig_enforced is called with CONFIG_MODULE_SIG=n
e.g. [1], it can lead to a linking error,

    ld: security/integrity/ima/ima_appraise.o: in function `ima_appraise_measurement':
    security/integrity/ima/ima_appraise.c:587:(.text+0xbbb): undefined reference to `set_module_sig_enforced'

This happens because the actual implementation of
set_module_sig_enforced comes from CONFIG_MODULE_SIG but both the
function declaration and the empty stub definition are tied to
CONFIG_MODULES.

So bind set_module_sig_enforced to CONFIG_MODULE_SIG instead. This
allows (future) users to call set_module_sig_enforced directly without
the "if IS_ENABLED(CONFIG_MODULE_SIG)" safeguard.

Note this issue hasn't caused a real problem because all current callers
of set_module_sig_enforced e.g. security/integrity/ima/ima_efi.c
use "if IS_ENABLED(CONFIG_MODULE_SIG)" safeguard.

[1] https://lore.kernel.org/lkml/20250928030358.3873311-1-coxu@redhat.com/

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202510030029.VRKgik99-lkp@intel.com/
Reviewed-by: Aaron Tomlin <atomlin@atomlin.com>
Reviewed-by: Daniel Gomez <da.gomez@samsung.com>
Signed-off-by: Coiby Xu <coxu@redhat.com>
---
v2
- improve commit message as suggested by Daniel
- add Reviewed-by tags from Aaron and Daniel

 include/linux/module.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/linux/module.h b/include/linux/module.h
index e135cc79acee..fa251958b138 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -769,8 +769,6 @@ static inline bool is_livepatch_module(struct module *mod)
 #endif
 }
 
-void set_module_sig_enforced(void);
-
 void module_for_each_mod(int(*func)(struct module *mod, void *data), void *data);
 
 #else /* !CONFIG_MODULES... */
@@ -865,10 +863,6 @@ static inline bool module_requested_async_probing(struct module *module)
 }
 
 
-static inline void set_module_sig_enforced(void)
-{
-}
-
 /* Dereference module function descriptor */
 static inline
 void *dereference_module_function_descriptor(struct module *mod, void *ptr)
@@ -924,6 +918,8 @@ static inline bool retpoline_module_ok(bool has_retpoline)
 #ifdef CONFIG_MODULE_SIG
 bool is_module_sig_enforced(void);
 
+void set_module_sig_enforced(void);
+
 static inline bool module_sig_ok(struct module *module)
 {
 	return module->sig_ok;
@@ -934,6 +930,10 @@ static inline bool is_module_sig_enforced(void)
 	return false;
 }
 
+static inline void set_module_sig_enforced(void)
+{
+}
+
 static inline bool module_sig_ok(struct module *module)
 {
 	return true;

base-commit: ac3fd01e4c1efce8f2c054cdeb2ddd2fc0fb150d
-- 
2.52.0


