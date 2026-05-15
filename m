Return-Path: <linux-integrity+bounces-9561-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kBwfKs2QB2oW9AIAu9opvQ
	(envelope-from <linux-integrity+bounces-9561-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Fri, 15 May 2026 23:31:57 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id B485055829B
	for <lists+linux-integrity@lfdr.de>; Fri, 15 May 2026 23:31:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 14B3A305E49E
	for <lists+linux-integrity@lfdr.de>; Fri, 15 May 2026 21:17:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEA394C6F1E;
	Fri, 15 May 2026 21:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mLG862k+"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E7D9413D66
	for <linux-integrity@vger.kernel.org>; Fri, 15 May 2026 21:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778879728; cv=none; b=hA0pfMjTntl4Km91AUHKJM05+7hS3LKy71P0r3ad/kVGTpgLNhAXPttCmeSTd8mKexmpjZQs3ggGBgWpFeqU+phKpnVgyvdHX1sptFdWbNS6HiHdoEnq0Pr8f0II4/Hqy93OHKbPBL+31cCqNIT2ocFztr6idN90gTVf8e9tDYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778879728; c=relaxed/simple;
	bh=ws7RALHIgZvmMfHxpeYb691c/xou17qPzYNIPgpKvkw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ewvaPHIQkMMYry01zkysQki92pTQfASN3+9t/+PkBZKK/MrOVHoYm7Kx5o1vbKFUguP0ZzkGveh/VWTMWSv56On0l3xvIPDZeNKV/0/EFfVaXIMClIo3qqDB0OMayOMTeBLygXUymjTcBaj59BeKsQBOfubelOMh3yx92oIQJec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mLG862k+; arc=none smtp.client-ip=74.125.82.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-2f7020a928eso392756eec.1
        for <linux-integrity@vger.kernel.org>; Fri, 15 May 2026 14:15:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778879726; x=1779484526; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zqo7CRqxUyGu2ximwHeynWdE4uCktJ1VQ9YKgYjfZfU=;
        b=mLG862k+XvHfYupXY2cGN3KGmsVEarkfn+irlqIgLRV7YTl1YOL7rWy18hQOrUcqlJ
         ksnEVDMtlJuORz9AHqXFw1cYhAdj/9o+vXaXOOzWe28wk3dys/zIToepw6+c9dHabvKa
         FiUYL7xyp4xQS5EoFtUZXt8tX4vME/asD+16w3nvjGBBr595Q0+FUwYlvG03IibGTq1F
         wdi40Wrv0EGMGgRZiRjvkTDMXd04nosit30VEIyD5KQIlIlUfalXz61hGUlhExwWOiAd
         4UHGDn8sFl7bGSQ1rfhi58kXBo1l+ZYheebN8ogAtmUiyBkcGc5As9oKrf9bzH5BADsC
         10Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778879726; x=1779484526;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zqo7CRqxUyGu2ximwHeynWdE4uCktJ1VQ9YKgYjfZfU=;
        b=ILkh6lJjkX02dZGnNXPE0/m5ccgMXwbqkw9H9IXPjM3OeLJ6lPFmsgyPyvfGFouAbW
         TlPksE9Up2i4bhSg6y8Hm0zjQ5lnr3PTI+DYlZEkSwobcWhjj7ShltnfEaI4WHeW13fY
         HmpE2sNNBXgCx17QG+BDpoqepjntIPM/508CLf1Zqok1TZPVgMEnNIzrmqOD7yQUttgC
         lGgv9BDlv5z1KEu9k1ThWeHXgBOtd9PJSt9jIyUKzBmbIpImPROzQqKck9HwkPzr1HhE
         u+gGYidapmNojwO7nhMcDQ71ueyX025eW0LRqDViMCQ9I/wrDzsM5o0uSxwrjaUmrnkS
         eRPw==
X-Forwarded-Encrypted: i=1; AFNElJ9DQT50g640SBSFukQ0NQewECKslVZMFY8ocby0SMUj98KSKdiD5dOK6dRQf5ipJK2u35RvLbuJHvq6MhDfn9g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3phYeBD+fpxfMAm7Y2th5GH4gvXsKm6PfKo1WgZO/YncDE5Kj
	oTB5x5bJS7Zb1Zfj72+YDfAoHGZSRWMb2vW4ySn7yYh5Ox5gKRJCdd4J
X-Gm-Gg: Acq92OEmwk6/mY7IbQi94G3a41FqpQTzTUT10cqAO1DRiTZ1VOcm35pdLoEG21b7NmF
	++T3RSIUB+JF0Fzvh6k67ZLi1zqNDLhANCUryigmDJDJVHkz+5kdI4tJQSHgtKi2h3BomioFufI
	Dw71x8+5dzJ5HZKfnGgNkMPPJxBnAev05mWCpJx/oXoDERVvYalMBhPpvQJfQHLb9d/qlyo40TM
	mTs4w8aMKC4Kpd7adIVYgCW4poBvIkUZ17bV7G3CmrgV+CGA/68xrjSQj6kpJFogcvNMpMNiYTC
	FeIN/HrDSpqPnz/g1FAEACiNLh8tkiYl3uZMte4s5rPRYAJ5bcMb5+ZqzFmIDVXAVZF0Hzmq6gu
	j8KL0gJhBghZa16v/oDKrblTK7Xwp3pvTkKeGPB6EYE0CIt9wxhhTo/PoYQIgLW53rwDzpTOHyA
	zm4klFJTHNC0SY8I2ZPMna/qePaxziVBc=
X-Received: by 2002:a05:7300:fb83:b0:2de:cc07:e8b with SMTP id 5a478bee46e88-3039818afa7mr2863582eec.1.1778879726369;
        Fri, 15 May 2026 14:15:26 -0700 (PDT)
Received: from mimas.lan ([2603:8000:df01:38f7:a6bb:6dff:fecf:e71a])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-302977a9474sm8155633eec.25.2026.05.15.14.15.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 14:15:25 -0700 (PDT)
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
Subject: [PATCH v16 26/38] x86: Add early SHA-1 support for Secure Launch early measurements
Date: Fri, 15 May 2026 14:13:58 -0700
Message-ID: <20260515211410.31440-27-ross.philipson@gmail.com>
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
X-Rspamd-Queue-Id: B485055829B
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
	TAGGED_FROM(0.00)[bounces-9561-lists,linux-integrity=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,apertussolutions.com:email]
X-Rspamd-Action: no action

From: "Daniel P. Smith" <dpsmith@apertussolutions.com>

Secure Launch is written to be compliant with the Intel TXT Measured
Launch Developer's Guide. The MLE Guide dictates that the system can be
configured to use both the SHA-1 and SHA-2 hashing algorithms.

Regardless of the preference towards SHA-2, if the firmware elected to
start with the SHA-1 and SHA-2 banks active and the dynamic launch was
configured to include SHA-1, Secure Launch is obligated to record
measurements for all algorithms requested in the launch configuration.

The user environment or the integrity management does not desire to use
SHA-1, it is free to just ignore the SHA-1 bank in any integrity operation
with the TPM. If there is a larger concern about the SHA-1 bank being
active, it is free to deliberately cap the SHA-1 PCRs, recording the
event in the DRTM log.

Signed-off-by: Daniel P. Smith <dpsmith@apertussolutions.com>
Signed-off-by: Ross Philipson <ross.philipson@gmail.com>
---
 arch/x86/boot/startup/Makefile   | 4 ++++
 arch/x86/boot/startup/lib-sha1.c | 6 ++++++
 2 files changed, 10 insertions(+)
 create mode 100644 arch/x86/boot/startup/lib-sha1.c

diff --git a/arch/x86/boot/startup/Makefile b/arch/x86/boot/startup/Makefile
index 5e499cfb29b5..e283ee4c1f45 100644
--- a/arch/x86/boot/startup/Makefile
+++ b/arch/x86/boot/startup/Makefile
@@ -20,6 +20,10 @@ KCOV_INSTRUMENT	:= n
 
 obj-$(CONFIG_X86_64)		+= gdt_idt.o map_kernel.o
 obj-$(CONFIG_AMD_MEM_ENCRYPT)	+= sme.o sev-startup.o
+
+slaunch-objs			+= lib-sha1.o
+obj-$(CONFIG_SECURE_LAUNCH)	+= $(slaunch-objs)
+
 pi-objs				:= $(patsubst %.o,$(obj)/%.o,$(obj-y))
 
 lib-$(CONFIG_X86_64)		+= la57toggle.o
diff --git a/arch/x86/boot/startup/lib-sha1.c b/arch/x86/boot/startup/lib-sha1.c
new file mode 100644
index 000000000000..8d679d12f6bf
--- /dev/null
+++ b/arch/x86/boot/startup/lib-sha1.c
@@ -0,0 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2026 Apertus Solutions, LLC
+ */
+
+#include "../../../../lib/crypto/sha1.c"
-- 
2.47.3


