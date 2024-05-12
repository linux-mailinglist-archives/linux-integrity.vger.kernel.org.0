Return-Path: <linux-integrity+bounces-2363-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F1CC88C3917
	for <lists+linux-integrity@lfdr.de>; Mon, 13 May 2024 01:04:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADE1C1F215AA
	for <lists+linux-integrity@lfdr.de>; Sun, 12 May 2024 23:04:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EED0058AA3;
	Sun, 12 May 2024 23:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FnMTJLxV"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE93928F5;
	Sun, 12 May 2024 23:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715555043; cv=none; b=ENnMojsQipXZCbhC3HWWMtU66Eznj1EYZPUVXFZu/Boujd3aiKmjxCvzDqff14/oAn/Np3srLCiat2xkr3sl+ZIhTtzLGiaW+8VeamFC/VHPkOYJdHXCXQg9F6KZKuCaPkCaBHcCLHNqwfYjeBdk0BgHda4x6P1MVXR45ft509w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715555043; c=relaxed/simple;
	bh=5RS9nKU72vuoWK/oLzWJN2joGQUKg0ve4S4/I5HbJbk=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=NeNMitkad0j6lsRpS1nHgnI29jNvoJgtDijMqPfUeBTlvIW5INlXimEygKBBAJOh7xqTKjj50+arVOgxv5V9Ff2JedRN4OpZqaenRcKhbM+V/a2AcUmTXa+AbNkKHYYpHXdQLl2k3VHnfoaC0TpdUAHhrzuDveXZUKruxkMoDv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FnMTJLxV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE049C116B1;
	Sun, 12 May 2024 23:04:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715555043;
	bh=5RS9nKU72vuoWK/oLzWJN2joGQUKg0ve4S4/I5HbJbk=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=FnMTJLxVqqs94BVPzUTyYswte1nnYnqEbYfjaW7MCmCMM8bCH8Mb+A0LMnWQtIoHu
	 SQXNGB2ujnOwUIfwFWuZu1LyKDXz8ktRHp0osk9IBA4Y/SFSW85STEcsUNoB1npT3G
	 +lhr5LVJAL82pO3y7LLi8Eta1hZ+CfGnIlIxkW0PhhNKUCvAUZhpY9aLLR/XMstrg2
	 9C55EUhXVjSY9uLwun3VnQdgJCj0G7L/C4/aXQoN+MkkfQP1bLYFNXhGougJiykBRh
	 HSqTejI/yp/j0kMNooAeNpilzaUPpnszCn7v0bnpDEvzPibIr34O9YY9ytZDtOrxG9
	 kFKDwHh5d/KDA==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 13 May 2024 02:03:59 +0300
Message-Id: <D181I8W0OB91.2VHONX3BPMPP3@kernel.org>
Cc: <linux-integrity@vger.kernel.org>, <keyrings@vger.kernel.org>,
 <linux-security-module@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <trivial@kernel.org>
Subject: Re: [PATCH] integrity: Update comment for load_moklist_certs()
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Yusong Gao" <a869920004@gmail.com>, <zohar@linux.ibm.com>,
 <roberto.sassu@huawei.com>, <dmitry.kasatkin@gmail.com>,
 <eric.snowberg@oracle.com>, <paul@paul-moore.com>, <jmorris@namei.org>,
 <serge@hallyn.com>
X-Mailer: aerc 0.17.0
References: <20240511032224.818418-1-a869920004@gmail.com>
In-Reply-To: <20240511032224.818418-1-a869920004@gmail.com>

On Sat May 11, 2024 at 6:22 AM EEST, Yusong Gao wrote:
> After commit 45fcd5e521cd ("integrity: add new keyring handler for
> mok keys"), the comment about load_moklist_certs() is out-of-date.
> Change keyring name from platform to machine.
>
> Signed-off-by: Yusong Gao <a869920004@gmail.com>
> ---
>  security/integrity/platform_certs/load_uefi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/security/integrity/platform_certs/load_uefi.c b/security/int=
egrity/platform_certs/load_uefi.c
> index d1fdd113450a..e954776d3cfb 100644
> --- a/security/integrity/platform_certs/load_uefi.c
> +++ b/security/integrity/platform_certs/load_uefi.c
> @@ -97,7 +97,7 @@ static __init void *get_cert_list(efi_char16_t *name, e=
fi_guid_t *guid,
>   * load_moklist_certs() - Load MokList certs
>   *
>   * Load the certs contained in the UEFI MokListRT database into the
> - * platform trusted keyring.
> + * machine keyring.
>   *
>   * This routine checks the EFI MOK config table first. If and only if
>   * that fails, this routine uses the MokListRT ordinary UEFI variable.

Alone pretty useless change to be honest. Can be fixed up when something
relevant is changed.

BR, Jarkko

