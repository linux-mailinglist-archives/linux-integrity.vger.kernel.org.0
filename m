Return-Path: <linux-integrity+bounces-1965-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6125B895CCF
	for <lists+linux-integrity@lfdr.de>; Tue,  2 Apr 2024 21:39:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14471285A0B
	for <lists+linux-integrity@lfdr.de>; Tue,  2 Apr 2024 19:39:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9847915B980;
	Tue,  2 Apr 2024 19:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="GrZeNhqn"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69F0256458
	for <linux-integrity@vger.kernel.org>; Tue,  2 Apr 2024 19:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712086788; cv=none; b=FWig001O9NSScQfUptUD7u/BKfzpbW3UyYdZM1z6x637vBraajE1TQiH7lorX3/J2UzZBTj+taF9zVzAMbOLnP0Es9/1Z/YLDIznCpG3nDLRzc7S4Vj1SV8dr6oZmLLcz817MvZ5eA7R4SIjDYGNx1FwmzOZ9x/13ZT0/fK3gwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712086788; c=relaxed/simple;
	bh=FUitx7MgiMoEaaLuPTTMRh2BBePYzO9uMUChIAgHet4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qSI/kl8w9FsQyS4sOYVzpJlJkRrVXrzVRe6IBSKjlBKr0dQXt6zow5XMC5oRzBzJw1M3Qh61Z++52q4p1AWJzRQnFE3YBlQJtvaXgY8vMLbJ2fREl+bB0L2sPdsZKMZKMxyAZYupa+/n+CscOFGFiwiEDaFG5bIUG1B7aVMN6Xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=GrZeNhqn; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-56845954ffeso8176381a12.2
        for <linux-integrity@vger.kernel.org>; Tue, 02 Apr 2024 12:39:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1712086784; x=1712691584; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0mQeGyOEkrbKK1USpW42EOtHV5nHSHeR2mY3J6ZfsUg=;
        b=GrZeNhqnkcLYGTX+yyG8BOagRjmaAaJP+ErkV4Bp8cauJzqpnp5AwAqyfvWool1JFd
         k1GpkgNzfn7bVylSi+EFxe9r/r5bvAyV71XWS94KPGoo2xFBYwiLHXbOyHADn4w8UPxv
         FPuxU66l2HUTfxQGTOidDYyYD6P01dNCgbHdI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712086784; x=1712691584;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0mQeGyOEkrbKK1USpW42EOtHV5nHSHeR2mY3J6ZfsUg=;
        b=uM8GuQfC6waRYykGLfuZCe5UllJ5lSXhSExM4QB/Yt7HPeXRG7TRLo1t4diCr61B+e
         MF18hmtzv4WS1buzwCY3FCSQ5fxojiIWoWIOxwjOQtyj6tBoKZSPxZlDbJKCYR/e9ZpC
         pgeGPKB7goevahjMXJXkZNLXPFpqkDGmSBc5Ekq4fqWKqrsZg1l8T0/EKQZRd2UPjZrS
         m/xshRlIOJS1TMNiF0QR6lEOPItCEuUB6mYRmm9NYv25GEygTOwb0WELeeCPcPTCZ+8o
         5p8MNgr7zKv8WuQAY1ncuRCRtyyXcSD7G1SQeIqkhRPGRPuLc8xHczmQnkv9gYvCNtfe
         N+mQ==
X-Gm-Message-State: AOJu0Yw/fV5/MvJCuEuEdHLyU15+rbdWhhWE0KCXL1Dx47zPCvNt3Nxp
	B47wHrwUpm9uCa/R5y8ZKFKhybutb/YVD9KpiQddnCf6jORwb7HQa7X8/erSntcCkI6yoL1RKSe
	GAGU=
X-Google-Smtp-Source: AGHT+IE6fIL63BFVZK7j9wIHlc30Eg7Z4u+wHr8CKOY8KchBj4ckHEaBZSCwMcb6gPCZNaHEOWNSDw==
X-Received: by 2002:a50:d5de:0:b0:56d:c3cb:df49 with SMTP id g30-20020a50d5de000000b0056dc3cbdf49mr6409378edj.31.1712086784569;
        Tue, 02 Apr 2024 12:39:44 -0700 (PDT)
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com. [209.85.208.48])
        by smtp.gmail.com with ESMTPSA id f5-20020a05640214c500b0056bf7f92346sm7235757edx.50.2024.04.02.12.39.43
        for <linux-integrity@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Apr 2024 12:39:43 -0700 (PDT)
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-56df87057bbso845852a12.3
        for <linux-integrity@vger.kernel.org>; Tue, 02 Apr 2024 12:39:43 -0700 (PDT)
X-Received: by 2002:a17:906:2698:b0:a47:4d61:de44 with SMTP id
 t24-20020a170906269800b00a474d61de44mr8673776ejc.55.1712086783205; Tue, 02
 Apr 2024 12:39:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240402141145.2685631-1-roberto.sassu@huaweicloud.com>
In-Reply-To: <20240402141145.2685631-1-roberto.sassu@huaweicloud.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 2 Apr 2024 12:39:27 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgepVMJCYj9s7J50_Tpb5BWq9buBoF0J5HAa1xjet6B8A@mail.gmail.com>
Message-ID: <CAHk-=wgepVMJCYj9s7J50_Tpb5BWq9buBoF0J5HAa1xjet6B8A@mail.gmail.com>
Subject: Re: [GIT PULL] security changes for v6.9-rc3
To: Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc: linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-cifs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Roberto Sassu <roberto.sassu@huawei.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 2 Apr 2024 at 07:12, Roberto Sassu
<roberto.sassu@huaweicloud.com> wrote:
> A single bug fix to address a kernel panic in the newly introduced function
> security_path_post_mknod.

So I've pulled from you before, but I still don't have a signature
chain for your key (not that I can even find the key itself, much less
a signature chain).

Last time I pulled, it was after having everybody else just verify the
actual commit.

This time, the commit looks like a valid "avoid NULL", but I have to
say that I also think the security layer code in question is ENTIRELY
WRONG.

IOW, as far as I can tell, the mknod() system call may indeed leave
the dentry unhashed, and rely on anybody who then wants to use the new
special file to just do a "lookup()" to actually use it.

HOWEVER.

That also means that the whole notion of "post_path_mknod() is
complete and utter hoghwash. There is not anything that the security
layer can possibly validly do.

End result: instead of checking the 'inode' for NULL, I think the
right fix is to remove that meaningless security hook. It cannot do
anything sane, since one option is always 'the inode hasn't been
initialized yet".

Put another way: any security hook that checks inode in
security_path_post_mknod() seems simply buggy.

But if we really want to do this ("if mknod creates a positive dentry,
I won't see it in lookup, so I want to appraise it now"), then we
should just deal with this in the generic layer with some hack like
this:

  --- a/security/security.c
  +++ b/security/security.c
  @@ -1801,7 +1801,8 @@ EXPORT_SYMBOL(security_path_mknod);
    */
   void security_path_post_mknod(struct mnt_idmap *idmap, struct dentry *dentry)
   {
  -     if (unlikely(IS_PRIVATE(d_backing_inode(dentry))))
  +     struct inode *inode = d_backing_inode(dentry);
  +     if (unlikely(!inode || IS_PRIVATE(inode)))
                return;
        call_void_hook(path_post_mknod, idmap, dentry);
   }

and IMA and EVM would have to do any validation at lookup() time for
the cases where the dentry wasn't hashed by ->mknod.

Anyway, all of this is to say that I don't feel like I can pull this without
 (a) more acks by people
and
 (b) explanations for why the simpler fix to just
security_path_post_mknod() isn't the right fix.

                 Linus

