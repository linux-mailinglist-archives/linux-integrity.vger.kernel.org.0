Return-Path: <linux-integrity+bounces-6775-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F349B195AA
	for <lists+linux-integrity@lfdr.de>; Sun,  3 Aug 2025 23:19:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CD3B188B963
	for <lists+linux-integrity@lfdr.de>; Sun,  3 Aug 2025 21:19:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4DDD20F079;
	Sun,  3 Aug 2025 21:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j92PH1st"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD31A1F2B88;
	Sun,  3 Aug 2025 21:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754255937; cv=none; b=acT0V4ahbQCdP7yI32QH/5d5a2KPhpphSkN3ZtsJm/9f8itcLSRmC3za4N+NyLgfyRPUdL5Xlc5iGGUtBNtTtJ+mLhu8gyc1kLyUhdMAvbA+De+lfgozVZM/wtU0QHKFc0jv9zTS8zssU2Y71zljF/8KC5ZOcdb1zQgw8yM+mUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754255937; c=relaxed/simple;
	bh=MMBtPQLwCO0QyeKFov+bjaf22K64YPf+7/jIyciOv1Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gP8o2yVewQMqGb2NatlTPpDR0QHulKv5IcZyuL9y2BwnplyEs7aQNDHXxD5pI/r5YikanOT+qZNgIRDVIryS7XfHcoLcYH1QeKKisQzz7Tmw8ekKpugLaFrb1r7/ZFSgWow9fIo9XIyiRwIOT7Ny2XFyc7sM3pbh8ZC7Q8YvqnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j92PH1st; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 858DCC4CEF0;
	Sun,  3 Aug 2025 21:18:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754255937;
	bh=MMBtPQLwCO0QyeKFov+bjaf22K64YPf+7/jIyciOv1Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=j92PH1stiDAgi/hPYdl9rcohXPS8PKQ2hOeoie1G+LuJ9BxH1kQ4vYIo23DJtzyXW
	 FRTM7G4VyvwXw+UM1RdHsiyl1t12k2SG8zmK9/MilIL5kmoNziviZis/jL4JJZAlIN
	 GjtVqn2WgO48/MaqqhlxxrT7zG5IaueHibfz3/voaf0D/vQyYKyk7TAPl5G17mr5f0
	 Qm3z5KOGdo3KAkxYwfJwF50PxdMPvCskPqLtbosDegPGcf21kkCJ43wHzRhj1o2uoA
	 iC/WHNSpMJtFvYrih9NQbVgvST60nhTklbeKi4NEk9fFXNPeGUFKVZCl/dPvQGArdc
	 NbIKoiRM6GsVg==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Yeoreum Yun <yeoreum.yun@arm.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	peterhuewe@gmx.de,
	linux-integrity@vger.kernel.org
Subject: [PATCH AUTOSEL 6.15 08/34] tpm: tpm_crb_ffa: try to probe tpm_crb_ffa when it's built-in
Date: Sun,  3 Aug 2025 17:18:10 -0400
Message-Id: <20250803211836.3546094-8-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250803211836.3546094-1-sashal@kernel.org>
References: <20250803211836.3546094-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.15.9
Content-Transfer-Encoding: 8bit

From: Yeoreum Yun <yeoreum.yun@arm.com>

[ Upstream commit 746d9e9f62a6e8ba0eba2b83fc61cfe7fa8797ce ]

To generate the boot_aggregate log in the IMA subsystem using TPM PCR
values, the TPM driver must be built as built-in and must be probed
before the IMA subsystem is initialized.

However, when the TPM device operates over the FF-A protocol using the
CRB interface, probing fails and returns -EPROBE_DEFER if the
tpm_crb_ffa device — an FF-A device that provides the communication
interface to the tpm_crb driver — has not yet been probed.

This issue occurs because both crb_acpi_driver_init() and
tpm_crb_ffa_driver_init() are registered with device_initcall.  As a
result, crb_acpi_driver_init() may be invoked before
tpm_crb_ffa_driver_init(), which is responsible for probing the
tpm_crb_ffa device.

When this happens, IMA fails to detect the TPM device and logs the
following message:

  | ima: No TPM chip found, activating TPM-bypass!

Consequently, it cannot generate the boot_aggregate log with the PCR
values provided by the TPM.

To resolve this issue, the tpm_crb_ffa_init() function explicitly
attempts to probe the tpm_crb_ffa by register tpm_crb_ffa driver so that
when tpm_crb_ffa device is created before tpm_crb_ffa_init(), probe the
tpm_crb_ffa device in tpm_crb_ffa_init() to finish probe the TPM device
completely.

This ensures that the TPM device using CRB over FF-A can be successfully
probed, even if crb_acpi_driver_init() is called first.

[ jarkko: reformatted some of the paragraphs because they were going past
  the 75 character boundary. ]

Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

**Backport Status: YES**

This commit should be backported to stable kernel trees for the
following reasons:

1. **Fixes a functional bug affecting users**: The commit addresses a
   race condition where IMA (Integrity Measurement Architecture) fails
   to detect TPM devices that use CRB over FF-A, resulting in the
   message "ima: No TPM chip found, activating TPM-bypass!" This
   prevents IMA from generating boot_aggregate logs with TPM PCR values,
   which is a critical security feature.

2. **Small and contained fix**: The change is minimal and focused:
   - Adds a static forward declaration of `tpm_crb_ffa_driver`
   - Modifies `tpm_crb_ffa_init()` to explicitly register the FFA driver
     when built-in
   - Adds conditional compilation guards around `module_ffa_driver()`

3. **No architectural changes**: The fix doesn't introduce new features
   or change the architecture. It simply ensures proper driver
   registration ordering when the driver is built-in.

4. **Clear root cause**: The issue occurs because both
   `crb_acpi_driver_init()` and `tpm_crb_ffa_driver_init()` are
   registered with `device_initcall`, leading to unpredictable
   initialization order. When `crb_acpi_driver_init()` runs first, it
   calls `tpm_crb_ffa_init()` which returns `-ENOENT` because the FFA
   driver hasn't been registered yet.

5. **Security implications**: TPM is a critical security component, and
   IMA's inability to use TPM measurements compromises system integrity
   attestation. This fix ensures security features work as intended.

6. **Minimal risk**: The changes only affect the initialization path
   when `CONFIG_TCG_ARM_CRB_FFA` is built-in (not as a module). The fix:
   - Only executes when `!IS_MODULE(CONFIG_TCG_ARM_CRB_FFA)`
   - Preserves existing error handling
   - Doesn't change the module case behavior

7. **Well-reviewed**: The commit has been reviewed by multiple
   maintainers including Mimi Zohar (IMA maintainer), Sudeep Holla (ARM
   FF-A maintainer), and Jarkko Sakkinen (TPM maintainer).

The fix is important for ARM systems using FF-A to communicate with TPM
devices, ensuring that security features like IMA work correctly when
TPM drivers are built into the kernel.

 drivers/char/tpm/tpm_crb_ffa.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/drivers/char/tpm/tpm_crb_ffa.c b/drivers/char/tpm/tpm_crb_ffa.c
index 3169a87a56b6..430b99c04124 100644
--- a/drivers/char/tpm/tpm_crb_ffa.c
+++ b/drivers/char/tpm/tpm_crb_ffa.c
@@ -109,6 +109,7 @@ struct tpm_crb_ffa {
 };
 
 static struct tpm_crb_ffa *tpm_crb_ffa;
+static struct ffa_driver tpm_crb_ffa_driver;
 
 static int tpm_crb_ffa_to_linux_errno(int errno)
 {
@@ -162,13 +163,23 @@ static int tpm_crb_ffa_to_linux_errno(int errno)
  */
 int tpm_crb_ffa_init(void)
 {
+	int ret = 0;
+
+	if (!IS_MODULE(CONFIG_TCG_ARM_CRB_FFA)) {
+		ret = ffa_register(&tpm_crb_ffa_driver);
+		if (ret) {
+			tpm_crb_ffa = ERR_PTR(-ENODEV);
+			return ret;
+		}
+	}
+
 	if (!tpm_crb_ffa)
-		return -ENOENT;
+		ret = -ENOENT;
 
 	if (IS_ERR_VALUE(tpm_crb_ffa))
-		return -ENODEV;
+		ret = -ENODEV;
 
-	return 0;
+	return ret;
 }
 EXPORT_SYMBOL_GPL(tpm_crb_ffa_init);
 
@@ -341,7 +352,9 @@ static struct ffa_driver tpm_crb_ffa_driver = {
 	.id_table = tpm_crb_ffa_device_id,
 };
 
+#ifdef MODULE
 module_ffa_driver(tpm_crb_ffa_driver);
+#endif
 
 MODULE_AUTHOR("Arm");
 MODULE_DESCRIPTION("TPM CRB FFA driver");
-- 
2.39.5


