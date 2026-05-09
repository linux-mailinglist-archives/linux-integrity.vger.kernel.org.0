Return-Path: <linux-integrity+bounces-9506-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iEqFFVFw/2kx6gAAu9opvQ
	(envelope-from <linux-integrity+bounces-9506-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Sat, 09 May 2026 19:35:13 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D87E500CA2
	for <lists+linux-integrity@lfdr.de>; Sat, 09 May 2026 19:35:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 94B4E300D317
	for <lists+linux-integrity@lfdr.de>; Sat,  9 May 2026 17:35:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3712C2E7F20;
	Sat,  9 May 2026 17:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k1OZqvsY"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12DE2253958;
	Sat,  9 May 2026 17:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778348109; cv=none; b=KN8lzpihjXPumq2b2Xb1xPuCVld72kedHZ67my5vCLOQMiZI7J1IdppSe6h7981uM/j7cG4lOxyU0a3+8wXc3Z6o1RdoULKeF7qb10MXPEa+PCEfG65CxLtS13FnPTtjqnw3iBkzDHnSKg9NddHhHMpYzh/GP1mn/msVqAqXANo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778348109; c=relaxed/simple;
	bh=BENoTAiy10ENMoBOqti7gYlVUuYOQP1tE2livSwxKnc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UfnwnfQ7VfRMaMemIEFxjMULJ0BWmuucz/WV/JLGhtlcYz9JpoKWGCW5EibFjyFo7BMtddugZqcsCwLMuv8DDNqEMcGNO9aXUHAhZJOtv3kdT0HTbvPiMtxBfzTyii70zOXvIpJlU4voMq4Fyrb0gTIJaFc7HyuDN8WOkzrjMSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k1OZqvsY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED9DBC2BCB2;
	Sat,  9 May 2026 17:35:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778348108;
	bh=BENoTAiy10ENMoBOqti7gYlVUuYOQP1tE2livSwxKnc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=k1OZqvsYmMkN5WhscSBW8FWZ1leLN41bgR9Sn00pT+4bpQZt/Q6G3TmODxYA37BXF
	 8RL8f6tdE8GyZdQyBjgtP09NDvtEwcBtrbpWfQzIahguLW/RcAXlNLNyy7aTo86q6L
	 f4/rFMorEBzmYPi621pCePzQaC6EhoAes1M5wKiKEjJa3T5VqhkEqZJNri/5Mvz4np
	 /ysG7REq12Y7/kZuvuD9s9Z5u/FVaSvJltVhcvUUE4jSPuMBGRJns05gfC4Anh4/n7
	 26IcZd6/adX2s3tDiPCKRAou0mUN4FOzmG8ayU6SGROufqyAdprJZgU5Sw/Yv6VrnE
	 wYRmL0tO2fn7Q==
Date: Sat, 9 May 2026 20:35:04 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Stefan Wahren <wahrenst@gmx.net>
Cc: Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	linux-arm-kernel@lists.infradead.org,
	linux-integrity@vger.kernel.org, kernel@pengutronix.de,
	Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>
Subject: Re: tpm: spi: do not call blocking ops when !TASK_RUNNING; during
 shutdown
Message-ID: <af9wSERzU04Zu68Z@kernel.org>
References: <e7974d35-0d50-4742-8747-822f28915e00@gmx.net>
 <afiiUdFv7p0fuK-5@kernel.org>
 <6964bec7-3dbb-453b-89ef-9b990217a8b9@gmx.net>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="O68tc/HXB4lj4vp+"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6964bec7-3dbb-453b-89ef-9b990217a8b9@gmx.net>
X-Rspamd-Queue-Id: 8D87E500CA2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain,text/x-diff];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9506-lists,linux-integrity=lfdr.de];
	FROM_HAS_DN(0.00)[];
	SUBJECT_HAS_EXCLAIM(0.00)[];
	FREEMAIL_CC(0.00)[gmx.de,ziepe.ca,lists.infradead.org,vger.kernel.org,pengutronix.de,nxp.com,lists.linux.dev];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+,1:+,2:+];
	FREEMAIL_TO(0.00)[gmx.net];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jarkko@kernel.org,linux-integrity@vger.kernel.org];
	HAS_ATTACHMENT(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-integrity];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action


--O68tc/HXB4lj4vp+
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Mon, May 04, 2026 at 06:05:25PM +0200, Stefan Wahren wrote:
> Am 04.05.26 um 15:42 schrieb Jarkko Sakkinen:
> > Hi Stefan,
> > 
> > On Mon, Apr 20, 2026 at 12:25:21PM +0200, Stefan Wahren wrote:
> > > Hi,
> > > we use a custom i.MX93 board, which based on Phytec Phycore i.MX93 with a
> > > TPM connected via SPI. If I enable CONFIG_DEBUG_ATOMIC_SLEEP=y in our kernel
> > > config with mainline kernel 6.18.23 and reboot our board, I will get the
> > > following warning:
> > Please provide results with the latest mainline kernel.
> > 
> Here you are
> 
> [   69.085410] do not call blocking ops when !TASK_RUNNING; state=1 set at
> [<0000000090f4020f>] prepare_to_wait_event+0x54/0x14c
> [   69.097076] WARNING: kernel/sched/core.c:9086 at __might_sleep+0x74/0x7c,
> CPU#0: systemd-shutdow/1
> [   69.106026] Modules linked in: flexcan can_dev rtc_rv3028 mse102x
> phy_can_transceiver fuse autofs4
> [   69.114991] CPU: 0 UID: 0 PID: 1 Comm: systemd-shutdow Not tainted
> 7.1.0-rc2-00005-g6d35786de281-dirty #45 PREEMPT
> [   69.125405] Hardware name: chargebyte Charge SOM Evaluation Kit (DT)
> [   69.131741] pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS
> BTYPE=--)
> [   69.138690] pc : __might_sleep+0x74/0x7c
> [   69.142608] lr : __might_sleep+0x74/0x7c
> [   69.146525] sp : ffff800081b7b710
> [   69.149827] x29: ffff800081b7b710 x28: 0000000000000080 x27:
> ffff000002cafe80
> [   69.156951] x26: ffff800081965000 x25: 0000000000000018 x24:
> 0000000000000000
> [   69.164075] x23: ffff800081b7b8f7 x22: 0000000000000000 x21:
> 0000000000000080
> [   69.171199] x20: 000000000000013c x19: ffff8000813e2880 x18:
> 0000000000000000
> [   69.178323] x17: 003fffffffffffff x16: 000000000017d600 x15:
> ffff00003fda1a00
> [   69.185447] x14: ffff000000132c00 x13: 00000000000002ce x12:
> 0000000000000000
> [   69.192571] x11: 00000000000000c0 x10: 00000000000009e0 x9 :
> ffff800081b7b580
> [   69.199695] x8 : ffff0000001335c0 x7 : ffff00003fda1280 x6 :
> 0000000000000000
> [   69.206819] x5 : 000000001fffffff x4 : 0000000000000001 x3 :
> 0000000000000010
> [   69.213943] x2 : 0000000000000000 x1 : 0000000000000000 x0 :
> ffff000000132b80
> [   69.221068] Call trace:
> [   69.223503]  __might_sleep+0x74/0x7c (P)
> [   69.227420]  mutex_lock+0x24/0x80
> [   69.230731]  spi_bus_lock+0x20/0x50
> [   69.234214]  tpm_tis_spi_transfer_full+0x70/0x2c4
> [   69.238912]  tpm_tis_spi_read_bytes+0x3c/0x48
> [   69.243263]  tpm_tis_status+0x58/0xf8
> [   69.246920]  wait_for_tpm_stat_cond+0x30/0x90
> [   69.251271]  wait_for_tpm_stat+0x1cc/0x2e0
> [   69.255361]  tpm_tis_send_data+0xdc/0x35c
> [   69.259365]  tpm_tis_send_main+0x74/0x18c
> [   69.263369]  tpm_tis_send+0xd4/0x13c
> [   69.266940]  tpm_transmit+0xc4/0x3c4
> [   69.270511]  tpm_transmit_cmd+0x38/0xd4
> [   69.274341]  tpm2_shutdown+0x6c/0xa4
> [   69.277912]  tpm_class_shutdown+0x60/0x88
> [   69.281916]  device_shutdown+0x130/0x258
> [   69.285833]  kernel_restart+0x44/0xa4
> [   69.289491]  __do_sys_reboot+0x114/0x244
> [   69.293408]  __arm64_sys_reboot+0x24/0x30
> [   69.297412]  invoke_syscall+0x54/0x10c
> [   69.301156]  el0_svc_common.constprop.0+0x40/0xe0
> [   69.305853]  do_el0_svc+0x1c/0x28
> [   69.309164]  el0_svc+0x38/0x138
> [   69.312301]  el0t_64_sync_handler+0xa0/0xe4
> [   69.316478]  el0t_64_sync+0x198/0x19c

Thank you. This bug has been active since IRQs were enabled in tpm_tis_spi.
It's quite surprising that getting a report on it has taken so many years.
Anyway, my conclusion is that the bug report is totally legit.

"state=1" in the dump above refers to TASK_INTERRUPTIBLE, which unrolled
the root cause (I believe).

Here's an experimental fix that uses wake_woken(). It ensures that we
read status only while task is running.

BR, Jarkko

--O68tc/HXB4lj4vp+
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="test.patch"

From bf458dd675988a4fd78859a3e6a348071ecd2695 Mon Sep 17 00:00:00 2001
From: Jarkko Sakkinen <jarkko@kernel.org>
Date: Sat, 9 May 2026 19:55:30 +0300
Subject: [PATCH] tpm: tpm_tis_spi: Use wait_woken() in wait_for_tmp_stat()

wait_event_interruptible_timeout() evaluates its condition after setting
the current task state to TASK_INTERRUPTIBLE.

With CONFIG_DEBUG_ATOMIC_SLEEP this triggers a warning when the IRQ wait
path is used:

    tpm_tis_status()
      tpm_tis_spi_read_bytes()
        tpm_tis_spi_transfer_full()
          spi_bus_lock()
            mutex_lock()

Address this with the following measures:

1. Call wait_tpm_stat_cond() only while tasking is running.
2. Use wait_woken() to wait for changes.

Cc: stable@vger.kernel.org # v4.19+
Cc: Linus Walleij <linusw@kernel.org>
Reported-by: Stefan Wahren <wahrenst@gmx.net>
Closes: https://lore.kernel.org/linux-integrity/6964bec7-3dbb-453b-89ef-9b990217a8b9@gmx.net/
Fixes: 1a339b658d9d ("tpm_tis_spi: Pass the SPI IRQ down to the driver")
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
---
 drivers/char/tpm/tpm_tis_core.c | 40 +++++++++++++++++++--------------
 1 file changed, 23 insertions(+), 17 deletions(-)

diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
index 21d79ad3b164..097ad0762895 100644
--- a/drivers/char/tpm/tpm_tis_core.c
+++ b/drivers/char/tpm/tpm_tis_core.c
@@ -66,8 +66,8 @@ static int wait_for_tpm_stat(struct tpm_chip *chip, u8 mask,
 		bool check_cancel)
 {
 	struct tpm_tis_data *priv = dev_get_drvdata(&chip->dev);
+	DEFINE_WAIT_FUNC(wait, woken_wake_function);
 	unsigned long stop;
-	long rc;
 	u8 status;
 	bool canceled = false;
 	u8 sts_mask;
@@ -87,23 +87,29 @@ static int wait_for_tpm_stat(struct tpm_chip *chip, u8 mask,
 	/* process status changes with irq support */
 	if (sts_mask) {
 		ret = -ETIME;
-again:
-		timeout = stop - jiffies;
-		if ((long)timeout <= 0)
-			return -ETIME;
-		rc = wait_event_interruptible_timeout(*queue,
-			wait_for_tpm_stat_cond(chip, sts_mask, check_cancel,
-					       &canceled),
-			timeout);
-		if (rc > 0) {
-			if (canceled)
-				return -ECANCELED;
-			ret = 0;
-		}
-		if (rc == -ERESTARTSYS && freezing(current)) {
-			clear_thread_flag(TIF_SIGPENDING);
-			goto again;
+		add_wait_queue(queue, &wait);
+		for (;;) {
+			if (wait_for_tpm_stat_cond(chip, sts_mask, check_cancel,
+						   &canceled)) {
+				ret = canceled ? -ECANCELED : 0;
+				break;
+			}
+
+			timeout = stop - jiffies;
+			if ((long)timeout <= 0)
+				break;
+
+			if (signal_pending(current)) {
+				if (freezing(current)) {
+					clear_thread_flag(TIF_SIGPENDING);
+					continue;
+				}
+				break;
+			}
+
+			wait_woken(&wait, TASK_INTERRUPTIBLE, timeout);
 		}
+		remove_wait_queue(queue, &wait);
 	}

 	if (ret)
--
2.47.3


--O68tc/HXB4lj4vp+--

