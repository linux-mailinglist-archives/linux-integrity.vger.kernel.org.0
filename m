Return-Path: <linux-integrity+bounces-7052-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C32E8B51EE4
	for <lists+linux-integrity@lfdr.de>; Wed, 10 Sep 2025 19:28:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 828995E81C4
	for <lists+linux-integrity@lfdr.de>; Wed, 10 Sep 2025 17:28:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17FFA255F5E;
	Wed, 10 Sep 2025 17:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g0OQ4e8y"
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DE9AEACD
	for <linux-integrity@vger.kernel.org>; Wed, 10 Sep 2025 17:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757525318; cv=none; b=gDcTkBlq7Bb2PajZjMmm3AZJEudFuABJSYG/gLJx1fip0KYPZzAP9yiZUfKyvus7MseBXuX/fYRrAooJ7qoKvU4Der3+XlpfJOirXVkPcaTKv/mW5ndGCqw3WIRKU2LxyV3NAEowY/DpdR/igLBybGtcoAKsmTiSyrmOMY8k6o0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757525318; c=relaxed/simple;
	bh=cvIabScJrBWqsx8/+F9YFqGSB2ZkIqJbJk6pSrfuSQ8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oPpW4Lk1PXf1H96i4mtXJ8aVy02XX8+SlcoKLpC9YrxsUkn9IIsRzmtz7WxTJlFM1zNbl1oXUuFIwQXCzzEh0UKgOuEZyYunWnpt/N5i9Hg3JK3N6ioykO9LlqqnpYH62+RrC4+HtX86CwkzAqW0KyfMzaIufJf6qAcMmfwLDlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=g0OQ4e8y; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757525315;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cvIabScJrBWqsx8/+F9YFqGSB2ZkIqJbJk6pSrfuSQ8=;
	b=g0OQ4e8y9OXLUDKHoE/BIadP/NGpW0ILW9LIsP36VKUR8SXsyi4gUdbrFwNbMofhVE2pHn
	aegU3A3vFBpXUjmQNNGSI28UOOIEhrlH3n5ba1lk6Zjpb1pjWp38fK2hhXrrvsgXRXxqHi
	lp55vAx0QmIMVdfEGXKcFj58xoJa/Qc=
Received: from mail-yb1-f200.google.com (mail-yb1-f200.google.com
 [209.85.219.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-522-n1YuaQFtPoCurZ-4-36H7A-1; Wed, 10 Sep 2025 13:28:31 -0400
X-MC-Unique: n1YuaQFtPoCurZ-4-36H7A-1
X-Mimecast-MFC-AGG-ID: n1YuaQFtPoCurZ-4-36H7A_1757525311
Received: by mail-yb1-f200.google.com with SMTP id 3f1490d57ef6-ea3ca79dddfso211180276.1
        for <linux-integrity@vger.kernel.org>; Wed, 10 Sep 2025 10:28:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757525311; x=1758130111;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cvIabScJrBWqsx8/+F9YFqGSB2ZkIqJbJk6pSrfuSQ8=;
        b=NBus7VDoLZ5yuxWZ0+CfBiuilwZeAP1NNvG/JJj1vJW4z8IoCxB60lyfq40V5n3RBQ
         +ROFrjTiGdZiW/QtSMx29isPxamigXUlHG6FddTmQW7KMluaOna4PkqKV9pdKUWZ724y
         vDkm00a9eEoPoGGO5BmjPZ/VBH+cmTBY8T4tDDm7ClN4KfDVmEGewS+iG63e0uYlwhR3
         lUMG/N7MNvwRp8zv2Y6//d6w7OsyDNuuxXj7gsYlOQfseaBjPelQd+g1Gg5L0lOR6zkf
         uQtqtHTtB3L7fG8LQYwoL/I2IODfflsvOuzKEa7aR6HDsyx/fpNndgrmd5tZJxXtjvEr
         baIg==
X-Forwarded-Encrypted: i=1; AJvYcCU4X0ocJUEahM0mcPMJWPCyYHZ+WjyhEDqylNvyuwQOiSbyj1gfNiPZUd84u9jpoT0dFHKHf55f9i08FYdabpA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmhAZEyzf/zTB+Twcw4xCFkrTXGXYSuEYe1CgDAFh5cLzAHwsS
	xGnoSWNj7SN8ZTUjoRwsFeQ+4N0f0vsrw4DVEqIbzUCb0BaBohCpNexXAhQZcq2FmSf193EtctO
	X2otemkrOxq/PZDooWulc/W/lEOKiCU0GH8+UBjG4H70xqc/IrhCVzoPz3aM82VDcOcDvXrdcYT
	wyoMwomyIezbCOhff4U9dNDwL67pYZDoUC4kSKnAbcmasf
X-Gm-Gg: ASbGncsMdEFnSHIAI5ElO44fnqG3dQeymYSkCnMh1GJhyhSX6jkayFnDGyGryS2prxJ
	B8J0W4lMgsLfTuhmKOSD6Hm0+CrG9x/Z93bNYr9M1xdzh5MtGYWMsEYiODy50BiP58gz7TOWwGu
	FCTq96pgUkR/neF1bdqaddyiMNO1CV7V+nnUpJCSF/czPrRkL52r0ysw==
X-Received: by 2002:a05:6902:2a46:b0:e95:1835:c074 with SMTP id 3f1490d57ef6-ea3ca660e43mr406502276.13.1757525311275;
        Wed, 10 Sep 2025 10:28:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHKzufPwAHrhHRraMuWiSerU+09ieXjMlEpGn4NzxNK8/0/9tH6Dg6Z5eUkuJpc8FzH1MDxUwdWAAcANjEbIAo=
X-Received: by 2002:a05:6902:2a46:b0:e95:1835:c074 with SMTP id
 3f1490d57ef6-ea3ca660e43mr406470276.13.1757525310778; Wed, 10 Sep 2025
 10:28:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250902142429.14041-2-daleksan@redhat.com> <aLcl2SzTc_nTX56u@kernel.org>
 <CAG+gbFeYuxVbo+RY9Ux-zysO76Q9yiD5DfD4e4cwNxX-VgfKWQ@mail.gmail.com> <aMGwoYlvBSPLpp3z@kernel.org>
In-Reply-To: <aMGwoYlvBSPLpp3z@kernel.org>
From: Denis Aleksandrov <daleksan@redhat.com>
Date: Wed, 10 Sep 2025 13:28:19 -0400
X-Gm-Features: Ac12FXxkB9vA4meuRuHdzUuorLar5SZcRhu0Qy5TCG-eyDTGHi_pN_V95qCDMVA
Message-ID: <CAG+gbFfed3fFZYnLHNMFGWaO-pEM2RTUJktZ0AuQLSC_zY1g5Q@mail.gmail.com>
Subject: Re: [PATCH v4] tpm: Prevent local DOS via tpm/tpm0/ppi/*operations
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: peterhuewe@gmx.de, jgg@ziepe.ca, linux-integrity@vger.kernel.org, 
	Jan Stancek <jstancek@redhat.com>, Paul Menzel <pmenzel@molgen.mpg.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 10, 2025 at 1:09=E2=80=AFPM Jarkko Sakkinen <jarkko@kernel.org>=
 wrote:
>
> On Tue, Sep 02, 2025 at 03:12:45PM -0400, Denis Aleksandrov wrote:
> > Great, thank you Jarkko!
> >
> > Could you please take a look at the most recent reply from Paul in the
> > v2 thread for this patch?
> > Should I move forward with the advised changes and send a v5?
>
> Mind passing me the lore link? At least quick search could not find
> (sorry).
>

Here is the link:
https://lore.kernel.org/linux-integrity/20250827022102.17731-1-daleksan@red=
hat.com/t/#u
My apologies for not including it earlier.

> >
> > The concerns were:
> > - Adding info on how to test and debug the code to the commit message.
> > - Reverting the "Blocked by OS ..." field in tpm_ppi_info[].
> > - Reverting the conditional in tpm_show_tcg/vs_operations()
> > and sending in a separate patch with the change. The change was
> > concerning displaying the "Not Implemented" status by updating
> > `ret > 0` to `ret >=3D 0` in the if statement.

To be more clear on the last point, the suggestion was to revert this chang=
e
and send it as a separate patch.

> >
> > Please let me know what you think.
> >
> > Thanks again,
> > Denis
> >
>
> BR, Jarkko
>

Thanks,
Denis


