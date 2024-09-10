Return-Path: <linux-integrity+bounces-3498-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CFE0972CBA
	for <lists+linux-integrity@lfdr.de>; Tue, 10 Sep 2024 11:01:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1CC4C288AAD
	for <lists+linux-integrity@lfdr.de>; Tue, 10 Sep 2024 09:01:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EC5E187FE7;
	Tue, 10 Sep 2024 09:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="26Mja9Lo"
X-Original-To: linux-integrity@vger.kernel.org
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E2B0187357;
	Tue, 10 Sep 2024 09:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725958889; cv=none; b=WPB2UH5CnsKwDGNiAanzaniy/S06IQvhL61CLR8UhzjRpd94ZCuy68MQMu6sNix6aU2qCtsewpk84HJKgBlMWixPIbBX0y/Bykmf5AYIvnoNZB/PeVhF6rADnccIgALoIAeXA2+fptcgGBJIlNfjV8oi0mHmgVxQCFRAmB9e/Xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725958889; c=relaxed/simple;
	bh=4x+QL41ns1QPmGRucqQPte1Nmt5UGtBC/ZuB8yTgeb0=;
	h=Message-ID:Date:MIME-Version:From:To:Cc:Subject:Content-Type; b=axLN84VrtAtEE/vrGeihqHxYuIOFK/wmTp081sExZ892tDaWYZBea/k1FpbYOzf3cfKAgTp4LmKP+4XrSfiuV8c97HsW/JCxBWNqpJN1InmUM3UYRmOpJ9vlSLM4vmUWsmFOAT3t79fwUfJLm7Mgku6k20bfuqTkDgarKM3Ixdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=26Mja9Lo; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	Reply-To:Subject:Cc:To:From:MIME-Version:Date:Message-ID:From:Sender:Reply-To
	:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=KACh0iP/ZRcc8FerQkJVRSzMtk4GzsY5xUMh0/fAg5k=; t=1725958887;
	x=1726390887; b=26Mja9Lob/3o6ON/ICV8vTVJmcYcKbHkcETuegmhlohuBd0qizORGamHfzklW
	VDp9GRuF2dU7pKZsbwhFBK1NopgtRBr1ODivZY4xcVPmvzhDCW4zQVTDDVLahyi8f6prlOG2kKahN
	i3gC/+/p1Yg/hLnVc0mQr9RVwS+HCVCFLzbaxiRhRBkRZL/dnMogpzu/dcl6PA5SM51qWq8l+Kzdc
	DemMfAV5U8rRe7Zvf5FDUwX5nh7jH4FJuBdJ3tawFdFFSACDElC8HnOUQOaStdBZCnz+LE77pa3P/
	YK28Vqyz4kOo6g2s8kJ5CIrysbjCHgIkYPIhn7aI+FRxGd6+6Q==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1snwkW-0005xO-U0; Tue, 10 Sep 2024 11:01:24 +0200
Message-ID: <0b4a5a86-a9f6-42d1-a9ba-ec565b336d3a@leemhuis.info>
Date: Tue, 10 Sep 2024 11:01:24 +0200
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Content-Language: en-US, de-DE
To: James Bottomley <James.Bottomley@HansenPartnership.com>,
 Jarkko Sakkinen <jarkko@kernel.org>
Cc: keyrings@vger.kernel.org,
 "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>,
 Linux kernel regressions list <regressions@lists.linux.dev>,
 Pengyu Ma <mapengyu@gmail.com>
Subject: [regression] significant delays when secureboot is enabled since 6.10
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1725958887;3b747881;
X-HE-SMSGID: 1snwkW-0005xO-U0

Hi, Thorsten here, the Linux kernel's regression tracker.

James, Jarkoo, I noticed a report about a regression in
bugzilla.kernel.org that appears to be caused by this change of yours:

6519fea6fd372b ("tpm: add hmac checks to tpm2_pcr_extend()") [v6.10-rc1]

As many (most?) kernel developers don't keep an eye on the bug tracker,
I decided to forward it by mail. To quote from
https://bugzilla.kernel.org/show_bug.cgi?id=219229 :

> When secureboot is enabled,
> the kernel boot time is ~20 seconds after 6.10 kernel.
> it's ~7 seconds on 6.8 kernel version.
> 
> When secureboot is disabled,
> the boot time is ~7 seconds too.
> 
> Reproduced on both AMD and Intel platform on ThinkPad X1 and T14.
> 
> It probably caused autologin failure and micmute led not loaded on AMD platform.

It was later bisected to the change mentioned above. See the ticket for
more details.

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.

[1] because bugzilla.kernel.org tells users upon registration their
"email address will never be displayed to logged out users"

P.S.: let me use this mail to also add the report to the list of tracked
regressions to ensure it's doesn't fall through the cracks:

#regzbot introduced: 6519fea6fd372b
#regzbot from: Pengyu Ma <mapengyu@gmail.com>
#regzbot duplicate: https://bugzilla.kernel.org/show_bug.cgi?id=219229
#regzbot title: tpm: significant delays when secureboot is enabled
#regzbot ignore-activity

