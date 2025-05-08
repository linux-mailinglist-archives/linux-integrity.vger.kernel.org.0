Return-Path: <linux-integrity+bounces-6162-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C8DCAB042A
	for <lists+linux-integrity@lfdr.de>; Thu,  8 May 2025 21:58:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0BC4217D3CC
	for <lists+linux-integrity@lfdr.de>; Thu,  8 May 2025 19:58:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4260287509;
	Thu,  8 May 2025 19:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZiRICA1o"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B06AA21D5B6;
	Thu,  8 May 2025 19:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746734283; cv=none; b=aQLfoxRFWFSZq9rorYY6we8eS7IT9HarT3hZaRWStmciZVhk6UD9HeYYTCyl3f47ubcQ0WvbrrwaZ3sjVIg+EGI85D9o5jf/hcwJ64RWrivimEv9gPk1gqdPBu7M0lcsVhf0NJgSxUwRdayraUqQWIFSSqa3riSdzZWOcDqJjgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746734283; c=relaxed/simple;
	bh=FH9ehDK9w6juOjpTVtLhZKee0FunkstL7xkh4AtrgTw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SAPNFEmV5NLXNP/AZ+vjeIponEx6AjHgnyLurZSQIw9SJfR/1KB+GGfs5kgkw928NaEfAC02kcLS82qU5e5Hnj4IKP9xq3CQmLUS3IAeyF0NkoIdY1iTiOy4J0IMx6V3kCNvXVlYTlg3dgw/auLyQ9YQH1pOdk8Dn206hhliWaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZiRICA1o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DD17C4CEE7;
	Thu,  8 May 2025 19:58:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746734283;
	bh=FH9ehDK9w6juOjpTVtLhZKee0FunkstL7xkh4AtrgTw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZiRICA1oFfayFJnQV5xeTUPwimK7G3h4CFi26D/JDJTMCB/Ex+seUtV616z+bWwXv
	 dX5eoV51Sg+vgkqhmT+7I9T2omk1J00lBbpObzTFG4VEJfXY2ajSN+9IUU9z4oHDNm
	 OWSf+Y/8AJqDntx62kr8L/NcQehqGTzbWEBQ/QeIN+uJhVI7LQThEtxkgJkT+vTdre
	 Ehvh1fpEmR+1Ks49iK7GS+bTbAxN1oi0yCIHoIjkUvbRXk5SSDivdJ8AFzNFL50kAD
	 Z29BDBtD7Mf5sbdHr0973NnKVNyRlhz+ClqxoDKV3Q2Pxk/8MNAC1UEvQSASgiy8H7
	 WG+tYLe6KBN3g==
Date: Thu, 8 May 2025 22:57:58 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Qunqin Zhao <zhaoqunqin@loongson.cn>
Cc: Stefano Garzarella <sgarzare@redhat.com>, lee@kernel.org,
	herbert@gondor.apana.org.au, davem@davemloft.net, peterhuewe@gmx.de,
	linux-kernel@vger.kernel.org, loongarch@lists.linux.dev,
	linux-crypto@vger.kernel.org, jgg@ziepe.ca,
	linux-integrity@vger.kernel.org, pmenzel@molgen.mpg.de,
	Yinggang Gu <guyinggang@loongson.cn>,
	Huacai Chen <chenhuacai@loongson.cn>
Subject: Re: [PATCH v9 4/5] tpm: Add a driver for Loongson TPM device
Message-ID: <aB0MxkdKVLso4jZD@kernel.org>
References: <20250506031947.11130-1-zhaoqunqin@loongson.cn>
 <20250506031947.11130-5-zhaoqunqin@loongson.cn>
 <2nuadbg5awe6gvagxg7t5ewvxsbmiq4qrcrycvnrmt2etzq2ke@6oyzavctwrma>
 <0b148f09-d20d-b6be-d31b-6c8a553658c9@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0b148f09-d20d-b6be-d31b-6c8a553658c9@loongson.cn>

On Wed, May 07, 2025 at 09:33:32AM +0800, Qunqin Zhao wrote:
> 
> 在 2025/5/6 下午10:13, Stefano Garzarella 写道:
> > On Tue, May 06, 2025 at 11:19:46AM +0800, Qunqin Zhao wrote:
> > > Loongson Security Engine supports random number generation, hash,
> > > symmetric encryption and asymmetric encryption. Based on these
> > > encryption functions, TPM2 have been implemented in the Loongson
> > > Security Engine firmware. This driver is responsible for copying data
> > > into the memory visible to the firmware and receiving data from the
> > > firmware.
> > > 
> > > Co-developed-by: Yinggang Gu <guyinggang@loongson.cn>
> > > Signed-off-by: Yinggang Gu <guyinggang@loongson.cn>
> > > Signed-off-by: Qunqin Zhao <zhaoqunqin@loongson.cn>
> > > Reviewed-by: Huacai Chen <chenhuacai@loongson.cn>
> > > Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
> > > ---
> > > v9: "tpm_loongson_driver" --> "tpm_loongson"
> > >    "depends on CRYPTO_DEV_LOONGSON_SE" --> "depends on MFD_LOONGSON_SE"
> > > 
> ...
> > > +static int tpm_loongson_recv(struct tpm_chip *chip, u8 *buf, size_t
> > > count)
> > > +{
> > > +    struct loongson_se_engine *tpm_engine =
> > > dev_get_drvdata(&chip->dev);
> > > +    struct tpm_loongson_cmd *cmd_ret = tpm_engine->command_ret;
> > > +
> > > +    memcpy(buf, tpm_engine->data_buffer, cmd_ret->data_len);
> > 
> > Should we limit the memcpy to `count`?
> > 
> > I mean, can happen that `count` is less than `cmd_ret->data_len`?
> 
> Hi, Stefan, thanks for your comment.
> 
> Firmware ensures "cmd_ret->data_len" will be less than TPM_BUFSIZE,  so this
> would never happen.

It still must have check-and-fail, as we don't live in a belief system
:-) It helps to mitigate collateral damage of possible firmware bugs
(and thus -EIO is the appropriate error code).

> 
> BR, Qunqin.
> 
> > 
> > Thanks,
> > Stefano
> 

BR, Jarkko

