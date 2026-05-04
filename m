Return-Path: <linux-integrity+bounces-9411-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GLdwOFmi+GlExQIAu9opvQ
	(envelope-from <linux-integrity+bounces-9411-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Mon, 04 May 2026 15:42:49 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5858B4BE00B
	for <lists+linux-integrity@lfdr.de>; Mon, 04 May 2026 15:42:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3DC6D3012BD5
	for <lists+linux-integrity@lfdr.de>; Mon,  4 May 2026 13:42:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01F7C3A3E86;
	Mon,  4 May 2026 13:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zrh5lzVf"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF66F39DBED;
	Mon,  4 May 2026 13:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777902165; cv=none; b=OteL7U5mLw0xBNU5LxlyX386Jprbg9hm2eNs+0pAYj1FJOOJ5+ZRmU35TEkR6JnkStCeIg+J6y4PxsXKbyiBqWzZDwWX2A7UziDXcEAPeaj/Uo+dEPC3BV/VxFVbN8JLPqigLh28cKd0TRYL7fIveh0OTfEcGpe8Jtmu0RzGxL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777902165; c=relaxed/simple;
	bh=8tSxUuDeUyvAzyJEtbx33GrMXbNrQ8yGPFNRsdz/Gs8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F3DYUDnjtWG7pWSiIkrQQPoX6faGs721Xf1sjZLPEZKleZy7eeiLCcfdn/0P6EXd06sJlTrMrLZKDXveq+W6WtHbXRelJTz1KkZb+QFeNX3R+2D9SApJxvcIx2St9i1sEZHh7+jLGjadFaDCNwlL+shUi3gUC6u8hiNumLQnQm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zrh5lzVf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59ADDC2BCB8;
	Mon,  4 May 2026 13:42:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777902165;
	bh=8tSxUuDeUyvAzyJEtbx33GrMXbNrQ8yGPFNRsdz/Gs8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Zrh5lzVfDhZEsk2qhy4yS5mwhpiYAWQXd41K5Z+bqFwH7Uzmef/Z8XTg/NHKKI0hD
	 TVmdh+yKwg03VNygJ9vobHiCUrYkun7ThShNwwaEs1ATuiAw1F9ggDcNryy26TvPzQ
	 gA5T2CYQE43C+HM2mzetxkuUprqZdZOHII6qR2Y0EUKQJ++T5+knqWzFmwmfMFMkEM
	 VGuzKVCJWuVeo/lbTpKJnLxDV4pz7WDIKI4V1etF4iKaKUBqb+MH+OKHRwvJ8QDfid
	 hQf9kmW4NYN5sJ5qqXcFu8044fZxP1wIuC5rXJ8H1dFkRJ+bif39CBxKiyOs78C8T/
	 DYlhXoJuklPpA==
Date: Mon, 4 May 2026 16:42:41 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Stefan Wahren <wahrenst@gmx.net>
Cc: Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	linux-arm-kernel@lists.infradead.org,
	linux-integrity@vger.kernel.org, kernel@pengutronix.de,
	Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>
Subject: Re: tpm: spi: do not call blocking ops when !TASK_RUNNING; during
 shutdown
Message-ID: <afiiUdFv7p0fuK-5@kernel.org>
References: <e7974d35-0d50-4742-8747-822f28915e00@gmx.net>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e7974d35-0d50-4742-8747-822f28915e00@gmx.net>
X-Rspamd-Queue-Id: 5858B4BE00B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9411-lists,linux-integrity=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	SUBJECT_HAS_EXCLAIM(0.00)[];
	FREEMAIL_TO(0.00)[gmx.net];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[gmx.de,ziepe.ca,lists.infradead.org,vger.kernel.org,pengutronix.de,nxp.com,lists.linux.dev];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jarkko@kernel.org,linux-integrity@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-integrity];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

Hi Stefan,

On Mon, Apr 20, 2026 at 12:25:21PM +0200, Stefan Wahren wrote:
> Hi,
> we use a custom i.MX93 board, which based on Phytec Phycore i.MX93 with a
> TPM connected via SPI. If I enable CONFIG_DEBUG_ATOMIC_SLEEP=y in our kernel
> config with mainline kernel 6.18.23 and reboot our board, I will get the
> following warning:

Please provide results with the latest mainline kernel.

> 
> [   43.287416] do not call blocking ops when !TASK_RUNNING; state=1 set at
> [<000000005a2107f3>] prepare_to_wait_event+0x54/0x14c
> [   43.299009] WARNING: CPU: 0 PID: 1 at kernel/sched/core.c:8857
> __might_sleep+0x74/0x7c
> [   43.306920] Modules linked in: polyval_ce flexcan rtc_rv3028 can_dev
> mse102x phy_can_transceiver fuse autofs4
> [   43.316838] CPU: 0 UID: 0 PID: 1 Comm: systemd-shutdow Not tainted
> 6.18.23-00002-g626a194342f0 #2 PREEMPT
> [   43.326471] Hardware name: chargebyte Charge SOM Evaluation Kit (DT)
> [   43.332807] pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS
> BTYPE=--)
> [   43.339757] pc : __might_sleep+0x74/0x7c
> [   43.343675] lr : __might_sleep+0x74/0x7c
> [   43.347592] sp : ffff800081aab720
> [   43.350894] x29: ffff800081aab720 x28: 0000000000000080 x27:
> ffff000000235880
> [   43.358018] x26: ffff800081897000 x25: 0000000000000018 x24:
> 0000000000000000
> [   43.365142] x23: ffff800081aab907 x22: 0000000000000000 x21:
> 0000000000000080
> [   43.372266] x20: 000000000000010f x19: ffff80008131cd00 x18:
> 0000000000000001
> [   43.379390] x17: 0000000000000000 x16: 000000000017d600 x15:
> ffff00003fda4680
> [   43.386514] x14: 0000000000017e01 x13: 0000000000000209 x12:
> 0000000000000000
> [   43.393638] x11: 00000000000000c0 x10: 0000000000000950 x9 :
> ffff800081aab5a0
> [   43.400762] x8 : ffff0000000d89b0 x7 : ffff00003fda3f00 x6 :
> 000000013417d29a
> [   43.407886] x5 : 0000000000000000 x4 : 0000000000000002 x3 :
> 0000000000000010
> [   43.415010] x2 : 0000000000000000 x1 : 0000000000000000 x0 :
> ffff0000000d8000
> [   43.422135] Call trace:
> [   43.424570]  __might_sleep+0x74/0x7c (P)
> [   43.428487]  mutex_lock+0x24/0x80
> [   43.431797]  spi_bus_lock+0x20/0x50
> [   43.435281]  tpm_tis_spi_transfer_full+0x70/0x2c4
> [   43.439979]  tpm_tis_spi_read_bytes+0x3c/0x48
> [   43.444321]  tpm_tis_status+0x58/0xf8
> [   43.447978]  wait_for_tpm_stat_cond+0x30/0x90
> [   43.452329]  wait_for_tpm_stat+0x1cc/0x2e0
> [   43.456419]  tpm_tis_send_data+0xdc/0x334
> [   43.460423]  tpm_tis_send_main+0x74/0x160
> [   43.464427]  tpm_tis_send+0xd4/0x13c
> [   43.467998]  tpm_transmit+0xc4/0x3c4
> [   43.471569]  tpm_transmit_cmd+0x38/0xd4
> [   43.475399]  tpm2_shutdown+0x6c/0xa4
> [   43.478970]  tpm_class_shutdown+0x60/0x88
> [   43.482974]  device_shutdown+0x130/0x25c
> [   43.486891]  kernel_restart+0x44/0xa4
> [   43.490549]  __do_sys_reboot+0x114/0x254
> [   43.494466]  __arm64_sys_reboot+0x24/0x30
> [   43.498470]  invoke_syscall+0x48/0x10c
> [   43.502214]  el0_svc_common.constprop.0+0x40/0xe0
> [   43.506911]  do_el0_svc+0x1c/0x28
> [   43.510222]  el0_svc+0x34/0xec
> [   43.513273]  el0t_64_sync_handler+0xa0/0xe4
> [   43.517441]  el0t_64_sync+0x198/0x19c
> 
> Best regards

BR, Jarkko

