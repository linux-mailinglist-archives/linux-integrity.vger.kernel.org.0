Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6932333D7AD
	for <lists+linux-integrity@lfdr.de>; Tue, 16 Mar 2021 16:34:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238043AbhCPPe3 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 16 Mar 2021 11:34:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:53041 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238191AbhCPPeI (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 16 Mar 2021 11:34:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615908847;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vaXCCvAlIgPCMP0NubPFqcsgaZ/djj633OL9Iqy0B3E=;
        b=Gsv4VZ43+5Vp6nG5PQ47bsHpnZ1tV1Ivkb5TMbSPuQ6PEYzyx+U4zjdMdV4t9wNPGZ/uxi
        1WiGZx3QvwIs5bB97IRD3de732bfZPJMTGkgEyRtrbPFd0kzSUX4575ocKn4M+1fYyUCC2
        kN32MRHqcSgU5tsc4TYbO41m5+Fkxik=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-585-lMcIQ2ipOzeXEYBxciLtog-1; Tue, 16 Mar 2021 11:34:03 -0400
X-MC-Unique: lMcIQ2ipOzeXEYBxciLtog-1
Received: by mail-ed1-f72.google.com with SMTP id t27so17793994edi.2
        for <linux-integrity@vger.kernel.org>; Tue, 16 Mar 2021 08:34:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vaXCCvAlIgPCMP0NubPFqcsgaZ/djj633OL9Iqy0B3E=;
        b=KdqJ+MMT5Dd9SnL+ihDCXOWOWk8CXzCu0z33t/heuKoc7FznvnFzRICns5ZJ6b6Ihv
         MdDhEuZ4WV0CWfuVVUcM3QGYBzjvGtZc9xQN9gBw+Ar87u/WQI+K2vNH3PvK/6/yiqky
         L9B2pQwAhQMR9iz0m/cpPpHfSRSEpldqfpHDle35IUT1+KEwWy3n2ko2B8BjxuYvREoW
         /eW6kt2gk5i8pyzM5F7gPthDgq1wBYwv/nrDLXAgj1DsCF0gwVfwYJoPfEuJGld36+0B
         B9kVMcxfWQX7KIGNyU+/ZI9dr+wjmOxFDRmA/7W2EsdNIETQ8cdX2Enc3earxMGR4+xa
         /8Ng==
X-Gm-Message-State: AOAM531otlINNIfZSHzbv7SWiitSR62/e1zl4Jk13TpCnE6OTnTHxWh6
        IO133oQx6543FYFpMJRc62yb6z2sMEFNf1rEVa7E3OGSpzKRlw8Uz3sm/1iK0ENEKZM1itfjIE2
        tfqbRtQmOv5jGg06/PszpxxE4/xYZXcK7UN1BRKO8kjPxibqfrYKfrJkXt7qfgwaX6BizSP58RB
        K0WPuz
X-Received: by 2002:a05:6402:32d:: with SMTP id q13mr36937799edw.17.1615908842648;
        Tue, 16 Mar 2021 08:34:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwmW4iLSBrT8PiyQThS8JsXj7bwtKzzDR61is3C+nlp5UklH5LVfWvn1AnqkufbZvroK0c0xA==
X-Received: by 2002:a05:6402:32d:: with SMTP id q13mr36937775edw.17.1615908842413;
        Tue, 16 Mar 2021 08:34:02 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id bh4sm3086869ejb.24.2021.03.16.08.34.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Mar 2021 08:34:02 -0700 (PDT)
Subject: Re: Recent tpm_tis IRQ handling changes are causing kernel backtraces
From:   Hans de Goede <hdegoede@redhat.com>
To:     Jerry Snitselaar <jsnitsel@redhat.com>
Cc:     Jarkko Sakkinen <jarkko@kernel.org>,
        Matthew Garrett <mjg59@google.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        linux-integrity <linux-integrity@vger.kernel.org>
References: <34442b17-c8e6-9d33-831f-fcbf3a38552b@redhat.com>
Message-ID: <e4afc566-0114-c5a3-ebda-a775132e999d@redhat.com>
Date:   Tue, 16 Mar 2021 16:34:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <34442b17-c8e6-9d33-831f-fcbf3a38552b@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi,

On 2/11/21 2:09 PM, Hans de Goede wrote:
> Hi Jerry,
> 
> It looks like there still is an issue with the recent changes to the tpm_tis IRQ
> handling. At least I think those are the cause I did not dive any deeper,
> I just noticed that we (Fedora) have been receiving an aweful lot of
> kernel tpm_tis_send_data backtraces with most starting with tpm_tis_probe_irq_...
> 
> See for example:
> https://bugzilla.redhat.com/show_bug.cgi?id=1912167
> https://bugzilla.redhat.com/show_bug.cgi?id=1927610
> 
> Those are just the 3 which landed in my inbox today, for much more see:
> https://bugzilla.redhat.com/buglist.cgi?quicksearch=tpm_tis_send_data
> (this shows 18 bugs atm).
> 
> These were reported through the Fedora ABRT tools which automatically
> collects backtraces, the bugs have links to the ABRT reports, e.g. :
> https://retrace.fedoraproject.org/faf/reports/28155/
> https://retrace.fedoraproject.org/faf/reports/37107/
> 
> The 28155 report says that so far there have been 308,412 (ouch) automatic
> uploads of that particular variant of these backtraces
> 
> Note the second (37107) retrace report is about this happening
> on resume, rather then on probe/tpm_tis_probe_irq_... time.
> 
> Did your work on this work land in 5.10 ? Or could it be that the
> issue is an incomplete backport to the 5.10.y stable series ?

Ping ?

It is raining bug-reports about this:

https://bugzilla.redhat.com/buglist.cgi?quicksearch=tpm_tis_send_data

Currently lists 25 bugs and that is excluding bugs which have already
been marked as a duplicate.

Can someone involved in the patch-series which is causing this regression
please take a look at these kernel backtraces ?

Regards,

Hans

