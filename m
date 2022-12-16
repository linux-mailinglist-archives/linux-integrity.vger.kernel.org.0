Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06F0F64ECA7
	for <lists+linux-integrity@lfdr.de>; Fri, 16 Dec 2022 15:10:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230437AbiLPOKT (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 16 Dec 2022 09:10:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230064AbiLPOKJ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 16 Dec 2022 09:10:09 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C8732B62C
        for <linux-integrity@vger.kernel.org>; Fri, 16 Dec 2022 06:09:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671199759;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RA/Yc5ZHRE6FrNcZRlkstCVubCNeOdRMPGJUgVDRano=;
        b=XY7mVvZH+7mD/tfFbb91W0qO3IYwHqKDnxL3RP2rR3TfEzLmXtyBmk3x0VGbgtBx5ENCk4
        2L8T75VfGW4lGDUU5G53v18Qmn1VfwtwnKobxAyT/kVcmUxLLSJfWh7nVBKGKqiCdMbD3D
        LXGtZvt+oFvIB1MmjZkAT+LH+W4aszw=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-570-U9VzwBfqNWmoNdf5VKO8LA-1; Fri, 16 Dec 2022 09:09:17 -0500
X-MC-Unique: U9VzwBfqNWmoNdf5VKO8LA-1
Received: by mail-pl1-f200.google.com with SMTP id z3-20020a170903018300b0018fb8ca1688so1772621plg.5
        for <linux-integrity@vger.kernel.org>; Fri, 16 Dec 2022 06:09:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RA/Yc5ZHRE6FrNcZRlkstCVubCNeOdRMPGJUgVDRano=;
        b=iTt1uwtksB6u8Ux1+7OBybnZ+oAfXJ8RhjHx/zMWXsfvLS/VOaltMX+tQxsm1khN0U
         TUl9B4i/FyiwNcUAELWjJXjc/PSNOAZ2imaOmW3FmQeh189GRgT86lw1uizf7W3maUX4
         MqtIm+iCBhS650KIGxvs9k2X/2l68bSjeWbSexocQqPwjMMfGEJm07ZiToUZbJlAcIjy
         ZSRn7q+eOMh2jhbsqsI/9XjO2ecpIoWaoT9J+bUPYbAtQhjjhRXYtmPeAl3fwaaihG5P
         E+3vg6cyf7xaKigwgDFFD4lEHKr3R2aFoMcH3zFKSMc7DXrNjEqi56er6aZXQEN9t1Pz
         cRhA==
X-Gm-Message-State: ANoB5pnSIuMqXh/txnK2MuGi8TLwNdF9inzSwrLQATHAG0ESI374JSVR
        pUixPh48g67N+4m4wM9VX+oOgIvtxXeJGrThVC6TQh9iiBjMbodNB/xcV6xw7XTrvxe2g0BxfsD
        fa0tm3Cuab/f4AbgWw0PMcJGbi6+q
X-Received: by 2002:a05:6a21:999d:b0:9d:efd3:66f2 with SMTP id ve29-20020a056a21999d00b0009defd366f2mr49385978pzb.57.1671199756394;
        Fri, 16 Dec 2022 06:09:16 -0800 (PST)
X-Google-Smtp-Source: AA0mqf4QvH51tl1mP7UPtNO+GFRJLHBLli6PFxppfCqFl8Wt05sNUw4tDC0RTAnYyFUqUPkWRn6nSA==
X-Received: by 2002:a05:6a21:999d:b0:9d:efd3:66f2 with SMTP id ve29-20020a056a21999d00b0009defd366f2mr49385943pzb.57.1671199755949;
        Fri, 16 Dec 2022 06:09:15 -0800 (PST)
Received: from localhost ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id l10-20020a63f30a000000b00470275c8d6dsm1515027pgh.10.2022.12.16.06.09.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Dec 2022 06:09:15 -0800 (PST)
Date:   Fri, 16 Dec 2022 22:06:48 +0800
From:   Coiby Xu <coxu@redhat.com>
To:     Eric Snowberg <eric.snowberg@oracle.com>,
        Mimi Zohar <zohar@linux.ibm.com>
Cc:     Jarkko Sakkinen <jarkko@kernel.org>,
        David Howells <dhowells@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>,
        "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "dmitry.kasatkin@gmail.com" <dmitry.kasatkin@gmail.com>,
        "paul@paul-moore.com" <paul@paul-moore.com>,
        "jmorris@namei.org" <jmorris@namei.org>,
        "serge@hallyn.com" <serge@hallyn.com>,
        "pvorel@suse.cz" <pvorel@suse.cz>,
        "noodles@fb.com" <noodles@fb.com>, "tiwai@suse.de" <tiwai@suse.de>,
        Kanth Ghatraju <kanth.ghatraju@oracle.com>,
        Konrad Wilk <konrad.wilk@oracle.com>,
        Elaine Palmer <erpalmer@linux.vnet.ibm.com>,
        "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>
Subject: Re: [PATCH v3 00/10] Add CA enforcement keyring restrictions
Message-ID: <20221216140648.h32gn5qf3igorpzi@Rk>
References: <20221214003401.4086781-1-eric.snowberg@oracle.com>
 <b8e54d077da633132eb6da03ea536face095a425.camel@linux.ibm.com>
 <4CE6F17D-9D87-4024-9E1A-FDFE7C29D5FC@oracle.com>
 <1c51910a35a1d113256494827fd66ccc7473632e.camel@linux.ibm.com>
 <17855993-519C-4DAC-B62F-9DB473CF249B@oracle.com>
 <7df94da37c100c160436892a6996ba30e3fd6dc8.camel@linux.ibm.com>
 <21E52C3E-0778-4908-AF44-F65D57BEC4E0@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <21E52C3E-0778-4908-AF44-F65D57BEC4E0@oracle.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Eric and Mimi,

On Thu, Dec 15, 2022 at 09:45:37PM +0000, Eric Snowberg wrote:
>
>
>>>>>>> A CA cert shall be defined as any X509 certificate that contains the
>>>>>>> keyCertSign key usage and has the CA bit set to true.
>>>>>>
>>>>>> Hi Eric,
>>>>>>
>>>>>> Allowing CA certificates with the digitalSignature key usage flag
>>>>>> enabled defeats the purpose of the new Kconfig.  Please update the
>>>>>> above definition to exclude the digitalSignature key usage flag and
>>>>>> modify the code accordingly.
>>>>>
>>>>> Within v2, the request was made to allow Intermediate CA certificates to be
>>>>> loaded directly.  The Intermediate CA referenced was the one used by kernel.org.
>>>>> This Intermediate CA contains both digitalSignature and keyCertSign.  If the code
>>>>> is changed to exclude this certificate, now the root CA has to be loaded again.  Is that
>>>>> the intent?
>>>>
>>>> That definitely was not the intent.  Nor would it address the issue of
>>>> a particular intermediate CA certificate having both keyCertSign and
>>>> digitalSignature.
>>>
>>> Sorry, I’m not following.  Why is it an issue that an intermediate CA certificate contains
>>> both keyCertSign and digitalSignature? Why would we want to exclude an Intermediate
>>> CA cert like the one used on kernel.org?
>>
>> I must be missing something.  Isn't the purpose of "keyUsage" to
>> minimize how a certificate may be used?   Why would we want the same
>> certificate to be used for both certificate signing and code signing?
>
>Every 3rd party intermediate CA I have looked at so far contains both set. Most have CRLSign set.
>Typically the root CA contains keyCertSign and CRLSign, but some also have digitalSignature
>set.  Finding a 3rd party Intermediate CA without digitalSignature set is probably going to be
>challenging and will severely limit usage.

How about allowing both keyCertSign and digitalSignature asserted but
issuing a warning for this case?

Here's my rationale for this proposal.

I assume we should conform to some X.509 specifications. So I checked
"RFC 5280: Internet X.509 Public Key Infrastructure Certificate and
Certificate Revocation List (CRL) Profile" [1] and ITU-T X.509 (2012-10)
[2].

[1] states in 4.2.1.3. Key Usage,
    "If the keyUsage extension is present, then the subject public key
    MUST NOT be used to verify signatures on certificates or CRLs unless
    the corresponding keyCertSign or cRLSign bit is set.  If the subject
    public key is only to be used for verifying signatures on
    certificates and/or CRLs, then the digitalSignature and
    nonRepudiation bits SHOULD NOT be set.  However, the digitalSignature
    and/or nonRepudiation bits MAY be set in addition to the keyCertSign
    and/or cRLSign bits if the subject public key is to be used to verify
    signatures on certificates and/or CRLs as well as other objects."

and [2] states in 8.2.2.3 Key usage extension that,
   "More than one bit may be set in an instance of the keyUsage extension.
   The setting of multiple bits shall not change the meaning of each
   individual bit but shall indicate that the certificate may be used for
   all of the purposes indicated by the set bits. There may be risks
   incurred when setting multiple bits. A review of those risks is
   documented in Annex I."

I interpret the above texts as we should allow both keyCertSign and
digitalSignature. However [2] warns about the risks of setting multiple
bits. Quoting Annex I,

   "Combining the contentCommitment bit in the keyUsage certificate
   extension with other keyUsage bits may have security implications
   depending on the security environment in which the certificate is to be
   used. If the subject's environment can be fully controlled and trusted,
   then there are no specific security implications. For example, in cases
   where the subject is fully confident about exactly which data is signed
   or cases where the subject is fully confident about the security
   characteristics of the authentication protocol being used. If the
   subject's environment is not fully controlled or not fully trusted, then
   unintentional signing of commitments is possible. Examples include the
   use of badly formed authentication exchanges and the use of a rogue
   software component. If untrusted environments are used by a subject,
   these security implications can be limited through use of the following
   measures:   
    – to not combine the contentCommitment key usage setting in
      certificates with any other key usage setting and to use the
      corresponding private key only with this certificate;   
      
    – to limit the use of private keys associated with certificates that
      have the contentCommitment key usage bit set, to environments which
      are considered adequately controlled and trustworthy"

So maybe it's useful to add a warning if both keyCertSign and
digitalSignature are asserted.


-- 
Best regards,
Coiby

