Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2BD7D5E113
	for <lists+linux-integrity@lfdr.de>; Wed,  3 Jul 2019 11:33:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725847AbfGCJdg (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 3 Jul 2019 05:33:36 -0400
Received: from mout.web.de ([212.227.17.11]:34977 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725820AbfGCJdg (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 3 Jul 2019 05:33:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1562146405;
        bh=MuIReLZrODBMR2dpGFuu0WuqH0PetKGbveXgbZ4+Ao8=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=AAT/yZiCTZk7ygGysyTWzg6AhPNX/RIghr/PEvEUbbBJNIvt2Sg2YUVKPXmchJj/c
         I5+kC9G1XYf8CpslMcR/64EalqGgtJC6SUf5mL9/OBQUWgN87Ab2FzOakwTDE/DxPd
         0uzO6E316jOPfz6FeimeINKQ2mgEI1WiYPZBCJbA=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.132.189.108]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MINAx-1hg8Ox4BX5-004Ebx; Wed, 03
 Jul 2019 11:33:25 +0200
Subject: Re: ima: Replace two seq_printf() calls by seq_puts() in
 ima_show_template_data_ascii()
To:     David Laight <David.Laight@ACULAB.COM>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
Cc:     Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        James Morris <jmorris@namei.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
References: <e96eac40-0745-80b5-6aab-f872e6415031@web.de>
 <d94bfdb9d53b46059787b9bdd10c5919@AcuMS.aculab.com>
From:   Markus Elfring <Markus.Elfring@web.de>
Openpgp: preference=signencrypt
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <6b7db918-8d0b-b280-91e4-c15e22451cfc@web.de>
Date:   Wed, 3 Jul 2019 11:33:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <d94bfdb9d53b46059787b9bdd10c5919@AcuMS.aculab.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:eTuH+cPnv7rUtZftUJKwLncs21EDbgKi6GOQLctscTNlkgbH2TB
 tP73jbN9bfn4h+dvRzFSQfm7eTwykLkN5pWIFRSfRQIzfw+/HkF8njwgkekXIE6gmoazTmo
 juwjkKL8YxLZ98nHqb52qaOcvwredZpKuCEPHVcOzsSchlKzXsGlsCVJNa0KJtjVs1EVHfO
 ouhTwJpTkBHGTHroSG6nA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:8qAnTI8UoOs=:o9nQL/LjU3d/cBB/NCG1gz
 mfu9xracmQfEXa6/p6kMirjCzhc8RDI+mL9APutJyTwSLgTQMmcRDCt6qmsLS2AhbtTXMLLPC
 nvmHHiziiIYAoOspyp6SFv4cECBGqXxfo07HMFy96Ss/KrGGAL4c8FtJXBy948CTZ7MDh6vuf
 vwvIW28r1ZE7PN/EabD6av2O5nTViGWGAlLGUzEUQd5UISYr1y90kf+WFuHsvlwvhU4kxPGEq
 Wn9KwRlMY6i7aqyb+rrWrU/pV2euekbWCOKgLajLKYzD3qaIbpX3FqspIQfqgruGuGE5PzkeS
 NjeCRyd7MVcFzrWAQ4R0Es/y2LY4j8KWvwRH7es6XeKGxicORuACc3FizE9KYPTjQDIC9N6gN
 /Y7lQy0EBLxBK13nJG8lQrnS7+71hX9bbkQcw9E8v+4DOj44FYQ+hVGDkThUSnLCbbrr1T3JH
 tNVmvso9ppQS7kf5L6QWAP6t65lSGPfBj1jA8ozjhPu3ub6itD64UKaloXot0A8j0/AXb875V
 dJLHf10g3iQ5oV7jSly2fafIJHBQVE8riHXa8Wy++AK19VXBDMRW3N5SVjqZuJxw5f2Ot6I7P
 7Xg4b1TGXkoTjMALws1fVv6tNKtrq96iCKG+jK9DqhceDwK63U0GcJhNlvqy1Srf0llMaMpji
 rgPzREXtFW53d2IDAkbhANku6kG0/cLjQWXgk1SaOH81aTuYX8XMD4Lh/cHq/895OtaJJhICV
 XiAy0FiYtquLc/I8wmn+PnDVaxNhXKETWBPWyypu8Zf+RytU0HGZUMZiEGxpDamHmM+0Qm24l
 SHA6NCx1OjwVXpKk9hXW0V3/ja2IEV+2v35TqeWMlM44Yv05Nt0jiZSf9A3npz2ZvzCb05kCo
 xS05Tt9p2dMw/xMQ/a3X+g4Ya1CjcSNVi2vtWcbimf3Zx+EOUbgbGugudRAc5/jmde7UaAowq
 iNPNiQAuCx1wRAXHeiJbL0fElkf1jwT8guvz/79r3hBIdytccP1TGEsPRtYmxKtK5Wx6KI89R
 1rkg2SWiGMPrcjdIN0WPwi+lm578vg97wDfUlXCUJCX/UBSuLiczZ98ojXCXm9tKE5GTrtmbL
 /UHs0CFwqXxTqyiv6s215+0ZlNAky1SY3yC
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

> So this is probably just a minor performance improvement in a code
> path where it really doesn't matter.

I imagine that another small software adjustment can help a bit
to get nicer run time characteristics also at this place.


>> +++ b/security/integrity/ima/ima_template_lib.c
>> @@ -74,7 +74,7 @@ static void ima_show_template_data_ascii(struct seq_f=
ile *m,
>>  	case DATA_FMT_DIGEST_WITH_ALGO:
>>  		buf_ptr =3D strnchr(field_data->data, buflen, ':');
>>  		if (buf_ptr !=3D field_data->data)
>> -			seq_printf(m, "%s", field_data->data);
>> +			seq_puts(m, field_data->data);
>>
>>  		/* skip ':' and '\0' */
>>  		buf_ptr +=3D 2;
>
> That code looks highly suspect!

Would you like to change this implementation detail any more?

Regards,
Markus
