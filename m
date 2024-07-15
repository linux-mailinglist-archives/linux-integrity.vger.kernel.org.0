Return-Path: <linux-integrity+bounces-3110-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5540931308
	for <lists+linux-integrity@lfdr.de>; Mon, 15 Jul 2024 13:25:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6083628323E
	for <lists+linux-integrity@lfdr.de>; Mon, 15 Jul 2024 11:25:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78C821891A2;
	Mon, 15 Jul 2024 11:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GvdfMZWL"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DC1E187868;
	Mon, 15 Jul 2024 11:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721042719; cv=none; b=dWdpK9xpaAwttewMHdQHMyEOMaDh/qvhoBXMkIQJ8JrBE5Kh23fwTuDPjFJjojZl7iYs4q+abcnxilebtH+sRCqlrdRypJ4aLZ2TdenvhteaGvbRvPf2JkVsy0VXxRs1gNaEWI5ebrXRM0xLdSbmBZ+6ZEQ7hnTzXFzH9JALqNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721042719; c=relaxed/simple;
	bh=KC0jcakKkauqSbjVB4rvDkrK1IwXEPbpjatq47Q8YLg=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=KDbwpCsjmOHumebYZfZlhthsn3zDdzun2iGBfyAcYSe3vbPH2d/AsDu1S4EOH9pFwpM+D2d0MtGepW7f15EsOB0wV8uqjwdYYHK3gjorTar61eWQ609CAjRZ8xHb+U+fA8RmXjcO0UG8z8FohdlfRPM+E+p0ZICK/JPFx2LYfsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GvdfMZWL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A95FEC32782;
	Mon, 15 Jul 2024 11:25:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721042718;
	bh=KC0jcakKkauqSbjVB4rvDkrK1IwXEPbpjatq47Q8YLg=;
	h=Date:To:Cc:Subject:From:References:In-Reply-To:From;
	b=GvdfMZWLK+QQB0Loqm/2bafYkFbrdwFHsb60HINhZmkOX5GLfIAe7TilDJ89IE0vM
	 nQLxk/HV9nDrSNVsyD7OOTJ5YJRVZFTQ7QOikfyspol/GTVOn+hKVQxP16MjzXgB40
	 3j4lQPzcAP38iN4CnbgPlHtWWSlvo+FjhesaswIyTIwqSjnthkOlIb0TpmHeNGVJPp
	 meSz5XfkWOb/grCWOeRQvfv37w1IDGMNt06MWHsAhNfOQK9tHHt9V9CfjVzBckMf9k
	 71l1Vm62vhAhQZhSW3W/nmeYBJLWimt04kINAxqGgDDL6iLtBQNJQmKgMKVkYfFvS9
	 a0jNGrx196aRQ==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 15 Jul 2024 14:25:15 +0300
Message-Id: <D2Q2Q4R8BZ4Q.2QZF7NM3RE9B8@kernel.org>
To: "Hao Ge" <hao.ge@linux.dev>, <peterhuewe@gmx.de>, <jgg@ziepe.ca>
Cc: <linux-integrity@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Hao
 Ge" <gehao@kylinos.cn>
Subject: Re: [PATCH] tpm: Move dereference after NULL check in
 tpm_buf_check_hmac_response
From: "Jarkko Sakkinen" <jarkko@kernel.org>
X-Mailer: aerc 0.17.0
References: <20240709023337.102509-1-hao.ge@linux.dev>
In-Reply-To: <20240709023337.102509-1-hao.ge@linux.dev>

On Tue Jul 9, 2024 at 5:33 AM EEST, Hao Ge wrote:
> From: Hao Ge <gehao@kylinos.cn>
>
> We shouldn't dereference "auth" until after we have checked that it is
> non-NULL.
>
> Fixes: 7ca110f2679b ("tpm: Address !chip->auth in tpm_buf_append_hmac_ses=
sion*()")
> Signed-off-by: Hao Ge <gehao@kylinos.cn>

Also lacking:

Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/linux-integrity/3b1755a9-b12f-42fc-b26d-de2=
fe4e13ec2@stanley.mountain/T/#u

What is happening here is that my commit exposed pre-existing bug to
static analysis but it did not introduce a new regression. I missed
from your patch how did you ended up to your conclusions.

Please *do not* ignore the sources next time. Either explain how the bug
was found or provide the reporting source. You are essentially taking
credit and also blame from the work that you did not accomplish
yourself, which is both wrong and dishonest.

BR, Jarkko

