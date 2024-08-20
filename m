Return-Path: <linux-integrity+bounces-3369-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F8F8957BA8
	for <lists+linux-integrity@lfdr.de>; Tue, 20 Aug 2024 04:52:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D2D6D1C2326C
	for <lists+linux-integrity@lfdr.de>; Tue, 20 Aug 2024 02:52:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A998446D1;
	Tue, 20 Aug 2024 02:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="dqOkZljJ"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97A923C6BA
	for <linux-integrity@vger.kernel.org>; Tue, 20 Aug 2024 02:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724122330; cv=none; b=jMINriqrGvopiyWdRpN3U7ruk0Y/BqYxTBRJGW3Zcqh3lzE/8IOqqbBohevtn5zc1vqp6X9lfhPuNmw4b+vPMl27XaOAkL+LaMP3eCRPDPudcMKQxwiFdLsnUrphF8MpIe8IPPzwekMK/QVHFhrnmU2MuYioR2qE+kIYLLEbh0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724122330; c=relaxed/simple;
	bh=ZDr5ZbxqvFQWLLGyxixOKscT+4fsLzUr364GEc8bx4k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=vFcS0gjlFZfPtUBS0E23+I7Co+3Bn/StPpDay35L/bUVYXqfcfrjhIKgUFfqQhYuf+rnYoYDTNuG0KuxlZU9qeS/iXR+8wqWiq38Jxc+3x9kBm8jleXTI9OkPi2QJYnjfl/Y8vjMn6rqeEpORyku+AbVTZhdSg4PZNEo8iCPL5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=dqOkZljJ; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-e1633202008so1664357276.2
        for <linux-integrity@vger.kernel.org>; Mon, 19 Aug 2024 19:52:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1724122327; x=1724727127; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dMMqIhR8mNN7qbNLvHC3cSRq9saBfgJ6P2Pudx1fscs=;
        b=dqOkZljJ/4XbyB5lfn0o4WdQuoguaCyga7HO4AANEqA0oaRTt5aUuJ9QhtHuwDPRMw
         mEw+K0qCLjIAwbi7NtZAYAZtPJ8R382PbpPsZDVDDU6QbWjyW0oDHoS1d4yq/dWbihz5
         yLsyVA5ubIkQVO3Bk7JEFA12oWZq5h3sp0QPu1/eqqyq9x6s2h1sSpMgbintfGTI6vY3
         N3QYxaOGerWRC/yHj+uOu7/Mcnfu2rXGvRhWVxhuA4bBZkSdAzIzX+K4zJZy/wss9Xre
         a6qjc/CVIIQGFRXWSGf/XpVDLoDhRWY9PoltyLQ83+DFFx3kdYcAILRMwOYINusjg0jk
         ujng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724122327; x=1724727127;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dMMqIhR8mNN7qbNLvHC3cSRq9saBfgJ6P2Pudx1fscs=;
        b=qV3aZ549Lw8CuLnkOan6saUZYQvo7/UWs7YDuthxkCun9ryZuaQycckloCa6PUSANt
         RhH4tnMiU0xoPnuNBS3+2vnUYOCgwp1fz7WM/iP80YKBBb9B+Ht3rg0gmnqhaGQO2JoF
         t2BkqYACL3HfkpivJqEWBYG3gB4x6XqjZXo3Q9KEsA0xCBbY5RoZoD8XLUmZ2qf5WgyS
         YjtLbpR9CUblEglSZHbMqLedVcUsB9BxuhvQQH/QsAIdbGUcBlVWzpxgEh1QjJMKa3kn
         OXGscsOs05voEtqD2de1oViE1Ac99SY9SfFvv+SOvkl4csDYWGqVZpkhQHqEk3zhjUvg
         Y8fw==
X-Forwarded-Encrypted: i=1; AJvYcCUodhOjwTEPyPoOdPgDN0fO/r1zvo/Odc+Dy6uKZ42Hy1YeEKEjX20VEnFUFFjvJua/093tx/qFOzLRuznh18Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMco/iYasKYCeNevLBj4CPeahqOnYZ8KYeUrPB8uBr2t03iSId
	1whSLH1KdQeslOgY7kmBO8FMm1b7oO6Wp72RaoFomejE7yeb1EsbXwa3Nz8NofqAEGP/TrL+moe
	b9tZKTDCkgeGBKPHMhhkw8rvmW/cxnMhXYuxW
X-Google-Smtp-Source: AGHT+IGx4BZUDH+LCtHEYeY3Jj6i77Krk/e4mCpEtrxZEdqLSGFNLBDOXv3VOnuXbn9YLa/m+2U6fa38CFBTVrK6h9g=
X-Received: by 2002:a25:d8ce:0:b0:e11:83ac:a024 with SMTP id
 3f1490d57ef6-e1183acaecemr11644146276.39.1724122327544; Mon, 19 Aug 2024
 19:52:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1722665314-21156-1-git-send-email-wufan@linux.microsoft.com> <CAHC9VhQ3LobZks+JtcmOxiDH1_kbjXq3ao8th4V_VXO8VAh6YA@mail.gmail.com>
In-Reply-To: <CAHC9VhQ3LobZks+JtcmOxiDH1_kbjXq3ao8th4V_VXO8VAh6YA@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 19 Aug 2024 22:51:56 -0400
Message-ID: <CAHC9VhR7CEBmzjnruFaHHpepYWSRu0bvPUxYk_jz7oXRS5yJUw@mail.gmail.com>
Subject: Re: [PATCH v20 00/20] Integrity Policy Enforcement LSM (IPE)
To: Fan Wu <wufan@linux.microsoft.com>
Cc: corbet@lwn.net, zohar@linux.ibm.com, jmorris@namei.org, serge@hallyn.com, 
	tytso@mit.edu, ebiggers@kernel.org, axboe@kernel.dk, agk@redhat.com, 
	snitzer@kernel.org, mpatocka@redhat.com, eparis@redhat.com, 
	linux-doc@vger.kernel.org, linux-integrity@vger.kernel.org, 
	linux-security-module@vger.kernel.org, fsverity@lists.linux.dev, 
	linux-block@vger.kernel.org, dm-devel@lists.linux.dev, audit@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 6, 2024 at 4:59=E2=80=AFPM Paul Moore <paul@paul-moore.com> wro=
te:
> On Sat, Aug 3, 2024 at 2:08=E2=80=AFAM Fan Wu <wufan@linux.microsoft.com>=
 wrote:
> >
> > IPE is a Linux Security Module that takes a complementary approach to
> > access control. Unlike traditional access control mechanisms that rely =
on
> > labels and paths for decision-making, IPE focuses on the immutable secu=
rity
> > properties inherent to system components. These properties are fundamen=
tal
> > attributes or features of a system component that cannot be altered,
> > ensuring a consistent and reliable basis for security decisions.
> >
> > ...
>
> There was some minor merge fuzz, a handful of overly long lines in the
> comments, and some subject lines that needed some minor tweaking but
> overall I think this looks good.  I only see one thing holding me back
> from merging this into the LSM tree: an updated ACK from the
> device-mapper folks; if we can get that within the next week or two
> that would be great.

I've just merged IPE into the lsm/dev branch, it should go up to Linus
during the next merge window.  Thanks everyone!

--=20
paul-moore.com

