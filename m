Return-Path: <linux-integrity+bounces-3502-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9121A9737BE
	for <lists+linux-integrity@lfdr.de>; Tue, 10 Sep 2024 14:41:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 460F11F25AA8
	for <lists+linux-integrity@lfdr.de>; Tue, 10 Sep 2024 12:41:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D31721917CB;
	Tue, 10 Sep 2024 12:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="JEJX+UXr"
X-Original-To: linux-integrity@vger.kernel.org
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AFD9184522;
	Tue, 10 Sep 2024 12:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725972081; cv=none; b=QCL7gxcK8L3dVwVnsVNlqDNPnfbyD1711fvK6z9Py8yD5M5w8YEdFZiVIST69TBV6/9Tb2OMi2fJ5Z2WGQLID8YWWS8L5tl1glDuYZdrIMFHgj8oTdppJjg1hiqZSCymkHKG33VM6FyKKcbjqOpfi5DKBAwAyk42HShOArzdO84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725972081; c=relaxed/simple;
	bh=m2K/Vf4byjHEn20xns9NDv3uZk9NEGFoUH+n6doRo08=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n+u2WeGWbhIJFWUzG4FYzSZuAhiKTQf0kjDj7bpQyaot2BibE6cuYQyQ6Y18nm+VtS8j2ss4VOqRp2+gwSjIqp/RRPr898sM3i22nbQNm9P4cr74ff+YBs9HUMNp8s2tZv0zrtjssW4xOcbgqCkOyNru3kGU370iQ5db6Dq0j+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=JEJX+UXr; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:
	Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
	In-Reply-To:References; bh=Xv6rJk0HG3KR4doXkHSZBn1oVXRmhuKAGldwfUAagCk=;
	t=1725972079; x=1726404079; b=JEJX+UXrQlfCC8c9i+ue9OhyRvTI3gdcs//2hziUtZRR3+B
	g4eXbWi5/Pox8aKbrEZIBSaoMqWjmXTwcxX+suT/pOWnqsYwZX4GGwMyiycA8cdoHkk4AR/ocR3sk
	f+zxObsBsIswwJt534iXCrH1VLx7lxfyjivoRNi3OpvR11E4dmefrey2GklpByTcMtAin1SuZISgs
	KArLO8SAFg6f20FVE7JB5aVLixgdp9gu3xkwQK9ZUF68nxq/9g++Rg26x6juDMVe1BOtz8NhxYoQ7
	9wFTiyciIwGKbZXLwBUbuZFPntPy9FzZCBekyiSS1+a1FvFkuEwPMTk7pySSuyzw==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1so0BI-0006Jv-Jp; Tue, 10 Sep 2024 14:41:16 +0200
Message-ID: <1de8359d-f231-452c-bf5c-9fc01f0ec800@leemhuis.info>
Date: Tue, 10 Sep 2024 14:41:15 +0200
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [regression] significant delays when secureboot is enabled since
 6.10
To: James Bottomley <James.Bottomley@HansenPartnership.com>,
 Linux regressions mailing list <regressions@lists.linux.dev>,
 Jarkko Sakkinen <jarkko@kernel.org>
Cc: keyrings@vger.kernel.org,
 "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, Pengyu Ma <mapengyu@gmail.com>,
 Roberto Sassu <roberto.sassu@huaweicloud.com>
References: <0b4a5a86-a9f6-42d1-a9ba-ec565b336d3a@leemhuis.info>
 <db275ab4fb73fc089c66738ffbcab23557e53055.camel@HansenPartnership.com>
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Content-Language: en-US, de-DE
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <db275ab4fb73fc089c66738ffbcab23557e53055.camel@HansenPartnership.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1725972079;333abe14;
X-HE-SMSGID: 1so0BI-0006Jv-Jp

On 10.09.24 14:22, James Bottomley wrote:
> On Tue, 2024-09-10 at 11:01 +0200, Linux regression tracking (Thorsten
> Leemhuis) wrote:
>>
>> 6519fea6fd372b ("tpm: add hmac checks to tpm2_pcr_extend()") [v6.10-
>> rc1]
>>
>> https://bugzilla.kernel.org/show_bug.cgi?id=219229 :
>>
>>> When secureboot is enabled,
>>> the kernel boot time is ~20 seconds after 6.10 kernel.
>>> it's ~7 seconds on 6.8 kernel version.
>>>
>>> When secureboot is disabled,
>>> the boot time is ~7 seconds too.
>>>
>>> Reproduced on both AMD and Intel platform on ThinkPad X1 and T14.
> 
> We always suspected encryption and hmac would add overheads which is
> why it's gated by a config option.  The way to fix this is to set
> 
> CONFIG_TCG_TPM_HMAC to N

FWIW (mainly for others that later find this thread on lore), I's pretty
sure James meant CONFIG_TCG_TPM2_HMAC.

> of course, TPM transactions are then insecure, but it's the same state
> as you were in before.

Hmmm. But it's on by default on X86_64.

Hmmm. If this would cause serious trouble, I'd say this is a regression
that must be fixed, as we can't expect people to know that they need to
turn this off. But delays during boot? Hmmm. Makes me wonder what Linus
stance would be here. I suspect it might be "why was this enabled by
default for x86_64 anyway, new features almost always should be off by
default", but might be wrong there. And given that this was introduced
in 6.10 I assume a lot of users already have CONFIG_TCG_TPM2_HMAC=Y in
their .config files already anyway. :-/

Hmmm. :-|

Ciao, Thorsten

