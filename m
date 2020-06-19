Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3A4A201E3A
	for <lists+linux-integrity@lfdr.de>; Sat, 20 Jun 2020 00:50:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729612AbgFSWub (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 19 Jun 2020 18:50:31 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:27090 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729577AbgFSWua (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 19 Jun 2020 18:50:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592607028;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:in-reply-to:in-reply-to:  references:references;
        bh=asajOs/B7wU/35zztVXUrU53aHo3MNVOYGFjzslgDxI=;
        b=UEoB+z2BfTWwKJwkR18pW00xwp8HCp699zIrTWcXZVkHwz29kfuxu6evRnu9hWs9IpUyBe
        Baz6vlMoRIH1LRusG+OS/+cO560yRrR2Vuk7pGLQHm0tGjqexVtu0DsOjLrwYHpJ46zx5t
        6c+f80A4QjkF7q/scMbw8rK4HMpp6Tg=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-418-IoklGAchN--zASFUOYVpqg-1; Fri, 19 Jun 2020 18:50:27 -0400
X-MC-Unique: IoklGAchN--zASFUOYVpqg-1
Received: by mail-qt1-f200.google.com with SMTP id c22so8314276qtp.9
        for <linux-integrity@vger.kernel.org>; Fri, 19 Jun 2020 15:50:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to;
        bh=asajOs/B7wU/35zztVXUrU53aHo3MNVOYGFjzslgDxI=;
        b=RlHE/dzNGJWXRPb+BE7a+W7TGw3OzSYyPIV4CiIDXbKBHTBjp01szNltPlcmvg/0G6
         MfcmME01eK/dfZMW6SSlOPAj/7PRmaymu5UwPLp4cfoVOWwKlqxAQOFA8tgCnOXe7xWx
         XTiAN7Ew9OQfmmYVx7k0h7NQJ9SVV2Q30c53b407f8T4tiGBVi8Vw91bEbYiKFMdmBI+
         V1OVfrNE5a7ntcbI3pP0sEonGhM+6UnnHHmQu+fc6DOIDTeRuPVVyjrNZlEoUMLF0eQO
         Rqwr843OZZW4Xd31RFnbr1aiFO+87UlyyCK2aORGGpoN1VlHButA1LzIY9F+HaW5wpV/
         1d+g==
X-Gm-Message-State: AOAM532Fkyli4EsRTQ91zZ5jk09ICsfQCl4iaGhA07ecV/8KUGF5vfCv
        OKLPUp3oSOgDjAej2ZuM6cl3w5hfT94NEBsZAY0M/NVneUbfpDLkK/Y7q5MBWoazvV/zyCGiajv
        xBjDVA20iwN4z7VQMnXfHJyEiBy+6
X-Received: by 2002:aed:3768:: with SMTP id i95mr5787902qtb.58.1592607026521;
        Fri, 19 Jun 2020 15:50:26 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzekmtu/p8vlcbNmM6YAFuhRMVIDjgvJysKokyrmv893YX5RrDch70n9+ZFcWXQ05B0XCMxpw==
X-Received: by 2002:aed:3768:: with SMTP id i95mr5787886qtb.58.1592607026271;
        Fri, 19 Jun 2020 15:50:26 -0700 (PDT)
Received: from localhost (ip70-163-223-149.ph.ph.cox.net. [70.163.223.149])
        by smtp.gmail.com with ESMTPSA id h19sm7929507qkj.109.2020.06.19.15.50.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2020 15:50:25 -0700 (PDT)
Date:   Fri, 19 Jun 2020 15:50:24 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     "Wiseman, Monty (GE Research, US)" <monty.wiseman@ge.com>
Cc:     David Woodhouse <dwmw2@infradead.org>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Subject: Re: [PATCH 3/8] oid_registry: Add TCG defined OIDS for TPM keys
Message-ID: <20200619225024.kmhdqe25cmgaq5e4@cantor>
Reply-To: Jerry Snitselaar <jsnitsel@redhat.com>
References: <1575781600.14069.8.camel@HansenPartnership.com>
 <1575781746.14069.11.camel@HansenPartnership.com>
 <194d8ba601b9ecb43e812445729c6270e9f32162.camel@infradead.org>
 <26ED11907FC0F446BB0296B5357EEF0E316CDBB0@CINMBCNA02.e2k.ad.ge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <26ED11907FC0F446BB0296B5357EEF0E316CDBB0@CINMBCNA02.e2k.ad.ge.com>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri Jun 19 20, Wiseman, Monty (GE Research, US) wrote:
>James,
>
>> -----Original Message-----
>> From: David Woodhouse <dwmw2@infradead.org>
>> Sent: December 9, 2019 03:56 AM
>> To: James Bottomley <James.Bottomley@HansenPartnership.com>; linux-
>> integrity@vger.kernel.org; Wiseman, Monty (GE Global Research, US)
>> <monty.wiseman@ge.com>
>> Cc: Mimi Zohar <zohar@linux.ibm.com>; Jarkko Sakkinen
>> <jarkko.sakkinen@linux.intel.com>
>> Subject: EXT: Re: [PATCH 3/8] oid_registry: Add TCG defined OIDS for TPM
>> keys
>>
>> On Sat, 2019-12-07 at 21:09 -0800, James Bottomley wrote:
>> > The TCG has defined an OID prefix "2.23.133.10.1" for the various TPM
>> > key uses.  We've defined three of the available numbers:
>> >
>> > 2.23.133.10.1.3 TPM Loadable key.  This is an asymmetric key (Usually
>> > 		RSA2048 or Elliptic Curve) which can be imported by a
>> > 		TPM2_Load() operation.
>> >
>> > 2.23.133.10.1.4 TPM Importable Key.  This is an asymmetric key (Usually
>> > 		RSA2048 or Elliptic Curve) which can be imported by a
>> > 		TPM2_Import() operation.
>> >
>> > Both loadable and importable keys are specific to a given TPM, the
>> > difference is that a loadable key is wrapped with the symmetric
>> > secret, so must have been created by the TPM itself.  An importable
>> > key is wrapped with a DH shared secret, and may be created without
>> > access to the TPM provided you know the public part of the parent key.
>> >
>> > 2.23.133.10.1.5 TPM Sealed Data.  This is a set of data (up to 128
>> > 		bytes) which is sealed by the TPM.  It usually
>> > 		represents a symmetric key and must be unsealed before
>> > 		use.
>>
>> Do we still not have an official reference for these that you can
>> provide in the commit or the file itself?
>>
>> It would be very nice to have something more than a verbal assurance
>> that they're in Monty's spreadsheet.
>>
>>
>> > Signed-off-by: James Bottomley
>> <James.Bottomley@HansenPartnership.com>
>> > ---
>> >  include/linux/oid_registry.h | 5 +++++
>> >  1 file changed, 5 insertions(+)
>> >
>> > diff --git a/include/linux/oid_registry.h b/include/linux/oid_registry.h
>> > index 657d6bf2c064..a4cee888f9b0 100644
>> > --- a/include/linux/oid_registry.h
>> > +++ b/include/linux/oid_registry.h
>> > @@ -107,6 +107,11 @@ enum OID {
>> >  	OID_gostTC26Sign512B,		/* 1.2.643.7.1.2.1.2.2 */
>> >  	OID_gostTC26Sign512C,		/* 1.2.643.7.1.2.1.2.3 */
>> >
>> > +	/* TCG defined OIDS for TPM based keys */
>> > +	OID_TPMLoadableKey,		/* 2.23.133.10.1.3 */
>> > +	OID_TPMImporableKey,		/* 2.23.133.10.1.4 */
>> > +	OID_TPMSealedData,		/* 2.23.133.10.1.5 */
>> > +
>> >  	OID__NR
>> >  };
>> >
>Bring back an old thread.  We are finally getting the TCG OID registry ready
>to publish and wanted to verifier the OIDs you requested and we assigned
>above.
>
>I can find 2.23.133.10.1.3 TPM Loadable key in the tpm2-tss-engine project.
>
>I do not see this one, nor the others list above in the kernel source. Did
>these ever
>get used? If so, where and can you provide a use case for a relying party?
>
>Also, I have in my local spreadsheet the following which I believe were just
>drafts and never assigned. Please confirm.
>2.23.133.10.1.1.2
>Secondary Identifier: tcg-wellKnownAuthValue
>
>This in intended to be bitmap of well-known authValues. This is not intended
>to contain an actual authValue. For example. Bit 1 means and authValue of
>hashsize all zeros, Bit 2 means an authValue of hashsize all NULLs, etc.
>[Note: Bit 1 is lsb in this notation]
>
>2.23.133.10.1.1.3
>No secondary identifier or description
>
>2.23.133.10.1.1.4
>No secondary identifier or description
>
>
>Monty Wiseman
>Principal Engineer, Security Architecture
>Controls & Optimization

Hi Monty,

The patchset is still being reviewed and discussed:

https://lore.kernel.org/linux-integrity/20200616160229.8018-3-James.Bottomley@HansenPartnership.com/

