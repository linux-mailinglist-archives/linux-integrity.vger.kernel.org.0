Return-Path: <linux-integrity+bounces-9570-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4OFgLaOPB2rB8AIAu9opvQ
	(envelope-from <linux-integrity+bounces-9570-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Fri, 15 May 2026 23:26:59 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 791D155810C
	for <lists+linux-integrity@lfdr.de>; Fri, 15 May 2026 23:26:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 03C22301DF55
	for <lists+linux-integrity@lfdr.de>; Fri, 15 May 2026 21:19:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A34940C5C1;
	Fri, 15 May 2026 21:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MW3f6p1L"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6038340C5A6
	for <linux-integrity@vger.kernel.org>; Fri, 15 May 2026 21:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778879754; cv=none; b=m0Ilrk8YgC6bp1oRAiOmA+e0f/08fHtIMnEm+y+OgMVOr+uJn127GvrpAkXAiZbO0KkDYNe+3vO2DnVh6MzfzxnCDphTjbIIbxgNuqzU5YUDV6ZgAg0AFyppuQoYF5KAUYfyNzV+GMuo7onRV6ZMhg8JlmpEVdUsVpD/4fSkPO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778879754; c=relaxed/simple;
	bh=k11liqjn7SKCyf9jqrs9rTU6kFg+eJg4IVC5ddHmpkI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uYxtQfQVJsAu3etE0O5lavlE8ohWcYU0HxE3YSb4zj7JlGR+oK7zTiT3eRanWX4jjnyfDbmZjHpngZOjIuOC7GgGlcJ5iwpwbtjGnByRWrYMW2cDjsyp7JQ8533qYUZtM3AjRi/sVdfwbYkjcsEXbmndg7wz8RGLgnV3qPYtrYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MW3f6p1L; arc=none smtp.client-ip=74.125.82.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-2f3c623322bso1046912eec.0
        for <linux-integrity@vger.kernel.org>; Fri, 15 May 2026 14:15:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778879753; x=1779484553; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d0sYZnhQeLyzvjO7vpNeSMDXaPgGF/81BOZ3a8GGZZ8=;
        b=MW3f6p1L5kudegGCItpuYAXS0RaiDi4aNt4p22EfgX11pgRsZn0lkRN/b11rRXCWh4
         Timw43kcCzZdNRr8jfGYUIrLHf+Zq71fP9atGwGnaPZPEuqF3JRXOybBWGN4Bcj7+wZV
         pJXY/7KvNXuCNw2IDafGifFgt/qPqSJgSY4Fyjg3I1GtfYy446IuqHKyhO1W93TZhUv0
         I3XOK9esj/N/vrNMe11n9gSuwnxhphCC0RvnmwruX4gebJ+nWhpgGJcvAQ9cDtmshGJX
         SYNUKSX8YPQrZ/gxyiK/aMBuXXZaVh9FhVgzgM56noTmG9GcF6/S4kcU1vGe9grQL/2I
         yu8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778879753; x=1779484553;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=d0sYZnhQeLyzvjO7vpNeSMDXaPgGF/81BOZ3a8GGZZ8=;
        b=CEvWyDBPDUjKTes9JH9FwmGm0tmSPtttfyhWCMOqrbmf94arWeBiwbALYDXtNPeHP4
         0iQywGux4pFLhQExibnFDjqacv7/q9NhM2v7YT1suKpVH1DaHi8jKpi0fA3I+COOid3N
         NXMw/Fq1sFr0cwqwqKo4PisdxaG6QrHLD4TMOSQTxGJCyR33V51jSlYxb86ULLpxHIQl
         3tQU662+3Lxeb/FYUTbpsO2jz9Q+12tfQVkJWorYHO0FBjefEUrpuzPNQXsG1SIv+JwI
         KN0GiYKqQMT5AP7JO8hPu+U7gddvUb1MdMFdXemoPaEY2d75sGrkaOnnbDWJPXN/E9S5
         GghQ==
X-Forwarded-Encrypted: i=1; AFNElJ8lM7sgxqusLTs+3g9u+Ax09V11Xp6BB9oqscrqNrpPnP/2liHlBjVPM8yBM/0uaoRl/LpyBAluTsWu0vfwAeY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxR49mxgy9oKFqeHFYIXfyryn/0zg4vhPEpSPee8zi2WefKsKTN
	L47S4b5UsG9NVad5Wd8WEOIPRtL/FvvoznTzailctXTlliTv97PexrcjaR1NNzfx
X-Gm-Gg: Acq92OFY4iI8yyV7CPFxu9h8ULyxrKfoxZvR5fgBfU4EZz0IOKzPk75F3wCQed7jL+y
	LXVQsze6af+E9evdbJaptL5ZFaV1TanDoOf2+yiAHHds40uKXn4rwiI9D42b50uWheuUkeyfRry
	7mu0flHqy3AP80P2Mhn+55gFznI5es9qyNVbTUIrltlWOrguRXeVhIeAR9kbEDFYvC85XnQbqhL
	W3yajiwjg/dk+f3uCAZQr/lNYhkp97hvK4dpo06vSDWqDMMvH1hLm4vLCIlkm3m0U0aq3fqZnet
	eNgGJKhx0L5i9yw/wnLzCswnqjPJv2QUoNWBn4LinbdNcrl79xHwREWUxttLsUw+Mc+IBdQIkx7
	tHaTaaCIOPk4rIqs85o9ue4KO9oxn3gtdXECIAp94FmKHmntc8vXzx6XncNy1zk5PY2Wul22H9r
	uaCpnQyMeXD4u/YRiBb1wiwJlICmiU1vf1JGGh85OJVQ==
X-Received: by 2002:a05:7301:290f:b0:2da:7e33:9261 with SMTP id 5a478bee46e88-3039869b7b3mr2853046eec.27.1778879752504;
        Fri, 15 May 2026 14:15:52 -0700 (PDT)
Received: from mimas.lan ([2603:8000:df01:38f7:a6bb:6dff:fecf:e71a])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30297bbc9a3sm8132550eec.31.2026.05.15.14.15.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 14:15:52 -0700 (PDT)
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
Subject: [PATCH v16 35/38] reboot/slaunch: Secure Launch SEXIT support on reboot paths
Date: Fri, 15 May 2026 14:14:07 -0700
Message-ID: <20260515211410.31440-36-ross.philipson@gmail.com>
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
X-Rspamd-Queue-Id: 791D155810C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9570-lists,linux-integrity=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[apertussolutions.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

If the MLE kernel is being powered off, rebooted or halted,
then SEXIT must be called. Note that the GETSEC[SEXIT] leaf
can only be called after a machine_shutdown() has been done on
these paths. The machine_shutdown() is not called on a few paths
like when poweroff action does not have a poweroff callback (into
ACPI code) or when an emergency reset is done. In these cases,
just the TXT registers are finalized but SEXIT is skipped.

Co-developed-by: Daniel P. Smith <dpsmith@apertussolutions.com>
Signed-off-by: Daniel P. Smith <dpsmith@apertussolutions.com>
Signed-off-by: Ross Philipson <ross.philipson@gmail.com>
---
 arch/x86/kernel/reboot.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/x86/kernel/reboot.c b/arch/x86/kernel/reboot.c
index 6032fa9ec753..87835706bb4f 100644
--- a/arch/x86/kernel/reboot.c
+++ b/arch/x86/kernel/reboot.c
@@ -14,6 +14,7 @@
 #include <linux/pgtable.h>
 #include <linux/kexec.h>
 #include <linux/kvm_types.h>
+#include <linux/slaunch.h>
 #include <acpi/reboot.h>
 #include <asm/io.h>
 #include <asm/apic.h>
@@ -779,6 +780,12 @@ static void native_machine_restart(char *__unused)
 
 	if (!reboot_force)
 		machine_shutdown();
+	/*
+	 * The comments for slaunch_finalize() provides the explanation for the
+	 * conditions required to do the SEXIT op reflected in the conditional
+	 * parameter do_sexit.
+	 */
+	slaunch_finalize(!reboot_force);
 	__machine_emergency_restart(0);
 }
 
@@ -789,6 +796,8 @@ static void native_machine_halt(void)
 
 	tboot_shutdown(TB_SHUTDOWN_HALT);
 
+	slaunch_finalize(1);
+
 	stop_this_cpu(NULL);
 }
 
@@ -797,8 +806,12 @@ static void native_machine_power_off(void)
 	if (kernel_can_power_off()) {
 		if (!reboot_force)
 			machine_shutdown();
+		slaunch_finalize(!reboot_force);
 		do_kernel_power_off();
+	} else {
+		slaunch_finalize(0);
 	}
+
 	/* A fallback in case there is no PM info available */
 	tboot_shutdown(TB_SHUTDOWN_HALT);
 }
@@ -826,6 +839,7 @@ void machine_shutdown(void)
 
 void machine_emergency_restart(void)
 {
+	slaunch_finalize(0);
 	__machine_emergency_restart(1);
 }
 
-- 
2.47.3


