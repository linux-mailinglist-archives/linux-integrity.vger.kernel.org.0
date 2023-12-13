Return-Path: <linux-integrity+bounces-426-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6936A8106C3
	for <lists+linux-integrity@lfdr.de>; Wed, 13 Dec 2023 01:37:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 257632823C5
	for <lists+linux-integrity@lfdr.de>; Wed, 13 Dec 2023 00:37:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DFA1A31;
	Wed, 13 Dec 2023 00:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GER0MF1r"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF828EB
	for <linux-integrity@vger.kernel.org>; Tue, 12 Dec 2023 16:37:47 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-548ae9a5eeaso3033a12.1
        for <linux-integrity@vger.kernel.org>; Tue, 12 Dec 2023 16:37:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702427866; x=1703032666; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1LnE6BidxYtGaY3naq+UID6BS2mBFdrix5t5XhfBs+I=;
        b=GER0MF1r3n4hbuvaztv/r7g9jGVPXuX+pJokY1ZkDTPPmo/wIIE7c3LqkFrIvPx7Ty
         UmLA14tAQQgXEpxv1asWdk6rQ9QS2lE3212qvuOC5Uqba7fKx8y01Dcai3PkJSVclyC4
         4d7V/natmrN/jvPJAp6oV71SbAhayZrmkPzjwkmmwXO9if/oJjJuGXYWgNKIQpkkvAnc
         J4vXJjAFWk9P/rxTN54I3hpjYqEZ23HiBM1rWIUZSMAdLfACuq0k0KHmiaBfY23LymOI
         v0G+TFSg5rUV7GY8TmIqZ/fk6B6mBxbGwbw7g+Svkh+7JES+wEZTsa8I91/Z8s0rEkl8
         rZMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702427866; x=1703032666;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1LnE6BidxYtGaY3naq+UID6BS2mBFdrix5t5XhfBs+I=;
        b=dzRSsXOMsFD/oYVwfbSGQa2HUUVTtUkpXkSZvVDPL3UYJt6bqXLHKrQ0LeTqUI+nX3
         0xi0Wbvt5psdpZNCP5LBEeNUMiKwRAYWxhy0leURCHGlJ/Vhm7VOJ4E8BbrJYfeptyR0
         HKnnPG+TsyTyasdGS05bVr9gpg6S6Nju2/tvGpU5Mwr5cCqj2k5ovnzz5SbnpSTYiQFh
         /TSdwqME8vCAVq5NHOa31z+6HyLjCpX6TgHFp/0l05PoAzYufsqNyzTEzO6JkBThz/DW
         C0QG7J0mugLO6NJ3346W1cFa95nAqhLmRrHL9rqdP0621aQyTXpcJXOaQZVZGtr8lDL/
         KuhQ==
X-Gm-Message-State: AOJu0YxD3MSSiLCjMpeFO3GzHnMoChk3UCWROyTBwrExsJvhFSCDwtfM
	+k9HTp9C5oVhhko1XpJj8wp0RmZNnb9ysPH6FHC/EfNqzsQNiS8SaQ==
X-Google-Smtp-Source: AGHT+IGnMQRiKEPWZSvwWYwwY8FAhUWy825RQ67iHfal2GL8IR+NeDwrblzRUmQldUIwiAa92DPPmgK9pAj6EIrAdq4=
X-Received: by 2002:a50:d601:0:b0:551:f450:752a with SMTP id
 x1-20020a50d601000000b00551f450752amr37151edi.6.1702427866162; Tue, 12 Dec
 2023 16:37:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <000000000000b505f3060c454a49@google.com> <ZXfBmiTHnm_SsM-n@sashalap>
In-Reply-To: <ZXfBmiTHnm_SsM-n@sashalap>
From: Robert Kolchmeyer <rkolchmeyer@google.com>
Date: Tue, 12 Dec 2023 16:37:31 -0800
Message-ID: <CAJc0_fz4LEyNT2rB7KAsAZuym8TT3DZLEfFqSoBigs-316LNKQ@mail.gmail.com>
Subject: Re: IMA performance regression in 5.10.194 when using overlayfs
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, linux-integrity@vger.kernel.org, 
	regressions@lists.linux.dev, eric.snowberg@oracle.com, zohar@linux.ibm.com, 
	jlayton@kernel.org
Content-Type: text/plain; charset="UTF-8"

> Looking at the dependencies you've identified, it probably makes sense
> to just take them as is (as it's something we would have done if these
> dependencies were identified explicitly).
>
> I'll plan to queue them up after the current round of releases is out.

Sounds great, thank you!

-Robert

