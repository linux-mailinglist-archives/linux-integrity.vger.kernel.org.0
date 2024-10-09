Return-Path: <linux-integrity+bounces-3760-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D08B997041
	for <lists+linux-integrity@lfdr.de>; Wed,  9 Oct 2024 18:01:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AFF8EB21C0C
	for <lists+linux-integrity@lfdr.de>; Wed,  9 Oct 2024 16:01:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 880541F12EC;
	Wed,  9 Oct 2024 15:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="RmzLyaxN"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B95471F12E0
	for <linux-integrity@vger.kernel.org>; Wed,  9 Oct 2024 15:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728488175; cv=none; b=lsAxLpuuy4wBHiaS4UXbYJTXUvY5aCLh5RshuEwG9YG6gnm70Zv9GPAdr9Y3ccvmlbHnWbt5n+VrkBMKwKzozPNvGdRqUthp9QL7d1CFeBR/LEEdi3zm0bDB34fCGvf7OQVXnzvWu+4rAh5U8iz1EiINwIDO0D1AhepLUNfEsKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728488175; c=relaxed/simple;
	bh=t0jsWZVzZQn+sDURCRyRKujF2TOyMfjajxg8xq74q88=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cnjuQe07fjVq5Spcr1Hh6Ifa5NClZejZ81hWV3W2XJATaCFE9WagKjrre+cEn5p0zkxD0FnakwN6pDT0kGjmhQU9q8wqGiAAhTkOA4QEIgg+W/uesf1Phl4DuZLvN7Rxjj39818hjjE79qQrsten8VFn9DDe/szpD/vmYC7oWOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=RmzLyaxN; arc=none smtp.client-ip=209.85.217.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-4a3c6bc4cecso1883641137.0
        for <linux-integrity@vger.kernel.org>; Wed, 09 Oct 2024 08:36:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1728488172; x=1729092972; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qhu38DngzJNXLHykf9yFte9ZgoMKMY8LdzsSZdaHnjk=;
        b=RmzLyaxN8sjmApq7cFcKSo1Uaq6ZkYzM6NlPIxyfD0/RdCDtQ13ddThIM6RP20+woc
         jez37ghbj+ugxPTXZtaOAkxNK1EZhGF3PMswEAJnuyzsrRUsiKBTcpD244KjJBvQk1lu
         w6+LQJceWk7N3Gh+xb0on8+M/6X4QY4A0HdUtITtEZgu89DTKyMdwx81SysyzpWBlwMo
         mdXiah6rIZ78AZ3J1quvMBSpj0OjVOKn91fLf+N7pn/OkiOT+Hle6xI+CXaswtTDk1ki
         X7K928R0rHMWEflw1EbVeOjMnEJaHSgXNoL/5xGjVuhLGCc3w9ZVPiMgE1jPZUbrEwzb
         PJDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728488172; x=1729092972;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qhu38DngzJNXLHykf9yFte9ZgoMKMY8LdzsSZdaHnjk=;
        b=caYkaJs79NK1tSGKe0sYrcNPmB0nOrhaW2870W5joaVdTBuH1MqSkjwl5+S0l9m57T
         YzAinZzHKM2ogJtx/LJMTuvwyw29reYG8p9wW1vC53GA2KlvWz7G5TGGOQspt+coGQmC
         zqAvsCSynmRsV2fa+SA2eEZeRIzoYYs63/dIQuQrlsUXXwSBqS/2JOnCbH8pZAqRtNPn
         6Xr55xOlZOu3xpQ1lZT1ZL84C0OwDTFywzDhaTSbS4Uuq/ukqlsJsTJ7aK+tF809QFG4
         GRbTkJH1ftD7BMIJWa9y6/y15VxBr6xpHXT+0EyM0DPRjB6A8MDQ/hU8N3J+MyInWTrM
         uiuw==
X-Forwarded-Encrypted: i=1; AJvYcCUsmwxyrzS1JTo36bfQIJ+3GYq4fz5Z1l6DWeCdGm1hR048tjQn6Zks51J26iCiTNCUcg7/MEDM7oOG06AURYo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNPZmlRBK7h1ZVobuEdX658BmVs9gWm4dyw0V2z7+MEtY+u6DK
	kAwyXMg1EeUIQU9odxY+cx9JNlNTgoT6mahZINbRb8gd7BIZBIReoOXhSeHrpNCNP2QKvm2lzKl
	npQLIeRUa2g0Tptjm2smnUSnjdtTb1ygNHLB8
X-Google-Smtp-Source: AGHT+IGXhNalhdnG3UgTDQ9dAvTj83wJi/06ycVsl8RL3FYNY25jYKWxfxAzxHyvtp+Cq9de5ucgCU67xNjnkIFk4Ug=
X-Received: by 2002:a05:6122:290f:b0:508:1db6:3b5 with SMTP id
 71dfb90a1353d-50cf0c8bb7fmr1934036e0c.13.1728488172555; Wed, 09 Oct 2024
 08:36:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241008165732.2603647-1-roberto.sassu@huaweicloud.com>
In-Reply-To: <20241008165732.2603647-1-roberto.sassu@huaweicloud.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 9 Oct 2024 11:36:01 -0400
Message-ID: <CAHC9VhSyWNKqustrTjA1uUaZa_jA-KjtzpKdJ4ikSUKoi7iV0Q@mail.gmail.com>
Subject: Re: [PATCH 1/3] ima: Remove inode lock
To: Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc: zohar@linux.ibm.com, dmitry.kasatkin@gmail.com, eric.snowberg@oracle.com, 
	jmorris@namei.org, serge@hallyn.com, linux-integrity@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, ebpqwerty472123@gmail.com, 
	Roberto Sassu <roberto.sassu@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 8, 2024 at 12:57=E2=80=AFPM Roberto Sassu
<roberto.sassu@huaweicloud.com> wrote:
>
> From: Roberto Sassu <roberto.sassu@huawei.com>
>
> Move out the mutex in the ima_iint_cache structure to a new structure
> called ima_iint_cache_lock, so that a lock can be taken regardless of
> whether or not inode integrity metadata are stored in the inode.
>
> Introduce ima_inode_security() to simplify accessing the new structure in
> the inode security blob.
>
> Move the mutex initialization and annotation in the new function
> ima_inode_alloc_security() and introduce ima_iint_lock() and
> ima_iint_unlock() to respectively lock and unlock the mutex.
>
> Finally, expand the critical region in process_measurement() guarded by
> iint->mutex up to where the inode was locked, use only one iint lock in
> __ima_inode_hash(), since the mutex is now in the inode security blob, an=
d
> replace the inode_lock()/inode_unlock() calls in ima_check_last_writer().
>
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> ---
>  security/integrity/ima/ima.h      | 26 ++++++++---
>  security/integrity/ima/ima_api.c  |  4 +-
>  security/integrity/ima/ima_iint.c | 77 ++++++++++++++++++++++++++-----
>  security/integrity/ima/ima_main.c | 39 +++++++---------
>  4 files changed, 104 insertions(+), 42 deletions(-)

I'm not an IMA expert, but it looks reasonable to me, although
shouldn't this carry a stable CC in the patch metadata?

Reviewed-by: Paul Moore <paul@paul-moore.com>

--=20
paul-moore.com

