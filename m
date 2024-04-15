Return-Path: <linux-integrity+bounces-2119-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A787E8A46A9
	for <lists+linux-integrity@lfdr.de>; Mon, 15 Apr 2024 03:56:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D0FF1F21966
	for <lists+linux-integrity@lfdr.de>; Mon, 15 Apr 2024 01:56:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F33B6FCA;
	Mon, 15 Apr 2024 01:56:51 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx.ewheeler.net (mx.ewheeler.net [173.205.220.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED97617F8
	for <linux-integrity@vger.kernel.org>; Mon, 15 Apr 2024 01:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.205.220.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713146211; cv=none; b=OjfC0lswj3WhDsVLL44VAn8kf5AAsKIRh15Kgk3GLCUpeR2VZSRhaL6Iyr4qrGECfL0/mx1anu1W6Mc9NwzxV8rVIF88ap1LOctF/6XQVAAy/79sXogZHn+PHS0hAsTi0SvUO1uc8QA1SDXs8rf7SVZLIvQ8nS8VHiU8O8pk+z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713146211; c=relaxed/simple;
	bh=x2mN3aGMBIqilMtANepKQisyHifjx+YP8B1AYfux+RQ=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=gMRkauixfJUdGGBQ5MxqTHCqx6s4L41pO1OJNdnjBe31lrHXzr92LlIMwX+WwI5AcsiINxykhV2g+qxH6Ya/pgoY5Qnry+43OVHHgOFVapwfbz4MzelLoUwclVz0Q/feLJ7e3Z/RW1I3PKdGGFdRChzXG5f4tmE+3noP3VRG6m0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lists.ewheeler.net; spf=none smtp.mailfrom=lists.ewheeler.net; arc=none smtp.client-ip=173.205.220.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lists.ewheeler.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=lists.ewheeler.net
Received: from localhost (localhost [127.0.0.1])
	by mx.ewheeler.net (Postfix) with ESMTP id 782AF46;
	Sun, 14 Apr 2024 18:56:43 -0700 (PDT)
X-Virus-Scanned: amavisd-new at ewheeler.net
Received: from mx.ewheeler.net ([127.0.0.1])
	by localhost (mx.ewheeler.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id IDEniheN284g; Sun, 14 Apr 2024 18:56:42 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx.ewheeler.net (Postfix) with ESMTPSA id 5C15945;
	Sun, 14 Apr 2024 18:56:42 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx.ewheeler.net 5C15945
Date: Sun, 14 Apr 2024 18:56:42 -0700 (PDT)
From: Eric Wheeler <linux-integrity@lists.ewheeler.net>
To: Milan Broz <gmazyland@gmail.com>
cc: linux-integrity@vger.kernel.org, 
    "dm-devel@lists.linux.dev" <dm-devel@lists.linux.dev>, 
    Mikulas Patocka <mpatocka@redhat.com>
Subject: Re: dm-integrity: 4k devices report 512b discard alignment
In-Reply-To: <acd54b09-c5b9-4548-a24f-95c503e20139@gmail.com>
Message-ID: <fd71431e-16f0-4834-6ff-c42ff9b391a@ewheeler.net>
References: <447e2027-bfe2-9c21-a5ad-291e16b78f28@ewheeler.net> <acd54b09-c5b9-4548-a24f-95c503e20139@gmail.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1606257909-1713146202=:29291"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1606257909-1713146202=:29291
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Sun, 14 Apr 2024, Milan Broz wrote:
> On 4/14/24 3:05 AM, Eric Wheeler wrote:
> > Hello all,
> > 
> > I'm not sure if this is a bug or a feature, so thought I'd report it.
> > These are all for Linux 6.6.26:
> > 
> > If you start with a 512-byte backing device (logical and physical):
> >    # blockdev --getss --getpbsz  /dev/nvme9n9
> >    512
> >    512
> 
> Hi,
> 
> this looks wrong. But you should send it to dm-devel list (added to cc) ...
> 
> Maybe also add lsblk -D (and lsblk -t for block sizes)
> (where you can see inherited values for all layers).

ok here it is for the same 6.6.27. 

# lsblk -o NAME,MIN-IO,PHY-SEC,LOG-SEC,DISC-GRAN,DISC-MAX /dev/nvme[12]n1
NAME                           MIN-IO PHY-SEC LOG-SEC DISC-GRAN DISC-MAX
nvme2n1                           512     512     512      512B       2T
└─integrity-0025385681b3003f     4096    4096    4096      512B       2T
  └─md2                      16777216    4096    4096      512B       2T

nvme1n1                           512     512     512      512B       2T
└─integrity-0025385681b30055     4096    4096    4096      512B       2T
  └─md2                      16777216    4096    4096      512B       2T


> And I see similar problem in dm-crypt with 4k sector but 512B discard
> granularity
> (on 6.8.4 - LUKS with forced 4k sector and alllow_discards).
> 
> What is interesting, for current Linus' tree I see discard granularity 0 (?),
> but
> with Mike's DM for-next (with use queue_limits_set fixes) it correctly shows
> 4k.
> 
> (Ditto for your integrity case. So perhaps linux-next is fixed.)

Good to know.

Do you know which commit might fix this for stable, and was it marked `Cc: stable@`?


--
Eric Wheeler



> 
> Milan
> 
> 
> 
> > 
> > then format+open with 4k sectors:
> >    # integritysetup format -s 4096 /dev/nvme9n9
> >    # integritysetup open /dev/nvme9n9 integrity-nvme9n9
> > 
> > and find the dm-X device:
> >    # ls -l /dev/mapper/integrity-nvme9n9
> >    lrwxrwxrwx. 1 root root 9 Apr 13 17:09 /dev/mapper/integrity-nvme9n9 ->
> >    ../dm-189
> > 
> > then check it's discard_granularity, it shows 512:
> >    # tail /sys/block/dm-189/queue/discard_*
> >    ==> /sys/block/dm-189/queue/discard_granularity <==
> >    512
> > 
> > The sector size is 4k, so supporting unaligned discards seems at least
> > strange, if not invalid, and dmesg complains too:
> >    # blockdev --getss /dev/mapper/integrity-nvme9n9
> >    4096
> > 
> > Relatedly, should the physical size of an integrity volume "properly"
> > report 512 to match the backing device, or is 4k correct in this case?
> > Presently it reports 4k:
> >    # blockdev --getpbsz /dev/mapper/integrity-nvme2n1
> >    4096
> > 
> > Finally, this is what made me go investiage: when you issue `blkdiscard`
> > on the integrity volume:
> >    # blkdiscard /dev/mapper/integrity-nvme9n9
> > 
> > it causes dmesg spews the following:
> > [ 2508.364637] device-mapper: integrity: Bio not aligned on 8 sectors:
> > 0x74ff8000, 0x7f0f
> > [ 2508.364856] device-mapper: integrity: Bio not aligned on 8 sectors:
> > 0x74ffff16, 0xea
> > [ 2508.365070] device-mapper: integrity: Bio not aligned on 8 sectors:
> > 0x757fff0e, 0x7
> > [ 2508.365973] device-mapper: integrity: Bio not aligned on 8 sectors:
> > 0x757f8000, 0x7f0e
> > 
> > What do you think?
> > 
> > 
> > --
> > Eric Wheeler
> 
> 
--8323328-1606257909-1713146202=:29291--

