Return-Path: <linux-integrity+bounces-1482-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 855A7868300
	for <lists+linux-integrity@lfdr.de>; Mon, 26 Feb 2024 22:27:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 26ECF1F274DD
	for <lists+linux-integrity@lfdr.de>; Mon, 26 Feb 2024 21:27:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ECF113173B;
	Mon, 26 Feb 2024 21:26:19 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0A391E880
	for <linux-integrity@vger.kernel.org>; Mon, 26 Feb 2024 21:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708982779; cv=none; b=eBg4LuMq5dJ0HVwFdUxJ3u3brNFCq4fpiWprPL9sPwIU0zCYcJ37+foPSyFhFGtBKY10uc2Yunj/Mzjmw/v16cXzmdSvKiQFePSGnST9T2z97y7FxsDVQoEFA4TPRSi1bFMjw+8m880XR1ndNVvIPy/GQ/rJmYwg+CHq04e/BZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708982779; c=relaxed/simple;
	bh=ocyp3J12temD/A1wD6ETKBJ5HK67PYdKqlU8YnAmU9E=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KxdnBGk5a+gO9al/FpwyxNDSrnELW6PP56mf+k48guKBjdeZazVh2T15uCkMVDMmJtEUxcaAPONPedj/nWZj2Vhq/8LJIUGjkYiS6NpAki6nxlnb4mEhQbZrCcd14Nm7NXvTRu7ba3Zejk65z3SjNgrsiJzj26fv5CMb4PH1OKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=andred.net; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=andred.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-412a7b68809so7739985e9.0
        for <linux-integrity@vger.kernel.org>; Mon, 26 Feb 2024 13:26:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708982775; x=1709587575;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ocyp3J12temD/A1wD6ETKBJ5HK67PYdKqlU8YnAmU9E=;
        b=mog5d29Jc3v2U81YZ+vGr3RYZ8mIM2BuHFN6Tu3E0mvkNtu0Fn00DntCM/2Z1B7ymh
         MLCRjlhr5vQZ32epluC4EwuSL48k/Aan9aYisGi45CEhgu1bKmXdCzQLsOyUkCU+E/If
         bbNm98XXhLbgkPaPbq1groVnP4Jz+/mVDjb4mEzSgWsLLNU1J44S27FsSF33cSABJu+5
         PTxj5oqpXK7IA3pS5EiZ5SJjVfxAiWjmBCOjMrWFaKy3j/6ob5FSWyHtJ4cvDJXEGKrL
         Mt844yX4fv8kKWeLYQxr1ceu8EE0pO1on8ArihYqnHV0g5aYD/ib5ewsyguPwSfAPinb
         4Zrg==
X-Forwarded-Encrypted: i=1; AJvYcCV10y88yFD/9nvRgWYjj7wiBhyhm0rBa/qNNmOwaWReGnHdUbcKyoIwlfQfKspp/R0eI7RSi8Z9QvwCYchQJLmINxl6ZMjram8zxcMwIcdG
X-Gm-Message-State: AOJu0YzQ/liCGUR/eDw8+a0Oadg7pL9d3hL33KhmOzAnPTFpd8AClgpT
	8vEmuUmEN9Zkwn/RHJ+xE8wch9N2sdLaIv75G0picV7dFPdwEsHqAZa+vhJeNJo=
X-Google-Smtp-Source: AGHT+IFLIx2xH8xz+7b8FU5gtfUjwL/R4TG0UNSjO4JDYcuYJoXc7NZe/8t1Vmz/dE247apogg+3Sg==
X-Received: by 2002:a05:600c:1989:b0:412:9bfa:4a with SMTP id t9-20020a05600c198900b004129bfa004amr4531822wmq.23.1708982775035;
        Mon, 26 Feb 2024 13:26:15 -0800 (PST)
Received: from salami.lan ([80.111.64.44])
        by smtp.gmail.com with ESMTPSA id bd22-20020a05600c1f1600b00412a38e732csm5615897wmb.35.2024.02.26.13.26.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 13:26:14 -0800 (PST)
Message-ID: <da05e5f88ec57c357978185c65ba1498e2cfd28e.camel@andred.net>
Subject: Re: [ima-evm-utils: PATCH v1 1/1] Change license to
 LGPL-2.0-or-later and GPL-2.0-or-later
From: =?ISO-8859-1?Q?Andr=E9?= Draszik <git@andred.net>
To: Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, 
	linux-integrity@vger.kernel.org
Cc: a.mardegan@omp.ru, dbaryshkov@gmail.com, ebiggers@google.com, 
 sorenson@redhat.com, gcwilson@linux.ibm.com, 
 James.Bottomley@HansenPartnership.com, kgoldman@us.ibm.com,
 mjg59@srcf.ucam.org,  zohar@linux.ibm.com, patrick.ohly@intel.com,
 patrick@puiterwijk.org,  petr.vorel@gmail.com, roberto.sassu@huawei.com,
 stefanb@linux.ibm.com,  stephen.smalley.work@gmail.com,
 tianjia.zhang@linux.alibaba.com, vt@altlinux.org,  vgoyal@redhat.com,
 z.jasinski@samsung.com
Date: Mon, 26 Feb 2024 21:26:12 +0000
In-Reply-To: <9205ed32da8814d8c4d9bde5a03d92c7588f1d9a.1708503094.git.dmitry.kasatkin@gmail.com>
References: 
	<9205ed32da8814d8c4d9bde5a03d92c7588f1d9a.1708503094.git.dmitry.kasatkin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3-1 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-02-21 at 10:11 +0200, Dmitry Kasatkin wrote:
> Currently libimaevm provided by this project is used by the tool evmctl,
> which is also provided by this project.
>=20
> An issue was reported about using libimaevm with other software. Its
> GPL2-only license makes it incompatible to use with other licenses, in
> particular GPL3-only.
>=20
> To address this issue, change the project license to GPL-2.0-or-later
> and libimaevm to LGPL 2.0 or later.
>=20
> Signed-off-by: Dmitry Kasatkin <dmitry.kasatkin@gmail.com>

Acked-by: Andr=C3=A9 Draszik <git@andred.net>




