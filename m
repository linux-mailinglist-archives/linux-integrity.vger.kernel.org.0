Return-Path: <linux-integrity+bounces-526-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AFD8816D3C
	for <lists+linux-integrity@lfdr.de>; Mon, 18 Dec 2023 13:01:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2980F2845C6
	for <lists+linux-integrity@lfdr.de>; Mon, 18 Dec 2023 12:01:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62DE61A287;
	Mon, 18 Dec 2023 11:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="IwN1vhis";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="tcWIsBkE"
X-Original-To: linux-integrity@vger.kernel.org
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD4D031A62;
	Mon, 18 Dec 2023 11:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.nyi.internal (Postfix) with ESMTP id CEB9C5C0138;
	Mon, 18 Dec 2023 06:57:22 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Mon, 18 Dec 2023 06:57:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1702900642; x=1702987042; bh=oNCXpmzOnp
	v/ZMs2C1LVLkDAobWIT06Q4NQom04jsYA=; b=IwN1vhisXOGaPhVE4Dhn4TW9/Z
	5glTuEG1jsmAFC+YjD9LvXEi1LDjGfnlMjxWk4t8/cjqOXJDyyORyxc8WYrujZjn
	OIqLqiTd5aCie8Z50qdn/V1ToML/hcaWbikjBTBM81kYwXlXCPF7fszOUz0d6xCZ
	NhNpXR3OT/rYQyANwbF0McbQBhG5Z/BKEZSDa3Y8u/MzeEYr2CfznZ9+Blbic9Yz
	ytbVEuirHn8fcSJfUlvObvjy7KxmRlR7yNTC2VNl73PhJUS4dMAq86u/sBLIAyoJ
	x+BTotSQsQLcjaAsNLGPm9MrxAoGWMEljm8vaiCOdHive/XFX/wPfDIeP6/g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1702900642; x=1702987042; bh=oNCXpmzOnpv/ZMs2C1LVLkDAobWI
	T06Q4NQom04jsYA=; b=tcWIsBkE1buhqz932G1poGIONjJimqHG6++Mq379BdXX
	yEvsJs959+wwt++eYpHxB9FFYgh4NHGtiYKzxmB6PZ5daLwVSogkK5Allkche08n
	V6FiY/ahTSTIsUU8CAMWVk0SwMWOi7ylP3LIfF3NFb8Z7ZVC4qXsFyazpOkEXXjP
	CwViIE3L8NkiGc2vxLS0NZ8mBnCjZzooYSYWjJFlA2vLyglfq9PGFEubpquz6wic
	1QN8H617XMtJz9VJslMhOogvvANcvGNpJkiNCn5c3iIL2iqFQzAI5LtdeJbixzca
	r6rzPSP4Ajpw/ROd1i6xLDYHbp8OeI5jBPpbI3Z61Q==
X-ME-Sender: <xms:ojOAZfXVmBp1zkMxYhB9NDV6HZeeCnRCxR33iLcXIBCzMItcvCKMEQ>
    <xme:ojOAZXlTH5-weNS81GPlMmGeyrrMqG69Y0jmlgpfbAHcPUJ_6KuaXc6LCni4kV9Dd
    mJ20vvhOPAARA>
X-ME-Received: <xmr:ojOAZbaYQb74aA8hIV6hsUEBt9XpXdupHkUwCOza3qHE857tvy2qOmg1B6ML_SV7nPKPzJtY0SuMyMwugJ3D6QxYdVlr6OgUew>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvddtkedgfedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepifhrvghg
    ucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrfgrthhtvghrnhepheegvd
    evvdeljeeugfdtudduhfekledtiefhveejkeejuefhtdeufefhgfehkeetnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhrvghgsehkrhhorg
    hhrdgtohhm
X-ME-Proxy: <xmx:ojOAZaX1zNH3DvKdgODOHnegGaHd_BxP5hANWs2XEovTdsKCo2QIPQ>
    <xmx:ojOAZZmZVj-MSdx432L2sWfNAxUjTrQ7r9ihBLNQdt-Ivfr6tgeg8Q>
    <xmx:ojOAZXd40Y0fEWxvMzfhTq1IcFMv2jlLI7kQVOQu63A55iuTnLP6fg>
    <xmx:ojOAZe8iSNtDRJyC9-NRZlp0279tkdGr55hyAiaIIDF8owUfu26NZw>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 18 Dec 2023 06:57:22 -0500 (EST)
Date: Mon, 18 Dec 2023 12:57:20 +0100
From: Greg KH <greg@kroah.com>
To: Robert Kolchmeyer <rkolchmeyer@google.com>
Cc: Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org,
	linux-integrity@vger.kernel.org, regressions@lists.linux.dev,
	eric.snowberg@oracle.com, zohar@linux.ibm.com, jlayton@kernel.org
Subject: Re: IMA performance regression in 5.10.194 when using overlayfs
Message-ID: <2023121848-filter-pacifier-c457@gregkh>
References: <000000000000b505f3060c454a49@google.com>
 <ZXfBmiTHnm_SsM-n@sashalap>
 <CAJc0_fz4LEyNT2rB7KAsAZuym8TT3DZLEfFqSoBigs-316LNKQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJc0_fz4LEyNT2rB7KAsAZuym8TT3DZLEfFqSoBigs-316LNKQ@mail.gmail.com>

On Tue, Dec 12, 2023 at 04:37:31PM -0800, Robert Kolchmeyer wrote:
> > Looking at the dependencies you've identified, it probably makes sense
> > to just take them as is (as it's something we would have done if these
> > dependencies were identified explicitly).
> >
> > I'll plan to queue them up after the current round of releases is out.
> 
> Sounds great, thank you!

I've dropped them now as there are some reported bug fixes with just
that commit that do not seem to apply properly at all, and we can't add
new problems when we know we are doing so :)

So can you provide a working set of full backports for the relevant
kernels that include all fixes (specifically stuff like 8a924db2d7b5
("fs: Pass AT_GETATTR_NOSEC flag to getattr interface function")) so
that we can properly queue them up then?

Or, conversely, we can revert the other commits if you think that would
be better?

thanks,

greg k-h

