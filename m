Return-Path: <linux-integrity+bounces-2569-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C96788CD16C
	for <lists+linux-integrity@lfdr.de>; Thu, 23 May 2024 13:44:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 021721C21820
	for <lists+linux-integrity@lfdr.de>; Thu, 23 May 2024 11:44:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5D0C1487DB;
	Thu, 23 May 2024 11:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="3eRrQhj1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MX8cr7h1"
X-Original-To: linux-integrity@vger.kernel.org
Received: from wfhigh5-smtp.messagingengine.com (wfhigh5-smtp.messagingengine.com [64.147.123.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 190261487D5;
	Thu, 23 May 2024 11:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716464670; cv=none; b=NKr4ZjyrJ8QEp6wMPNcZHJ8jzOCmmoYB1KghH9nA5jWi4RYS10tMTI0bSNZW0IEY6N2FX32SQm4Tv7WlOa0bo/pH5QdK1gNu5BY34+LQbAGPf4cnd/fG4BpEJCsCNlMdr3woDkjglOV2Fd7Ck3kXeZkVZDWCiTnuxOuoFvx9P2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716464670; c=relaxed/simple;
	bh=RHaHN5qysp0UZ0LS4yjpaxXzKXzEBXT6pleSmQv1Yx4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G1jYqwAx/xF4Yz2bB7DGARa8Y+Fy67pil55P+bBo3CsY/cTTaAJn2JBAD58pPf6dTyEZG2JlnVzMU/ehWKWzXuhfc4YSoH2XKEQBrs0lF6rK1zLEhWWPcYwrvvsAJlK+KW9a3dvxs1BBC9NfmbPJEehtgx8SX79t5PeqpmL+s98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=3eRrQhj1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MX8cr7h1; arc=none smtp.client-ip=64.147.123.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfhigh.west.internal (Postfix) with ESMTP id 543FA180006C;
	Thu, 23 May 2024 07:44:27 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Thu, 23 May 2024 07:44:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1716464666; x=1716551066; bh=BiKLlLfmZ5
	kTubzVSa1yR2p+BZfX8aCx4jhbqC2spCE=; b=3eRrQhj1ClZGfUY9naF1pyNNQI
	smrWlEQqm4ct+4KaRRJasKA0lo/tVn5pQDDbFDHig+K1SwL5cuPSfcZVqvOMA1Xh
	WRcdIff/xuQmPzgdWoS2o/c7asrwIQWxn4ogOdSC2GlM3VIZLatTWZclwYUirB9C
	GEqnu163K8+YGpQpLpNcF82NCK1KLdtyurr/AniZ85BCfHZx8nih8inSw16rdot5
	4aO14F5PtX1zIskT5UEycQqSyCtXV/giRhO0bjA6KbHgD2Yic7Q054x92dWP5zBZ
	b7K7/I4XpShBdKTQXTWonE/jKgjV9Yb4hY+G/DDEdmSI14S9xvWvsC1B9gLA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1716464666; x=1716551066; bh=BiKLlLfmZ5kTubzVSa1yR2p+BZfX
	8aCx4jhbqC2spCE=; b=MX8cr7h18Xh0wQ6H2wvcd+fPCLGH9JgVuCy/tTCmhf24
	BewYVWBT2h4veIsOdpO1y1cER6s0poXDx2ij9T/x4riTUXvEP890nTrofkXAjvMK
	6OcQkZfl0QuUWyqyqEBZJsFCs9PXVipDfhFnrschUCz86lzkQnCzObKuYeVzPfS2
	P8mEFgqveWO42IKNZE54woCPRi5aHmfR7e/NwO+B3cbEeEFLRhkHTyyYBDFhEnaU
	JlymKTAnTmf6T5M+h1ARL6upvRmJwof/sQcCyxv9ryMQxHGRDbU9paPg1K7VfAmp
	F8BhHioWMu9j87XX+45QxwgG6iZ9kVsBeJQCcyi1LQ==
X-ME-Sender: <xms:GixPZpHdvi-yhTH-N8XVmOmRIF-h5qSXwW_TuiprFKavaK6RsXRXYA>
    <xme:GixPZuW49hYIUTlnwyISHfEbcQPHTxbaIPjxCc0VpPanvf_u900bOWOP2lknGo40o
    jM3_quQMPypBg>
X-ME-Received: <xmr:GixPZrLPpnE3_H4V0N2dPUPnNCCLfR-AcJtmQV2T3h-irGR6aov5glq-dsPqemFJXNqFYWkOl-GWpNLz83sMEBISgkeKDQ_elrkSDA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeiiedggeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepifhrvghg
    ucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrfgrthhtvghrnhepheegvd
    evvdeljeeugfdtudduhfekledtiefhveejkeejuefhtdeufefhgfehkeetnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhrvghgsehkrhhorg
    hhrdgtohhm
X-ME-Proxy: <xmx:GixPZvHGm1uwaHoNsiLF95yAkEikgoi-mIeF9eDqV6yHuKePffZe_A>
    <xmx:GixPZvX-f5YlBodrnCa59u3oSCYYoIVWRE_goT8Fxo1--06FzjnjFQ>
    <xmx:GixPZqNIUhTTIJI1c_21U0nx1nxYXvejYg8Af4eSgCpRP-5_2OVFDQ>
    <xmx:GixPZu3wLFdBEFS0fRXVBkbxP1ycFG5-e3bftjWkvxmYI8jAwkYmLw>
    <xmx:GixPZgsBG69_67EQMknWW01OJqv1XMIc-UzQfDz0y0G2fhnRIWCHPUAX>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 23 May 2024 07:44:25 -0400 (EDT)
Date: Thu, 23 May 2024 13:44:24 +0200
From: Greg KH <greg@kroah.com>
To: "Guozihua (Scott)" <guozihua@huawei.com>
Cc: Mimi Zohar <zohar@linux.ibm.com>, dmitry.kasatkin@gmail.com,
	jmorris@namei.org, serge@hallyn.com,
	linux-integrity@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] ima: fix deadlock when traversing "ima_default_rules".
Message-ID: <2024052317-reassign-keep-ea77@gregkh>
References: <20240507093714.1031820-1-guozihua@huawei.com>
 <baff6527d8d1e1f7287e33d6a8570bd242d5cadf.camel@linux.ibm.com>
 <3a155ac1-b97a-9ee3-a609-469502653f28@huawei.com>
 <af9692da-dede-bedd-a373-70981da41dee@huawei.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <af9692da-dede-bedd-a373-70981da41dee@huawei.com>

On Wed, May 08, 2024 at 03:06:30PM +0800, Guozihua (Scott) wrote:
> On 2024/5/8 10:06, Guozihua (Scott) wrote:
> > On 2024/5/7 19:54, Mimi Zohar wrote:
> >> On Tue, 2024-05-07 at 09:37 +0000, GUO Zihua wrote:
> >>> From: liqiong <liqiong@nfschina.com>
> >>>
> >>> [ Upstream commit eb0782bbdfd0d7c4786216659277c3fd585afc0e ]
> >>>
> >>> The current IMA ruleset is identified by the variable "ima_rules"
> >>> that default to "&ima_default_rules". When loading a custom policy
> >>> for the first time, the variable is updated to "&ima_policy_rules"
> >>> instead. That update isn't RCU-safe, and deadlocks are possible.
> >>> Indeed, some functions like ima_match_policy() may loop indefinitely
> >>> when traversing "ima_default_rules" with list_for_each_entry_rcu().
> >>>
> >>> When iterating over the default ruleset back to head, if the list
> >>> head is "ima_default_rules", and "ima_rules" have been updated to
> >>> "&ima_policy_rules", the loop condition (&entry->list != ima_rules)
> >>> stays always true, traversing won't terminate, causing a soft lockup
> >>> and RCU stalls.
> >>>
> >>> Introduce a temporary value for "ima_rules" when iterating over
> >>> the ruleset to avoid the deadlocks.
> >>>
> >>> Addition:
> >>>
> >>> A rcu_read_lock pair is added within ima_update_policy_flag to avoid
> >>> suspicious RCU usage warning. This pair of RCU lock was added with
> >>> commit 4f2946aa0c45 ("IMA: introduce a new policy option
> >>> func=SETXATTR_CHECK") on mainstream.
> >>>
> >>> Signed-off-by: liqiong <liqiong@nfschina.com>
> >>> Reviewed-by: THOBY Simon <Simon.THOBY@viveris.fr>
> >>> Fixes: 38d859f991f3 ("IMA: policy can now be updated multiple times")
> >>> Reported-by: kernel test robot <lkp@intel.com> (Fix sparse: incompatible types in comparison expression.)
> >>> Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
> >>> Sig=ned-off-by: GUO Zihua <guozihua@huawei.com>
> >>
> >> Hi Scott,
> >>
> >> I'm confused by this patch.  Is it meant for upstream?
> >>
> >> thanks,
> >>
> >> Mimi
> >>
> > It's a backport from upstream.
> > 
> To clarify, it's meant for Linux-5.10.y.

Now queued up, thanks.

greg k-h

