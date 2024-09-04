Return-Path: <linux-integrity+bounces-3438-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E2B9A96C4D9
	for <lists+linux-integrity@lfdr.de>; Wed,  4 Sep 2024 19:05:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BE3D28158D
	for <lists+linux-integrity@lfdr.de>; Wed,  4 Sep 2024 17:05:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0CD884A50;
	Wed,  4 Sep 2024 17:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="c27obQdQ"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F7A81DA31D
	for <linux-integrity@vger.kernel.org>; Wed,  4 Sep 2024 17:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725469511; cv=none; b=TAfh7sEzVC7gZ8e+NRIMGqiH9d3RoO8gfEkyHBduozEl8cv43uzDo9kF8RchIEA9gqDwe4BF+S2TviJVRXmTjtXhai6Sh/+xDszhGuI0jTa5QFQ9278F3DG/ldBaVAPIWQax+w2864VfLJFxxm5q6R9YClbIvpwyWMQz2PdahOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725469511; c=relaxed/simple;
	bh=eEbMR5sJOGHdR4hsg+rR8Tn3NsZZ3ta4DvPKuylS9G0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UUO9YACxKBHRybnO2F57Hulloh2NWbTr7p6KF8pzBsqhS07WDunFcNYvXk8OcEZon0jOGZGt4If8tJGfF12u5lTgxTdReIvI/kuj4/o0bXLkLCaaMyXjvGAmTTHDyIYE0DL2QXxd/wyVohipgFDfug5zyCXGL1PIJGc1B62oFFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=c27obQdQ; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5c2460e885dso943a12.0
        for <linux-integrity@vger.kernel.org>; Wed, 04 Sep 2024 10:05:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725469508; x=1726074308; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BGKKwnKBtULPKByPd0VuQJbNaazKa6p+MrDbswg8Z2Y=;
        b=c27obQdQd+5XMfpDdZ7YY0BSfkZp1LWwDtnbct2HAw3ZH6Nk6o8RZqHw85qKuTKsp6
         Z3bdAuSSlHcDgr0vmfKXCjRl11YUlN8TqBKQ8x3t6wm4InQf2OGAopGwu/XVwGeORMSY
         7QT9dkQ8M5l9p4dACf7mhIan0TcFDFZaNifuMN8tpGR/5t+k5q2rZwo+dkBZYQJKbSPn
         Uk05FeJOzTfDsKdHQ4ntuwtUomAkyf57qvxyEN5Tl02wjqg4vdtCXeVjSfSspzfeK3qH
         8a7Sj31jW/9bt8WiytWSBO3txdEzOCGatxzQXA0fGsTctGJGHc/LoiHRK1V/Y9j6Itxv
         9sBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725469508; x=1726074308;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BGKKwnKBtULPKByPd0VuQJbNaazKa6p+MrDbswg8Z2Y=;
        b=Nw/GTb1fFSb7LdwIF1ciqoXP63qyDK/7woXIH62wmKXhhaZzfbQp4Jnm+gOtSronho
         mLCPNRGBm0ieXjzbVHrOvn458qonkQkSiOJlimDdOX8pFlMZfw50Was1bcKmUXDsfExO
         LzxVA25tqnmtkOCTsONQksdz6C44NRlRa42eiZxeUe/3Jus2OQlu3VI56L0LvAhLIqlF
         zwalRZwJMXdeskAfdArVy4SZkhrDs7J7bae7ZmiRD1OojU2gWckRPP7/WR8BOeQerWzt
         S/T36qAhA5d32enPIZ80+x69IxvIkZ7Z//YesUXIl+Bsix1VHUZrYk9/v2exgLE7GDwa
         5cRA==
X-Forwarded-Encrypted: i=1; AJvYcCXamcXF6FKGeKUylCvDXbJiYUkX0Uvv/OdLk5dekD7aMK+1b0kf+v9GEJh6Ef8hQMY810sKGKcG+XVZ7MWtsi0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcOZFrtAWtJvTrVLwXuWKBalzRFagrevO8L+Vz9DJaOP8CyUXE
	IFF2sO3S0FcKkEkksERoxCAR0dEdQSJS68oZG69tXbghkt/bntwrOtlTtJYkt07EhXgnk6OHEcU
	vvc6x0dMxQToY0/fix04Ot4pTDfvWsLfvXUaj
X-Google-Smtp-Source: AGHT+IGwiTvv8JFtAD7mnwNOHhZO0XjtuxjpCwJ+dxu+zMx8RmL9UkSfEcQZfUTGg8ykX+529d60DH1wVsGqIQ9TssY=
X-Received: by 2002:a05:6402:50d2:b0:5c2:2d47:2868 with SMTP id
 4fb4d7f45d1cf-5c278557341mr201680a12.6.1725469507249; Wed, 04 Sep 2024
 10:05:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240531-beheben-panzerglas-5ba2472a3330@brauner> <20240531-vfs-i_writecount-v1-1-a17bea7ee36b@kernel.org>
In-Reply-To: <20240531-vfs-i_writecount-v1-1-a17bea7ee36b@kernel.org>
From: Jann Horn <jannh@google.com>
Date: Wed, 4 Sep 2024 19:04:29 +0200
Message-ID: <CAG48ez2Vv8Z8nmn=mRwQ3_5azksszwoc+8UJgo3nh2uk-VwYXQ@mail.gmail.com>
Subject: Re: [PATCH] fs: don't block i_writecount during exec
To: Christian Brauner <brauner@kernel.org>, Mimi Zohar <zohar@linux.ibm.com>, 
	Roberto Sassu <roberto.sassu@huawei.com>, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, 
	Eric Snowberg <eric.snowberg@oracle.com>
Cc: Josef Bacik <josef@toxicpanda.com>, Linus Torvalds <torvalds@linux-foundation.org>, 
	amir73il@gmail.com, linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk, 
	jack@suse.cz, david@fromorbit.com, hch@lst.de, 
	linux-integrity@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

[necrothreading...]
[+IMA folks]

On Fri, May 31, 2024 at 3:01=E2=80=AFPM Christian Brauner <brauner@kernel.o=
rg> wrote:
> Back in 2021 we already discussed removing deny_write_access() for
> executables. Back then I was hesistant because I thought that this might
> cause issues in userspace. But even back then I had started taking some
> notes on what could potentially depend on this and I didn't come up with
> a lot so I've changed my mind and I would like to try this.
[snip]
> Yes, someone in userspace could potentially be relying on this. It's not
> completely out of the realm of possibility but let's find out if that's
> actually the case and not guess.

FYI, ima_bprm_check() still has a comment that claims that executables
use deny_write_access():

/**
 * ima_bprm_check - based on policy, collect/store measurement.
 * @bprm: contains the linux_binprm structure
 *
 * The OS protects against an executable file, already open for write,
 * from being executed in deny_write_access() and an executable file,
 * already open for execute, from being modified in get_write_access().
 * So we can be certain that what we verify and measure here is actually
 * what is being executed.
 *
 * On success return 0.  On integrity appraisal error, assuming the file
 * is in policy and IMA-appraisal is in enforcing mode, return -EACCES.
 */

But what actually happens in there is not so different from what
happens in ima_file_mmap(), so I think probably the only change
required here is to fix up the comment...

