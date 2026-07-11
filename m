Return-Path: <linux-integrity+bounces-9915-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id g/9IBUJpUmrvPQMAu9opvQ
	(envelope-from <linux-integrity+bounces-9915-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Sat, 11 Jul 2026 18:03:14 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A0BE74217E
	for <lists+linux-integrity@lfdr.de>; Sat, 11 Jul 2026 18:03:13 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=g8t864WG;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "linux-integrity+bounces-9915-lists+linux-integrity=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-integrity+bounces-9915-lists+linux-integrity=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 62D3E300BEA8
	for <lists+linux-integrity@lfdr.de>; Sat, 11 Jul 2026 16:01:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30E013CCFB2;
	Sat, 11 Jul 2026 16:01:36 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F66E3C9EDD
	for <linux-integrity@vger.kernel.org>; Sat, 11 Jul 2026 16:01:34 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783785696; cv=none; b=E3zxWdTP66SAAsRj7DiFIAtO9al0CXj0BGxvWOWQRySHcyRtLmvcPDo9pkDMbBedwqY3pZqTu4aAsFrMJzZjART1MHRM9JPOjNju/eZxnNSviEGI5avjMe628IR1nOlSAQJLjbiLQEmONZJ1C7pP5eUCnLsosG4eulbpLnqOjNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783785696; c=relaxed/simple;
	bh=SWTmQxbm+O3CiuFQm/Zj3X9aRzkg0EYTJlhP8g+50ZE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wm3W+qaQRqyTOvhW37IQw1/uW6WmLl89KpgRC8rV4KEbw3cMuTAzP2VhpRdh5Otao/ssgxukSR1IoAIDy4k1DAeHmeGyYDkBIYHFKqOs8CJMy9RhoZAGatJC5Ky5jDLJUJiWSzFEBa73RNxnJnZ4ceMXBgUeu2IKqIjKYJdgoZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g8t864WG; arc=none smtp.client-ip=209.85.214.182
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2ceab75934dso3631475ad.2
        for <linux-integrity@vger.kernel.org>; Sat, 11 Jul 2026 09:01:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783785694; x=1784390494; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=h8PdlfVA45gq99DCqpKxVhIV4ifAok/KN5VEGME0LcA=;
        b=g8t864WGg/9SeihPvThSlxO6aPm1JKP+lZV5uqf4SxOGm5cSaLmszjo+qTr6W6Mk4i
         i14kRKNOH832Rpk8M5BB5PtKC7VLJXcSEJRneJywRQLIH7R+XR6FXOCnazpwyzxwdZ/T
         gnRXjR2omx7pImL8ZekUjMxErBXvDvNakGBHgedgE8h3Z7I6OZjO083vHKk4ULtAcUt5
         kCG5ZtX94y7CNTHg+Rdj6YLPfn0RFSmlQ7bbXidPQJxboDwLUtlaijiOD12HagX4tLKe
         njOr4SDL/GGhi9XkSB3VneKsmO+ngrX2jI9elAcoD6bzhp4TAGfNTFDyTAjci6Myf+dn
         byUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783785694; x=1784390494;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=h8PdlfVA45gq99DCqpKxVhIV4ifAok/KN5VEGME0LcA=;
        b=iaBC/E9qquA1Sz41VPP70mxuSJ6jDDQrZllv/lh9bLp4+tqV2/e/fTJhYpPvZEflSO
         /B3hScXIEBYqlDj88lS+ZOnInBxJAR0dnjcY2xUy5GtEWUmC13/uBS1GCPXOM48bUAiw
         hK4LIg/Khes3WCuEkqvg+WniyIkmkwPVa1hC03ueqf8l7gopCrD6o/kF0KbMpvePHtCB
         emqTz3R3FnA3vQ/lEC9gbMFGkRbj8x/EMuxe1Or96tmh6u/xeEwVdWBbtkHBgUTe72I0
         JXlmgsVi1/sToCns5AD8iSsGrFCJ3oPPmH12nzsfWzST0zuYchRAZjAQ1exTAA7zo5GX
         EfAQ==
X-Forwarded-Encrypted: i=1; AHgh+RqFPgoixGEgR4gBqm0KF2sWEJ6ZNpDxcQVCol6bhEywwD/ATXr96IWaHcK1ff4ZwxK7yDNw/P1aQr3oy4uexPU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAIDTjiJcKGnyJc/2Sbru4s+8jkkhAbrfDM9KVuWhAz9/q3oer
	eNJvRwLY8DCOOmM4PTW+7RORhbwnQC35Xgm+CCJuaSBs+C6KKV8mPppl
X-Gm-Gg: AfdE7ck5VyrBCqeX4nKgrq4MW/jrfjCtGHoLxxmGuh0QAV6Ka2IRSqysdd2BrPO9avc
	CVh6GIss3Ygw2EvUh24ElG2becn6kiI2BaBceM4NiQ7nlPNcYN9QQC+bhmkd9sg/NA/r8jvPE+P
	fYmoNZlgkw+7OMDuE7ta174S2UpQhQCRp2WiHaDTUq/br9VgbVLW/9CW3wvTZOKNnxvtGH6bPhe
	fwr0o0J/bV5vbAnx5ebetGwMdN2z44MdNI2quRNO+bppuqraH00ju0Zyq3hB0/or++c4oqdikCw
	JnXfeYC77ZOZBaG3Ux+4OUsk6HiHkQXbr+NDKC1JNAXSrS74Rn58ApNUgpCp++uoW0lYVvg+fqv
	oGjkLoos7vI4jI3mnxGuxnRGpr0nuNnQRT88dxF8u/t/p69GXBKBDPtIrudig503yNDF3CbP0bm
	Y3JOVvrwtRBuaxybvpBzYC
X-Received: by 2002:a17:90a:da83:b0:384:d509:7274 with SMTP id 98e67ed59e1d1-38dc75f63bemr3176054a91.15.1783785694020;
        Sat, 11 Jul 2026 09:01:34 -0700 (PDT)
Received: from titan.lan ([2603:8000:df01:38f7:255c:dd03:30a6:e57b])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3118ee6091dsm54498068eec.14.2026.07.11.09.01.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jul 2026 09:01:32 -0700 (PDT)
From: Ross Philipson <ross.philipson@gmail.com>
To: linux-kernel@vger.kernel.org,
	x86@kernel.org,
	linux-integrity@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	linux-efi@vger.kernel.org
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
	luto@amacapital.net,
	herbert@gondor.apana.org.au,
	davem@davemloft.net,
	corbet@lwn.net,
	kanth.ghatraju@oracle.com,
	daniel.kiper@oracle.com,
	andrew.cooper3@citrix.com,
	trenchboot-devel@googlegroups.com
Subject: [PATCH v2 06/10] tpm: Remove main TPM header from TPM event log header
Date: Sat, 11 Jul 2026 09:01:06 -0700
Message-ID: <20260711160110.267780-7-ross.philipson@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260711160110.267780-1-ross.philipson@gmail.com>
References: <20260711160110.267780-1-ross.philipson@gmail.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-9915-lists,linux-integrity=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:linux-kernel@vger.kernel.org,m:x86@kernel.org,m:linux-integrity@vger.kernel.org,m:linux-crypto@vger.kernel.org,m:linux-efi@vger.kernel.org,m:ross.philipson@gmail.com,m:dpsmith@apertussolutions.com,m:tglx@linutronix.de,m:mingo@redhat.com,m:bp@alien8.de,m:hpa@zytor.com,m:dave.hansen@linux.intel.com,m:ardb@kernel.org,m:mjg59@srcf.ucam.org,m:James.Bottomley@hansenpartnership.com,m:peterhuewe@gmx.de,m:jarkko@kernel.org,m:luto@amacapital.net,m:herbert@gondor.apana.org.au,m:davem@davemloft.net,m:corbet@lwn.net,m:kanth.ghatraju@oracle.com,m:daniel.kiper@oracle.com,m:andrew.cooper3@citrix.com,m:trenchboot-devel@googlegroups.com,m:rossphilipson@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[rossphilipson@gmail.com,linux-integrity@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	FREEMAIL_CC(0.00)[gmail.com,apertussolutions.com,linutronix.de,redhat.com,alien8.de,zytor.com,linux.intel.com,kernel.org,srcf.ucam.org,hansenpartnership.com,gmx.de,amacapital.net,gondor.apana.org.au,davemloft.net,lwn.net,oracle.com,citrix.com,googlegroups.com];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[rossphilipson@gmail.com,linux-integrity@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-integrity];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5A0BE74217E

From: Alec Brown <alec.r.brown@oracle.com>

Allow the TPM event log functionality to be used without including
the main TPM driver definitions.

Signed-off-by: Alec Brown <alec.r.brown@oracle.com>
Signed-off-by: Ross Philipson <ross.philipson@gmail.com>
---
 include/linux/tpm_eventlog.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/tpm_eventlog.h b/include/linux/tpm_eventlog.h
index aff8ea2fa98e..40fe92eb7deb 100644
--- a/include/linux/tpm_eventlog.h
+++ b/include/linux/tpm_eventlog.h
@@ -3,7 +3,7 @@
 #ifndef __LINUX_TPM_EVENTLOG_H__
 #define __LINUX_TPM_EVENTLOG_H__
 
-#include <linux/tpm.h>
+#include <linux/tpm_command.h>
 
 #define TCG_EVENT_NAME_LEN_MAX	255
 #define MAX_TEXT_EVENT		1000	/* Max event string length */
-- 
2.55.0


