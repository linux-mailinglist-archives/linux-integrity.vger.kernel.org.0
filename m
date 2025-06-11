Return-Path: <linux-integrity+bounces-6429-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 60854AD611B
	for <lists+linux-integrity@lfdr.de>; Wed, 11 Jun 2025 23:21:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1FE351688D9
	for <lists+linux-integrity@lfdr.de>; Wed, 11 Jun 2025 21:21:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD590288D6;
	Wed, 11 Jun 2025 21:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="IDheiRYM"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B5251AAA29
	for <linux-integrity@vger.kernel.org>; Wed, 11 Jun 2025 21:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749676899; cv=none; b=VPvfix3yOtaqQ0zsxOy/+O5icfml6Cfjt/sfYKwBYo3UNMPZhsETfy3LERpa5NZW4XUE9erKWkWWRTGXrZHTDRxd1y8jdUWXqSbYrDX8NK37kL9Rn134xM/gTcIebCn8pExovl6l9EBZvySCObTInsvD9bna/jJ90BKwcoyB2H8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749676899; c=relaxed/simple;
	bh=M6HxvA49p+fK8bp/m2l/SRceWAjSLs3kZZfYsnrgxUg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P39yY9hTxyzKHJ3wQw8K+Cp41cbj4TTqRrylpO7l45V2q4FPUMK3Vb7dUYXhpzweT1ZDlbe9x6xJhx5kshnOxVYpUisuwnUGMZlAouwQwlhJnpRvt39pxCzQejxg9GccBh/DnCL/YvO+1eAIVIAGU1CGFBoKPghq3+L9Tuw8b20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=IDheiRYM; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-ade326e366dso44674666b.3
        for <linux-integrity@vger.kernel.org>; Wed, 11 Jun 2025 14:21:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1749676895; x=1750281695; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=OgzdZm4+49mKePkx+kNZ7H8LSMYhd60zWxBKo/56OGU=;
        b=IDheiRYMdvm79GDWo6i147Df4PVx9VCdQIuxa8W8S9SGldnZByjhGn0Gup4I3TEn9Y
         7uz4Ics6k9YO4oFZQKGIDBeGck+F7QogI7LHCB0egXqr4MC9l8U78wFyCAEB6sThLrAj
         BWDcRWPBIXQiHtqeIrLvIzsAsMckQ35K+1G1A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749676895; x=1750281695;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OgzdZm4+49mKePkx+kNZ7H8LSMYhd60zWxBKo/56OGU=;
        b=xNqC2eKTDrCSa+Gql6p9BlM0dMerzSrzFp4qe35gsTdMKTO+GNezr+gRWEzNZMfjDv
         aBb0OP+cnadf9w3AeSM8QyU3TW4nBjcXS1j7x75oQwtCNyU/QS0oQTJC5Tof7p9jaAS+
         S+n9/VvVZr9FmWZ9h6d2hcenBq+1VHgtv+N3oDW9L0rk7bwptCt1DNKPLubJwntmN1nA
         NCuKqen9bTvPcM/IKWRruo3U30D7B6jaEmgmJsxXicwGkDuVUw/QCd3KCAVvvv0ZcyyJ
         eBJ1TskbAsFA3WstNiphSFToNz0kwMdV4JRApWRvxotm5vFUykqzCT84r8EW37QmmNKh
         BjLg==
X-Forwarded-Encrypted: i=1; AJvYcCWZeYAFndYSrGjmIkw3nFycE80tDs3LQhywcJt0pKcX1tzyjTCzRHKQMJwkMqST35w2t1HCoQGbhPh9bfI6jfc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwH7jXly+DZBDpuA+hg6kM7LSmuP520FV9sGIsFchGhvd9CI0Ng
	pIh6ixa9h0Ma5XHRCSp2P45vTSrfUdxW37bDFu9znVw5NUlGiFtFr47gMACdmyJN4VUoU0n5Vg8
	/8fq6bYE=
X-Gm-Gg: ASbGnct7vr9RWGIUkD//S5OlXryD1i8tvXuagRdDEocnISpxJ6uUxBNLVF9QXvkRZqq
	Yq+e6eESqCncLcgalacgXOAzYdTBwIRTFQralC3bntLmZi+y83ccI3QgD7LiuIYAnWAV2BDdUK7
	MuqtRYB/E2S2gRL9X4Gv9JWb3xEjsIHKJpZFHSMuHIRehML2Z+o7J19OPaSKhI4pCGBEH4EjIuP
	9ysNRTUW8Yu6Y1pExkzCl3Hdv914DDuZV1UaWtpkE/lzYn/SXJvPIh825CbmP+SoG/nxB1Zrsbe
	Vzw4fHXEbtS4H+P74OD1s/+w14jo0wyTfZTSHUoUiKDNOWM4c84xtTGhzfKviAQoQlTmtR5WGl1
	Fb+3S7cWExdMrJJn6h+XVSuclhe6aIQyNhZnY
X-Google-Smtp-Source: AGHT+IFr2YW969u/E9SMIRCWC0WTIX9WiKowCDpRTXlsQfBmibxx+bMrlB3/evXG+exgXEfkMzbqNA==
X-Received: by 2002:a17:907:9301:b0:ade:8d5a:cf37 with SMTP id a640c23a62f3a-adea93ff6cfmr55485166b.44.1749676895323;
        Wed, 11 Jun 2025 14:21:35 -0700 (PDT)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com. [209.85.208.44])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-adead4d468dsm13676366b.5.2025.06.11.14.21.34
        for <linux-integrity@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Jun 2025 14:21:34 -0700 (PDT)
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-607b59b447bso618337a12.1
        for <linux-integrity@vger.kernel.org>; Wed, 11 Jun 2025 14:21:34 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXDFORQ0ZpidckYVjs3vuVXJzuRArltL9u2afRexUcdzCTsR5vCQPFBTAKYQYH00OQTuLVVf6BTH5dhfXo5gdU=@vger.kernel.org
X-Received: by 2002:a05:6402:34c8:b0:601:6c34:5ed2 with SMTP id
 4fb4d7f45d1cf-6086a8d8175mr280985a12.4.1749676894398; Wed, 11 Jun 2025
 14:21:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <301015.1748434697@warthog.procyon.org.uk> <CAHC9VhRn=EGu4+0fYup1bGdgkzWvZYpMPXKoARJf2N+4sy9g2w@mail.gmail.com>
 <CAHk-=wjY7b0gDcXiecsimfmOgs0q+aUp_ZxPHvMfdmAG_Ex_1Q@mail.gmail.com>
 <382106.1749667515@warthog.procyon.org.uk> <CAHk-=wgBt2=pnDVvH9qnKjxBgm87Q_th4SLzkv9YkcRAp7Bj2A@mail.gmail.com>
 <20250611203834.GR299672@ZenIV>
In-Reply-To: <20250611203834.GR299672@ZenIV>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 11 Jun 2025 14:21:17 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgGMd31KshGecZJCupkGJQteupgk1SqswBsbHadMfpVhg@mail.gmail.com>
X-Gm-Features: AX0GCFtJBJ0_GDTJQXbaSb0DbKUaXWaGBcUByl4A2_DrwE75v36idPEAZwBhho8
Message-ID: <CAHk-=wgGMd31KshGecZJCupkGJQteupgk1SqswBsbHadMfpVhg@mail.gmail.com>
Subject: Re: [PATCH] KEYS: Invert FINAL_PUT bit
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: David Howells <dhowells@redhat.com>, Paul Moore <paul@paul-moore.com>, 
	Herbert Xu <herbert@gondor.apana.org.au>, Jarkko Sakkinen <jarkko@kernel.org>, 
	keyrings@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-crypto@vger.kernel.org, linux-integrity@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 11 Jun 2025 at 13:38, Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> Speaking of the stuff fallen through the cracks - could you take another
> look at https://lore.kernel.org/all/20250602041118.GA2675383@ZenIV/?

Also done.

Well, the script part is, it's still doing the test-build and I'll
have to make a commit message etc.

              Linus

