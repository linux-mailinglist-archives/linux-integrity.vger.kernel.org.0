Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B8E2037724
	for <lists+linux-integrity@lfdr.de>; Thu,  6 Jun 2019 16:50:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728876AbfFFOuZ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 6 Jun 2019 10:50:25 -0400
Received: from mail-vs1-f53.google.com ([209.85.217.53]:45040 "EHLO
        mail-vs1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728958AbfFFOuV (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 6 Jun 2019 10:50:21 -0400
Received: by mail-vs1-f53.google.com with SMTP id v129so1351597vsb.11
        for <linux-integrity@vger.kernel.org>; Thu, 06 Jun 2019 07:50:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=C3bKAUz/ZAqzArCBYaNOadKHvWfElQL/zXU+h864QZU=;
        b=sx/0k25lNq/Md3+9olSSFZJ5R3974E17B+LQOkcUqQIYM6Df4mHn1gBRX5Rrzg+s1x
         6QZPtUHFpgSE6sKEci05mWzyumIpbQIAHmGAxdBNNxowoLJR++b9bv+HsAuzTldbDxu1
         VBmIIBfdxvUpD3wwN6UFhIeuyDGSNbCjrMs3kgiKnf9kpPNtbsR+mfYO1Om4no4/7p7i
         P9zGsCgozPuXVhUsjpr8j7wcyTNvWvQo7jmgHTrHSvZwt9P7FWvyq99Xpw6jNy3I5dHE
         9Qvf8v3ZANyD0bHovq8aVFCWMSX/GUoeXVJ8j0g0a3zLIy9NelFrOYsMn25PqmGJgPWS
         opjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=C3bKAUz/ZAqzArCBYaNOadKHvWfElQL/zXU+h864QZU=;
        b=TOSiIXVO7HA+0ZezDyjvx3R7RMoF16/sY0domIJBB/AENu6qou5Jfa1oa+PGJu94jP
         ZqZrWniPYpaTEvsCsV5lMBAJYPD+e4zQVpvYOWFtwB2YcAKbV27PjSC1bP2mHk4CK7GF
         00PTV3IR2ZFT99i5f7F8mG507cJKpJaKAmq2BYFik2qskxj4DUkMOVTUf+EPMhDgwNJ5
         ChxXpqDtuNJKcvsg87/afR6YCPqGdaBuCdiTYhkUrfKb9dVhIWTnlanIQb1nxFEiUUeo
         vV6XIKn/oh9IsUjH30iy4/K2O8XW7D/0WgMfRFyiszzgRuM2aygY4xQyDvu/+RQUnr0f
         BV2Q==
X-Gm-Message-State: APjAAAVuB2roMXBnB/rr6FoQn7LPbkr8CvYE6H8F/iTvSR5SMj9oqM3z
        0Vdrfo4kcWz+9yHC0NHIgC9K4O5yAsWbkGi68/P6TUDWCUE=
X-Google-Smtp-Source: APXvYqxgJ/FRa5uQKj3o/eQHidqnTyXG4OrYufr0zhde+dKYqOMO2CCVnMuNa2SdM6u/WU6jxqz2an0Cf7L/BO3U2xI=
X-Received: by 2002:a67:ce11:: with SMTP id s17mr18574675vsl.129.1559832619647;
 Thu, 06 Jun 2019 07:50:19 -0700 (PDT)
MIME-Version: 1.0
References: <CABatt_ztdnRn7ZU1ap0Kf-coA3GRRCDTZ0z=c6yMUToFuayUAA@mail.gmail.com>
In-Reply-To: <CABatt_ztdnRn7ZU1ap0Kf-coA3GRRCDTZ0z=c6yMUToFuayUAA@mail.gmail.com>
From:   Martin Townsend <mtownsend1973@gmail.com>
Date:   Thu, 6 Jun 2019 15:50:08 +0100
Message-ID: <CABatt_wCJM0G6w5q+46ca58SePq45uqkriOa9wug3tsbWKHMzw@mail.gmail.com>
Subject: Re: evmctl and Hardware Security Module
To:     linux-integrity@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Jun 4, 2019 at 4:01 PM Martin Townsend <mtownsend1973@gmail.com> wrote:
>
> Hi,
>
> I'm hoping that someone with knowledge of evmctl is on this list and
> can help.  I want to modify evmctl to use a HSM to perform the
> signature generation side of things.  My first attempt, which is the
> easiest option, was to just replace
>
> len = RSA_private_encrypt(sizeof(sighash), sighash, sig + sizeof(*hdr)
> + 2, key, RSA_PKCS1_PADDING);
>
> in sign_hash_v2 with a call to C_Encrypt from the Cryptoki API but
> sadly this failed as I think the private key has been marked as not
> being able to encrypt.  The call returns
> CKR_KEY_FUNCTION_NOT_PERMITTED.  If I try the public key it's encrypts
> happily.  I tried setting CKA_ENCRYPT on the private key but, and
> quite rightly, it wouldn't let me.
>
> So the next option is to try and perform the signature generation in
> the HSM which is a bit more involved.  Before attempting, I was
> wondering whether this is possible or there is something in the way
> the signatures are generated that means that this just isn't going to
> work? I ask as I see that it prepends the ASN1 encoded message of what
> hash function was used to the actual hash. Would the HSM sign function
> do exactly the same if I use RSA_PKCS1_PADDING?
>
> Many Thanks in advance,
> Martin.

I now have it working.  In case anyone else stumbles across this and
wants to do the same thing you can call C_Sign() in the Cryptoki API
and use the CKM_RSA_PKCS mechanism

CK_MECHANISM rsa_mech = {
    .mechanism = CKM_RSA_PKCS,
    .pParameter = NULL_PTR,
    .ulParameterLen = 0
};

With this mechanism the HSM will perform the Padding and encryption
part of the signing but not perform any hash function so in effect
performing the the same as the RSA_private_encrypt call.

-Martin
