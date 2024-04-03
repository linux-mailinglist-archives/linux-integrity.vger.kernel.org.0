Return-Path: <linux-integrity+bounces-1998-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CDA2C8975C8
	for <lists+linux-integrity@lfdr.de>; Wed,  3 Apr 2024 19:00:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D80E1F21558
	for <lists+linux-integrity@lfdr.de>; Wed,  3 Apr 2024 17:00:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4845152170;
	Wed,  3 Apr 2024 16:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="TCCp6BSw"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4AE2150980
	for <linux-integrity@vger.kernel.org>; Wed,  3 Apr 2024 16:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712163596; cv=none; b=tZRbmsKhv5m8OG9YJyM64Fc6hge02n/Mva+ZdtHCnhnMie1aobJU1G/z2K5CUWnWbcxiRZDVJRbk9l6yub2P1omU/uOFoSLM+aSbSNKtMGWtcQxlUenNiYiZeg0SIOlRc872fbqDItkcqPYvQ26RzusaFowB0Php4ReE4QYL2FU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712163596; c=relaxed/simple;
	bh=1QHEDPpqFRVTaMitRFRECKns1ULA3ceFkMwOdLkg8FU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tbUqYyIF4cLqQu8QtqaNW8wRIEB6CxclmPo/LHGCBduDarVxPQGL2YerPHAjZqQYhJxE50Uhav3j3PTBxEJztTUNDefLiDhG6XA3e8pp3eL8M0Cp2yIn3lZRMMYLB5CL9TexM+FPGSVG8lxdta5Kz1Fx8D6/BfH4+xVeqbIZuOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=TCCp6BSw; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a4e60a64abcso203219566b.1
        for <linux-integrity@vger.kernel.org>; Wed, 03 Apr 2024 09:59:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1712163593; x=1712768393; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9zZqVSe49xG+Cuf6x2/pIzSVIeoqPFNTQJEfQlqHLac=;
        b=TCCp6BSwTIKImCa6ejUZOPRl8RsaJEURQMAwwU7IHez/VMYlGRhnn9pSN9ctNafl5+
         6iHtQuJA4ZXkg4Ce42HjQ660rSmAhMRbGLX1VBWYeMrG/P9SYdN7TXCF970dSrzMsUPd
         a2WRC79HWKBeNYRUnQL8ddgSmlswDktck7p7k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712163593; x=1712768393;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9zZqVSe49xG+Cuf6x2/pIzSVIeoqPFNTQJEfQlqHLac=;
        b=T3L17xYukqx8394Z+bOP40tU4YrGasTohIjLA+b31pTQe/oa2DQmemCVzH3t6iAXNQ
         GNbgsCneY3NGWrcnWX0MuhP1oapr1vaSKY1BpBD08eIvbGtAjCS+1uGLJp9RAFU+/D7F
         IxFpfvdm3jfzAie4b2tK3mmJlbT/dxYrXmMXisC/2ZUy+g3DtE9YPmIrew2E4CLi1uSs
         8FmZQrj/V2VMK3/XVxYI56FpM8glK7VyqAQTLoC6rtg7+lHg9k0VXOUV/dF8Az+gXd6J
         e1jtla8fztp+tJG491ZPI6QJdZgiNUSb+sF57A3hilUNGjuSQiHq1UzIUNx7cLqagp+X
         2hWA==
X-Forwarded-Encrypted: i=1; AJvYcCUT2Do+mlDxljsURcUXvpmG+QUVFgZ2RZm+Xj8+TCHFnjfyOe1BcChkLPv+iQQvOhdqZz8dD78xWG2ZYlHK0UM/jQTU1VEaVtq5NwK2Fbfr
X-Gm-Message-State: AOJu0YwP0qziFYJUNxq7N4rtQjgTF2dQwl90cJIrJ4s7ca5QFfdlCdQF
	6U848eFN4hWTF1kYWtcthPJp8HZdcpMmzS4AynOWIeozSHpVX28MfW6WA1CJqG0PaLvutrLA9hx
	HqCom8w==
X-Google-Smtp-Source: AGHT+IFJ5GV7jK77Ob03XjqNi2qej+nlGaawXcl1UjTY2pzN3c6YiKHAOVuDUwwtkeljhD68ptxpwQ==
X-Received: by 2002:a17:906:d787:b0:a4d:f681:c964 with SMTP id pj7-20020a170906d78700b00a4df681c964mr2775568ejb.28.1712163593221;
        Wed, 03 Apr 2024 09:59:53 -0700 (PDT)
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com. [209.85.218.42])
        by smtp.gmail.com with ESMTPSA id bo2-20020a170906d04200b00a45bb14b1a5sm7919510ejb.89.2024.04.03.09.59.52
        for <linux-integrity@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Apr 2024 09:59:52 -0700 (PDT)
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a4e60a64abcso203216966b.1
        for <linux-integrity@vger.kernel.org>; Wed, 03 Apr 2024 09:59:52 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWDsDPcSBR/IyMkmfkC5jtO5eU2xyMzuguvYoizx4xqZ2fCm4mQMRcZtL1MmY/HF34zSDN4kDF68d67uzm+BUCaQBiQsJs/1rLqt48OoS6s
X-Received: by 2002:a17:906:4f0f:b0:a47:3afd:4739 with SMTP id
 t15-20020a1709064f0f00b00a473afd4739mr2945922eju.6.1712163592316; Wed, 03 Apr
 2024 09:59:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240403090749.2929667-1-roberto.sassu@huaweicloud.com>
In-Reply-To: <20240403090749.2929667-1-roberto.sassu@huaweicloud.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 3 Apr 2024 09:59:36 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjG-V-9USyDTWqUhY7YxEwSfwC9yA7LJkT7uGbHHFZeYQ@mail.gmail.com>
Message-ID: <CAHk-=wjG-V-9USyDTWqUhY7YxEwSfwC9yA7LJkT7uGbHHFZeYQ@mail.gmail.com>
Subject: Re: [RESEND][PATCH v3] security: Place security_path_post_mknod()
 where the original IMA call was
To: Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, 
	paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com, zohar@linux.ibm.com, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-cifs@vger.kernel.org, 
	linux-integrity@vger.kernel.org, pc@manguebit.com, 
	Roberto Sassu <roberto.sassu@huawei.com>, Steve French <smfrench@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 3 Apr 2024 at 02:10, Roberto Sassu
<roberto.sassu@huaweicloud.com> wrote:
>
> Move security_path_post_mknod() where the ima_post_path_mknod() call was,
> which is obviously correct from IMA/EVM perspective. IMA/EVM are the only
> in-kernel users, and only need to inspect regular files.

Thanks, applied,

              Linus

