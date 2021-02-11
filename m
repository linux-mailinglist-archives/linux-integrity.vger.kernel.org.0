Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46EA4318BBF
	for <lists+linux-integrity@lfdr.de>; Thu, 11 Feb 2021 14:17:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230272AbhBKNOW (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 11 Feb 2021 08:14:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:39040 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230213AbhBKNKg (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 11 Feb 2021 08:10:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613048947;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=lf7siPgJA5+sIT/5q/V54nJV0Ccehz6ukMSrd90YcPc=;
        b=CZL8cRHfezjADSL+0sWgyCm+cgD+nk4hNSxvP5dzWwhwFHCCQCUw6msTuhB9CFaw/20u14
        d6wxqYwhho/8izc8+uLIyCPkpy3qYRT6Bp1kTHeimmfamNDq1tt/e+libbsVns+14a8p/6
        /R3R3cTudgDJ7+Y+Cr6EBsR/koqYOlY=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-147-xDnjQRKvMymenZjF7Q188g-1; Thu, 11 Feb 2021 08:09:04 -0500
X-MC-Unique: xDnjQRKvMymenZjF7Q188g-1
Received: by mail-ej1-f70.google.com with SMTP id ia14so4717478ejc.8
        for <linux-integrity@vger.kernel.org>; Thu, 11 Feb 2021 05:09:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=lf7siPgJA5+sIT/5q/V54nJV0Ccehz6ukMSrd90YcPc=;
        b=bVU3cxI/kNYGZ08WEGaXVL7Bj7rx1eU0M1KA3jRTq7Hgl9v0ICLo6pfFCsidxLG5vW
         yRQqIOLtUkROa4KqMfMBju4qmYYEoMqxTmFGtVRhQuqk8KNSAlFYsihhDjNIZt5xLal5
         TzZ3iVjQNuUAjPMjt+cJcBGNlyw3o6hc7w5JRrdGPXnL5/zsqlwer8QRoDWdd0TFZHFT
         7euSi2SyBgaZNXQmtd0dUvtYuMHlkvPVIFwLD1aobnjsivyDUr4YlTyUMEA+FJWN8JFQ
         GNvmxNsSVyQOWINZitTTstv6Gu2WbO/1od6SlCRFEPUPqsbP44jk2DFp4U8MeWembXf0
         v5bQ==
X-Gm-Message-State: AOAM53037V2NSbO4J9H2+wh+dOz0kRKKanpI60XyyktgLK2fo3SB5hRF
        3bq1tI3f/wrvc2VTJ03En0RV+d07uYZVi+N6VXdi0FG9u6cuf+0lAkuRsa/ZBXbaavZoiIkfgEd
        bqfJ5t1k82W8dT02W1tNOKJh6/dI255EDSHDRGWBtRuurxOq4U7FIy/cb7aiNvAbuf+VYxanv/s
        AvVuMr
X-Received: by 2002:a17:906:d19b:: with SMTP id c27mr8559712ejz.234.1613048943027;
        Thu, 11 Feb 2021 05:09:03 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyNTLrHnM4+q0EA0tyWwP8pAIdpG4KwxSAYKxx3Agjvnk4DFKxFvnaQTl37pHhoQO0hDFNosQ==
X-Received: by 2002:a17:906:d19b:: with SMTP id c27mr8559696ejz.234.1613048942873;
        Thu, 11 Feb 2021 05:09:02 -0800 (PST)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id bz20sm4733629ejc.28.2021.02.11.05.09.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Feb 2021 05:09:02 -0800 (PST)
To:     Jerry Snitselaar <jsnitsel@redhat.com>
Cc:     Jarkko Sakkinen <jarkko@kernel.org>,
        Matthew Garrett <mjg59@google.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        linux-integrity <linux-integrity@vger.kernel.org>
From:   Hans de Goede <hdegoede@redhat.com>
Subject: Recent tpm_tis IRQ handling changes are causing kernel backtraces
Message-ID: <34442b17-c8e6-9d33-831f-fcbf3a38552b@redhat.com>
Date:   Thu, 11 Feb 2021 14:09:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Jerry,

It looks like there still is an issue with the recent changes to the tpm_tis IRQ
handling. At least I think those are the cause I did not dive any deeper,
I just noticed that we (Fedora) have been receiving an aweful lot of
kernel tpm_tis_send_data backtraces with most starting with tpm_tis_probe_irq_...

See for example:
https://bugzilla.redhat.com/show_bug.cgi?id=1912167
https://bugzilla.redhat.com/show_bug.cgi?id=1927610

Those are just the 3 which landed in my inbox today, for much more see:
https://bugzilla.redhat.com/buglist.cgi?quicksearch=tpm_tis_send_data
(this shows 18 bugs atm).

These were reported through the Fedora ABRT tools which automatically
collects backtraces, the bugs have links to the ABRT reports, e.g. :
https://retrace.fedoraproject.org/faf/reports/28155/
https://retrace.fedoraproject.org/faf/reports/37107/

The 28155 report says that so far there have been 308,412 (ouch) automatic
uploads of that particular variant of these backtraces

Note the second (37107) retrace report is about this happening
on resume, rather then on probe/tpm_tis_probe_irq_... time.

Did your work on  this work land in 5.10 ? Or could it be that the
issue is an incomplete backport to the 5.10.y stable series ?

Regards,

Hans

