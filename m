Return-Path: <linux-integrity+bounces-2444-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B99998C9092
	for <lists+linux-integrity@lfdr.de>; Sat, 18 May 2024 13:22:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C03301C20DF3
	for <lists+linux-integrity@lfdr.de>; Sat, 18 May 2024 11:22:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 676F12629C;
	Sat, 18 May 2024 11:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linumiz.com header.i=@linumiz.com header.b="T7t+6AJR"
X-Original-To: linux-integrity@vger.kernel.org
Received: from omta036.useast.a.cloudfilter.net (omta036.useast.a.cloudfilter.net [44.202.169.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 802571E494
	for <linux-integrity@vger.kernel.org>; Sat, 18 May 2024 11:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716031322; cv=none; b=QpAjJuCr4lrQfU5VZrbsghP3c1s5t2qYgVapx0QYkSK++6waQlnTOsyYoFSzOBbEWe/V+mjKvd1/ocZRSctIPWW1fCwU/chdocrM3grPcg1T4U1oA8DPKNih4hqi3VdcsUQcU3xqPtFrG+aNM77Cb8WnHvjmzqodfO0cK7eEzBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716031322; c=relaxed/simple;
	bh=zHYkd1VuWjjnzZEIuSP/Fnz06nmQVhRTsZ+AdbTD/7U=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=VIqiqzJ3DETitm10rd378uuN61VIin80eZFCusb3E1vHIUUlAoGmGL2thm+MV6dLJ6u8v0Tbpf5Q2WNwls6dGndlgAD0ye2LHMskBtIHl96X5yFv6RtJJqZJtT1aaHsjX3kUoS26S5o4GnycTUzSVch4GXDooukjWcrAOOttmnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linumiz.com; spf=pass smtp.mailfrom=linumiz.com; dkim=pass (2048-bit key) header.d=linumiz.com header.i=@linumiz.com header.b=T7t+6AJR; arc=none smtp.client-ip=44.202.169.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linumiz.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linumiz.com
Received: from eig-obgw-5008a.ext.cloudfilter.net ([10.0.29.246])
	by cmsmtp with ESMTPS
	id 8HnIs8nRMAidI8I8NsPX2h; Sat, 18 May 2024 11:21:51 +0000
Received: from md-in-79.webhostbox.net ([43.225.55.182])
	by cmsmtp with ESMTPS
	id 8I8IsvjMldvsz8I8JsFuqY; Sat, 18 May 2024 11:21:48 +0000
X-Authority-Analysis: v=2.4 cv=Y6X+sAeN c=1 sm=1 tr=0 ts=66488f4c
 a=LfuyaZh/8e9VOkaVZk0aRw==:117 a=kofhyyBXuK/oEhdxNjf66Q==:17
 a=IkcTkHD0fZMA:10 a=TpHVaj0NuXgA:10 a=oz0wMknONp8A:10 a=bLk-5xynAAAA:8
 a=VwQbUJbxAAAA:8 a=vU9dKmh3AAAA:8 a=VRwkkYsinlBzF09QRo4A:9 a=QEXdDO2ut3YA:10
 a=zSyb8xVVt2t83sZkrLMb:22 a=AjGcO6oz07-iQ99wixmX:22 a=rsP06fVo5MYu2ilr0aT5:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=linumiz.com
	; s=default; h=Content-Transfer-Encoding:Content-Type:Subject:From:Cc:To:
	MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=M8NMo52btDShYrwy22WqU46BbavfaGKTsDr4nRIpSqo=; b=T7t+6AJRBwYpwv/GPWIfCEgCgX
	yNPia1LJ4/08hJA0kzNuy4oqAT0pb/DQwzQe+jDcSUqEMiSzWOtwA6c9cq/uXAVEODSbcdl/8YCb5
	/qdKkexFl4hclno6qxKRNglBZ5l0gGZMkhuicKdbx2cD0nU6p/Rz8Z+RgTvO6w2q06zbc2HTTUEmk
	nlOeu4U11JKojpwv1NBJL4EhnSuM7GVW3A1ugAu9y5m5lXoREpSf/YdZgqxB6UErhfnR6EG5eeAX+
	VRxYchTGdTBM2KV0EbnwtmVCTiXVTHmw3NagduOzDs40AHSD++T0oWO70bTzbziPdiR+CfnPsXa69
	cTc8GBDQ==;
Received: from [122.165.245.213] (port=37884 helo=[192.168.1.5])
	by md-in-79.webhostbox.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <parthiban@linumiz.com>)
	id 1s8I8G-0020Q2-25;
	Sat, 18 May 2024 16:51:44 +0530
Message-ID: <7955419c-ccc2-4a20-8ff5-07b119258415@linumiz.com>
Date: Sat, 18 May 2024 16:51:36 +0530
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: James.Bottomley@HansenPartnership.com
Cc: linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
 peterhuewe@gmx.de, jarkko@kernel.org, jgg@ziepe.ca,
 Parthiban <parthiban@linumiz.com>
From: Parthiban <parthiban@linumiz.com>
Subject: SLB9670 TPM module crash
Organization: Linumiz
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - md-in-79.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - linumiz.com
X-BWhitelist: no
X-Source-IP: 122.165.245.213
X-Source-L: No
X-Exim-ID: 1s8I8G-0020Q2-25
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.1.5]) [122.165.245.213]:37884
X-Source-Auth: parthiban@linumiz.com
X-Email-Count: 5
X-Org: HG=dishared_whb_net_legacy;ORG=directi;
X-Source-Cap: bGludW1jbWM7aG9zdGdhdG9yO21kLWluLTc5LndlYmhvc3Rib3gubmV0
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfLmAlQYnHmgowZIltKrUW3kHU8t1EXg9xoP4Bld+/RSf332gCVZK2ZBYjTGfCcso8sOtBFkIGU48Q9Q/Yz9a6oqrHRpJQFf/OYU2YyFKwEqcfHhNDcEO
 dQjOk/7OCHEpdez0FDL2acI64/zPfPdEoGCnZD9ofqfZ9l8HIpyVx9+uwlnBh8FdANUZ9Afpz5zA4SRZKq+qSTB6OTfxaDXLui4UMPjahQc90+nd0Fu9LaRb

Dear James Bottomley,

The following crash is observed in the current mainline kernel and I have tried the
git bisect to narrow it down. Bisect points to the below commit, which got merged as
part of [1]. I tried reverting the below commit and the TPM loads fine.

commit 1b6d7f9eb150305dcb0da4f7101a8d30dcdf0497
Author: James Bottomley <James.Bottomley@HansenPartnership.com>
Date:   Mon Apr 29 16:28:07 2024 -0400

    tpm: add session encryption protection to tpm2_get_random()
    
    If some entity is snooping the TPM bus, they can see the random
    numbers we're extracting from the TPM and do prediction attacks
    against their consumers.  Foil this attack by using response
    encryption to prevent the attacker from seeing the random sequence.
    
    Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
    Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
    Tested-by: Jarkko Sakkinen <jarkko@kernel.org>
    Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>

 drivers/char/tpm/tpm2-cmd.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

[   11.551988] tpm_tis_spi spi0.1: 2.0 TPM (device-id 0x1B, rev-id 22)
[   11.563036] spi_master spi0: will run message pump with realtime priority
[   11.564345] tpm tpm0: A TPM error (256) occurred attempting the self test
[   11.576709] tpm tpm0: starting up the TPM manually
[   11.576825] mcp251xfd spi0.0 can0: MCP2518FD rev0.0 (-RX_INT -PLL -MAB_NO_WARN +CRC_REG +CRC_RX +CRC_TX +ECC -HD o:40.00MHz c:40.00MHz m:10.00MHz rs:10.00MHz es:10.00MHz rf:10.00MHz ef:10.00MHz) successfully i
nitialized.
[   12.418989] ------------[ cut here ]------------
[   12.423626] WARNING: CPU: 3 PID: 173 at kernel/module/kmod.c:144 __request_module+0x1b0/0x298
[   12.432169] Modules linked in: mcp251xfd tpm_tis_spi tpm_tis_core hantro_vpu can_dev v4l2_vp9 v4l2_h264 videobuf2_dma_contig etnaviv videobuf2_memops v4l2_mem2mem videobuf2_v4l2 gpu_sched videobuf2_common drm
videodev crct10dif_ce mc onboard_usb_hub imx8m_ddrc backlight fsl_imx8_ddr_perf tmp102 rtc_rv3028 caam spi_imx at24 rtc_snvs error imx8mm_thermal pwm_imx27 imx_sdma
[   12.465135] CPU: 3 PID: 173 Comm: kworker/u16:7 Not tainted 6.9.0-gde8a0c1b43a5 #1
[   12.472709] Hardware name: PHYTEC phyGATE-Tauri-L-iMX8MM (DT)
[   12.478458] Workqueue: async async_run_entry_fn
[   12.482996] pstate: 00000005 (nzcv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[   12.489964] pc : __request_module+0x1b0/0x298
[   12.494326] lr : __request_module+0x1a8/0x298
[   12.498694] sp : ffff800082a0b520
[   12.502007] x29: ffff800082a0b520 x28: 00000000001b15d1 x27: ffff800081fef212
[   12.509155] x26: 0000000000000000 x25: 0000000000000000 x24: 0000000000000000
[   12.516303] x23: 000000000000200f x22: 0000000000000001 x21: ffff800080601d7c
[   12.523449] x20: 0000000000000000 x19: ffff80008153a260 x18: 0000000000000014
[   12.530593] x17: 00000000935207a2 x16: 00000000a4f4335b x15: 0000000098476eec
[   12.537739] x14: 0000000000000001 x13: 0000000000000000 x12: 0000000000000000
[   12.544885] x11: 000000006516c2bb x10: ffffffffff2949fe x9 : ffff8000800e3594
[   12.552031] x8 : ffff800082a0b5c8 x7 : 0000000000000000 x6 : 0c0406065b07370f
[   12.559175] x5 : 0f37075b0606040c x4 : 0000000000000000 x3 : 0000000000000030
[   12.566322] x2 : 0000000000000008 x1 : ffff8000800e3468 x0 : 0000000000000001
[   12.573473] Call trace:
[   12.575921]  __request_module+0x1b0/0x298
[   12.579941]  crypto_alg_mod_lookup+0x184/0x230
[   12.584389]  crypto_alloc_tfm_node+0x5c/0x110
[   12.588751]  crypto_alloc_shash+0x2c/0x40
[   12.592768]  drbg_init_hash_kernel+0x30/0xf0
[   12.597046]  drbg_kcapi_seed+0x218/0x3b0
[   12.600975]  crypto_rng_reset+0x8c/0xc8
[   12.604821]  crypto_get_default_rng+0xac/0xe8
[   12.609186]  ecc_gen_privkey+0x60/0xe0
[   12.612938]  ecdh_set_secret+0x98/0x1a0
[   12.616779]  tpm_buf_append_salt+0x198/0x308
[   12.621055]  tpm2_start_auth_session+0x11c/0x2d0
[   12.625677]  tpm2_get_random+0x58/0x230
[   12.629521]  tpm_get_random+0x7c/0xa0
[   12.633193]  tpm_hwrng_read+0x2c/0x40
[   12.636862]  add_early_randomness+0x70/0x128
[   12.641137]  hwrng_register+0x16c/0x220
[   12.644978]  tpm_chip_register+0x110/0x238
[   12.649079]  tpm_tis_core_init+0x494/0xf18 [tpm_tis_core]
[   12.654488]  tpm_tis_spi_probe+0xac/0xe8 [tpm_tis_spi]
[   12.659639]  tpm_tis_spi_driver_probe+0x3c/0x78 [tpm_tis_spi]
[   12.665396]  spi_probe+0x8c/0xf8
[   12.668633]  really_probe+0xc4/0x2a8
[   12.672219]  __driver_probe_device+0x80/0x140
[   12.676582]  driver_probe_device+0xe0/0x170
[   12.680776]  __driver_attach_async_helper+0x54/0xc8
[   12.685663]  async_run_entry_fn+0x3c/0xf0
[   12.689677]  process_one_work+0x160/0x3f0
[   12.693695]  worker_thread+0x304/0x420
[   12.697449]  kthread+0x11c/0x128
[   12.700682]  ret_from_fork+0x10/0x20
[   12.704267] ---[ end trace 0000000000000000 ]---

[1]: https://patchwork.kernel.org/project/linux-integrity/list/?series=804628&state=*

-- 
Thanks,
Parthiban N
https://www.linumiz.com

