Return-Path: <linux-integrity+bounces-1970-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C793A895EC7
	for <lists+linux-integrity@lfdr.de>; Tue,  2 Apr 2024 23:36:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4285F1F276FA
	for <lists+linux-integrity@lfdr.de>; Tue,  2 Apr 2024 21:36:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29F6015E5D4;
	Tue,  2 Apr 2024 21:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="OYSBwejq"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B37315E5DC
	for <linux-integrity@vger.kernel.org>; Tue,  2 Apr 2024 21:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712093768; cv=none; b=tliDhFDxwjNNoK/RFYUYG2p92ix7MlkvuxlkyTw+MjhMiYFbp1lH2nIfjmRNxIDGo++mgEhoOJau3SLGcD8M95NgaVFRJ67VtRKRaKLPljEDu6y2B6ky/D1djRPTFFinS4t8eRO40me1JInVZwHR0Sj/XTL4/ewVq7a/JlOoxwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712093768; c=relaxed/simple;
	bh=A+i2scP1i3n04ntHseA7vuTsn6YdwPi7luBLLidTYoo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EQC4Db8ErPDHIs5B0K/cb+vuIbF/eAHD1+B8pdFo+Tnm8ZH3nl+4yI4FDke8iXB42Db8/+92zyURVtglgGWQY88jtbcatXNONbI/6YgbfqqApfQwauVnDqsXyk9IayIDqfA195BfbgORyG4wsV0jXjlHpvS8jDumSNAh8SadCUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=OYSBwejq; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a467d8efe78so710524866b.3
        for <linux-integrity@vger.kernel.org>; Tue, 02 Apr 2024 14:36:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1712093764; x=1712698564; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=P45Bu4wHn5RquDWpNCud3aZNlC5obFSwexJqgolasMk=;
        b=OYSBwejqUZSJatrUYwPEm5e8aXr1KKX1f4eM0m5EkMhAJGXumLRkdluegK0Snm5Ygu
         ciE9jICnlWSZmNV4MECoE2A8oBtEBktFme39CPNrRKoqgZTcyWywWo7ttQBowdD54+/I
         4gKWCirpXTcLXispnYV0PxICMRWz5MJfeb9Ps=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712093764; x=1712698564;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P45Bu4wHn5RquDWpNCud3aZNlC5obFSwexJqgolasMk=;
        b=hDuc9sgWmMQg/1ssv1WUTquS3xol6W257kj/l6SF/+stkl5PqWgyHNhqVQTrrh3mhS
         rvbKIEC3cxBI3sIettdLC0QKaIOhwj21bWptjSfc1WCmW5rNozDCalvywJud712W3d2A
         pVHzceUaipIafGiiHJHsgovGTsDdBgQ/LyvyaP++SoahyFAGaLbRtfwtlJ6v0KQi/V0+
         5DJ1xrOrslkH/Vjih0A09NQ9ClEn6VySjHo5M2puAQuAdmAi0k5b4D8TDWKUO2IjB4LF
         +Sh7Pdk7Y6sA24UtspnzQDGmZx0hBi5O1UVmcKF47xJx+yKn/ZSsPPECNZNYPKMel2wW
         /N4Q==
X-Forwarded-Encrypted: i=1; AJvYcCUUStlLEXkmjpMOFpR3EvN1E61UNjOG+UyggKGibV8Dv1G0LDsmkDGrLCtlcnn4iuGyYzTNhBG23WSO58WVkDD723oD1HTqr+7b7B25xyua
X-Gm-Message-State: AOJu0YzItWBjICC50FfJJ0OBRP6zVBveAEP64hyptm1HMdmlPCfm3dVo
	sDv90/Rc4yrYrfwBDb5KPFba2OebbkzNyqtegcWXNbr7HbhWqUK/XbqiLA/0z7wEvZT2uxB+ddy
	/CJw=
X-Google-Smtp-Source: AGHT+IEILyNd9UQQ5qJsx3Ge6Fr7f/W0ZCWYzwv03DElO9QZHpLRLNTyDrAXG5HbZ99iMYjXOYbtoA==
X-Received: by 2002:a17:907:368e:b0:a4e:6c21:6d5f with SMTP id bi14-20020a170907368e00b00a4e6c216d5fmr6187018ejc.72.1712093764138;
        Tue, 02 Apr 2024 14:36:04 -0700 (PDT)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com. [209.85.208.42])
        by smtp.gmail.com with ESMTPSA id q16-20020a1709060e5000b00a47531764fdsm6918921eji.65.2024.04.02.14.36.03
        for <linux-integrity@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Apr 2024 14:36:03 -0700 (PDT)
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-566e869f631so6015685a12.0
        for <linux-integrity@vger.kernel.org>; Tue, 02 Apr 2024 14:36:03 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWtJj3G2ZZ9BEQ1xkr7WDa/Tj5yO+EataidYaF4heaRBgaFZcH/aZWzBk54TNEdNQjRh1Ccn316Nqi9J4xBcHrnQU9fTbeJ5cPj8/0/SrjT
X-Received: by 2002:a17:907:944a:b0:a4e:48d6:b9d7 with SMTP id
 dl10-20020a170907944a00b00a4e48d6b9d7mr11214699ejc.56.1712093763393; Tue, 02
 Apr 2024 14:36:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240402141145.2685631-1-roberto.sassu@huaweicloud.com>
 <CAHk-=wgepVMJCYj9s7J50_Tpb5BWq9buBoF0J5HAa1xjet6B8A@mail.gmail.com>
 <CAHk-=wjjx3oZ55Uyaw9N_kboHdiScLkXAu05CmPF_p_UhQ-tbw@mail.gmail.com> <20240402210035.GI538574@ZenIV>
In-Reply-To: <20240402210035.GI538574@ZenIV>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 2 Apr 2024 14:35:47 -0700
X-Gmail-Original-Message-ID: <CAHk-=wikLJEzBT1_7K5CMfc6DjNNevuYR8z-CfKgYLgwwDLVDA@mail.gmail.com>
Message-ID: <CAHk-=wikLJEzBT1_7K5CMfc6DjNNevuYR8z-CfKgYLgwwDLVDA@mail.gmail.com>
Subject: Re: [GIT PULL] security changes for v6.9-rc3
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Roberto Sassu <roberto.sassu@huaweicloud.com>, linux-integrity@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-cifs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Roberto Sassu <roberto.sassu@huawei.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 2 Apr 2024 at 14:00, Al Viro <viro@zeniv.linux.org.uk> wrote:
>
>         1) location of that hook is wrong.  It's really "how do we catch
> file creation that does not come through open() - yes, you can use
> mknod(2) for that".  It should've been after the call of vfs_create(),
> not the entire switch.  LSM folks have a disturbing fondness of inserting
> hooks in various places, but IMO this one has no business being where
> they'd placed it.  Bikeshedding regarding the name/arguments/etc. for
> that thing is, IMO, not interesting...

Hmm. I guess that's right - for a non-file node, there's nothing that
the security layer can really check after-the-fact anyway.

It's not like you can attest the contents of a character device or whatever...

>         2) the only ->mknod() instance in the tree that tries to leave
> dentry unhashed negative on success is CIFS (and only one case in it).
> From conversation with CIFS folks it's actually cheaper to instantiate
> in that case as well - leaving instantiation to the next lookup will
> cost several extra roundtrips for no good reason.

Ack.

>         3) documentation (in vfs.rst) is way too vague.  The actual
> rules are
>         * ->create() must instantiate on success
>         * ->mkdir() is allowed to return unhashed negative on success and
> it might be forced to do so in some cases.  If a caller of vfs_mkdir()
> wants the damn thing positive, it should account for such possibility and do
> a lookup.  Normal callers don't care; see e.g. nfsd and overlayfs for example
> of those that do.
>         * ->mknod() is interesting - historically it had been "may leave
> unhashed negative", but e.g. unix_bind() expected that it won't do so;
> the reason it didn't blow up for CIFS is that this case (SFU) of their mknod()
> does not support FIFOs and sockets anyway.  Considering how few instances
> try to make use of that option and how it doesn't actually save them
> anything, I would prefer to declare that ->mknod() should act as ->create().
>         * ->symlink() - not sure; there are instances that make use of that
> option (coda and hostfs).  OTOH, the only callers of vfs_symlink() that
> care either way are nfsd and overlayfs, and neither is usable with coda
> or hostfs...  Could go either way, but we need to say it clearly in the
> docs, whichever way we choose.

Fair enough.

Anyway, it does sound like maybe the minimal fix would be just that
"move it into the
                case 0: case S_IFREG:
path".

Although if somebody already has the cifs patch to just do the
d_instantiate() for mknod, that might be even better.

I will leave this in more competent hands for now.

Let the bike-shedding commence,

               Linus

