Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BA248B4051
	for <lists+linux-integrity@lfdr.de>; Mon, 16 Sep 2019 20:29:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390363AbfIPS3o (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 16 Sep 2019 14:29:44 -0400
Received: from 2.mo1.mail-out.ovh.net ([178.32.119.250]:36953 "EHLO
        2.mo1.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726648AbfIPS3n (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 16 Sep 2019 14:29:43 -0400
X-Greylist: delayed 8817 seconds by postgrey-1.27 at vger.kernel.org; Mon, 16 Sep 2019 14:29:41 EDT
Received: from player693.ha.ovh.net (unknown [10.109.159.35])
        by mo1.mail-out.ovh.net (Postfix) with ESMTP id 8102218FC11
        for <linux-integrity@vger.kernel.org>; Mon, 16 Sep 2019 18:02:42 +0200 (CEST)
Received: from 3mdeb.com (85-222-117-222.dynamic.chello.pl [85.222.117.222])
        (Authenticated sender: piotr.krol@3mdeb.com)
        by player693.ha.ovh.net (Postfix) with ESMTPSA id 5155D9D825CE;
        Mon, 16 Sep 2019 16:02:36 +0000 (UTC)
Subject: Re: LPC System Boot and Security Microconference (subject change)
To:     Jerry Snitselaar <jsnitsel@redhat.com>,
        Mimi Zohar <zohar@linux.ibm.com>
Cc:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        linux-integrity@vger.kernel.org, Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>
References: <20190916073535.25117-1-jarkko.sakkinen@linux.intel.com>
 <20190916074657.GA26795@linux.intel.com>
 <1568635613.4975.40.camel@linux.ibm.com>
 <20190916134437.dx7aniyzsmoal45l@cantor>
From:   =?UTF-8?Q?Piotr_Kr=c3=b3l?= <piotr.krol@3mdeb.com>
Openpgp: preference=signencrypt
Autocrypt: addr=piotr.krol@3mdeb.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <4a51563d-3d8b-24b6-a529-1fbe8f60678e@3mdeb.com>
Date:   Mon, 16 Sep 2019 18:02:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190916134437.dx7aniyzsmoal45l@cantor>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 12835821888172706887
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrudefgdeljecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512



On 9/16/19 3:44 PM, Jerry Snitselaar wrote:
> On Mon Sep 16 19, Mimi Zohar wrote:

Hi Mimi,

>> On Mon, 2019-09-16 at 10:46 +0300, Jarkko Sakkinen wrote:
>>> My excuse is the overnight flight last night (no sleep).
>> 
>> Sorry I couldn't make LPC.  Did anyone takes notes of the LPC
>> System Boot and Security microconference?
>> 
>> thanks,
>> 
>> Mimi
>> 
> 
> There is an etherpad somewhere, but I haven't found a link to it
> yet, and there will eventually be videos posted as well.
> 

Link to etherpad:
https://etherpad.net/p/LPC2019_System_Boot_and_Security

Best Regards,
- -- 
Piotr Król
Embedded Systems Consultant
GPG: B2EE71E967AA9E4C
https://3mdeb.com | @3mdeb_com
-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE4DCbLYWmfoRjKeNLsu5x6WeqnkwFAl1/shoACgkQsu5x6Weq
nkwYGBAAr6PSE1F0Cr3f0izrkmq+RA60aSG1/UHvDrie/kVCsrbFPb7UFYrqePBr
+tw4fUSeVu5+8dSHoKjtT+AXaUo3AO4ChCCI/9Z57gaIu/35Qt+qtGu+Jo6mnK5x
wAI/2Lr+7uO+KL3AmBVkAMta2hpKkMdWv/9Lnd3MvVO4DUnp5QRiVTBCWQvLa8SW
3Z0KNudpz5iRVieRJBXHR5y6ZKXK2jq5PSvsp2UjtLo6oajH0Syh0L2LBbzPp27n
rd7k2sMWlLcTKgRZYETRrkzwHXjKNiUhqaWBjRDVTFQLQoa+8s+O1JI/qDIZb274
6CtypT20xArSZGqGE9GhXEodBUXa9QTOWtHhwe8r/ImO3e42U+mW8xuwA4g4aTju
Axcg4FIAyVRN/Egp5aFncJE6N2f5vfu3thMzSPmPzSrxHA3tc3fSip+UlpMiO5f+
xM+8GIjnbkyK408SGvS577xOgu7TJOlT0y9HCjy1pQlNSlTy6tTEVzgwvM5ntZSv
TGsRzy1j0SIPBJCh4+MNPQk3CyLui4uSAi6G2olu9swS8Qcu+enAYLIfaCtfadMd
F1FKnSYIa0je9Nx3kjOVzl8/1Q4jHIWKTq8YxFftLKGWDxd7yMzLH01W0hkWQfJT
aknsSKTDy5WPh9pFKNxl4znSfFyarSn7t7Ro8IiiZwXtjpooY6Y=
=IjQC
-----END PGP SIGNATURE-----
