Return-Path: <linux-integrity+bounces-664-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FD6D82546B
	for <lists+linux-integrity@lfdr.de>; Fri,  5 Jan 2024 14:25:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 91166B22CA6
	for <lists+linux-integrity@lfdr.de>; Fri,  5 Jan 2024 13:25:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3291F2D629;
	Fri,  5 Jan 2024 13:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GGmAB5a1"
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CF8B2D602
	for <linux-integrity@vger.kernel.org>; Fri,  5 Jan 2024 13:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704461118;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=X+N2QN09tRy41VD5NIYroenQi57udRymfLPwCbxVPuM=;
	b=GGmAB5a17meogvAcRiiMEnTipLtzD51957YlTocFfDEal3vmf/Rs/Hda6p/u3oGMD8oToC
	chfhZwSb3VLN2z3KypR/ehua4y+HgoPo/5XdeBcgnVBksr+p2CtoJezvvLa3VUTjxJjs6q
	4kvAkDqkGU1VIQZmQVs9VqUvZpNlrkY=
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com
 [209.85.166.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-600-K641ItTYNMqPRvBlezpnIQ-1; Fri, 05 Jan 2024 08:25:17 -0500
X-MC-Unique: K641ItTYNMqPRvBlezpnIQ-1
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-35fd673f361so15423405ab.3
        for <linux-integrity@vger.kernel.org>; Fri, 05 Jan 2024 05:25:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704461116; x=1705065916;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X+N2QN09tRy41VD5NIYroenQi57udRymfLPwCbxVPuM=;
        b=QWeyirBfI1o+22fg8M/HnQxf3nRXL4JxtPEYoo94fOB3qRAUoYVk3azQ5UpSU6IOwf
         8zCf/J6c5GmKjaTD4ubY/XYAkeNdZbP4MZWpVA5zkgFLRUlEWbWrsUzVW0L/VfwmgJhE
         zMA9/SX1dw6KupmCvVKVianLoi2LfphzH19FVnoh/B/JWTISmtC3pOlkiXxkS9HBobVD
         mlBgxNhP521Ehn9X6TfQTe90fj3JYacL+kZIiVeG3H5nKZ1/fEfvNNaBu0vg1Hia1obW
         Nb6W+TsfjPA2cwDFv03YCNrhozOvOTWMoxZ3Jao11WmKSRoIjE6QNWAVgyGii/XjP4yE
         9ZBw==
X-Gm-Message-State: AOJu0YxaaRTrhUt7NNhmnNSOsOJuWMO+aYpEdIvKYgdo63bIxccb/9Mq
	yHHGttsn1mEcpiRKL6hZiCXxGwPNVeOKRiGyYze7DAP09qDTKILRaLpi27RCxj67Uh07wKjlSEJ
	3ElRUkkOa3tqaV+LaHm+Vnrf2KbTjFzwXQiRq
X-Received: by 2002:a05:6e02:1788:b0:35f:feb7:35e5 with SMTP id y8-20020a056e02178800b0035ffeb735e5mr2486077ilu.69.1704461116337;
        Fri, 05 Jan 2024 05:25:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGUPQheyiFfY5luVUQI5Mu+aTbDrNLu5ERwC9srQCSZz+wyviXhwj8/teWqfyQ53IB+42HnPQ==
X-Received: by 2002:a05:6e02:1788:b0:35f:feb7:35e5 with SMTP id y8-20020a056e02178800b0035ffeb735e5mr2486069ilu.69.1704461116035;
        Fri, 05 Jan 2024 05:25:16 -0800 (PST)
Received: from localhost ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id q68-20020a634347000000b005cd821a01d4sm1383371pga.28.2024.01.05.05.25.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jan 2024 05:25:15 -0800 (PST)
Date: Fri, 5 Jan 2024 21:20:45 +0800
From: Coiby Xu <coxu@redhat.com>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: linux-integrity@vger.kernel.org, itrymybest80@protonmail.com, 
	Mimi Zohar <zohar@linux.ibm.com>, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, 
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, 
	"open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Subject: Re: Re: [PATCH] integrity: don't throw an error immediately when
 failed to add a cert to the .machine keyring
Message-ID: <43dozoqfip7m6nglbwzwyzykx23fpzbp7d42pcqzudnzlfvfkb@yjvuo5a6suvv>
References: <20231227044156.166009-1-coxu@redhat.com>
 <CY54Q6U6UMKM.2H5N3BACDBGU0@suppilovahvero>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CY54Q6U6UMKM.2H5N3BACDBGU0@suppilovahvero>

On Wed, Jan 03, 2024 at 04:09:29PM +0200, Jarkko Sakkinen wrote:
>On Wed Dec 27, 2023 at 6:41 AM EET, Coiby Xu wrote:
>> Currently when the kernel fails to add a cert to the .machine keyring,
>> it will throw an error immediately in the function integrity_add_key.
>>
>> Since the kernel will try adding to the .platform keyring next or throw
>> an error (in the caller of integrity_add_key i.e. add_to_machine_keyring),
>> so there is no need to throw an error immediately in integrity_add_key.
>>
>> Reported-by: itrymybest80@protonmail.com
>
>Missing "Firstname Lastname".

Thanks for raising this concern! I've asked the reporter if he/she can
share his/her name.

-- 
Best regards,
Coiby


