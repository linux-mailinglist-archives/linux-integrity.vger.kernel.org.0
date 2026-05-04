Return-Path: <linux-integrity+bounces-9414-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mJlENL7E+GlQ0gIAu9opvQ
	(envelope-from <linux-integrity+bounces-9414-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Mon, 04 May 2026 18:09:34 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 35A9E4C1302
	for <lists+linux-integrity@lfdr.de>; Mon, 04 May 2026 18:09:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5AF5B301B918
	for <lists+linux-integrity@lfdr.de>; Mon,  4 May 2026 16:05:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D24E93DEAED;
	Mon,  4 May 2026 16:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="AR1TitMf"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A94AE37883D
	for <linux-integrity@vger.kernel.org>; Mon,  4 May 2026 16:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777910740; cv=none; b=bLdZ0T+be858ezewdo3VA6kujh/61YgdTQexKTgVkTtEXRaNnKraK4dZIj9AMUi012Lelzv33LYV72Hux7/XCUQtqVusmCLzDOPG1g2gNBDXuwi9YXty2N7U8AEW1AxAC4seRRid+PD/TtTJQmnuz6zxbTicAq23dxWYD61sS7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777910740; c=relaxed/simple;
	bh=wThVEhDgSbCnQM85Le2LRc0qrdkqcfV+fEMFRwjnpbM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E+BAEYlIk3CzF9jT8LdCoNWPJXl1IY2178cDKRZI/PXRAYFNCjQ1r0L9TrrSGncDVjw8zzh9ckRiyHRc0Y31PiwRAXF+HQXrGrHNKGyU0HQr18DyMTbr+k9Pym5tmUK/xqEhsEmsX5ncL5NamsJGfmPHuJuOG15DpsfYKQ5VNk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=AR1TitMf; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1777910726; x=1778515526; i=wahrenst@gmx.net;
	bh=wThVEhDgSbCnQM85Le2LRc0qrdkqcfV+fEMFRwjnpbM=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=AR1TitMf2fH+ii5SpE/iFG1MPHUzS8Epgibt9cUr+VQslyAH8k7u2bSmMruZ12fb
	 aVPeTgjLXYMjoB9a4YhtHG64gzXv2OKG8UPkfn7Y7mLX1pi0R2JL6hfdjAY7QI8k3
	 nn/BU/1hvpjHpU2xBBNsxEpJBG5JlYN54Kk6fjlIwa/nLMLjNHBIK08ReNmNCFj+i
	 h3SEDxim5SukQ85Zjf8np1QX9NtQ7NR87FovYcM/e9ZMv//OuKq8ZMN/auUMsxQRl
	 kky4E2m6Y1XPFtl3q3u3SZN8nHSJMNRQQ9EmBbTTnK6nmzAO1I1ibyp+sYVF2WAn8
	 ppATna2n8ZU4vPjFnA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MJE2D-1w0tTh2llz-00U14Z; Mon, 04
 May 2026 18:05:26 +0200
Message-ID: <6964bec7-3dbb-453b-89ef-9b990217a8b9@gmx.net>
Date: Mon, 4 May 2026 18:05:25 +0200
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: tpm: spi: do not call blocking ops when !TASK_RUNNING; during
 shutdown
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
 linux-arm-kernel@lists.infradead.org, linux-integrity@vger.kernel.org,
 kernel@pengutronix.de, Frank Li <Frank.Li@nxp.com>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 "imx@lists.linux.dev" <imx@lists.linux.dev>
References: <e7974d35-0d50-4742-8747-822f28915e00@gmx.net>
 <afiiUdFv7p0fuK-5@kernel.org>
Content-Language: en-US
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
In-Reply-To: <afiiUdFv7p0fuK-5@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:062LCKQxtmUhtLKSyuTqX2f5CI8ASU3824mUzYxCGO/ePHjJ2Q4
 P/th2jR57VtMzThmmPKM2orPQdRiDwi8RcB0VDEKuO94QwZrcuJ4v9CJkng5xFwkuKZjwek
 TlRWDrSA42ASXC7looRUg4EeO5CmwR/ifl/14LXHp9gYWMiIgp5Y01037f4VkCX6eENkK+B
 P9EKmhK3BNQOzb1uNengw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:+bOXf5rZ1K4=;TrI3gB53qPTIc+XUpxlXb+62bcP
 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
 ffhwm8oYBYPadyMwY/RMQlwMBqQ=
X-Rspamd-Queue-Id: 35A9E4C1302
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmx.net,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmx.net:s=s31663417];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9414-lists,linux-integrity=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	SUBJECT_HAS_EXCLAIM(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_FROM(0.00)[gmx.net];
	FREEMAIL_CC(0.00)[gmx.de,ziepe.ca,lists.infradead.org,vger.kernel.org,pengutronix.de,nxp.com,lists.linux.dev];
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

Am 04.05.26 um 15:42 schrieb Jarkko Sakkinen:
> Hi Stefan,
>
> On Mon, Apr 20, 2026 at 12:25:21PM +0200, Stefan Wahren wrote:
>> Hi,
>> we use a custom i.MX93 board, which based on Phytec Phycore i.MX93 with=
 a
>> TPM connected via SPI. If I enable CONFIG_DEBUG_ATOMIC_SLEEP=3Dy in our=
 kernel
>> config with mainline kernel 6.18.23 and reboot our board, I will get th=
e
>> following warning:
> Please provide results with the latest mainline kernel.
>
Here you are

[=C2=A0 =C2=A069.085410] do not call blocking ops when !TASK_RUNNING; stat=
e=3D1 set=20
at [<0000000090f4020f>] prepare_to_wait_event+0x54/0x14c
[=C2=A0 =C2=A069.097076] WARNING: kernel/sched/core.c:9086 at=20
__might_sleep+0x74/0x7c, CPU#0: systemd-shutdow/1
[=C2=A0 =C2=A069.106026] Modules linked in: flexcan can_dev rtc_rv3028 mse=
102x=20
phy_can_transceiver fuse autofs4
[=C2=A0 =C2=A069.114991] CPU: 0 UID: 0 PID: 1 Comm: systemd-shutdow Not ta=
inted=20
7.1.0-rc2-00005-g6d35786de281-dirty #45 PREEMPT
[=C2=A0 =C2=A069.125405] Hardware name: chargebyte Charge SOM Evaluation K=
it (DT)
[=C2=A0 =C2=A069.131741] pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -=
SSBS=20
BTYPE=3D--)
[=C2=A0 =C2=A069.138690] pc : __might_sleep+0x74/0x7c
[=C2=A0 =C2=A069.142608] lr : __might_sleep+0x74/0x7c
[=C2=A0 =C2=A069.146525] sp : ffff800081b7b710
[=C2=A0 =C2=A069.149827] x29: ffff800081b7b710 x28: 0000000000000080 x27:=
=20
ffff000002cafe80
[=C2=A0 =C2=A069.156951] x26: ffff800081965000 x25: 0000000000000018 x24:=
=20
0000000000000000
[=C2=A0 =C2=A069.164075] x23: ffff800081b7b8f7 x22: 0000000000000000 x21:=
=20
0000000000000080
[=C2=A0 =C2=A069.171199] x20: 000000000000013c x19: ffff8000813e2880 x18:=
=20
0000000000000000
[=C2=A0 =C2=A069.178323] x17: 003fffffffffffff x16: 000000000017d600 x15:=
=20
ffff00003fda1a00
[=C2=A0 =C2=A069.185447] x14: ffff000000132c00 x13: 00000000000002ce x12:=
=20
0000000000000000
[=C2=A0 =C2=A069.192571] x11: 00000000000000c0 x10: 00000000000009e0 x9 :=
=20
ffff800081b7b580
[=C2=A0 =C2=A069.199695] x8 : ffff0000001335c0 x7 : ffff00003fda1280 x6 :=
=20
0000000000000000
[=C2=A0 =C2=A069.206819] x5 : 000000001fffffff x4 : 0000000000000001 x3 :=
=20
0000000000000010
[=C2=A0 =C2=A069.213943] x2 : 0000000000000000 x1 : 0000000000000000 x0 :=
=20
ffff000000132b80
[=C2=A0 =C2=A069.221068] Call trace:
[=C2=A0 =C2=A069.223503]=C2=A0 __might_sleep+0x74/0x7c (P)
[=C2=A0 =C2=A069.227420]=C2=A0 mutex_lock+0x24/0x80
[=C2=A0 =C2=A069.230731]=C2=A0 spi_bus_lock+0x20/0x50
[=C2=A0 =C2=A069.234214]=C2=A0 tpm_tis_spi_transfer_full+0x70/0x2c4
[=C2=A0 =C2=A069.238912]=C2=A0 tpm_tis_spi_read_bytes+0x3c/0x48
[=C2=A0 =C2=A069.243263]=C2=A0 tpm_tis_status+0x58/0xf8
[=C2=A0 =C2=A069.246920]=C2=A0 wait_for_tpm_stat_cond+0x30/0x90
[=C2=A0 =C2=A069.251271]=C2=A0 wait_for_tpm_stat+0x1cc/0x2e0
[=C2=A0 =C2=A069.255361]=C2=A0 tpm_tis_send_data+0xdc/0x35c
[=C2=A0 =C2=A069.259365]=C2=A0 tpm_tis_send_main+0x74/0x18c
[=C2=A0 =C2=A069.263369]=C2=A0 tpm_tis_send+0xd4/0x13c
[=C2=A0 =C2=A069.266940]=C2=A0 tpm_transmit+0xc4/0x3c4
[=C2=A0 =C2=A069.270511]=C2=A0 tpm_transmit_cmd+0x38/0xd4
[=C2=A0 =C2=A069.274341]=C2=A0 tpm2_shutdown+0x6c/0xa4
[=C2=A0 =C2=A069.277912]=C2=A0 tpm_class_shutdown+0x60/0x88
[=C2=A0 =C2=A069.281916]=C2=A0 device_shutdown+0x130/0x258
[=C2=A0 =C2=A069.285833]=C2=A0 kernel_restart+0x44/0xa4
[=C2=A0 =C2=A069.289491]=C2=A0 __do_sys_reboot+0x114/0x244
[=C2=A0 =C2=A069.293408]=C2=A0 __arm64_sys_reboot+0x24/0x30
[=C2=A0 =C2=A069.297412]=C2=A0 invoke_syscall+0x54/0x10c
[=C2=A0 =C2=A069.301156]=C2=A0 el0_svc_common.constprop.0+0x40/0xe0
[=C2=A0 =C2=A069.305853]=C2=A0 do_el0_svc+0x1c/0x28
[=C2=A0 =C2=A069.309164]=C2=A0 el0_svc+0x38/0x138
[=C2=A0 =C2=A069.312301]=C2=A0 el0t_64_sync_handler+0xa0/0xe4
[=C2=A0 =C2=A069.316478]=C2=A0 el0t_64_sync+0x198/0x19c

