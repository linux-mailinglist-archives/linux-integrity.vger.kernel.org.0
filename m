Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C6A71D4998
	for <lists+linux-integrity@lfdr.de>; Fri, 15 May 2020 11:30:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728164AbgEOJaO (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 15 May 2020 05:30:14 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:23209 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728150AbgEOJaN (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 15 May 2020 05:30:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589535011;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:in-reply-to:in-reply-to:  references:references;
        bh=7306oN4RwKYF0PhwXfWO57GL96EDQl+QO/STW6boOqc=;
        b=ZhsOZgkbH21tKolmzJqMlnEmyLTzKJv5Qtr+F5ofa98woTzpFT7ZhlrtldHYf8gMj1f4cD
        W726SytPgeuZ/BqGS5atdzjw/T22Bfk0tZbQmk+9Ud+5bjwXRqSokranMS0W900TZHTX2x
        ilEVyv/gKp7LgeAK0HLb1Gwi+fXmVdg=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-215-e_5LWnB-MdW1ae8e4yGLMQ-1; Fri, 15 May 2020 05:30:04 -0400
X-MC-Unique: e_5LWnB-MdW1ae8e4yGLMQ-1
Received: by mail-qt1-f197.google.com with SMTP id c20so1767051qtw.11
        for <linux-integrity@vger.kernel.org>; Fri, 15 May 2020 02:30:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to;
        bh=7306oN4RwKYF0PhwXfWO57GL96EDQl+QO/STW6boOqc=;
        b=EPBnIG8Rw/WzmTuS0HlYFzSdshxv8cLoGS+WzqO1L/P3o8FKaLZYaaD/TmAA03qPrh
         LeJx0zBUsenDC4HLYxwtjdepxYAW3NpruIiJEEPvqBAn3nC0lzPV7rENaThGH2vK9/DK
         3/OF6ktSLJd75ArBQPuubORLt625VOEKMp4jRU+alIKeCbR24KyHHrKhnj4B1n5A4p86
         ceSdp2i9Z31lWoF8sOTa8OEqbJzz4xwImVa0rIFVySeM26LAmwle73SBD18+0AQN19Yu
         vnyjK/pCwbz8eHdZvejYkKURlHCXyN4jbquZ4c9BadcaHVKC2IwX2/TlSmiQ0UPXDmI/
         tHAA==
X-Gm-Message-State: AOAM532Xmh/p1yUOCiDferuUPCW2ejBw2rrAyqIGHhePtv1tUky0UDfe
        NC2C1WY816qKGctUPDyiSWFoI0kKLh4JQx3aZhIhxvypdmkgb4T0Lcxsap5m2rDKzD/vN1R7RY8
        bOHGjVB3eBEvoAKQahxXBrXMzbckW
X-Received: by 2002:ac8:534b:: with SMTP id d11mr2386788qto.287.1589535003663;
        Fri, 15 May 2020 02:30:03 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwGkxVVdFCxQKI+koaF2YHjmJKBc1Il/J586ZA5MpaZ74xyJ2+vvxBqR5TBYyD9Ths/OS+yBw==
X-Received: by 2002:ac8:534b:: with SMTP id d11mr2386755qto.287.1589535003284;
        Fri, 15 May 2020 02:30:03 -0700 (PDT)
Received: from localhost (ip70-163-223-149.ph.ph.cox.net. [70.163.223.149])
        by smtp.gmail.com with ESMTPSA id g57sm1590345qtb.48.2020.05.15.02.30.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2020 02:30:02 -0700 (PDT)
Date:   Fri, 15 May 2020 02:30:00 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     James Bottomley <James.Bottomley@hansenpartnership.com>,
        linux-integrity@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>,
        David Woodhouse <dwmw2@infradead.org>,
        keyrings@vger.kernel.org, David Howells <dhowells@redhat.com>
Subject: Re: [PATCH v9 0/8] TPM 2.0 trusted keys with attached policy
Message-ID: <20200515093000.naogi4a7j22bzggz@cantor>
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

keyctl_read_alloc is in the userspace keyctl program, right?

git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/keyutils.git

