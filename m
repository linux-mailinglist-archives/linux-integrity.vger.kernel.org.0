Return-Path: <linux-integrity+bounces-3929-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4989B9B3C62
	for <lists+linux-integrity@lfdr.de>; Mon, 28 Oct 2024 21:56:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10B4A281F27
	for <lists+linux-integrity@lfdr.de>; Mon, 28 Oct 2024 20:56:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CD7D1DFE2B;
	Mon, 28 Oct 2024 20:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M9FnZOIS"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E4B718FDC2;
	Mon, 28 Oct 2024 20:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730149000; cv=none; b=Qek8tbM4+YAjGV+HQC0cBtnuT/UUZb1yH7hHJ/+6ZdUXoVRDcYjAg2w3Xpd9idVudhfUiK+TvtlVDTfumZYZPQJQ4klP05NtJQWUVREeqvjqBzAd4LonpH7T3qa/4kKJdPP4aaNu3FsKqXlZeh5HV50A0wFVoYX9dVEpv4LgUAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730149000; c=relaxed/simple;
	bh=2xirGwapAOhwwW98vmdKD/TKyBtsn31rVeuL8cNBJcI=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=etEAQlGiz7FBlnWuhDJkRzeYc2U7H8vgqMs3S0Ga13Wu5hyeqtqNkca8NJ2kX68wnap4vHG13iU70dpz7DssoOiO0CErneAUyRu6lCLhvKxdDgFvxss+jhondmJN4ZqvUTk5z3FlC990Xbh5ovSkWDnJuVz6ZThEK7uWjQt/W4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M9FnZOIS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DC9AC4CEC3;
	Mon, 28 Oct 2024 20:56:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730148999;
	bh=2xirGwapAOhwwW98vmdKD/TKyBtsn31rVeuL8cNBJcI=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=M9FnZOISibfA10+UTcpJU5tbxUpfyoN6N8q+2QG8q1Wc0cfJQcoStpPdEBvwu+a4L
	 4zRnqq/gZX+0WWVrWJxL/h6SjpD4LsXzCOwFE1pdZmaiY4sR6XMOBUG2pcBeQ+0KQK
	 O+6evVBtXppq31T/seQi/9hu5VmKewQ5VQHuDQUc6W5ePOMDMWkqVuqH/rOblTA5EX
	 /6ZXOv+sFXrbQ/8F8YqMCUdAalxat97uZz/sQtSVVtxvmnqYjyBHBAF/ZTiBvGzTkK
	 H2y1+SvZHYoEpOaBIZJdLR1JmFVQKIyp53BFy4kV41AwuibgMwhJ7eXITvWgW8DJ11
	 6vsqjl2sMEP4Q==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 28 Oct 2024 22:56:35 +0200
Message-Id: <D57QMS2B7KBS.2AR64O934IY0G@kernel.org>
Cc: <linux-kernel@vger.kernel.org>, "David Howells" <dhowells@redhat.com>,
 "James Bottomley" <James.Bottomley@HansenPartnership.com>, "Mimi Zohar"
 <zohar@linux.ibm.com>, "Roberto Sassu" <roberto.sassu@huawei.com>, "Paul
 Moore" <paul@paul-moore.com>, "James Morris" <jmorris@namei.org>, "Serge E.
 Hallyn" <serge@hallyn.com>, "Dmitry Kasatkin" <dmitry.kasatkin@gmail.com>,
 "Eric Snowberg" <eric.snowberg@oracle.com>, "open list:KEYS-TRUSTED"
 <keyrings@vger.kernel.org>, "open list:SECURITY SUBSYSTEM"
 <linux-security-module@vger.kernel.org>, "Pengyu Ma" <mapengyu@gmail.com>,
 <stable@vger.kernel.org>
Subject: Re: [PATCH v8 3/3] tpm: Lazily flush the auth session
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Stefan Berger" <stefanb@linux.ibm.com>,
 <linux-integrity@vger.kernel.org>, "Peter Huewe" <peterhuewe@gmx.de>,
 "Jason Gunthorpe" <jgg@ziepe.ca>
X-Mailer: aerc 0.18.2
References: <20241028055007.1708971-1-jarkko@kernel.org>
 <20241028055007.1708971-4-jarkko@kernel.org>
 <fa6b6c7d-1b90-40ad-b7f4-73e1a0eef1d5@linux.ibm.com>
In-Reply-To: <fa6b6c7d-1b90-40ad-b7f4-73e1a0eef1d5@linux.ibm.com>

On Mon Oct 28, 2024 at 7:52 PM EET, Stefan Berger wrote:
>
> On 10/28/24 1:50 AM, Jarkko Sakkinen wrote:
> > Move the allocation of chip->auth to tpm2_start_auth_session() so that =
this
> > field can be used as flag to tell whether auth session is active or not=
.
> >=20
> > Instead of flushing and reloading the auth session for every transactio=
n
> > separately, keep the session open unless /dev/tpm0 is used.
> >=20
> > Reported-by: Pengyu Ma <mapengyu@gmail.com>
> > Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D219229
> > Cc: stable@vger.kernel.org # v6.10+
> > Fixes: 7ca110f2679b ("tpm: Address !chip->auth in tpm_buf_append_hmac_s=
ession*()")
> > Tested-by: Pengyu Ma <mapengyu@gmail.com>
> > Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
>
> Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
> Tested-by: Stefan Berger <stefanb@linux.ibm.com>

Thanks!

Next after this: tpm2_get_random() issues reported.

I think biggest problem with that in general, and independent of bugs,
is that it does not pool random but instead pulls random small chunks.
This is more like performance issue exposed by bus encryption than
introducing a new issue (not formally but with better implementation
would not be necessarily a problem).

BR, Jarkko

