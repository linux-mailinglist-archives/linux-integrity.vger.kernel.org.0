Return-Path: <linux-integrity+bounces-9553-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SEXWIwWPB2oe8wIAu9opvQ
	(envelope-from <linux-integrity+bounces-9553-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Fri, 15 May 2026 23:24:21 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 96BA5557F82
	for <lists+linux-integrity@lfdr.de>; Fri, 15 May 2026 23:24:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1BC0330166A2
	for <lists+linux-integrity@lfdr.de>; Fri, 15 May 2026 21:16:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95AFA40312C;
	Fri, 15 May 2026 21:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s9V33mfU"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0F253ED5B8
	for <linux-integrity@vger.kernel.org>; Fri, 15 May 2026 21:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778879706; cv=none; b=btzrQUBb/xNUchDPuYWpdp9KYgfJfQ78hx501jt/9R69z1pwfwPb3VddWh1qYyPbYAAZQ4OjrV6ALeSLdc6OBFsI96yinY7Myd24FYXEg0BmAfS4vZRk9e3dKL4Qm3P/Hx9wkpy+XJjjc9VYpm0iTh9hl/V6e837l8gpIqAyMhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778879706; c=relaxed/simple;
	bh=qtwiEWwByfHHxjTrlTyTKX/7jH6vLFs54iG3FoiDWyY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KG6O350MNDk2K1M/4Gw2qs92PIUvaUb9HLuMIqOn+IxXMoe0A3otvbVa4DYa6mtkrJ3fGOHyJR1Nf4zlZWX/eJRVWAMOuDx8gk7g7eAiqp19fCzHnz7AmFsUxlHGg0U3VSQtny5hfq7f33BWRZKnyzlddGjeU/oSQ1gMgnrv0mQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=s9V33mfU; arc=none smtp.client-ip=74.125.82.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-1329fc4bf77so361555c88.1
        for <linux-integrity@vger.kernel.org>; Fri, 15 May 2026 14:15:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778879704; x=1779484504; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=azOcaoqgBG4GOjXSMRG7UYVXI2K8VE7Oo8FvV1FqK6Y=;
        b=s9V33mfUWQSz9b71/QS4bizbbARZHMDNvH7LsGEPdS45xkCfL7xQwNunkkk5UbevFy
         w0xSUPPpNM6DkKIOd8ilLXHV6pV05emWyPPWFgqfn9kayoO8I56TjLnTQkA83RLVQort
         j3HRyLu0UnCxhI9MZTxUqlGCDn49YnoTpH+Vqlwk9N40NWTRpfCfLfKeRrdYlaes3gpg
         yuziZP3k99tvGWE9sgFtiQ24002qiDICOLKL1JqwUpsBbLdAm5ybiYLaAYzWLrd9GBNt
         fY1FVQCWMDnCoY4L+hfoMxL2Tdsqm96Us8LZih0uGUthsPQYzPfDuEnCoG59+ipp3xMP
         vflA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778879704; x=1779484504;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=azOcaoqgBG4GOjXSMRG7UYVXI2K8VE7Oo8FvV1FqK6Y=;
        b=Jbb6SrpBaA0Pg4CElEJsxDR986XyP90KqaOxWmY3vftHp0qBKmThVBDjOmjuQcs8v1
         aYuL7K9eXNdvl7/8ySipYlu6Hhge3vwiyaLhKlAw1aujWoEyTvL07IZ0HTyBl9mE561N
         ttNovpysnOKRBepZSCGhj6fbvVl0QIFVXHiABvg3a9gdVRDDS4fhEB9xnSy+yKBntDwE
         IGjkavfGVRkMvlU+l8+XlDgjZU/DQ3/8uV/Tk56CLReVNypdBTO84Uec3y+Sa2xAaJeY
         711E4kHmGiFSDq3/cWOs4htSkjNuou8XIhoAxKU8cqzNfocrN7/zSv2jkDonWzUwYXcr
         +OMw==
X-Forwarded-Encrypted: i=1; AFNElJ/Btz4bCc+lO1ZKh5QQ4A8G6cgiiZfr1tT8w/QdiImagghuJiTTgBNoSsBURAv/BPf05qmm9mECXgpT8qMsqrY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyWLEF9ShSIVazTGxPRnA/MoQqwakBMiDZLOgt7mLLlwKzAfwR
	23/bLJq8jCuka5QmErdVxvrFmCRT0F9bRKLOrJZ2NW5L+sn5gzWP6C9o
X-Gm-Gg: Acq92OEWxf8N0HMsc1caWex5xOiS1BYGLxQtvdPg6mhrvBU3IkLDDT5ZV7C3rDGUFkb
	a9rWkiRLVbXK1f4WrzUuiQN7d0rt3hWuG5RL/DpxrEezwf4eqU/orQvABwLsKTp90trDdILm0hR
	l8Cs1ZCXklDfrQF0DN9FWmV3OEK7gz9Zby0Yr0Rq2BLhFbSAA0TkTPXtP+QukjClJLZr6/pkJKJ
	SNTjPxQHK34J00CEqvcpOhkWT0jVOSIHVnNHSLKbRQxPCKlbRB74DSfsx4Cfg5m2zB7cmYCisZs
	rTYvETtvXZhool8iuXvZsCIHwUv9fMz7Y3UdFtp/sJ1xXC3ng+Lx2E38BD8FTICp+/eFP/DZ0vF
	KCFiKeobMGrnRkh+Gh3RmoqoS0CxGsDuR6JR7vWf48foJaqke8depU9siu4q4NNrEcNhsU+gvvc
	2HusFj947sGC9Tgky64EO1Mw2ootgt1nk=
X-Received: by 2002:a05:7022:239d:b0:133:598c:2b45 with SMTP id a92af1059eb24-1350494e3f6mr2888720c88.31.1778879703912;
        Fri, 15 May 2026 14:15:03 -0700 (PDT)
Received: from mimas.lan ([2603:8000:df01:38f7:a6bb:6dff:fecf:e71a])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-134cc3490bcsm9740638c88.15.2026.05.15.14.15.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 14:15:03 -0700 (PDT)
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
Subject: [PATCH v16 18/38] x86/efi: Secure Launch Resource Table EFI definitions header file
Date: Fri, 15 May 2026 14:13:50 -0700
Message-ID: <20260515211410.31440-19-ross.philipson@gmail.com>
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
X-Rspamd-Queue-Id: 96BA5557F82
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9553-lists,linux-integrity=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Action: no action

The Secure Launch EFI definitions are contained in the Secure Launch
Specification. The definitions are split out into a separate header
file for compilation purposes for EFI vs non-EFI environments in the
kernel.

The specification can be found here:
https://github.com/TrenchBoot/documentation/blob/master/specifications/secure-launch-specification.rst

Co-developed-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Ross Philipson <ross.philipson@gmail.com>
---
 include/linux/slr_efi.h | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)
 create mode 100644 include/linux/slr_efi.h

diff --git a/include/linux/slr_efi.h b/include/linux/slr_efi.h
new file mode 100644
index 000000000000..5de87a9b38aa
--- /dev/null
+++ b/include/linux/slr_efi.h
@@ -0,0 +1,40 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * EFI Definitions for Secure Launch Resource Table
+ *
+ * See TrenchBoot Secure Launch kernel documentation for details.
+ *
+ * Copyright (c) 2026 Apertus Solutions, LLC
+ * Copyright (c) 2026, Oracle and/or its affiliates.
+ */
+
+#ifndef _LINUX_SLR_EFI_H
+#define _LINUX_SLR_EFI_H
+
+#include <linux/slr_table.h>
+
+#ifndef __ASSEMBLER__
+
+/* EFI Support */
+
+/* SLR table GUID for registering as an EFI Configuration Table (put this in efi.h if it becomes a standard) */
+#define SLR_TABLE_GUID			EFI_GUID(0x877a9b2a, 0x0385, 0x45d1, 0xa0, 0x34, 0x9d, 0xac, 0x9c, 0x9e, 0x56, 0x5f)
+
+/* Secure Launch EFI runtime protocol */
+#define EFI_SLAUNCH_PROTOCOL_GUID	EFI_GUID(0x534189e0, 0x6fde, 0x413d,  0xbe, 0x91, 0xcd, 0x4e, 0x8d, 0x67, 0x2f, 0xea)
+
+struct efi_slaunch_protocol {
+	efi_status_t
+	(__efiapi *setup_dlme)(struct efi_slaunch_protocol *this,
+			       u64 dlme_base,
+			       u64 dlme_header_offset,
+			       u64 dlme_table);
+
+	efi_status_t
+	(__efiapi *launch)(struct efi_slaunch_protocol *this);
+};
+typedef struct efi_slaunch_protocol efi_slaunch_protocol_t;
+
+#endif /* !__ASSEMBLER__ */
+
+#endif /* _LINUX_SLR_EFI_H */
-- 
2.47.3


