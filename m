Return-Path: <linux-integrity+bounces-3518-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CEE497510A
	for <lists+linux-integrity@lfdr.de>; Wed, 11 Sep 2024 13:47:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6FAC81C20B83
	for <lists+linux-integrity@lfdr.de>; Wed, 11 Sep 2024 11:47:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4F58185B6F;
	Wed, 11 Sep 2024 11:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sigma-star.at header.i=@sigma-star.at header.b="PGM76Jo9"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F21C7144D15
	for <linux-integrity@vger.kernel.org>; Wed, 11 Sep 2024 11:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726055218; cv=none; b=FLS36jed8CiSGuRldygbOvjFw1zezJn3ZPYmIEtPVOb2mRfclHTx0LCkI72Jxit2vkGHOSHec7cIfjfvBym/7WYxZPzfWYq/cp3pTAxXXYVDoRxqOX0YpZxuqFPOuGx9w510mGcU+oQRXAPqSiywRCb/2sts5EXCBXAniOcY3JI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726055218; c=relaxed/simple;
	bh=X/p7ozOFdNkzDyFy84pNxedDNmhFFzcJ3Fp+8FbvONM=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=gqCIhNpOiyUUWLQWVmsvus5NmK8eVlIWjRtfU520StxadTBDVtASZ3yazf6kAf/x7STdc0pUfDTjvi7EPqZ85XnjxLcoSX2WY0Baaq8PkLvOLqnTZwBt0uKFgHAc2RigYAFcywIo6HwPgl9GMYEwf84fMpjPNM9jSaJ3m1nc4WU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sigma-star.at; spf=pass smtp.mailfrom=sigma-star.at; dkim=pass (2048-bit key) header.d=sigma-star.at header.i=@sigma-star.at header.b=PGM76Jo9; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sigma-star.at
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sigma-star.at
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-42cb57f8b41so821855e9.0
        for <linux-integrity@vger.kernel.org>; Wed, 11 Sep 2024 04:46:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sigma-star.at; s=google; t=1726055214; x=1726660014; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X/p7ozOFdNkzDyFy84pNxedDNmhFFzcJ3Fp+8FbvONM=;
        b=PGM76Jo9weK2yz+iASBV+A2aaLAapTj0ppz/W2wLq5XdN5Qgz7AjFQZsmRJF/YJUQ9
         jh6tkLM+OczU5UnDZAmBEGC8Vb5nmMj1wwHLo6zpJUdmx1DiY9j8grmpN+UQtSlJxENc
         PF/AuzdEg+XTTvK+Qh7izbqHcMSVbPNWtKfuOmt0nBP/tifelGnzcgZu8+PaRZUFK3Me
         Q5wqh2J7slmzJMVxYNgRCVhGty0+Gzovw27Uh/lyvO1juACapkkPpgrxfor5mNfO4Pdb
         g2eZfsHs1mh6b6M9814JcAGvjTxZJW/9B9f1H3gEvIydxl5xtvmciPsFIuL8Z8lc1nsc
         NJ5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726055214; x=1726660014;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X/p7ozOFdNkzDyFy84pNxedDNmhFFzcJ3Fp+8FbvONM=;
        b=EQfUvzP+FZtxeBpBMkpUpasLlnJsknSCHV51umZnJpIQojddzOsgWwdbh/9e/MSDer
         rCApajGueqn9JJ0EeLf6QYtpeUG7fKY/bPHsRIjgOEla7VxrXAlIEUow8T1PTnb7Rlvh
         W6Nes4E8LdBEFMdad4ZfcH/kLRgxerZSibC7PjF/0wDQgYi46EcTqmuwMVfEev1Xk7Mq
         q7J8HQmWHnvGlLovlK3rcJQYiw7/C/zc7mFnmSCeLiOau5k8lhMt/sa5f4VIZB4AyPc6
         owbbByoARsRQzooIU2A4yrMEOAmw5YBUM4CxnRcjhKlqVp/Orn6SMvamjlQvavyxj0kW
         3Mhw==
X-Forwarded-Encrypted: i=1; AJvYcCW7uCbDISN4Le44Olff6VSnO7bWcgW7avq+kF4bZL/udyLtyAmpffFEQ4gw9XDnhm/gCG9xbVHn2Hh5K/Ydink=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJPgOnA/T34uuFcN3iNFM8Sj8q389sQCrAWOA653pcU+I338ih
	jbQHa0wN9b4m/5TeHLE1WBVniNBR+3cYfDDOAihfOE582DNBaVsMWDDdWR2pE10=
X-Google-Smtp-Source: AGHT+IEMjtmdnkfso1u1DLT4HeBwtEeQFYtm9Ats7aKaV4D0NjaHlFaTa/1ay6FbfV7/z6S531hLgw==
X-Received: by 2002:a05:600c:a48:b0:42a:a6b8:f09f with SMTP id 5b1f17b1804b1-42c9f9e0f8bmr152770355e9.23.1726055213647;
        Wed, 11 Sep 2024 04:46:53 -0700 (PDT)
Received: from smtpclient.apple ([82.150.214.1])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378956de3d4sm11353465f8f.108.2024.09.11.04.46.53
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Sep 2024 04:46:53 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51\))
Subject: Re: Trusted keys: DCP: Unable to handle paging request
From: David Gstir <david@sigma-star.at>
In-Reply-To: <254d3bb1-6dbc-48b4-9c08-77df04baee2f@linumiz.com>
Date: Wed, 11 Sep 2024 13:46:42 +0200
Cc: David Howells <dhowells@redhat.com>,
 "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
 "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>,
 "linux-security-module@vger.kernel.org" <linux-security-module@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <DEFB2283-435C-4807-B401-2F4B5FAE1386@sigma-star.at>
References: <254d3bb1-6dbc-48b4-9c08-77df04baee2f@linumiz.com>
To: Parthiban <parthiban@linumiz.com>
X-Mailer: Apple Mail (2.3776.700.51)

Hi Parthiban,

> On 10.09.2024, at 17:02, Parthiban <parthiban@linumiz.com> wrote:
>=20
> Dear David,
>=20
> The below commit when using the stack memory for encrypt/decryption, =
unable to
> add the key using keyctl. IMO the encrypt/decrypt request which is =
submitted to
> the dcp driver is asynchronous and seal/unseal is returned before the =
completion.
>=20
> crypto_wait_req with aead_request_set_callback will help?

thanks for reporting this! Yes, it looks like this could fix it.
I=E2=80=99m still a bit puzzled why I never ran into this during my =
tests,
but I=E2=80=99ll prepare a fix.

Thanks,
- david=

