Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 054F5154A37
	for <lists+linux-integrity@lfdr.de>; Thu,  6 Feb 2020 18:31:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727390AbgBFRb0 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 6 Feb 2020 12:31:26 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:46186 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727358AbgBFRbZ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 6 Feb 2020 12:31:25 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 016HT02e086564;
        Thu, 6 Feb 2020 17:30:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=K7CsAWV2I/Wti1tewqOHLMGUyy3ZOyrmWzgUJOIuDs8=;
 b=cft+KM4yzNXLP8s8te4EHuys/zL2HE6HROTBRYHZHoNua5cV5+sHx6ovQBIPmYrPVqob
 YWStUNHZsixtEZIy1FOK0rUSIHLRnn7aojxNXfWR8D6t9m+X8845KYOQS7Qk8Reudja+
 VYxh3ESrExFP0vPGvfvHSVOIeV01KhnBx1+njmsOwHO1XWcSfpoDtPKF2sYiEzRDMRtZ
 YODeQUYUiqPRA3RfMhtcGoIk5ajMqFavzbP3c+Sn73izq07LRlu25aADSwwkrHhgFqqW
 wNkyPzCdM2UKkpJOkvJA6T6Bkvx8Nf9XVQVoH0IcYo8Kf1IKN9oxMWin/RLqlWljEJpx Qg== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2019-08-05; bh=K7CsAWV2I/Wti1tewqOHLMGUyy3ZOyrmWzgUJOIuDs8=;
 b=dHf6zWppr3Yia16MMaFkgbgR/O4RMxwWOWlQnBousthFxssHT7I0WbGPh3A5vDP3mWg3
 ADww0m2V2syA4CY2CDBHkT8OPLWOyd4rb/j7kt+0vBlocn3GUji+u42TAcBy7KSbZxJo
 +ZBySFbPx9okyIvV4sYJUSh9TFCAw2PMli3rW8gLNBlC1LY9Z/H/lcWhrShZPr1GPGWG
 36N8x6XFCFDb2yMPwN5D85Q9ox0WUL7G03p1qzYBdq1rKsJsQtMmmntpe0fjghGiqU3Q
 lQ/uhEbusHi7lbyvB22hjYQW2cGB9yGMULLMblhEm7njR7PhIl308A75ysWYiw83LgmP Yw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 2xykbpk84s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 06 Feb 2020 17:30:51 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 016HTkeZ172387;
        Thu, 6 Feb 2020 17:30:51 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 2y0mnk3g76-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 06 Feb 2020 17:30:51 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 016HUmfl017145;
        Thu, 6 Feb 2020 17:30:48 GMT
Received: from dhcp-10-65-154-237.vpn.oracle.com (/10.65.154.237)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 06 Feb 2020 09:30:48 -0800
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [RFC PATCH 1/2] ima: Implement support for uncompressed module
 appended signatures
From:   Eric Snowberg <eric.snowberg@oracle.com>
In-Reply-To: <fda8b3e4-e3aa-a83a-0ddc-8ec096e67316@linux.microsoft.com>
Date:   Thu, 6 Feb 2020 10:30:45 -0700
Cc:     zohar@linux.ibm.com, dmitry.kasatkin@gmail.com, jmorris@namei.org,
        serge@hallyn.com, dhowells@redhat.com, geert@linux-m68k.org,
        gregkh@linuxfoundation.org, nayna@linux.ibm.com,
        tglx@linutronix.de, bauerman@linux.ibm.com, mpe@ellerman.id.au,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <9347B826-F924-4625-89CF-713303D8336D@oracle.com>
References: <20200206164226.24875-1-eric.snowberg@oracle.com>
 <20200206164226.24875-2-eric.snowberg@oracle.com>
 <fda8b3e4-e3aa-a83a-0ddc-8ec096e67316@linux.microsoft.com>
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
X-Mailer: Apple Mail (2.3273)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9523 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2002060132
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9523 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2002060132
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


> On Feb 6, 2020, at 10:07 AM, Lakshmi Ramasubramanian =
<nramas@linux.microsoft.com> wrote:
>=20
> On 2/6/2020 8:42 AM, Eric Snowberg wrote:
>=20
>>  @@ -31,6 +32,7 @@ static const char * const =
keyring_name[INTEGRITY_KEYRING_MAX] =3D {
>>  	".ima",
>>  #endif
>>  	".platform",
>> +	".builtin_trusted_keys",
>>  };
>>    #ifdef CONFIG_IMA_KEYRINGS_PERMIT_SIGNED_BY_BUILTIN_OR_SECONDARY
>> @@ -45,8 +47,11 @@ static struct key *integrity_keyring_from_id(const =
unsigned int id)
>>  		return ERR_PTR(-EINVAL);
>>    	if (!keyring[id]) {
>> -		keyring[id] =3D
>> -			request_key(&key_type_keyring, keyring_name[id], =
NULL);
>> +		if (id =3D=3D INTEGRITY_KEYRING_KERNEL)
>> +			keyring[id] =3D VERIFY_USE_SECONDARY_KEYRING;
>=20
> Since "Built-In Trusted Keyring" or "Secondary Trusted Keyring" is =
used, would it be more appropriate to name this identifier =
INTEGRITY_KEYRING_BUILTIN_OR_SECONDARY?

I=E2=80=99m open to changing INTEGRITY_KEYRING_KERNEL to =
INTEGRITY_KEYRING_BUILTIN_OR_SECONDARY if that seems more appropriate.

