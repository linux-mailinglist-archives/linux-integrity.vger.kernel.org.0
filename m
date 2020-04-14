Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7911E1A764C
	for <lists+linux-integrity@lfdr.de>; Tue, 14 Apr 2020 10:40:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436995AbgDNIkn (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 14 Apr 2020 04:40:43 -0400
Received: from mout.web.de ([212.227.17.11]:59063 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2436988AbgDNIkk (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 14 Apr 2020 04:40:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1586853617;
        bh=hEj77XzExxM86gI+aD2VvXjn7SHjDcbARJFDPiuH/R0=;
        h=X-UI-Sender-Class:To:Cc:Subject:From:Date;
        b=P/2e9Sa0kM2GoAAYWir5qWkURwxu2KmfpwUB81hJlR4ZNBL/ZgVZ3gaNgUK/tOI73
         HaWl/cs0phhKfHmIaFRb8agud5QLG3J9hKLF9PULWgGWXpvT/fSfkxtINrPslO35Dn
         n5m/14UORJhjB/eBmt/hu0xmHMZjLdWVa98nNzfg=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.3] ([78.49.66.171]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0M5g0a-1j4XGr0goK-00xann; Tue, 14
 Apr 2020 10:40:17 +0200
To:     Zou Wei <zou_wei@huawei.com>, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        James Morris <jmorris@namei.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        "Serge E. Hallyn" <serge@hallyn.com>
Subject: Re: [PATCH -next] IMA: Fix a memdup.cocci warning
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <87ca047f-2b4b-313c-c8da-231c16d7277b@web.de>
Date:   Tue, 14 Apr 2020 10:40:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:MRYClenv3hRQ+J2VLmKxK5LNF2eDInoBHxgx5ptYlRpbyzfWZDE
 makOXI8slNtgjfwAw/IVQ5w3FgVHT9vynUAaoeGop2cY4ZtSLi6wu9aiRGgMb+Hwg8pi8iM
 8/3ak5GQPWrZqE54dr1R6j8B1iT4eo4DB3KeK9hjEuIGXFxMS9WNowtvC7TX/rZhMUwkge8
 VkQ2MiDQ9/7/LGawAj9ZA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:I+vvtfQuOOk=:pD72gCA25GzpRjFA0zPTHJ
 ZvLyhmGPM3g6aeufSnbPRATYYsGEt9jYkiOdYf9GSEQcHe8/oH71Q0L9u7jf5oBtacC4ZyVWs
 GWNJDbK4NcPadagYUzy0r7wDlRBoaMttxoySCRqCsalnwWLWQfUFsZtxMmkxzMNuODlYKScsV
 /nu/9ryuH3PRKNGyDNp7n8feQ5QZne7ZrNrz+EhmD1TG7UnDc8/d8nxEjSAavQPmeqb3VCWA5
 N590gaf+i/uwyAfYTizp5tUUQWv5EVoQyQbOlnSf0azsZEwgE2FZaxc6+CmNznVizfezIAThH
 M+MEfHMpiXIfwpS5q7TdKKdG3ylW2phnB+byQ18KyXYn+gVCJviG53B1T6madGnD+T2s+XEd4
 aQSDFBZjf1pBak4NElerpVWK/YMGTraFhKj5q0UdUPlsmQZ7Aqe9cIfhE2agYaLJptU1eUIDM
 //ZhfT2T4xdmjQinHO1UD/bXRYdzwZenlJdV41PjsVinRUJgSCHn+VGQhh+jpCpfYjjByfWfW
 o/8z9CbPf8JYB0NxpkJxOF/57BjvfhcMAT1T2uj1Ad85agId/fpQf3b+W2LN0qyVIqXIybbql
 2qeSBgsU3WI6SPXqUh0EdfQ1aCeExpZxCiwZLmTi1q0TK//JeycKmtVadxz+LLgMpyH/0oTic
 XesGMB1qDfszMrSZcmyC2cHtix1bh1JM/M6Oy4nzQ/hsnfSGChzMxPt3BSum2CmMYJUDTjdgc
 lNFasKw0Dxbor147UjWbmJw/zidRYxpPYbnEGl9IskipD3+V1nCnklbRc60/mqMlh6rz5jK7S
 QuDmTXbIrQ81NpRsfmblmLJ9V3ugM/vgxlUn0oOZIStjertWxDHduMNSptDux31Q+m9qTUqSS
 9tx5k5ZHa3ug/uHX41bWeksuF3/hU1yguYBFbJhaOvzQ+y3+1ur6ZzDEXfgewR+RF/madcO10
 0cVpq8SmGtZs1b9PBCgb6KuoHQ+oKL9DKYqRNUQMoCBnsOa3AwFXxvu9U4Vh4CdlOW4TEapo4
 RbXKDGipO2kJVQc6r8xcvsJYJdCao+CGeBBzwrj0pPPpK5OSmrKb8PTNstW+d/YVEdBGBYkPT
 GFnROrYwVksUIlOmev114oJ/OEtzfmLq54xURca154CZvvZ5Kv5D4E5KSUHqVJOM/Fu17+oNo
 JUHnXD6vjq4bkWOzk3LGZno5nprVb3LhKOsso4Ep3EM2ZhAiGMyW+KKd8m7/ZWM57Yo3aYJAd
 eTsoAky8mveVHEVHy
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

> Use kmemdup rather than duplicating its implementation

How do you think about to add the tag =E2=80=9CFixes=E2=80=9D to the chang=
e description?

Regards,
Markus
