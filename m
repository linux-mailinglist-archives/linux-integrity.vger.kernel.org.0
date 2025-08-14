Return-Path: <linux-integrity+bounces-6816-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BFE4B269F3
	for <lists+linux-integrity@lfdr.de>; Thu, 14 Aug 2025 16:48:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A848176AB6
	for <lists+linux-integrity@lfdr.de>; Thu, 14 Aug 2025 14:35:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A9AF1CD215;
	Thu, 14 Aug 2025 14:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CsRxY3Q3"
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5904318FC86
	for <linux-integrity@vger.kernel.org>; Thu, 14 Aug 2025 14:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755182150; cv=none; b=G0C/I6YkMiuNrbUoYlcxTMiW4TRVOgss2bONJRmQyUGPsRLg/kaFuX9jj5APO3QKCpO0ZLFMc3syUzHurbUx0cOBk71417miLJu6vXPvLpuUc6oQ/cxf6fIBuFKnbX1yRUefMhHmM7+XkLx01RyRBhY3hqS/1dDJ4qOEODWTVCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755182150; c=relaxed/simple;
	bh=qnzgmX3LE0rZJQG0h3Mg/uZgA7PtFov8+DsZZt5oE50=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=crQwFcjYGrN/2T+gUyPVUkfxUpY2NF/IZfZ2K/kpt8u2dweSTA53dEiBH1hbLlaa9Jfgt8XIakNHobVBsLfX45vL60FKATtB88TXQEYW5OcT/bMbxWmKFtXIafwH3RqLdeFi2tkjswvMC14+qFwG/SHmbTrrm39RBEUxtyHfQfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CsRxY3Q3; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755182147;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qnzgmX3LE0rZJQG0h3Mg/uZgA7PtFov8+DsZZt5oE50=;
	b=CsRxY3Q3Lt1fyOFz7EQy+87gN6VYqcDmygxNu8DEYPFIO0XhH+B1vrljxUxLicN7Kt10nE
	hOBWzcGR1SMXNngdC7FZcC5cS8IGajRc0owuerEc/dZPtyC3aHm4JC96WjKiGOrXGgnRUj
	wadq1/14egNU7Iv3lI5hoowkVsKhuEQ=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-310-yBBIUSyKMZKlbV-Ipy4-Wg-1; Thu, 14 Aug 2025 10:35:45 -0400
X-MC-Unique: yBBIUSyKMZKlbV-Ipy4-Wg-1
X-Mimecast-MFC-AGG-ID: yBBIUSyKMZKlbV-Ipy4-Wg_1755182145
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-71d604e54baso13625227b3.2
        for <linux-integrity@vger.kernel.org>; Thu, 14 Aug 2025 07:35:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755182145; x=1755786945;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qnzgmX3LE0rZJQG0h3Mg/uZgA7PtFov8+DsZZt5oE50=;
        b=jsJuzNgm1ESgJE+JAcAad1aREWYohfF0BE+0X3SQbhNvIWwpklUZ7Zp4T3Qe2oiwof
         eIS99kgw+MwKlC6CDM65vAciZUhGlYwQCICF01G/yWxE3kfiW4Tt55T+gq5BH4NsGScu
         RSeEPltpNJW4G4ET2Q8bfqet7Y9SBHj+EugxxKmUNqr9O38IKeEWJjr1TJjgheClcL3d
         0DY/s6+xOIiK2RB9lMxHR1n7/pmJcxzNS29I9b3L56QFFJpb8Y4E+f19T6/y/ZvsBr8o
         luO8va8pLmtSGH9Mdbv4D3yr7IYJXiptDHnWwymYuSdJESY4zl9YTZ4gqRnpeVUuYmNy
         btNQ==
X-Forwarded-Encrypted: i=1; AJvYcCXdqww8StxQsQshMKsMg9FFoVe3O5wn5frXO4tXKweKVa3J2zKsSWXHNuUBw9Bj7l8NHhC9T/D/fXsGzl1/PBc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxRKEvvIl+5YYYhljHRKY3mfxbKkGtB6rxDVcUyEcmsMRbOefN
	eAlVHK+o2Na2kAYt9ufG95l5KPDi+fepZaZ4vCKMKMProEDCSMvhUW0OXP/cGoB8vShjVSaCfWd
	UQvrAvnTtgW16VouZTWPIBSVrdaziNCOTTUreocxYc0trm0kCKsyl5CIYok3gvZvGyqwN+PbIeG
	Lq4MFxTzRPpE43K0A2Dj+orSkIWIRgX4VVOWi6TULGyTRq
X-Gm-Gg: ASbGncsU5P75n9lKpP4f4ipVPalI+zEsJJx+93N8+NOVHaUGTZ1G1Q/iv2plXZBh8kd
	xnV8xSOZP9YpZTJfwQpU8jkX8hpGqhIsXyzqRXSU3DPu4NHUpmWsIezzVaJ5M1rm04CwbsOnem2
	wqE/BtZbRIrx6WAmEDGXzTqA==
X-Received: by 2002:a05:690c:6089:b0:718:38bd:bb42 with SMTP id 00721157ae682-71d6364c8demr45830917b3.41.1755182144990;
        Thu, 14 Aug 2025 07:35:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE41LZdQ76BgN8TggfyWuNHuA0dNF+fHi4dcbejNAv2DNvgVfwpDdd2799UCIwlf7iOHREbw/t/H+SC/IYEg6c=
X-Received: by 2002:a05:690c:6089:b0:718:38bd:bb42 with SMTP id
 00721157ae682-71d6364c8demr45830577b3.41.1755182144666; Thu, 14 Aug 2025
 07:35:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250702202851.33344-1-daleksan@redhat.com> <aGW2wabMXtdBEQxR@kernel.org>
 <CAG+gbFfKLCQND-TT8DEZ09T=Nhb39_CJfM5imv341Pen03bHjw@mail.gmail.com>
 <CAG+gbFfLP1Y=HgRfzjhT4uJ121keQ0ZKo=4saB3uqnZYyoV8JA@mail.gmail.com>
 <CAG+gbFcgfZALHCAxaMmWkNQX2sKgkc-HBJrYXdmehsqLidG_tA@mail.gmail.com>
 <aJtl4MOJ5hYU7mWy@kernel.org> <CAG+gbFfY=YZZ24dZpBtShc+4ypGJgngsz7X32XKaHZ90s3okFg@mail.gmail.com>
 <aJxDRb5KJUTc-dL9@kernel.org> <CAG+gbFdesyWJRBss6xBcGsKmTPZ=fro8DAFZaQTOsO-ZT1tcEg@mail.gmail.com>
 <aJ2SRfn2_sGplJTx@kernel.org>
In-Reply-To: <aJ2SRfn2_sGplJTx@kernel.org>
From: Denis Aleksandrov <daleksan@redhat.com>
Date: Thu, 14 Aug 2025 10:35:33 -0400
X-Gm-Features: Ac12FXzUpFXmfmcAMK5PBmxefckYEVQ_oSXPsws7DLJXN4zM0A8cTo5vAMdUHJI
Message-ID: <CAG+gbFcCFHyqOfgXAY9B6XASf_B+OHoz1w=oVZwTYgk8kOMF3g@mail.gmail.com>
Subject: Re: [PATCH] tpm: prevents local DOS via tpm/tpm0/ppi/*operations
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: peterhuewe@gmx.de, jgg@ziepe.ca, linux-integrity@vger.kernel.org, 
	Jan Stancek <jstancek@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Sounds good, enjoy your travels!

Cheers,
Denis

On Thu, Aug 14, 2025 at 3:37=E2=80=AFAM Jarkko Sakkinen <jarkko@kernel.org>=
 wrote:
>
> On Wed, Aug 13, 2025 at 09:13:19AM -0400, Denis Aleksandrov wrote:
> > Sorry about the HTML, my reply kept getting booted yesterday due
> > to formatting and I wasn't sure why that was the case.
> >
> > I guess it might be some automated gmail formatting.
> >
> > Let me know how you would like to proceed.
> >
> > Thanks again,
> > Denis
> >
>
> So I need to postpone early next week because of travelling but
> I'll come back then.
>
> BR, Jarkko
>


