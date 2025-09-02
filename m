Return-Path: <linux-integrity+bounces-6994-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C4F4AB40DB4
	for <lists+linux-integrity@lfdr.de>; Tue,  2 Sep 2025 21:13:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94B1716AEF2
	for <lists+linux-integrity@lfdr.de>; Tue,  2 Sep 2025 19:13:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DCEB2E22AA;
	Tue,  2 Sep 2025 19:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HuSwbJw3"
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DF3C20E00B
	for <linux-integrity@vger.kernel.org>; Tue,  2 Sep 2025 19:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756840382; cv=none; b=aHPD5R6pczjVfLDoKZdYaG7mnnMccuhrZD1vdL54Jz9nIMicjDWfs1wi7DStykMzyEhmAu/h2PKha8do8T/8fpoA9F3g9B4dUPoBY2KsUpWWbB4UFk4oHPAYCJBPrNygYj+y3PRX3I6uP04XLxR/3p3OK1YRunrFd4F+0qp62PM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756840382; c=relaxed/simple;
	bh=kKKJ/QgYbDPHwYtsulQ6l5VwQ3t2iD7IUKusBvrrMj4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N4KYfxz9eSrXCY9V8f5+ZcfW1+ze2pZw9Q9lpqsV9i3cKAHWTkl55/s/6hYBjxp5T8C++Szk0YZnear7J1Sine88ykd3zHMIo76Grp0bTYefo7gnEe3plTGQhLV/Sy1tM0CgUUj8O8MW4Jm15VB54HvCC9VKT4VGmERPpZu6+Yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HuSwbJw3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756840380;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kKKJ/QgYbDPHwYtsulQ6l5VwQ3t2iD7IUKusBvrrMj4=;
	b=HuSwbJw3xCF10ZVekM6FA+jpoAn8ZpI+ZXZhGM8O5nWb2lGoeguR6MPEQmn7RZ/BMCFAHp
	psuK/p9QapDEOcNUlHuKBfIsQ5XCnDlRcRd4Yarsu0fRBoHl3Sy/zOHzF1BnDgXPpTvw33
	ouSj7pRjOXgVsJDX3qC4Dj01nrp8EmA=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-315-PuKLBKR3OHSvthOvbg6kkw-1; Tue, 02 Sep 2025 15:12:57 -0400
X-MC-Unique: PuKLBKR3OHSvthOvbg6kkw-1
X-Mimecast-MFC-AGG-ID: PuKLBKR3OHSvthOvbg6kkw_1756840377
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-7238f75daa8so24816437b3.3
        for <linux-integrity@vger.kernel.org>; Tue, 02 Sep 2025 12:12:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756840377; x=1757445177;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kKKJ/QgYbDPHwYtsulQ6l5VwQ3t2iD7IUKusBvrrMj4=;
        b=aNiRDa31phBNGI2aRYYcRY5UgRviSx37wzvQoUvHhMgC7hhjy4B5UVh4s5XGZOTo16
         gmxOZWOLu6qIAHymyTYuE0NXNPVPmnliZK376nJfDgUYIhWckKx1ChoibB95+8TbOPXC
         UI+EK6hmbdDOGrV4HgIBSo9JKRbru75GvDVlZCbF6jrjbzpcI+qHeV3ZC5AMgxEX1hgi
         Dlj+VRnUftc+kQWkDgsMBJWJXgiB1sGXJLcVQDWqOm9HygAqrAy/33IYkIQaKlOzfsC3
         cv497MWDk5cfLcD6y7NXXYHiwCuQVZxCmqQv6ixacGNz22K06ovDFSU2YdbK+WNwfDFh
         +NcA==
X-Forwarded-Encrypted: i=1; AJvYcCUHPB3tDOQwkNUTSkZz9/Caeg3vikjmTxTHJzXfStNJHUC6oz3GwzGhFKOFBEJmU+7untyXu+B0mbV63NMIHM0=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywv+yojzgQ4QJawxH0pN2yOyMr4Qdrsf4fYPPMQJZjI6nVAcI3g
	dn+glv9q5MynySVmPX63g8rjVYg7gqH+D/av5aGoZOtGvWKpRhckpkk3RpcsRcM9vAuiFDg9m/B
	LCWMDWd8/1UmHeMldc5+cRRwk/R4sHD2AY+eBtI5YjIhSOD/1MNvci0XjSlMEZf6uueaXFgNlH5
	vjjlbx95xiCpfO+T0I0KQJHWFeUX6A1VzdLcJ07U6Vi0Wv
X-Gm-Gg: ASbGnctVrQAm1ZrmKekS7xQO2pm5+cGV+HMDgE5J1navqByudIPz1tvgHo/VRQKyia5
	2m7wbm+zxZgcrmR6vwwUkWgdtzdKNEDXXAnniSpcujdP2+BO7kzcH9CQ0BixLZKBWzK7GpwX4dC
	jIXqtECKVpZBTRBjKQyqxk924gM4saTniR2Dvyw0npKKEnEpiOTa8/wg==
X-Received: by 2002:a05:690c:17:b0:721:1105:e84e with SMTP id 00721157ae682-72276337a5amr178089007b3.10.1756840377188;
        Tue, 02 Sep 2025 12:12:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFN9uoxn1xfAaBIhL+EFnFMM6g2Lw4yDYUSycTRkZi1jU/ymY+/rEsHMqFOdB8Ztyad3guY3NaJPdGrkXspzf8=
X-Received: by 2002:a05:690c:17:b0:721:1105:e84e with SMTP id
 00721157ae682-72276337a5amr178088797b3.10.1756840376816; Tue, 02 Sep 2025
 12:12:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250902142429.14041-2-daleksan@redhat.com> <aLcl2SzTc_nTX56u@kernel.org>
In-Reply-To: <aLcl2SzTc_nTX56u@kernel.org>
From: Denis Aleksandrov <daleksan@redhat.com>
Date: Tue, 2 Sep 2025 15:12:45 -0400
X-Gm-Features: Ac12FXz8Up6a8q3UFB1frRYX37q08qsjVZjqBBJWEGxyAqAnhjfChMXsHL6ZwFs
Message-ID: <CAG+gbFeYuxVbo+RY9Ux-zysO76Q9yiD5DfD4e4cwNxX-VgfKWQ@mail.gmail.com>
Subject: Re: [PATCH v4] tpm: Prevent local DOS via tpm/tpm0/ppi/*operations
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: peterhuewe@gmx.de, jgg@ziepe.ca, linux-integrity@vger.kernel.org, 
	Jan Stancek <jstancek@redhat.com>, Paul Menzel <pmenzel@molgen.mpg.de>
Content-Type: text/plain; charset="UTF-8"

Great, thank you Jarkko!

Could you please take a look at the most recent reply from Paul in the
v2 thread for this patch?
Should I move forward with the advised changes and send a v5?

The concerns were:
- Adding info on how to test and debug the code to the commit message.
- Reverting the "Blocked by OS ..." field in tpm_ppi_info[].
- Reverting the conditional in tpm_show_tcg/vs_operations()
and sending in a separate patch with the change. The change was
concerning displaying the "Not Implemented" status by updating
`ret > 0` to `ret >= 0` in the if statement.

Please let me know what you think.

Thanks again,
Denis


