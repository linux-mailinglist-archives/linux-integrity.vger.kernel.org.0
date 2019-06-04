Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B565B34B5C
	for <lists+linux-integrity@lfdr.de>; Tue,  4 Jun 2019 17:02:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727776AbfFDPCI (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 4 Jun 2019 11:02:08 -0400
Received: from mail-ua1-f45.google.com ([209.85.222.45]:36655 "EHLO
        mail-ua1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727737AbfFDPCI (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 4 Jun 2019 11:02:08 -0400
Received: by mail-ua1-f45.google.com with SMTP id 94so7920998uam.3
        for <linux-integrity@vger.kernel.org>; Tue, 04 Jun 2019 08:02:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=ihaGGwLZm4n7dzcZPAp4qZkGrRbYpzyI3wuleSWYYGA=;
        b=J6SVJIfx+NSSl9Giwz0vhuIScxC9ZlcX2Bj4onP2xE/QbCGOH+wQ/jTruXCvkK2/l/
         sz+Qn9LJK9JBch3R4u275pWl0PDEhoBue7BKpHGKdiqngZ0GKILqZsYOjBFEgTK6MmJQ
         BiLwiNuoQzxTV7oDzO2hI4uByDYCydsTgRvd8E2YyOsKyPzLs+npk9MD8nVcPnbRnSjN
         P3uMd7q0O/NSUTOsecmASYocgVtaEQphnxGN84eiklFmVNJwCL6gE5E8CX2f5swUp4qP
         9BpNRAnc4i8MyII/K/x3vDi9fsOAn+/2r+Nrf/CnzqZ0e3ejlOIro1BRECShJJOYFM76
         sR4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=ihaGGwLZm4n7dzcZPAp4qZkGrRbYpzyI3wuleSWYYGA=;
        b=cLfYxD6AP4sAQd+vr9R1wEyxwtJDRTjga42InF1Q9k6TvqE0twCW5ah6BOc+b0omCm
         RzPVaUwrX8uBVnfGjY6F/KpF+7HKjLJaBHkMnex7EXAsw5IIIsgGLYD+gFyrQPA1eHc6
         8F6VMU7UELJT79whUSEp27VhnbV3LE7IAOIa7dBf19sp+B3+GkA835HmJ4hLe2p2Y9Ym
         6VgQ0aLadVXxMhHS2u2+DntEY5cIFvoRkrC5wzzd9D74Xik+ndpx0lZzYks2+v7mAarU
         ySXcLptu5fQZf1+QI31XlNmhFw4/5sTHCBl6RMWq/+x3ToxFF7u/yMegQdpKeakK3jaS
         neNg==
X-Gm-Message-State: APjAAAWrsuAPtmvxJhKjIC0/VUYGmmbCSrGlpClc1dpt8OJWRTNxcW9H
        oS3Sl51Ixrg++OL0qCBxFrwYlTreuK5TibeukgOrs+Ys
X-Google-Smtp-Source: APXvYqygJmK+c6zZV4My4Lz0W5Up0UmV6fOjzQlyCuo3f0qqoUWIehUflcpOoBEVyDiOl6QbauBQcBsDbb5+FUirHms=
X-Received: by 2002:ab0:698f:: with SMTP id t15mr6325052uaq.34.1559660527396;
 Tue, 04 Jun 2019 08:02:07 -0700 (PDT)
MIME-Version: 1.0
From:   Martin Townsend <mtownsend1973@gmail.com>
Date:   Tue, 4 Jun 2019 16:01:56 +0100
Message-ID: <CABatt_ztdnRn7ZU1ap0Kf-coA3GRRCDTZ0z=c6yMUToFuayUAA@mail.gmail.com>
Subject: evmctl and Hardware Security Module
To:     linux-integrity@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi,

I'm hoping that someone with knowledge of evmctl is on this list and
can help.  I want to modify evmctl to use a HSM to perform the
signature generation side of things.  My first attempt, which is the
easiest option, was to just replace

len = RSA_private_encrypt(sizeof(sighash), sighash, sig + sizeof(*hdr)
+ 2, key, RSA_PKCS1_PADDING);

in sign_hash_v2 with a call to C_Encrypt from the Cryptoki API but
sadly this failed as I think the private key has been marked as not
being able to encrypt.  The call returns
CKR_KEY_FUNCTION_NOT_PERMITTED.  If I try the public key it's encrypts
happily.  I tried setting CKA_ENCRYPT on the private key but, and
quite rightly, it wouldn't let me.

So the next option is to try and perform the signature generation in
the HSM which is a bit more involved.  Before attempting, I was
wondering whether this is possible or there is something in the way
the signatures are generated that means that this just isn't going to
work? I ask as I see that it prepends the ASN1 encoded message of what
hash function was used to the actual hash. Would the HSM sign function
do exactly the same if I use RSA_PKCS1_PADDING?

Many Thanks in advance,
Martin.
