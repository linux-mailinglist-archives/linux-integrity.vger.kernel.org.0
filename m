Return-Path: <linux-integrity+bounces-5811-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 03087A85123
	for <lists+linux-integrity@lfdr.de>; Fri, 11 Apr 2025 03:16:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 004378C3B71
	for <lists+linux-integrity@lfdr.de>; Fri, 11 Apr 2025 01:15:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00630AD24;
	Fri, 11 Apr 2025 01:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="EmOS1+8a"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53F1ED299
	for <linux-integrity@vger.kernel.org>; Fri, 11 Apr 2025 01:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744334161; cv=none; b=cjI+PrrRDD7JUM9qeH6zptoCM2N/tLqIxrS5dX8YDavKIskAp58D5iLRpE+V1hxbNCnkzXWUBAf0Wt4wOojoRG8uQ1fhXynN1UAX/Rpg+RUJIIuinZ4NAYJgSkP2l759jbuM9OWMw3zRx/B23dX4s5/2ye6oSulTq5tF7sugNF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744334161; c=relaxed/simple;
	bh=lBPIZgDjYNMb48Z4Mwlnz1IsLqFyEQ1b6hG4ISfsj1Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jJlL7AkwyeHeNxcjCLbjULmPnrMtIs7Ru1myKoP5ByjBp+jbmLphDQTcXclS8fbEvzaaw7eHW0NHUYIszZQzvs2v8ft1LKBhNTYm/OxTzdo+QQkT4kAN0dG1Eux4wXmhJzB2xWsgNY6qEN6gbXE2WhYe9T1zSftKV9z1i9mxRSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=EmOS1+8a; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-6fece18b3c8so14607097b3.3
        for <linux-integrity@vger.kernel.org>; Thu, 10 Apr 2025 18:15:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1744334158; x=1744938958; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=00loi0C+OFsshohTzr6gSdl2M7eE6uzuKOYDlg5tDms=;
        b=EmOS1+8aZu1vnj9BsRF8mYthb5aa+cCvRGG9Lg+X5ZDCWBIDQ2Wo8Z4X1OgOFvyCSK
         NkjC05TsKQH18F7AYMKuQ7Ve0JRMLMhvTj4Zc3BAv9vMiqZ9Brex5Pnx/uEPoVfj58VO
         qxifvv3b6tS1zooNgIToQ4J/vhFZEk4EDfG8fL5zZrR0AKEU1DYGNws7z1XudNfdjr7L
         StAZY+elohfgv34ff4xMhPAcPXBZ/VfKgxBhZ3gvKX9VdL9Cb4E7bddSdrdU+bn5pwVw
         WA8KaysW7jPL4QJh1LJnb8pNFkPl39AsZRZJJ/Al2iXzm9bnDbePtuZ9ZbdpkppCftCe
         nd3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744334158; x=1744938958;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=00loi0C+OFsshohTzr6gSdl2M7eE6uzuKOYDlg5tDms=;
        b=WOUMYZ/PVqlzLgfX9x7ndkdjv6SO/PWz8J5YED7BnE8oX0qPaMY8CZY9njmWH0jXeV
         tXk7RqGHdYhudAGUHBZLoLlzsjHrK98tJrgFF1OkmTgxjca2YJ3wbeurs0A4lmff97r6
         IT7ed/2dCFrURdK46kH+jvCiKKCAo3a6ckVQ/vmM9sgruLZfaxKlxj4wtFcNg0jAMxPr
         G2Bnfv8teaQU/vRGm+QYuBXwSwbCFTrkvELfbNd7ZdHAXF3jk4ESsIJfQBQctWpZ/W5t
         BLiAPBCour/CJ78zQHRp1fhoIt/polTEbHBVPhgZOjqCVnzUCnblwCpc94mAjdtOhCeT
         OkJQ==
X-Forwarded-Encrypted: i=1; AJvYcCWVbblZC1GFFiuoIy78iAMM2LUK31+XegSK1I/zWns4dc2e2uNl7321p6icJuFlRmzgLTbHgCaix8ryokD57i8=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywg9bi3/BfWF28IujEvgs71ss9jkionBMEJAjib17S8dKSHaEeG
	7Ihuj+fNV9d1hvzQXWoaEHwYQHF1VUAy4ercUhHgIGmP+D4b4iSevsk4vdyGXRfrIgYJ3H/H84P
	SZvgT9xpqg5hVZBjJ4fw96W6eSudljrWpTo6B
X-Gm-Gg: ASbGncsdqJAhzOZE2oJABILnyNTTtkQ62XBXEpqDz76WKhZKYHjH6DPAuqffFPuiP25
	A35bqDYCy7z9f67FmD8oktopSEdthcTflTD55RfkanQ7WLezDGOeWHoZj/O7fubT6sDQuCRXT0K
	HN9QIh/0a+jvnwnK4NrL/4u1cq6k/2Uq1x
X-Google-Smtp-Source: AGHT+IGFQRMjV4KveohCvg0mQjBfpOondU4UQqt51pas0249PJWFesgkAqqXsRgxE7lW8QGHdZcVbAsgShQCJua7tRs=
X-Received: by 2002:a05:690c:6208:b0:6f8:c7e5:9dc8 with SMTP id
 00721157ae682-705599ea187mr16134737b3.21.1744334158267; Thu, 10 Apr 2025
 18:15:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250409185019.238841-31-paul@paul-moore.com> <20250409185019.238841-49-paul@paul-moore.com>
 <202504091639.A12E1A853E@keescook>
In-Reply-To: <202504091639.A12E1A853E@keescook>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 10 Apr 2025 21:15:47 -0400
X-Gm-Features: ATxdqUEYpxUuObD3cxIQmBNboanrLKhkbyDK9XA6AouK1bP7m71B9mlRSJmg24c
Message-ID: <CAHC9VhTR=ee4SGuvDbFj-dtevVFN3Pm-tVhtMLpHsiYB24Xxcw@mail.gmail.com>
Subject: Re: [RFC PATCH 18/29] loadpin: move initcalls to the LSM framework
To: Kees Cook <kees@kernel.org>
Cc: linux-security-module@vger.kernel.org, linux-integrity@vger.kernel.org, 
	selinux@vger.kernel.org, John Johansen <john.johansen@canonical.com>, 
	Mimi Zohar <zohar@linux.ibm.com>, Roberto Sassu <roberto.sassu@huawei.com>, 
	Fan Wu <wufan@kernel.org>, =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	=?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
	Micah Morton <mortonm@chromium.org>, Casey Schaufler <casey@schaufler-ca.com>, 
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 9, 2025 at 7:39=E2=80=AFPM Kees Cook <kees@kernel.org> wrote:
> On Wed, Apr 09, 2025 at 02:50:03PM -0400, Paul Moore wrote:
> > Signed-off-by: Paul Moore <paul@paul-moore.com>
>
> Reviewed-by: Kees Cook <kees@kernel.org>

Do you mind if I convert this into an Acked-by?  Generally speaking I
put more weight behind a Reviewed-by tag, but in the case of Loadpin
you are the maintainer and I'd much prefer an Acked-by.  While I'm
always happy to get more reviews on a patch, the primary reason for
CC'ing you directly was to get ACKs on the LSMs you maintain :)

--=20
paul-moore.com

