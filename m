Return-Path: <linux-integrity+bounces-527-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F545816D46
	for <lists+linux-integrity@lfdr.de>; Mon, 18 Dec 2023 13:03:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3D251F22430
	for <lists+linux-integrity@lfdr.de>; Mon, 18 Dec 2023 12:03:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4FB71947A;
	Mon, 18 Dec 2023 11:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="TSegEniI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nDIsUvC/"
X-Original-To: linux-integrity@vger.kernel.org
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6EEA22325;
	Mon, 18 Dec 2023 11:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id D9B695C013A;
	Mon, 18 Dec 2023 06:58:48 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Mon, 18 Dec 2023 06:58:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1702900728; x=1702987128; bh=zKKRT4nNcp
	2+RkFPnMLe/cLtA7+ssJqRvH3Xq5HN52E=; b=TSegEniIQmiKtk6M/Y2pVurGLM
	DD7BuWb5XsnjO8BSFFdvvI2pDGFGYtqpuKWqpGZ5DSdR/qhZ4t9RWeLw1nDOJI9Y
	GJ3nEMOkJukScJ63liq/VOEediP3Komp8XQl77iTqoiq0+QQHTbH011mGwKxDOMU
	8mDyPqn5F+glaMaFp0XmnZeW/ST+QBKoUe/rzhtFaBbQwLQVpav0xIYm0sLB8xZI
	VCVkN+VdK77tYThfM74L/pN2UQYJOWQmrSW7lTgrtmSJmL2K+NYnlbs0ym8rsXFC
	/z4kMcyWeuQq6J1Ax3cpekeMpMMr6Ru2cZNCBuSa+yt++3UaqfDdT4S38vVA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1702900728; x=1702987128; bh=zKKRT4nNcp2+RkFPnMLe/cLtA7+s
	sJqRvH3Xq5HN52E=; b=nDIsUvC/XyJC77cncOR4tYXSn1iRudcv+DkLRqH6ZyON
	rPSJrrWlrM6Bjq/jrkZws8d+TO0Klp8RAarXouFd2GD+pdWqL5qsgPsiNNSF/adZ
	n6mCFlJifl+UBdQ7E0UlJnoOju9JwgmW5KgX3Fa2a3CvIUjjGH3+JSw6fPCBbpqS
	OvDIgFcGH+g8TEHx2c+T1x1smxZ5FvVfMf44bw9Vxr9x9x5aFvBdNLT3hv5Vjkyc
	/RIk2LZpcdAGers6qieQBB6kCiK0FsXS8h/D3/+ypwR3qZqWr+tWOnULK8jjr6Rm
	YMkfm0XvvN8i5A74FNCVaXgN5sdW64+3HOpuZrF38Q==
X-ME-Sender: <xms:-DOAZSqRUgqq7EJKhk3OM6WFZlhQp-v14TI-EXDAXMJnO-58mTk-0A>
    <xme:-DOAZQqnQRoW-EBLdSMiAr9qaUBx8ZdTBvrlHinbWdLwewSDV-NpMX6stZ9EDU2K4
    M9JBttwNxQz9w>
X-ME-Received: <xmr:-DOAZXNzn8r9XzLW_NWKlR-NlzcZ6qRUVKZd59OpDkrAeKk90JZcVVnAeoMJsNJOmQx9YL9fqdLybbMGWvhu-9oyecI5HW1a3w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvddtkedgfeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepifhrvghg
    ucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrfgrthhtvghrnhepheegvd
    evvdeljeeugfdtudduhfekledtiefhveejkeejuefhtdeufefhgfehkeetnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhrvghgsehkrhhorg
    hhrdgtohhm
X-ME-Proxy: <xmx:-DOAZR7mhPTTQRG2i7s1KxjrC0aHu37dV2lz-jHYrFawPrsWIC10Uw>
    <xmx:-DOAZR6zQOfXzaaqtR-EP_d2GpJatEe5Y_bPW26DMa7-h3zT2TWR4w>
    <xmx:-DOAZRjUBzy7OVGMvKWwkVodQu0oXFfdHmVxrQcrSsOa3H474bJjoA>
    <xmx:-DOAZQQPyX8YP8Ri52Rdi67Dn6_0mqd78LK2mHNS9YxmRjszcTUprA>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 18 Dec 2023 06:58:48 -0500 (EST)
Date: Mon, 18 Dec 2023 12:58:46 +0100
From: Greg KH <greg@kroah.com>
To: Robert Kolchmeyer <rkolchmeyer@google.com>
Cc: Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org,
	linux-integrity@vger.kernel.org, regressions@lists.linux.dev,
	eric.snowberg@oracle.com, zohar@linux.ibm.com, jlayton@kernel.org
Subject: Re: IMA performance regression in 5.10.194 when using overlayfs
Message-ID: <2023121834-abiding-armory-e468@gregkh>
References: <000000000000b505f3060c454a49@google.com>
 <ZXfBmiTHnm_SsM-n@sashalap>
 <CAJc0_fz4LEyNT2rB7KAsAZuym8TT3DZLEfFqSoBigs-316LNKQ@mail.gmail.com>
 <2023121848-filter-pacifier-c457@gregkh>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2023121848-filter-pacifier-c457@gregkh>

On Mon, Dec 18, 2023 at 12:57:20PM +0100, Greg KH wrote:
> On Tue, Dec 12, 2023 at 04:37:31PM -0800, Robert Kolchmeyer wrote:
> > > Looking at the dependencies you've identified, it probably makes sense
> > > to just take them as is (as it's something we would have done if these
> > > dependencies were identified explicitly).
> > >
> > > I'll plan to queue them up after the current round of releases is out.
> > 
> > Sounds great, thank you!
> 
> I've dropped them now as there are some reported bug fixes with just
> that commit that do not seem to apply properly at all, and we can't add
> new problems when we know we are doing so :)
> 
> So can you provide a working set of full backports for the relevant
> kernels that include all fixes (specifically stuff like 8a924db2d7b5
> ("fs: Pass AT_GETATTR_NOSEC flag to getattr interface function")) so
> that we can properly queue them up then?

Also don't forget 18b44bc5a672 ("ovl: Always reevaluate the file
signature for IMA") either.  There might be more...

thanks,

greg k-h

