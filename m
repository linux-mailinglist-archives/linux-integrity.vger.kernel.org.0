Return-Path: <linux-integrity+bounces-4025-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B1DC9BD363
	for <lists+linux-integrity@lfdr.de>; Tue,  5 Nov 2024 18:29:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C7781C227ED
	for <lists+linux-integrity@lfdr.de>; Tue,  5 Nov 2024 17:29:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 023C91E2018;
	Tue,  5 Nov 2024 17:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="VMt9XOOx"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5017C1E1308
	for <linux-integrity@vger.kernel.org>; Tue,  5 Nov 2024 17:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730827768; cv=none; b=TizWANk7wggghQOO1DXoR0yqFYz/YediupueBOGp9Drgg2kBflIr43C6yT8fs+30HOKIXYKzwN+slXGVJ/dDvgtkvsDnulkHgYCTJk6mNgGzN2nee55UWWqzSaO+0n0/3nO+qiPNS6P7CPJQxN06OXXQEs5k1is7QcpVxPItF74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730827768; c=relaxed/simple;
	bh=2QPF/Ug8UJPBY50upp7P8DUv5/Sc8d7YuMooAZdQhyA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E2TIAPkkyxwjlHssu8HcW/wbgRMnYZQEaQMvqwcFm7XANobhVkHcpc9pjghy7G2jQy3vLhQ6azEkZV6GN4TUv9Z60tqgoxXj89PjkajalObqsvs1VZB7CWrU21LzhYYuCaNGj2EwFX6qnW9ru9uFMeM+otuE76a51GbHOKsOAK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=VMt9XOOx; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-6e3b7b3e9acso49757727b3.1
        for <linux-integrity@vger.kernel.org>; Tue, 05 Nov 2024 09:29:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1730827766; x=1731432566; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2QPF/Ug8UJPBY50upp7P8DUv5/Sc8d7YuMooAZdQhyA=;
        b=VMt9XOOxUljvPEn+YrTy7uje8xYkl4Diblc/eRGVHUUPANWCiYbx8FJFDk2v5fB+Ij
         9ma6bOMUbuXoY3VNrHkO/8zfTK9njeN1c6oaCDhku0BwV9gWt/3G4nQlV7IYUQljNW20
         vTES9ocuRSmq5GvYDFnCNtna8F24FQK3R/ba4SLYxXDlOqC5+J8+l+MFlCT8wYFBFLLl
         62vubymJ4Mdms0Dz2XyN4UmQRdsdvFIWcXRN2vWYFokH6gTmyoAgJKJffjpdV7cj1ihO
         Poqa2P3id94ufFaNMfSzw0yihW+plA0Wf+NfbiloifpoPA1X/QoD8k6lpWbUPDTuQa+r
         0YWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730827766; x=1731432566;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2QPF/Ug8UJPBY50upp7P8DUv5/Sc8d7YuMooAZdQhyA=;
        b=H7nAE970Vpo0M7gmrblMZce5CXtNP6IfOdB73NUzCPVlwcXkw1whpUsxlImSGbgKGE
         WE08+WEaJO7PFKL3UYsBv2DcbTyJJHKHTmfl+/mI7goyX464ImcF9D+rFYtZK6TR34uo
         lH/QRvLdNocMfuEPS4XISDyQNXqSG52t8wroZCz93mpZu8949DpQILVU40NRnGmgjRSt
         bePtcFJJvzdRQ1mg0hTvxmp7dRsch08mu+uF+bI7vqjpXUax9EoUhyI1SBY9aWNhnkJ/
         BQhSuO7RTLRNA1u4cf5OaFmKgl+4uZz6avvFbERTL9D0m7Pd5jov2Mdf1KuAU2S31q4U
         i8cA==
X-Gm-Message-State: AOJu0YzG3L2Hc4U8yNWBIBe36qYynLSrLMyH0p2G4Giw7YtpRG30DXs3
	sTciMbl0REwT2lJ4tLiN4Tce1k89tmgsfaorGNrCkzE8J4Dd+xmQT7XBik3P45aZa1EUmpWhsX0
	m+LIz0o0zBh2HOQ4laLTmEzkNKMVaaVunKXYc
X-Google-Smtp-Source: AGHT+IFOtdS0rX3FHLkNcUtzfAk26Yond8xCj8zU0zoLRnwQv6qRHEuvJmQX5wXTy8+vzA4PqpNS1GJcb9sSajMI+aQ=
X-Received: by 2002:a0d:fc04:0:b0:6ea:7c46:8c23 with SMTP id
 00721157ae682-6ea7c4693e3mr84772327b3.35.1730827766330; Tue, 05 Nov 2024
 09:29:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241011150522.2697216-1-stefanb@linux.ibm.com> <50e5cfff-94f8-4a45-a32d-9cce4f48d5b4@linux.ibm.com>
In-Reply-To: <50e5cfff-94f8-4a45-a32d-9cce4f48d5b4@linux.ibm.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 5 Nov 2024 12:29:15 -0500
Message-ID: <CAHC9VhRqqxty8_ht+S0Wp-7hgRT7tzP+FR7-P-kui_OkfnPFMA@mail.gmail.com>
Subject: Re: [PATCH] ima: Suspend PCR extends and log appends when rebooting
To: Stefan Berger <stefanb@linux.ibm.com>, zohar@linux.ibm.com, roberto.sassu@huawei.com
Cc: linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 11, 2024 at 11:40=E2=80=AFAM Stefan Berger <stefanb@linux.ibm.c=
om> wrote:
>
> Tushar's series is still needed ...

A quick note that Tushar decided to leave Microsoft, but there is a
new developer coming up to speed that will be picking up that work as
a priority item.

--=20
paul-moore.com

