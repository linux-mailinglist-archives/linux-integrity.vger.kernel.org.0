Return-Path: <linux-integrity+bounces-3112-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B1DEF9319B2
	for <lists+linux-integrity@lfdr.de>; Mon, 15 Jul 2024 19:39:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4E1BBB20FC5
	for <lists+linux-integrity@lfdr.de>; Mon, 15 Jul 2024 17:39:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25801481A3;
	Mon, 15 Jul 2024 17:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="xttCcRE2"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E199224EF;
	Mon, 15 Jul 2024 17:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721065157; cv=none; b=WaVYvuWwz68AUWB30hnaqIUtu+gEDloTmUPvp5M8nRVldY4eA5l/fLtDCNP5LMWG7byrLre4MAINURRLJh0mTF56mbOa3vYbn3qNQ0jkEq6zgdCxDhauWxQ92e+fM7CI0+YP8qknsZZCCl3T2xHideDR+tsKei77U9I3mJ1ohp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721065157; c=relaxed/simple;
	bh=24rvZGQbyJ1eNnJCEu7WrRfxnOhxONZ/DQqyEX0BmJg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IjwK9J6FxI2HL8fZcsAERJ3m7rnbM1jqnhKK64I3TfYAwRe5RYrEwQA9qNol1B+QjC/4iHCBE4mq8+oTMdZFeXrJFdcJdGIS1TRzkQVFJf2+jdKXxeb+DR4+hr+FuGj0FdXtl0V2n4whi5HpAPZriIeoKqd3RBU03qq70Gen56o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=xttCcRE2; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb (31-10-206-125.static.upc.ch [31.10.206.125])
	by mail11.truemail.it (Postfix) with ESMTPA id 8EA671FA56;
	Mon, 15 Jul 2024 19:39:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1721065150;
	bh=KPCw+/GCnwYR991st3/6DyxVzTReOquM75cwjSwlxH0=; h=From:To:Subject;
	b=xttCcRE2hiE2wMuVtH/x3BuIbFPiwLZPMbfZ6j9svNJlv8432TxLso4PsQyEcdsUb
	 PUTunaiLqHtLhMQm3ofDbHroF+VH1C4TOMy+TKEL9xZNWRa30Uo2cjngL5hBpp1s7v
	 I++YsMImh+Ih7ANsjn9zyHMi41rxsLPQv1sd/WlkK34DiVbSZCbMOIjxaZavSYIFiG
	 YBpuJP32aQN8KA4QKfVsQJakTcWAn5+vWaJo6POTszgXEjKMw8V3j4PAEbfWbh8k2M
	 DwuYDEH69TdMKteIh9Qfc44Jm3TA/Lu8QNgVLQomaKcwk0GwZvVPu/4UYvyLs7WgLj
	 5hI4Cw5JogmuA==
Date: Mon, 15 Jul 2024 19:39:05 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Hermin Anggawijaya <hermin.anggawijaya@alliedtelesis.co.nz>,
	peterhuewe@gmx.de, jgg@ziepe.ca, linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tpm: Start the tpm2 before running a self test.
Message-ID: <20240715173905.GA81987@francesco-nb>
References: <20231122065528.1049819-1-hermin.anggawijaya@alliedtelesis.co.nz>
 <CX6NSGFJVYKC.3KFEPA92N0V53@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CX6NSGFJVYKC.3KFEPA92N0V53@kernel.org>

Hello Jarkko and all,
resurrecting this old thread for a question ...

On Fri, Nov 24, 2023 at 03:42:29AM +0200, Jarkko Sakkinen wrote:
> On Wed Nov 22, 2023 at 8:55 AM EET, Hermin Anggawijaya wrote:
> > Before sending a command to attempt the self test, the TPM
> > may need to be started, otherwise the self test returns
> > TPM2_RC_INITIALIZE value causing a log as follows:
> > "tpm tpm0: A TPM error (256) occurred attempting the self test".
> >
> > Signed-off-by: Hermin Anggawijaya <hermin.anggawijaya@alliedtelesis.co.nz>
> 
> Firmware does TPM power on.

Do you have any explanation on why this is required? Any kind of pointer
to documentation is welcome.

What I am looking for is to understand what are the major limitations if
the firmware is not doing it.

I understand that you cannot use any functionality that requires the TPM
to be enabled at boot, for example "Measured Boot". Is there anything
else that is prevented if the firmware is not enabling it?

Thanks,
Francesco


