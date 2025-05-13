Return-Path: <linux-integrity+bounces-6185-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C7336AB4A43
	for <lists+linux-integrity@lfdr.de>; Tue, 13 May 2025 05:55:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57D044660B5
	for <lists+linux-integrity@lfdr.de>; Tue, 13 May 2025 03:55:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B336F78F4B;
	Tue, 13 May 2025 03:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="PQGdo0DU"
X-Original-To: linux-integrity@vger.kernel.org
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18DD579D0
	for <linux-integrity@vger.kernel.org>; Tue, 13 May 2025 03:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747108535; cv=none; b=mjLG53cD2/DOLmHJ1oE4WkX2yJ/TGwJoz1x+2zuvf1JYyIHh3vLRh7OkFg9hUdV+B6V/pRjiqy+scU44xiuDf6DXijv14ckILHQtMu+rqEySnLPbMPfVBLKTYb4N2HzwHVCBq8xDZkpLCb4cTVItNvqpGbtUkSeuNfeHMdOM4I0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747108535; c=relaxed/simple;
	bh=un84Xmb0Xo7JYjp9UOrX0Xbfc+GNtMwAveY0q7bNW6s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qoc+8oF2ojNBIuBmKuhSS9DQEU0AVVZqdiUFtXtAHaKji0SZQqAEu5ZEAtknanLjTGsrXIq6Xoq8Ck9TPs3Q1E3L8IlnMfcWLyHmxiVGfH92z2xmZwUCTK7NMP2z6Q2Su28jIyoZZEg6rai+YEzSnYaYFjU+b1RuzO7/PnvQjlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=PQGdo0DU; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1747108523; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=tH28IR6cEDMJu6Zp6rniPm7B0/eMWW2T/aX6be9+u0c=;
	b=PQGdo0DUG5bivOVf/qu/X8FztblS8+ztpTr0m7k4Ymj/BJiUpadAcAtAp8C29XnByAMAaKFQycQOLPBjLOmnICZ/RYDRzoeZmcE8IptRuRd1CC6vWLi2xud1Fffti6hm9OtLzkBLZJfBrRtmJZS5bH9kEfCEZ9M0QEOcbpOno2w=
Received: from 30.221.65.46(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WaRTmuN_1747108522 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 13 May 2025 11:55:23 +0800
Message-ID: <9c4b14de-692a-415d-876f-c72e42aaba6f@linux.alibaba.com>
Date: Tue, 13 May 2025 11:55:22 +0800
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] ima: add a knob to make IMA be able to be disabled
To: Coiby Xu <coxu@redhat.com>
Cc: Roberto Sassu <roberto.sassu@huawei.com>, Baoquan He <bhe@redhat.com>,
 chenste@linux.microsoft.com, RuiRui Yang <ruyang@redhat.com>,
 linux-integrity@vger.kernel.org, kexec@lists.infradead.org,
 Christian Brauner <brauner@kernel.org>, Mimi Zohar <zohar@linux.ibm.com>
References: <65057b5256a28c3416e6b90a143d741801e68b03.camel@linux.ibm.com>
 <Z/MrpIv9EWftPhbD@MiWiFi-R3L-srv>
 <02563b1e8b0000bedf94ded447a8372f21d4304a.camel@linux.ibm.com>
 <Z/Xero1B0OazLcHL@MiWiFi-R3L-srv>
 <db0f463cbf4ad9b9cf9f9a23c5869a751ad12bba.camel@linux.ibm.com>
 <Z/8ijFhIf1J6vbWM@MiWiFi-R3L-srv>
 <f75tvrcc6xhfwz5rbwh2ps34wt2odz4wq32vez7dsct732x4ik@sv6nyjqr2ykr>
 <80766b04cafd24a1d7171b8da03c822d86272f3c.camel@linux.ibm.com>
 <qvv3tniawgb3rvqeuxzckj25xxkcr2tqbwnji5gmdg4x3ahdha@52hwfd36ttf7>
 <00d282d0cf06c3ac208ab9edfddedda1c9a5a77b.camel@linux.ibm.com>
 <s56ljuvqmrcy5gzjbrfbowq6gel7u4jjqtgyitvcbjgoiaahex@5kezecpurctk>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <s56ljuvqmrcy5gzjbrfbowq6gel7u4jjqtgyitvcbjgoiaahex@5kezecpurctk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Coiby,

On 2025/5/13 08:14, Coiby Xu wrote:
> On Fri, May 09, 2025 at 09:03:11AM -0400, Mimi Zohar wrote:

...

>>>
>>> > I'm aware that some
>>> > store the security xattr information in a file and write it out as xattrs.
>>>
>>> If the built initramfs as a CPIO file doesn't carry xattrs, the loaded
>>> initramfs still doesn't have xattrs. I just found the initramfs could
>>> opt to use squashfs or erofs which supports xattrs but currently it's
>>> hardcoded to disable xattrs. For example, recently the dracut erorfs
>>> module also follows squashfs to disable xattrs [1]. So in the near
>>> future, I don't expect xattrs to be supported in kdump.
>>>
>>> [1] https://github.com/dracut-ng/dracut-ng/pull
> 
> Sorry, I didn't notice the link is incomplete. It should be
> 
> [1] https://github.com/dracut-ng/dracut-ng/pull/1296
> 
>>
>> Right, so the issue isn't the initramfs root filesystem, but CPIO.  Either CPIO
>> would need to be extended, which multiple people have attempted to do, or the xattrs
>> could be stored in a file and written out to the initramfs root filesystem.  In fact
>> Roberto's last attempts at adding CPIO xattr support did something like that.
>>
>> https://lore.kernel.org/linux-integrity/20190523121803.21638-1-roberto.sassu@huawei.com/
> 
> Thanks for introducing Roberto's work to me!

I wrote some words on initramfs vs initrd erofs on related threads:
https://lore.kernel.org/r/934af3e3-3153-40c1-9a25-7a8d08fdb007@linux.alibaba.com
https://lore.kernel.org/r/582bc002-f0c8-4dbb-8fa5-4c10a479b518@linux.alibaba.com/T/#u

The CPIO standard doesn't support xattrs, also initramfs could cause
unnecessary unpacking.

But anyway it needs more work on this stuff too.

Thanks,
Gao Xiang

> 
>>
>> Mimi
>>
> 


