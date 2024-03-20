Return-Path: <linux-integrity+bounces-1820-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 12BB48817C6
	for <lists+linux-integrity@lfdr.de>; Wed, 20 Mar 2024 20:18:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C16E6281D22
	for <lists+linux-integrity@lfdr.de>; Wed, 20 Mar 2024 19:18:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F31098527E;
	Wed, 20 Mar 2024 19:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MR24ANJQ"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AFB86AFAE
	for <linux-integrity@vger.kernel.org>; Wed, 20 Mar 2024 19:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710962312; cv=none; b=NTcR8JnywkqSBrDvG/BFXr1uoRs2cTMTSsy8LF9qcJXqaMwffdytL7PxGqud81xaRu7L1V/Ardhfj1MA/lDScdki5eU4kUMiCDXmGKlvoMHmQUQGj1RicXbwUMBBuKDKNIV3t3JYBZz0QXYpFy6nG7qGgCDraH0LfD0q+h6qqz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710962312; c=relaxed/simple;
	bh=WsIxuOvN+bREjV/jSLqsWTry9lp6MJbn9jY4EuvPeIY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S4ZHMBIWWAWlOxg5IkxY/kbaNoh1qbXg3Lf+FZaRDwgpvhFeRWy024oguVflhnXsZ/U5oAloNV1qIEYNdyOhbpjlSJF2fQrrRHd+sz7Q99drCsLj8RirtgC/TMYFdbR+dVI6wuL/7ENiFb/5vrLTB6EBB5B3/Y6sGK7XBiTuTNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MR24ANJQ; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1def3340682so880745ad.1
        for <linux-integrity@vger.kernel.org>; Wed, 20 Mar 2024 12:18:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710962311; x=1711567111; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=s/2j7GJ/f78pTOgS8fiGqzLoshe938vqQPVEMBHr3eg=;
        b=MR24ANJQLxhb9V78hlLo48sQsdKtfV6EKQJXFUVwHXjRqL/wvAdY6pCVfnKYXxe5kJ
         n51iuJtk2MVjMJh1LDpcAGYDcIU/L97bDkC5uRLHId2YDL+9LbAFO23I7mg1n0E08gTs
         qutg+4XfWZdTZ01FdwUu+7RZ7nt1nfzsDZJrd4uhBFKDQlmBKL6+8yd28dJR74p4zogA
         BZGx6+UXiYjD632MCYwV2WxMs4Uhz3TG9RDR1BcJe5Pnhxrd+aPfryyJqHNUf5RHF/kh
         6L8hABGoIq+SqwCsaSQf96llGrtTujMq7iS9peZX5ioDgNGX4T5GEsEGw2D+2sB4K0fH
         XvQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710962311; x=1711567111;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s/2j7GJ/f78pTOgS8fiGqzLoshe938vqQPVEMBHr3eg=;
        b=GnusCc8yFwcWkpVPyi67OHjrQoUOzNG7WRaXlToNAwolaSxpOOK/X2Yov9RTPzm5UC
         htcNaQ24viujkGp/lXHkeNSQMu6+u7xOjDG2h9LvvsZy08QFH8IF2a50Y23kh6tuBDtO
         9GU3Z5Ci1AyMsmS3bAWxgKBunWHSoECVUuFVk5qIAc5Rwh+Klw5xpykIkNxwOnmCc4a3
         aBROhthKbpLj4IQRXfp/5Mr5sQaBwtFkB26vgQW/YGId3mv17qp6Pn6YvYzIS4kdfyFD
         a8Rq5ZOSK+Uzs0SYWAjP8iQDc0UjEf7Ic3Lwy6euCT91mknKJZsCmb9nb6v1quFXj+uN
         SMSA==
X-Forwarded-Encrypted: i=1; AJvYcCWc39hXuojtvvc0N4n3bCePkLj/PoV0GOtpv2U2XmIFnpzmSDWbTz5mt9C0ZcKGLHTxq2VVLXr/gv8HODzCcdZBKSQ3XOYF2yUEL1bTPVR0
X-Gm-Message-State: AOJu0YzQfeLqTVm5CcP3ZPZE6JEJ9Mt73uOt78eMPTb5T5iW9Ak1OcJy
	vnhK4wDun88agyAWZbQB3Lbt8HIB7E5NPKeBb0ueoQ21jW7CJrFxD9yWgkWL9Q==
X-Google-Smtp-Source: AGHT+IEOmO0s28VdHmgSPVGkidyNRf3nr2YZr0lrY5hMddb2XFotVXNAvEfg68IohlQddQyxy2ZaFg==
X-Received: by 2002:a17:903:124b:b0:1de:ff81:f650 with SMTP id u11-20020a170903124b00b001deff81f650mr8038158plh.10.1710962310458;
        Wed, 20 Mar 2024 12:18:30 -0700 (PDT)
Received: from google.com (34.85.168.34.bc.googleusercontent.com. [34.168.85.34])
        by smtp.gmail.com with ESMTPSA id q12-20020a170902a3cc00b001dd744f97d0sm12742081plb.273.2024.03.20.12.18.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Mar 2024 12:18:29 -0700 (PDT)
Date: Wed, 20 Mar 2024 19:18:25 +0000
From: Eric Biggers <ebiggers@google.com>
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
	linux-integrity@vger.kernel.org,
	Alberto Mardegan <a.mardegan@omp.ru>,
	Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>,
	Patrick Ohly <patrick.ohly@intel.com>,
	Patrick Uiterwijk <patrick@puiterwijk.org>,
	Tianjia Zhang <tianjia.zhang@linux.alibaba.com>,
	Matthew Garrett <mjg59@google.com>
Subject: Re: [ima-evm-utils: PATCH v2 1/1] Change license to
 LGPL-2.0-or-later and GPL-2.0-or-later
Message-ID: <20240320191825.GA2316017@google.com>
References: <103252ffff09c607e83c887cab2e0af5404d62ff.1710774200.git.dmitry.kasatkin@gmail.com>
 <CACE9dm8rjanQ8eKDJfD3Rj1GCYzk2MGidAkuiMo8ZZ4dduubQg@mail.gmail.com>
 <ZfiTJw1JVNyS8e/G@srcf.ucam.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZfiTJw1JVNyS8e/G@srcf.ucam.org>

Hi,

On Mon, Mar 18, 2024 at 07:16:55PM +0000, Matthew Garrett wrote:
> On Mon, Mar 18, 2024 at 05:42:59PM +0200, Dmitry Kasatkin wrote:
> 
> > Hello,
> > 
> > Added all those who have not responded so far.
> > Please respond.
> 
> All my contributions are owned by Google, not me, so I can't ack a 
> relicense of them. opensource@google.com may be able to help you? Sorry 
> about that!

I reached out to the opensource-licensing team internally and got permission to
approve the relicense for all Google contributions including Matthew's.  So feel
free to add:

Acked-by: Eric Biggers <ebiggers@google.com> # all Google contributions

- Eric

