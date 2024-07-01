Return-Path: <linux-integrity+bounces-2945-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BB6591E2DD
	for <lists+linux-integrity@lfdr.de>; Mon,  1 Jul 2024 16:53:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 11C37B2237B
	for <lists+linux-integrity@lfdr.de>; Mon,  1 Jul 2024 14:53:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1182716C6A5;
	Mon,  1 Jul 2024 14:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="areSKkIe"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE5F91411DF;
	Mon,  1 Jul 2024 14:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719845617; cv=none; b=K+kFiZ9DFNxGryyudFV6rKBY68XK0UrlwFOnyflj5DplRSJEKPOUlLxfkWfk5Zk7E/cSBSaJ5O4OGVVRnGYpjx/hVw5zqcTnOG8ODA8Sth6Ihuj/4O3Dd/W/X4ff4hBRVQhRTLOYkoMRg1Qaif0TAm+cmhWKaeNWs1y76CVormY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719845617; c=relaxed/simple;
	bh=yuEuUrvrf9RYFQWRBvVIUN1PGXOh9kgr1e+Z1d9sF4Y=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OSXDNKMEpMJEFnNlVSBtrlDym5jhM3UEtGLWlwEu71/gQ8/V5eh+2dTQYlDuggn2A/BEhKHSZJ55UOs7Pp+pohUhcTiwbnI/VxJpSbXZtwDekf1v7qcuRHmgkHCvPSF9mJiUQrI+UEBtJI6Ya8QXoXeA7tqd2VQ0iOxe2H0XlJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=areSKkIe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2165FC116B1;
	Mon,  1 Jul 2024 14:53:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719845616;
	bh=yuEuUrvrf9RYFQWRBvVIUN1PGXOh9kgr1e+Z1d9sF4Y=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=areSKkIeeJUY2Ap59EJGGWO+Nswre0vJmX0ojetisDqWQpzobNc/fFIFj5z2FrQ5h
	 7/RSW9BGJabnqVwtcBlK3QJuampZRIR9VSRpsydVWBaNXO43FhX4vbJTMd1jb2PB82
	 Se+BofJlvcR6G+TV4XqpVIUpAoBf5v0UXLDcp3zX8FtF3tZnZI6lj3K3PD/9ESHLQq
	 x4h4uFs0LSN2e9iEeAWOcV+ivhxelocq90JitRe7h9+1PqgH7+aXVXybbb7NfiVgYj
	 i9xASRFIaq6tx0odc2AexF6IXiJBS2jpe7FtxuZgueMsCvmiyoZAQj09nMSWqRUnW6
	 H92KIcGTTiMzQ==
Message-ID: <3642f5dc17bcb52aab7f0570637e922b08758d08.camel@kernel.org>
Subject: Re: [PATCH] tpm: ibmvtpm: Call tpm2_sessions_init() to initialize
 session support
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Stefan Berger <stefanb@linux.ibm.com>, linux-integrity@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org, mpe@ellerman.id.au, 
	naveen.n.rao@linux.ibm.com
Date: Mon, 01 Jul 2024 14:53:33 +0000
In-Reply-To: <9e167f3e-cd81-45ab-bd34-939f516b05a4@linux.ibm.com>
References: <20240617193408.1234365-1-stefanb@linux.ibm.com>
	 <9e167f3e-cd81-45ab-bd34-939f516b05a4@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.2 (3.52.2-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-06-19 at 18:34 -0400, Stefan Berger wrote:
> Jarkko,
> =C2=A0=C2=A0 are you ok with this patch?

Nope :-) It masks a bug, does not fix it.

BR, Jarkko

