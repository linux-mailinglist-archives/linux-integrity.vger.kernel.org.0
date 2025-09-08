Return-Path: <linux-integrity+bounces-7036-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A33EB49BA3
	for <lists+linux-integrity@lfdr.de>; Mon,  8 Sep 2025 23:12:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 359C64E0563
	for <lists+linux-integrity@lfdr.de>; Mon,  8 Sep 2025 21:12:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8674D2DCF61;
	Mon,  8 Sep 2025 21:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="NwwlXF+2"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06D3E47F4A
	for <linux-integrity@vger.kernel.org>; Mon,  8 Sep 2025 21:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757365963; cv=none; b=JY8G1mfdIvu0bxFZ2p70g6pQKMDlDjtaYC5yIm0NVMR4IWiG69SWMEmByahV3fzNbqceyCbvrE6eikCgfBHtD9gEc3nbCOez0UPKrSUdEk+zETiqfhBmH45Y7MHupGhqjAaBVL/2ozCCbOZC85wpyT7imS2Uzk8aH9ZgMdrHuoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757365963; c=relaxed/simple;
	bh=XRTx+EIPYf2U/8kH1WHhk+Pr+1repADusuxwe8OzR40=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JfyDFzSKgvYFw4154WWx/PN39OCyFoCe9ZhdsASJYOqkuKu06Kn7TI+G/g+RzhD2ECcvL1RWTnzdd1KmO0diE95ogDGGfWqiFIzGhSKjonjbonoDe2kq7tPQWPptfAuZ92Ibn0yDgZsbwV3PjufMYdm5JepNpt9P4xj6v5+UPE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=NwwlXF+2; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-32da35469f7so87783a91.1
        for <linux-integrity@vger.kernel.org>; Mon, 08 Sep 2025 14:12:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1757365961; x=1757970761; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I2NQT+Mk3p4TSCxt7pK5wFXpw9ktcr0hQ9tdUnoEinw=;
        b=NwwlXF+2GLZv9OEZPONFZAH0prn35DQcA8xpLQXPmRs5wk7t16OIVhF34SSXAmHze4
         EhbUUQ/o+G2Kx+jyo6TPwl0WusU4pdkuz1NmPIENKUvkQSKbNpXY2IwlAi90i1dmngWF
         j0E18L4XRmjZEtPYOIH+CowhukKP4lZs4aDtGKYf4jzbqYVafBWWZKuAmiSDWkePnO6+
         uxd3tFSuh4wd7AHyeIKwMYM84tcbmy5MXMvrnQYsliXXTMG6F2CdDZpAz3/Ce7EwAJVo
         O+xJvIRQhL05GSaTMHsq60jR8H/5m73DxDbNJwLS3DbsRgPdCXH2ljE7fbU8bEDDHuJF
         vF8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757365961; x=1757970761;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I2NQT+Mk3p4TSCxt7pK5wFXpw9ktcr0hQ9tdUnoEinw=;
        b=h2pCkh1EkzFj33t9DGCMqIf0PSVb4iDa2vLGoIICheFP87RbUNmavc31yj04+1teZf
         pXm8sAl/Qsj/1z3kYN7EW5lWIegH6VbgLiwQS28L8Omlox3hJcpGA+FQmiJcqpDjb6iQ
         Q1gc7qnozZCJSnP9si9sLQAPxUvW+tpKUEnTrQ+TFclcY7dea4YENynUqUMtzF5yTBxl
         VrBS99S8g/bC2dYRtjGOS5DDKr34OAdygUj4DK/19phgFZ7iuxikMkjxYBNJDSq6zFu4
         9uqjfOp09rsm81Kq1qBI56AvHEsZp8zUkLxsycM7kxZieABXKF0PDoiM7aZQYteNKXMJ
         Y63w==
X-Forwarded-Encrypted: i=1; AJvYcCVC7mS89jrpCFcabuSphTs+VlWyQ9NMjBNblS+06FCtiovVIPmqoPA6bLpXvwlTYMDgblqYRs59zanOpZsn1B4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwdRjZmeVgbKuwnZIENZGbHbhXnybtacxwLBtniHHcU0PuXJJC
	RDOedtTajPRAqtBm/4Ry8F7Fn/BmuwMEOTsagvVLNjvL3gb6QHKaL/uwgGXwKtNu2ljPVmKSgcq
	26MSFEP5M3QnKklsPF6mF0YIy6YlL8I2/2kDBEp4N
X-Gm-Gg: ASbGncubGLTqWa73rA0Cr5jvG0Xzu2HTynnZQh0KOHVNXGEMaCR0SCZpd8hlVhx2Ut/
	rYrHCYVNQjnZ1FBosg28GWaBEqo4dDi2s7ondBWsuJTsbfTcnFMDXg5IIzcNBWndi4yARq6piHM
	P+JUz9eFCi49c+5nypexyxY3MN4dnQkKPoHQqVVKQ+sO+Yk+eWjcYfb4DhMC6oLO4/2+s1grLRd
	/U3pxI=
X-Google-Smtp-Source: AGHT+IF+BzdxpdKA4HQ7DSSEF6ppz8VTpKBNm20HIVjqV21Axz9rUCShq8QssdNHtSFg2qc+MCxuDjz1Saanyjzg7Ds=
X-Received: by 2002:a17:90b:1e51:b0:32b:d089:5c14 with SMTP id
 98e67ed59e1d1-32d440c5edfmr12330752a91.35.1757365961252; Mon, 08 Sep 2025
 14:12:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250814225159.275901-36-paul@paul-moore.com> <20250814225159.275901-65-paul@paul-moore.com>
 <e1ed0bc4-136b-4e46-b030-1159411d6240@canonical.com>
In-Reply-To: <e1ed0bc4-136b-4e46-b030-1159411d6240@canonical.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 8 Sep 2025 17:12:29 -0400
X-Gm-Features: Ac12FXzddwEYAqNyhtf5sw2V7Z4CigwREJqUTu6_Er36SjqbkuSUTppS-HqFowg
Message-ID: <CAHC9VhSmwuwvTWc+QSbQq3my=D6YuV5bUu3120_XXH+_6ei_cg@mail.gmail.com>
Subject: Re: [PATCH v3 29/34] apparmor: move initcalls to the LSM framework
To: John Johansen <john.johansen@canonical.com>
Cc: linux-security-module@vger.kernel.org, linux-integrity@vger.kernel.org, 
	selinux@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>, 
	Roberto Sassu <roberto.sassu@huawei.com>, Fan Wu <wufan@kernel.org>, 
	=?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	=?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
	Kees Cook <kees@kernel.org>, Micah Morton <mortonm@chromium.org>, 
	Casey Schaufler <casey@schaufler-ca.com>, Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, 
	Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>, Xiu Jianfeng <xiujianfeng@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 8, 2025 at 3:12=E2=80=AFAM John Johansen
<john.johansen@canonical.com> wrote:
> On 8/14/25 15:50, Paul Moore wrote:
> > Reviewed-by: Kees Cook <kees@kernel.org>
> > Signed-off-by: Paul Moore <paul@paul-moore.com>
>
> Sorry this took so long.
> So the patch itself looks good, and can have my
> Acked-by: John Johansen <john.johansen@canonical.com>

No worries, thanks.

> with that said I have done 3 different builds with this series. Tweaking =
the base,
> and the config, and I haven't been able to successfully booted any of the=
m. I am
> not sure what I am missing yet. I working on a bisect, but its just a sid=
e project
> atm.
>
> Until I can get a successful boot, and test. I am going to refrain from f=
inishing
> out the review.

It obviously built, booted, and worked for me, but as I mentioned in
the other mail to Mimi, that was some weeks ago so it's possible that
there is an issue with this patchset and one of the latest tagged
-rc's from Linus.  Once the IMA/EVM patch is sorted out, which I
expect to happen in a day or two, I'll go ahead and do another post of
the patchset (complete with the usual testing beforehand) and when I
do I'll make a full tree available in the cover letter for people to
review/test/etc. in a known working context.

--=20
paul-moore.com

