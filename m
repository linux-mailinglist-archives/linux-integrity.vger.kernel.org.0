Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 608FD12FE6F
	for <lists+linux-integrity@lfdr.de>; Fri,  3 Jan 2020 22:47:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728754AbgACVrb (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 3 Jan 2020 16:47:31 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:53479 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728730AbgACVr2 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 3 Jan 2020 16:47:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578088046;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:in-reply-to:in-reply-to:  references:references;
        bh=aQ66C15EM+pgbqrVEPhqNK/QPopaJL165JeYQIZUeJw=;
        b=UNCOsjEOGM1f9DC4UF6m4blqfxuSeqWUm4HSq8GArvgPpf+vHC5d2Dylj3o3mA6BMPy74l
        9ihTlUyX9u/lRcvsCvr+2CJcw4bcW29jV5oYukZDqXdfjf0iRpVW8XlMZdCTZ8GVKk0mZy
        y7jp7lPmnXY/mV7plduHbh4J8FntdY8=
Received: from mail-yb1-f200.google.com (mail-yb1-f200.google.com
 [209.85.219.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-248-ook0ZCiiNAuRD3TbXVVR5A-1; Fri, 03 Jan 2020 16:47:23 -0500
X-MC-Unique: ook0ZCiiNAuRD3TbXVVR5A-1
Received: by mail-yb1-f200.google.com with SMTP id q189so34902410ybg.17
        for <linux-integrity@vger.kernel.org>; Fri, 03 Jan 2020 13:47:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=aQ66C15EM+pgbqrVEPhqNK/QPopaJL165JeYQIZUeJw=;
        b=mSjD7OYgMzGxiYJSDgxu27QA/6Jv4fPGKteG75A6V51IG9OnoS4KjrJGpgj8eF0G2A
         6JblN3n1qYbFBq4AWckBXptx8dNYRqnZaTM7vYG5p7widVpxgh4C0wOyTaBk9egnH5/7
         QoPi1qFAvqfjV0xGzS+H1AsqYrEJ3euirhNZEny5ZQ3TKqLCL4RIOa5j8VQshPqKDYDs
         GvRsBu15GUMmiVjMVxneG0Iklh14/iP82Ojc74yPTtvwT7UgHVSQcA2n8En1M2SZLBE+
         /Hppy21nUolUjWxWedkRXoPPLWAtrVIV2Db1RZofrQxFw0y1/tQD806AyLaXIKfeC6U4
         ovNQ==
X-Gm-Message-State: APjAAAUAZjvEaSEnLyjpeaUlKYh27MPTAnEDSaHfVeWanBC7pOZimcrz
        y1RpGPHzRPK6QATwOWAer40i/7kncpjDC0GYqn0pZGYKgpOvvRzeF5Tk1ejrdcHbN/WonvpR2oP
        0th1Rl2EF0rTNq7QJo139JBwMHwn1
X-Received: by 2002:a81:98b:: with SMTP id 133mr64946276ywj.387.1578088043349;
        Fri, 03 Jan 2020 13:47:23 -0800 (PST)
X-Google-Smtp-Source: APXvYqwv/q4jZ5mihtaQmAWvF5KH4xP7n1jA76SqQP/5d+Cz8w7XkIwzVRIqbdPsV0pMGBPXo+6N6A==
X-Received: by 2002:a81:98b:: with SMTP id 133mr64946251ywj.387.1578088043065;
        Fri, 03 Jan 2020 13:47:23 -0800 (PST)
Received: from localhost (ip70-163-223-149.ph.ph.cox.net. [70.163.223.149])
        by smtp.gmail.com with ESMTPSA id q189sm24069007ywb.15.2020.01.03.13.47.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jan 2020 13:47:22 -0800 (PST)
Date:   Fri, 3 Jan 2020 14:47:20 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     Christian Bundy <christianbundy@fraction.io>
Cc:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Peter Huewe <peterhuewe@gmx.de>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>,
        stable-commits@vger.kernel.org, linux-integrity@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Patch "tpm_tis: reserve chip for duration of tpm_tis_core_init"
 has been added to the 5.4-stable tree
Message-ID: <20200103214720.nf2ahcpk3t2d7lua@cantor>
Reply-To: Jerry Snitselaar <jsnitsel@redhat.com>
Mail-Followup-To: Christian Bundy <christianbundy@fraction.io>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Jason Gunthorpe <jgg@ziepe.ca>, Peter Huewe <peterhuewe@gmx.de>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>,
        stable-commits@vger.kernel.org, linux-integrity@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <CAPcyv4jfpOX85GWgNTyugWksU=e-j=RhU_fcrcHBo4GMZ8_bhw@mail.gmail.com>
 <c6ce34b130210d2d1330fc4079d6d82bd74dcef1.camel@linux.intel.com>
 <50217a688ffa56cf5f150ffd358daba2a88cad48.camel@linux.intel.com>
 <20191228151526.GA6971@linux.intel.com>
 <CAPcyv4i_frm8jZeknniPexp8AAmGsaq0_DHegmL4XZHQi1ThxA@mail.gmail.com>
 <CAPcyv4iyQeXBWvp8V_UPBsOk29cfmTVZGYrrDgyYYqzsQvTjNA@mail.gmail.com>
 <2c4a80e0d30bf1dfe89c6e3469d1dbfb008275fa.camel@linux.intel.com>
 <20191231010256.kymv4shwmx5jcmey@cantor>
 <20191231155944.GA4790@linux.intel.com>
 <be07a1e4-c290-4185-8c23-d97050279564@www.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <be07a1e4-c290-4185-8c23-d97050279564@www.fastmail.com>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue Dec 31 19, Christian Bundy wrote:
>> Christian, were you having any issues with interrupts? You system was going
>> into this code as well.
>
>Unfortunately I'm now unable to test, sorry for the trouble. I replaced my BIOS
>with UEFI firmware and the problem has disappeared. Please let me know if there
>is anything else I can do to help.
>
>Christian
>

That is interesting. Is the tpm functioning, or did the firmware change disable it?
Is there any output from 'dmesg | grep -i tpm' or anything in /sys/class/tpm/ ?

