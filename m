Return-Path: <linux-integrity+bounces-4198-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 017459D8C01
	for <lists+linux-integrity@lfdr.de>; Mon, 25 Nov 2024 19:11:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 185E3B2B629
	for <lists+linux-integrity@lfdr.de>; Mon, 25 Nov 2024 18:09:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87E06EED6;
	Mon, 25 Nov 2024 18:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="ZlsQn2KC"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D48F1B87E2
	for <linux-integrity@vger.kernel.org>; Mon, 25 Nov 2024 18:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732558147; cv=none; b=lr6pzFSXlsMJ154ZjbV8rbeyJkvK29cy3k2PCjfnzmBvNr0aPpwfeID9SCud/X2gROu4I/HrgtGRjZIGLX7arsv8kI77VbBg9IU6/a/FLuf2afB7PJKv53jtk8yJKoJO6tH21Dcx3V9N0T6EZlp9/V4GnG8Bv8MxGtqio9AWxws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732558147; c=relaxed/simple;
	bh=R9MnKqRkAYz4M7IdY2n1Q+LU+EaS2IZzi9iwfLCp9h8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eC5okQo9K1pWuL7caIKNtHRwc/03OBDcbXT6M7WP1lD8EwZIdzESXKvqaGz3/+uK9XJQthadXUBndyws33P0vGsYaIINZ2MfgME0CHqdNbFciTqvPqKwYNqjB/sWymM3igpt5GPLHRkWo5h06XRLkRz0S1Larn/eJfxgoV1cefY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=ZlsQn2KC; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-e3884cd186aso4695146276.1
        for <linux-integrity@vger.kernel.org>; Mon, 25 Nov 2024 10:09:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1732558144; x=1733162944; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R9MnKqRkAYz4M7IdY2n1Q+LU+EaS2IZzi9iwfLCp9h8=;
        b=ZlsQn2KCaGw+hScgxupu5paTLk/6tSsuPN9jM2917E6EVXzw3oHNYoqRMik/3XOBYh
         5daUQP8icqMf40xRgX/3hJo8Da5ZHpdZRHkU7MRpGY8Oxp9RpZ4Ko6jxcieLUfe/zXbD
         G2qXOYDbXzYFyNLQJjl4jhqgI5OTky+xtbX9gAz2UB8J9Ox1Bb3//S6NyhLJG9ItrcjR
         Q7jbp05XflgGNt2aZyXR0yGH4HtNOIXRuJ35i37rQ8G1f6rcbI0M4t/M4QmAZaK10Oxr
         OU9CwFvmGc10vvkC/7Pp5WfdrfM6iTRiMnIDyEC6mXGCFOpxXlhy8gD1FMPbGHYbg5jl
         k8TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732558144; x=1733162944;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R9MnKqRkAYz4M7IdY2n1Q+LU+EaS2IZzi9iwfLCp9h8=;
        b=WZozFuXZMVy1AyH8HsL1jZS3n34kj5PaKwDt9JiTwgMdXC6qtrE3vJYRKSS8dFlZ1b
         OTxykIUasTV36m/BT4/6Xf6axv0yrVlKnfaY9F9H9x+H/Zt5xbJRHYTYYqpxyldYXkLi
         Esa1AtjFCQ88Gh9K7c4rnQzKXTqPmQ4l/dwk0qKLgMUxfa3SKfxDtj0Hb782x04O5hK5
         l65oIZAYjkx073fxjWv5m3el5Xs5shGwOtDMUjb9xBMgu6vpBQBUQtiuOjigB+eFdiYr
         j0DgfO+quAkoqYs+0g09OxQmUajYk2PctUvbQrpywK5xqMas/M03+zFhtlpDAA0E8TwJ
         rH8Q==
X-Gm-Message-State: AOJu0YxbHQxCC5Ve3TsCggWkbuhmiLKkcwjfCeQuE7ZG15ggYTFACSjf
	xCD5RaYIm3++gPxw2OytXf/7zV3huxDq18uYcVJqvfb08TxNo9aTeZP75sTkkK/X5ohXrIPkjmE
	ZgpzRCDuXoEX6A+wuH+/v+hz5FMNfkQbJ68DgnR5PIQEaSBI=
X-Gm-Gg: ASbGncu69B3Ikj5wvLjP1U0B9Fg0GnqDX5M/o69+tTul4UHNYCfgMZpCF/Qy7Xrxg0W
	00TqFgKEW6D2Wu90xhJfneyhFlNWpCw==
X-Google-Smtp-Source: AGHT+IEpXgPL7q3jrul/j7CM+3IOwIbzusGGEtDUEpxaMuugVmVyG8Ys+pBxT4sj8uaErvzVo8IJiYtBYkZvxWCLdkQ=
X-Received: by 2002:a05:6902:2102:b0:e38:b6be:1d58 with SMTP id
 3f1490d57ef6-e38f8b343e3mr12969315276.21.1732558144407; Mon, 25 Nov 2024
 10:09:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJ2a_DeUX9UdAYOo9OwG-yXSH1etKQZortPcyxfzG70K3N+g7g@mail.gmail.com>
 <85139843-047b-44be-a1c1-4b0110206cf5@schaufler-ca.com> <3a3a1a22-636a-4ac5-ba12-4c59eabad664@googlemail.com>
 <3d718fa2-b043-4a75-a3f5-3b9dcf739b32@schaufler-ca.com>
In-Reply-To: <3d718fa2-b043-4a75-a3f5-3b9dcf739b32@schaufler-ca.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 25 Nov 2024 13:08:53 -0500
Message-ID: <CAHC9VhTrVnhPFBFW5vvfh+Rz+86xiprHM=qy7+bovaFq4npguQ@mail.gmail.com>
Subject: Re: ima: property parameter unused in ima_match_rules()
To: Casey Schaufler <casey@schaufler-ca.com>, =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>, 
	"M: Roberto Sassu" <roberto.sassu@huawei.com>
Cc: linux-integrity@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>, 
	"M: Dmitry Kasatkin" <dmitry.kasatkin@gmail.com>, "R: Eric Snowberg" <eric.snowberg@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 25, 2024 at 11:59=E2=80=AFAM Casey Schaufler <casey@schaufler-c=
a.com> wrote:
> On 11/25/2024 8:22 AM, Christian G=C3=B6ttsche wrote:
> > Nov 25, 2024 17:17:19 Casey Schaufler <casey@schaufler-ca.com>:
> >
> >> On 11/25/2024 3:38 AM, Christian G=C3=B6ttsche wrote:
> >>> Hi,
> >>>
> >>> I noticed that the `prop` parameter of `ima_match_rules()` is
> >>> currently unused (due to shadowing).
> >>> Is that by design or a mishap of the recent rework?
>
> It's a mishap. A patch to correct the flaw is under test.
> Thank you.

Thanks everyone, I'll keep watch for Casey's patch.

> >> Which tree are you looking at?
> > torvalds/linux:
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/
> >
> >
> >>> Related commits:
> >>>
> >>> 37f670a ("lsm: use lsm_prop in security_current_getsecid")
> >>> 870b7fd ("lsm: use lsm_prop in security_audit_rule_match")
> >>> 07f9d2c ("lsm: use lsm_prop in security_inode_getsecid")

--=20
paul-moore.com

