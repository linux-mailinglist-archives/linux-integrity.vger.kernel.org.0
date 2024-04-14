Return-Path: <linux-integrity+bounces-2110-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4CB98A3FD1
	for <lists+linux-integrity@lfdr.de>; Sun, 14 Apr 2024 03:05:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1FE13B21109
	for <lists+linux-integrity@lfdr.de>; Sun, 14 Apr 2024 01:05:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E8F612B8B;
	Sun, 14 Apr 2024 01:05:13 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx.ewheeler.net (mx.ewheeler.net [173.205.220.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 091FD12B82
	for <linux-integrity@vger.kernel.org>; Sun, 14 Apr 2024 01:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.205.220.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713056713; cv=none; b=heEi3LRHZ9bhFaM/M+GBbczn18rt+F5FrYlmaQCaaC4xZlc2FnMswnUfAgazRNpqD7+ikHewhCQEkvKTH7NnKI15mtPkDhyzTFi+EenjzuSUe7udiOIDGGlTjNK4rk6yrVIeP3veyhv6TOw735mKT7sAORgZkK4T7VIdNF0/t98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713056713; c=relaxed/simple;
	bh=4E0TTw6RR68WfgNW/RnAKKJCt/LnlEg00wWjrUBSu+U=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type; b=loLa1dI5QVwPER65qioLV+F83Rhr6GjCS3i4MdKCcpXJjGQ2qRPNEfcuYtQoQ9V/ozs1HgONFcsgh2yiVtw6PUbJShc50d+suNGs5mUFv9K3K8n+ZszPswriv9XSFr9f3jCZ+30O5aDGAeSGDrs3AW745LXu/nqCfQg9q+SIEjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lists.ewheeler.net; spf=none smtp.mailfrom=lists.ewheeler.net; arc=none smtp.client-ip=173.205.220.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lists.ewheeler.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=lists.ewheeler.net
Received: from localhost (localhost [127.0.0.1])
	by mx.ewheeler.net (Postfix) with ESMTP id 693A247
	for <linux-integrity@vger.kernel.org>; Sat, 13 Apr 2024 18:05:11 -0700 (PDT)
X-Virus-Scanned: amavisd-new at ewheeler.net
Received: from mx.ewheeler.net ([127.0.0.1])
	by localhost (mx.ewheeler.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id zKoz4gNvb0E1 for <linux-integrity@vger.kernel.org>;
	Sat, 13 Apr 2024 18:05:10 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx.ewheeler.net (Postfix) with ESMTPSA id 4B97845
	for <linux-integrity@vger.kernel.org>; Sat, 13 Apr 2024 18:05:10 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx.ewheeler.net 4B97845
Date: Sat, 13 Apr 2024 18:05:10 -0700 (PDT)
From: Eric Wheeler <linux-integrity@lists.ewheeler.net>
To: linux-integrity@vger.kernel.org
Subject: dm-integrity: 4k devices report 512b discard alignment
Message-ID: <447e2027-bfe2-9c21-a5ad-291e16b78f28@ewheeler.net>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

Hello all,

I'm not sure if this is a bug or a feature, so thought I'd report it.
These are all for Linux 6.6.26:

If you start with a 512-byte backing device (logical and physical):
  # blockdev --getss --getpbsz  /dev/nvme9n9
  512
  512

then format+open with 4k sectors:
  # integritysetup format -s 4096 /dev/nvme9n9
  # integritysetup open /dev/nvme9n9 integrity-nvme9n9

and find the dm-X device:
  # ls -l /dev/mapper/integrity-nvme9n9
  lrwxrwxrwx. 1 root root 9 Apr 13 17:09 /dev/mapper/integrity-nvme9n9 -> ../dm-189

then check it's discard_granularity, it shows 512:
  # tail /sys/block/dm-189/queue/discard_*
  ==> /sys/block/dm-189/queue/discard_granularity <==
  512

The sector size is 4k, so supporting unaligned discards seems at least
strange, if not invalid, and dmesg complains too:
  # blockdev --getss /dev/mapper/integrity-nvme9n9
  4096

Relatedly, should the physical size of an integrity volume "properly"
report 512 to match the backing device, or is 4k correct in this case?
Presently it reports 4k:
  # blockdev --getpbsz /dev/mapper/integrity-nvme2n1
  4096

Finally, this is what made me go investiage: when you issue `blkdiscard`
on the integrity volume:
  # blkdiscard /dev/mapper/integrity-nvme9n9

it causes dmesg spews the following:
[ 2508.364637] device-mapper: integrity: Bio not aligned on 8 sectors: 0x74ff8000, 0x7f0f
[ 2508.364856] device-mapper: integrity: Bio not aligned on 8 sectors: 0x74ffff16, 0xea
[ 2508.365070] device-mapper: integrity: Bio not aligned on 8 sectors: 0x757fff0e, 0x7
[ 2508.365973] device-mapper: integrity: Bio not aligned on 8 sectors: 0x757f8000, 0x7f0e

What do you think?


--
Eric Wheeler

