Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A8471D59D4
	for <lists+linux-integrity@lfdr.de>; Fri, 15 May 2020 21:18:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726228AbgEOTSL (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 15 May 2020 15:18:11 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:20868 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726223AbgEOTSL (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 15 May 2020 15:18:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589570289;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:in-reply-to:in-reply-to:  references:references;
        bh=O8sUao5NVjed89ybkYXZ8qWu9HTz3CZc9ckQ6lQ812A=;
        b=hCYkVKdP1EWvcI9eINI5LlV66T0fv7qQ3NnyxsGST2MCZIHmTJ3+AFVd/f7Ud44ILwbib9
        M1fPDxwz/6Xtdm4/DCtxbOCGYtXpAzuCTmTfWWjV927Bh1BbjSSx6Jgwby1ggVrWHY6uuP
        p23L8UrdV7ETvZPhr6w9M56y/JNO9zQ=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-150-wtu56aMIOROZm5Gn_wItKg-1; Fri, 15 May 2020 15:18:01 -0400
X-MC-Unique: wtu56aMIOROZm5Gn_wItKg-1
Received: by mail-qv1-f72.google.com with SMTP id j6so3634878qvn.9
        for <linux-integrity@vger.kernel.org>; Fri, 15 May 2020 12:18:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to;
        bh=O8sUao5NVjed89ybkYXZ8qWu9HTz3CZc9ckQ6lQ812A=;
        b=OiCmmLYmHnHDY88X10mcNpws1C1kqOebQovaTiwPl1VcoZIxQRXVEZMP3WoYKh8MFl
         C2gfNUbHERZbUse3JKUwPBJUxBxJ3+4VQTHeL8lqyhx78MrNLiBW6KyRVytCF0rVFrKw
         /fhd+HFJFGDD4dmPx7epOZ41clg/nbhoTGKx4YeuMRxM3578l/Sh22Z6REAAoFgYfbEt
         8gu/oyzloZk/KDGJ8ckBtQRfzXDvwnsQQIYIvJG4aizjUkI4npgQ/nCIiurhgRCZZUiN
         04UjDPwrFp7ykWP5jrAXQ594NeqgA97F6bagHC4ABFTYsgxMYEf63FJhXb19E4fWjcwP
         mTzg==
X-Gm-Message-State: AOAM532oA/lW48IOoHIYRrHr0I4EBm6lt1Mv8R+oCd9bakwW7tHtBSCq
        xfrLAtV6s1T3hDRz0wi0wPf7pwv91rlK6j874ICDAe2oSwmVU4PgMa+PECl4/WUdVaLWvVVdjRD
        /Dd++YYrAUDHqQ42OqayQZUgWDWXo
X-Received: by 2002:ac8:d0d:: with SMTP id q13mr1058213qti.254.1589570280988;
        Fri, 15 May 2020 12:18:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyh3U3YQg9CZAgKvwV/GIM87b3dJF1BFxDYfWRb2T+Bpd5FUdv63NUp2MdNnsCBaTUeqol79Q==
X-Received: by 2002:ac8:d0d:: with SMTP id q13mr1058176qti.254.1589570280660;
        Fri, 15 May 2020 12:18:00 -0700 (PDT)
Received: from localhost (ip70-163-223-149.ph.ph.cox.net. [70.163.223.149])
        by smtp.gmail.com with ESMTPSA id l186sm2228024qkf.89.2020.05.15.12.17.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2020 12:17:59 -0700 (PDT)
Date:   Fri, 15 May 2020 12:17:58 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     James Bottomley <James.Bottomley@hansenpartnership.com>,
        linux-integrity@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>,
        David Woodhouse <dwmw2@infradead.org>,
        keyrings@vger.kernel.org, David Howells <dhowells@redhat.com>
Subject: Re: [PATCH v9 0/8] TPM 2.0 trusted keys with attached policy
Message-ID: <20200515191758.ieojyk5xhsx2hzzd@cantor>
Reply-To: Jerry Snitselaar <jsnitsel@redhat.com>
References: <20200507231147.27025-1-James.Bottomley@HansenPartnership.com>
 <23639de13874c00e6bb2b816b4db0b586c9a074c.camel@linux.intel.com>
 <483c4f1af7be41c8d091b11d4484b606ebd319b7.camel@linux.intel.com>
 <1589514263.5759.25.camel@HansenPartnership.com>
 <20200515084702.GA3404@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <20200515084702.GA3404@linux.intel.com>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri May 15 20, Jarkko Sakkinen wrote:
>On Thu, May 14, 2020 at 08:44:23PM -0700, James Bottomley wrote:
>> On Fri, 2020-05-15 at 05:22 +0300, Jarkko Sakkinen wrote:
>> > On Thu, 2020-05-14 at 17:31 +0300, Jarkko Sakkinen wrote:
>> > > I'm compiling now kernel with all series included.
>> > >
>> > > Kind of checking if I could just take the whole series. Let see.
>> > >
>> > > In all cases I want the style errors in 3/8 to be fixes with a
>> > > helper
>> > > but maybe better to hold before sending anything. Possibly that is
>> > > all
>> > > needed I'll just carve that patch myself.
>> > >
>> > > Please don't do anything for the moment.
>> >
>> > This is what I tried first (with the full series applied):
>> >
>> > #!/bin/sh
>> >
>> > die()
>> > {
>> > 	keyctl clear @u
>> > 	./tpm2-flush --all-transient
>> > 	exit $1
>> > }
>> >
>> > KEYHANDLE=$(./tpm2-root-key || die 1)
>> > KEYID=$(keyctl add trusted kmk "new 32 keyhandle=$KEYHANDLE
>> > hash=sha256" @u || die 1)
>> >
>> > echo "$KEYID ($KEYHANDLE)"
>> >
>> > keyctl pipe $KEYID > blob.hex || die 1
>> > keyctl clear @u || die 1
>> >
>> > echo "Import key from blob"
>> >
>> > keyctl add trusted kmk "load `cat blob.hex` keyhandle=$KEYHANDLE" @u
>> > || die 1
>> >
>> > die 0
>> >
>> > Result:
>> >
>> > sudo ./keyctl-smoke.sh
>> > 566201053 (0x80000000)
>> > keyctl_read_alloc: Permission denied

I get keyctl_read_alloc -EPERM when I 'sudo su' and try to play with keyctl print.
If I 'sudo su -' and then try it works as expected. Also works for normal user.


>>
>> Well, it's clearly failing in keyctl pipe
>>
>> I do confess to never having tested a volatile primary, but I just did
>> so and it works for me.  I will also add the keyhandle in the load
>> isn't necessary, because it should be in the blob, but there should
>> also be no harm (just tested).
>>
>> However, I don't have keyctl_read_alloc in my tree, so it may be an
>> incompatibility with another patch set.  What's your base and what
>> other patches do you have applied?
>
>http://git.infradead.org/users/jjs/linux-tpmdd.git
>
>Or exactly:
>
>git://git.infradead.org/users/jjs/linux-tpmdd.git (master)
>
>/Jarkko
>

