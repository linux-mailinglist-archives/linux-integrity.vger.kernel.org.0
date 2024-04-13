Return-Path: <linux-integrity+bounces-2098-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AB008A3E8C
	for <lists+linux-integrity@lfdr.de>; Sat, 13 Apr 2024 22:55:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 171781F21568
	for <lists+linux-integrity@lfdr.de>; Sat, 13 Apr 2024 20:55:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00AD94206E;
	Sat, 13 Apr 2024 20:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o0ZgN/Fc"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0E6C41238
	for <linux-integrity@vger.kernel.org>; Sat, 13 Apr 2024 20:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713041703; cv=none; b=MbHNgLjVebhmVCOykjEHjrufmR24Zw8SKTmD3lpcb2W73SKS6c0HAVIi99Sb6InsOnz3ka2nuaLXKADeY/oWPX/NZnb40bEvfHTvK5ClOdZnZm0XNFN3+Ylb32L+THdN5uShvhS+b5BjZ9vepaZhFwKBpzLcX7eyLRgNPoYx9SU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713041703; c=relaxed/simple;
	bh=H7A69nwhk6/eHi7xhNQJEEuhBVT2AuTcQF3FbtTjpu0=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=OvqJnLuagC0iBTPJZI1BJr6+lq5nKxH6qLAGJSTqD0f42T4hEnbcbmqeLl7+ZtROhN959kFRhFFMo0lTp9ovwT1JmAWOxcVbci9oNbm2qtCnGA/truXTRE6yrN6qicHT6dN01pppzNeQbONXf16AZ8i+37ZQivgcsl5e7GpiBHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o0ZgN/Fc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8348EC113CD;
	Sat, 13 Apr 2024 20:55:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713041702;
	bh=H7A69nwhk6/eHi7xhNQJEEuhBVT2AuTcQF3FbtTjpu0=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=o0ZgN/FcwlA6SoOs80nf1bncLmFZOf6soqyE+Jk6WhHRUaXfrt4jB2T3d5utmNl31
	 E1F1DtbURCxsji1JsZJ8KmxI+Lcp/w/qDmt6MqnEYsS8pLjwY4jQkqYUr6ZOZEBpoA
	 ZEFDyaWEhuZjYODrZhaN156u6gW+VLygu17lFyhV8P6+Zwve5OK0Jszw5f/BpdId7q
	 5o/jm2dwZCkh7K+cqkuRei7YeMepUCdILYAinDzM0q+QN4ncsR4CJ/P73bjCDHwjJD
	 8lyP3GckgwINkPZrAiBl1YLEtsUlanR5NIwxx/elMrmJKX7HO7s9NHR+bjyUjYOO+2
	 WxX3gZQNxG7SA==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 13 Apr 2024 23:54:59 +0300
Message-Id: <D0JALOP2RDHA.21T8JRY0LWKN2@kernel.org>
Subject: Re: TPM error 0x0901, possibly related to TPM2_PT_CONTEXT_GAP_MAX
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "William Brown" <wbrown@suse.de>
Cc: <linux-integrity@vger.kernel.org>, <peterhuewe@gmx.de>, <jgg@ziepe.ca>,
 "Takashi Iwai" <tiwai@suse.de>
X-Mailer: aerc 0.17.0
References: <424B3F10-D91C-4F47-B33C-BB66FE4DB91A@suse.de>
 <D0BFJLQ0JKO4.20EW2ZA8GIS5Z@kernel.org>
 <F34D4DB5-EDFF-4E04-A35D-D9044F513A99@suse.de>
In-Reply-To: <F34D4DB5-EDFF-4E04-A35D-D9044F513A99@suse.de>

On Fri Apr 5, 2024 at 3:24 AM EEST, William Brown wrote:
>
>
> > On 5 Apr 2024, at 01:06, Jarkko Sakkinen <jarkko@kernel.org> wrote:
> >=20
> > Since the code is accessing /dev/tpm0 and not /dev/tpmrm0 this issue
> > should be mitigated by the user space resource manager.
>
> My code is operating via /dev/tpmrm0, not /dev/tpm0. And after each itera=
tion, all sessions are cleared and removed.=20
>
> If I operate on /dev/tpm0 the issue goes away. So the error is actually i=
n the resource manager itself.=20

Ah, my previous response about kprobe hook is still relevant.

Kernel RM can cause context gap error if user space leaves a=20
stall session long enough. Before making any decisions we should
be aware first what are the exact conditions in this case.

Sorry for late response. I was sick for most of last wee.

BR, Jarkko

