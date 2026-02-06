Return-Path: <linux-integrity+bounces-8469-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SE+CDonJhWnAGAQAu9opvQ
	(envelope-from <linux-integrity+bounces-8469-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Fri, 06 Feb 2026 11:59:21 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F920FCEB8
	for <lists+linux-integrity@lfdr.de>; Fri, 06 Feb 2026 11:59:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 91A6C302D5E2
	for <lists+linux-integrity@lfdr.de>; Fri,  6 Feb 2026 10:54:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40F6A309EE7;
	Fri,  6 Feb 2026 10:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=earth.li header.i=@earth.li header.b="iQ3ytPIU"
X-Original-To: linux-integrity@vger.kernel.org
Received: from the.earth.li (the.earth.li [93.93.131.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86CFE2E8B98
	for <linux-integrity@vger.kernel.org>; Fri,  6 Feb 2026 10:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.93.131.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770375284; cv=none; b=DiClUh07eMCcI04m6R9V6BWHJQaf83InRo9vc6Y7mu9ryA+IZjVfeApKe7CC/4yqTKVdrlo5A7Mwy8HVsnxPsnLuZcO2jj8mv/ZKPSZ5h2M4dcs0kj9US+SqGcgkw3X+3a8dMALzfms7Bad6QF3nNN8b0B+lp3lq1sYS1/TjZRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770375284; c=relaxed/simple;
	bh=iDpOC0WOdRHHvccpJ5ULtKPLc8+bgp8EaSxPYyMDkTI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=R70we3uLiAWSVZfNmWAdxP9KiYd6f7hOaJqLCJ3dXaJmTCP/KfWF63i7/Q/vfhRoxF3L+BWDzsWrogvkjn/hoWEPlDXpwqZFHeWPAOnsKqBnziOA2T4ne+rW8OuwBzBQj/IJx5JUcAlGhDdIvlPPnnbEGKj8S7z2NiuxW2FLL28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=earth.li; spf=pass smtp.mailfrom=earth.li; dkim=pass (2048-bit key) header.d=earth.li header.i=@earth.li header.b=iQ3ytPIU; arc=none smtp.client-ip=93.93.131.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=earth.li
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=earth.li
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=earth.li;
	s=the; h=Content-Type:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Sender:
	Reply-To:Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date
	:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
	List-Owner:List-Archive; bh=n6fUSwaQeunYCV5FL9M5sFL4UYtx4XlxFndoriSXmVM=; b=i
	Q3ytPIUTkjpsKZO0KPoEliYN9vhM8BPwXUUDaIFDpKhzmJI2MQk9nXuNOYZpaGnp53Xi/2bPeOuF4
	wy99krjAE6wOp1rOgHmXDBW+d1qtyXIntoWcfuY4KwPHago997RTxL2Nx/kCU0YGztCWhGADnMTHK
	zz6yMmlnuOoutrWLYZm5xpbWBKJBtSFiTW78Hsx0TwG9aEaysT2vHTr5oNkImrHs0XyL8pbVv9ZGN
	3sFGBxQPrTmbwrcGwF8BheCBCoL67+2RMOxT4sVJF+7l2mymIvw904c8CC2WPXHV0T5/TGyvJpn4t
	hOPIplDOhmoR2zy54tr/dmoB/7ePgG3MA==;
Received: from noodles by the.earth.li with local (Exim 4.96)
	(envelope-from <noodles@earth.li>)
	id 1voJDe-00Cw8d-0j;
	Fri, 06 Feb 2026 10:37:46 +0000
Date: Fri, 6 Feb 2026 10:37:46 +0000
From: Jonathan McDowell <noodles@earth.li>
To: linux-integrity@vger.kernel.org, Romain Naour <romain.naour@smile.fr>
Cc: Mimi Zohar <zohar@linux.ibm.com>
Subject: IMA vs TPM (SPI) boot order problems
Message-ID: <aYXEepLhUouN5f99@earth.li>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[earth.li:s=the];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-8469-lists,linux-integrity=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[earth.li];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[earth.li:-];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[noodles@earth.li,linux-integrity@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.986];
	TAGGED_RCPT(0.00)[linux-integrity];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3F920FCEB8
X-Rspamd-Action: no action

I'm seeing an issue with a SPI attached TPM, where it's not coming up 
early enough for IMA to decide there's a TPM available that it can 
measure into. The TPM is definitely present, and by the time we get to 
userspace it's working fine.

This is sort of resurrecting a post from 2024 by Romain, though that 
concerned an i2c TPM:

https://lore.kernel.org/all/9b98d912-ba78-402c-a5c8-154bef8794f7@smile.fr/

There doesn't seem to have actually been a fixed applied, so I tried the 
late_initcall_sync suggestion, but that didn't change things:

[    0.000000] ACPI: TPM2 0x0000004044BCA998 00004C (v04 ALASKA A M I    00000001 AMI  00000000)
[    0.000000] GICv3: 960 SPIs implemented
[    0.000000] GICv3: 320 Extended SPIs implemented
[    0.000447] LSM: initializing lsm=capability,bpf,ima
[    0.394832] Trying to unpack rootfs image as initramfs...
[    0.681134] tegra-qspi NVDA1513:00: Adding to iommu group 1
[    0.681241] tegra-qspi NVDA1513:00: device reset failed
[    0.686925] tpm_tis_spi spi-PRP0001:01: 2.0 TPM (device-id 0x1B, rev-id 22)
[    0.894451] ima: No TPM chip found, activating TPM-bypass!
[    0.894462] ima: Allocated hash algorithm: sha256
[    0.894471] ima: No architecture policies found

This seems to show SPI + the TPM coming up before IMA, but still not in 
a way that makes IMA happy.

Romain, did you solve your issue in some other manner?

J.

-- 
If I want to hear the pitter patter of little feet, I'll put shoes on
my cats.

