Return-Path: <linux-integrity+bounces-1868-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 58BEB88C2A4
	for <lists+linux-integrity@lfdr.de>; Tue, 26 Mar 2024 13:53:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 728B81C31C09
	for <lists+linux-integrity@lfdr.de>; Tue, 26 Mar 2024 12:53:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73E3D6EB56;
	Tue, 26 Mar 2024 12:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="TrSNZXgn"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEACC6D1C7
	for <linux-integrity@vger.kernel.org>; Tue, 26 Mar 2024 12:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711457601; cv=none; b=maGBLlCNWMe/+zuPZ2HHxlPsUTGupmYoCDYFAVCMAmXo1aGSKyeEvMsNuqBaXIL6Mfp6W9V+TJlQBBUG962LhzAxIgZks7SSSCFVfNP3Y7qNtJZ8oc6YJ6swKfLQgn9M5VEf46jiYgvgBMTI41meqiQaUJTe3YQdxXUqvlmejM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711457601; c=relaxed/simple;
	bh=5XbquQmJKaNfWBjyEtOOSnqsLcETpU6DZOyNLjemzmQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z5SRK+SFZ2XEabgIy4+4VjIjTGKXEQ5GGLyXJegcnj+6wikHD047Z3L+zFFIVAQQL5Ww0THQVdLB6v8UP1st7t4fJo5UvDXxXm3UL3xmI/wROub5dcj1K1eaaIcUTJQvasWyHasb+F5AL+z6HMohe9We7fM/1UL28TYhvzIactw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=TrSNZXgn; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-61149e50602so17858317b3.0
        for <linux-integrity@vger.kernel.org>; Tue, 26 Mar 2024 05:53:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1711457599; x=1712062399; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z0BhUuq6w2jcMHo0vnHZWTdWQ7YEJBXZjKotn4i2wHk=;
        b=TrSNZXgnFF7GvLHr6M+Rgew7GU+Wc6sqwMeSm/E9VbSWkoZE9GMg+Wl71y2gSnuWJI
         3NFtVETJjLs4IyW9BQR77EzSomQBRFS2IFOkfTYKRG0jNgDUhWWnV30AqBJCNeVmESEq
         czISs7cXGwoum4ATewhUj9UuAIU1vG32bY7qF+Ww7LB1txAIgVURulRKip8MlfZX0TBj
         rr7gdsJJ8M/ykHGK+KI164xZ8h3pgemvlntiQy05Zde07NWI178pm1wh5Gu8/PBx/WDq
         jLvMnhZBmsbSbgOLZpAx3CKkrMaCSZQhW413hzmV/TUd5/ssdMA6/tbShzvdszPIiykJ
         K0iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711457599; x=1712062399;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z0BhUuq6w2jcMHo0vnHZWTdWQ7YEJBXZjKotn4i2wHk=;
        b=om0RKnrClXUV433IEwDsj2WhelMqeXwr+gNOI3U/KLpOaI/HSFn7v6wbzTWDmspKZS
         RTSKXL0+XE5WPt7XltUUJItkzV51Ixr+TIz01SD05AoGRSvdNwLAppWic7lewrt/ciId
         4eYiUaPZQSoQhJTr+n129IMgQooG7U26t7qfYbI3pp6OnG8MszYJf2CVIrE2u8v0NC2e
         adwDfG9LwpUyk5xa+WosiBhQMU8ZmsS3cdcAlXlHJDgWsHh3AEhd6qtl9Dmey9VojJSY
         syZZM6U02JBBrVtvLnPG3EnHCYOA/QPqBNVQZqIgoZkOQGwoWphLIcz+T0rZCOl5+UpI
         z5HA==
X-Forwarded-Encrypted: i=1; AJvYcCX20riJapAeQUcBlJZLMc7GhlHLwM1VvnepoDQfhiuIj17vkY27+/TOa98L43q/bNhyUwBB2tug5zljfnSO4Z+h+d2nGftD7+iwn2ztpZSl
X-Gm-Message-State: AOJu0Yxh+T6k2Bijt2BsToxRfW5kS8K0c5h4qPBixd2bo3A0KlPBa2Nf
	OW8uRkEFgtRMCg0LYBhm10AOTp7btwrJlhFs8wgHS0UcPhChdni0SFAZBQq5LDtyCHtuCoviXM/
	eRnxK523vA/U36QmwQ45H46I6hlQ/pyVQOi+k
X-Google-Smtp-Source: AGHT+IH2Oz9Ij0xMEiUnRD6ybquNqgql6Kb2ocAG6nS4ykuQkyqgIotaRGNW/ASQAvSIwgHE/TxrVUinkjCFUqhPnQ8=
X-Received: by 2002:a05:690c:700f:b0:611:336d:c8f3 with SMTP id
 jf15-20020a05690c700f00b00611336dc8f3mr801016ywb.24.1711457598719; Tue, 26
 Mar 2024 05:53:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAH2r5msAVzxCUHHG8VKrMPUKQHmBpE6K9_vjhgDa1uAvwx4ppw@mail.gmail.com>
 <20240324054636.GT538574@ZenIV> <3441a4a1140944f5b418b70f557bca72@huawei.com>
 <20240325-beugen-kraftvoll-1390fd52d59c@brauner> <cb267d1c7988460094dbe19d1e7bcece@huawei.com>
 <20240326-halbkreis-wegstecken-8d5886e54d28@brauner>
In-Reply-To: <20240326-halbkreis-wegstecken-8d5886e54d28@brauner>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 26 Mar 2024 08:53:07 -0400
Message-ID: <CAHC9VhQg6Qhqjs7J+X6wZa+dP4cujcWPJMZONB0SB9aaaGvFDg@mail.gmail.com>
Subject: Re: kernel crash in mknod
To: Christian Brauner <brauner@kernel.org>
Cc: Roberto Sassu <roberto.sassu@huawei.com>, Al Viro <viro@zeniv.linux.org.uk>, 
	Steve French <smfrench@gmail.com>, LKML <linux-kernel@vger.kernel.org>, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>, CIFS <linux-cifs@vger.kernel.org>, 
	Paulo Alcantara <pc@manguebit.com>, Christian Brauner <christian@brauner.io>, 
	Mimi Zohar <zohar@linux.ibm.com>, 
	"linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>, 
	"linux-security-module@vger.kernel.org" <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 26, 2024 at 7:40=E2=80=AFAM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> For bigger changes it's also worthwhile if the object that's passed down
> into the hook-based LSM layer is as specific as possible. If someone
> does a change that affects lifetime rules of mounts then any hook that
> takes a struct path argument that's unused means going through each LSM
> that implements the hook only to find out it's not actually used.
> Similar for dentry vs inode imho.

For bigger changes please always ensure that the LSM list, and any
related LSM implementation lists, are on the To/CC line.  While we
appreciate Christian's input (and Al's, and all the other VFS devs) on
VFS matters, there are often other considerations that need to be
taken into account when discussing LSM related issues.  Generally,
"specific as possible" is good input, but it isn't the only thing we
need to worry about, and sometimes other requirements mean that it
isn't the best choice.  Just as we want the VFS devs involved in
discussions about VFS related LSM hooks (these new IMA/EVM-related LSM
hooks were sent to, and reviewed by the VFS folks), I would hope the
VFS devs would want to include the LSM devs on any LSM related issues
and would try to avoid speaking on behalf of the LSM devs and
maintainers.

--=20
paul-moore.com

