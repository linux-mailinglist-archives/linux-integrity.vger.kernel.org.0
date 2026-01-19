Return-Path: <linux-integrity+bounces-8274-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 89C87D39D73
	for <lists+linux-integrity@lfdr.de>; Mon, 19 Jan 2026 05:16:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2A81230062D5
	for <lists+linux-integrity@lfdr.de>; Mon, 19 Jan 2026 04:16:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1E063FEF;
	Mon, 19 Jan 2026 04:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PG1cylvF";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q1L2wE+8"
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F4872BB13
	for <linux-integrity@vger.kernel.org>; Mon, 19 Jan 2026 04:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768796159; cv=none; b=QGcpZ1ZBgRTziT0cZXOZOoVwShLpAFecIrtPlXKvvUALTyYMBoA+XiKtmplCYhA6iypsvYAvuT1rro2pBgm8U1dOesS8pkoz5B1niyuDqWfAbacw/ckstTdfipahihWdX6cfKPpS1ruqM1yUlgEaid0zoUXSVW2taIJQI6EI2WQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768796159; c=relaxed/simple;
	bh=Q4XorKD5YS6S0fB5vVv5DXfr9ymxSk1r7VwLAiX3vw0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OVJ1e6dxxfT8eRfjC1GYDm1vXP3VK67OaXKr/dHr2rXFwSzaEknSPH/JoWdccE6OPR7LGyIGcp/ZzSe7mJN3Z3WWHnMUGI1NUp9jj199QiDa1MUGrN01hl+aL6/RKHV/jT9w0dNKWOMPS663uYOO1frn4x3pQsr5H3LKgG6FMuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PG1cylvF; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Q1L2wE+8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768796157;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XmVPCf9pEYrflYW5gEcXAfiX8WqXl7WYVPdJt2MNiMA=;
	b=PG1cylvF7bZXecxPi0TgADmid3TgMK+Q1xMpyGiMnRPQRuS585v6IHnqy1wrQMR6l2yKqm
	16C6E9neGY/Q6ga0YMya4K0FcyTgV+7ecPmtR1a7YsZZMNWJRu+sPFiDoCTq4RE8GyJ6rf
	3jeOgDiAQSmo+Zhw3ZStI7qFnjyC4pE=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-628-cns-Qa8JOAyyGw4IS4NlBA-1; Sun, 18 Jan 2026 23:15:55 -0500
X-MC-Unique: cns-Qa8JOAyyGw4IS4NlBA-1
X-Mimecast-MFC-AGG-ID: cns-Qa8JOAyyGw4IS4NlBA_1768796155
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-c552d1f9eafso6369589a12.0
        for <linux-integrity@vger.kernel.org>; Sun, 18 Jan 2026 20:15:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1768796155; x=1769400955; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XmVPCf9pEYrflYW5gEcXAfiX8WqXl7WYVPdJt2MNiMA=;
        b=Q1L2wE+8ntU1v45vftJ+pAHK2o/0MZASQY2JVLqZTlAlydPS1xyjPiJ5WMgxlM2gLJ
         nmv1Eb43Ei5FAKa1KwCHSQM4Xdi513n2joZZ5n1AVRSbRhIWoOBJQH3vjxoeRMGJ7N/8
         goM45+Rxvr1LjzJK63xqVnZCyUor/qWD3Pgijue0XhYLS6VT2y7RYPoR1OS37abujiUq
         G9tweA+d1bL8af97aNPHxq0yb3Mp/h5kbAawIXU+FYLqRRP+NKylAkjOGYtNID8krXsL
         hPCpmUWYs7oQnzaNEFa6IQpO9xkWfsYeYJ4+9MMnS1r5xlQdSvGt/WT5OPVLo8Cd1ti1
         6Www==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768796155; x=1769400955;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XmVPCf9pEYrflYW5gEcXAfiX8WqXl7WYVPdJt2MNiMA=;
        b=sDF20WfdeO3HorcU0i8H3XwCMKp72NpQQNhU2iwdU+C/DtwirqyFFMZS43rN4pjzvQ
         lChF0eJl91o6dzbOwm8vl4xMqCr6WO9L0jT1x1heseD1qWuckkB8aqCdpYDOhmPhTEQT
         59v7Xzp0xqlB+RNdZH/vclCDV53zzlJZO6znSKJsyS7wzxe3ElUGO4T6zlLGnucVTq+q
         uXWi1cjbRDOCCRZnyrtsRjh52Y4RATN9xniSnuepll9QGNLsH/EG/QKjr/JqV7lDP3UF
         ib4dMIuT/J5Wq2AyUNMImrJvnPBjPnANYN8Q6dqgws3TcLkfHxFS1kJswB2GxppPNs4u
         b19w==
X-Forwarded-Encrypted: i=1; AJvYcCUV868x78TqMk5D7qdQrqZLgNMFmIsKHv0IYHPFSAVQYhcu/kTNstvjqQmRnYLQLSTk7VQNSvVncg+EbayQCUQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yya8wTVJ6JcjeVk4thXJ/X3OY7iEWsF+0nHooHqdvbYsz/gPteO
	dOJ/EQag2DWzShAQXtObHRLwysVBi7mwOrzoB0f+LnB2u2pRj3/TKPgvOHGsj0KqS0Z2/Vjg+VW
	3di7XBxrs6ny6uX6XjDcvaCas1bZKWGWKsgYF1NEfJZFh9x9XnG2i0EAofisei1kD4JRSYg==
X-Gm-Gg: AY/fxX7acTe8M/p1xbMlZTgUg/PGfeQbrBEfM+JLHX7gzhXhSQmcfaGcuxSL4Kw7kbv
	3+IWDFOMTLRK5a5V2QF7SZiRY8OjTjOjvjYhyXxL1+2x++pHQXnxLnWTtN2Xi/6SQMVtTWbNzqP
	JkY2K+dOZb3qBZNeXzIo1U6ftHhgsXbzpRWLAryxf4i940mpyRseaqjk89+tUJ6Y2EmiWpw7IuH
	9vLJEfIJ6IT2gHYmwg0L+cSzXsNZcz6MQtkdbgALG4YBV3vIZquqCe5zBBU7LXqZHftdco/aF9K
	zXhJZC37NOJBmq7LToQSX+uInOgzenxr9Fp068TbQ9DmltvT0wF1S+zIDlz84sDus1i3g3TZ82T
	8
X-Received: by 2002:a05:6a21:7103:b0:38d:f226:49fe with SMTP id adf61e73a8af0-38dfe7c307amr9251491637.63.1768796154620;
        Sun, 18 Jan 2026 20:15:54 -0800 (PST)
X-Received: by 2002:a05:6a21:7103:b0:38d:f226:49fe with SMTP id adf61e73a8af0-38dfe7c307amr9251469637.63.1768796154115;
        Sun, 18 Jan 2026 20:15:54 -0800 (PST)
Received: from localhost ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c5edf32d2a3sm5939653a12.20.2026.01.18.20.15.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Jan 2026 20:15:53 -0800 (PST)
Date: Mon, 19 Jan 2026 12:10:54 +0800
From: Coiby Xu <coxu@redhat.com>
To: Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc: Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org, 
	Heiko Carstens <hca@linux.ibm.com>, Roberto Sassu <roberto.sassu@huawei.com>, 
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, Eric Snowberg <eric.snowberg@oracle.com>, 
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, 
	"open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/3] evm: Don't enable fix mode when secure boot is
 enabled
Message-ID: <aW2uAwtNdq3KhsFa@Rk>
References: <20260115004328.194142-1-coxu@redhat.com>
 <20260115004328.194142-3-coxu@redhat.com>
 <522f60ac43b8757c0d7df5df0239190e49f577a8.camel@linux.ibm.com>
 <f38b2512d51351f83c51b6e2b5dec11eb7e6959d.camel@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <f38b2512d51351f83c51b6e2b5dec11eb7e6959d.camel@huaweicloud.com>

On Fri, Jan 16, 2026 at 01:06:32PM +0100, Roberto Sassu wrote:
>On Thu, 2026-01-15 at 13:15 -0500, Mimi Zohar wrote:
>> On Thu, 2026-01-15 at 08:43 +0800, Coiby Xu wrote:
>> > Similar to IMA fix mode, forbid EVM fix mode when secure boot is
>> > enabled.
>> >
>> > Reported-and-suggested-by: Mimi Zohar <zohar@linux.ibm.com>
>> > Suggested-by: Roberto Sassu <roberto.sassu@huaweicloud.com>
>
>Ah, if possible, could you please change the email to
>roberto.sassu@huawei.com?

Thanks for the reminder! I'll use the above email.

-- 
Best regards,
Coiby


