Return-Path: <linux-integrity+bounces-3592-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10197979644
	for <lists+linux-integrity@lfdr.de>; Sun, 15 Sep 2024 12:08:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 560BCB20EB9
	for <lists+linux-integrity@lfdr.de>; Sun, 15 Sep 2024 10:08:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD6951C3F17;
	Sun, 15 Sep 2024 10:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PokY6f7c"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78D8343AD9;
	Sun, 15 Sep 2024 10:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726394881; cv=none; b=BqPMQ6IX9b9A+tDReVMJviC+Yo/IOBO/lebcqu/XNXVZMtyzwtTgppOAXqgH8niIyh1G3CIKTDO2suFK/rlIlCwtiC00DEO15G99BU5pTypfhAXjDYGyHrQlT2mwI2Ia1PuCfjC2wBbuRko/DcBHkDmkUGc2fwrPbnaf/VDdF9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726394881; c=relaxed/simple;
	bh=YdbDhh4xMmlFf3aK29meBGYVCd2R6xK3NzgPUKIf5Tk=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=sJU1EVZWAt5LHX+DhpZlpohiOe3IXC8YfzF3qwUL4KwnxhT51Wxpi83JgfA7mwbbPoLLGcU2dJUZldsyIo96RYHQ8cmQf8HUUXkZfKrcmpToqhPFMRM7A3lUwL462RGn09Q6m0vHrs5JruMPo2fdz3ChuFzcl8vDi4a7bMMFHkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PokY6f7c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75678C4CEC3;
	Sun, 15 Sep 2024 10:08:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726394881;
	bh=YdbDhh4xMmlFf3aK29meBGYVCd2R6xK3NzgPUKIf5Tk=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=PokY6f7cqmhnLvhnlcz8piVvc7Og1vDaZVxTzITdJbia+JBgxYH8AwAsCgH5BxJT1
	 xMgEx36OUnTIw/W1BzJ5JCGaN5qcJ42P6uzRhy/ET/3td9CiaYtMRcUfMwPTsg43rK
	 vZg08sSQ9Q+eZwcBnLDWGt85IiiEt7KZN5d7vl8TsIrQqctEwacUgqVSv8R+ZfEYlY
	 2FbMVBr02BBDYUmkD/kkN88i0K5T0CTnPpcHrvvwezH7Gkqcz2iZ7bPKU5tY6uAm5K
	 0FqVEI+9BlfCSpwoERQ98m6mdxAmIxG187dLKG4HD1+8t9Uk3ZKoERXgxIby0SXcpn
	 0eJBeD4rce2dw==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 15 Sep 2024 13:07:57 +0300
Message-Id: <D46RWPQ211ZS.12EYKZY053BH@kernel.org>
Cc: <keyrings@vger.kernel.org>, "linux-integrity@vger.kernel.org"
 <linux-integrity@vger.kernel.org>, "LKML" <linux-kernel@vger.kernel.org>,
 "Pengyu Ma" <mapengyu@gmail.com>
Subject: Re: [regression] significant delays when secureboot is enabled
 since 6.10
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Jarkko Sakkinen" <jarkko@kernel.org>, "Roberto Sassu"
 <roberto.sassu@huaweicloud.com>, "James Bottomley"
 <James.Bottomley@HansenPartnership.com>, "Linux regressions mailing list"
 <regressions@lists.linux.dev>
X-Mailer: aerc 0.18.2
References: <0b4a5a86-a9f6-42d1-a9ba-ec565b336d3a@leemhuis.info>
 <92fbcc4c252ec9070d71a6c7d4f1d196ec67eeb0.camel@huaweicloud.com>
 <D42LZPLE8HR3.2UTNOI9CYZPIR@kernel.org>
 <D42M6OE94RLT.6EZSZLBTX437@kernel.org>
 <663d272617d1aead08077ad2b72929cbc226372a.camel@HansenPartnership.com>
 <D42N17MFTEDM.3E6IK034S26UT@kernel.org>
 <f554031343039883068145f9f4777277e490dc05.camel@huaweicloud.com>
 <D43JXBFOOB2O.3U6ZQ7DASR1ZW@kernel.org>
 <7e47f97aede88b87fbb9c9284db2005764bfbedd.camel@huaweicloud.com>
 <D46RE2BWMGJ4.25VA7IVYTJ8MO@kernel.org>
In-Reply-To: <D46RE2BWMGJ4.25VA7IVYTJ8MO@kernel.org>

On Sun Sep 15, 2024 at 12:43 PM EEST, Jarkko Sakkinen wrote:
> When it comes to boot we should aim for one single start_auth_session
> during boot, i.e. different phases would leave that session open so
> that we don't have to load the context every single time.  I think it
> should be doable.

The best possible idea how to improve performance here would be to
transfer the cost from time to space. This can be achieved by keeping
null key permanently in the TPM memory during power cycle.

It would give about 80% increase given Roberto's benchmark to all
in-kernel callers. There's no really other possible solution for this
to make any major improvements. So after opt-in kernel command line
option I might look into this.

This is already done locally in tpm2_get_random(), which uses
continueSession to keep session open for all calls.

BR, Jarkko

