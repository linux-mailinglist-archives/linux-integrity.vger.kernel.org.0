Return-Path: <linux-integrity+bounces-9893-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ZcGfFtgfTWr6vQEAu9opvQ
	(envelope-from <linux-integrity+bounces-9893-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Tue, 07 Jul 2026 17:48:40 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A780B71D7B6
	for <lists+linux-integrity@lfdr.de>; Tue, 07 Jul 2026 17:48:39 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=suse.com header.s=google header.b=Sp9zBXEN;
	dmarc=pass (policy=quarantine) header.from=suse.com;
	spf=pass (mail.lfdr.de: domain of "linux-integrity+bounces-9893-lists+linux-integrity=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-integrity+bounces-9893-lists+linux-integrity=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 766F631E52D1
	for <lists+linux-integrity@lfdr.de>; Tue,  7 Jul 2026 15:38:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FE92430CC3;
	Tue,  7 Jul 2026 15:38:51 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70FEA414A05
	for <linux-integrity@vger.kernel.org>; Tue,  7 Jul 2026 15:38:48 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783438731; cv=none; b=QjhskI1/WUqjQF17wL5A8STsNgUwRGRlAFKfQ4uO6q0ofTkVBi7vVVn9aw033EaMIlXRrLUDgUPeX6bWN683wQXi83ZmAIyHhsPNH4x5zQnGthzPwPYQKPdGavbyRgzQZqw7RKiArJyP2J79F9P0Lxn1sPJLChjnt2nepTurE1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783438731; c=relaxed/simple;
	bh=SO5eeYPZCjDEPtTUp5vp0e259QcOYfs80Q/ywveYhqA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f7tzPmW+d02nwacpBjZfRWVoc2JrXD8v3mUMbNBw++Uvbz55RY0E1Rvi1DPSyBId1cNQFXZI+qJ5QxDmRhEw4JilMpJkjGBjHpTmaT2jUsdRE21rr8MaxKzzxwPN78mFgSUfMpr+wjDE+bcBhtyNl4z1Ok3e2yeDULia08q7DmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Sp9zBXEN; arc=none smtp.client-ip=209.85.128.43
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-493b966dd74so15256535e9.3
        for <linux-integrity@vger.kernel.org>; Tue, 07 Jul 2026 08:38:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1783438727; x=1784043527; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3FzCn0X+c0BW10b/0YxzB57zNLgSGohyBE3JQzpVoRI=;
        b=Sp9zBXENbXVuk4pLgRwA07DY1fA0U6i0d3KsNaU72qPMjeU2lUQT22MYYNGI4URgSm
         nY81jVo81RLZKV+DKwjmqbLwJmsvYBVbeVme/Y8/1KVyMcWs6C/v4AaybK5TZTnTs8N3
         gjFrmikadN4ppXMuG830cLNTF4XyPPjyWCqWfKWAo5+YfRtnPzn+aySjEZX4ue4xHIoP
         nl2EXqQRhZvTM0XgjwtH2TwRTkJOPMlz5XyoV0gTsK4SPgIEFlLvRvQ72bttphGenVmN
         YLjEDYih/ME9p7n04hcodUY9XKoptFyC7Y8iiVvkZlS0WZlJSxJIzrNaQZXcHr4X7ke+
         m+Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783438727; x=1784043527;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3FzCn0X+c0BW10b/0YxzB57zNLgSGohyBE3JQzpVoRI=;
        b=NdTuolnbrwM2VSZ6AC10nkV+yG+/Doa18vzL5a+S52rohFNUH5mYlzFdOqcUBiKaCi
         C1g7euk/PeJX/Jk5EamqkUnb0qS80WLu/qrVsc1TuAHL68pHwpIR4g2w4ZlTaTbjAbFM
         ESJVR6AMulYb4Bfp9s6KLBk3iNHmxFA6jkgLDa1/Zm3rOJPDjJFT75BzWTzZY4X6MAub
         7iRWheTL+JV9T+kc8YDrSeNyQD8jdPqcAc8tRRarkkpssFncnR9BURWL0fWNvgeNVOop
         IEgIkhASOY3FNqwE1GeCHaQEyAYOoTL7inoIMCzok0/GXDPD6RHvzoLK/cKoV1nzhbjr
         gOsw==
X-Forwarded-Encrypted: i=1; AHgh+RrBvi7unnaViZv0FC7i5X835mT36j/At7Ebp/JrcAjKuTxG6m98MeTOzpNaOWVmQFhCmoWlpC7uDwKfiU7yj8I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCZkYDiCqv2aSsFAcDSjetrtW34t4x+PCi8kiIAkQqfBfrVN0A
	Eg5QjIuue61Z2S7DkqLz8ASBLgT2HZw2hE/leNhEZ0ZbvecYHPnDt/CfAB+Lner1IFA=
X-Gm-Gg: AfdE7ckzaIbccXbSw4QdHIyORZNaQghaPVYXG0qcKsG9gcQL5i6I1SZ1DrZIcXsyIJN
	GN8X3cSXK85czXgk2LOVtHuVk4LDLIaxOG8q8TcoYTbqCF/17fK4d+1rbhdusAPZbCTqrOob/sT
	haUuViC02cx2ZKV4HNcPi3vWJsT9CUSPo8WrTYJ9XCZeXMNlxpv69/RjgK7uyzr+1yh4awQ/1Rv
	1pPD5nMIdiCL9UpRqQMnhcoAROKXYE6/MNVVwyvHPCOGdYxbEkQst+3Ixppstm5hVEb2085+dZR
	LvZTu5i4ry71xUSIPft72u4hhJrNrWyc0O6LaO2BwLmsA7L1K7LsUyrQRHydy4hEx+2pi3TB3bJ
	Q4Zw0UvyU29jpZwBVIiyKiuhpZXRuGePoQa4VtoVB7d8c5phnr/vv8ckuvsEXS4P4Vo0A37OH70
	+LNFMV0D3aFzk5J03fVADsz88RxlwT2eHf/itqTyp0ZYusOqgZaWwZyx6b3VjOT4eoAOWbCbwZ5
	NUfPUVHVOy7og==
X-Received: by 2002:a05:600c:810b:b0:492:67df:3dfa with SMTP id 5b1f17b1804b1-493df080788mr55474505e9.34.1783438726830;
        Tue, 07 Jul 2026 08:38:46 -0700 (PDT)
Received: from zovi.suse.cz (dynamic-2a00-1028-838d-271e-8e3b-4aff-fe4c-a100.ipv6.o2.cz. [2a00:1028:838d:271e:8e3b:4aff:fe4c:a100])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493e0f5b811sm101111785e9.13.2026.07.07.08.38.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 08:38:46 -0700 (PDT)
From: Petr Pavlu <petr.pavlu@suse.com>
To: Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Peter Huewe <peterhuewe@gmx.de>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Daniel Gomez <da.gomez@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>
Cc: Xin Li <xin@zytor.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Andy Lutomirski <luto@kernel.org>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Janosch Frank <frankja@linux.ibm.com>,
	Claudio Imbrenda <imbrenda@linux.ibm.com>,
	David Hildenbrand <david@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Aaron Tomlin <atomlin@atomlin.com>,
	linux-s390@vger.kernel.org,
	kvm@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	linux-modules@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] x86: Avoid indirect includes through linux/module.h -> linux/elf.h
Date: Tue,  7 Jul 2026 17:37:04 +0200
Message-ID: <20260707153819.4172541-2-petr.pavlu@suse.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260707153819.4172541-1-petr.pavlu@suse.com>
References: <20260707153819.4172541-1-petr.pavlu@suse.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[29];
	TAGGED_FROM(0.00)[bounces-9893-lists,linux-integrity=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:tglx@kernel.org,m:mingo@redhat.com,m:bp@alien8.de,m:dave.hansen@linux.intel.com,m:x86@kernel.org,m:hca@linux.ibm.com,m:gor@linux.ibm.com,m:agordeev@linux.ibm.com,m:peterhuewe@gmx.de,m:jarkko@kernel.org,m:mcgrof@kernel.org,m:petr.pavlu@suse.com,m:da.gomez@kernel.org,m:samitolvanen@google.com,m:xin@zytor.com,m:hpa@zytor.com,m:luto@kernel.org,m:borntraeger@linux.ibm.com,m:svens@linux.ibm.com,m:frankja@linux.ibm.com,m:imbrenda@linux.ibm.com,m:david@kernel.org,m:jgg@ziepe.ca,m:atomlin@atomlin.com,m:linux-s390@vger.kernel.org,m:kvm@vger.kernel.org,m:linux-integrity@vger.kernel.org,m:linux-modules@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[petr.pavlu@suse.com,linux-integrity@vger.kernel.org];
	FREEMAIL_TO(0.00)[kernel.org,redhat.com,alien8.de,linux.intel.com,linux.ibm.com,gmx.de,suse.com,google.com];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[petr.pavlu@suse.com,linux-integrity@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-integrity];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.com:from_mime,suse.com:email,suse.com:mid,suse.com:dkim,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A780B71D7B6

Several x86 files use ELF-related declarations and currently rely on them
being provided indirectly through linux/module.h -> linux/elf.h:

* arch/x86/entry/entry_fred.c: ia32_enabled() -> asm/ia32.h,
* arch/x86/entry/syscall_32.c: vdso32_image -> asm/vdso.h,
* arch/x86/kernel/cpu/intel.c: ELF_HWCAP2 -> asm/elf.h,
* arch/x86/kernel/fpu/xstate.c: elf_coredump_extra_notes_write(),
  elf_coredump_extra_notes_size(), NT_X86_XSAVE_LAYOUT, elf_note ->
  linux/elf.h,
* arch/x86/kernel/process.c: mmap_is_ia32() -> asm/elf.h,
* arch/x86/kernel/signal.c: get_sigframe_size() -> asm/elf.h.

Add the missing includes to these files in preparation for removing the
linux/elf.h include from linux/module.h.

Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
---
 arch/x86/entry/entry_fred.c  | 1 +
 arch/x86/entry/syscall_32.c  | 1 +
 arch/x86/kernel/cpu/intel.c  | 1 +
 arch/x86/kernel/fpu/xstate.c | 2 +-
 arch/x86/kernel/process.c    | 1 +
 arch/x86/kernel/signal.c     | 1 +
 6 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/x86/entry/entry_fred.c b/arch/x86/entry/entry_fred.c
index fb3594ddf731..ea3bb4298065 100644
--- a/arch/x86/entry/entry_fred.c
+++ b/arch/x86/entry/entry_fred.c
@@ -9,6 +9,7 @@
 
 #include <asm/desc.h>
 #include <asm/fred.h>
+#include <asm/ia32.h>
 #include <asm/idtentry.h>
 #include <asm/syscall.h>
 #include <asm/trapnr.h>
diff --git a/arch/x86/entry/syscall_32.c b/arch/x86/entry/syscall_32.c
index 31b9492fe851..12fceffc99ef 100644
--- a/arch/x86/entry/syscall_32.c
+++ b/arch/x86/entry/syscall_32.c
@@ -12,6 +12,7 @@
 #include <asm/traps.h>
 #include <asm/cpufeature.h>
 #include <asm/syscall.h>
+#include <asm/vdso.h>
 
 #ifdef CONFIG_IA32_EMULATION
 #define __SYSCALL_WITH_COMPAT(nr, native, compat)	__SYSCALL(nr, compat)
diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index abb3984336eb..18cf40f08557 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -17,6 +17,7 @@
 #include <asm/cpufeature.h>
 #include <asm/cpu.h>
 #include <asm/cpuid/api.h>
+#include <asm/elf.h>
 #include <asm/hwcap2.h>
 #include <asm/intel-family.h>
 #include <asm/microcode.h>
diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index a7b6524a9dea..8b90bf86a742 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -7,6 +7,7 @@
 #include <linux/bitops.h>
 #include <linux/compat.h>
 #include <linux/cpu.h>
+#include <linux/elf.h>
 #include <linux/mman.h>
 #include <linux/kvm_types.h>
 #include <linux/nospec.h>
@@ -26,7 +27,6 @@
 #include <asm/msr.h>
 #include <asm/tlbflush.h>
 #include <asm/prctl.h>
-#include <asm/elf.h>
 
 #include <uapi/asm/elf.h>
 
diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index 85435044e33c..e40f7f3d3489 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -54,6 +54,7 @@
 #include <asm/mmu_context.h>
 #include <asm/msr.h>
 #include <asm/shstk.h>
+#include <asm/elf.h>
 
 #include "process.h"
 
diff --git a/arch/x86/kernel/signal.c b/arch/x86/kernel/signal.c
index 2404233336ab..0fe2d7a6b1af 100644
--- a/arch/x86/kernel/signal.c
+++ b/arch/x86/kernel/signal.c
@@ -29,6 +29,7 @@
 #include <linux/syscalls.h>
 #include <linux/rseq.h>
 
+#include <asm/elf.h>
 #include <asm/processor.h>
 #include <asm/ucontext.h>
 #include <asm/fpu/signal.h>
-- 
2.54.0


