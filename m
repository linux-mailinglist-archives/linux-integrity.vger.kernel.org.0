Return-Path: <linux-integrity+bounces-4576-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 485DFA138DB
	for <lists+linux-integrity@lfdr.de>; Thu, 16 Jan 2025 12:23:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6EB5E162E4B
	for <lists+linux-integrity@lfdr.de>; Thu, 16 Jan 2025 11:23:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88D401DE3A6;
	Thu, 16 Jan 2025 11:23:36 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A51BB1DDC10;
	Thu, 16 Jan 2025 11:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737026616; cv=none; b=WJYfx/T6GKJLYvaRy1jzCcoPENMH7hBHR3/vR2uvypow7RKZ6AZkAiLGarKNwZUwd+B6kCHEnMok1OCgGTe8pG49Dh+rjAnq3yrqTNhKUAIznPfGNZdcYANqXWHxGybWKWQxogJSyBltnZ4o8nKW3UqrImOYqO1mcfaL2kYuFmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737026616; c=relaxed/simple;
	bh=EZi6ZK9x72VW0NsySagdtc+fXDlaQIQXzTsLXElG7NA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XMt/t+XvCLQ3mgA4ALE/P9n1pxsrk0Vti9a9RTm6tiF2IZT42N6aM8DhB+JtpIaiHF73OVAZjJyiO9H1ubznk28su2M6aqdNZoIjSi3r07TIt5IVz+5TsbbdqRnKWzt+R3WnePwc/TlhWlrrI/5Bde/5rvUmcS8b+Mpa2BSbwv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5d932eac638so1681017a12.1;
        Thu, 16 Jan 2025 03:23:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737026613; x=1737631413;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e9qhclktkpiwcVlhX69uBL057FkuaQgXj7Vyw+C1VD0=;
        b=EA964dk4aKfN7Y4txWIv2pgmokc3gEPCgZnJiblbjW71+fitwPjZk6qUYCtkVEo8ak
         sW5loacB1/Xgkfl5HqNb8EoEOgwzK+JX26fMz7yjz/StyQ9DDWH5yb4gkwozB+2L/+3D
         Mzbo1B72z81UmzEhE3ALYy/KpmvqGYNCG44qZBkLdEcU6tQAYxqgwYF/q+PG7oyBVYQD
         WlhZndLcWDC1N08jUZw/H5e+kVj9slJkwqsXhhxbHBCGGSJYCgcHLZ5be4IDJjAD4hM6
         4esAOIw1LjkFwfeeQdc+mT9IIvkXZ6xM1mMHD6Dsrki+wZTEQkOJhCp+Zfjl9mH3Z0Fj
         3PBA==
X-Forwarded-Encrypted: i=1; AJvYcCVeHBXy5OEpOpeDPEIftHO3HP7FmM1ZUcceXTHilslFXCBOgxtyrVYiPPaSodD11/Jrt0jDifVYJ1be8B4tpww=@vger.kernel.org, AJvYcCX6Ql6yC0xHwPUwfstNWciT+CR+69kjvRZp0ZTVpjFVk8BV/MBE0FJhMDhWsqnNpxPOHOQDPU6Sx5dReRwI@vger.kernel.org, AJvYcCXjVgsMumzrWxU101AxYOOUdWsTGqiw2NXv0hXfIVfq3dETHTKJhSz+uhD2kIpaZ1FT5sq9LE0y4Zb3sQg8UrJn880lFZ/I@vger.kernel.org
X-Gm-Message-State: AOJu0YzjXbGMipoPtSc9+aV5hQ6nnBkTez9ujVcJ+bKL5xo0ktpstvS6
	H03pJFdh8CXkhHVgfjZ9Pl6UWxBNWoc6U+dHcTQ87FBerRX1RmRKhwJ6bw==
X-Gm-Gg: ASbGnctJO7JeTkrHUYyoRC111Mk6bMATfwTep0SfIGvC5x56tH9gDKFubYYlz8+jhuu
	Kh6eEOAZ2lv5EizuskV6E+2E8NSbQq8R7sh7nsUNdtymMIb/BYW8sXhsKIuA3y2IN3CyubQbW3n
	S7eKFemu8XQSx84KVaidWP2BBpFh6OIZ/IVaB1HrOVw273rYON4ViNAVjIxoTvAhO4oeNN8Z2Gq
	dpZjxNCYIV8+AlPTtghsttGCV3f0jUDVVhXPyO/PSQ7S30=
X-Google-Smtp-Source: AGHT+IFySmbf26jYGiFsqkQqqE8tJBSCG7NGRoWX1HKwuzn/eQvFpo8FWB4CDJLnKBQbywSGYaWqgA==
X-Received: by 2002:a50:c94d:0:b0:5d9:82bc:ad06 with SMTP id 4fb4d7f45d1cf-5d982bcb571mr22817480a12.3.1737026612825;
        Thu, 16 Jan 2025 03:23:32 -0800 (PST)
Received: from gmail.com ([2a03:2880:30ff:4::])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d990469d0fsm8867863a12.61.2025.01.16.03.23.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2025 03:23:32 -0800 (PST)
Date: Thu, 16 Jan 2025 03:23:29 -0800
From: Breno Leitao <leitao@debian.org>
To: Mimi Zohar <zohar@linux.ibm.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
	Eric Snowberg <eric.snowberg@oracle.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Mimi Zohar <zohar@linux.vnet.ibm.com>, linux-integrity@vger.kernel.org,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: Re: [PATCH v2] ima: kexec: silence RCU list traversal warning
Message-ID: <20250116-jovial-stalwart-chipmunk-0b3693@leitao>
References: <20241121-ima_rcu-v2-1-4d48630cf2c6@debian.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241121-ima_rcu-v2-1-4d48630cf2c6@debian.org>

Hello Mimi,

On Thu, Nov 21, 2024 at 01:57:12AM -0800, Breno Leitao wrote:
> The ima_measurements list is append-only and doesn't require
> rcu_read_lock() protection. However, lockdep issues a warning when
> traversing RCU lists without the read lock:
> 
>   security/integrity/ima/ima_kexec.c:40 RCU-list traversed in non-reader section!!

What are the next steps in regarding this issue? I am still seeing this
problem on Linus' tree.

Thanks

