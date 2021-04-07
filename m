Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 280B5356774
	for <lists+linux-integrity@lfdr.de>; Wed,  7 Apr 2021 11:00:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349806AbhDGJA2 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 7 Apr 2021 05:00:28 -0400
Received: from mail4.tencent.com ([183.57.53.109]:33402 "EHLO
        mail4.tencent.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233848AbhDGJA0 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 7 Apr 2021 05:00:26 -0400
X-Greylist: delayed 331 seconds by postgrey-1.27 at vger.kernel.org; Wed, 07 Apr 2021 05:00:24 EDT
Received: from EX-SZ018.tencent.com (unknown [10.28.6.39])
        by mail4.tencent.com (Postfix) with ESMTP id AAED0C603A;
        Wed,  7 Apr 2021 16:54:39 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tencent.com;
        s=s202002; t=1617785679;
        bh=wLcs5HJdPsEd0/IyfrDDCKbFAHmSbXPOqJcaEwkWK3E=;
        h=From:To:CC:Subject:Date:References;
        b=AugilU0ymKTimol2k6kO2rdx5e2VYD3PeWsrHSBjZ005D0JaJZjxaqBeFMq8/CSXc
         Xu8+EyJd26vbVFxm/FAL/X8m5W5VD63abI4C7GT9ObhKwM1OQaRXyZELEX1z1cPAII
         LNS0As8ZCRwOwhmmEukv0fzXTwmCJAg006ge1Yos=
Received: from EX-SZ013.tencent.com (10.28.6.37) by EX-SZ018.tencent.com
 (10.28.6.39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Wed, 7 Apr 2021
 16:54:39 +0800
Received: from EX-SZ003.tencent.com (10.28.6.15) by EX-SZ013.tencent.com
 (10.28.6.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Wed, 7 Apr 2021
 16:54:39 +0800
Received: from EX-SZ003.tencent.com ([fe80::d568:905c:3bcd:8f1f]) by
 EX-SZ003.tencent.com ([fe80::d568:905c:3bcd:8f1f%12]) with mapi id
 15.01.2106.013; Wed, 7 Apr 2021 16:54:39 +0800
From:   =?iso-2022-jp?B?aGVyYmVydGhibGkoGyRCTXs5MEduGyhCKQ==?= 
        <herberthbli@tencent.com>
To:     Jarkko Sakkinen <jarkko@kernel.org>,
        Hongbo Li <herbert.tencent@gmail.com>
CC:     "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        "dhowells@redhat.com" <dhowells@redhat.com>,
        "zohar@linux.ibm.com" <zohar@linux.ibm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>
Subject: Re: [PATCH 0/5] crypto: add rsa pss support for x509(Internet mail)
Thread-Topic: [PATCH 0/5] crypto: add rsa pss support for x509(Internet mail)
Thread-Index: AQHXKuZ2jiQgEg4HGkWw/fvJB5257A==
Date:   Wed, 7 Apr 2021 08:54:39 +0000
Message-ID: <0115cbd5a3154e8d868e98d564eba997@tencent.com>
References: <1617714686-25754-1-git-send-email-herbert.tencent@gmail.com>
 <YG1vakmzanwPGsvU@kernel.org>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.14.87.198]
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

=1B$B:_=1B(B 2021/4/7 16:38, Jarkko Sakkinen =1B$B<LF;=1B(B:=0A=
> On Tue, Apr 06, 2021 at 09:11:21PM +0800, Hongbo Li wrote:=0A=
>> From: Hongbo Li <herberthbli@tencent.com>=0A=
>>=0A=
>> This series of patches adds support for x509 cert signed by RSA=0A=
>> with PSS encoding method. RSA PSS is described in rfc8017.=0A=
> Please also briefly describe it here AND also provide link to the=0A=
> RFC. In the way this currently is, it is too time consuming to=0A=
> review the patch set.=0A=
>=0A=
> /Jarkko=0A=
=0A=
Thanks, will add that in the following patches.=0A=
=0A=
=0A=
>> This series of patches adds support for x509 cert signed by RSA=0A=
>> with PSS encoding method. RSA PSS is described in rfc8017.=0A=
>>=0A=
>> Patch1 make x509 support rsa pss algo and parse hash parameter.=0A=
>>=0A=
>> Patch2 add rsa pss template.=0A=
>>=0A=
>> Patch3 add test vector for rsa pss.=0A=
>>=0A=
>> Patch4 is the ecdsa ima patch borrowed from Stefan Berge's ecdsa=0A=
>>        patch series, rsa-pss's ima patch is made on top of this patch.=
=0A=
>>=0A=
>> Patch5 is the rsa-pss's ima patch.=0A=
>>=0A=
>> Test by the following script, it tests different saltlen, hash, mgfhash.=
=0A=
>>=0A=
>> keyctl newring test @u=0A=
>>=0A=
>> while :; do=0A=
>>     for modbits in 1024 2048 4096; do=0A=
>> 	if [ $modbits -eq 1024 ]; then=0A=
>> 	    saltlen=3D(-1 -2 0 20 32 48 64 94)=0A=
>> 	elif [ $modbits -eq 2048 ]; then=0A=
>> 	    saltlen=3D(-1 -2 0 20 32 48 64 222)=0A=
>> 	else=0A=
>> 	    saltlen=3D(-1 -2 0 20 32 48 64 478)=0A=
>> 	fi=0A=
>>=0A=
>> 	for slen in ${saltlen[@]}; do=0A=
>> 	    for hash in sha1 sha224 sha256 sha384 sha512; do=0A=
>> 		for mgfhash in sha1 sha224 sha256 sha384 sha512; do=0A=
>> 		    certfile=3D"cert.der"=0A=
>> 		    echo slen $slen=0A=
>> 		    openssl req \=0A=
>> 			    -x509 \=0A=
>> 			    -${hash} \=0A=
>> 			    -newkey rsa:$modbits \=0A=
>> 			    -keyout key.pem \=0A=
>> 			    -days 365 \=0A=
>> 			    -subj '/CN=3Dtest' \=0A=
>> 			    -nodes \=0A=
>> 			    -sigopt rsa_padding_mode:pss \=0A=
>> 			    -sigopt rsa_mgf1_md:$mgfhash \=0A=
>> 			    -sigopt rsa_pss_saltlen:${slen} \=0A=
>> 			    -outform der \=0A=
>> 			    -out ${certfile} 2>/dev/null=0A=
>>=0A=
>> 		    exp=3D0=0A=
>> 		    id=3D$(keyctl padd asymmetric testkey %keyring:test < "${certfile}=
")=0A=
>> 		    rc=3D$?=0A=
>> 		    if [ $rc -ne $exp ]; then=0A=
>> 			case "$exp" in=0A=
>> 			    0) echo "Error: Could not load rsa-pss certificate!";;=0A=
>> 			esac=0A=
>> 			echo "modbits $modbits sha: $hash mgfhash $mgfhash saltlen: $slen"=0A=
>> 			exit 1=0A=
>> 		    else=0A=
>> 			case "$rc" in=0A=
>> 			    0) echo "load cert: keyid: $id modbits $modbits hash: $hash mgfha=
sh $mgfhash saltlen $slen"=0A=
>> 			esac=0A=
>> 		    fi=0A=
>> 		done=0A=
>> 	    done=0A=
>> 	done=0A=
>>     done=0A=
>> done=0A=
>>=0A=
>> Hongbo Li (5):=0A=
>>   x509: add support for rsa-pss=0A=
>>   crypto: support rsa-pss encoding=0A=
>>   crypto: add rsa pss test vector=0A=
>>   crypto: ecdsa ima support=0A=
>>   ima: add support for rsa pss verification=0A=
>>=0A=
>>  crypto/Makefile                           |   7 +-=0A=
>>  crypto/asymmetric_keys/Makefile           |   7 +-=0A=
>>  crypto/asymmetric_keys/public_key.c       |   5 ++=0A=
>>  crypto/asymmetric_keys/x509_cert_parser.c |  71 ++++++++++++++++-=0A=
>>  crypto/rsa.c                              |  14 ++--=0A=
>>  crypto/rsa_helper.c                       | 127 +++++++++++++++++++++++=
+++++++=0A=
>>  crypto/testmgr.c                          |   7 ++=0A=
>>  crypto/testmgr.h                          |  87 ++++++++++++++++++++=0A=
>>  include/crypto/internal/rsa.h             |  25 +++++-=0A=
>>  include/keys/asymmetric-type.h            |   6 ++=0A=
>>  include/linux/oid_registry.h              |   2 +=0A=
>>  security/integrity/digsig_asymmetric.c    |  34 ++++----=0A=
>>  12 files changed, 363 insertions(+), 29 deletions(-)=0A=
>>=0A=
>> -- =0A=
>> 1.8.3.1=0A=
>>=0A=
>>=0A=
>=0A=
=0A=
