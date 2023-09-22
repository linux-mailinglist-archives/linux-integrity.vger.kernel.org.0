Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EAB47AA87B
	for <lists+linux-integrity@lfdr.de>; Fri, 22 Sep 2023 07:42:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230404AbjIVFmu (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 22 Sep 2023 01:42:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229713AbjIVFmq (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 22 Sep 2023 01:42:46 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C30D3192
        for <linux-integrity@vger.kernel.org>; Thu, 21 Sep 2023 22:41:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695361304;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=w1g43mhqJbkov4+o/9sy0UqgCm25IRVOc1Rtq6HxOfs=;
        b=Wq9C4/aiZZ3GjNdhyyiVCUu/hBWE3NNTxN2KKLx0iat5fdd8S7ZPgd2s4/eLH0h+gbJjel
        lLAc0fcK8JKjMWTPAA6p6kgGAZ5mEz8Jxm0+1uLciJ1w0OY6GgTv4u1AxOw4cFHPy9XM+F
        6yw5s0fYd1Hcp/hanxvBtEmaABRsfyI=
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com
 [209.85.166.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-44-hToJzCsSPLOOq5MupIGkkw-1; Fri, 22 Sep 2023 01:41:43 -0400
X-MC-Unique: hToJzCsSPLOOq5MupIGkkw-1
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-79f7a3e5dd2so40446839f.0
        for <linux-integrity@vger.kernel.org>; Thu, 21 Sep 2023 22:41:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695361302; x=1695966102;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w1g43mhqJbkov4+o/9sy0UqgCm25IRVOc1Rtq6HxOfs=;
        b=SF8upaxpYFxaos7u7KNtjdJhHRppRAwEIOZuN6gtE03SK0rvC6CuEmEGehZNymF08/
         hTI7D2zEv0h/1k1h6q8CJMAh2V0UTAEjec6BZ88TOH6FFI07Ky8THgMncjh55Eqylit7
         cZmNaBOq5Iwq+9LzHeF7S9uMo8kGaecVEL2/ASsAQPOp9/kPzYTsm3G4Eu6ZqlWftfm0
         2AEDu1libm0+Pb04w+SCV26tiCi8x1WkrOZeZdPCKuFWMaR6RSsjj5SS3yWDL7Mtm3tW
         vTz0VVBcSgOPO7iB0ie+H2RdUrYIVK2HIEJ8hBmZ5R11D7lam8czOGYNC7E980Lw5xKn
         tehw==
X-Gm-Message-State: AOJu0YwzYIsPTN8HdJ5a2FKpjs0Rc2FN0fqlmgq4Yje4tdiLIwXPyapA
        Cg+v0YNfqku2aX80yL2A4gYAnWzTdpyXoNCsdPzKjkYiVhZ7cnEYiZaAaPd5+ImDiFrws25ghCE
        qLTrQkxhlAT2fAANP+5iLKBa2haadHx8O4NqO5QFT+Itn
X-Received: by 2002:a05:6e02:78e:b0:34e:2a69:883c with SMTP id q14-20020a056e02078e00b0034e2a69883cmr8337988ils.1.1695361302716;
        Thu, 21 Sep 2023 22:41:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE7U4ewOt9pYuaiF1z9N4YP0emAqNw0+efBuWJO/E+lbDyczzOUW+FIWgqK+FH1Y4BNMPXHNG22j7U9dWvcSwI=
X-Received: by 2002:a05:6e02:78e:b0:34e:2a69:883c with SMTP id
 q14-20020a056e02078e00b0034e2a69883cmr8337962ils.1.1695361302436; Thu, 21 Sep
 2023 22:41:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230921133703.39042-1-kernelfans@gmail.com> <ZQ0j6Es88aR8cjRv@desktop>
In-Reply-To: <ZQ0j6Es88aR8cjRv@desktop>
From:   Dave Young <dyoung@redhat.com>
Date:   Fri, 22 Sep 2023 13:41:22 +0800
Message-ID: <CALu+AoQHZOBcbCJJnhSyEcTyX6C3VttLxMKt2mdHgT7A6xHN9w@mail.gmail.com>
Subject: Re: [PATCH 0/2] Sign the Image which is zboot's payload
To:     Jan Hendrik Farr <kernel@jfarr.cc>
Cc:     Pingfan Liu <kernelfans@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-efi@vger.kernel.org,
        kexec@lists.infradead.org, Pingfan Liu <piliu@redhat.com>,
        Baoquan He <bhe@redhat.com>, Philipp Rudo <prudo@redhat.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, keyrings@vger.kernel.org,
        Luca Boccassi <bluca@debian.org>, lennart@poettering.net,
        Jarkko Sakkinen <jarkko@kernel.org>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, mjg59@google.com,
        James.Bottomley@hansenpartnership.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Jan,

On Fri, 22 Sept 2023 at 13:19, Jan Hendrik Farr <kernel@jfarr.cc> wrote:
>
> Hi Pingfan!
>
> On 21 21:37:01, Pingfan Liu wrote:
> > From: Pingfan Liu <piliu@redhat.com>
> >
>
> > For security boot, the vmlinuz.efi will be signed so UEFI boot loader
> > can check against it. But at present, there is no signature for kexec
> > file load, this series makes a signature on the zboot's payload -- Image
> > before it is compressed. As a result, the kexec-tools parses and
> > decompresses the Image.gz to get the Image, which has signature and can
> > be checked against during kexec file load
>
> I missed some of the earlier discussion about this zboot kexec support.
> So just let me know if I'm missing something here. You were exploring
> these two options in getting this supported:
>
> 1. Making kexec_file_load do all the work.
>
> This option makes the signature verification easy. kexec_file_load
> checks the signature on the pe file and then extracts it and does the
> kexec.
>
> This is similar to how I'm approaching UKI support in [1].
>
> 2. Extract in userspace and pass decompressed kernel to kexec_file_load
>
> This options requires the decompressed kernel to have a valid signature on
> it. That's why this patch adds the ability to add that signature to the
> kernel contained inside the zboot image.
>
> This option would not make sense for UKI support as it would not
> validate the signature with respect to the initrd and cmdline that it
> contains.

Another possibility for the cmdline could be using the bootconfig
facility which was
introduced for boot time tracking:
Documentation/admin-guide/bootconfig.rst

So the initrd+cmdline can be signed as well.  Has this been discussed
before for UKI?

Thanks
Dave

