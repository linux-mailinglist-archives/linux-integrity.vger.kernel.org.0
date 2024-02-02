Return-Path: <linux-integrity+bounces-999-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 10F19847015
	for <lists+linux-integrity@lfdr.de>; Fri,  2 Feb 2024 13:19:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4364D1C26D42
	for <lists+linux-integrity@lfdr.de>; Fri,  2 Feb 2024 12:19:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3A177E76D;
	Fri,  2 Feb 2024 12:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="FCnvynLb"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBDEF1419A4
	for <linux-integrity@vger.kernel.org>; Fri,  2 Feb 2024 12:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706876389; cv=none; b=Mi2kGzlpYv9Vow+SycXiSEXXrJyZ76yYdpE/0kqrrtodzHI6AcXgCRW4hVsGQAqYK4SobbSke2EhZ0zeWBeIejFYkrEn/ZSmlzewTPWwYJ/tYO7LsUEyBLfbNS5B6gvj5thSUsLJRp+lSuK8LzMORmCq8nB4xz2jvWHIC3ED7H0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706876389; c=relaxed/simple;
	bh=5hj8arzg/kd3VZoNZL5jFI8jc+DYOemsfmbYbJ/OykU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Yqey6zBXorNQOxaM9VuHQsNxEw5eKUcr3eGM8ka4yF3R5VdyXLvlaaxjAOi/AGC3wIBUR631tn7Q6PUqlgf+ln77nLi5pAkGLStyDoYnbqMuZfLrJAJTFFysIPgDb/5NQuYGDl2MCUqHvorHJdE33Q0Oec3SPWvzUdLo2W8Wvh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=FCnvynLb; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-55fcceb5f34so1688436a12.3
        for <linux-integrity@vger.kernel.org>; Fri, 02 Feb 2024 04:19:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1706876377; x=1707481177; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=LFP84Zrmnc+wlMdD8DIoxjiCigtXFMKoOTPi2WgaEVI=;
        b=FCnvynLb2HfyZrMuxl7Ds9QkCMDQvBB5aIj1qY6beCYhJOh2i0pRnO4ifvYsPyCVpT
         7UWqgDljq7yHvF3dsqPBOZXtie1zOA185tfzRMwH7BC5wTsfE9BnZGsg1h0ekesRNtOx
         qsoz/saloZbH7AxJFxNTSq0JevzVkPoBNV9gM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706876377; x=1707481177;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LFP84Zrmnc+wlMdD8DIoxjiCigtXFMKoOTPi2WgaEVI=;
        b=lDZwmgJ5JHmJ0GFV5GWDvqQg0FIxyLFjbK5tyUh53BCwbaucpPj+Edsjh8qpVo4sAb
         2VoqxzGBcd3rDWXouk4L6I1bSrUhRQZLZ1EV66hBkCqYkpRh5Fr+e8mfkCjW3rn/NKiA
         yy64I3oHfJdsCsP+EJLOwW0BObw3dCDJJG+uQ8kmj5x1YS41JER3Dff3ep5P90+v//2o
         8FgDqlgPYcsLqR2Q18MbXTejoyrkfH9M2Ti9ECjwQNL8fWP/9/xSXu7sTrtQWVz3UFG+
         LJ4rh3Lo/dFyPIQtSUgU73WuoMVt6I4GhWiY9S8YBl4tHfo6wEVl4hGd6C9LF6g33r7I
         UH+A==
X-Gm-Message-State: AOJu0YxY8RqHVsS1c2d/scpiVH5I9xHoIQODsRxQpihN6oGpDKaqIdLb
	sasDp7tx17+k1YKJLSNhhXANXeTe9Le/xw8hGieHnqQNWcNKdvvBHAg4VKT2aDL+0c9vxLOD/1I
	aMox/yRIyLj+3EbTL49wrIVLCCqnExFubInqozA==
X-Google-Smtp-Source: AGHT+IE0f2aO085cH3xmP9VanflnkDeHUQnAqufqusFiaFr70CRd6j+Bz+dipUFrBk+UzO7Pa5H1MDK+TckxWx/Siqo=
X-Received: by 2002:a17:906:f117:b0:a35:4ee9:7f12 with SMTP id
 gv23-20020a170906f11700b00a354ee97f12mr5466933ejb.50.1706876377331; Fri, 02
 Feb 2024 04:19:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240202110132.1584111-1-amir73il@gmail.com> <20240202110132.1584111-3-amir73il@gmail.com>
In-Reply-To: <20240202110132.1584111-3-amir73il@gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 2 Feb 2024 13:19:25 +0100
Message-ID: <CAJfpeguhrTkNYny1xmJxwOg8m5syhti1FDhJmMucwiY6BZ6eLg@mail.gmail.com>
Subject: Re: [PATCH 2/2] fs: remove the inode argument to ->d_real() method
To: Amir Goldstein <amir73il@gmail.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Stefan Berger <stefanb@linux.ibm.com>, Mimi Zohar <zohar@linux.ibm.com>, 
	linux-unionfs@vger.kernel.org, linux-integrity@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 2 Feb 2024 at 12:01, Amir Goldstein <amir73il@gmail.com> wrote:

> diff --git a/Documentation/filesystems/locking.rst b/Documentation/filesystems/locking.rst
> index d5bf4b6b7509..453039a2e49b 100644
> --- a/Documentation/filesystems/locking.rst
> +++ b/Documentation/filesystems/locking.rst
> @@ -29,7 +29,7 @@ prototypes::
>         char *(*d_dname)((struct dentry *dentry, char *buffer, int buflen);
>         struct vfsmount *(*d_automount)(struct path *path);
>         int (*d_manage)(const struct path *, bool);
> -       struct dentry *(*d_real)(struct dentry *, const struct inode *);
> +       struct dentry *(*d_real)(struct dentry *, int type);

Why not use the specific enum type for the argument?

Thanks,
Miklos

