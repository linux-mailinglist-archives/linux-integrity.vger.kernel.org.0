Return-Path: <linux-integrity+bounces-4102-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E4CF9C68EE
	for <lists+linux-integrity@lfdr.de>; Wed, 13 Nov 2024 06:56:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43B0E28413C
	for <lists+linux-integrity@lfdr.de>; Wed, 13 Nov 2024 05:56:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53B521714CB;
	Wed, 13 Nov 2024 05:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YG2vKlER"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A4ED1527A7;
	Wed, 13 Nov 2024 05:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731477394; cv=none; b=cE7wlO8aKPIVm0ywRdEt/G7ds4HW3TOCQiDoj0CCfqfEfX2qC/aw6aB7F8vSv9iFMkKgDcjUbnnq/z4yxaCPtvRKfvRTSJAzndx9QPC2aRb2cP54GLE/npHowG6fR9spxAr3Ttz7QPj4TDF6qz2prZ/mcItnPkU8kRCoJTm9smY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731477394; c=relaxed/simple;
	bh=MN5GOjIImDbDM2pOrDVGASQO5/OZe6x9pHt7qMO222g=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=HR7EpTVsaX4j/U8gzMI2jilHkAE4yOZxKeNA6O1X6vpI2VVTVUKd4t5f/mWp+U7MpaVvW77PWFbsc1EU0ABQelGjS4mKhZ/Qth+stdeFv3zxvIZ/tEd35czRMS8DKm5zAirqdfGKPFdbKd+CZQHD8Z1rOdcKYpF396KaVvFyAXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YG2vKlER; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2A1AC4CECD;
	Wed, 13 Nov 2024 05:56:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731477393;
	bh=MN5GOjIImDbDM2pOrDVGASQO5/OZe6x9pHt7qMO222g=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=YG2vKlERddDbtjfH4zBA57xZpwGNhlZTBy8ifh/QN2AjvmlO7sWXw3kMnlIw8qG6X
	 JiJMUMIk4BvV+qU/WG1mVApoY2SocaF/2ESELOQVQ6mHWXu2Q+R3icb1GpLlilvNMn
	 4CXkfLE54awLDw4Lh0Eahr9OXazNmQm2R23zKMoRk5RpPylwMMoDULQy/HSuk3qw55
	 2HKmX1IBMfNUllwSU/Z0EU+hessQ0IGnU311Zag4lNH+EbL5/Swnah2QDcqwEp4kym
	 vN+XhH2WhLi85H1bSHpYvNWWDUPukEjIcA5mFB0toI2Wssymse8mKns179o0pFnP+q
	 1XD9jGrtvX/sA==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 13 Nov 2024 07:56:29 +0200
Message-Id: <D5KTIBJRLLZO.393Y9M060YHWG@kernel.org>
Cc: "Roberto Sassu" <roberto.sassu@huawei.com>, "David Howells"
 <dhowells@redhat.com>, "Paul Moore" <paul@paul-moore.com>, "James Morris"
 <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, "Thomas Huth"
 <thuth@redhat.com>, "Andrew Morton" <akpm@linux-foundation.org>, "Paul E.
 McKenney" <paulmck@kernel.org>, "Steven Rostedt" <rostedt@goodmis.org>,
 "Xiongwei Song" <xiongwei.song@windriver.com>, "Stefan Berger"
 <stefanb@linux.ibm.com>, "Ard Biesheuvel" <ardb@kernel.org>, "Al Viro"
 <viro@zeniv.linux.org.uk>, "open list:DOCUMENTATION"
 <linux-doc@vger.kernel.org>, "open list" <linux-kernel@vger.kernel.org>,
 "open list:KEYS-TRUSTED" <keyrings@vger.kernel.org>, "open list:SECURITY
 SUBSYSTEM" <linux-security-module@vger.kernel.org>, "Josh Poimboeuf"
 <jpoimboe@kernel.org>
Subject: Re: [PATCH v3] tpm: Opt-in in disable PCR integrity protection
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Mimi Zohar" <zohar@linux.ibm.com>, <linux-integrity@vger.kernel.org>,
 "Jonathan Corbet" <corbet@lwn.net>, "Peter Huewe" <peterhuewe@gmx.de>,
 "Jason Gunthorpe" <jgg@ziepe.ca>, "James Bottomley"
 <James.Bottomley@HansenPartnership.com>
X-Mailer: aerc 0.18.2
References: <20241113002414.609168-1-jarkko@kernel.org>
 <9649cec7710241dc359c7c1a715b2cef36ebce15.camel@linux.ibm.com>
In-Reply-To: <9649cec7710241dc359c7c1a715b2cef36ebce15.camel@linux.ibm.com>

On Wed Nov 13, 2024 at 6:34 AM EET, Mimi Zohar wrote:
> The module_param variable documentation needs to be updated to reflect th=
e
> actual module_param variable 'disable_pcr_integrity'.
>
> Otherwise,
> Tested-by: Mimi Zohar <zohar@linux.ibm.com>

Thanks for catching that glitch. Here's updated version:

https://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git/comm=
it/?id=3D8f22b3ed4d200ae0c575791e069316c633ed5c39

BR, Jarkko

