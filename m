Return-Path: <linux-integrity+bounces-3579-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 156F8978A38
	for <lists+linux-integrity@lfdr.de>; Fri, 13 Sep 2024 22:50:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B425C1F24C8E
	for <lists+linux-integrity@lfdr.de>; Fri, 13 Sep 2024 20:50:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73738146A71;
	Fri, 13 Sep 2024 20:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="l4tNLFek"
X-Original-To: linux-integrity@vger.kernel.org
Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D64E824A1;
	Fri, 13 Sep 2024 20:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726260637; cv=pass; b=ZOAculWvAIBub2yMfpA9tANHY7O5Nqv6QOID5ydA8JQq1lt3mSUHaoL918MGTYLK9oro7VALPyijBHmwU/wOqZRi8+Bpa6sUmPZyPNQXp1rtKPntMVzzW/7+H2vAe+zDfAM7bWLEmU4Ui0P6rghZ3tcx1/k8uKevh1Z3L0IK6R0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726260637; c=relaxed/simple;
	bh=IyHwq3gLv93dYm4dDVxpET0KKx/gYmYIpij+l71ZSgk=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=rucmliWrdZ/A8jSAqvAtw/NUCHLJP4XUhsFR5vo/wnSiSyp8XCRqiYCqe3uYHsHNrvrl3GC92uvi8MuUdelnZCfhXt+MFqvrq5Y0e0s1wP7EldXQ41vJpA4Y3G+Nf0q8OZtYVty2Wm0Q/Y0MAeLLf2AIJ3Dwa/DkvZnqdwgJsMs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=l4tNLFek; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Received: from localhost (83-245-197-106.elisa-laajakaista.fi [83.245.197.106])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sakkinen)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4X55zk1W3lz49Q33;
	Fri, 13 Sep 2024 23:50:26 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1726260626;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IyHwq3gLv93dYm4dDVxpET0KKx/gYmYIpij+l71ZSgk=;
	b=l4tNLFek/TDFwZBOxa+fufpxVTS+FaVSZS33KwbLImz/KcR4/yPUbBM+N9mBLBmCVJp2zn
	lcAkmPGVA34ADF8ARM2q+fvXoa5CSxGA2o9JIJpFkqZEwJK9Mw6KFvY9ApCHdfjfITi5Qy
	N6dV9tb+HK9pv9CEEwY02m5yrIyrAB0Nm/6fPhUz4j/+C2vsTqSwabdrm+BjlbqDWNkSEE
	CyO+hLGlJ6+yvbQGKOvWg4lnJAZK6sY8CF6fT7pkdyqwv34BaOH8lhL/b0IsZsKoGq4bUP
	e4LumVA1oJNkj+rVGvEheQTwClDtgOo6RIviy8keZClra+arl1qUE3UcBA0pRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1726260626;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IyHwq3gLv93dYm4dDVxpET0KKx/gYmYIpij+l71ZSgk=;
	b=tq6KLSnUXAW1zeEzBJT5ak+sbn2fl9eh3+XRND730ZPBak+kO3yCAVJ/LJzMcZoXBPFr6k
	9h7ag0Fr107V2BYG5QODKqXy/MwSXVqFQiL1H+ugjtD0ExQxW7YB8nRlD9GerDtP+z/ru4
	bEe5SVHORRcOAbSoTl8M2rgQxfB/qdR5VCSnr6BMdrD5w+GZ3Vlo5J9H9L0/WycErZxCmT
	4JK808o8/4IC4YO7HiuOxWWgA23KWLTgXsRM/qh1zH+pDf6YtvV6vlOupxjujDQlb+M6+b
	zrCts5dXDqiwl1SQEaOSzZ3nmILXBN3odFX76NhMzbuC14d+bE18+m/k6qY32g==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=sakkinen smtp.mailfrom=jarkko.sakkinen@iki.fi
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1726260626; a=rsa-sha256;
	cv=none;
	b=pG0r/+T06biVOJqOTx9dZx9owVgyiCBY71em/k7Jqt0XexY9dhdCJESOjNgZbpUT6qN2Zh
	9/p9eUZtENLEXI6P33uHs3B4epwcUnTtmyIYJo3o90Vhz3nB8p5XeRhBkwpFhaKM0tpSIy
	2CMvpQ/FLzeqUZHud1MIeUEfk99BV09pU5J1Flb1/dcX5QxEMFvnToA3kVs0o3bp1LT6vF
	3VKz1bDaPI8o5SEQMTzYjwiWG3TD7F1DXq1hDhGyuC2gJZVkT2EcAscOPiQATcE2p/gEmE
	QeSHYKK34qyu0753tG42ueBslcgp5XT9ril+fud9t8B4DBbZmB1zvb69lcj/Dg==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 13 Sep 2024 23:50:24 +0300
Message-Id: <D45GBJ51SBNP.1WR34VCVNSN52@iki.fi>
Cc: <keyrings@vger.kernel.org>, "linux-integrity@vger.kernel.org"
 <linux-integrity@vger.kernel.org>, "LKML" <linux-kernel@vger.kernel.org>,
 "Pengyu Ma" <mapengyu@gmail.com>
Subject: Re: [regression] significant delays when secureboot is enabled
 since 6.10
From: "Jarkko Sakkinen" <jarkko.sakkinen@iki.fi>
To: "Roberto Sassu" <roberto.sassu@huaweicloud.com>, "Jarkko Sakkinen"
 <jarkko@kernel.org>, "James Bottomley"
 <James.Bottomley@HansenPartnership.com>, "Linux regressions mailing list"
 <regressions@lists.linux.dev>
X-Mailer: aerc 0.18.2
References: <0b4a5a86-a9f6-42d1-a9ba-ec565b336d3a@leemhuis.info>
 <92fbcc4c252ec9070d71a6c7d4f1d196ec67eeb0.camel@huaweicloud.com>
 <D42LZPLE8HR3.2UTNOI9CYZPIR@kernel.org>
 <D42M6OE94RLT.6EZSZLBTX437@kernel.org>
 <663d272617d1aead08077ad2b72929cbc226372a.camel@HansenPartnership.com>
 <D42N17MFTEDM.3E6IK034S26UT@kernel.org>
 <f554031343039883068145f9f4777277e490dc05.camel@huaweicloud.com>
 <D43JXBFOOB2O.3U6ZQ7DASR1ZW@kernel.org>
 <7e47f97aede88b87fbb9c9284db2005764bfbedd.camel@huaweicloud.com>
In-Reply-To: <7e47f97aede88b87fbb9c9284db2005764bfbedd.camel@huaweicloud.com>

On Thu Sep 12, 2024 at 11:13 AM EEST, Roberto Sassu wrote:
> On Wed, 2024-09-11 at 18:14 +0300, Jarkko Sakkinen wrote:
> > On Wed Sep 11, 2024 at 11:53 AM EEST, Roberto Sassu wrote:
> > > I made few measurements. I have a Fedora 38 VM with TPM passthrough.
> >=20
> > I was thinking more like
> >=20
> > sudo bpftrace -e 'k:tpm_transmit { @start[tid] =3D nsecs; } kr:tpm_tran=
smit { @[kstack, ustack, comm] =3D sum(nsecs - @start[tid]); delete(@start[=
tid]); } END { clear(@start); }'
> >=20
> > For example when running "tpm2_createprimary --hierarchy o -G rsa2048 -=
c owner.txt", I get:
>
> Sure:

Took couple of days to upgrade my BuildRoot environment to have bcc and
bpftrace [1] but finally got similar figures (not the same test but doing
extends).

Summarizing your results looking at call before tpm_transmit:

- HMAC management: 124 ms
- extend with HMAC: 25 ms
- extend without HMAC: 5.2 ms=20

I'd see the only possible way to fix this would be refactor the HMAC
implementation by making the caller always the orchestrator and thus
allowing to use continueSession flag for TPM2_StartAuthSession to be
used.

For example if you do multiple extends there should not be good reason
to setup and rollback session for each call separately right?

[1] https://codeberg.org/jarkko/linux-tpmdd-test

BR, Jarkko

