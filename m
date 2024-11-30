Return-Path: <linux-integrity+bounces-4262-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88CB39DEF40
	for <lists+linux-integrity@lfdr.de>; Sat, 30 Nov 2024 08:52:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 373DB281438
	for <lists+linux-integrity@lfdr.de>; Sat, 30 Nov 2024 07:52:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5CCB13E022;
	Sat, 30 Nov 2024 07:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nNQo3m4b"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83FD929A0;
	Sat, 30 Nov 2024 07:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732953126; cv=none; b=OsQFPJTvYh4AcIrD6Bfbhhtpr23iFjgCyLBhABfBMjvjbqmC76FqcSxiqW6PfVYxbCD4jDLy2YmIgWU1Fes6ygDm8YU5/dicAcmVwjBhAPlAYLPFV5CNEOSjO4dzGNrxmqIusm6bN/B8XNRxc2+U/K5OwPafpnvixuS+igZs+fA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732953126; c=relaxed/simple;
	bh=B2jqdqUMq9AblgtpyT+tux0MiGaM+gLl7c0wRNYaxqk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qPfm2DjoVE2sCP01OPprSEfDSGHV6JE6rVBzQ62oDdmaH3G8tTRWR38Bjxo8+yJ/wWUOMhhX/FhqoaOa5APp/Ly1+YXC0cC0ptIupkmYQdK5blX0KM56EeR1J6zkZ5QbBl81VnYgW3JkxGuLMnPAHV/OXGfJqBM1wqfoa2k/56U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nNQo3m4b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7410C4CECC;
	Sat, 30 Nov 2024 07:52:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732953125;
	bh=B2jqdqUMq9AblgtpyT+tux0MiGaM+gLl7c0wRNYaxqk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=nNQo3m4bVtcCQHKBrv3xkJJB4jlXRF3Og/dbAKUaGSsN8TB+ZFdPoa/97oXqaQrvG
	 ga8YjCA5PgdHBmtewxQyb3FgJe+Yo0ldZuRQoPqiXNfsYgbLn5YEozGgoyH82T8fT1
	 apT2s7OeG8oK0CqUwrW3aPu0hjPWyQjVLPGpdINoPht62Fo2Gz2R/73MA+BXvg0NQK
	 yWUBxAxkFVGDrkrkSuIOWXz+BB0BOVT0ODqWPedfQKtxXm5NB8mxqiLe6XUesVmXJf
	 dHvpbL/v2Xg97dDmSPIRbDrpTmSvy4oSmroktIYFMaC5zxuiVl1rdmMoxKJBqWwhtQ
	 4ks3dx3RP5CMQ==
Message-ID: <144c7ba3-786d-4bca-bca7-f02781c82caf@kernel.org>
Date: Sat, 30 Nov 2024 08:52:00 +0100
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: TPM/EFI issue [Was: Linux 6.12]
To: James Bottomley <James.Bottomley@HansenPartnership.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: =?UTF-8?Q?Peter_H=C3=BCwe?= <PeterHuewe@gmx.de>,
 Jarkko Sakkinen <jarkko@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
 linux-integrity@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
 "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>
References: <CAHk-=wgtGkHshfvaAe_O2ntnFBH3EprNk1juieLmjcF2HBwBgQ@mail.gmail.com>
 <9c893c52-e960-4f30-98ce-ba7d873145bb@kernel.org>
 <ca741d8eade72aa68c389a88d2520f4fe541a1e7.camel@HansenPartnership.com>
 <2a238b61-fa03-4ae4-9dc4-f73834aa3228@kernel.org>
 <70bc83bd7cfb236da030e584e93bfc62c1d9eb6a.camel@HansenPartnership.com>
 <7773891b-b699-4f1d-b9ba-220c649aee9d@kernel.org>
 <02060553aafac7e145e96510a66a6845d389d6ff.camel@HansenPartnership.com>
Content-Language: en-US
From: Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <02060553aafac7e145e96510a66a6845d389d6ff.camel@HansenPartnership.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 29. 11. 24, 17:03, James Bottomley wrote:
>>   But well, fs/fat/ received no significant changes either.
> 
> We don't use that at all in the EFI stub (and neither does systemd-
> boot).  We use the protocols EFI provides to read fat volumes, so any
> issue would be in the edk2 (or in your case ovmf) FatPkg.

Sure, I had an FS corruption (during initrd write) in my mind.

-- 
js
suse labs

