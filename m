Return-Path: <linux-integrity+bounces-7551-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B4CDC23B68
	for <lists+linux-integrity@lfdr.de>; Fri, 31 Oct 2025 09:13:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0161234368C
	for <lists+linux-integrity@lfdr.de>; Fri, 31 Oct 2025 08:13:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B8F0303A08;
	Fri, 31 Oct 2025 08:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S/s5mASS"
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1F543009DE
	for <linux-integrity@vger.kernel.org>; Fri, 31 Oct 2025 08:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761898223; cv=none; b=HmmXUp9LLfbWA7M6WqgDDSz5C9Bj3c+nYROU2B4OtTmWJB4p5ET5vqsBuwK9iO2hflKwmDdlhrKzKQHAwJ8W7FQkJd1Shwc/57Oj70f7rSkfWzZJX/s1wFgNHhpQrXTHAzTYr5xmnlKzg1do/BHUHjLbXBEjqU0i0UJ70OHoFro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761898223; c=relaxed/simple;
	bh=VrcIxeKGvklYAAY8vcHJNydokVUp7bULcDMSaEYoXWs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UBJyzZOydoqOGjOlKLuA3IV7qsodluEIpKKeqt/vjao/cRaMuixFlUCUPgYcT5j2eAEO3WvihTPkMrqfkB+3zkPnc7fB+X5DfChvIPnrdd7MTSQpvxMrOWz78H4nOeKi7/4UbkEqfkxwOiXjycQ+dNRVvXkw9WD0JXG1zFYcI+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=S/s5mASS; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761898220;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=i82y6QYrW3cjMA5vRe+eeZV6V5DVvv4lrrKkBnMpwUY=;
	b=S/s5mASSV0EGrGvG/mpqBl1qWFUe0P5oHfbY7t6OqxlEft5rClEt3pOdbVB22Np+Ti3j4e
	Wh3ScwMQnaOhVT2y+nYQQDPtF+ikoaRsJA0Fv5R5M5Lv2WMkqJGYi+BcfMfjyB5oaqQIVQ
	hYl8NWdr5hOGsdlX0VwtJgd+5Yw8evk=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-662-6JE5HBaoNgeUzrONSYgMIA-1; Fri, 31 Oct 2025 04:10:19 -0400
X-MC-Unique: 6JE5HBaoNgeUzrONSYgMIA-1
X-Mimecast-MFC-AGG-ID: 6JE5HBaoNgeUzrONSYgMIA_1761898218
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3405c46a22eso1757785a91.2
        for <linux-integrity@vger.kernel.org>; Fri, 31 Oct 2025 01:10:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761898218; x=1762503018;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i82y6QYrW3cjMA5vRe+eeZV6V5DVvv4lrrKkBnMpwUY=;
        b=nx4uCCXzKUgQKyPWSG3EdgWNmhXtXRvN13iL7SFkgc3KMI6SrUV18ySanwKoKuyBcq
         6nkkc+xg5NvoJijWVRuXH6gxb99p+SJPvQpcm3Q7eMGi/kqfa2zUopuzPtehYWWQVh0k
         LKXhsZ7ovAiz8cKxjovaVSdsE6gzjrvQYP5e9eFUlQfkI+0euRXiZeGuDG94vAtSksI+
         gWdxoHE2Egz96bNQDjs89j7QNPmrTnHkMJpRCV5YWeLyFWhk9Y5ays3zO4FtSINWXV/w
         gKxTN8hN/CPLcvnH4f+gPUaF8taiNJiEfh4KZv4MRrshKREYY4vCfupRZ4Vdm+ibDT6H
         cikg==
X-Gm-Message-State: AOJu0YwCF9JAV0/2BrDOy7eVDqZSCQ8kHKarZOSsDgLa2+fhkszKr9Zp
	Jv9c/MeW8Qe26Nx/bHOzlQJZquFloMjuOrQpwu2Ck7Yye/SNyq8DgJbfYJTsZVrMRK4FwHHzf1d
	PICV3Y7iVPKBnk36l1e1aMGsERK7FzP5Pxf9Zmh6s9zm9nU1aa8d6va+uBwtHIB0HfpJL7g==
X-Gm-Gg: ASbGncvVszUL3g4SzODofpFdmIX9xk/SilXJIpNZSdYHwtZl1h1VCG3UKmgPbMk3pPN
	q+mgfzlZC531dtWvPXoydt+zlmQpIXIl7es09Sd8J6GrUqnY0K+uV0ydz6p+6n1Bt8GUEyZApEg
	kE47wuyKDI1wBTRQqwJj83LJlU123kvZko3hUMp0W0EIkGtA/S2INXmnxB+GGde1VE/TaZMN1Ui
	2pMGyHaFBKzQcp1ipGXoGPDxDNKG8z7Kq5KKdW3VrK4GeEiQChqqX7Qq3WC0lPmq+1xrInIO/Fm
	bztloseDJot3PIXicIAEdoyHBhOzCqfWMTmEsdiBZt4pglEFBu8xU4tklvvOv40+dQ==
X-Received: by 2002:a17:90b:2e50:b0:330:6f16:c4e0 with SMTP id 98e67ed59e1d1-34082fd8a51mr4113229a91.12.1761898217803;
        Fri, 31 Oct 2025 01:10:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF4iFz4WR/OBJiATgxQJLE1K7D2jafbG20415vZcHWra3bLCe9VveUtUMdFVbyjY0dNnGmaJQ==
X-Received: by 2002:a17:90b:2e50:b0:330:6f16:c4e0 with SMTP id 98e67ed59e1d1-34082fd8a51mr4113171a91.12.1761898217197;
        Fri, 31 Oct 2025 01:10:17 -0700 (PDT)
Received: from localhost ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-340999f9943sm814815a91.1.2025.10.31.01.10.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 01:10:16 -0700 (PDT)
From: Coiby Xu <coxu@redhat.com>
To: linux-modules@vger.kernel.org
Cc: linux-integrity@vger.kernel.org,
	kernel test robot <lkp@intel.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Daniel Gomez <da.gomez@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	linux-kernel@vger.kernel.org (open list:MODULE SUPPORT)
Subject: [PATCH] module: Only declare set_module_sig_enforced when CONFIG_MODULE_SIG=y
Date: Fri, 31 Oct 2025 16:09:48 +0800
Message-ID: <20251031080949.2001716-1-coxu@redhat.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, set_module_sig_enforced is declared as long as CONFIG_MODULES
is enabled. This can lead to a linking error if
set_module_sig_enforced is called with CONFIG_MODULE_SIG=n,

    ld: security/integrity/ima/ima_appraise.o: in function `ima_appraise_measurement':
    security/integrity/ima/ima_appraise.c:587:(.text+0xbbb): undefined reference to `set_module_sig_enforced'

So only declare set_module_sig_enforced when CONFIG_MODULE_SIG is
enabled.

Note this issue hasn't caused a real problem because all current callers
of set_module_sig_enforced e.g. security/integrity/ima/ima_efi.c
depend on CONFIG_MODULE_SIG=y.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202510030029.VRKgik99-lkp@intel.com/
Signed-off-by: Coiby Xu <coxu@redhat.com>
---
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

base-commit: e53642b87a4f4b03a8d7e5f8507fc3cd0c595ea6
-- 
2.51.0


