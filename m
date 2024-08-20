Return-Path: <linux-integrity+bounces-3374-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 360D6958EB9
	for <lists+linux-integrity@lfdr.de>; Tue, 20 Aug 2024 21:44:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF432284460
	for <lists+linux-integrity@lfdr.de>; Tue, 20 Aug 2024 19:44:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE1901586D0;
	Tue, 20 Aug 2024 19:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LnT/OAss"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24074125D5
	for <linux-integrity@vger.kernel.org>; Tue, 20 Aug 2024 19:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724183077; cv=none; b=UjiRbWi9LTThPd/YEabsOa1rOLI7lncEBe3sYkQVhm5KUqYoOxwib2Zm5x3lR56k6oOVq12tAQjjYsb3NeQFQUQQr4CLBOUwIpeahy7YwF1askOtPXqoCYrEKU2W+RdWYfdaZ7pLnVxobmrHfkmrvzON1mjKRsuiwGOfY7sBO1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724183077; c=relaxed/simple;
	bh=ZJaHs1/opTBSHJguuRopmUMDFqDizKViMy4knODnj3s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LWo3ibAv8Xkcu5kSzVkRvK4R8VIfrowIswAezgZOahqdm8KJhQx+12m/pjSUybYVRGAGGtsvFABnjj36yQutNq6mibyYC80Wa6qDKYhBqpgjNnAkH7Leua9xSR1ecMTQCyudn9Z8Cd5Xtxy7ITxzmiVc8vIqOYU45mqGy9a01kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LnT/OAss; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-428243f928cso47624835e9.3
        for <linux-integrity@vger.kernel.org>; Tue, 20 Aug 2024 12:44:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724183074; x=1724787874; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZJaHs1/opTBSHJguuRopmUMDFqDizKViMy4knODnj3s=;
        b=LnT/OAssXIZizHsIvwjTL3hoiVWqup4mz+1BW1rzmrZ7lRF3TvZIMxgTjzl/uQfmmW
         w6K2Xaj2K9eXlxqeryZQ5SnPCSPpLnvYBvszUONYFRIShAe5OqjH2fRH8lITOfWL+XsV
         h80dOAbzSJQlRlvWaFRk88ODKKAAc2ltvik9MOVbfpejJs9ZO+6uYv86nVQtsSu63gwL
         fjXolfHyqD1uShdJjxoGJxsi8UHekfdaTwJCeencuI9ZckH734hEbJyUSP+UMV1bNtLY
         uhbR4yBgGvTQ4+n2W8X3tI9yTwECjGYENRY6uS6uomp7/e8wKkTkACb3XbNOnsxEMNVE
         W8bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724183074; x=1724787874;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZJaHs1/opTBSHJguuRopmUMDFqDizKViMy4knODnj3s=;
        b=A424eOZM95EuXEeEQlKzylUx6Ej7UASG1Y4P+vbGWGUq91ANjARV6r5+h0RPa2Nyby
         uzwpEvqPfvbkMTB057l5GHCgEChmXFni/FdOj0E1tKOMV4gc0AOSHh+m98lu3kkkQ+Aa
         TwLIdTOHJ4mBOL8uoNIRtbZwCkPPYg4EEtac+vtFB9Afar7KTp6qXtZ0EXqIMibOt2A4
         Ur2VQfN3QrGPbwGS92n/9OQ8WuVJIfQFcNKa5mJBykidMF0oDUlC6ILdJ5ZUD+W+Zq7x
         LuhqniIHiskf2TqIHo9HKR5cbn2M3W9+G37+aKbMjqRAc3MXZQKHUZcEBPi0UAubnQNy
         9HVA==
X-Forwarded-Encrypted: i=1; AJvYcCVc3dfsc4/zI5xEv5rbx0kdHqvHaHmg3kLVTyyGUlxOsqC6MrUwbzS8O0qYVBeRU62BFe88BlDGeNIVVR0vqvw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTRJTogEisnaLTed+1146qZEJiBBoYT3Kn+nGQPs5oSohgEH+L
	bFua/86q3z0qvFT+CIZxmXIlxP/oavDnyhMgq5paZB3dPnSxkP9Z+4l/dSDgn6o2CgONb5mREq1
	YHRNdH6fp/Yv/4fSKlTJCCnzex01Y7xgGKkjI
X-Google-Smtp-Source: AGHT+IG70cBNlT3plfJxI4DIerzuiQ3N5SE9z/tYuZFz919tjmblvr4exlJJh/0zkmLgxr3lQyg/f/xWx10j6efsw5w=
X-Received: by 2002:a05:600c:46c4:b0:428:16a0:1c3d with SMTP id
 5b1f17b1804b1-42abd2282c3mr2591225e9.19.1724183073980; Tue, 20 Aug 2024
 12:44:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240128212532.2754325-1-sameo@rivosinc.com> <c17a31e4fb30f5f9d4a337e5bd8d54cc6f99eef7.camel@HansenPartnership.com>
 <6DEAEC08-420C-46A9-8877-EBF60331A931@google.com> <ZsSXxMn-E7OCvxST@vermeer.tail79c99.ts.net>
In-Reply-To: <ZsSXxMn-E7OCvxST@vermeer.tail79c99.ts.net>
From: Qinkun Bao <qinkun@google.com>
Date: Tue, 20 Aug 2024 12:44:22 -0700
Message-ID: <CAOjUGWfa9gUp2HFQbnDmHyhHd3ZacpF0ngkXeb3qkt=4uspv5w@mail.gmail.com>
Subject: Re: [RFC PATCH v2 0/4] tsm: Runtime measurement registers ABI
To: Samuel Ortiz <sameo@rivosinc.com>
Cc: Dan Williams <dan.j.williams@intel.com>, 
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, 
	"Yao, Jiewen" <jiewen.yao@intel.com>, "Xing, Cedric" <cedric.xing@intel.com>, 
	James Bottomley <James.Bottomley@hansenpartnership.com>, linux-coco@lists.linux.dev, 
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Vishal Annapurve <vannapurve@google.com>, Chong Cai <chongc@google.com>, 
	Dan Middleton <dan.middleton@intel.com>, Alex Crisan <alex.crisan@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Samuel,

Sounds great, thanks for the helpful information! I am looking forward to t=
he
new patch.

Thanks,
Qinkun


On Tue, Aug 20, 2024 at 6:19=E2=80=AFAM Samuel Ortiz <sameo@rivosinc.com> w=
rote:
>
> Qinkun,
>
> I am working on a adding a patch that generates and exports a CEL, but
> this takes longer than I was hoping for, mostly due to a lack of
> bandwidth on my side. I will send a PoC for this as soon as I can, and
> folks can improve it from there.
>
> Cheers,
> Samuel.
>
> On Mon, Aug 19, 2024 at 02:25:15PM -0700, Qinkun Bao wrote:
> > A gentle ping on this email thread. We have tested the patch series [1]=
 and will release a product based on the patch series.
> >
> > If the patch series can not get upstreamed, the whole confidential comp=
uting community can not have a way to measure the workload with RTMRs. With=
out the patch, RTMR3 is completely unused. The patch works perfectly for ou=
r usage case (Like the existing TPM ABI, the raw measurement is taken inste=
ad of recording the log entry.). Assuming RTMR serves as an alternative to =
TPM-based measurement, migrating existing software to the RTMR could be gre=
atly simplified by developing an ABI that resembles the TPM.
> >
> > I don=E2=80=99t object to having an ABI to take the log entry. For our =
usage case, we use the Canonical event log [2] to measure the workload. I d=
o think that we should NOT block the patch series for several months to sol=
ve an issue that TPM can not solve.
> >
> > Link:
> > [1] https://lore.kernel.org/lkml/20240128212532.2754325-1-sameo@rivosin=
c.com/
> > [2] https://trustedcomputinggroup.org/resource/canonical-event-log-form=
at/

