Return-Path: <linux-integrity+bounces-6381-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EBECCAD1A1E
	for <lists+linux-integrity@lfdr.de>; Mon,  9 Jun 2025 10:58:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0FB43A662B
	for <lists+linux-integrity@lfdr.de>; Mon,  9 Jun 2025 08:57:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8EC524676B;
	Mon,  9 Jun 2025 08:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cKsRQe6d"
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17DC741C63
	for <linux-integrity@vger.kernel.org>; Mon,  9 Jun 2025 08:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749459488; cv=none; b=P+HBL+A/zQTpHdqKcIobJy9W7sxXQoPHR3pbdJydLB0OWkW330WtloTqRljAISCPq4kd/ZacTK+xTpyHvXbBDw0DqL7huMJnRa32iT09xu7PPd/CgeaHyrJdPRvJiob2Tn2UCEwf/wofzM4s3M+zbkoLTh8jYl80LmugFx/68oM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749459488; c=relaxed/simple;
	bh=tObexuNu5puy0S/zrHD6bJ96PlTpeqIfPPG17mA0siE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=en1nLGI7TO3ogIH6baki/746aGf51r0+ukW9SoTeOrHeJGDmvmJloDLgV7uzLHk5aaWF5lrLsIG9sPjTlBxwAtvZGbmC1dPi3XCbvPomVm8qCMjLSKo6aWT5jwSkdit0PAh+uqze+iTy1Xv3JKhBzhTq59LF+qozYEmcHxi9GpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cKsRQe6d; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749459486;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EAX9gR6Ry+BCiLbmBNWFHsPfQj/lBkDp4XOdgquTNsY=;
	b=cKsRQe6dUTDzZ/u7ywx5Hh+KHOVIw4dLuQUWZkZXaJkI7I4nggKjmF+i2W/Aq8TPbHAA/J
	87Q25IWnG06oCMKbXQK3JqP0pNvUkIXXXjncduR8aXvUSaWLrzgsWHs/YRqj9THmOqha+C
	4qua3RKkow0D6VoTV0sVEBT1ML61GRU=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-418-p1Vv1kFZMk-iF5UK-JIaXw-1; Mon, 09 Jun 2025 04:58:04 -0400
X-MC-Unique: p1Vv1kFZMk-iF5UK-JIaXw-1
X-Mimecast-MFC-AGG-ID: p1Vv1kFZMk-iF5UK-JIaXw_1749459483
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3a4f7ebfd00so1476483f8f.2
        for <linux-integrity@vger.kernel.org>; Mon, 09 Jun 2025 01:58:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749459483; x=1750064283;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EAX9gR6Ry+BCiLbmBNWFHsPfQj/lBkDp4XOdgquTNsY=;
        b=ZZHsSmtr9nN2NARKigxnuJywl79kfqiQhPsMxColQV+u7ThZLkRRf4IWYjRZMJucq0
         ElxawW9bCWoZn+ZmJ7T9sV9yu7+JTqHGZroId6eDzFc04ZiiwKmD0fO8y8WMDu/Gqh/e
         aJAsRjlSHRHGk5iAgxSZrCLjvwE76L3MvYSsEykPnytcyMDKMxcSRgfdcbgx7ARyHfJr
         4ljLQuaDPfwiG5scUQwEMlT9deTdreLz8AJdjnNyhUHQNu2Qsju5yzkBbYeoc9dOJCz0
         Sbj2CIyioVC58HcxaCnLmwPKKlWGsBreBgl9EUOFS+6gI42G3qVM/6QB2wMdz9patVVS
         Oc1A==
X-Forwarded-Encrypted: i=1; AJvYcCWRVR/X2CbqsdjiXUBLkpXnAZ3W52Nhlok1WYfHv9TQ8aE0hHa+MvEkkXsiaEGr1y7Nz5/J+jjNeHIeB+mbdCs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzT+OKfj0iZ9nIddQ2MNKoIMzFiBvnmhmB0txFTPffYWwZcjB+i
	ZlLBhhzK+7/gZtRG1cHosNcwVbeDoxB4OJceYCWX52rVJYqOPjeTDtkSIC7Q3f5Wz4qNeU4HNiN
	bP71AOa8CY88wHaaWYdnV+b46iVRKKE9WVf2yBv+XBDmGC/BHp287Srr0vb9c3q3fX5Mm2A==
X-Gm-Gg: ASbGncvXw33aWhvbfBeQMmkM/UfRy6KcE6AvtFhhr53mlQbkW7A10RSkbIg85nCzFdU
	IXqA9PyN4SHUmIwJ//8F2xe3JyQvzeAr5lFHIlyuS8LrtvVK5ftagzFnHFjC3bVagsmNdrzWAbv
	fyfH000ba9bAndK01S9fdQbAhu6NXg8xHh73XDvua93Q+hwy8pJnTyf8ef0M1mkwnR0z9MoThNy
	+aws7nf2/c4kmEaxEjFzEDSIEYONeXYNTMg4W6FnnQyb6unC41tm9j1qSQUrh3iNDrMlSHZAoKP
	6PZBsSE=
X-Received: by 2002:a05:6000:420a:b0:3a4:fc37:70e4 with SMTP id ffacd0b85a97d-3a531cf5be1mr8000740f8f.58.1749459483397;
        Mon, 09 Jun 2025 01:58:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEGKstU+gvDYJRoCuhWj9Uy3B0R5FuTJdpuAKJpWIzyKGQze6gxwv3jbQl0SI7KqRYCXE0l/g==
X-Received: by 2002:a05:6000:420a:b0:3a4:fc37:70e4 with SMTP id ffacd0b85a97d-3a531cf5be1mr8000722f8f.58.1749459483016;
        Mon, 09 Jun 2025 01:58:03 -0700 (PDT)
Received: from fedora (g3.ign.cz. [91.219.240.17])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a5323be604sm8881091f8f.42.2025.06.09.01.58.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jun 2025 01:58:02 -0700 (PDT)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: James Bottomley <James.Bottomley@HansenPartnership.com>, Eric Snowberg
 <eric.snowberg@oracle.com>, Peter Jones <pjones@redhat.com>
Cc: "linux-security-module@vger.kernel.org"
 <linux-security-module@vger.kernel.org>, "linux-integrity@vger.kernel.org"
 <linux-integrity@vger.kernel.org>, "linux-modules@vger.kernel.org"
 <linux-modules@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "linux-doc@vger.kernel.org"
 <linux-doc@vger.kernel.org>, "keyrings@vger.kernel.org"
 <keyrings@vger.kernel.org>, David Howells <dhowells@redhat.com>, David
 Woodhouse <dwmw2@infradead.org>, Jonathan Corbet <corbet@lwn.net>, Luis
 Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, Sami
 Tolvanen <samitolvanen@google.com>, Daniel Gomez <da.gomez@samsung.com>,
 Mimi Zohar <zohar@linux.ibm.com>, Roberto Sassu
 <roberto.sassu@huawei.com>, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
 Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, "Serge
 E. Hallyn" <serge@hallyn.com>, Robert Holmes <robeholmes@gmail.com>,
 Jeremy Cline <jcline@redhat.com>, Coiby Xu <coxu@redhat.com>, Gerd
 Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH RFC 0/1] module: Optionally use .platform keyring for
 signatures verification
In-Reply-To: <a9bb8b0cfd1af85443ff8ee615b3be0fc705ce02.camel@HansenPartnership.com>
References: <20250602132535.897944-1-vkuznets@redhat.com>
 <0FD18D05-6114-4A25-BD77-C32C1D706CC3@oracle.com>
 <f0b37bc55ed3c02569c74f0fbdb6afa8efd329e2.camel@HansenPartnership.com>
 <87zfemoc76.fsf@redhat.com>
 <e4e838d03b3619df5523d429e0cd8160a8aef9f8.camel@HansenPartnership.com>
 <87tt4unw1w.fsf@redhat.com>
 <a9bb8b0cfd1af85443ff8ee615b3be0fc705ce02.camel@HansenPartnership.com>
Date: Mon, 09 Jun 2025 10:58:01 +0200
Message-ID: <87ldq1nvfq.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

James Bottomley <James.Bottomley@HansenPartnership.com> writes:

> On Thu, 2025-06-05 at 15:43 +0200, Vitaly Kuznetsov wrote:
>> James Bottomley <James.Bottomley@HansenPartnership.com> writes:
>> 
>> > On Thu, 2025-06-05 at 09:54 +0200, Vitaly Kuznetsov wrote:
>> 
>> So far, I got two 'runtime' ideas:
>> - Observe MokListTrustedRT and distrust .platform when it is
>> non-empty. This can, of course, be combine with a Kconfig for those,
>> who do not want it at all.
>
> Well, not sure about that specific variable.  It seems to be set but
> not used by shim (however it is used in the kernel to decide whether to
> import the MoK list), so how would someone with a current distrusted db
> get it set?  But there's also MokIgnoreDB (which is actually a RT
> import of MokDBState) which is used to prevent importing the db certs
> into the platform keyring in the first place.
>
> I think the reason this is so fragmented is because we didn't really
> co-ordinate with shim when all the variables and switches were added. 
> Perhaps we should document all the variables and expectations before
> deciding on a mechanism? 

I was hoping Peter (pjones@) can help us here) Generally, I agree that
as these variables originate in shim, we should describe them there and
not try to give them some potentially undesired meaning in kernel.

>
> The one thing we can guarantee is if the cloud use case is booting
> without shim (is it?) then none of the RT variables will get created,
> so checking any (or a set) of them would work.

Personally, I always advocate for injecting shim in the boot chain at
least when distro kernels are used: shim provides SBAT revocation
mechanism which is likely going to be used when a new secureboot related
vulnerability is discovered. SBAT was used for UKIs only but a mechanism
for embedding it into the Linux kernel itself is coming (already merged
for 'zboot' arches, pending for x86). If, however, someone is signing
his own kernels and can use 'dbx' or even revoke the cert in case of a
problem, then I guess shim can be avoided.

>> and/or
>> - Sysctl toggle. Keep things as they are by default but make
>> .platform trusted (either for modules or for everything) when
>> switched 'on'. This can (optionally) by combined with a previous idea
>> and have e.g. an 'auto' state for the toggle which follows
>> MokListTrustedRT.
>
> I'm less keen on user specifiable runtime because the security policy
> of the system using a lockdown to make root less privileged than ring 0
> can't allow a malicious root to weaken it.  However, let's see if we
> can get a proposal that would mitigate that concern.
>
> Ideally, if we can get to something that works for everyone at runtime,
> we can remove the current Kconfig explosion which is definitely adding
> to the confusion (as shown in the Debian bug reports).

-- 
Vitaly


