Return-Path: <linux-integrity+bounces-3111-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C2A0C931378
	for <lists+linux-integrity@lfdr.de>; Mon, 15 Jul 2024 13:52:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A0351F23DF4
	for <lists+linux-integrity@lfdr.de>; Mon, 15 Jul 2024 11:52:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10954189F5F;
	Mon, 15 Jul 2024 11:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="RvLQkDDu";
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="RvLQkDDu"
X-Original-To: linux-integrity@vger.kernel.org
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [96.44.175.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08629187868;
	Mon, 15 Jul 2024 11:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.44.175.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721044343; cv=none; b=hW4IybHQ7GkkNDqKeXcrzvehEu3arcR4sPQQZkVukiezXcMqzmxRfb8HVggXlxbl5nP+D0pA5KL2aHwvTowoRmzdvldn23ihURZjfBeUhucMm1Qdpyok5tTbjDPe6ttCbDm/yIKt3pmK1BmPu1PexZLLcWqSIGXnT4o6N2tfzX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721044343; c=relaxed/simple;
	bh=PrVrtzXKdJak050dS1hUn835fsKc7EDVplg1jLcrIMo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Y7Z5peOUO225qyBxKeve/pKcL3ji02oozj/jQ5xAq626nWZwzE7hC0QOqVn9Sw9lovvuU4menb+pShbD3T4pUmKTIh9vSWQ7QNlegQkatBPLe0iWvDk9I0Vi4NKiUEdyxsMCNNsX5yWIx+S4W6A36joqdPQol7sb8vEGspEtKV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=RvLQkDDu; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=RvLQkDDu; arc=none smtp.client-ip=96.44.175.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1721044339;
	bh=PrVrtzXKdJak050dS1hUn835fsKc7EDVplg1jLcrIMo=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=RvLQkDDu2rC3b6CMv9u9LZd/Y2kV0N6fH+9LKUs3DjA3wzzqScr3VmHuCLyBMO53C
	 ymC48ruJ+0GceKEOMZIOCoRqxJUbDG5rT+BpiSDqottYfCdg+NBONkJ1IYbA/Z3Cyd
	 /4LYCpIvByAfU4ckxyM2Wvi6+N2xxNqiyfVZvbmg=
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id C54D91281802;
	Mon, 15 Jul 2024 07:52:19 -0400 (EDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id JkKL_Oj60n8I; Mon, 15 Jul 2024 07:52:19 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1721044339;
	bh=PrVrtzXKdJak050dS1hUn835fsKc7EDVplg1jLcrIMo=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=RvLQkDDu2rC3b6CMv9u9LZd/Y2kV0N6fH+9LKUs3DjA3wzzqScr3VmHuCLyBMO53C
	 ymC48ruJ+0GceKEOMZIOCoRqxJUbDG5rT+BpiSDqottYfCdg+NBONkJ1IYbA/Z3Cyd
	 /4LYCpIvByAfU4ckxyM2Wvi6+N2xxNqiyfVZvbmg=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4302:c21::a774])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id D7B9F1280F4F;
	Mon, 15 Jul 2024 07:52:18 -0400 (EDT)
Message-ID: <f6ab30f39a14550b6fc111feb83b2657006b8b8c.camel@HansenPartnership.com>
Subject: Re: [PATCH] tpm: Move dereference after NULL check in
 tpm_buf_check_hmac_response
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Jarkko Sakkinen <jarkko@kernel.org>, Hao Ge <hao.ge@linux.dev>, 
	peterhuewe@gmx.de, jgg@ziepe.ca
Cc: linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org, Hao Ge
	 <gehao@kylinos.cn>
Date: Mon, 15 Jul 2024 07:52:16 -0400
In-Reply-To: <D2Q2Q4R8BZ4Q.2QZF7NM3RE9B8@kernel.org>
References: <20240709023337.102509-1-hao.ge@linux.dev>
	 <D2Q2Q4R8BZ4Q.2QZF7NM3RE9B8@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

On Mon, 2024-07-15 at 14:25 +0300, Jarkko Sakkinen wrote:
> On Tue Jul 9, 2024 at 5:33 AM EEST, Hao Ge wrote:
> > From: Hao Ge <gehao@kylinos.cn>
> > 
> > We shouldn't dereference "auth" until after we have checked that it
> > is
> > non-NULL.
> > 
> > Fixes: 7ca110f2679b ("tpm: Address !chip->auth in
> > tpm_buf_append_hmac_session*()")
> > Signed-off-by: Hao Ge <gehao@kylinos.cn>
> 
> Also lacking:
> 
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Closes:
> https://lore.kernel.org/linux-integrity/3b1755a9-b12f-42fc-b26d-de2fe4e13ec2@stanley.mountain/T/#u
> 
> What is happening here is that my commit exposed pre-existing bug to
> static analysis but it did not introduce a new regression.

Actually, it didn't.  The previous design was sessions were config
determined and either auth would be non-NULL or attach would fail.  You
chose with this series to make auth the indicator of whether sessions
should be used, and before this auth could not be NULL so no bug
existed.

Consider also the fidelity of the Fixes tag for stable: this commit
needs backporting with 7ca110f2679b and Fixes should identify that

James


