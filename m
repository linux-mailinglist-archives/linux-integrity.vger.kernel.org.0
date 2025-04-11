Return-Path: <linux-integrity+bounces-5816-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 02BB4A8516B
	for <lists+linux-integrity@lfdr.de>; Fri, 11 Apr 2025 04:15:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D68A1B82A6F
	for <lists+linux-integrity@lfdr.de>; Fri, 11 Apr 2025 02:15:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA06A27BF99;
	Fri, 11 Apr 2025 02:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="cEiV/auX"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 535C827BF85
	for <linux-integrity@vger.kernel.org>; Fri, 11 Apr 2025 02:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744337705; cv=none; b=MLel7rkURtHBuVbhE0oFxmxpzAVH6u9R7sHHPwrr+ziWlT2qoVpo7IEIcD1R/+NZL7Q66gAR08Ik3kDYMmiIdflr5A6+ZykJBcFYa0vISKh66RDEvPZNMrYKmVPS+rrFb0Cd3AHi3nmQQYDxQ5oH3mMcFXA4BlhE3M5wmVwlJx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744337705; c=relaxed/simple;
	bh=pgAT8Qc2QoFkFKo9CcaUohfX6BdbfmZhvPmHWJJSwzQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HeJYHcpzG+ea5VXFf/p+dpNON5xk5ubRadP8U6zOQGVFl5mdTSOOkLvLtgNN61Ne8T4iuCb1uZgscPPGIafmSUhrS2VPT1oBk0S2CZm6hHdscKhp1CVUw0XUkhyWj+6viuTsULz5avHgNV6+Bs2lg07t/Ziw+W7EjpDYhXtzgOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=cEiV/auX; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-e573136107bso1374912276.3
        for <linux-integrity@vger.kernel.org>; Thu, 10 Apr 2025 19:15:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1744337703; x=1744942503; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pgAT8Qc2QoFkFKo9CcaUohfX6BdbfmZhvPmHWJJSwzQ=;
        b=cEiV/auXOeksXq8uT2oTwklewEg6x+g3XUKLCmCSz2IwStRGJ9UP2FP0f4CfSW3lLQ
         gAPe8ogFt2kHwbzdXsSQ+olJe77xhp2/Xc6dtAOGLGyhUlIZ6p2iVWw3Zhp6+1VVJcJA
         9wk+W5PJ+8at9U5H/sKSEsLnQuHsznNTkD/IwenQcTVUf3asKOgejK1clFfWopQr+Of2
         +WnJygW5QivB2vtFSO2gMeMcEXYla7s1PlOSnjSZKDmc7jhz/ajpKXcngNEnVI00BL0n
         c8S2CbpjoybtJydSlC+s8gNoor5CRu8o0PUMSAUzxh20CFE7XEZN7Gz1Qow5PNc4ACfm
         pTYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744337703; x=1744942503;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pgAT8Qc2QoFkFKo9CcaUohfX6BdbfmZhvPmHWJJSwzQ=;
        b=OgDtP3jGqC2hVuXkhjJYtjVfUNJJhXJZVfXlHewo/5HquYgruY8zdbK/6PADS/q6i0
         1+nrJG6Y3x8Pkc1ND5Z9PyYDXv/82K2ei8FPzloODGAfs3KcGMMWLPpHherUYt3HiTio
         TITqNhRUAB6KyroUZ2NkrukJuzGpV4pedHWGwQH3JHkbtNQ7VnlU0Vqs+WsrCBECaRLL
         yRjtzZ3yGahfSOnwZ3wdH+MGKLue9Z2iCQz6kqcnXRK8M708KYPxfn/ln5vJK2mwhBD7
         2z7qJkjVvelMBG8yrRaSE95lTDbkud9RcFjKccF99PPse1SE87vx/+v2QTOEgdtvpQBZ
         T8qA==
X-Forwarded-Encrypted: i=1; AJvYcCXAjYU+q4c0hVhYcu59sN3JkgFJrwoax4d/bo2vA3V7jtcgDbzjxv7Y4QyRlrjip3+5DGw2EC9XaE39RrelC8g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/4CRG+7j8V7/2SR0E2SwimwNRY/487TM6UD0OCfzVs7IxdH21
	s5wLewmo8ikYs3UKgVy0XDSWTfO48Q4GazNdyy5pl6Gvl2DYQMsVijvMlS+6UTvOSVdpT9xDoJA
	E2ARrLIXZpuGNZCqG1vWwCHf6k1b7f3cwDyfX
X-Gm-Gg: ASbGncuhrt+1NCdqNYKTobY70oCzFTJ1XZBi92ntH1OdVEMIBChpRHVubS5TaaX4fcM
	Ck5a4Dtsxwk8jQJThBaD26N9NZaFLI8YSB58SeNsZXj60Z+Ldy3a0BBOy6TG1VE5zjyx2asPyBw
	VaDSa7nXxg1L9acx7oCHW7pg==
X-Google-Smtp-Source: AGHT+IGrM2n2rbgpwcEO5kOc/D9dhDNnGXDOY3TLNKyzkfl2Hg5nNHGBO/S9yZ4DvomKQWEMD32rhbni3kdmuWNZONY=
X-Received: by 2002:a05:690c:6606:b0:6fb:46dc:d9c4 with SMTP id
 00721157ae682-705599c9de6mr21538937b3.12.1744337703320; Thu, 10 Apr 2025
 19:15:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250409185019.238841-31-paul@paul-moore.com> <20250409185019.238841-40-paul@paul-moore.com>
 <202504091656.21EEF38DCA@keescook> <CAHC9VhT7M4GWLJ0Kx0nkCAC+kirQ0LKqBVaqps9z-0kOc77iDw@mail.gmail.com>
In-Reply-To: <CAHC9VhT7M4GWLJ0Kx0nkCAC+kirQ0LKqBVaqps9z-0kOc77iDw@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 10 Apr 2025 22:14:52 -0400
X-Gm-Features: ATxdqUFgbb3sqVMjbtBqdDPWycG5EM8g5SzhjnvXiM3Xmh9QxxHw6T_UWbYo7YI
Message-ID: <CAHC9VhRT_dBRusxjsD+mwAXG=bg7MmwA3L_3W9J3GgtoODqZWQ@mail.gmail.com>
Subject: Re: [RFC PATCH 09/29] lsm: cleanup and normalize the LSM enabled functions
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

On Thu, Apr 10, 2025 at 9:50=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
> On Wed, Apr 9, 2025 at 8:11=E2=80=AFPM Kees Cook <kees@kernel.org> wrote:
> > On Wed, Apr 09, 2025 at 02:49:54PM -0400, Paul Moore wrote:

...

> > The simple renamings looks fine, but would be nicer if they got split
> > out.
>
> I can look into doing that, let me try the squashing first.

... and I pulled out the enabled/disable setter/getter functions into
their own patch.

--=20
paul-moore.com

