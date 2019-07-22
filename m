Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 01CB170563
	for <lists+linux-integrity@lfdr.de>; Mon, 22 Jul 2019 18:25:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730237AbfGVQZU (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 22 Jul 2019 12:25:20 -0400
Received: from sonic301-9.consmr.mail.bf2.yahoo.com ([74.6.129.48]:34776 "EHLO
        sonic301-9.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730116AbfGVQZU (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 22 Jul 2019 12:25:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1563812718; bh=I7s0LQz3xGjNdo9rjbuOOVi1dzD2jYmAkG324hj2GYA=; h=Subject:To:References:From:Date:In-Reply-To:From:Subject; b=cLukG7W/1x5a0dMuTUjw6pfyDU0Km5tvijdsEFp2GCPrJe9ZKZG5HZgB6h8ERIrHFWFHvKM1jE3UiSKdelHGP16Fun57+tdHM0sYvKE3j9x02Kbu+c9BrjV7NrvX3z094ZB5+RxzFdsemzIOG1zn+/r//+qmgJfN8Ko0ubqz/NaAJQIGQsT7GFdowUtbZdIXQZJwEuv6fztQnTT9RIXxdAGCDsT1jKBmR/f/sJVohh/LXdIsHHXyQprSp3cTbd3Jmsv5IgguwBJJfhTWobBriY7dGmkgu3v8n9TGOFpYpO6QEWYsOYJxe6+JgK8HMutvCL9H0cqC999PfNFUCuUvTA==
X-YMail-OSG: KCey.jIVM1lBVdehHwNunO8guhgdHxLHNpq4RT2JyTmvzw7bzdNrKppBmSA7Mhm
 PerfEVjpsqag38biOXnQ0SBrU7Ee4OQoX7cOEr3ZYdTTgSPGMSxO.zJyobt739l2suIVYWV0Gh1f
 ZZQVxA5ejZBwEZtd54whbhbHOMKvlHh3SWSIKSh1ZoajxQpNbxEVcaJssnDcEduwH4gq_CaAy2y0
 _VWg8ktDjPPGbHMZdSo52.mPzhIgCj93ovZfQu60fSO9txfivt.Q1Niin855rOUQtv0.u85pQ_L4
 K3Sj9exYLPbtN.G.Ky3EVe33nbCRcMUyvoWQC6Hto6H4j.6EyMWazSs9y2Sx.Q9YTw_sS1dkWrhH
 pqR3A4dvA85JgmT.CkCW8G7aMN4UT6d0iDy55fSleVQuhqbFS8uZHxIkYvoD4UERllJX76UaYy2K
 z3zSg7RbgA59WSk1y_bMW3pNJmdHmPeMFaGU0h4PLv7DTV8y9AeS_dWXTqrJ00l4E1jb.MLTp_2H
 50H3FuhgG3vYsFhuHa.bd.g6xbS1GxWxgf1Q2ij_bVwMXfoPyS6ztFQArLqwFl.SiMrgXa0Hjo3N
 mA8my0MWwZNrKj3jqcRR1dbZjkNP7KJB7rAUWJNmh1KfC1X1nzM7WA1ahVEns7qQtRGFNDnQdRDk
 ZK9...a5ngn2rQbghrcSdG4x2pWBG1NyqE.NRvSyITq_P72Vm0I6stq6eZpXZIv_ptnEAHXnGiB9
 jUVIclbAUBFlVUWebZc.mKgl5SSxFpIq1vDixgI8irvJAXt_WH2Bcigc6XA2UXOJ8VobKHK..PLT
 pEWcbBbdQltZqhaYkeC7zhrkwUdke_fLkpZQ_YrM6mQd433u0rFUADj5Pi4.k2wn66MJJ2oiX1dT
 Qfi2Jrx6uUilP_oDHp3rS20IR2uUdNd.ztQSKNW2YdExtav4AiiKVHi2UGoaMDBhLiWpjNxnZWbo
 6ZHWDVojRFeWKnTMLENz2aXgHx3k5Y5usWAgANZQTz6UPw35PWzzOS58dRH6zsrhPFdx99WLdNws
 HD.M9pO5rSTjKzpZgtF_mQJTgBw60lAoTCbDNO2lHcFs8xYEIeiZqIM8AVft4xj85BemwhPgnZpg
 YCh5SwXITF4fwxDxk6Q.eguBrFAQf8SiU8xVoWsnBPhO_c3p3KNzXGb71SWAVSxTCQUYO7a2VBSD
 Q9KCveA5RGWoj4Urc0eN_AeXYjNgIpA8hcQ3tjbnKGYOo8buSF49SN.wYxcuQZfuQSSxl55XVR41
 .J8GtmZwTYJSu
Received: from sonic.gate.mail.ne1.yahoo.com by sonic301.consmr.mail.bf2.yahoo.com with HTTP; Mon, 22 Jul 2019 16:25:18 +0000
Received: by smtp414.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 5d3a9adf0e9529af0b785836bf6e52cd;
          Mon, 22 Jul 2019 16:25:17 +0000 (UTC)
Subject: Re: SMACK and keys
To:     Martin Townsend <mtownsend1973@gmail.com>,
        linux-integrity@vger.kernel.org, casey@schaufler-ca.com
References: <CABatt_yn_yjw-MOUnrPDyg-ZQd1AjaHkcJKxNBo8STC9o2EGrw@mail.gmail.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Openpgp: preference=signencrypt
Autocrypt: addr=casey@schaufler-ca.com; keydata=
 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
 abzjfg==
Message-ID: <165e3170-9b5a-7c75-9a9b-265ede62f55e@schaufler-ca.com>
Date:   Mon, 22 Jul 2019 09:25:18 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CABatt_yn_yjw-MOUnrPDyg-ZQd1AjaHkcJKxNBo8STC9o2EGrw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 7/22/2019 1:03 AM, Martin Townsend wrote:
> Hi,
>
> One of our developers has reported the following audit log entry when
> trying to add a key to the kernel's keyring when SMACK is enabled:
>
> Jul  9 09:33:23 mach-cw-rnet-ppm-1840 user.notice kernel: audit:
> type=3D1400 audit(1562664803.960:12): lsm=3DSMACK fn=3Dsmack_key_permis=
sion
> action=3Ddenied subject=3D"programmingapp" object=3D"_" requested=3Dw p=
id=3D905
> comm=3D"programmingapp" key_serial=3D98475196 key_desc=3D"_ses"

The Smack label on a key is set when the key is created,
and is set to the label of the process that created it.

> I had a quick look through the code in smack_lsm.c but can't see how
> I'm supposed to set a SMACK label for keys or keyrings.  Is it
> possible and if so how?

There is currently no way to change the Smack label on a key.

> We are running a 4.9 Kernel with not much
> chance of upgrading as it's a vendor kernel (linux-imx).  As it's an
> embedded system we are happy to hard code the SMACK labels into the
> kernel if this is possible?

In smack_key_alloc() change

	key->security =3D skp;

to
	key->security =3D &smack_known_star;

and all keys will have the star ("*") label, which
grants everyone access to them. Not the best solution
long term, but it should get you by.

> or is it set to '_' by design and we
> should add the key whilst the process is a privileged state before the
> SMACK label for the process has been set?

If you can run the program that creates the key with a label
other than floor ("_"), perhaps "keymaster", the key would be
labeled keymaster, and you could create access rules like

	programmingapp keymaster rw


>
> Many Thanks,
> Martin.

