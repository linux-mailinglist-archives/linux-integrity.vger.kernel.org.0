Return-Path: <linux-integrity+bounces-2648-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B67F8CF29A
	for <lists+linux-integrity@lfdr.de>; Sun, 26 May 2024 07:43:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A385D281428
	for <lists+linux-integrity@lfdr.de>; Sun, 26 May 2024 05:43:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72794186A;
	Sun, 26 May 2024 05:43:33 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79E2F1849;
	Sun, 26 May 2024 05:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716702213; cv=none; b=pBp6e1FWV2TVRWYdBV6RFShqRxvlwgZLAZac7sM8Y4ForSiYeFTPkyi2K/a6ikPNBRpXJJJIdLZWyZT+TTnC7XmVCLk44XHqIZJAhrBk7/RQPXTFLl0/1jBzZM+LEQd5bBDXa0OmXDS3gThOHa3nXeEvghWSTsBb1Ml7S25na/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716702213; c=relaxed/simple;
	bh=OPMX6x8YbfjqFbkc4RVAg4/SxYD0td8ZmS8MKp33A+8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QUl5+ZI1U9H9WfCdNiraNGS/iTM48MpE/OmYaoHlW9ydThZ27E6UMbSbEXIYuzuSZQ17Ea+es3SLp6nqYQf7RNj8J+haaMzaiH+H4IVTc5eThczkAaiDVNAEARHpcGpai4K3lVFRLGbckggBIdZJ8bRfrcVx4QLMonBlOpuah9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.0.3] (ip5f5af45c.dynamic.kabel-deutschland.de [95.90.244.92])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 97A2761E5FE3D;
	Sun, 26 May 2024 07:42:30 +0200 (CEST)
Message-ID: <17bbe39e-3c68-4e0b-9862-9658f684b19e@molgen.mpg.de>
Date: Sun, 26 May 2024 07:42:29 +0200
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tpm: Open code tpm_buf_parameters()
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
 James.Bottomley@HansenPartnership.com, Peter Huewe <peterhuewe@gmx.de>,
 Jason Gunthorpe <jgg@ziepe.ca>, Mimi Zohar <zohar@linux.ibm.com>,
 David Howells <dhowells@redhat.com>, Paul Moore <paul@paul-moore.com>,
 James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>,
 Stefan Berger <stefanb@linux.ibm.com>, Ard Biesheuvel <ardb@kernel.org>,
 Mario Limonciello <mario.limonciello@amd.com>, linux-kernel@vger.kernel.org,
 linux-security-module@vger.kernel.org
References: <20240525154406.4811-1-jarkko@kernel.org>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20240525154406.4811-1-jarkko@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Jarkko,


Thank you for your patch.

Am 25.05.24 um 17:44 schrieb Jarkko Sakkinen:
> With only single call site, this no sense, and it actually slipped out

this *makes* no sense?

> of the radar during the review. Open code and document the action
> directly to the site, to make it more readable.

[…]


Kind regards,

Paul

