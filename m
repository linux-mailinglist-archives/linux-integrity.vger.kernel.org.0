Return-Path: <linux-integrity+bounces-9563-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gGZ7GyKPB2oe8wIAu9opvQ
	(envelope-from <linux-integrity+bounces-9563-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Fri, 15 May 2026 23:24:50 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F9D7557FD6
	for <lists+linux-integrity@lfdr.de>; Fri, 15 May 2026 23:24:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 135A4304DE90
	for <lists+linux-integrity@lfdr.de>; Fri, 15 May 2026 21:18:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 984103EDAAE;
	Fri, 15 May 2026 21:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IYL3YWM0"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB90C4048AE
	for <linux-integrity@vger.kernel.org>; Fri, 15 May 2026 21:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778879734; cv=none; b=kW5jEEjKiMrXasbkCRyQzC2uRveDeTLoyMEJZEmr1dNCGAcWwQ8y5V7IgnJs26HqWw2h9ReirGEgcAtG8eIppAj38YhiSpdn39l/OLLD7JQcZpKgw02Rq1ud8Z+JeyioVsEK3pEH4QLAEU3ZTVqM+iDBJlilBGfFWHMpGRT1vhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778879734; c=relaxed/simple;
	bh=ILT1qaKW78nRQkC/CMCLSzr2h8dTPOcGoDMHkPnSKzE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z9OyhjR63ixrI5ybHRrtV0Ggo9oh5A5dMo2O4d7TF8rkhfFqJMURybQ9Y/Ym0pQVnUhT380FJjQ1vo0NoHGTU+mdrONsL+q5KicYxCwGuE3XRcNRtTr6dhWoKPuCv+eONr6jRQMKGfZNipJtgzROeuaOiiyHhRBL7RA+ZBAY+Fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IYL3YWM0; arc=none smtp.client-ip=74.125.82.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-12c1a170a50so288792c88.0
        for <linux-integrity@vger.kernel.org>; Fri, 15 May 2026 14:15:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778879732; x=1779484532; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aF0BH6dZpM5RACWLo6N4NcvxHw87HpE9a7jatFY2Xnk=;
        b=IYL3YWM0K72+PKBjUIotlkyudmp1jTzkcWSk+FsrFVXzSnegkXpcBDTHvkmgtyv013
         1Fz+1cDxxzxpwH2cjTMD3XcK8OrL3KyPSBFqH8USMoVoBphH/PDfMppdjjf5WM9Uu+zw
         zdblTDDlg3ILJFwS88bKz+DpkkC4R874roDAz+B70ThKNQTz3lnAY6Vm18brrdmeKYlL
         nrRDow22yM9/5xyVwtbnB/WqwizcqZ8UTLFg96EIfVlIoQZejH3ZXpbdDCcTFwuaBYDe
         SBIe7CCRHOt+kHRuouqHqrJpRS0HE1SBm0toraK+5jwMRSnRo9h+dKmUj5IEOAw9IoLh
         DUQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778879732; x=1779484532;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aF0BH6dZpM5RACWLo6N4NcvxHw87HpE9a7jatFY2Xnk=;
        b=WFdQY2W/0tL58ZjoDNOLcfLUD2z4Eo9BgLQlGnhy9YLlpcp5hxmIG6KbpP2dV/yM5Z
         PiWeHVPmweCRSIB22Vwc8akBTLekJ6ELsqvlXCnSnm5feb06R093tb1HDAEifE+rr9BW
         Lkm+VP69USY3qJP/5HugvHDjXeh8Os3qdMRmvmc7OTouT/tbFtTUIu6nXkW567ECJ19D
         jZro6BRNrXvzgdHDMhd7kmIeP+rjECcnDdwXDlNZ6JWVwNCroLSjnCUalAiCf9BKac9o
         pIJVF40Wj77UY1WpYuJnGpBVyRmivLFtGodPFgekDlS9U7iSpkbhiMVQxP9Fsayv2oXn
         lb6g==
X-Forwarded-Encrypted: i=1; AFNElJ9N+egGIKiWFFhw21CvIi6TBPfVZbnBA0pvLG2kwNnxbvOpaEXbjynRipKgifiPFaMfe9N+EDRgtL6ZSYpsUTQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsIDRYqec1f/txzOIF7cXlejA4iGT980tdfbwI6JV8Bx2L5+O2
	YuuFhB9klL4/Olh/Ll3lGrWhO8lsxgJQ9hYYjQMyxzuv5mtJbC9mY26/
X-Gm-Gg: Acq92OGfJWMECwv2sT6AdT9yWQYAkGNBCEltdicYiJKL573XoWErdeksn0oPllc/WNx
	8j5tzIsMsGnqGsKXwN6TG3tKgeu7w9qBBQsZrv8g3uxxAEDMh9gku3EEMz3cVd8MnfFNdytgb7o
	oDBgRpB7LstX29o+9oL9v0wiekvXXllUqii/07QuB575dwmrsJgQaBgQs/IlNhes9KYupGMmsXm
	tEoKBdcEMiAaDPBTGH7SM1LfzEAD0SlzAutRiP3DaoejOfMmnXberNv6Y254etY+kBNb64LSsA9
	vwrZeudEqjG6eDSQjvLPtqtaAZQH7wVHmBVHMVoKEuotaYxHXty7rVMqe4gq0vSZKsCOdNk0m2n
	CBoQ0E9dtDoXsxJkrWQE07J2wjzbQnlcnZV8fRyK+vYs23xaQm50qPvruLZWhzEPGAF3dDmjGOL
	70t3IDlKs7hp6Ay/bNuzi+QY4W7nSObzwqPZkq/+PBDg==
X-Received: by 2002:a05:7022:6621:b0:134:a710:d908 with SMTP id a92af1059eb24-1350451887emr2398095c88.13.1778879732067;
        Fri, 15 May 2026 14:15:32 -0700 (PDT)
Received: from mimas.lan ([2603:8000:df01:38f7:a6bb:6dff:fecf:e71a])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-134cc33a618sm11245224c88.12.2026.05.15.14.15.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 14:15:31 -0700 (PDT)
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
Subject: [PATCH v16 28/38] x86: Add early SHA-384/512 support for Secure Launch early measurements
Date: Fri, 15 May 2026 14:14:00 -0700
Message-ID: <20260515211410.31440-29-ross.philipson@gmail.com>
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
X-Rspamd-Queue-Id: 0F9D7557FD6
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9563-lists,linux-integrity=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[apertussolutions.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

From: "Daniel P. Smith" <dpsmith@apertussolutions.com>

On newer TPM 2 implementations, SHA 384 and 512 banks may be available
for use. If these banks are enabled in firmware, they will be used for
the Dynamic Launch. The DLME will also use these algorithms to measure
configuration information into the TPM as early as possible before using
the values. This implementation uses the established approach of #including
the SHA-512 library directly in the early boot code.

Signed-off-by: Daniel P. Smith <dpsmith@apertussolutions.com>
Signed-off-by: Ross Philipson <ross.philipson@gmail.com>
---
 arch/x86/boot/startup/Makefile     | 1 +
 arch/x86/boot/startup/lib-sha512.c | 6 ++++++
 2 files changed, 7 insertions(+)
 create mode 100644 arch/x86/boot/startup/lib-sha512.c

diff --git a/arch/x86/boot/startup/Makefile b/arch/x86/boot/startup/Makefile
index 071a90f23ae0..527cba7e4560 100644
--- a/arch/x86/boot/startup/Makefile
+++ b/arch/x86/boot/startup/Makefile
@@ -23,6 +23,7 @@ obj-$(CONFIG_AMD_MEM_ENCRYPT)	+= sme.o sev-startup.o
 
 slaunch-objs			+= lib-sha1.o
 slaunch-objs			+= lib-sha256.o
+slaunch-objs			+= lib-sha512.o
 obj-$(CONFIG_SECURE_LAUNCH)	+= $(slaunch-objs)
 
 pi-objs				:= $(patsubst %.o,$(obj)/%.o,$(obj-y))
diff --git a/arch/x86/boot/startup/lib-sha512.c b/arch/x86/boot/startup/lib-sha512.c
new file mode 100644
index 000000000000..2afd5c5935cd
--- /dev/null
+++ b/arch/x86/boot/startup/lib-sha512.c
@@ -0,0 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2026 Apertus Solutions, LLC
+ */
+
+#include "../../../../lib/crypto/sha512.c"
-- 
2.47.3


