Return-Path: <linux-integrity+bounces-3956-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F5039B8892
	for <lists+linux-integrity@lfdr.de>; Fri,  1 Nov 2024 02:36:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F05C1F221F7
	for <lists+linux-integrity@lfdr.de>; Fri,  1 Nov 2024 01:36:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A44564D8D1;
	Fri,  1 Nov 2024 01:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ldpHo7jm"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72F581EF1D;
	Fri,  1 Nov 2024 01:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730424989; cv=none; b=hTAPvMQ6TWgmwPkulGvdNfxSXFsqwOdOlF7fDJMib19YdcrAWMo7w6m58/G8INvsh24/qIhgMDLyQN3LmlSyJ1Fi+GCF91SK42/2LqEpQDVsPTPg2r1oQpSpbizoXTCZoD9+q8504hH3KfwFcUnTZU/OKVXDcI3wGxamN6Qr52w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730424989; c=relaxed/simple;
	bh=U9rXdex20pdzghMTxJDoyy1xjpUN9kjUud61Ah3KPMU=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=hLverEm6avApF74XFi4arBNd/PvX4P6eOgBR+7NbkGQtHi4TZcgyEECQ7B3GNZbj+0G2iFJPc2ekuMJ6aobe2wz4gBOvdI9BR6qa46fyPfqpCBAysdk7xARrNsxXjD76mcnwZFkybHqYqKNnQkgDTGifd6dQvyhU23NGadXB1xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ldpHo7jm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D049C4CEC3;
	Fri,  1 Nov 2024 01:36:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730424988;
	bh=U9rXdex20pdzghMTxJDoyy1xjpUN9kjUud61Ah3KPMU=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=ldpHo7jmB6nHqp7B4MfBAE0kf4qbxxmiLJKRcb2bXCP6Q+VQ34Feu9tBV75GY0tUP
	 ceQBALkpKRQULMO+8wVOLYj8nfjDUY+3bOwQdAr4/yYQ/nUrCIECkR3hauEf8TSgSZ
	 ZNoT2c/fsAn8Kk7Y4rskpdPfAsJfi+cbGbQ4FT6uPQ6sMweffLUg2cyHF5jjRswExy
	 pV/jau6rS01O1M38tVhsuDPu6+IYvgQPstIN9AzWzjMebdqH0XnBi+uu2nXTLEWeX0
	 1X+zD47eNiKk5reppE7X2cWD8OyhHC3sJQwlVR7g/YZW8f5CVL7ULkCxgnWZHm1HFu
	 TQ4mI7902XkQA==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 01 Nov 2024 03:36:24 +0200
Message-Id: <D5AGGNMO6W6H.POLV23HA8CKQ@kernel.org>
Cc: <stable@vger.kernel.org>, "Mike Seo" <mikeseohyungjin@gmail.com>, "open
 list:TPM DEVICE DRIVER" <linux-integrity@vger.kernel.org>, "open list"
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] tpm: Lock TPM chip in tpm_pm_suspend() first
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Jarkko Sakkinen" <jarkko@kernel.org>, "Peter Huewe"
 <peterhuewe@gmx.de>, "Jason Gunthorpe" <jgg@ziepe.ca>, "Jerry Snitselaar"
 <jsnitsel@redhat.com>
X-Mailer: aerc 0.18.2
References: <20241101002157.645874-1-jarkko@kernel.org>
 <D5AEYFC1VUYN.24WN7GVHN1MDU@kernel.org>
In-Reply-To: <D5AEYFC1VUYN.24WN7GVHN1MDU@kernel.org>

On Fri Nov 1, 2024 at 2:25 AM EET, Jarkko Sakkinen wrote:
> cmake -Bbuild -Dbuildroot_defconfig=3Dbusybox_x86_64_defconfig && make -C=
build buildroot-prepare
> make -Cbuild/buildroot/build
> pushd build/buildroot/build
> images/run-qemu.sh &
> socat - UNIX-CONNECT:images/serial.sock

and export LINUX_OVERRIDE_SRCDIR=3D/home/jarkko/work/kernel.org/jarkko/linu=
x-tpmdd

<offtopic>
I wondered what was the thing anyway with those "kernel patches for
Github/lab" discussed in LWN while ago. If you know how to propeerly
use BuildRoot, CI compatibility is and old thing. This has been fully
tested to run also inside CI (and has run-tests.sh based on TCL's
utility expect). How I understood that article was lack of knowledge
of the tools available. Hope none of those kernel patches never
landed tbh...
</offtopic>

BR, Jarkko

