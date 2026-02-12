Return-Path: <linux-integrity+bounces-8488-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2Av7ApUojWmEzgAAu9opvQ
	(envelope-from <linux-integrity+bounces-8488-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Thu, 12 Feb 2026 02:10:45 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D22C128CE9
	for <lists+linux-integrity@lfdr.de>; Thu, 12 Feb 2026 02:10:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A9B723038FDE
	for <lists+linux-integrity@lfdr.de>; Thu, 12 Feb 2026 01:10:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDA8B1EB9FA;
	Thu, 12 Feb 2026 01:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r9qokTK/"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B923D1E7C23;
	Thu, 12 Feb 2026 01:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770858609; cv=none; b=I2guvpBVl+7sIuXZOKWQoPwC0OWT++9JmNqGIiRRMR3vwiYJqBwutTPMXyuEokeVo00hxkjwfSZRWRl07JvGBH7R7/lybENIhVwcn1zqXw9t1I88TrborP57SFWORKWbNJ4+IMHLEcdHWuMR3w1m3yxhOJycAp6Nwcdry0lQGXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770858609; c=relaxed/simple;
	bh=2BUTkqvGtxM61N9vkMccq26T/Mth1/H/gYa0x+OTFfc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fgo3hUzYoh3CanhWlxQpYN+1aVooyKCaUDo686uLucDFdxHnWd1KJ7vUre3m+UL803kqVwFiqChaqQwFiA2w0U/lqvRbEjcBYLNZiE3jh66ky7LVALSoVFs26rxAECJ7v0W4WqzQajz8aN2qang3QvftYLyKp7tuWRUwp5jXPJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r9qokTK/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF6C0C16AAE;
	Thu, 12 Feb 2026 01:10:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770858609;
	bh=2BUTkqvGtxM61N9vkMccq26T/Mth1/H/gYa0x+OTFfc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=r9qokTK/jitWKBPIpcQUjPZGTCuyN477yxFKyjqUe+Lr+IiBOp2PXNkSz0sVJtGoY
	 JAXDsVAWw6OHCZl+ZDl0VjP/zZjdY2P/zFlMQ98IehwnQkZBEAcsF4h1O9pIfHMYvR
	 IveOR7HyUvr+6HDsPu4k9yQi52L/H5OUoB8AH/WpILCQPvpx4ZaqTyo6mRm/nd9QjG
	 8kQXNogQwp9xOCMDrn1DgqvoD07BLbkuSmag7o4x/Cju+MI9VtZk8wC8hk3GHpFD08
	 UU8/7+Y4QeQXkEsUA0vwqRVxsKB0Je2hdR1b9xX0rAeswN8i81eDvqc66GGxrNphiC
	 ZlVkQVc1zGz7Q==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Thomas Gleixner <tglx@kernel.org>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	peterhuewe@gmx.de,
	clrkwllms@kernel.org,
	rostedt@goodmis.org,
	dlan@kernel.org,
	linux-integrity@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev
Subject: [PATCH AUTOSEL 6.19-5.15] char: tpm: cr50: Remove IRQF_ONESHOT
Date: Wed, 11 Feb 2026 20:09:30 -0500
Message-ID: <20260212010955.3480391-7-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260212010955.3480391-1-sashal@kernel.org>
References: <20260212010955.3480391-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.19
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linutronix.de,kernel.org,gmx.de,goodmis.org,vger.kernel.org,lists.linux.dev,lists.infradead.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-8488-lists,linux-integrity=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,linux-integrity@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	PRECEDENCE_BULK(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-integrity];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linutronix.de:email]
X-Rspamd-Queue-Id: 7D22C128CE9
X-Rspamd-Action: no action

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

[ Upstream commit 1affd29ffbd50125a5492c6be1dbb1f04be18d4f ]

Passing IRQF_ONESHOT ensures that the interrupt source is masked until
the secondary (threaded) handler is done. If only a primary handler is
used then the flag makes no sense because the interrupt can not fire
(again) while its handler is running.

The flag also prevents force-threading of the primary handler and the
irq-core will warn about this.

Remove IRQF_ONESHOT from irqflags.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
Link: https://patch.msgid.link/20260128095540.863589-10-bigeasy@linutronix.de
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

Now I have a complete understanding. Let me write up the comprehensive
analysis.

---

## Comprehensive Analysis

### 1. Commit Message Analysis

The commit subject is "char: tpm: cr50: Remove IRQF_ONESHOT" and the
message explains three points:
1. `IRQF_ONESHOT` is for masking the interrupt source until the
   **threaded** (secondary) handler completes
2. These drivers only have primary handlers, so the flag is meaningless
3. The flag **prevents force-threading** of the primary handler, and the
   irq-core will warn about this

The commit is authored by **Sebastian Andrzej Siewior** (bigeasy), the
PREEMPT_RT maintainer, and signed off by **Thomas Gleixner**, the IRQ
subsystem maintainer and co-maintainer of the Linux kernel. It was
reviewed by **Jarkko Sakkinen**, the TPM subsystem maintainer.

### 2. Code Change Analysis

The change is minimal and surgical:
- **`tpm_tis_i2c_cr50.c`**: Removes `IRQF_ONESHOT` from the flags in
  `devm_request_irq()`, keeping `IRQF_TRIGGER_FALLING | IRQF_NO_AUTOEN`
- **`tpm_tis_spi_cr50.c`**: Removes `IRQF_ONESHOT` from the flags in
  `devm_request_irq()`, keeping `IRQF_TRIGGER_RISING`

Both interrupt handlers (`tpm_cr50_i2c_int_handler` at line 74 and
`cr50_spi_irq_handler` at line 65) are trivially simple - they just call
`complete()` and return `IRQ_HANDLED`. There is no thread_fn.
`devm_request_irq()` is a wrapper that calls
`devm_request_threaded_irq()` with `thread_fn = NULL`.

### 3. The Real Bug

The companion commit **`aef30c8d569c`** ("genirq: Warn about using
IRQF_ONESHOT without a threaded handler") was merged on 2026-01-12 and
adds a `WARN_ON_ONCE()` in `__setup_irq()`:

```c
WARN_ON_ONCE(new->flags & IRQF_ONESHOT && !new->thread_fn);
```

This means that **without this cr50 fix**, every time the cr50 TPM
driver probes on a system with the updated IRQ core, it will emit a
`WARN_ON_ONCE` kernel warning at boot. This is a real runtime issue that
would affect all Chromebook and other systems using cr50/ti50 TPM chips.

More importantly, the core technical issue is that `IRQF_ONESHOT`
prevents force-threading of the primary handler. From
`irq_setup_forced_threading()` in `kernel/irq/manage.c`:

```c
if (new->flags & (IRQF_NO_THREAD | IRQF_PERCPU | IRQF_ONESHOT))
    return 0;  // Skip force-threading!
```

On **PREEMPT_RT kernels** (where `force_irqthreads()` returns `true`),
this means the cr50 interrupt handler runs in hardirq context instead of
being force-threaded. While the handler itself (`complete()`) is safe in
hardirq context, this defeats the PREEMPT_RT design goal of having all
interrupt handlers run in thread context. On non-RT systems with
`threadirqs` boot parameter, the same issue occurs.

### 4. Classification

This is a **bug fix** that addresses:
1. **A spurious kernel warning** triggered by the new `WARN_ON_ONCE`
   check added in `aef30c8d569c`
2. **Incorrect IRQ flags** - `IRQF_ONESHOT` has never been semantically
   correct for these drivers since they only use primary handlers
3. **PREEMPT_RT compatibility** - the flag prevents force-threading,
   which can be problematic

The fix is not a feature addition - it removes an incorrect flag that
was always wrong.

### 5. Scope and Risk Assessment

- **Lines changed**: 2 files, 2 lines total (removing `IRQF_ONESHOT`
  from two flag constants)
- **Risk**: Extremely low. `IRQF_ONESHOT` had no functional effect on
  these drivers since they use only primary handlers. The interrupt
  cannot fire while its primary handler is already running (hardware
  guarantee), so removing the flag changes nothing about interrupt
  masking behavior.
- **Subsystem**: TPM drivers, well-understood, mature code
- **Testing**: Reviewed by TPM maintainer (Jarkko Sakkinen), authored by
  PREEMPT_RT maintainer, signed off by IRQ core maintainer

### 6. User Impact

- **Who is affected**: All users with cr50/ti50 TPM chips (primarily
  Chromebooks and Google-based embedded devices)
- **Severity without fix**: Kernel `WARN_ON_ONCE` at boot if the
  `aef30c8d569c` warning commit is also backported; PREEMPT_RT
  degradation
- **Severity of regression risk**: Essentially zero - the flag had no
  functional purpose

### 7. Dependencies

This commit is **self-contained**. It does not require any other patches
to apply cleanly. However, the motivating warning comes from
`aef30c8d569c` - if that commit is backported to stable, this fix
becomes essential to avoid warnings. Even without the warning commit,
this fix is correct and beneficial (enables proper force-threading on RT
systems).

The i2c-spacemit driver already got a similar fix (`e351836a54e3`) with
`Cc: stable@vger.kernel.org` tag, establishing precedent that these
IRQF_ONESHOT removal patches are considered stable material.

### 8. Stability Indicators

- Author: Sebastian Andrzej Siewior (PREEMPT_RT maintainer) - domain
  expert
- Signed-off-by: Thomas Gleixner (IRQ subsystem maintainer) - domain
  expert
- Reviewed-by: Jarkko Sakkinen (TPM maintainer) - domain expert
- Part of a systematic cleanup pattern with prior art (i2c-exynos5,
  i2c-hix5hd2, i2c-spacemit, drm/msm)

### Conclusion

This is a small, surgical, obviously correct bug fix. The `IRQF_ONESHOT`
flag was always semantically wrong for these primary-only handlers. The
fix removes a flag that had no functional benefit but actively prevented
force-threading on PREEMPT_RT systems and will trigger a `WARN_ON_ONCE`
with the companion IRQ core warning check. The risk is near-zero, the
change is trivial (2 lines across 2 files), it was reviewed by all three
relevant subsystem maintainers, and there is clear precedent for
identical fixes being marked as stable material (the i2c-spacemit fix
had `Cc: stable@vger.kernel.org`).

**YES**

 drivers/char/tpm/tpm_tis_i2c_cr50.c | 3 +--
 drivers/char/tpm/tpm_tis_spi_cr50.c | 2 +-
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/char/tpm/tpm_tis_i2c_cr50.c b/drivers/char/tpm/tpm_tis_i2c_cr50.c
index fc6891a0b6936..b48cacacc0664 100644
--- a/drivers/char/tpm/tpm_tis_i2c_cr50.c
+++ b/drivers/char/tpm/tpm_tis_i2c_cr50.c
@@ -749,8 +749,7 @@ static int tpm_cr50_i2c_probe(struct i2c_client *client)
 
 	if (client->irq > 0) {
 		rc = devm_request_irq(dev, client->irq, tpm_cr50_i2c_int_handler,
-				      IRQF_TRIGGER_FALLING | IRQF_ONESHOT |
-				      IRQF_NO_AUTOEN,
+				      IRQF_TRIGGER_FALLING | IRQF_NO_AUTOEN,
 				      dev->driver->name, chip);
 		if (rc < 0) {
 			dev_err(dev, "Failed to probe IRQ %d\n", client->irq);
diff --git a/drivers/char/tpm/tpm_tis_spi_cr50.c b/drivers/char/tpm/tpm_tis_spi_cr50.c
index f4937280e9406..32920b4cecfb4 100644
--- a/drivers/char/tpm/tpm_tis_spi_cr50.c
+++ b/drivers/char/tpm/tpm_tis_spi_cr50.c
@@ -287,7 +287,7 @@ int cr50_spi_probe(struct spi_device *spi)
 	if (spi->irq > 0) {
 		ret = devm_request_irq(&spi->dev, spi->irq,
 				       cr50_spi_irq_handler,
-				       IRQF_TRIGGER_RISING | IRQF_ONESHOT,
+				       IRQF_TRIGGER_RISING,
 				       "cr50_spi", cr50_phy);
 		if (ret < 0) {
 			if (ret == -EPROBE_DEFER)
-- 
2.51.0


