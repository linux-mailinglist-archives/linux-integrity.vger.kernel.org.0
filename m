Return-Path: <linux-integrity+bounces-5423-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EBADA708ED
	for <lists+linux-integrity@lfdr.de>; Tue, 25 Mar 2025 19:18:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D511517058F
	for <lists+linux-integrity@lfdr.de>; Tue, 25 Mar 2025 18:18:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EDD617CA1B;
	Tue, 25 Mar 2025 18:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="cAhb6xx5"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE6EB2AD2D
	for <linux-integrity@vger.kernel.org>; Tue, 25 Mar 2025 18:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742926686; cv=none; b=EB4xLQkGDF/nsP6NF1fV/P/k3TT0T6OtN9Nv7sFMGHHvNy97U/Le4vUDfoL6DzFLSSblciCCg8EC78jJ3egNaopLLV8p7cmDl1wSq+eiyy1jQMR86YCiipnjp8uqYl2S1hzRXIXjlPoOqLCPQ2XwHtQkBOA4IIPl+2/8lBDguhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742926686; c=relaxed/simple;
	bh=/4+bLAd5YIoSfto7uBkSvM5inHnQsWrkg2NKoQTN1ps=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qJi17HgYcSqw/qz/Rwk48AQgm8LLhUQ6Ou/5hbzV+oQVBLZePTlEjg0aZ7SCoQ8pbO5dN70U1YJ01T2BMuMnf+oAm18ya2HpyhoRYioo/B7riij7sChFZXuwDcSvqhKqIrocX6lS+s8Yk2pZV93zSESsCSa5CQKztxwey3QHQqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=cAhb6xx5; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-85e14ce87ceso3694539f.1
        for <linux-integrity@vger.kernel.org>; Tue, 25 Mar 2025 11:18:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1742926684; x=1743531484; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/4+bLAd5YIoSfto7uBkSvM5inHnQsWrkg2NKoQTN1ps=;
        b=cAhb6xx5/FqYSdd/1pORUOfxDXuZwjI1+wO/qNjf+5iOaxo5aH6OrERWlUwDuyLJxz
         VKCHKuRLynpMWRS0zezpKRoORVHrqW/R7Y+YDgw9karI/FqV/q15HB11/8XpAn9SK2bP
         m/NPF0zyV73OYAN0tWiQJvRCSrf0Jgqrziu9qNDjPz9ss1hTIqsnRx4tw97dZBol3kiv
         57gmth1WbMErq9QcPwMjCvFiiXaQqgKUpbMzBgdUhs8E6H3UdfuQrape7k5yPTaGJ4Ky
         5IQiS22e7hQsHmDDGnP30mYfnghmmT46fk28Bnrtzo154xFqt15ve1u4/V2wMI10bh3N
         jvxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742926684; x=1743531484;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/4+bLAd5YIoSfto7uBkSvM5inHnQsWrkg2NKoQTN1ps=;
        b=oLAVjqXwiuHnAteySSi6YOiHUmOGiWoRbGT7Ru7ZHjb8lk3FMQO7PT62SLnj+9JqsG
         thXA1pG9XYy6YeaEw0krdVPyzqTXjiVKuXWf+3kTppFIkKgqNhtJE6TW1+cYcJib//PX
         FZpFQg+HDuFrIrdyNZcCJA4KvNjHKrufpg9gkNuMvPk8wheSM1hldK8rdtPnAsw0uclV
         SbbpyKrFAg3PWLPuR7SB8sr4kFJc97OwJp5k9dgXl8qyv6wI4iqvrK4ykjqUgFJFOEeJ
         +Tqgf+0XtFJZVoc7SliY7IKoEL5qRkFrqS04C5MFlT4+nbIu4YxAc+26eeKgDwkqb9rx
         SHgQ==
X-Forwarded-Encrypted: i=1; AJvYcCWkQDhwHy72bxbN9GyG0aeXS/UjP9C6YDtJd4oZYzdnVFt9qOEshR9JVb33kBJ19S7KZRbQfH+OFYJYe2bc5uc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8dUQB7ECu0mtkW/0AxBJwTeBZcOW9AE1ZcqIEEiZIlszxSL3+
	M9GWYqFJrJUYpOmTisTL/5a2lMZioLEDhNCax1mKhWJse7ybVcQfYpgDiMG8o1E=
X-Gm-Gg: ASbGncvvNctkV3Qwmi58anQlLDqikycw7yXwC9TZ1N7w+VNNx+pp3hbd+bQDXlnZ+Cp
	EgOsUl1fjKZKj477PtsTMyytAiPJ1E5zIpveIg2UVNHSOqNQeI07F3PjccgG1YZwmmnpeWbaVZK
	X8otLjtBRO68Gjxin/dVuQt8Z/4QDmFVwvfZCvePC0164U4XVnEGTTLronNZF3C3QBrMfDqGnyR
	lDDMZga1fPxGF5vCjo2OWg500hiHMxlMTg6OXZXz46AfmVL6md6WrrGCX87upndKyvlTpbsU9Wo
	6XfSoDj6zCljxU3io8AeXyOYgw==
X-Google-Smtp-Source: AGHT+IHerZJCcUba5+2uQMpJ6FxRljVNwdYl2gum46dsHYwuSY7HzXegJqiAeVDE22k7LOpkVelMjg==
X-Received: by 2002:a05:6602:b8f:b0:85b:36cc:201b with SMTP id ca18e2360f4ac-85e751c2403mr101382339f.2.1742926683683;
        Tue, 25 Mar 2025 11:18:03 -0700 (PDT)
Received: from CMGLRV3 ([2a09:bac5:8152:1b37::2b6:1])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-85e2bc13d74sm217164439f.11.2025.03.25.11.18.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Mar 2025 11:18:03 -0700 (PDT)
Date: Tue, 25 Mar 2025 13:18:00 -0500
From: Frederick Lawler <fred@cloudflare.com>
To: Mimi Zohar <zohar@linux.ibm.com>,
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
	Roberto Sassu <roberto.sassu@huawei.com>
Cc: Eric Snowberg <eric.snowberg@oracle.com>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	linux-ima-devel@lists.sourceforge.net,
	linux-integrity@vger.kernel.org,
	linux-ima-user@lists.sourceforge.net,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-team@cloudfalre.com
Subject: Re: [PATCH] ima: process_measurement() needlessly takes inode_lock()
 on MAY_READ
Message-ID: <Z-LzWCbROAI2H2Dx@CMGLRV3>
References: <20250325181616.79540-2-fred@cloudflare.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250325181616.79540-2-fred@cloudflare.com>

My mistake, this is PATCH v2. I forgot to change the subject in git
send-email. I can resend if that's needed.


