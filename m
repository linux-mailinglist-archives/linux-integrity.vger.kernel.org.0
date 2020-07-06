Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 346EA2162A5
	for <lists+linux-integrity@lfdr.de>; Tue,  7 Jul 2020 01:57:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726729AbgGFX5f (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 6 Jul 2020 19:57:35 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:49881 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726799AbgGFX5e (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 6 Jul 2020 19:57:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594079853;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5h/pRXHkSxEq61rxonlUns+UKJmDH2+YzkyLNI3P18c=;
        b=LvDFxApzmWvOyKgwYQIy2znvnixcw2o1OiwUDvNdElewoPbTSHwygw+VBJoIMnZ/sFFwjY
        sFnGa7uITwFjgNUCS29ENT7GCxAOGymGpX3fFBEnr5zRlq3RN+rxwMgdhMGlZXL8l2+2xF
        6ZqRg6/2xK+0g+NpJ3u3bgYBWtxodK4=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-395-0Gg1tXjuPTOeha4H4xfC1Q-1; Mon, 06 Jul 2020 19:57:31 -0400
X-MC-Unique: 0Gg1tXjuPTOeha4H4xfC1Q-1
Received: by mail-qv1-f70.google.com with SMTP id v20so25926691qvt.15
        for <linux-integrity@vger.kernel.org>; Mon, 06 Jul 2020 16:57:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=5h/pRXHkSxEq61rxonlUns+UKJmDH2+YzkyLNI3P18c=;
        b=MrHIyOmI9jNRCOhIW7pY5Q9u/DxYenKkbd51mWq4tihMZInNrCl14DZNpjMEti83+Z
         MH+kg7qJ3uaoOcLG1AOuyQEdluRr+XdUfCNKFms0LTlRVIQG+5uRpJdC/FSXjA0u5cIY
         0a7NHJTVtIBhfZZKINF7wCU6T2cc9c1fBPEVANOPqpmp3udWpOYWbP0Cr5aG5TBbufGD
         WCfsDee8CaUeTFkRRLyLObA3N3xC8oovkCOkpLu0OzqjcBerFJVHsxDKC1vEO/2eyZ98
         p0iZUIYCbPJDAebSt7B3tS9SFoisTOX3K9Fuy6i7/U3gQ4BmggJirbCdZxvIz+aX6F7U
         L15g==
X-Gm-Message-State: AOAM5316Ipkz6qi710JDZJiMVCBJxLeqSKqVnswH/U1zlmmN4YIZPw2S
        h/7JZWHiO/dvsEg0uwGQkLPopcI1lglTppuI2cc2V++kKS5rPtXGSm4qhhkH5ynjy0JQTQnGF/V
        m+OkFQiT228oKgchxj4SGyMra+C3h
X-Received: by 2002:a37:a253:: with SMTP id l80mr49623328qke.197.1594079851022;
        Mon, 06 Jul 2020 16:57:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxr5SZNidI4OJoMWzUXi9Xjl/T41/3YcOx+9xtlh2k1eoNc3KkVBOU6fOs9TEw6tHZ9F9ixxA==
X-Received: by 2002:a37:a253:: with SMTP id l80mr49623312qke.197.1594079850724;
        Mon, 06 Jul 2020 16:57:30 -0700 (PDT)
Received: from localhost (ip70-163-223-149.ph.ph.cox.net. [70.163.223.149])
        by smtp.gmail.com with ESMTPSA id g41sm25799385qtb.37.2020.07.06.16.57.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2020 16:57:30 -0700 (PDT)
References: <20200706181953.3592084-1-stefanb@linux.vnet.ibm.com> <20200706181953.3592084-3-stefanb@linux.vnet.ibm.com> <20200706230914.GC20770@linux.intel.com>
User-agent: mu4e 1.4.10; emacs 26.3
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     Stefan Berger <stefanb@linux.vnet.ibm.com>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-security-module@vger.kernel.org,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: Re: [PATCH v9 2/2] tpm: Add support for event log pointer found in TPM2 ACPI table
In-reply-to: <20200706230914.GC20770@linux.intel.com>
Date:   Mon, 06 Jul 2020 16:57:28 -0700
Message-ID: <87mu4cjixj.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


Jarkko Sakkinen @ 2020-07-06 16:09 MST:

> On Mon, Jul 06, 2020 at 02:19:53PM -0400, Stefan Berger wrote:
>> From: Stefan Berger <stefanb@linux.ibm.com>
>> 
>> In case a TPM2 is attached, search for a TPM2 ACPI table when trying
>> to get the event log from ACPI. If one is found, use it to get the
>> start and length of the log area. This allows non-UEFI systems, such
>> as SeaBIOS, to pass an event log when using a TPM2.
>> 
>> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
>
> Do you think that QEMU with TPM 1.2 emulator turned on would be a viable
> way to test this?
>
> I'm anyway more worried about breaking existing TPM 1.2 functionality
> and that requires only QEMU without extras.
>
> /Jarkko

The 1.2 bits should be functionally the same as before, right?

