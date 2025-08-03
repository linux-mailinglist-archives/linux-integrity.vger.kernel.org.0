Return-Path: <linux-integrity+bounces-6772-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF891B19585
	for <lists+linux-integrity@lfdr.de>; Sun,  3 Aug 2025 23:18:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 77B0C7A95B3
	for <lists+linux-integrity@lfdr.de>; Sun,  3 Aug 2025 21:16:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 562E32046A9;
	Sun,  3 Aug 2025 21:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iw8IxJrU"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23FEA1FC0F0;
	Sun,  3 Aug 2025 21:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754255876; cv=none; b=bzte6J4UJbbZHnpVq+e7TWjO+CbrjQ7GNrLLsLNYA+P0Kox6iHTk+6b+eon+XB7io/8zsMKSVai1eLCh8nNomiNxmWyxtUWVYMGneWfb3X4CWwHyqBJWuNkgvkUcLgwDwW9P7HeYQp7GC9FXOJ62A6d7Scud56+1MClI33Jv9aY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754255876; c=relaxed/simple;
	bh=Q08RjAV9KniQgdDl6tpPyv8u7EwxsuuYKUWSxgJ0fQE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gQ2aoi7UXgGuGAF3UL3vSSevm+zwCZE3ENNvXArigoaf7rIBkN8sbuUsOyEsz/KaVIyj5QhrpIl8PGx/AIWbaUkXTH7UDEmUEBbWhelFmuOSkfcpkYK2Dp66gMk/yiqdpc738OJEEbPjtosEhxX4SGJweRUwscROv9ZYFIXvRiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iw8IxJrU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 094A9C4CEF8;
	Sun,  3 Aug 2025 21:17:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754255874;
	bh=Q08RjAV9KniQgdDl6tpPyv8u7EwxsuuYKUWSxgJ0fQE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iw8IxJrUNO+6U14Taxome5aLe1OSodJ4eSQ+K8IahUFAJVVFfMCBzDCERv8F++3oK
	 84ErBCcu4aoCUUR3KZI16ydP+VWghAfiuC1t5WrqSjR2OgY29U/UAk03dXLdhmUEel
	 8G5CdDNhy6usVMTUQAl3JX0ycMfdf0S74/AT6TKZs9ZSQPvjN74aRfnmEm/ZdjyvEu
	 2KrUQNafNTCsMG38aoiisxwUkZnlvFgVQzcyisKLc8dmlyrGL0XWLROvNS/85B23HI
	 ohM/2a4Ax/wqrfjL+Cs084YBwQgRMd6ICtaWRC5+jhkWLWegnwxInkfqyCjVnX0Q+d
	 PdlSXG6rrHQsg==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Jarkko Sakkinen <jarkko@kernel.org>,
	Ivan Orlov <ivan.orlov0322@gmail.com>,
	Jonathan McDowell <noodles@meta.com>,
	Sasha Levin <sashal@kernel.org>,
	peterhuewe@gmx.de,
	linux-integrity@vger.kernel.org
Subject: [PATCH AUTOSEL 6.16 07/35] tpm: Check for completion after timeout
Date: Sun,  3 Aug 2025 17:17:07 -0400
Message-Id: <20250803211736.3545028-7-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250803211736.3545028-1-sashal@kernel.org>
References: <20250803211736.3545028-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.16
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Jarkko Sakkinen <jarkko@kernel.org>

[ Upstream commit d4640c394f23b202a89512346cf28f6622a49031 ]

The current implementation of timeout detection works in the following
way:

1. Read completion status. If completed, return the data
2. Sleep for some time (usleep_range)
3. Check for timeout using current jiffies value. Return an error if
   timed out
4. Goto 1

usleep_range doesn't guarantee it's always going to wake up strictly in
(min, max) range, so such a situation is possible:

1. Driver reads completion status. No completion yet
2. Process sleeps indefinitely. In the meantime, TPM responds
3. We check for timeout without checking for the completion again.
   Result is lost.

Such a situation also happens for the guest VMs: if vCPU goes to sleep
and doesn't get scheduled for some time, the guest TPM driver will
timeout instantly after waking up without checking for the completion
(which may already be in place).

Perform the completion check once again after exiting the busy loop in
order to give the device the last chance to send us some data.

Since now we check for completion in two places, extract this check into
a separate function.

Signed-off-by: Ivan Orlov <ivan.orlov0322@gmail.com>
Reviewed-by: Jonathan McDowell <noodles@meta.com>
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

Now let me analyze the code changes in detail to understand the race
condition being fixed.

**Backport Status: YES**

This commit should be backported to stable kernel trees. Here's my
extensive analysis:

## Bug Analysis

The commit fixes a critical race condition in the TPM driver's timeout
handling mechanism that can cause data loss. The bug occurs in the
following scenario:

1. **The Race Window**: Between the last completion status check in the
   busy loop (line 149-151 in the original code) and the timeout check
   (line 160), there's a window where:
   - The driver checks status and finds no completion
   - The process sleeps via `tpm_msleep(TPM_TIMEOUT_POLL)`
   - During sleep, the TPM device completes the operation
   - When the process wakes up, `time_before(jiffies, stop)` returns
     false
   - The driver immediately returns `-ETIME` without checking completion
     again

2. **VM-Specific Impact**: The commit message specifically mentions this
   affects virtual machines where vCPUs can be descheduled for extended
   periods. When the vCPU resumes, the timeout may have expired while
   the TPM response is actually ready.

## Code Changes Analysis

The fix involves:

1. **New Helper Function** (lines 85-90): `tpm_transmit_completed()`
   extracts the completion check logic into a reusable function:
  ```c
  static bool tpm_transmit_completed(u8 status, struct tpm_chip *chip)
  {
  u8 status_masked = status & chip->ops->req_complete_mask;
  return status_masked == chip->ops->req_complete_val;
  }
  ```

2. **Additional Completion Check** (lines 162-167): After the timeout
   loop exits, the code now performs one final completion check:
  ```c
  /*
    - Check for completion one more time, just in case the device
      reported
    - it while the driver was sleeping in the busy loop above.
    */
   if (tpm_transmit_completed(tpm_chip_status(chip), chip))
       goto out_recv;
   ```

## Stable Backport Criteria Analysis

1. **Fixes a real bug**: ✓ - This fixes a race condition that causes TPM
   operations to fail spuriously
2. **User impact**: ✓ - TPM operations failing due to this race can
   affect:
   - System boot (TPM measurements)
   - Cryptographic operations
   - Attestation services
   - Secure boot processes
3. **Small and contained**: ✓ - The fix is minimal:
   - Adds one helper function
   - Adds one additional check after the loop
   - No architectural changes
4. **Low regression risk**: ✓ - The additional check only runs when
   timeout occurs, adding minimal overhead
5. **No new features**: ✓ - Only fixes existing functionality
6. **Critical subsystem**: ✓ - TPM is security-critical infrastructure

## Additional Considerations

- The fix is particularly important for virtualized environments where
  scheduling delays are common
- The race condition can cause intermittent failures that are difficult
  to debug
- The fix follows the principle of "check one more time" which is a
  common pattern for avoiding race conditions
- No follow-up fixes were needed for this commit, indicating it's stable

This commit meets all the criteria for stable backporting and addresses
a real-world bug that affects system reliability, especially in
virtualized environments.

 drivers/char/tpm/tpm-interface.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
index 8d7e4da6ed53..8d18b33aa62d 100644
--- a/drivers/char/tpm/tpm-interface.c
+++ b/drivers/char/tpm/tpm-interface.c
@@ -82,6 +82,13 @@ static bool tpm_chip_req_canceled(struct tpm_chip *chip, u8 status)
 	return chip->ops->req_canceled(chip, status);
 }
 
+static bool tpm_transmit_completed(u8 status, struct tpm_chip *chip)
+{
+	u8 status_masked = status & chip->ops->req_complete_mask;
+
+	return status_masked == chip->ops->req_complete_val;
+}
+
 static ssize_t tpm_try_transmit(struct tpm_chip *chip, void *buf, size_t bufsiz)
 {
 	struct tpm_header *header = buf;
@@ -129,8 +136,7 @@ static ssize_t tpm_try_transmit(struct tpm_chip *chip, void *buf, size_t bufsiz)
 	stop = jiffies + tpm_calc_ordinal_duration(chip, ordinal);
 	do {
 		u8 status = tpm_chip_status(chip);
-		if ((status & chip->ops->req_complete_mask) ==
-		    chip->ops->req_complete_val)
+		if (tpm_transmit_completed(status, chip))
 			goto out_recv;
 
 		if (tpm_chip_req_canceled(chip, status)) {
@@ -142,6 +148,13 @@ static ssize_t tpm_try_transmit(struct tpm_chip *chip, void *buf, size_t bufsiz)
 		rmb();
 	} while (time_before(jiffies, stop));
 
+	/*
+	 * Check for completion one more time, just in case the device reported
+	 * it while the driver was sleeping in the busy loop above.
+	 */
+	if (tpm_transmit_completed(tpm_chip_status(chip), chip))
+		goto out_recv;
+
 	tpm_chip_cancel(chip);
 	dev_err(&chip->dev, "Operation Timed out\n");
 	return -ETIME;
-- 
2.39.5


