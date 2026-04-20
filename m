Return-Path: <linux-integrity+bounces-9243-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YADZDGX/5WlEqAEAu9opvQ
	(envelope-from <linux-integrity+bounces-9243-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Mon, 20 Apr 2026 12:26:45 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B18DC429572
	for <lists+linux-integrity@lfdr.de>; Mon, 20 Apr 2026 12:26:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 79EA5303717E
	for <lists+linux-integrity@lfdr.de>; Mon, 20 Apr 2026 10:25:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF4C539768F;
	Mon, 20 Apr 2026 10:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="h5GZhZ8r"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D30E9399344
	for <linux-integrity@vger.kernel.org>; Mon, 20 Apr 2026 10:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776680739; cv=none; b=CzkUTPBzKVvB7FolGcQ9UoKdEMD0UTTeV6fF0cyygZIAXnXM5uZt+exJPiTkvUwWv9Q+87L0kaNl3M8zE+TvTZXIsPpVV+XH9TOkzfhbs+MkXwc0W4qvUoIzjDFyVgsvRHUOtBox/B5NeLJOjohmjoWAscKHUx2QyJ0OupbfLuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776680739; c=relaxed/simple;
	bh=zYRjNlpnhhnK3y9wa9/sty3xs1NiCIAa2BhJvp02deo=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=aCks71iMv9m2+qeDf8aBeuQ5q3A5eEvPQxbq/YvKDGzJkHtXJVxRm6nwb3Org/QLwookUpp3FGKWiob+MuEcZ4UTu7DLXcGTqyIRfqx+/xB4ZZMzsXM1tIZe+KkVSP/Xmd8IsWxj9KE+6tyu83u7zKnixgPUzzrDNexfbJeD18E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=h5GZhZ8r; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1776680722; x=1777285522; i=wahrenst@gmx.net;
	bh=zYRjNlpnhhnK3y9wa9/sty3xs1NiCIAa2BhJvp02deo=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:From:
	 Subject:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=h5GZhZ8r8Wrn+aoFxoX6eBMnNZCNKs/52VHmMw12O6YIYXCU/QziRv+l9VscBOl/
	 N99tsDQzHxNWUeQmpev7ltFYdQn0gurAP5asYmP8bJCyoaXHwf8XSUz0n51KBxegW
	 8LLn4b87gQ0hnfRAW9YlKZbOYljqdg9afYueP6zu1FXP8qbGIBjC852Nzd6bQnENx
	 tH/O/1tAxFWRjgwr0tG3wodoLO3D2fAkhN8XNcgWrKAl3lpRygAtwCdJpko28hJ8N
	 ej4A0hXEreaCiWTE6FDKCEJKC+wjUYo0jpPzNzq/fs05nVKWmVAK/g7mjmkYmqU5L
	 23yMYIIHo5QJbCgafQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N17Ye-1vHfpI1Qy2-00uI5W; Mon, 20
 Apr 2026 12:25:22 +0200
Message-ID: <e7974d35-0d50-4742-8747-822f28915e00@gmx.net>
Date: Mon, 20 Apr 2026 12:25:21 +0200
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Peter Huewe <peterhuewe@gmx.de>, Jarkko Sakkinen <jarkko@kernel.org>,
 Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-arm-kernel@lists.infradead.org, linux-integrity@vger.kernel.org,
 kernel@pengutronix.de, Frank Li <Frank.Li@nxp.com>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 "imx@lists.linux.dev" <imx@lists.linux.dev>
From: Stefan Wahren <wahrenst@gmx.net>
Autocrypt: addr=wahrenst@gmx.net; keydata=
 xjMEZ1dOJBYJKwYBBAHaRw8BAQdA7H2MMG3q8FV7kAPko5vOAeaa4UA1I0hMgga1j5iYTTvN
 IFN0ZWZhbiBXYWhyZW4gPHdhaHJlbnN0QGdteC5uZXQ+wo8EExYIADcWIQT3FXg+ApsOhPDN
 NNFuwvLLwiAwigUCZ1dOJAUJB4TOAAIbAwQLCQgHBRUICQoLBRYCAwEAAAoJEG7C8svCIDCK
 JQ4BAP4Y9uuHAxbAhHSQf6UZ+hl5BDznsZVBJvH8cZe2dSZ6AQCNgoc1Lxw1tvPscuC1Jd1C
 TZomrGfQI47OiiJ3vGktBc44BGdXTiQSCisGAQQBl1UBBQEBB0B5M0B2E2XxySUQhU6emMYx
 f5QR/BrEK0hs3bLT6Hb9WgMBCAfCfgQYFggAJhYhBPcVeD4Cmw6E8M000W7C8svCIDCKBQJn
 V04kBQkHhM4AAhsMAAoJEG7C8svCIDCKJxoA/i+kqD5bphZEucrJHw77ujnOQbiKY2rLb0pE
 aHMQoiECAQDVbj827W1Yai/0XEABIr8Ci6a+/qZ8Vz6MZzL5GJosAA==
Subject: tpm: spi: do not call blocking ops when !TASK_RUNNING; during
 shutdown
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:jlNMM+8img2zRmhQuN7WBKnUumUmPUwrg2CZE1aS6YlZdiVvk6g
 nfahE9WbCUqlDRvJtG9GNgYZjzkv0E6KeuGOiU+s5xNosknOujJRoUgbv887l3RBOXNygn0
 4xJaXAj4tgEhtHWt8YRmLgQb2blSXm4OebzqV6v9tLQhmn+qdRefIxtmLDQ/PsXkrVovXdF
 4zx7PhO0U5jsp03yG409A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:1e2qm3yC7PA=;ewQ4VUJnmyJHC+l00dNAF9T9CK+
 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
 GL2IooLrTxfhSOg==
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmx.net,quarantine];
	R_DKIM_ALLOW(-0.20)[gmx.net:s=s31663417];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	SUBJECT_HAS_EXCLAIM(0.00)[];
	FREEMAIL_TO(0.00)[gmx.de,kernel.org,ziepe.ca];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_FROM(0.00)[gmx.net];
	TAGGED_FROM(0.00)[bounces-9243-lists,linux-integrity=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wahrenst@gmx.net,linux-integrity@vger.kernel.org];
	DKIM_TRACE(0.00)[gmx.net:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-integrity];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B18DC429572
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,
we use a custom i.MX93 board, which based on Phytec Phycore i.MX93 with=20
a TPM connected via SPI. If I enable CONFIG_DEBUG_ATOMIC_SLEEP=3Dy in our=
=20
kernel config with mainline kernel 6.18.23 and reboot our board, I will=20
get the following warning:

[=C2=A0 =C2=A043.287416] do not call blocking ops when !TASK_RUNNING; stat=
e=3D1 set=20
at [<000000005a2107f3>] prepare_to_wait_event+0x54/0x14c
[=C2=A0 =C2=A043.299009] WARNING: CPU: 0 PID: 1 at kernel/sched/core.c:885=
7=20
__might_sleep+0x74/0x7c
[=C2=A0 =C2=A043.306920] Modules linked in: polyval_ce flexcan rtc_rv3028 =
can_dev=20
mse102x phy_can_transceiver fuse autofs4
[=C2=A0 =C2=A043.316838] CPU: 0 UID: 0 PID: 1 Comm: systemd-shutdow Not ta=
inted=20
6.18.23-00002-g626a194342f0 #2 PREEMPT
[=C2=A0 =C2=A043.326471] Hardware name: chargebyte Charge SOM Evaluation K=
it (DT)
[=C2=A0 =C2=A043.332807] pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -=
SSBS=20
BTYPE=3D--)
[=C2=A0 =C2=A043.339757] pc : __might_sleep+0x74/0x7c
[=C2=A0 =C2=A043.343675] lr : __might_sleep+0x74/0x7c
[=C2=A0 =C2=A043.347592] sp : ffff800081aab720
[=C2=A0 =C2=A043.350894] x29: ffff800081aab720 x28: 0000000000000080 x27:=
=20
ffff000000235880
[=C2=A0 =C2=A043.358018] x26: ffff800081897000 x25: 0000000000000018 x24:=
=20
0000000000000000
[=C2=A0 =C2=A043.365142] x23: ffff800081aab907 x22: 0000000000000000 x21:=
=20
0000000000000080
[=C2=A0 =C2=A043.372266] x20: 000000000000010f x19: ffff80008131cd00 x18:=
=20
0000000000000001
[=C2=A0 =C2=A043.379390] x17: 0000000000000000 x16: 000000000017d600 x15:=
=20
ffff00003fda4680
[=C2=A0 =C2=A043.386514] x14: 0000000000017e01 x13: 0000000000000209 x12:=
=20
0000000000000000
[=C2=A0 =C2=A043.393638] x11: 00000000000000c0 x10: 0000000000000950 x9 :=
=20
ffff800081aab5a0
[=C2=A0 =C2=A043.400762] x8 : ffff0000000d89b0 x7 : ffff00003fda3f00 x6 :=
=20
000000013417d29a
[=C2=A0 =C2=A043.407886] x5 : 0000000000000000 x4 : 0000000000000002 x3 :=
=20
0000000000000010
[=C2=A0 =C2=A043.415010] x2 : 0000000000000000 x1 : 0000000000000000 x0 :=
=20
ffff0000000d8000
[=C2=A0 =C2=A043.422135] Call trace:
[=C2=A0 =C2=A043.424570]=C2=A0 __might_sleep+0x74/0x7c (P)
[=C2=A0 =C2=A043.428487]=C2=A0 mutex_lock+0x24/0x80
[=C2=A0 =C2=A043.431797]=C2=A0 spi_bus_lock+0x20/0x50
[=C2=A0 =C2=A043.435281]=C2=A0 tpm_tis_spi_transfer_full+0x70/0x2c4
[=C2=A0 =C2=A043.439979]=C2=A0 tpm_tis_spi_read_bytes+0x3c/0x48
[=C2=A0 =C2=A043.444321]=C2=A0 tpm_tis_status+0x58/0xf8
[=C2=A0 =C2=A043.447978]=C2=A0 wait_for_tpm_stat_cond+0x30/0x90
[=C2=A0 =C2=A043.452329]=C2=A0 wait_for_tpm_stat+0x1cc/0x2e0
[=C2=A0 =C2=A043.456419]=C2=A0 tpm_tis_send_data+0xdc/0x334
[=C2=A0 =C2=A043.460423]=C2=A0 tpm_tis_send_main+0x74/0x160
[=C2=A0 =C2=A043.464427]=C2=A0 tpm_tis_send+0xd4/0x13c
[=C2=A0 =C2=A043.467998]=C2=A0 tpm_transmit+0xc4/0x3c4
[=C2=A0 =C2=A043.471569]=C2=A0 tpm_transmit_cmd+0x38/0xd4
[=C2=A0 =C2=A043.475399]=C2=A0 tpm2_shutdown+0x6c/0xa4
[=C2=A0 =C2=A043.478970]=C2=A0 tpm_class_shutdown+0x60/0x88
[=C2=A0 =C2=A043.482974]=C2=A0 device_shutdown+0x130/0x25c
[=C2=A0 =C2=A043.486891]=C2=A0 kernel_restart+0x44/0xa4
[=C2=A0 =C2=A043.490549]=C2=A0 __do_sys_reboot+0x114/0x254
[=C2=A0 =C2=A043.494466]=C2=A0 __arm64_sys_reboot+0x24/0x30
[=C2=A0 =C2=A043.498470]=C2=A0 invoke_syscall+0x48/0x10c
[=C2=A0 =C2=A043.502214]=C2=A0 el0_svc_common.constprop.0+0x40/0xe0
[=C2=A0 =C2=A043.506911]=C2=A0 do_el0_svc+0x1c/0x28
[=C2=A0 =C2=A043.510222]=C2=A0 el0_svc+0x34/0xec
[=C2=A0 =C2=A043.513273]=C2=A0 el0t_64_sync_handler+0xa0/0xe4
[=C2=A0 =C2=A043.517441]=C2=A0 el0t_64_sync+0x198/0x19c

Best regards

