Return-Path: <linux-integrity+bounces-9558-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0ATNEomOB2rB8AIAu9opvQ
	(envelope-from <linux-integrity+bounces-9558-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Fri, 15 May 2026 23:22:17 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 06CE4557E15
	for <lists+linux-integrity@lfdr.de>; Fri, 15 May 2026 23:22:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7FF4B3052369
	for <lists+linux-integrity@lfdr.de>; Fri, 15 May 2026 21:17:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15A914EA393;
	Fri, 15 May 2026 21:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pS456OJH"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 842074C6F1C
	for <linux-integrity@vger.kernel.org>; Fri, 15 May 2026 21:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778879720; cv=none; b=sXrO7O8u8W1xqBpQ7mJa/d9N826MawbyNEDBhl2gGNy/Pttfg6xMY8EcoYQY7u+m5y8Ap5RjBDMSLyIg53D8Lt7nVKxqqot22XxraHL+6cIFWIlpcIAclFi0dOqySv+IU8/v7igvVMSc3YZfm0inRat19NlFYAacG4JALdgL/6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778879720; c=relaxed/simple;
	bh=Zcwz++VNrXh9y6soBYCC7hxdmV5RO3C0KhJ6H3w36Z4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IwhSXwa6UekuEqDk09j9LL/7TnSH4IMedKgx2olbsQ6HNzhxRxGo9zkidAK9b/HgrPD4G0gb8v1S5wGKn548kM4UxJBvksJ2ZOaSnQFOF0Wi2jlZmFnvzC5cefK1Pt5UgB19C7rKpYLAZcm67ggIsZBf6AqKPklt4cxWlXFY6k8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pS456OJH; arc=none smtp.client-ip=74.125.82.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-2f0d3e07e30so1352960eec.0
        for <linux-integrity@vger.kernel.org>; Fri, 15 May 2026 14:15:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778879718; x=1779484518; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h8RkPwRSQGNgtwFGhMa45mhqNtBX9nLmlB3IzWi1i0E=;
        b=pS456OJH1AEeHSLqDqw4ui/jbQksci7GOMA5UlZbGUKa3b3cKwqxQ6MWm5xwlX57PI
         IZDJIMG8QqVi0ayPNo4/ypRXZdgRlhu+XjkAk73EqC7nB0IRpSRqGXxoy8vQd8Bgt0CQ
         WzXiDAw6KrRaOGBb/z0v7a61im0dlEScKq/wb4E9/cTIbcx67pmRYk290CD9S+K1KRL/
         l6Fry/b26nnViZfxl9z6fED8dgvP5m7O9o1LjTQeMg92Ky/sK7+4svsAdj3UWxQlrHwX
         SF0UYmimTDOTR1kBR9t4IKWksrJIgXR9XanS7ZoycxoKXpmFEuhgVKLoq5LCGKnBYZTA
         SWvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778879718; x=1779484518;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=h8RkPwRSQGNgtwFGhMa45mhqNtBX9nLmlB3IzWi1i0E=;
        b=TWSMjI3S60SO7ickvB3i8c/Q1U99vUyEYqODJ71W4Uu1Xb0ScK/sr+3dm8C/6k5AtZ
         Z1YyROBJrrVvOtucTI9f45iVwiAShLTU0cglFGUItRl9g3hr8DHve1a2EAhX9SvDrBM6
         cHxk8YAK/tA0ff1X3N5LBHY9g3drmYgIwmlDaPOSv+WfFfoTRc8kgnNgRobBvy7hMYFM
         OH49cEE3q+wF7NWUIXyF4r15m2cy1z2lIg0bJJLqdxBBQBDLXYjbYJQZB1pHRLMa3Ylo
         flJQxzp6ZSagjHxcuIAN2WcTWdSS8rbw9/n23VdcW4MmUrXhIQo6j5T3t+lm+MCnf1F8
         D4Ag==
X-Forwarded-Encrypted: i=1; AFNElJ/bynTUC6Z1COkoH8vuzBShQAb4zFcTUHsHFGy/rowCyQgxy4/aHJYXsZytW6M5Z9/7i/g7OVmSpA1KZrZUyjk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIyrZSgS6vYhvLpt7yW7TW1/G5qbjlrYw5ctl+0Gwvke8DS9gG
	4ZjAQTw7zdXbQUvjPO9poKXKaH7jFl1TXds0wSDdbqPUWdxY6gvjw2Fd
X-Gm-Gg: Acq92OHZdFs3Vd3TwysoTfOuBR4tyB93gUd8I84pRcoAJu0epnGJ81jBw5N6ZGpKZ+j
	Yyl6a1XpD8xr2CySAkFYOB5byEzZVwy7Pl+zxco7unrKo6h8gdXErFfbUKHRd9ICsywJCCU/WhV
	qg31pij1+TImpILfpEmwOr67RoqqELvgNnRSdXdZYdJoGB4l+YaRuMSDgYqx08rZEBkbT2rYTSI
	Htg++gBCUdxuQywnYPsL6o0qiR+R1TxG9ozbJY8hxYuA0ry0i+Ni/4hQohv75h4w78MfcLzkPK5
	V81TF3lqPGa+4dneCKEQx8TldTlVdoPSBpjNXUjpKMdRONwi6g6aAQ+qvG6/YvfWqZHjo+p3Zx/
	e1VjMhhgSD8UJU5K+9Qi/E4hAUvhIPMvjLC6lBVhbUJ0ORnnLH1209LnrxW2CDD+idz7sV0NvSi
	P34njsY8eA/080ftqO/TXyUHFvethaGfo=
X-Received: by 2002:a05:7300:ad30:b0:2e7:5737:8364 with SMTP id 5a478bee46e88-303984e17ffmr3028118eec.15.1778879717789;
        Fri, 15 May 2026 14:15:17 -0700 (PDT)
Received: from mimas.lan ([2603:8000:df01:38f7:a6bb:6dff:fecf:e71a])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-302947e917dsm8005268eec.12.2026.05.15.14.15.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 14:15:17 -0700 (PDT)
From: Ross Philipson <ross.philipson@gmail.com>
To: linux-kernel@vger.kernel.org,
	x86@kernel.org,
	linux-integrity@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	kexec@lists.infradead.org,
	linux-efi@vger.kernel.org,
	iommu@lists.linux.dev
Cc: ross.philipson@gmail.com,
	dpsmith@apertussolutions.com,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	hpa@zytor.com,
	dave.hansen@linux.intel.com,
	ardb@kernel.org,
	mjg59@srcf.ucam.org,
	James.Bottomley@hansenpartnership.com,
	peterhuewe@gmx.de,
	jarkko@kernel.org,
	jgg@ziepe.ca,
	luto@amacapital.net,
	nivedita@alum.mit.edu,
	herbert@gondor.apana.org.au,
	davem@davemloft.net,
	corbet@lwn.net,
	ebiederm@xmission.com,
	dwmw2@infradead.org,
	baolu.lu@linux.intel.com,
	kanth.ghatraju@oracle.com,
	daniel.kiper@oracle.com,
	andrew.cooper3@citrix.com,
	trenchboot-devel@googlegroups.com
Subject: [PATCH v16 23/38] x86: Allow WARN_trap() macro to be included in pre-boot environments
Date: Fri, 15 May 2026 14:13:55 -0700
Message-ID: <20260515211410.31440-24-ross.philipson@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260515211410.31440-1-ross.philipson@gmail.com>
References: <20260515211410.31440-1-ross.philipson@gmail.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 06CE4557E15
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9558-lists,linux-integrity=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,apertussolutions.com,linutronix.de,redhat.com,alien8.de,zytor.com,linux.intel.com,kernel.org,srcf.ucam.org,hansenpartnership.com,gmx.de,ziepe.ca,amacapital.net,alum.mit.edu,gondor.apana.org.au,davemloft.net,lwn.net,xmission.com,infradead.org,oracle.com,citrix.com,googlegroups.com];
	RCPT_COUNT_TWELVE(0.00)[33];
	FROM_NEQ_ENVFROM(0.00)[rossphilipson@gmail.com,linux-integrity@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[linux-integrity];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,infradead.org:email]
X-Rspamd-Action: no action

For pre-boot environments, do not use the static call definition of the
WARN_trap() macro.

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Ross Philipson <ross.philipson@gmail.com>
---
 arch/x86/include/asm/bug.h | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/bug.h b/arch/x86/include/asm/bug.h
index 80c1696d8d59..7899768ae644 100644
--- a/arch/x86/include/asm/bug.h
+++ b/arch/x86/include/asm/bug.h
@@ -138,8 +138,14 @@ do {									\
 #ifdef HAVE_ARCH_BUG_FORMAT_ARGS
 
 #ifndef __ASSEMBLER__
+
+#ifndef __DISABLE_EXPORTS
 #include <linux/static_call_types.h>
 DECLARE_STATIC_CALL(WARN_trap, __WARN_trap);
+#define WARN_trap(...)	static_call_mod(WARN_trap)(__VA_ARGS__)
+#else /* __DISABLE_EXPORTS */
+#define WARN_trap(...)	__WARN_trap(__VA_ARGS__)
+#endif /* __DISABLE_EXPORTS */
 
 struct pt_regs;
 struct sysv_va_list { /* from AMD64 System V ABI */
@@ -172,7 +178,7 @@ extern void *__warn_args(struct arch_va_list *args, struct pt_regs *regs);
 #define __WARN_print_arg(flags, format, arg...)				\
 do {									\
 	int __flags = (flags) | BUGFLAG_WARNING | BUGFLAG_ARGS ;	\
-	static_call_mod(WARN_trap)(__WARN_bug_entry(__flags, format), ## arg); \
+	WARN_trap(__WARN_bug_entry(__flags, format), ## arg);		\
 	asm (""); /* inhibit tail-call optimization */			\
 } while (0)
 
-- 
2.47.3


