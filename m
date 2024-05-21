Return-Path: <linux-integrity+bounces-2513-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D10AD8CB069
	for <lists+linux-integrity@lfdr.de>; Tue, 21 May 2024 16:27:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B81D28593E
	for <lists+linux-integrity@lfdr.de>; Tue, 21 May 2024 14:27:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91C9412FF8E;
	Tue, 21 May 2024 14:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oTzoosUc"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FBB312FF92;
	Tue, 21 May 2024 14:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716301619; cv=none; b=rhyt1fmrehjVh9IA03EHZ+qP0JuhO/9Wjz5/OvzN3ouCxGQ+F2tiYJRG43Jfeh1ZcAK8dhHo5CapIzXS1C+BOHmQYXQriGs5xhjfc6yvqvYLvbXhbBPRBBqKvSeWp/7Ort6CQWab88W675I1uiwvDieoyPYiNHcMLaHgjw+9Ibo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716301619; c=relaxed/simple;
	bh=1g2QcHXVGrgKGcleBAKJcmGbMkt1SO1MJSLlE1cOLmw=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=KcQSMND8CkLCBiC0JvQfa06C2lYgF3Qd77CEpZfQAfmPjYogkdgUIalP71mJDcmatON3T0p4+4UWiJdSE54anrxnQuuqofDvvPYBNRsnONvtYgTDzOuPaeD8vHM5VoUZTbM2dtG5wN/eHy0/FJXVw4W8E0Li+5bKMYnF9QQhEBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oTzoosUc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EACCC2BD11;
	Tue, 21 May 2024 14:26:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716301619;
	bh=1g2QcHXVGrgKGcleBAKJcmGbMkt1SO1MJSLlE1cOLmw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oTzoosUcMowiKdDmdDCn3VHirfdkeXbkWRAuIezBZldov1LQpPyNftWBVWMcq3Zqw
	 /J/wjBLNxTVoWsTIBinFzMc6K4MPZ2JZBOBQ3kO6C7S59+fOG0v+zrdmTS2r+QyQRZ
	 H6JHusUp+xtT2YeNmXCLwbOiSNhS05SS64SGkmEi0pmojqOssWrj/0GmRe5bdBEN2A
	 gwSNGzo05bomi/6E5ZJ+yx1i/BaSacwvDs0FvyQ0RnTtVlBd5BeFeTkpe6oB1zIub9
	 PAvDqGBb62/GZGe0kB++B6xIVQoz6P7ep7KyuOY3CH+QTcaVcBoZQ+VixFzYgvBJ2K
	 L5vGMD08zSvlg==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 21 May 2024 17:26:54 +0300
Message-Id: <D1FE58VX0KL4.70F6U9Y6HPQC@kernel.org>
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "James Bottomley" <James.Bottomley@HansenPartnership.com>,
 <linux-integrity@vger.kernel.org>
Cc: <keyrings@vger.kernel.org>, "Peter Huewe" <peterhuewe@gmx.de>, "Jason
 Gunthorpe" <jgg@ziepe.ca>, "Mimi Zohar" <zohar@linux.ibm.com>, "David
 Howells" <dhowells@redhat.com>, "Paul Moore" <paul@paul-moore.com>, "James
 Morris" <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>,
 <linux-kernel@vger.kernel.org>, <linux-security-module@vger.kernel.org>
Subject: Re: [PATCH] tpm: enable HMAC encryption for only x86-64 and aarch64
X-Mailer: aerc 0.17.0
References: <20240521130921.15028-1-jarkko@kernel.org>
 <236606947b691049c650bdf82c37324084662147.camel@HansenPartnership.com>
 <D1FDMULT5YRK.GZOPJ9FZ325R@kernel.org>
 <854fa2e1634eb116b979dab499243e40917c637c.camel@HansenPartnership.com>
In-Reply-To: <854fa2e1634eb116b979dab499243e40917c637c.camel@HansenPartnership.com>

On Tue May 21, 2024 at 5:13 PM EEST, James Bottomley wrote:
> On Tue, 2024-05-21 at 17:02 +0300, Jarkko Sakkinen wrote:
> > Secondly, it also roots to the null key if a parent is not given. So
> > it covers all the basic features of the HMAC patch set.
>
> I don't think that can work.  The key file would be wrapped to the
> parent and the null seed (and hence the wrapping) changes with every
> reboot.  If you want a permanent key, it has to be in one of the
> accessible permanent hierarchies (storage ideally or endorsement).

I'm fully aware that null seed is randomized per power cycle.

The fallback was inherited from James Prestwood's original code and I
decided to keep it as a testing feature, and also to test HMAC changes.

If you look at the testing transcript in the cover letter, it should be
obvious that a primary key is created in my basic test.

BR, Jarkko

