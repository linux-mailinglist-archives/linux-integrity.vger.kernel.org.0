Return-Path: <linux-integrity+bounces-2253-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9E408B6340
	for <lists+linux-integrity@lfdr.de>; Mon, 29 Apr 2024 22:11:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DEF6FB208A2
	for <lists+linux-integrity@lfdr.de>; Mon, 29 Apr 2024 20:11:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B1261411C9;
	Mon, 29 Apr 2024 20:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="rNb+qhYw";
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="rNb+qhYw"
X-Original-To: linux-integrity@vger.kernel.org
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [96.44.175.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E50F140E58;
	Mon, 29 Apr 2024 20:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.44.175.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714421465; cv=none; b=NFa2yMHdgrKKRjWqcN5xntdMD2zAssyvAPlO9/mdQfnWKDtY+TENB03kPUr3JBCRHv1JXt5UoZtnLYm0sWUIc9EAwmy49I/W/eyRn6RIoUdpcnybVK1Sp20NMTPZigVzPKHc4i15Rnu0wXqER6K86qqUWbsu6Zmd6JYriX8JhlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714421465; c=relaxed/simple;
	bh=qN5aiW7e3+MjFB6f5Rv9QZKLQqZmp3qE2pIlVF3cCsg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BzduB24dstARgU018tnUdRRoovKpDqXRFS3txz+/VOb9Ke8Nb0sTdjdYEba65M/1UjG3T97XHhFk5j5Whwhs2+SfB0bEd77KF+WDIBWfYv4fQIuxXaLBx8Qsoc6DX00uGfIF2IWaaNrwMGfIg8XEWsG8dwuZOaHVToKTjsvv2jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=rNb+qhYw; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=rNb+qhYw; arc=none smtp.client-ip=96.44.175.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1714421460;
	bh=qN5aiW7e3+MjFB6f5Rv9QZKLQqZmp3qE2pIlVF3cCsg=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=rNb+qhYwzJhRNHSLa9m+mHe7MhUUZNlUsorKja5YNPTpLmkOTMFI/Z/TQ/tJllPwj
	 29UHsmB70tRqc2J6Ov8sODVeJUW9lgu06u9py+LsnCGAPxZHApsMrGiGOp0fXmhIwp
	 kdZ5g4bHE/9UMJEto2V3uUWFuUPj3VdlKXBENfw4=
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id 8629E1280977;
	Mon, 29 Apr 2024 16:11:00 -0400 (EDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id ctjt7HWys5Sz; Mon, 29 Apr 2024 16:11:00 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1714421460;
	bh=qN5aiW7e3+MjFB6f5Rv9QZKLQqZmp3qE2pIlVF3cCsg=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=rNb+qhYwzJhRNHSLa9m+mHe7MhUUZNlUsorKja5YNPTpLmkOTMFI/Z/TQ/tJllPwj
	 29UHsmB70tRqc2J6Ov8sODVeJUW9lgu06u9py+LsnCGAPxZHApsMrGiGOp0fXmhIwp
	 kdZ5g4bHE/9UMJEto2V3uUWFuUPj3VdlKXBENfw4=
Received: from [IPv6:2601:5c4:4302:c21::a774] (unknown [IPv6:2601:5c4:4302:c21::a774])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits))
	(Client did not present a certificate)
	by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id D89661280728;
	Mon, 29 Apr 2024 16:10:59 -0400 (EDT)
Message-ID: <778e6af138ed1ce711bc4e89757dbfe1b19cf3b4.camel@HansenPartnership.com>
Subject: Re: [PATCH v7 12/21] tpm: Add NULL primary creation
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Jarkko Sakkinen <jarkko@kernel.org>, linux-integrity@vger.kernel.org
Cc: keyrings@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>
Date: Mon, 29 Apr 2024 16:10:58 -0400
In-Reply-To: <CZCKTWU6ZCC9.2UTEQPEVICYHL@suppilovahvero>
References: <20240213171334.30479-1-James.Bottomley@HansenPartnership.com>
	 <20240213171334.30479-13-James.Bottomley@HansenPartnership.com>
	 <CZCKTWU6ZCC9.2UTEQPEVICYHL@suppilovahvero>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 2024-02-23 at 17:51 +0200, Jarkko Sakkinen wrote:
> On Tue Feb 13, 2024 at 7:13 PM EET, James Bottomley wrote:
[...]
> > --- a/drivers/char/tpm/tpm.h
> > +++ b/drivers/char/tpm/tpm.h
> > @@ -321,4 +321,14 @@ void tpm_bios_log_setup(struct tpm_chip
> > *chip);
> >  void tpm_bios_log_teardown(struct tpm_chip *chip);
> >  int tpm_dev_common_init(void);
> >  void tpm_dev_common_exit(void);
> > +
> > +#ifdef CONFIG_TCG_TPM2_HMAC
> > +int tpm2_sessions_init(struct tpm_chip *chip);
> 
> I'm sorry but "sessions" and "init" are the worst possible
> terminology I could every pick when trying to make a function that
> self-documents itself :-)

About 95% of the kernel that run initialization routines are suffixed
_init. The TCG documents that describe how to effect HMAC and
encryption of commands call the entities used to do this "sessions".
You can argue they should have chosen a better name, but given it's the
name they chose, we have to use it to avoid confusion.

> I'd like to see here well-scoped name so that it is easy to connect
> this to its purpose when reviewing some other patches.

It's purpose is to initialize the sessions handling code in the tpm2-
sessions.c file; I'm not sure I could come up with anything as concise
for self description.


James


