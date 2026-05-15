Return-Path: <linux-integrity+bounces-9569-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +KhgKwmTB2pV9QIAu9opvQ
	(envelope-from <linux-integrity+bounces-9569-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Fri, 15 May 2026 23:41:29 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id D0A32558560
	for <lists+linux-integrity@lfdr.de>; Fri, 15 May 2026 23:41:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A227930736A7
	for <lists+linux-integrity@lfdr.de>; Fri, 15 May 2026 21:19:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D5CD3F58DC;
	Fri, 15 May 2026 21:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CAGQ8a4i"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F1D8409E0D
	for <linux-integrity@vger.kernel.org>; Fri, 15 May 2026 21:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778879752; cv=none; b=knX8tmxn5KLOhW83ruPHyuNkanax9nLzSXdWaWOSZ+DG6rb6zWSl+xOWzLOE/9x3rhs69TlhXQkpDwWzktqYkEo5yTD7vtzbA/bu3pYmCcpLmsDkMysytKCDXwLBA38Kdk7QI4u4L5a5qXUDY0rlWPDDsTTdYgnsBLoFQQHu5R4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778879752; c=relaxed/simple;
	bh=XbUQZxHpNqBquc7KQic463MCIdXLrI/jlIpArje4CQY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aGhmf1yuVCp/zy5UPBVdeARmYohdYk14lQm7ARokiceEyFVy5BhguB92033wx5wQL1cav2k53DDg9cqPhXsJ+pUrkQMSNkWwg2qWGF8XT3F8nxkPX+bwLX3pPK5kHLt/1g79RiZrMJ+xg2oUVTH/zfaGT1YakYXAxSBnOOUhgVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CAGQ8a4i; arc=none smtp.client-ip=74.125.82.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-30246cfd41aso1516059eec.1
        for <linux-integrity@vger.kernel.org>; Fri, 15 May 2026 14:15:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778879750; x=1779484550; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+XRl4qspUk2kb6S4/X/JxR4OkIHL9zexMUP1DlnAUlQ=;
        b=CAGQ8a4iH3SSfmaF4RFgv7YATJ5hLTx06I7TdBd+XDrkvC6tnQMpcT31yKe+LlZ9eB
         YbnhOnhixK1Oqvrp2w2OiYYVXQ4w04Ahlk6hz2e8n6HUb7CEygsVYiKsFLYw5tS1rNgm
         sdm8mqMqRI8gJTDDBJNxpp+iEmvQyJRSVxb8iAN7Fb4XYUqx12BZpKi9ghmDtPPDZzqo
         X1jq/0LqaQjl/FEiSf3ZBiKcc2+V+6ZvaoR7QeTqb9G2suC/lmEfAYR0w43FvjyCzdCV
         aMK/gCSz8IVOKKNUL6cdey//sfpHeSfRLV6IZLstHLAiDJH4tHJSxqvlo+2n2hdiQMjC
         hEtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778879750; x=1779484550;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+XRl4qspUk2kb6S4/X/JxR4OkIHL9zexMUP1DlnAUlQ=;
        b=W0Ns4zqcWoDoWKZa72xgNb0PIJpdWAbQYzIXyHrJPi9PiI2memk7cbMAa5pUC6+0sD
         HEcRzgQTFxmvB3wWD6evydXYACSThLmEOIFJZ27QF9IGX16vjQN9JEymwP9FuCic2olC
         w9ruE7Kch2TLfsEdekC8oc7g4P3/UpjnGS4+i0NFeiP1/IOeyaki1HbuwstbW2oep8Ur
         As8XflcTHt/JwDbNP89E3I11zYvct13i6dzeWhEvdtANsNg6Wg6ZiThacMA47Ep/moMP
         JHFgjicPO+qZeQgjOePN5ZteZqolJjaFAJ7+TnwvSvJNXXIKuRxkIuRB23spVZ/6IFnp
         Q7mg==
X-Forwarded-Encrypted: i=1; AFNElJ84NA5HimS51rxzeBD4t//lC1K24O50NMZl7PdE/lbLwURMpj7obyvYXTZ4uvgFVsRh0tJ43ZBETvxt5tMlP7U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0d7DSNz0nvOeySBphihQMlm1W3UIhTemDQk32JXA6DkuY8R0C
	ZrJsL8P5guoll/Us2qdb4heSvSuwIU3dPYISh8ag0cJkgGY7tHtGIeuT
X-Gm-Gg: Acq92OGzi4Tx45tjpbe4xVhV+UyF6H9IiVePnvQA6n9wmO1pG13oaWFx3FDzAbSxc26
	aW2ru76fim6cV37/Ad+icAbNmcJeJsPPG0qz9dbHZuaIb7tJbuosYsSCErz9mQ4P+4tghUFSLd4
	hSMLjIMoZE3MdjNYvEW6s/ajvqTtqd7DoKTU4EmiqH0P4uOowFNkYD2BUX8ey1wztwzoL4OnhNc
	i2DIp5mkt2mXc9YNKpYRr3oKMVVn07NCMvQ+SFAAsJWDq+oaxE/eRugYLdRWP4sXAOru9D/VsJa
	7fPEif3MF9rSV+LczbSk01jTTeJviLBQv57oc9rNAoBJ3Pi2CJNH2SX15XJNjiOBp9xCbom2BSM
	r93OE8w/gKo7NbUaHBGLoVzOmZ1DkClZbmqkgoGXoBJnwDTFJYYk0UuGx7WtApYK1Yx1dqbJDoP
	7kdNhjOZYfRuFjm+4wkQltNGLNo/cfumY=
X-Received: by 2002:a05:7300:3252:b0:2ea:5057:a31d with SMTP id 5a478bee46e88-3039818a864mr3228730eec.1.1778879749634;
        Fri, 15 May 2026 14:15:49 -0700 (PDT)
Received: from mimas.lan ([2603:8000:df01:38f7:a6bb:6dff:fecf:e71a])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30293e2e686sm9461192eec.5.2026.05.15.14.15.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 14:15:49 -0700 (PDT)
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
Subject: [PATCH v16 34/38] kexec/slaunch: Secure Launch kexec SEXIT support
Date: Fri, 15 May 2026 14:14:06 -0700
Message-ID: <20260515211410.31440-35-ross.philipson@gmail.com>
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
X-Rspamd-Queue-Id: D0A32558560
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
	TAGGED_FROM(0.00)[bounces-9569-lists,linux-integrity=lfdr.de];
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

Prior to running the next kernel via kexec, the Secure Launch code
closes down private SMX resources and does an SEXIT. This allows the
next kernel to start normally, effectively exiting the DRTM
environment.

The function slaunch_finalize() takes a boolean argument that controls
whether a GETSEC[SEXIT] can be issued. When true, the finalize code can
completely shutdown and exit the DRTM. This allows another kernel to
start normally and in turn can re-establish another DRTM session.

In cases where the machine has not been fully shutdown (e.g. when
machine_shutdown() was not called), the SEXIT step cannot be done
(SEXIT will fail if other processors are busy). In these cases SEXIT
is not attempted. This normally occurs on power off or reboot
operations where it doesn't really matter.

Co-developed-by: Daniel P. Smith <dpsmith@apertussolutions.com>
Signed-off-by: Daniel P. Smith <dpsmith@apertussolutions.com>
Signed-off-by: Ross Philipson <ross.philipson@gmail.com>
---
 arch/x86/kernel/slaunch.c | 80 +++++++++++++++++++++++++++++++++++++++
 kernel/kexec_core.c       |  8 ++++
 2 files changed, 88 insertions(+)

diff --git a/arch/x86/kernel/slaunch.c b/arch/x86/kernel/slaunch.c
index f6e6f1b7e18c..b34997a5f541 100644
--- a/arch/x86/kernel/slaunch.c
+++ b/arch/x86/kernel/slaunch.c
@@ -537,3 +537,83 @@ void __init slaunch_fixup_ap_wake_vector(void)
 
 	pr_info("TXT AP startup vector address updated\n");
 }
+
+static inline void smx_getsec_sexit(void)
+{
+	asm volatile ("getsec\n" : : "a" (SMX_X86_GETSEC_SEXIT));
+}
+
+/*
+ * Used during kexec and on reboot paths to finalize the TXT state
+ * and do an SEXIT SMX operation, exiting the DRTM and disabling SMX mode.
+ */
+void slaunch_finalize(int do_sexit)
+{
+	u64 one = TXT_REGVALUE_ONE, val;
+	void __iomem *config;
+
+	if (!slaunch_is_txt_launch())
+		return;
+
+	config = ioremap(TXT_PRIV_CONFIG_REGS_BASE, TXT_NR_CONFIG_PAGES * PAGE_SIZE);
+	if (!config) {
+		pr_emerg("TXT: SEXIT failed to ioremap TXT private registers\n");
+		return;
+	}
+
+	/* Clear secrets bit for SEXIT */
+	memcpy_toio(config + TXT_CR_CMD_NO_SECRETS, &one, sizeof(one));
+	memcpy_fromio(&val, config + TXT_CR_E2STS, sizeof(val));
+
+	/* Unlock memory configurations */
+	memcpy_toio(config + TXT_CR_CMD_UNLOCK_MEM_CONFIG, &one, sizeof(one));
+	memcpy_fromio(&val, config + TXT_CR_E2STS, sizeof(val));
+
+	/* Close the TXT private register space */
+	memcpy_toio(config + TXT_CR_CMD_CLOSE_PRIVATE, &one, sizeof(one));
+	memcpy_fromio(&val, config + TXT_CR_E2STS, sizeof(val));
+
+	/*
+	 * Calls to iounmap are skipped due to the system state this late in the
+	 * kexec process. Local IRQs are disabled and iounmap causes a TLB flush
+	 * which in turn causes a warning. Leaving these mappings is not an issue
+	 * since the next kernel is going to completely re-setup memory management.
+	 */
+
+	/* Map public registers and do a final read fence */
+	config = ioremap(TXT_PUB_CONFIG_REGS_BASE, TXT_NR_CONFIG_PAGES *
+			 PAGE_SIZE);
+	if (!config) {
+		pr_emerg("TXT: SEXIT failed to ioremap TXT public registers\n");
+		return;
+	}
+
+	memcpy_fromio(&val, config + TXT_CR_E2STS, sizeof(val));
+
+	pr_emerg("TXT clear secrets bit and unlock memory complete.\n");
+
+	/*
+	 * Mostly finalized but the system is still in SMX mode. At this point if the
+	 * system has been quiesced, the APs are halted and the current process is
+	 * running on the BSP, a final GETSEC(SEXIT) can be done exiting DRTM/SMX mode.
+	 * This cannot be done on certain boot paths where the system has not been quiesced
+	 * (e.g. where machine_shutdown() has not been called).
+	 */
+	if (!do_sexit)
+		return;
+
+	if (smp_processor_id() != 0)
+		panic("TXT: SEXIT must be called on CPU 0\n");
+
+	/*
+	 * In case SMX mode was disabled, enable it for SEXIT. Clearing the bit
+	 * anytime during DRTM operation will not have an affect until the next
+	 * GETSEC() op is performed.
+	 */
+	cr4_set_bits(X86_CR4_SMXE);
+
+	/* Do the SEXIT SMX operation */
+	smx_getsec_sexit();
+
+	pr_info("TXT SEXIT complete.\n");
+}
diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index 2fea396d29b9..dd284e5043ab 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -43,6 +43,7 @@
 #include <linux/kmsg_dump.h>
 #include <linux/dma-map-ops.h>
 #include <linux/sysfs.h>
+#include <linux/slaunch.h>
 
 #include <asm/page.h>
 #include <asm/sections.h>
@@ -1201,6 +1202,13 @@ int kernel_kexec(void)
 		cpu_hotplug_enable();
 		pr_notice("Starting new kernel\n");
 		machine_shutdown();
+
+		/*
+		 * If a Secure Launch is in progress and the current kernel is
+		 * running as a DRTM with TXT, finalize the Secure Launch state
+		 * and do the GETSEC(SEXIT) returning from SMX mode to do the KEXEC.
+		 */
+		slaunch_finalize(1);
 	}
 
 	kmsg_dump(KMSG_DUMP_SHUTDOWN);
-- 
2.47.3


