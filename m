Return-Path: <linux-integrity+bounces-9456-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UEmuF4R1+mkAPQMAu9opvQ
	(envelope-from <linux-integrity+bounces-9456-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Wed, 06 May 2026 00:56:04 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 01AF04D4792
	for <lists+linux-integrity@lfdr.de>; Wed, 06 May 2026 00:56:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CBCB2301FF08
	for <lists+linux-integrity@lfdr.de>; Tue,  5 May 2026 22:56:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E05A9330305;
	Tue,  5 May 2026 22:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="CyGjf2g3"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38273329C66
	for <linux-integrity@vger.kernel.org>; Tue,  5 May 2026 22:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778021760; cv=pass; b=tlRxJ9pe0wUxlPs8MPUESqMDXys4pC89ohhztD5AoaheMDoqO9/Dhgv4s+dMFQQQWTJweoF4aICrYfYVW0ahgBcZBehMX/dSzWbz8fDiBzminjdGdHkkpjqAun4OliNogl8bVZq/XdBbI+ro+EqmdgZTkHAePQtphkPoaV9VC7Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778021760; c=relaxed/simple;
	bh=jp0ufABEKNNQZig+P4OStv7rq3Lf0B6nVuGfU3anl3I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PKpY6c/BwyI6HSNZomRZ8tGRCoNsc3WCPlirEjzn4bl1lZF8AEu03poht+gN06eBfvyl/MEfUOkYE7/ZC8+o0Q+VR/va8Zo8LFjVohVGcSg+ixnvItxGleDPH+hO0LWFTaPXoyfDRkxMQRnQGJ5IeDKoo8yQfM055yzHM0p5HDc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=CyGjf2g3; arc=pass smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-67b6a6bd7b8so725982a12.0
        for <linux-integrity@vger.kernel.org>; Tue, 05 May 2026 15:55:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778021757; cv=none;
        d=google.com; s=arc-20240605;
        b=RBh1/30KD0Sde5qFuWzwLTAg4WDzakxzz6VmY1EuMCqJtqw13CBoK0gUmztEFOikv3
         lry8rCiZEqEAXwFTjTull1icA4NGMoveqpyExKp6H1Zg84j3gewR9bDObNUwJbCHRMRW
         /ojbhwU2oQuPMHAo+hdf0GTEHxbLgQlMkxNJhGl1F3V4SgNOekNDOi96fgMzj0n+d02w
         46CF2MyVYkOuOTioLohA8tKsXe1Vt18m+zwhI+Bwls6K0a0g9a0Xa8eXbAitqEjfXpN8
         +8fEHJn9z7h4Ak7KgIJPZ2/KzyguXjneKmpas5Y9wnfashsPKmWEWqazFBIDk9gc/AQU
         BZIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=igXYnTt1y5W94mwyAvmuGSDvQ0T1atQGMaOaIv56W9Q=;
        fh=DvjLf33jmcH80xFxvqKi/qkjAFFuivt2lg9Ap+F7NWA=;
        b=jCEhNWrN2Olc1FOzNHoX7Y444z9PTsPIZzGsQbvFBDlMoHHGOEd9jj1rzqDIAo7X0T
         ttt7DPHi5FGTXrzm6gAFMcDF1dedG2V6th96WKQlUSkTFo+YBi8wa7ueTxXLy1Cqdl2u
         eTN5kXHmSNYuyw+ax2eOmFEb22LDbgXuWb2c2K19EduR5mWn95Priz7HaLY0nzhD0yuh
         MsjuBZ5p0Ke+Lz3txJc9JZnALcozY4kKgVgs1UuH0qRUKQTwulLyoyNAiJFJwu1g/wXi
         bFzNJi2ov5CWaoWaCtIag/eHMDoMHh56SniKrLXe6iKnWa2BChKwGjxLO8YveXI/aauf
         madQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1778021757; x=1778626557; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=igXYnTt1y5W94mwyAvmuGSDvQ0T1atQGMaOaIv56W9Q=;
        b=CyGjf2g3a73QDzn/ZzguwA7lAkPSi/Ty+tjuFlBocjBu9Q2mYRsAtseTmeO6d9Cney
         U7B4bLQxhLskhSKplYoOX2/0WVJRzFOM+7p1UX9Kv3k7z4ESWBczK9MlN1sXwl2q+41h
         lP+4NDdccTrR1p81sP6hSQvDY1dD9sKEja4jzUMLaIT6toipqDbzmyFgrmL98RLBFwBE
         dZwL8LsiIZbxeAJ85BnnMr8eM6BnbgX5rIJ11kHNhqfcSz+y6/36hk3FA7rUr6vZUoUv
         8cFzvjgCf0cl2Ceyoy6d9YfZHtl4yzLIc2uGsP+YMT9ct7rwzY0PzwBfjVLBYhQICUvZ
         8wog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778021757; x=1778626557;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=igXYnTt1y5W94mwyAvmuGSDvQ0T1atQGMaOaIv56W9Q=;
        b=RhIQg5HH6MoWAl+QTT/1YABrmzexMrJ9iP7C9qW/hfMzMUbFHsM73MvTILoD1n/mNa
         ajLjsUPtolFbiW/2N3P/xSzzXj7eqWIBoJ5XhAlsmQjFG3U1sep9jsVM8GUB92j0wiRk
         xB+APmhzDTUr5epvwY+fLrz69qsLlLuVswJKeYUFcB+irl+h7yQ5wlG+q18l693boERo
         5b01jiiJMqBSuIHgsL6lzGNa1B0mDsvS8R/HXtkAS2rO6FfQYlI4W79tY2JAVzn9pIwJ
         h3fHiZpw0Z3qQeJNAmd40P3T6t3opjmrd2N35bKVTxuQlpqAmQvzICKtbeMkgV0HSmPr
         9T9A==
X-Forwarded-Encrypted: i=1; AFNElJ+InuUkKbhzO2+U9vqLp0efdD7hDE5GugJakMWX3h4pyJYmiLgpsDN9a1rx5panIB0z0C0scN8nat99eXPWc5s=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHIBXOXT24UObx3YgNGEsOoElPRHpCC7aWdhSxauMyRIZZ8O41
	NthVHQ8kTE09EQYxVfJU+3wivnf1OZhQZ8qJtb4pjhAaVjknl+f4DfArvQx55yjNGFE5EExTPTk
	8+/IxgMYutyAqF/4k7tRJsgdT3sEbmQqoCEe8s9vq
X-Gm-Gg: AeBDieuf3kVEasrZ1ezx8PXlv8QslHXlmEJ1IyjpijX2b9F2CylbH+eTnWG7Zvoi6Ej
	1gimitDaElEhPC6ds7aQXgKznRCY3gTIAMj887N6owV0UFNKsvlTts8qJ1oyuOwgP+9QAxkz8OT
	Vkmk4GQ7qJUZjTljnuBUksxBCiIDfVvgCwF9VSoQdai5joZdDt99LUx8ddRHI0L6fq2LTYwXS3+
	OuDWE0ClQ9qhRhXr1ZYMohcoogB4sOaZJ0SfCYneO0j7ddd55pXvcoZnU6FQJNej0OZ6qgyrGdm
	/sSuyVAV99s0/OvBz/khCav81kiX
X-Received: by 2002:a50:8d89:0:b0:67c:a9cb:d85 with SMTP id
 4fb4d7f45d1cf-67cc392dbd1mr2021608a12.11.1778021756772; Tue, 05 May 2026
 15:55:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1777036497.git.noodles@meta.com> <7734099f5e7fda5480bca016a9e6707983325fbd.camel@linux.ibm.com>
 <afMlgstqahnZg68h@e129823.arm.com> <9f188536f09a2db30877d6bfbb84aeaf2565cccf.camel@linux.ibm.com>
 <CAHC9VhRsnmPp2KmQAns5uq5qXX5EF2xQQzyfTgrPi4O9AXyPpg@mail.gmail.com>
 <ba4bf28314b679474a6a8da6298e548e54b3754c.camel@linux.ibm.com>
 <CAHC9VhRE2kRr1fdDf6xgQgpSrtvqtP8Vy9LVGJhDZFUbzLKGmQ@mail.gmail.com>
 <ff28c6dcb60c357c752724927addaa8c4fd3bf2c.camel@linux.ibm.com>
 <CAHC9VhQY2TMkTvQq9P8oZteQWQSr7qq2utOuH+pdVx+8jWLBCw@mail.gmail.com> <a9412fe10e70ce95dd70556ace19368bec5c188c.camel@linux.ibm.com>
In-Reply-To: <a9412fe10e70ce95dd70556ace19368bec5c188c.camel@linux.ibm.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 5 May 2026 18:55:43 -0400
X-Gm-Features: AVHnY4LjwHbGYu80nNIZo2bt6oowEdScIKVunh9rMqRrLydWrBO3U9oWRNn2sww
Message-ID: <CAHC9VhRUgNA=Sj=jhD=zOt8R80Q+FQj+H0nYSy-FAujTL3EKPA@mail.gmail.com>
Subject: Re: [PATCH] ima: debugging late_initcall_sync measurements
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: Yeoreum Yun <yeoreum.yun@arm.com>, Jonathan McDowell <noodles@earth.li>, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-integrity@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	kvmarm@lists.linux.dev, jmorris@namei.org, serge@hallyn.com, 
	roberto.sassu@huawei.com, dmitry.kasatkin@gmail.com, eric.snowberg@oracle.com, 
	jarkko@kernel.org, jgg@ziepe.ca, sudeep.holla@kernel.org, maz@kernel.org, 
	oupton@kernel.org, joey.gouly@arm.com, suzuki.poulose@arm.com, 
	yuzenghui@huawei.com, catalin.marinas@arm.com, will@kernel.org, 
	noodles@meta.com, sebastianene@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 01AF04D4792
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[paul-moore.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[paul-moore.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9456-lists,linux-integrity=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[paul-moore.com:+];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[paul@paul-moore.com,linux-integrity@vger.kernel.org];
	FREEMAIL_CC(0.00)[arm.com,earth.li,vger.kernel.org,lists.infradead.org,lists.linux.dev,namei.org,hallyn.com,huawei.com,gmail.com,oracle.com,kernel.org,ziepe.ca,meta.com,google.com];
	TAGGED_RCPT(0.00)[linux-integrity];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,mail.gmail.com:mid,paul-moore.com:dkim,paul-moore.com:url]

On Tue, May 5, 2026 at 5:05=E2=80=AFPM Mimi Zohar <zohar@linux.ibm.com> wro=
te:
> On Mon, 2026-05-04 at 16:51 -0400, Paul Moore wrote:
> > On Mon, May 4, 2026 at 8:03=E2=80=AFAM Mimi Zohar <zohar@linux.ibm.com>=
 wrote:
> > > On Sun, 2026-05-03 at 12:46 -0400, Paul Moore wrote:
> > > > Regardless, assuming you always want IMA to leverage a TPMs when th=
ey
> > > > exist, your reply suggests that using an initcall based IMA init
> > > > scheme, even a late-sync initcall, may not be sufficient because
> > > > deferred TPM initialization could happen later, yes?
> > >
> > > Well yeah.  The TPM could be configured as a module, but that scenari=
o is not of
> > > interest.  That's way too late.  The case being addressed in this pat=
ch set is
> > > when the TPM driver tries to initialize at device_initcall, returns
> > > EPROBE_DEFER, and is retried at deferred_probe_initcall (late_initcal=
l).  Since
> > > ordering within an initcall is not supported, this patch attempts to =
initialize
> > > IMA at late_initcall and similarly retries, in this case, at late_ini=
tcall_sync.
> >
> > Okay, so from a TPM initialization perspective you are satisfied with
> > a late-sync IMA initialization, yes?
>
> No. On some architectures moving IMA initialization from the late_initcal=
l to
> late_initcall_sync does not miss any measurement records. However, as pre=
viously
> mentioned, Linux running in a PowerVM LPAR the move would drop ~30 measur=
ement
> records[1].  So no, only if the TPM is not initialized by late_initcall, =
should
> IMA retry at late_initcall_sync.

What do you do in the PowerVM LPAR when the TPM is not avaiable at
late initcall and you have to defer IMA initialization until
late-sync?

--=20
paul-moore.com

