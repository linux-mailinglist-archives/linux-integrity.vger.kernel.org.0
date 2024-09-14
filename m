Return-Path: <linux-integrity+bounces-3583-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3823B97901B
	for <lists+linux-integrity@lfdr.de>; Sat, 14 Sep 2024 12:52:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A9551C21671
	for <lists+linux-integrity@lfdr.de>; Sat, 14 Sep 2024 10:52:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 022A01CF2AF;
	Sat, 14 Sep 2024 10:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="OaYMqFv+"
X-Original-To: linux-integrity@vger.kernel.org
Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A23F51CF2A6;
	Sat, 14 Sep 2024 10:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726311082; cv=pass; b=sw/99onEt8B3oS0fEjtgjdPsV+8HXXgOHVqEYNPJUKZduW4h7IYyqfBEwcl2wMkF8pjNmsCl+aB0cpKSfMoa85dhQWCDQCe1YMJsjqPdLQJHHXEDAfQZ+SkN9os3i/oFDV3QHwjWhvopPsb0V5VCe8i1WvYZBgLC65F4jG3GTDA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726311082; c=relaxed/simple;
	bh=m8d+9q3kZe0ADCcH+zl7FFtgiggpLWzcGS+CWgkb0+E=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=SgQi+P92GUuJm58335oEXZH1KT45F1KsBYd13U595sRoO1xdEyOly1u0DsSQKDzm1cMDW1VQkGNAGIDNjkdtY1W95JSILZIHYEyJN7FC/vCJpBYYZpIcVanK1MQJeeiuS0KXQRnulZ0EcMTYbONc1+XLS7UBu4P388zMxHHmwE0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=OaYMqFv+; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Received: from localhost (83-245-197-106.elisa-laajakaista.fi [83.245.197.106])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sakkinen)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4X5Sdp2XM7zySy;
	Sat, 14 Sep 2024 13:51:10 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1726311072;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m8d+9q3kZe0ADCcH+zl7FFtgiggpLWzcGS+CWgkb0+E=;
	b=OaYMqFv+VE+RnQrHLC88LVhHfkYqNkh5TaGThhrw5IANBSm2DJnzDniZOS18BIwcTYzjMX
	tbpNGkLkm4WrAN2FCZauKfeL2x+EGuCBVkjOhXyW2CmL36fLz2LxgzyMQpbpCvkqTdXdMC
	lKgyalCT6+5uHLLF/4CAH/BrTrzn2PA=
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1726311072; a=rsa-sha256; cv=none;
	b=Tnsxy6J9Xwit+N3c2o2ua/OpWzVJDRZtncgjjj8IJCLSX8fpveMMq3BSNJ8IsQK4i20bRm
	Cc59vkRUa8uD0KpgF2IoGNnjjp3ama0kTKjMSbndovhXy8Bk672Tzh5gqfuI5YmLQI7GMx
	6fGUoT8WT4ysF+EWhZZImvp0Y8CavYk=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=sakkinen smtp.mailfrom=jarkko.sakkinen@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1726311072;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m8d+9q3kZe0ADCcH+zl7FFtgiggpLWzcGS+CWgkb0+E=;
	b=A/TAUolZcNt+grDn2cSx88Faz8YuHcwdDij0KfV8nWjp1m3TZeY2EptgNlmO6O5qS20Y7n
	MGx6eH3AoFUnLLKg8e3jVtM+4hEI209h9RkndjqPYYoiEbnuWkLLKJfee2ki0R442C6dG+
	Qnh/7u9Tv/SFCt5Xnsdjq2TNMZWLkPA=
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 14 Sep 2024 13:51:08 +0300
Message-Id: <D45Y78TPNUC3.VPF1BWS5EI0Q@iki.fi>
Cc: <keyrings@vger.kernel.org>, "linux-integrity@vger.kernel.org"
 <linux-integrity@vger.kernel.org>, "LKML" <linux-kernel@vger.kernel.org>,
 "Pengyu Ma" <mapengyu@gmail.com>
Subject: Re: [regression] significant delays when secureboot is enabled
 since 6.10
From: "Jarkko Sakkinen" <jarkko.sakkinen@iki.fi>
To: "Jarkko Sakkinen" <jarkko@kernel.org>, "James Bottomley"
 <James.Bottomley@HansenPartnership.com>, "Roberto Sassu"
 <roberto.sassu@huaweicloud.com>, "Linux regressions mailing list"
 <regressions@lists.linux.dev>
X-Mailer: aerc 0.18.2
References: <0b4a5a86-a9f6-42d1-a9ba-ec565b336d3a@leemhuis.info>
 <92fbcc4c252ec9070d71a6c7d4f1d196ec67eeb0.camel@huaweicloud.com>
 <D42LZPLE8HR3.2UTNOI9CYZPIR@kernel.org>
 <D42M6OE94RLT.6EZSZLBTX437@kernel.org>
 <663d272617d1aead08077ad2b72929cbc226372a.camel@HansenPartnership.com>
 <D42N17MFTEDM.3E6IK034S26UT@kernel.org>
 <f554031343039883068145f9f4777277e490dc05.camel@huaweicloud.com>
 <10ae7b8592af7bacef87e493e6d628a027641b8d.camel@HansenPartnership.com>
 <D45Y0H3JRIJE.3LIRI1PEDTJE3@kernel.org>
In-Reply-To: <D45Y0H3JRIJE.3LIRI1PEDTJE3@kernel.org>

On Sat Sep 14, 2024 at 1:42 PM EEST, Jarkko Sakkinen wrote:
> Please address how this discussion is related to https://bugzilla.kernel.=
org/show_bug.cgi?id=3D219229
>
> I just read the bug report nothing about IMA or PCR extend.
>
> There's now tons of spam about performance issue in a patch set that is
> not in the mainline and barely nothing about the original issue:
>
> "
> When secureboot is enabled,
> the kernel boot time is ~20 seconds after 6.10 kernel.
> it's ~7 seconds on 6.8 kernel version.
>
> When secureboot is disabled,
> the boot time is ~7 seconds too.
>
> Reproduced on both AMD and Intel platform on ThinkPad X1 and T14.
>
> It probably caused autologin failure and micmute led not loaded on AMD pl=
atform.
>
> 6.9 kernel version is not tested since not signed kernel found.
> 6.8, 6.10, 6.11 are tested, the first bad version is 6.10.
> "
>
> How is this going to help to fix this one?
>
> I say this once and one: I zero care fixing code that is in the
> mainline.

How do we now that bug is anything to do with IMA? I'm having a weekend
now but on Monday I'll ask the kconfig from the reporter. I think
important thing is to then revisit how many times the session is setup
during boot and make conclusions from that.

It is plain wrong and immoral to convolute a regression with marketing
a new kernel feature. These topics should be brought up in the topic
(i.e. patch set comments), not here. It misleads everyone.

Please explain me how this is going to help the reporter in any
possible?=20

BR, Jarkko

