Return-Path: <linux-integrity+bounces-6645-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C42CB07570
	for <lists+linux-integrity@lfdr.de>; Wed, 16 Jul 2025 14:18:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB8F1166951
	for <lists+linux-integrity@lfdr.de>; Wed, 16 Jul 2025 12:18:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5D612F3C3F;
	Wed, 16 Jul 2025 12:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q/Fau8LZ"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 922CB22068F;
	Wed, 16 Jul 2025 12:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752668308; cv=none; b=soiDDyw1GoS6wRGoDw8LyCh4fC1sgBOyhVZKyohyu/OWu/twUokeonE7/Oh8/d/Fq/jC1SyUbJZzUUDwwoRfiRqFyzkujvOH4/vYvnL698+6X5t9YrLaS+8Vcl4Yv/L06CXNVpK5RXfy16Q4/jtJhjtXwA5LaUNeY8KIIHAB/8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752668308; c=relaxed/simple;
	bh=fQcg0JlR4emu2uqamRjb41I2ds1ijPQIV210NDtKJfQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tc6dKzjcPL8prUcg6kowNBobAUyg50NEjM/ka+mC0JmQSGhlkgqmM4J9dNB+GcLiY3Jd3r9mBXY8g2ilcLWnW1oq+9QT+jXf0vsDJwflVxRue/UrC89coID6PU2SnKzdVTwJFBFVyEwqYVN8jeP3oxfp9fBd+B6cpUPAW6tfRdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q/Fau8LZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F413C4CEF0;
	Wed, 16 Jul 2025 12:18:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752668308;
	bh=fQcg0JlR4emu2uqamRjb41I2ds1ijPQIV210NDtKJfQ=;
	h=From:To:Cc:Subject:Date:From;
	b=Q/Fau8LZwsYpFWjTtkoODCUUvYqy6y1JVVGNCVtKXKFsd7eZsMRwwpRTrx0ki8Hp8
	 3NOEJaUR75BluMyf6T7louSyrEt5GETx++fTLDAnOTnwMyE8DPW5UB67vuQ1cKDNLJ
	 4VH3NA663e50WSvFZ7aG0v0c83Tdu2xsZ0SxcV24IzaZNYklYeDfl9ErR3IYcmA9XJ
	 PEjdBXkss2dEWfLKrzB0ivnqu9QbGttP/OervA/0pX50Zd3bL6kdMrgtjWRsnSDjP4
	 kbK2nvpX3hPsy85yYPDoT7v6bG7/lcAnB2td/pPA0ikr4f2nDVRSoAevbjXyqhTl2s
	 WtnQ5ioQkBb9g==
From: Jarkko Sakkinen <jarkko@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: keyrings@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	Stefan Berger <stefanb@linux.ibm.com>,
	Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Peter Huewe <peterhuewe@gmx.de>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>,
	"Borislav Petkov (AMD)" <bp@alien8.de>,
	Arnd Bergmann <arnd@arndb.de>,
	Frank van der Linden <fvdl@google.com>,
	linux-doc@vger.kernel.org (open list:DOCUMENTATION)
Subject: [RFC PATCH] tpm, tpm_vtpm_proxy: boot-time TPM
Date: Wed, 16 Jul 2025 15:18:21 +0300
Message-Id: <20250716121823.173949-1-jarkko@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>

Provide a kernel command-line parameter named as `supplicant`, which
contains a path to an TPM emulator binary. When defind, the kernel will
launch the program during boot-time.

This feature is most useful in feature testing e.g., in environments
where other means are not possible, such as CI runners. Its original use
case highlights also quite well of its applicability for pre-production
hardware: it was used to provide a TPM implemnentation for a RISC-V SoC
running on FPGA with no TPM HW implementation at the time.

Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>
---
Bumped into this in my archives so thought to make it available just in
case anyone is interested.
---
 .../admin-guide/kernel-parameters.txt         | 14 +++++
 drivers/char/tpm/tpm_vtpm_proxy.c             | 51 +++++++++++++++++++
 2 files changed, 65 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index f1f2c0874da9..e062de99480e 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -7230,6 +7230,20 @@
 			defined by Trusted Computing Group (TCG) see
 			https://trustedcomputinggroup.org/resource/pc-client-platform-tpm-profile-ptp-specification/
 
+	tpm_vtpm_proxy.supplicant= [TPM]
+			When defined, this field must contain a legit path to a
+			program emulating a TPM chip, which will be started
+			during the driver initialization, thus providing a
+			mechanism for the user space have an emulated TPM from
+			the get go. Kernel prepares the process with a file
+			pre-opened file descriptor in the index 3 for
+			/dev/vtpmx.
+
+			An emulator can optionally provide support for
+			localities by reacting to the vendor command defined
+			by the driver: 0x20001000. Its payload is a single
+			byte containing the new locality.
+
 	tp_printk	[FTRACE]
 			Have the tracepoints sent to printk as well as the
 			tracing ring buffer. This is useful for early boot up
diff --git a/drivers/char/tpm/tpm_vtpm_proxy.c b/drivers/char/tpm/tpm_vtpm_proxy.c
index 0818bb517805..612f5251fdc0 100644
--- a/drivers/char/tpm/tpm_vtpm_proxy.c
+++ b/drivers/char/tpm/tpm_vtpm_proxy.c
@@ -51,6 +51,8 @@ struct proxy_dev {
 #define VTPM_PROXY_FLAGS_ALL  (VTPM_PROXY_FLAG_TPM2)
 
 static struct workqueue_struct *workqueue;
+static char *supplicant;
+module_param(supplicant, charp, 0);
 
 static void vtpm_proxy_delete_device(struct proxy_dev *proxy_dev);
 
@@ -678,6 +680,55 @@ static const struct file_operations vtpmx_fops = {
 	.llseek = noop_llseek,
 };
 
+static int vtpmx_supplicant_setup(struct subprocess_info *info, struct cred *new)
+{
+	struct vtpm_proxy_new_dev dev = { .flags = VTPM_PROXY_FLAG_TPM2 };
+	struct file *file = vtpm_proxy_create_device(&dev);
+
+	if (IS_ERR(file))
+		return PTR_ERR(file);
+
+	fd_install(dev.fd, file);
+	return 0;
+}
+
+static void vtpmx_supplicant_cleanup(struct subprocess_info *info)
+{
+}
+
+static int vtpmx_supplicant_init(void)
+{
+	static const char * const argv[] = { supplicant, NULL };
+	struct subprocess_info *info;
+	int ret;
+
+	if (!supplicant)
+		return 0;
+
+	info = call_usermodehelper_setup(argv[0], (char **)argv, NULL,
+					 GFP_KERNEL, vtpmx_supplicant_setup,
+					 vtpmx_supplicant_cleanup, NULL);
+	if (!info)
+		return -ENOMEM;
+
+	ret = call_usermodehelper_exec(info, UMH_KILLABLE | UMH_NO_WAIT);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static int vtpmx_init(void)
+{
+	int ret;
+
+	ret = vtpmx_supplicant_init();
+	if (ret)
+		return ret;
+
+	return misc_register(&vtpmx_miscdev);
+}
+
 static struct miscdevice vtpmx_miscdev = {
 	.minor = MISC_DYNAMIC_MINOR,
 	.name = "vtpmx",
-- 
2.39.5


