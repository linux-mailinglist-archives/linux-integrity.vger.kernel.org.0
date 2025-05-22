Return-Path: <linux-integrity+bounces-6290-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 62C67AC02C2
	for <lists+linux-integrity@lfdr.de>; Thu, 22 May 2025 05:16:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46C173A9BE0
	for <lists+linux-integrity@lfdr.de>; Thu, 22 May 2025 03:15:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B52B41527B1;
	Thu, 22 May 2025 03:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fUjrZJr+"
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61BA63D76
	for <linux-integrity@vger.kernel.org>; Thu, 22 May 2025 03:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747883755; cv=none; b=rAVR86B5apIEaVo2HK2eUbgXAaUgCdo3/QB8y3b37X/wQ45iVrQGfU6W7HSRA0HwNRqMvkyVHbwHYvkigyzIxlA/TY8jfwiO/I/1TRerHSI60ADqUnlbguwlJAU7ECOXephlxmd4VDzBra3bW27vnGYCreRya7OMcoxfqt8Xhhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747883755; c=relaxed/simple;
	bh=ufrLgZQ485FEvo3uWuTgxV7fGaWGc6qRHQtu+pOXEFo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gVYeZBBj3DWFPL5lNr+a3uPM/rSD1X6soQcRohbXBaArf5H2cMUyWh8nC1+S8Pa/wi1lW+XvE0FyfOUhuJBCAAtNT0F5QbGQmLZKU8LG7KhB2kNnpH+uxY8LQS/u1pRQ0VwAUFNJS+pgSBr3cjdH2FRf6G2LK1CJe46+sDz+FOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fUjrZJr+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747883751;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4hDDPXNPVUX4wJWjO3RS6faGJDUQmnN1Tk6BjYHPjDw=;
	b=fUjrZJr+LvVoOokr7s904hGm7DhWL1V9fRPvFl6xuaiJ7zfC3eyoWipW0w5QEKmB7TUUAQ
	pW88Gduwv5BzYbHkEldYjaEI4GngBVrP0OVkMvJ5pR6Zlw8vWVb21FllpqnFQ3dB+0VDUm
	W05rPVesIQR9cpQmr/upUP0qTwSuoaM=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-509-PROcHyWrPTaYZ3JWB4hxfw-1; Wed, 21 May 2025 23:15:49 -0400
X-MC-Unique: PROcHyWrPTaYZ3JWB4hxfw-1
X-Mimecast-MFC-AGG-ID: PROcHyWrPTaYZ3JWB4hxfw_1747883749
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-232054aa634so44036805ad.3
        for <linux-integrity@vger.kernel.org>; Wed, 21 May 2025 20:15:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747883749; x=1748488549;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4hDDPXNPVUX4wJWjO3RS6faGJDUQmnN1Tk6BjYHPjDw=;
        b=NS00vsJfNiExVm1vbO8xREJyfeDXwuwJ+Nv35SzN839ahNQYPyX/Nx9Lyg9isVHnsK
         hOz1Lu4VBvzZAA5llHXpj2DHfmPF+aEjSxqD8Hnk89OTdt9XRmNPneayeO/bx3FA3e2Y
         yfKfuxc+2fFJkEulPN3wagYZoxYIvM42YivzecQAqM8EP8XLOcK3tj5KYiPfG7qPYeGv
         XB2OnQVZHqktk7z2h1jtiOTcZMZ583huYfe8nQvHeipn2eW+Ysg+wY+cqWlafXwj9pUX
         KFaXyIBiZCgx6iDD6Nsem0HcJUff5e36pqd56vj9+R9HtMR0vO7ek8CQKnzzgXIExAWG
         swXg==
X-Gm-Message-State: AOJu0YzDpzOnylqubU1U/Eh+/WygfMmByNMYqhi8acit1MTKvgZsbUWt
	kqiaqr6LF0GKda1HPX62+RkdU0Ldw7QKoAnBqFx0ihJUTTXlu/Xc+qdv9Jh6AaPPVyDt5oRKVQo
	Jipc4sHw8Nl3RQUEltMKnqnXaySM0IhkqHTmZYpo3JlxMpWDs/ZqItrPsOeVYBwc+Zi9UCw==
X-Gm-Gg: ASbGncuZiQnibIr6LRW3xlgcbhgefN60ScBi5Fb8jF+/6mwi5SmZQrEGsuYYDSdDFUt
	xE+pgv+nxV/fdO186l2WWENstHo9wAxJsH8TLn9WKXlaQcJH6Y9VL6L5WM+X2mQC3Fl7/Rl5UPY
	FcJhLiJFjy45w6fvncHK/F+sOqRWweaPEwdvYUu2CvnTbtnAXdSX7BXLb5sycCPBNIQjLQs39fO
	8D0qPAWQJF69eoTCe50Qn8BU+ob17NGZtceGro0thd1MQhPUIFvxhTP/WcwO8b79/n14aseJbR6
	zFs=
X-Received: by 2002:a17:902:ecd2:b0:224:2384:5b40 with SMTP id d9443c01a7336-231de31b3dbmr363597695ad.24.1747883748865;
        Wed, 21 May 2025 20:15:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEcfftTSP/k2nGycwqU2/FTMkDY/jJeqv6xU/mivJ+VvdxVqymTYQF+F0wBnxQg3D8g55fOLw==
X-Received: by 2002:a17:902:ecd2:b0:224:2384:5b40 with SMTP id d9443c01a7336-231de31b3dbmr363597425ad.24.1747883748476;
        Wed, 21 May 2025 20:15:48 -0700 (PDT)
Received: from localhost ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-231d4ed195csm99296115ad.212.2025.05.21.20.15.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 May 2025 20:15:48 -0700 (PDT)
Date: Thu, 22 May 2025 11:14:35 +0800
From: Coiby Xu <coxu@redhat.com>
To: Baoquan He <bhe@redhat.com>, Mimi Zohar <zohar@linux.ibm.com>
Cc: linux-integrity@vger.kernel.org, kexec@lists.infradead.org, 
	linux-kernel@vger.kernel.org, pmenzel@molgen.mpg.de, ruyang@redhat.com, 
	chenste@linux.microsoft.com
Subject: Re: [PATCH] ima: add a knob ima= to make IMA be able to be disabled
Message-ID: <f4qj7ql2g2yhp44f6quq2ighboq57vilzepnltxgje5gg2cymv@vi5i2krnk7zf>
References: <20250515233953.14685-1-bhe@redhat.com>
 <aCaFNvHbYxrCaPbe@MiWiFi-R3L-srv>
 <1d2848fe45dbf58707cecf16c4fc46b179e24415.camel@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1d2848fe45dbf58707cecf16c4fc46b179e24415.camel@linux.ibm.com>

On Wed, May 21, 2025 at 08:54:10AM -0400, Mimi Zohar wrote:
>On Fri, 2025-05-16 at 08:22 +0800, Baoquan He wrote:
>> CC kexec list.
>>
>> On 05/16/25 at 07:39am, Baoquan He wrote:
>> > Kdump kernel doesn't need IMA functionality, and enabling IMA will cost
>> > extra memory. It would be very helpful to allow IMA to be disabled for
>> > kdump kernel.
>
>The real question is not whether kdump needs "IMA", but whether not enabling
>IMA in the kdump kernel could be abused.  The comments below don't address
>that question but limit/emphasize, as much as possible, turning IMA off is
>limited to the kdump kernel.
>
>> >
>> > And Coiby also mentioned that for kdump kernel incorrect ima-policy loaded
>> > by systemd could cause kdump kernel hang, and it's possible the booting
>> > process may be stopped by a strict, albeit syntax-correct policy and users
>> > can't log into the system to fix the policy. In these cases, allowing to
>> > disable IMA is very helpful too for kdump kernel.

To clarify, what I mentioned early is that the system hangs because
systemd freezes after trying to load an incorrect policy or the booting
process may be stopped by a strict, albeit syntax-correct policy. kdump
won't be affected in these cases because the IMA policy file
(/etc/ima/ima-policy) won't be installed into the kdump initramfs by
default so there is no chance for this IMA policy file to affect kdump.
Besides, if the normal/1st system does hang because of the IMA policy,
the kdump kernel and initramfs simply won't be loaded thus no chance to
to be booted or to load an IMA policy file.

But kdump can be affected if the kernel cmdline parameter
ima_policy=appraise_tcb is configured. Because currently files in kdump
initramfs don't have security.ima. Without the reference value stored in
security.ima to prove a file's integrity, IMA will prevent accessing
this file. So in this case, IMA can also stop systemd from running.

>> >
>> > Hence add a knob ima=on|off here to allow people to disable IMA in kdump
>> > kenrel if needed.
>
>^kernel
>
>> >
>> > Signed-off-by: Baoquan He <bhe@redhat.com>
>> > ---
>> >  .../admin-guide/kernel-parameters.txt         |  5 +++++
>> >  security/integrity/ima/ima_main.c             | 22 +++++++++++++++++++
>> >  2 files changed, 27 insertions(+)
>> >
>> > diff --git a/Documentation/admin-guide/kernel-parameters.txt
>> > b/Documentation/admin-guide/kernel-parameters.txt
>> > index d9fd26b95b34..762fb6ddcc24 100644
>> > --- a/Documentation/admin-guide/kernel-parameters.txt
>> > +++ b/Documentation/admin-guide/kernel-parameters.txt
>> > @@ -2202,6 +2202,11 @@
>> >  			different crypto accelerators. This option can be
>> > used
>> >  			to achieve best performance for particular HW.
>> >  
>> > +	ima=		[IMA] Enable or disable IMA
>> > +			Format: { "off" | "on" }
>> > +			Default: "on"
>> > +			Note that this is only useful for kdump kernel.
>
>Instead of "useful" I would prefer something clearer like "limited".
>
>> > +
>> >  	init=		[KNL]
>> >  			Format: <full_path>
>> >  			Run specified binary instead of /sbin/init as
>> > init
>> > diff --git a/security/integrity/ima/ima_main.c
>> > b/security/integrity/ima/ima_main.c
>> > index f3e7ac513db3..07af5c6af138 100644
>> > --- a/security/integrity/ima/ima_main.c
>> > +++ b/security/integrity/ima/ima_main.c
>> > @@ -27,6 +27,7 @@
>> >  #include <linux/fs.h>
>> >  #include <linux/iversion.h>
>> >  #include <linux/evm.h>
>> > +#include <linux/crash_dump.h>
>> >  
>> >  #include "ima.h"
>> >  
>> > @@ -38,11 +39,27 @@ int ima_appraise;
>> >  
>> >  int __ro_after_init ima_hash_algo = HASH_ALGO_SHA1;
>> >  static int hash_setup_done;
>> > +static int ima_disabled;
>
>Like the ima_hash_algo variable definition above, ima_disabled should be
>defined as __ro_after_init.
>
>> >  
>> >  static struct notifier_block ima_lsm_policy_notifier = {
>> >  	.notifier_call = ima_lsm_policy_change,
>> >  };
>> >  
>> > +static int __init ima_setup(char *str)
>> > +{
>
>is_kdump_kernel() should also be called here, before the tests below.
>Something like:
>
>+       if (!is_kdump_kernel()) {
>+               pr_info("Warning ima setup option only permitted in kdump");
>+               return 1;
>+       }

Yes, this kind of info will be helpful to avoid users misusing
ima=off. I already saw a case where a user tried to use ima=0 to skip
loading an invalid IMA policy file in order to resolve booting failure
"systemd Freezing execution" and even filed a bug saying ima=0 doesn't
work.

>
>> > +	if (strncmp(str, "off", 3) == 0)
>> > +		ima_disabled = 1;
>> > +	else if (strncmp(str, "on", 2) == 0)
>> > +		ima_disabled = 0;
>> > +	else
>> > +		pr_err("Invalid ima setup option: \"%s\" , please specify
>> > ima=on|off.", str);
>> > +
>> > +	return 1;
>> > +}
>> > +__setup("ima=", ima_setup);
>> > +
>> > +
>> > +
>
>Remove the extraneous blank line.
>
>> >  static int __init hash_setup(char *str)
>> >  {
>> >  	struct ima_template_desc *template_desc =
>> > ima_template_desc_current();
>> > @@ -1184,6 +1201,11 @@ static int __init init_ima(void)
>> >  {
>> >  	int error;
>> >  
>> > +	if (ima_disabled && is_kdump_kernel()) {
>> > +		pr_info("IMA functionality is disabled");
>> > +		return 0;
>> > +	}
>> > +
>
>Even with the additional call to is_kdump_kernel() in ima_setup, please keep
>the is_kdump_kernel() test here as well.  Even though the code is self
>describing, please add a one line comment emphasizing disabling IMA is limited
>to kdump.
>
>> >  	ima_appraise_parse_cmdline();
>> >  	ima_init_template_list();
>> >  	hash_setup(CONFIG_IMA_DEFAULT_HASH);
>> > --
>> > 2.41.0
>> >
>>
>>
>
>thanks,
>
>Mimi


-- 
Best regards,
Coiby


