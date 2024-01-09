Return-Path: <linux-integrity+bounces-703-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E233827C1A
	for <lists+linux-integrity@lfdr.de>; Tue,  9 Jan 2024 01:35:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DD1E2B22DD5
	for <lists+linux-integrity@lfdr.de>; Tue,  9 Jan 2024 00:35:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ABF1819;
	Tue,  9 Jan 2024 00:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hg0sPdI/"
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72DC7375
	for <linux-integrity@vger.kernel.org>; Tue,  9 Jan 2024 00:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704760518;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ARMX4HM6itdBlTBKVKSEXcT1ilseNu4Nvq2nBbOEvW8=;
	b=hg0sPdI/JzE5QqFTLZ6Q4a6nYm4go4/zGBl3ZqPpTDvRxgyrHz0pXJHQQgQcDpawILzpSe
	A5Qp2sjp9nQOQVwES7NTW8rRyj6qzi2fJeb+QPSOwfnaJZtR+YJw2Fej5MSTC2itToQ7Ms
	q9vSq4GgTtBRt3S/j6XfFE90KEXIpBo=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-564-TdPLpGZ1ODmVy4yGyeEQqA-1; Mon, 08 Jan 2024 19:35:17 -0500
X-MC-Unique: TdPLpGZ1ODmVy4yGyeEQqA-1
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-6d99506e2e7so3009334b3a.2
        for <linux-integrity@vger.kernel.org>; Mon, 08 Jan 2024 16:35:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704760515; x=1705365315;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ARMX4HM6itdBlTBKVKSEXcT1ilseNu4Nvq2nBbOEvW8=;
        b=DLrLRtav2YlL2PBZ5zG/LgQaMAtphVGVrTMpsw6PQvb8s3f62PBakt2Gdtxz/0Pb3d
         oDkU/RwNzVgflyhAP308X/A0gKUn5i+W4JdaQwG4L+/uPncp/4jGH5Zu8Xq08uzu+uWU
         Pqe+av3AiSJwjyQX0McqtD80YCjbK8RJKYlpdyoac+SZoYDs/qFv0qi96rZnjYhGu/AA
         ugwLp8TOyoTiqQy9fM9PzP1MmaLFt8OOvlCatMKFhxMn5iRtp4M0qGGMIWVazXhfErIl
         +J7/t7pJrPz7iwI8AXi+Cl2nA0ahppfZ0lplXeTZ3oNLOwWfB9XF/3x2tcA55dHTPnJi
         2P+Q==
X-Gm-Message-State: AOJu0Yy0+YPAkTyf4JQhgMvSKSQAiJo7UQuvTkYWqvXnqG0q6+2tTjW+
	HOLDNS4ptCd2UIDQ3Ff+Tm7QnVOBf1RPIGkJJ7bWX+DZtuwcX4hgeZya8Sa9//bSEG9tSNGaRek
	s2lQKu7X5Rb8EjrhL/5/555y278IqejLM2LSIf0SlyuoYIQBDvQ==
X-Received: by 2002:a05:6a20:65d:b0:199:f2ef:8282 with SMTP id 29-20020a056a20065d00b00199f2ef8282mr122302pzm.100.1704760515682;
        Mon, 08 Jan 2024 16:35:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFpvMu4Ls9SGUYo6jmphzFnSHZMJQHYOZu5gp20jJVmFV8u2Z+IYHNt7UlyuoeL2/n3onexSQ==
X-Received: by 2002:a05:6a20:65d:b0:199:f2ef:8282 with SMTP id 29-20020a056a20065d00b00199f2ef8282mr122295pzm.100.1704760515363;
        Mon, 08 Jan 2024 16:35:15 -0800 (PST)
Received: from localhost ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id b15-20020a17090a12cf00b0028c89122f8asm553134pjg.6.2024.01.08.16.35.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jan 2024 16:35:15 -0800 (PST)
Date: Tue, 9 Jan 2024 08:30:03 +0800
From: Coiby Xu <coxu@redhat.com>
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: linux-integrity@vger.kernel.org, itrymybest80@protonmail.com, 
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	"open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Subject: Re: Re: Re: [PATCH] integrity: don't throw an error immediately when
 failed to add a cert to the .machine keyring
Message-ID: <vzys7y22d7zduhcrlqojnavcad5zvxde4axdsgrfpwn3u557iz@cnjbuwkfqiur>
References: <20231227044156.166009-1-coxu@redhat.com>
 <39e5612eb2d4dea2759310ccce39c1ad40b5388f.camel@linux.ibm.com>
 <35tiggwgbrb2sapyykv3umio5l2xqhmzc43wy33dxmz4hyu24c@bprgz7skpxma>
 <16ae3e51dc4eeb2b2e674b8ff1051ac315fa492c.camel@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <16ae3e51dc4eeb2b2e674b8ff1051ac315fa492c.camel@linux.ibm.com>

On Fri, Jan 05, 2024 at 09:59:14AM -0500, Mimi Zohar wrote:
>On Fri, 2024-01-05 at 21:27 +0800, Coiby Xu wrote:
>> On Tue, Jan 02, 2024 at 12:54:02PM -0500, Mimi Zohar wrote:
>> >Hi Coiby,
>>
>> Hi Mimi,
>>
>> >
>> >According to https://docs.kernel.org/process/submitting-patches.html,the
>> summary line should be no more than  70 - 75 characters.
>>
>> Thanks for pointing me to this limit! How about
>> integrity: eliminate harmless error "Problem loading X.509 certificate -126"
>
>Still >75.   How about the following?
>
>integrity: eliminate unnecessary "Problem loading X.509 certificate" msg

Thanks, v2 now uses the above subject. I thought the limit applies to
the "summary phrase" instead of the whole "summary" and a second look
proved me wrong. 

-- 
Best regards,
Coiby


