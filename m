Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D77EA658A9C
	for <lists+linux-integrity@lfdr.de>; Thu, 29 Dec 2022 09:42:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233238AbiL2Im0 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 29 Dec 2022 03:42:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbiL2ImZ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 29 Dec 2022 03:42:25 -0500
Received: from mail-vs1-xe2e.google.com (mail-vs1-xe2e.google.com [IPv6:2607:f8b0:4864:20::e2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24C131004D
        for <linux-integrity@vger.kernel.org>; Thu, 29 Dec 2022 00:42:24 -0800 (PST)
Received: by mail-vs1-xe2e.google.com with SMTP id d185so17889539vsd.0
        for <linux-integrity@vger.kernel.org>; Thu, 29 Dec 2022 00:42:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8wwcb3zcw25PWlBfSjjSAUxfSTg5XPlQN1zIA8ml2v4=;
        b=s1HmQgDU//Cm2CEjLa1IEPQvdZcGXcUjD9SRWGXTFcmMSzSJeyFo/iHLybNocVlSOl
         lkEbGJKlQanUjtrv8pHadm3IA89ez0Q6a6I7b04jr322QVT2/0/Nwb7QenDIVM3qnSaK
         RQqly6ReqMrMjOlWZ7szSQEOt6tfaNuzvIZ85DwDzefUxIzrajhIzBdsq0jah27NeyPG
         4oBqfHACmkyc6ZyOvEGyqsEdqtiLnqdlioZy308jsW5clUgGbc9RdDiAMVPPZKsVvIOv
         uLBhoU24yaqwiAZZKSTxIo/APdDSIs59MXTaCTmAzcQuOSrSIEMUKon5thIdggnMx/O0
         Pmbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8wwcb3zcw25PWlBfSjjSAUxfSTg5XPlQN1zIA8ml2v4=;
        b=UC94v6ruBQ05eJoO/9yUb0gEjAP5MEPWB9zQQeVcKkKE9LpodPrfS10agg1WjT8iLR
         uhGGzRnIEvy3OlyfLX7HHNThmlP1motSNOM2oiQdewwkBzSejIF3LfkfiqbHYZF94cTV
         TMiHsRk0HxykbWxJfkg95c2E1xL2Eo+rPMb30wxTpxMe86g3nDJPnQLCgv7mOnwA/kg5
         DCExLCgTEio/YTJdOKfY8Zwe6JSPc+BvQTDNj9U8Sbl6CpDg/jrJDAwWeO986YI8Ym26
         siCEoAE0NSuql31UwXpJrTlrGy4YEyT+mHCgaMZAMieKco9DO1td+7r0OBK1APYt6NNX
         /L0Q==
X-Gm-Message-State: AFqh2kr/uiiS/Crt+aLgyWgpuCoswwNdK/pw0Krczf0GXXyY+gYt61/N
        X8Mrc7Aug9ywkCrSTrCVHthcHzoJxpFLoOJuKOTCYCrIC715zM6F
X-Google-Smtp-Source: AMrXdXstRnTo4M/kI90KLKXSiYU38YEqTiZ/Quav/oTv/ya1brfaSEow838AmHseNlyqQxZx8WVV19w6CSuSfjiHPD8=
X-Received: by 2002:a67:ec92:0:b0:3c6:c5a3:9ad7 with SMTP id
 h18-20020a67ec92000000b003c6c5a39ad7mr1699835vsp.46.1672303343100; Thu, 29
 Dec 2022 00:42:23 -0800 (PST)
MIME-Version: 1.0
References: <CADg8p94+rY5B937YweMo=5aGS4Dhz2z4QW-BiAdkVdiWCm-u9w@mail.gmail.com>
 <3bd7c0b2c9937c30082381f92624e98902c72ece.camel@HansenPartnership.com>
 <CADg8p94qd-Kx9Xn2LwqypFeAsV734wv7CvswPmGqJZa+ENPpRg@mail.gmail.com> <2910376b6912885f696afebf43b820513c004dbb.camel@HansenPartnership.com>
In-Reply-To: <2910376b6912885f696afebf43b820513c004dbb.camel@HansenPartnership.com>
From:   Sughosh Ganu <sughosh.ganu@linaro.org>
Date:   Thu, 29 Dec 2022 14:12:12 +0530
Message-ID: <CADg8p94kTNkoByjLhEij3KkigLxhwU8PxnO82cRaO0Ejh7T3Zg@mail.gmail.com>
Subject: Re: Seal/Unseal trusted keys against PCR policy
To:     James Bottomley <James.Bottomley@hansenpartnership.com>
Cc:     linux-integrity@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

hi James,

On Thu, 29 Dec 2022 at 04:18, James Bottomley
<James.Bottomley@hansenpartnership.com> wrote:
>
> On Thu, 2022-12-29 at 02:10 +0530, Sughosh Ganu wrote:
> [...]
> > Thanks for your reply. For reloading the sealed key, I am trying to
> > start a policy session through the tpm2_startauthsession command,
> > followed by the tpm2_policypcr command to get the same policy digest.
> > However, I am not sure how to get the session handle. As per my
> > understanding, the policyhandle is a uint32_t object. However, none
> > of the above two commands give back the session handle. I tried the
> > tpm2_getcap command with the handles-saved-session, which shows a
> > handle once I have run the tpm2_startauthsession command. However,
> > providing this value to the keyctl command as policyhandle does not
> > work. Can you please point out what I am doing wrong?
>
> I'm afraid I gave up on the Intel toolkit long ago because of the
> constantly changing command options.  I can show you how to do it with
> the IBM toolkit, though:
>
> https://build.opensuse.org/package/show/security/ibmtss
>
> The main thing you have to do is connect to the TPM not through the
> resource manager so the policy session survives multiple commands
>
> export TPM_DEVICE=/dev/tpm0
>
> Then you can seal to say PCR7 which simply records the secure boot
> state:
>
> root@testdeb:~# cat /sys/class/tpm/tpm0/pcr-sha256/7
> 65CAF8DD1E0EA7A6347B635D2B379C93B9A1351EDC2AFC3ECDA700E534EB3068
>
> So you can now construct the policy exactly and ask policymaker what
> its hash is:
>
> root@testdeb:~# tsspolicymakerpcr -pr -bm 000080 -if /sys/class/tpm/tpm0/pcr-sha256/7 > tmp.policy
> root@testdeb:~# tsspolicymaker -if ~/tmp.policy -ns
> policy digest:
> 4cc48043aedaae487452bb407e8fc21d25c3a412ffc9473cf2552ddc659e97c1
>
> So now you know the policy hash, you can create a key
>
> root@testdeb:~# keyctl add trusted kmk "new 32 keyhandle=0x81000001 hash=sha256 policydigest=4cc48043aedaae487452bb407e8fc21d25c3a412ffc9473cf2552ddc659e97c1" @u
> 214245338
> keyctl pipe %trusted:kmk > key.tpm
> keyctl unlink %trusted:kmk
> 1 links removed
>
> Now you can reload it if you construct the correct policy
>
> root@testdeb:~# tssstartauthsession -se p
> Handle 03000000
> root@testdeb:~# tsspolicypcr -ha 03000000 -bm 000080
>
> Now you can check this policy register matches the hash you have above:
>
> root@testdeb:~# tsspolicygetdigest -ha 03000000
>  policyDigest length 32
>  4c c4 80 43 ae da ae 48 74 52 bb 40 7e 8f c2 1d
>  25 c3 a4 12 ff c9 47 3c f2 55 2d dc 65 9e 97 c1
>
> And you can now use this policy handle as the reload policy for the
> key:
>
> root@testdeb:~# keyctl add trusted kmk "load `cat ~/key.tpm` policyhandle=0x03000000" @u
> 872397032

I am able to unseal and load the key using the tss tools that you
pointed to above. Thanks a lot for your help! So the issue seems to be
that the Intel tpm2_startauthsession tool does not return the policy
handle, which the unseal operation expects. Not sure if I did
something wrong in using the tool, but fwiw, these are the steps that
I followed.

# tpm2_startauthsession -S session.ctx --policy-session
# tpm2_policypcr -S session.ctx -l sha256:10

The tpm2_policypcr returns the same policy digest that was generated
at the time of policy creation. So that is not an issue. But
tpm2_startauthsession does not return any handle value, it just
creates the session.ctx file.

-sughosh
