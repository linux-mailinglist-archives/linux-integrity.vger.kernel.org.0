Return-Path: <linux-integrity+bounces-4564-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 73290A11600
	for <lists+linux-integrity@lfdr.de>; Wed, 15 Jan 2025 01:18:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93450169BBF
	for <lists+linux-integrity@lfdr.de>; Wed, 15 Jan 2025 00:18:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C9D0182D2;
	Wed, 15 Jan 2025 00:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Ytd0/5vt"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D6A820ED
	for <linux-integrity@vger.kernel.org>; Wed, 15 Jan 2025 00:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736900296; cv=none; b=MIYDQffhZJijOC7rZlmIfg7bNjENHRfDprzpBVnSyyAbudsovgG8mrq0BlX2QsOkTe0vAwB8n4bcai8Uz1X1c+HyLbvClnW5BirRDdmXkyjaK3Qp8oRcV87wHL2z7QplkmG1i2/nnnC+Y8bOhua2+315u5OrAWeGi1G2MsYP7kM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736900296; c=relaxed/simple;
	bh=Zp49rurA1Myl0pyaSxk9MhtQoSZ5WS+5uSafkdF+aKI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jUyvEacctbATYCVhB49gnV0aZ++JvvGeZ3msN0+kZxgR0O2D7Gfi3IPJp312s+3v+mGi/aR6jYuHrrhfaJHn3rBDmmf0cdUYz53hXZYGrsxERdyqPRpQrltdISfk3YQufBBYz/y4h3VMBXLxMGqZRY2VjEHCeoJxB3/HLarxk+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Ytd0/5vt; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-e53537d8feeso8998609276.0
        for <linux-integrity@vger.kernel.org>; Tue, 14 Jan 2025 16:18:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1736900294; x=1737505094; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zp49rurA1Myl0pyaSxk9MhtQoSZ5WS+5uSafkdF+aKI=;
        b=Ytd0/5vt5mbHsaA+1uehqTjn72JDz0D4KPYxpwRIK1lXSfDUrv4JepQt1rUn3Ppubx
         5x2pX1MHSrJ8817FJmBDcfBRCTfIt6tPGDTtfyWEJqSJvaFTnO4wJ9s7HiKGnjD4PRxg
         MJ4O2YdI20kDRQnXZGTf9JisB75gVe1Bl8oJ6zUQPui6t1odFJouRmIYG0OZVWlXd9r3
         f2c7xoSdrl/SArjItXBG0tq95SfgLfreQi1qKrUZb5krTQ4B3wDPRgPmxRAF3VUBgEQ+
         q3Hc2Q3jOQNbafNKmo/FB9Lo4Wk1b7ji9OMhebr6OFtf6uQUlhVwOkIMp2yb5U+B8xC2
         Dotw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736900294; x=1737505094;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zp49rurA1Myl0pyaSxk9MhtQoSZ5WS+5uSafkdF+aKI=;
        b=GtzoAcQ1R8d+ZhH1Fsjbddhj6eBRDGjQK9Jqe9Zsholm11bqqLcloNKO5K0hfK4eRt
         Hmnvh4bcUtRBj2um8kgq5QRaQx2+DfjlRR71dbeYFe0Itg966YkiCnD9HmVqL8o021ZN
         hcuN0Njn2ZOR6yP9AT17HVOElXNZcnTF8xjFRt1/mEgyh47kY96JVMtoVQ+3l5UxtMQd
         qjGA9m82Y+g61/wB0XWSouZmJSBFJArAzoM+rnSkTbl8fqZV50Ai2zJ65L4ALm37sFSg
         nP0D8bLj/gkk09bMbMLHfkANQqaMQr2X6jRygxcreU0ticJH+RWtxADXN/HipAdv3wuJ
         3sYQ==
X-Forwarded-Encrypted: i=1; AJvYcCU/WJgxlVb2KsD3+c/E5yVvhnDTC2h2CH9XECuaPPOkqpDJaUpON864zNsiwq4LDG/FGqQCiP8+PTp77Q/X+i0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTEw64onFZj0zDX/hdw82oaQb8CAhdQCFAxFSPDJI4RQrFH5nv
	2jUwlr5H05kpqpr4dk2scKliJW26urowttf4l48qom3QlpZcmNxnINI/oC0lzv2rXg2KKYBdsQW
	DTQmyyKLJqTUkuEbPQu8Y/6FxSTnSOLsfl+H7
X-Gm-Gg: ASbGncsd0VWfGGrrzd/ayfhOC/EN0MyMne/PS5fB9VQEvB2ceTbPHfgEtutXTkYMpk8
	HUKjxeAUlHF5rbueTxeC0KUoXhx2mCAZO9mDB
X-Google-Smtp-Source: AGHT+IHtJYSwXkwz+07V0jN+izWJEyDVHZCMBZLUC2IdNu3wLbY2abzMLGBC7XuWrOyXqA98/b43/EFQmm+YZfl72hQ=
X-Received: by 2002:a05:6902:1444:b0:e57:2e8f:b680 with SMTP id
 3f1490d57ef6-e572e8fb8d7mr13442994276.40.1736900294049; Tue, 14 Jan 2025
 16:18:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250111.22fc32ae0729@gnoack.org> <20250112072925.1774-1-tanyaagarwal25699@gmail.com>
 <20250113.a860b47a11c7@gnoack.org> <d1b05612412a1d4b858662f296b45279c2141aa8.camel@linux.ibm.com>
 <CAPdGtUw9Ee7weCmS2ZP-Hi5KwPw9-O1fGRrY_KLKQh-SWgEN5Q@mail.gmail.com>
In-Reply-To: <CAPdGtUw9Ee7weCmS2ZP-Hi5KwPw9-O1fGRrY_KLKQh-SWgEN5Q@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 14 Jan 2025 19:18:03 -0500
X-Gm-Features: AbW1kvaUpZnLTH-RTdyjzL8irQYqX_incLPjKbOpK4BgJaOp8exyZK1GGvI_Sl0
Message-ID: <CAHC9VhQ1X_6V3ReOQv1ob22My=fjYk-b4Cfm0wB1YS6fomJtYg@mail.gmail.com>
Subject: Re: [PATCH V2] security: fix typos and spelling errors
To: Tanya Agarwal <tanyaagarwal25699@gmail.com>
Cc: Mimi Zohar <zohar@linux.ibm.com>, =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack3000@gmail.com>, 
	casey@schaufler-ca.com, takedakn@nttdata.co.jp, 
	penguin-kernel@i-love.sakura.ne.jp, john.johansen@canonical.com, 
	jmorris@namei.org, serge@hallyn.com, roberto.sassu@huawei.com, 
	dmitry.kasatkin@gmail.com, eric.snowberg@oracle.com, mic@digikod.net, 
	gnoack@google.com, stephen.smalley.work@gmail.com, omosnace@redhat.com, 
	linux-kernel@vger.kernel.org, apparmor@lists.ubuntu.com, 
	linux-security-module@vger.kernel.org, linux-integrity@vger.kernel.org, 
	skhan@linuxfoundation.org, anupnewsmail@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 14, 2025 at 11:13=E2=80=AFAM Tanya Agarwal
<tanyaagarwal25699@gmail.com> wrote:
>
> Hi All,
> Thanks for the review.
> Sure, I'll split patches of different security subsystems so, that
> they are easy for maintainers to merge.

Thanks!

--=20
paul-moore.com

