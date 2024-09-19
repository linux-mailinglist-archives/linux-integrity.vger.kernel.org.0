Return-Path: <linux-integrity+bounces-3644-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CBE4797CA51
	for <lists+linux-integrity@lfdr.de>; Thu, 19 Sep 2024 15:45:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 123861C22B78
	for <lists+linux-integrity@lfdr.de>; Thu, 19 Sep 2024 13:45:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A90319E7D1;
	Thu, 19 Sep 2024 13:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eeQx8zw7"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E70C101C8;
	Thu, 19 Sep 2024 13:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726753530; cv=none; b=LkGpmG0dLuBIjaUYwIosShGW5vapFlSxhJb6vh/89CSAanHXjDED8WPpmgmDc6c6WxTlmTjEkZTYlHOsH/VMxjMTdjbZPsHtdP3FQNajI+vDQ4BtRyUvud5d5GiW1R4BgQN0486J8bzJGgkxSvGufNbtnuAgGBiNsnwubLaLCgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726753530; c=relaxed/simple;
	bh=FUYBepLdRp0iSBZxVwRXEjHJHigCeMLd0ZMY0ivjTAc=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=rXE18V+EXzXagBAIAX6He0g5gj3a3IbAOL+c9u3rSey4mVD4zJeDQsqo84pRI3v8uFjQ12QdhifxUO05mFCamur73IKKKBkS2u8teZQIEMWV61ZNgEHEo0h7artDYdFZdZjgL/idyK4CFynWUpg70HG0yLv4Zv8m1ePy3Kk0D14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eeQx8zw7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5916AC4CEC4;
	Thu, 19 Sep 2024 13:45:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726753528;
	bh=FUYBepLdRp0iSBZxVwRXEjHJHigCeMLd0ZMY0ivjTAc=;
	h=Date:To:Cc:Subject:From:References:In-Reply-To:From;
	b=eeQx8zw772AesrOc9kn0TiyBO3HI6qZmGuLzoIhk4QPPWNQ/QOcJXWcquMURaVLRG
	 pPT2cZIJ1OwwQBRJB35JksgkmCHTBlC51zGdkahT6kyp9yyjgEWR2tQggcx0K+Ex9q
	 kWuDxMj1c36R76S1oVGvwT1FxqgNoIP7aRgN+s15Cofj0fkR6q0ZdQLPL9E1MpEnKj
	 0+Vm99bMMWT7cFGLJ5Qd+eZjzV0Vs8i+GwTjGKuHboo7tw7k3CrOGdQWa8udDYwGVK
	 8GVc6Is9kpz8SBS4Uq9KjE7j27v8muCwD7YmvUXqfxi/HYdS2/Rcb0jIlXm6Y5Ud7I
	 JSabZ+qBu5iTg==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 19 Sep 2024 16:45:25 +0300
Message-Id: <D4AB1EB73L84.2CVJGCDFJSWX0@kernel.org>
To: "Pengyu Ma" <mapengyu@gmail.com>
Cc: <linux-integrity@vger.kernel.org>,
 <James.Bottomley@hansenpartnership.com>, <roberto.sassu@huawei.com>, "Mimi
 Zohar" <zohar@linux.ibm.com>, "David Howells" <dhowells@redhat.com>, "Paul
 Moore" <paul@paul-moore.com>, "James Morris" <jmorris@namei.org>, "Serge E.
 Hallyn" <serge@hallyn.com>, <keyrings@vger.kernel.org>,
 <linux-security-module@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 0/5] Lazy flush for the auth session
From: "Jarkko Sakkinen" <jarkko@kernel.org>
X-Mailer: aerc 0.18.2
References: <20240918203559.192605-1-jarkko@kernel.org>
 <CALSz7m3SXE3v-yB=_E3Xf5zCDv6bAYhjb+KHrnZ6J14ay2q9sw@mail.gmail.com>
In-Reply-To: <CALSz7m3SXE3v-yB=_E3Xf5zCDv6bAYhjb+KHrnZ6J14ay2q9sw@mail.gmail.com>

On Thu Sep 19, 2024 at 4:12 AM EEST, Pengyu Ma wrote:
> On Thu, Sep 19, 2024 at 4:36=E2=80=AFAM Jarkko Sakkinen <jarkko@kernel.or=
g> wrote:
> >
> > For the sake of:
> > https://bugzilla.kernel.org/show_bug.cgi?id=3D219229
> >
> > The baseline for the series is v6.11 tag.
>
> Clean applied on v6.11 upstream kernel.
> Boot time is 8.7 seconds which is almost good as 7 seconds without TPM2_H=
MAC.

Awesome thank you! I think there could be some places where we could
further make "100 ms here and 50 ms there" time savings. I'll look
at those when I have some bandwidth but overally I think we are
now in pretty acceptable measures :-)

Thanks again for all the effort with testing this!

BR, Jarkko

