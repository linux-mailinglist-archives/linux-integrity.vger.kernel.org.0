Return-Path: <linux-integrity+bounces-3747-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D2DA5993B69
	for <lists+linux-integrity@lfdr.de>; Tue,  8 Oct 2024 01:49:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A199281502
	for <lists+linux-integrity@lfdr.de>; Mon,  7 Oct 2024 23:49:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B170518EFC6;
	Mon,  7 Oct 2024 23:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FxPc4Ui/"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F9C618C90A;
	Mon,  7 Oct 2024 23:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728344966; cv=none; b=iUmiKth0MpXeLmm78ePXWOMmSs2qW7fdfPC1cnW2jaMUf3mCIhdcLjoOO/Wl1xhV79A6SYHkXtDiYPIK58/m9i3Jl2sgayWN8CcB9Q38pxyOVDz07MTblS2CTo66AxAjDmoOkLPgYhMWfqkVpnGEt2EOFfqreEtCmEmVC0Vg3mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728344966; c=relaxed/simple;
	bh=RQea1xOvcFlUuQShOAEXZCqknMqD2qPxnzXHUX7psZA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bsx5NO3j3nO48/sb64LaAa34zBUU+m6gw8ivql67N//51tOytLcUMo73T51mCKWv/jaYuSIMO17pIqQOWh1tOjtC2CD3aCt4zaudDr++STAL0c4Iww0TEcNMMIpV8L/7HYD8AllUNxmicf+MD32nzzkX49E3eP+d6MjKOG101zA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FxPc4Ui/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 998EEC4CEC6;
	Mon,  7 Oct 2024 23:49:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728344966;
	bh=RQea1xOvcFlUuQShOAEXZCqknMqD2qPxnzXHUX7psZA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=FxPc4Ui/40o6dhkE3q8Sdqgg0wQNpWL5VJIWGcLCPbY4ZebrArJ3mRBNS+4C3oRMy
	 pktEzgQO4r5UHujz0s4kXlA9pRI9I3D/B1MhhS1NTKohJ1ZcJk6ePeNyiMWb73I9i5
	 ElSsv5d/O5xRdJWFGnWV0zJqvdXvyBo0evQC04uFZ6taAhFOdjg5PNjPxM26IWGh+8
	 vRUk4/LfAhXZf7RsvdBvAJIVh9AJmwzbzqkNoGX6sxltkIXKo5aazAVCdAii1bslMi
	 55aXoeS73u2bTam+0Cy6gP0kAFM6LznuZZCkZrKUHxGzZHyTNmr9+wlO269ITl4vVI
	 Kz2tAzcoFDKWg==
Message-ID: <b2dd8b0587f6d40a0474cb76db3a339442021bf2.camel@kernel.org>
Subject: Re: [PATCH v5 0/5] Lazy flush for the auth session
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Stefan Berger <stefanb@linux.ibm.com>, linux-integrity@vger.kernel.org
Cc: James.Bottomley@HansenPartnership.com, roberto.sassu@huawei.com, 
 mapengyu@gmail.com, Mimi Zohar <zohar@linux.ibm.com>, David Howells
 <dhowells@redhat.com>, Paul Moore <paul@paul-moore.com>, James Morris
 <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, Peter Huewe
 <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
 keyrings@vger.kernel.org,  linux-security-module@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Tue, 08 Oct 2024 02:49:21 +0300
In-Reply-To: <7f05ff8e-6103-4ad7-8a32-9ff5643b8a41@linux.ibm.com>
References: <20240921120811.1264985-1-jarkko@kernel.org>
	 <7f05ff8e-6103-4ad7-8a32-9ff5643b8a41@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-10-03 at 11:14 -0400, Stefan Berger wrote:
>=20
>=20
> On 9/21/24 8:08 AM, Jarkko Sakkinen wrote:
> > This patch set aims to fix:
> > https://bugzilla.kernel.org/show_bug.cgi?id=3D219229.
> >=20
> > The baseline for the series is the v6.11 tag.
>=20
> I was testing this with 6.12-rc1 on ppc64/kvm + vtpm boot time from=20
> pressing return on grub until login prompt appears while using an IMA
> measure policy:
>=20
> with HMAC2: 36s
> with HMAC2+this series: 29s
> without HMAC2: 28s
>=20
> Looks good to me, though using a hardware TPM would probably be more=20
> critical in this type of measurement.

Yep, exactly. QEMU fails here...

BR, Jarkko

