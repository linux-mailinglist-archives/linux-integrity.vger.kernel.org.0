Return-Path: <linux-integrity+bounces-2333-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 46B838BBC4E
	for <lists+linux-integrity@lfdr.de>; Sat,  4 May 2024 15:55:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 024372823BD
	for <lists+linux-integrity@lfdr.de>; Sat,  4 May 2024 13:55:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F2BA374F1;
	Sat,  4 May 2024 13:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=benboeckel.net header.i=@benboeckel.net header.b="BKIGsNYc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Kwh0vdut"
X-Original-To: linux-integrity@vger.kernel.org
Received: from fout7-smtp.messagingengine.com (fout7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDBC124B2A;
	Sat,  4 May 2024 13:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714830935; cv=none; b=ZbRdb4ElxFljcUZMHSy4a8w07efSCzlwgF1FrhTQwdS/5jQ/sGlUaGsBPTpbzxOz1O0Gs/qKk53+RCgCIBJU3NQuHSbqy1qKIjEJky0NX5Rq2kasbReirUq5ULQRZXAIj8w9QLlIp1H5Hfg0cRZGcgSKg/qTAUS70j+/3tj/+dY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714830935; c=relaxed/simple;
	bh=Dr6moDwcHaVY/M5vimL+8X/TwtPDRUKWxK9/5v3fnZc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q/YFH73uWBz/vE8sBuflowOstkg+lyS/VS3+6fEcqD/08L0OeMIC4r72VmGqJfdTrwFTGWKVxxBcdavfXsWJXGA2iO9XSo77yxo+21baerJ5yi2f8yFvJK5HoiuThX33hsN74yfJBdLHW7PZno78RKE96ZSEio9DVhEEQpRxrOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=benboeckel.net; spf=pass smtp.mailfrom=benboeckel.net; dkim=pass (2048-bit key) header.d=benboeckel.net header.i=@benboeckel.net header.b=BKIGsNYc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Kwh0vdut; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=benboeckel.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=benboeckel.net
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfout.nyi.internal (Postfix) with ESMTP id ADAA01380386;
	Sat,  4 May 2024 09:55:31 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Sat, 04 May 2024 09:55:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=benboeckel.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1714830931; x=
	1714917331; bh=Dr6moDwcHaVY/M5vimL+8X/TwtPDRUKWxK9/5v3fnZc=; b=B
	KIGsNYc5LsBPFCfjVZNHjuAvW1kYLsmljo4tpB+cckYIalyhPsyI/Vozr2aYYyxt
	4+jeJiOegKOEWsv95VXuJ+ehHySzs9+p4t4mvS2P/H4huCc5EqIDy5ne+fq+xTZ8
	6CGddwJtRMWD50TssP16tI8FMTpwx1GW+dBe5OtnFbKLk4sKAQwdu/eJ39NVecNb
	S8o0OXs00weiv3AEy+Dw/1TYAb1ObvcdZD+GQFXDj/agzYgO59Cfof2CUYxDWgMo
	g+4PFjUWRLQL8MD+8CbIWp/s9pPXTSWHMXorxITj2tJu/o6i/wqU4jnYZ18k0x3D
	Kz6XA+wRNIM9DOVszhyqw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1714830931; x=1714917331; bh=Dr6moDwcHaVY/M5vimL+8X/TwtPD
	RUKWxK9/5v3fnZc=; b=Kwh0vduthkpU+Vl1YwNqRuiJi+Volo7we9c5i9iN+kID
	1B8KM8qDZsMATWvM+8iyzaZ9efu5blHoCIrclzBy/aXGLNZLSNutATaog++iFVDb
	u/OPSEyrgZV6/pzGINrUy1nkrsIXSP2XxGFatLW3LSmZYK1DrMJ5nW7s1yx59t3X
	kh5vCDynAc/aynCDYFhSoLdvxWWnrYAeoH7leVn3wLCKne5GeLnbv/dgEEbJK5mZ
	hGZ+c4lrLpmkXS0+yxgOsqPeXvfvO48Ursi7CJjtriZR++s+Gg7jitH38m+cIzNy
	ZbkpdjehdidqJ7IjzVX2SvNUHpiiU8b+7Bfq2C5KKw==
X-ME-Sender: <xms:Uj42ZoiAMYGbTF0weTitm7AOidAk8dJ_ZNcNgBI8hSS0zk2w7t0XVQ>
    <xme:Uj42ZhAG5DAKgVRPqsviKpo5Ak4mqu3RfgrPwCemlNbrbex45fa06UMTt6GdQOYmN
    npMqXOsGlw2zWazyZY>
X-ME-Received: <xmr:Uj42ZgFNqRzdrCV6s-naXzg6WJC8RTNjkXTVDXCa-eOsgjx2Tf4Br4dRYSBz6aAKhOdkKaCGYzqs8kiHN6qf1lq7joQdHciXS7bD>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvddvvddgjedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujggfsehttdertddtreejnecuhfhrohhmpeeuvghn
    uceuohgvtghkvghluceomhgvsegsvghnsghovggtkhgvlhdrnhgvtheqnecuggftrfgrth
    htvghrnhepffelgeffveelkeffkeehiefgtdeluedvtdfghfdtvdefgfejheffudeuveek
    vddvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmh
    gvsegsvghnsghovggtkhgvlhdrnhgvth
X-ME-Proxy: <xmx:Uj42ZpQbFG8LS3jUqS05X9HpPWZRbKB8bwzOxzj3lDsY2POXO-lZgg>
    <xmx:Uj42Zlx6Cl1GwWky8db7CcV2aD-27hWfbPvBAeUvz8Nicj-6MLTQSg>
    <xmx:Uj42Zn5dGx0AlMnjT5tlJ5ts9TOUFzvdBjs_xpuLsuCSA9OM0TdRpA>
    <xmx:Uj42ZiyUa-FMsPcV7XD3kq-dbPK5i3yRckL9h0h0NqgxJ7qRc3UVeQ>
    <xmx:Uz42Zor3FF79OMYHbo0i3mBo6IJMu5sTN9SY1mpYK3Kx6adyWcoXBF5L>
Feedback-ID: iffc1478b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 4 May 2024 09:55:30 -0400 (EDT)
Date: Sat, 4 May 2024 09:55:29 -0400
From: Ben Boeckel <me@benboeckel.net>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Ignat Korchagin <ignat@cloudflare.com>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	David Howells <dhowells@redhat.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	serge@hallyn.com, linux-integrity@vger.kernel.org,
	keyrings@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-team@cloudflare.com
Subject: Re: [RFC PATCH 0/2] TPM derived keys
Message-ID: <ZjY-UU8pROnwlTuH@farprobe>
References: <20240503221634.44274-1-ignat@cloudflare.com>
 <D10FIGJ84Q71.2VT5MH1VUDP0R@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <D10FIGJ84Q71.2VT5MH1VUDP0R@kernel.org>
User-Agent: Mutt/2.2.12 (2023-09-09)

On Sat, May 04, 2024 at 03:21:11 +0300, Jarkko Sakkinen wrote:
> I have no idea for what the key created with this is even used, which
> makes this impossible to review.

Additionally, there is nothing in Documentation/ for how userspace might
use or create them. This includes things like their description format
and describing available options.

--Ben

