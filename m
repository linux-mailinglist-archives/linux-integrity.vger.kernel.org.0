Return-Path: <linux-integrity+bounces-2919-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 99A91914538
	for <lists+linux-integrity@lfdr.de>; Mon, 24 Jun 2024 10:46:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5EEA1C208CF
	for <lists+linux-integrity@lfdr.de>; Mon, 24 Jun 2024 08:46:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3544C7E0F2;
	Mon, 24 Jun 2024 08:46:38 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E2DC1FAA;
	Mon, 24 Jun 2024 08:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719218798; cv=none; b=RHl2A5cKoKdEFH0RH31OhiwkPXxtqkbX7YRh2s5HOmVPs/mul1j+E1xa6VPTRExKz3ifEUAd03RGI2U6Fx5pdSE6zT5kdEez4GlKq6Jg3ckAOZb2nBS92NOV9IWOvMvIyq9bDFvLrs9aFxsjB4xrmwma6NT0Ef6f6zaSke0WbRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719218798; c=relaxed/simple;
	bh=BIdEdWkDT6EWmjACsuAXmqxF3OU7gyb9Iv5JEW1LWPA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cWBXVVKDzvp4OrgErPX9e7rV10S9TtiAxtkwvizYSl+ZCh148GkdEfslGE2ZOH2TbGeRwB84Z8gIVWsu3OjmdKavklaf+QX3pj9yz6c+JjAYpomYKurDIba24DoiM0TRizalz31ZZvmxwSx/t6ysj4LEwyA+TRXjkNJ/fIezfFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.51])
	by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4W71M62bknz9v7Hl;
	Mon, 24 Jun 2024 16:28:34 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.27])
	by mail.maildlp.com (Postfix) with ESMTP id 063AC1405DF;
	Mon, 24 Jun 2024 16:46:15 +0800 (CST)
Received: from [127.0.0.1] (unknown [10.204.63.22])
	by APP2 (Coremail) with SMTP id GxC2BwCH3t9LMnlm2cMiAA--.46294S2;
	Mon, 24 Jun 2024 09:46:14 +0100 (CET)
Message-ID: <aecad5ea129946dbf9cf5013331f9368ceb84326.camel@huaweicloud.com>
Subject: Re: [PATCH v39 01/42] integrity: disassociate ima_filter_rule from
 security_audit_rule
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: Paul Moore <paul@paul-moore.com>
Cc: Mimi Zohar <zohar@linux.ibm.com>, Roberto Sassu
 <roberto.sassu@huawei.com>,  linux-security-module@vger.kernel.org,
 jmorris@namei.org, serge@hallyn.com,  keescook@chromium.org,
 john.johansen@canonical.com,  penguin-kernel@i-love.sakura.ne.jp,
 stephen.smalley.work@gmail.com,  linux-kernel@vger.kernel.org,
 mic@digikod.net, linux-integrity@vger.kernel.org,  Casey Schaufler
 <casey@schaufler-ca.com>
Date: Mon, 24 Jun 2024 10:45:59 +0200
In-Reply-To: <CAHC9VhRKmkAPgQRt0YXrF4hLXCp7RyCSkG0K9ZchJ6x4bKKhEw@mail.gmail.com>
References: <20231215221636.105680-1-casey@schaufler-ca.com>
	 <20231215221636.105680-2-casey@schaufler-ca.com>
	 <CAHC9VhT+QUuwH9Dv2PA9vUrx4ovA_HZsJ4ijTMEk9BVE4tLy8g@mail.gmail.com>
	 <CAHC9VhSY2NyqTD35H7yb8qJtJF5+1=Z4MHy_ZpP_b7YDT-Mmtw@mail.gmail.com>
	 <fbf7f344c518d70833398c2365bb2029480bd628.camel@linux.ibm.com>
	 <d953fac4-9dbe-42a0-82eb-35eac862ca6a@huaweicloud.com>
	 <CAHC9VhRKmkAPgQRt0YXrF4hLXCp7RyCSkG0K9ZchJ6x4bKKhEw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID:GxC2BwCH3t9LMnlm2cMiAA--.46294S2
X-Coremail-Antispam: 1UD129KBjvJXoW7AFWUGr4DAr1xtr1DAr1fJFb_yoW5JF15pa
	y3Ka45AF4kXFy3C3ZIvF1UZ345K395Jr1UZr9xtw1vqFn0vr13Zr17GF48ua4UuryxGFy7
	tF13Ww13u34DArJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkjb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2Ij
	64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
	8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE
	2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42
	xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIE
	c7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UWE__UUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgAEBF1jj5wOowAAsC

On Fri, 2024-06-21 at 17:19 -0400, Paul Moore wrote:
> On Fri, Jun 21, 2024 at 4:34=E2=80=AFPM Roberto Sassu
> <roberto.sassu@huaweicloud.com> wrote:
> > On 6/21/2024 10:23 PM, Mimi Zohar wrote:
> > > On Fri, 2024-06-21 at 15:07 -0400, Paul Moore wrote:
> > > > On Fri, Jun 21, 2024 at 12:50=E2=80=AFPM Paul Moore <paul@paul-moor=
e.com> wrote:
> > > > > On Fri, Dec 15, 2023 at 5:16=E2=80=AFPM Casey Schaufler <casey@sc=
haufler-ca.com> wrote:
> > > > > > Create real functions for the ima_filter_rule interfaces.
> > > > > > These replace #defines that obscure the reuse of audit
> > > > > > interfaces. The new functions are put in security.c because
> > > > > > they use security module registered hooks that we don't
> > > > > > want exported.
> > > > > >=20
> > > > > > Acked-by: Paul Moore <paul@paul-moore.com>
> > > > > > Reviewed-by: John Johansen <john.johansen@canonical.com>
> > > > > > Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> > > > > > To: Mimi Zohar <zohar@linux.ibm.com>
> > > > > > Cc: linux-integrity@vger.kernel.org
> > > > > > ---
> > > > > >   include/linux/security.h     | 24 ++++++++++++++++++++++++
> > > > > >   security/integrity/ima/ima.h | 26 --------------------------
> > > > > >   security/security.c          | 21 +++++++++++++++++++++
> > > > > >   3 files changed, 45 insertions(+), 26 deletions(-)
> > > > >=20
> > > > > Mimi, Roberto, are you both okay if I merge this into the lsm/dev
> > > > > branch?  The #define approach taken with the ima_filter_rule_XXX
> > > > > macros likely contributed to the recent problem where the build
> > > > > problem caused by the new gfp_t parameter was missed during revie=
w;
> > > > > I'd like to get this into an upstream tree independent of the lar=
ger
> > > > > stacking effort as I believe it has standalone value.
> > > >=20
> > > > ... and I just realized neither Mimi or Roberto were directly CC'd =
on
> > > > that last email, oops.  Fixed.
> > >=20
> > > Paul, I do see things posted on the linux-integrity mailing list pret=
ty quickly.
> > > Unfortunately, something came up midday and I'm just seeing this now.=
  As for
> > > Roberto, it's probably a time zone issue.
> >=20
> > Will review/check it first thing Monday morning.
>=20
> Thanks Roberto, no rush.

Ok, so no problem from my side to upstream the patch.

My only comment would be that I would not call the new functions with
the ima_ prefix, being those in security.c, which is LSM agnostic, but
I would rather use a name that more resembles the differences, if any.

If not:

Acked-by: Roberto Sassu <roberto.sassu@huawei.com>

Thanks

Roberto


