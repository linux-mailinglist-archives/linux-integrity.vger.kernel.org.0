Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 884B4141418
	for <lists+linux-integrity@lfdr.de>; Fri, 17 Jan 2020 23:29:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728733AbgAQW33 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 17 Jan 2020 17:29:29 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:36943 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726587AbgAQW33 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 17 Jan 2020 17:29:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579300167;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jZf99ZIAW9yy0t5E59TCq+10wuyOwii+MEj2SxcSPCc=;
        b=VFD/mQCiKcOrmio8U1na8PsOtB+JtP9RtcJIMWQP4OB3/MuYvcWruqlF7hKs3UpEAzyLAW
        8KB4C7cCBM7y+6L+v6bVzvgEciGpr+xBEGycVP5+4K43tLXaF4rgMNHkrOTI9xFC5GmB+y
        beXh+Yz5R8LkVD0VRLSuGQ0hIsLy4Ok=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-194-dJHtnYvKN_e7I72UZtDv8g-1; Fri, 17 Jan 2020 17:29:23 -0500
X-MC-Unique: dJHtnYvKN_e7I72UZtDv8g-1
Received: by mail-qv1-f70.google.com with SMTP id n11so16567947qvp.15
        for <linux-integrity@vger.kernel.org>; Fri, 17 Jan 2020 14:29:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=jZf99ZIAW9yy0t5E59TCq+10wuyOwii+MEj2SxcSPCc=;
        b=kUsSRDo7zBiDb6XppIxrq9Cr69B7tiazDkQ0qkiiMjyPRjaUeBCKmjBpLW4S/yE5l0
         6r6JM/wDH5LyasT3J9gPvCEdzO42c48M2uoevUfb7Uh0yNICvpbpuF8BBIsez+cZKX31
         3rkozJ+Gnb8KRQZ+bAwIOhVOAqfvouss+gwhxPardmm6efMwu782vjrSjCvUz+/W3QzH
         yueM5juGBT8mxIsqEpHUqY8iJAMOKjKwq9CvW0F0txKhGGRkXtA3LmzUQHtKFUep25KU
         tP2DAsI5b9/L/P5m8zELx09YRx4U0rT+0uVsQ3eFoV0P7G0FeuZPBfagXvpjUAF9OzNc
         oxRg==
X-Gm-Message-State: APjAAAXqNiJFLgqhzDuh3oerIZqVpQbb2yx4XYp7bSv5kGF9DIYSe4Zj
        vXgdofiJEX1MDDU3EMOTPV5jrw+qsJLBw6IuZyJdgMIL//929TPg/OAMErFPZtk84LiNphv8GqD
        Crz6F3qPqyFtgpX8rnuvapPFp2jrT
X-Received: by 2002:a05:620a:78f:: with SMTP id 15mr39995898qka.295.1579300162766;
        Fri, 17 Jan 2020 14:29:22 -0800 (PST)
X-Google-Smtp-Source: APXvYqyRjj9h0V8AIBtSJU9CmO7DPuXwmwXwoGKEmDX72Q0bLlzRj+pd6TGrUNzX2SvX0/slAsIrsQ==
X-Received: by 2002:a05:620a:78f:: with SMTP id 15mr39995883qka.295.1579300162560;
        Fri, 17 Jan 2020 14:29:22 -0800 (PST)
Received: from localhost (ip70-163-223-149.ph.ph.cox.net. [70.163.223.149])
        by smtp.gmail.com with ESMTPSA id o16sm12423621qkj.91.2020.01.17.14.29.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2020 14:29:21 -0800 (PST)
Date:   Fri, 17 Jan 2020 15:29:20 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     linux-integrity@vger.kernel.org
Subject: Re: ima pcr question
Message-ID: <20200117222920.2d42m3ahxznl64em@cantor>
Reply-To: Jerry Snitselaar <jsnitsel@redhat.com>
References: <20200114000602.h5k5rr2k6zl3dlts@cantor>
 <1578964659.5796.7.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1578964659.5796.7.camel@linux.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon Jan 13 20, Mimi Zohar wrote:
>On Mon, 2020-01-13 at 17:06 -0700, Jerry Snitselaar wrote:
>> We had a report of messages from ima saying "Error communicating with
>> TPM".  Looking into it a bit, it looks like with some Dell systems
>> (possibly others as well) in the bios they can set the hash algorithm
>> being used. In this case with that set to sha256 the messages
>> appear. Flipping the system to using sha1 makes them disappear.
>> Looking at the ima code, ima_calc_boot_aggregate_tfm hard codes using
>> sha1. Should that be changed to use whatever the default is in the
>> config, or possibly find out from the tpm what algorithm is being used?
>
>The ima-ng template contains two digests.  The first digest is the
>value being extended into the TPM, while the second digest is either
>the boot aggregate or file data hash.  It sounds like the problem is
>with the first digest.  Changing the boot-aggregate to use sha256
>might be a good idea, but probably won't fix the problem.
>
>Mimi
>

The error message is coming from ima_pcrread, and the tpm_digest that gets passed
by ima_calc_boot_aggregate_tfm to ima_pcrread is declared:

	struct tpm_digest d = { .alg_id = TPM_ALG_SHA1, .digest = {0} };

According to Dell their default BIOS setting is to use sha256. What they see with that
setting is:

[ 5.475036] ima: Error Communicating to TPM chip
[ 5.475083] tsc: Refined TSC clocksource calibration: 3311.999 MHz
[ 5.475092] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x2fbd936b72f, max_idle_ns: 440795283163 ns
[ 5.475118] ima: Error Communicating to TPM chip
[ 5.475165] ima: Error Communicating to TPM chip
[ 5.475235] clocksource: Switched to clocksource tsc
[ 5.475266] ima: Error Communicating to TPM chip
[ 5.475311] ima: Error Communicating to TPM chip
[ 5.475341] ima: Error Communicating to TPM chip
[ 5.475371] ima: Error Communicating to TPM chip
[ 5.475402] ima: Error Communicating to TPM chip
[ 5.489049] ima: No architecture policies found

