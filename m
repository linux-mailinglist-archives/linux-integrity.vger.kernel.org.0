Return-Path: <linux-integrity+bounces-6307-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B81EEAC3ACC
	for <lists+linux-integrity@lfdr.de>; Mon, 26 May 2025 09:40:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8135716A359
	for <lists+linux-integrity@lfdr.de>; Mon, 26 May 2025 07:40:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 043E7EAE7;
	Mon, 26 May 2025 07:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UsezSDSV"
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 496321DE2BA
	for <linux-integrity@vger.kernel.org>; Mon, 26 May 2025 07:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748245240; cv=none; b=Yp5bu/4RPVCGVjiVEbU6gWkf0ZBVrHIN8+3VNpqUtYnIadFZotjG9yoUrdw8YWx5zrDWqz84pTilmjKTMN/3NmVBtMYsbM0KXuugBV88aEh9gDodYp5Pr42hlFtwu5XFeQpP2mAlRt4mVzeNVbLhl6/CJ3x63u2JLRvLEQ6X35s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748245240; c=relaxed/simple;
	bh=KRUpYZvebp2gnS2ohX+VG/NoILCSLWt+BQ82B+4vI4U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TBt6fJV93OSilUU8rHg46YCxN0lXYSz8V56aRcjW6gwNkdKvhizCx5pfiFSSW6ZKddOYPjYya0urQLVnBl2NfSOqfJXrzLTbyeUEDJ8lcJ5r2jWrpXSNStT7ecBTr8RKf4Y7bFOw0TLNf9c1RlMJAynia4rFCi5DKV6SzdvUIkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UsezSDSV; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748245238;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KRUpYZvebp2gnS2ohX+VG/NoILCSLWt+BQ82B+4vI4U=;
	b=UsezSDSVqjXp49s/3GF19NhHXhrGBlue8iNnNWBdgfbpT8SogKzRtj/eTqv0zjC2SbouDX
	E8q/jqXG80/tOjZ4CprOzbdhzM/FppeejMZfQyhh3Yx+Z3pSATqd/lO1ULSGbvXt+JOy9O
	I7SG4ro/V3wscwlOqr5NToaKmZo5JCU=
Received: from mail-yb1-f200.google.com (mail-yb1-f200.google.com
 [209.85.219.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-524-pBRBWqjUOzuEqKK3UM9CVQ-1; Mon, 26 May 2025 03:40:37 -0400
X-MC-Unique: pBRBWqjUOzuEqKK3UM9CVQ-1
X-Mimecast-MFC-AGG-ID: pBRBWqjUOzuEqKK3UM9CVQ_1748245237
Received: by mail-yb1-f200.google.com with SMTP id 3f1490d57ef6-e73194d7744so2628925276.0
        for <linux-integrity@vger.kernel.org>; Mon, 26 May 2025 00:40:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748245236; x=1748850036;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KRUpYZvebp2gnS2ohX+VG/NoILCSLWt+BQ82B+4vI4U=;
        b=TLbsNLFr546bI914ml+8Q9bOG/02TSOaKW9Q6TY89vOok018RRINH9mLlyrZ3cz497
         JROzOXQkoN6Bx8Xe0Jf3a7MczLlqUYMqkgO6Q6Y22YTdiIgwrnByy877x336fyVM0uJq
         OLkq3tUPnoM2odH7lSE9jHWGjMeueohsRY/5ngR4Xob/F9a4LLmgrMLL6vvY5r5bfFlG
         lMbnH+5gS9pVsHVlUmW0Yxrx0as9Fs8Sj60SX5sXTGeTo6/vI3wRkKKPl8bzGdgLEVJN
         nZBVjZ2BswNqmFSdx2UKdE/ifhkVcbIiSVfkBpxOH2rsT6ues0+Q6XihmUqKQifSJuWD
         QF5w==
X-Forwarded-Encrypted: i=1; AJvYcCUiyxj4pacvoqmF+ykGyk9o+Y4IytwQowyCQxO0oSZsV3Trgv/nXKumiS/3VP87dYVv8Z9jpmuh0wIsO33fm+w=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywfg5DRtPnnlEa/wI8+LT8qc3/Ua0fjP2jsg7rNjPDKdojy9Tvd
	KPpQ2H0jiN/hV1tJ3MxxdHH0Ho7W2+p01fQhPHRO49NVHc7inD/FCADnAVuDexifCkTFbFDCMMS
	hkE+Vz4l7nZzZ1IeudRCM5Cue/7t16XbZaz/S+qp8QjnEILV2Sm8KACpfnxXZNa6ajoSTtig0uT
	FgcMgxv20Xdeqof79KYA3fRpQzNTzO15ialfd0jcJaX1e25S5gCTOm
X-Gm-Gg: ASbGnctiPmD8hsJlI5MNB5X0LWtyxNHTr+PYfTFyNPwm3SKMZfJ43+kJipS9Jwj9AfI
	rUJ7LRn00fSl9wAnsbziVRwXYHUv9kHU9nV7d20lrjkWGnIkqG6uWD0blzsbnSkKBSTw=
X-Received: by 2002:a05:6902:1503:b0:e7d:89d2:a2bb with SMTP id 3f1490d57ef6-e7d919ff94bmr8974775276.3.1748245236244;
        Mon, 26 May 2025 00:40:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFS7Pp/XoXNFVlvnyTUc1K1XXQydWSpcpTrFXtXpr4SnhnenRHHP8SHUydPH75wP5FH91MrTTW9j01EIYlJd6g=
X-Received: by 2002:a05:6902:1503:b0:e7d:89d2:a2bb with SMTP id
 3f1490d57ef6-e7d919ff94bmr8974742276.3.1748245235915; Mon, 26 May 2025
 00:40:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250514134630.137621-1-sgarzare@redhat.com> <20250514134630.137621-5-sgarzare@redhat.com>
 <aCVHQ-LRqHeEVEAW@kernel.org> <CAGxU2F5AsNY5mQPd=qajW1seFYHSYpB0Fa1iuR_f2QavtoB6sA@mail.gmail.com>
 <aCzf6aoJAC-IdS_n@kernel.org> <CAGxU2F6rfqGV_gJk-JxrCk3f9dWtYn_3o9RODh7cVG0X_oQWaA@mail.gmail.com>
 <aC2nBCxkvWWz5y5E@kernel.org> <aC4CVUXpThAyKQdf@kernel.org>
 <CAGxU2F5zQJR4GvZ9ovtQBqMFGs-wBMoCRks=JYQ1JF6qMKK-6g@mail.gmail.com> <aDCb-wkHGoLQ-IGg@kernel.org>
In-Reply-To: <aDCb-wkHGoLQ-IGg@kernel.org>
From: Stefano Garzarella <sgarzare@redhat.com>
Date: Mon, 26 May 2025 09:40:23 +0200
X-Gm-Features: AX0GCFsNxPiQg4uBSQzNKiQ-b9RZogg3WHbWdCxyQyCynKE3SGVLrqvJ3a7shh4
Message-ID: <CAGxU2F7bS7LsUTVihKdFu2UE20-HfqGk+T8j5fUaX=wMu7R1OA@mail.gmail.com>
Subject: Re: [PATCH v5 4/4] tpm/tpm_svsm: support TPM_CHIP_FLAG_SYNC
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: linuxppc-dev@lists.ozlabs.org, Peter Huewe <peterhuewe@gmx.de>, 
	Jens Wiklander <jens.wiklander@linaro.org>, linux-integrity@vger.kernel.org, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, linux-arm-kernel@lists.infradead.org, 
	Nicolas Ferre <nicolas.ferre@microchip.com>, Nicholas Piggin <npiggin@gmail.com>, 
	Sumit Garg <sumit.garg@kernel.org>, 
	James Bottomley <James.Bottomley@hansenpartnership.com>, 
	Claudiu Beznea <claudiu.beznea@tuxon.dev>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Jason Gunthorpe <jgg@ziepe.ca>, linux-kernel@vger.kernel.org, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, Naveen N Rao <naveen@kernel.org>, 
	Michael Ellerman <mpe@ellerman.id.au>
Content-Type: text/plain; charset="UTF-8"

On Fri, 23 May 2025 at 18:02, Jarkko Sakkinen <jarkko@kernel.org> wrote:
>
> On Thu, May 22, 2025 at 10:26:34AM +0200, Stefano Garzarella wrote:
> > On Wed, 21 May 2025 at 18:42, Jarkko Sakkinen <jarkko@kernel.org> wrote:
> > >
> > > On Wed, May 21, 2025 at 01:12:20PM +0300, Jarkko Sakkinen wrote:
> > > > > I tried, but the last patch (this one) is based on the series merged
> > > > > on the tip tree, where I introduced tpm_svsm.
> > > > > I can see that series in linux-next merged with commit
> > > > > 16a56ee59ab8ee05e67de35bbb5782ef9cfb4f07,
> > > > > but I can't see it in your next tree [1].
> > > > >
> > > > > How do we proceed in such cases?
> > > > >
> > > > > Just to be sure, did I use the right tree?
> > > >
> > > > Thanks for the remark. Lemme check tonight. Hold on doing
> > > > anything ;-) We'll get there...
> > >
> > > I just rebased my branches on top of latest from Linus. That is what I
> > > need base PR also on, and:
> > >
> > > $ git show 16a56ee59ab8ee05e67de35bbb5782ef9cfb4f07
> > > fatal: bad object 16a56ee59ab8ee05e67de35bbb5782ef9cfb4f07
> > >
> > > I'd use git cherry-pick on a range to take them from linux-next to a
> > > mainline tip...
> >
> > I see, let me know if I can help in some way.
> >
> > We can also wait the next cycle if it simplifies your work, definitely
> > no rush on my side.
>
> Let's do it. At least it will then get a full round of testing before
> ending up to a release.

Sure, I'll send v6 after the merge window.

Thanks,
Stefano

>
> Thank you!
>
> >
> > Thanks,
> > Stefano
>
> BR, Jarkko
>


