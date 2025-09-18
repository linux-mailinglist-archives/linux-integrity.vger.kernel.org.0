Return-Path: <linux-integrity+bounces-7158-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BC8CB85966
	for <lists+linux-integrity@lfdr.de>; Thu, 18 Sep 2025 17:28:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0EB047B1C8C
	for <lists+linux-integrity@lfdr.de>; Thu, 18 Sep 2025 15:26:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A379A30C629;
	Thu, 18 Sep 2025 15:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="HE1jRdqh"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0208530BF5C
	for <linux-integrity@vger.kernel.org>; Thu, 18 Sep 2025 15:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758209274; cv=none; b=Xuqv8AfUAf7OrMiWGZAVoDT+moXINlGiQRdNym5ycykcdl6AT8/XpWh2aL49KRGY8gW6vWDsqo5L5MfDGx/2pOG65wnp/g9DCKmt7sodFkN6SkqLsRw9mJbFYF605o9Pisk7cfPbKWrDyyru8t4HnFnA79mEwAmD8ZdYbDCroKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758209274; c=relaxed/simple;
	bh=HXvQiKWsrrHBdZACQbTWrX32g69RA1tMFfDPMY+ssIw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eGYUmVsdK3bxgZshYqK7PynaIHxzrsmkw++5u6e0K8kUJmD6G0qq8ZUocNdinJDfkesfzADE2Ww1GBxlj9uGY+oqkS/T/aUs4FmC2ncoBLDVcNEeQL/ChPMFWyuDT8Ak3J/nkI9tgu2vvtPgN2BnTk4AfS6d6j8OPpM/xb/WUjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=HE1jRdqh; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2698384978dso8356355ad.0
        for <linux-integrity@vger.kernel.org>; Thu, 18 Sep 2025 08:27:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1758209272; x=1758814072; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9usXAm7mnQ2i6AJbPrd0D0V8P+IxkfPi+oCGWh2MEZs=;
        b=HE1jRdqhb/bVK2e1hfRNhAHq97SKOklDUV8FCsdx9jxdfinSmXuadzc+aFqX0s7QwE
         6guJAaakj2iWeEI07uuDivcPXSDQJnUMp9nlsojMvkghFB9LTZ4arQLnjnrm2QmZxnwq
         tOPYiBC2qIX8hjQ5QSGSrnxTLGG4rcg7AohKKqQkAL6934GoDzXqsimOs6p9HqIqY9N2
         +ZDCb/0K98MpVlcUKWwdMfGYeY5F+0EgGJ/sYgndmpWydHI4j0Gf4QjnhEnY9LFrq9y3
         aNjDafxyknsAnKv5tgK4EGO4+IblCtOJgeaOapBw8fIPP8bvR4CbTiOV0nQGu41yZTBd
         Td4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758209272; x=1758814072;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9usXAm7mnQ2i6AJbPrd0D0V8P+IxkfPi+oCGWh2MEZs=;
        b=w2GjHxnltPrWS3MuaSX/gBS+aQnJ2VG1DpBL4AiFhjhrNaoRei3BFzTIO3QUU48cW3
         zloRUgEoSNdKvWgJ96F3iIGnJ0lwr1b7aqGVWpPg7G751WYBNvSRYVh+9VRIQPjqq/kU
         oPwbZfvfxHvSpzuCkabrdF9x8YNRzF8z8egOt8mMmQCPwUr0PkwxNjEHdSWQVGAjhuri
         lth2bJskBLEPTVhswL0VZ9sRfRjbiZ3BfnHYzR8OGkcm90AV8J4K2YXHdWFFS3+gRpkQ
         2qPBgz4rEd3toZQ0nVyVjoO0/ZROon+gyS8/P3pQ2EkcIUc5e65+dG90NWj1DCw3AAY6
         ctKg==
X-Forwarded-Encrypted: i=1; AJvYcCX+TXMCFcfBvauusfIB7dyJmOSKNErbShzfi222guIOsW8yS2HcGV2gejwhTclpXtI5RInJLQt2FLhVKbD8wOs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfrfwPKYnOkhmRBjpB8RWn6TjHsdNI8RFn4KNsKtJ7mSSCsG+N
	jx5JyhSgDgN20pzB6QfoZStdJF7pBquSiH+9fanO/xkqNt4c0cJ8YkT2giJ0ffxethRK4RBSfc4
	vqAeomMbK0zDeLA/1s+73X2jh83oQyKW90NnuFdW5
X-Gm-Gg: ASbGncsd6344vLtZCrNkBWPDlTaxpIRTWuNBm+yu2UrGn5Cbe35qhbZdbQjv7nSgC3v
	JAix/xKdrQevyrW7BLRMX8SqGadpNpHzwmRDbwa4UHEgKe1rzYokkP9DYMwaQHfapXAihH8Asn0
	A7IgHIAIJfXlw/DV3nsgMmbRvAe2GbnSchNsa3GtBccw7DPVwuxopbHIdc97EHppZFJRCG50g+H
	pr2NQ9cEZKTnmq6qSE8G99iSg==
X-Google-Smtp-Source: AGHT+IG7BDPCip6fQa6ARXPNfQrjCV+vC+xcORBNq41mtqWS9WAdTM6NdCI+4xWkS1H6z+w3/aesgQolKoF2syk/PGE=
X-Received: by 2002:a17:902:d544:b0:249:3efa:3c99 with SMTP id
 d9443c01a7336-26813f1e97cmr69129925ad.61.1758209272366; Thu, 18 Sep 2025
 08:27:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250916220355.252592-36-paul@paul-moore.com> <20250916220355.252592-60-paul@paul-moore.com>
 <598e9ed199ba23e7e11c5ea29132bd2e3202305f.camel@linux.ibm.com>
In-Reply-To: <598e9ed199ba23e7e11c5ea29132bd2e3202305f.camel@linux.ibm.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 18 Sep 2025 11:27:39 -0400
X-Gm-Features: AS18NWBPsneqht7dFrXISa1pEsxcBNxr7SK4dsIkWlo-NPzoZeCCloIzwU8sIuw
Message-ID: <CAHC9VhT53+2qvJT8Cpw5aYsbyT057Q2y0LZwDziRiucuzbUbyQ@mail.gmail.com>
Subject: Re: [PATCH v4 24/34] loadpin: move initcalls to the LSM framework
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: linux-security-module@vger.kernel.org, linux-integrity@vger.kernel.org, 
	selinux@vger.kernel.org, John Johansen <john.johansen@canonical.com>, 
	Roberto Sassu <roberto.sassu@huawei.com>, Fan Wu <wufan@kernel.org>, 
	=?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	=?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
	Kees Cook <kees@kernel.org>, Micah Morton <mortonm@chromium.org>, 
	Casey Schaufler <casey@schaufler-ca.com>, Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, 
	Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>, Xiu Jianfeng <xiujianfeng@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 18, 2025 at 7:16=E2=80=AFAM Mimi Zohar <zohar@linux.ibm.com> wr=
ote:
> On Tue, 2025-09-16 at 18:03 -0400, Paul Moore wrote:
> > Acked-by: Kees Cook <kees@kernel.org>
> > Reviewed-by: John Johansen <john.johhansen@canonical.com>
> > Signed-off-by: Paul Moore <paul@paul-moore.com>
>
> For the first couple of iterations, the patch descriptions needed to be a=
dded or
> improved upon.

As was discussed in the first cover letter, and in the related
reviews, the first iteration was simply a FYI primarily for the sake
of Casey who was working on a patchset which has some overlap.

> Some of the patch descriptions are still missing (e.g. 25, 27,
> etc).  Is this intentional because you feel it is redundant ...

Yes.  Take this particular patch as an example, the conversion to
using the new initcall mechanism for Loadpin is perhaps one of the
more trivial patches one might see in the kernel, the subject line of
"loadpin: move initcalls to the LSM framework" is sufficient to
document the patch as far as I'm concerned.

> FYI, teaching newbies how to break up a patch set is not easy.  This patc=
h set
> is nicely broken up and would be a good example.  However, leaving out th=
e patch
> description would be teaching the wrong thing.

Documentation is a good and important part of the work we do, but
redundant and/or excessive documentation simply for the sake of
satisfying a checkbox is not a good thing IMO.

--=20
paul-moore.com

