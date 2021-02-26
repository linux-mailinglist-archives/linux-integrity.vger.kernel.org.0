Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B7033269AD
	for <lists+linux-integrity@lfdr.de>; Fri, 26 Feb 2021 22:47:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229622AbhBZVqs (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 26 Feb 2021 16:46:48 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:3590 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229598AbhBZVqr (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 26 Feb 2021 16:46:47 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 11QLipsk138897;
        Fri, 26 Feb 2021 16:46:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type; s=pp1; bh=bQOb4NUYm81KkYF+cKJsZ6XptMkNy3hv52NZM2Aj94k=;
 b=h9lps9tV/6d+4ch9jUFTSggGecs5vxJq1XCLM0WbqSy2WoM+QWvi72Y1dYFO9nW6j2vh
 uDmcchmLPuGFQJzz8PQ8JRcgfpbR9pLXNVNQBX0vg0O2QTzJf1gwx45FUpZhLLCqAlBs
 jXVyNaMMDbBUyfOBcUHaAfFUmAkPepBSoAw4J7rpno3u6RjHy4X4JqLxLx2SxGe3K8gu
 lsat8wHeeqHnKfZuGljjGktwtz3d32ni7Y9f+qsKWrICFb8y6NYIoQSmMeIrUhDDPuKX
 dZbS9qhczY0/sV26QbUIV0NebEZtQYQfcSIHbGZKm9578R5I9K4aIyn/ZEs3kxFHLTmo Ig== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36y95tg0we-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 26 Feb 2021 16:46:01 -0500
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 11QLj2PL140057;
        Fri, 26 Feb 2021 16:46:01 -0500
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36y95tg0vu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 26 Feb 2021 16:46:01 -0500
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 11QLfxAu012268;
        Fri, 26 Feb 2021 21:46:00 GMT
Received: from b01cxnp22033.gho.pok.ibm.com (b01cxnp22033.gho.pok.ibm.com [9.57.198.23])
        by ppma03dal.us.ibm.com with ESMTP id 36v5y9xmyq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 26 Feb 2021 21:46:00 +0000
Received: from b01ledav002.gho.pok.ibm.com (b01ledav002.gho.pok.ibm.com [9.57.199.107])
        by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 11QLjxQb20840848
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 26 Feb 2021 21:45:59 GMT
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A94D1124058;
        Fri, 26 Feb 2021 21:45:59 +0000 (GMT)
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2A774124054;
        Fri, 26 Feb 2021 21:45:59 +0000 (GMT)
Received: from [9.85.162.49] (unknown [9.85.162.49])
        by b01ledav002.gho.pok.ibm.com (Postfix) with ESMTP;
        Fri, 26 Feb 2021 21:45:59 +0000 (GMT)
Subject: Re: [PATCH 0/3] Load keys from TPM2 NV Index on IMA keyring
To:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        Patrick Uiterwijk <patrick@puiterwijk.org>, peterhuewe@gmx.de,
        jarkko@kernel.org, jgg@ziepe.ca, zohar@linux.ibm.com,
        dmitry.kasatkin@gmail.com, linux-integrity@vger.kernel.org
Cc:     pbrobinson@gmail.com, stefanb@linux.ibm.com
References: <20210225203229.363302-1-patrick@puiterwijk.org>
 <1e41f22b1f11784f1e943f32bf62034d4e054cdb.camel@HansenPartnership.com>
From:   Ken Goldman <kgold@linux.ibm.com>
Message-ID: <72e8b5a3-edcf-ff82-7d6b-021ed633bf54@linux.ibm.com>
Date:   Fri, 26 Feb 2021 16:45:58 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <1e41f22b1f11784f1e943f32bf62034d4e054cdb.camel@HansenPartnership.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256; boundary="------------ms090207080305060400050308"
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-02-26_09:2021-02-26,2021-02-26 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 phishscore=0 suspectscore=0 mlxscore=0 impostorscore=0
 spamscore=0 adultscore=0 mlxlogscore=999 bulkscore=0 clxscore=1011
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102260159
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

This is a cryptographically signed message in MIME format.

--------------ms090207080305060400050308
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable


On 2/25/2021 4:50 PM, James Bottomley wrote:
> On Thu, 2021-02-25 at 21:32 +0100, Patrick Uiterwijk wrote:
>>
>> Note that if this feature is enabled, users should make sure an NV
>> Index is created with accurate attributes to prevent any other users
>> from writing or deleting the NV Index. Without this precaution, any
>> user who has access to the TPM would be able to write a key to the NV
>> Index and have that key loaded on the IMA trusted keyring.
>>
>> A distro who wants to enable this feature, for example, should ensure
>> that the installer defines the NV Index in all cases, and only fills
>> it if a key was provided by the user.
>=20
> This has some problematic security implications:  any member of the tpm=

> group (which is pretty much all users if you use the TPM for user space=

> secrets or other operations) can read and write NV indexes.  What does
> a distro do if the index is occupied on install (because it could be
> some malicious entity who's put their cert in the index)?
>=20
>> It is strongly adviced that any NV Index created for this purpose has
>> at least the policy_delete and policywrite attributes set, together
>> with a non-empty policy. Those flags make sure that the policy (which
>> would be up to them to define) is required to be satisfied to delete
>> or write the index.
>=20
> This isn't necessarily good enough.  Unless the index has
> PlatformCreate set, then any member of the tpm group can delete it with=

> TPM2_NV_UndefineIndex.  Creating stuff with TPM_NV_PLATFORMCREATE
> attributes is possible, but whoever does must know the platform policy
> or auth, so how would any distro get that if it's non standard (and if
> it is standard then any tpm user can delete the index with
> TPM2_NV_UndefineSpaceSpecial).
>=20
> The bottom line is I don't see how this could safely be used by a
> distribution in any standard manner, so why not simply pass the cert in=

> on the command line instead?  At least any random user can't then
> compromise the process.

Some ideas on this:

1 - Create the index such that it can be deleted by the platform (pre-OS,=

physical presence) but not post-OS.

E.g, create with TPMA_NV_POLICY_DELETE in the owner hierarchy, and with a=
 zero
length policy.  TPM2_Clear will delete it but the owner cannot.

2 - Permit reads with no authorization.

3 - Permit the first write (when the OS is first installed) with no autho=
rization.

E.g., write if written is clear.

If worried about a malicious first write, remove this step and use #5.

4 - Permit writes when a password is supplied locally, the password suppl=
ied
during first install.

5 - For remote update, permit a write when given a signed authorization b=
y an
update serve, e.g. a tang server.

E.g., the index policy says "accepts writes signed by this key".  The key=

signs an authorization to write a specific new value to NV.
Also:

It is not enough for the application to read the index data.  The applica=
tion
must read the index metadata (the Name in TCG jargon) to verify that the
index has the correct authorization metadata.



--------------ms090207080305060400050308
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
JTNkQWN0YWxpcyUyMFMucC5BLiUyZjAzMzU4NTIwOTY3LGMlM2RJVD9jZXJ0aWZpY2F0ZVJl
dm9jYXRpb25MaXN0O2JpbmFyeTA9oDugOYY3aHR0cDovL2NybDA1LmFjdGFsaXMuaXQvUmVw
b3NpdG9yeS9BVVRILVJPT1QvZ2V0TGFzdENSTDAdBgNVHQ4EFgQUvpepqoS/gL8QU30JMvnh
LjIbz3cwDgYDVR0PAQH/BAQDAgEGMA0GCSqGSIb3DQEBCwUAA4ICAQAmm+cbWQ10sxID6edV
94SAhc1CwzthHFfHpuYS30gisWUfWpgp43Dg1XzG2in3VGV7XrzCCGZh4JM/XQWp+4oxmyV4
2Qjz9vc8GRksgo6X2nYObPYZzQjda9wxsCB38i4G3H33w8lf9sFvl0xm4ZXZ2s2bF/PdqvrK
0ZgvF51+MoIPnli/wJBw3p72xbk5Sb1MneSO3tZ293WFzDmz7tuGU0PfytYUkG7O6annGqbU
1I6CA6QVKUqeFLPodSODAFqJ3pimKD0vX9MuuSa0QinH7CkiPtZMD0mpwwzIsnSs3qOOl60t
IZQOTc0I6lCe1LLhrz7Q75J6nNL9N5zVwZ1I3o2Lb8Dt7BA13VFuZvZIzapUGV83R7pmSVaj
1Bik1nJ/R393e6mwppsT140KDVLh4Oenywmp2VpBDuEj9RgICAO0sibv8n379LbO7ARa0kw9
y9pggFzN2PAX25b7w0n9m78kpv3z3vW65rs6wl7E8VEHNfv8+cnb81dxN3C51KElz+l31zch
FTurD5HFEpyEhzO/fMS5AkweRJIzwozxNs7OL/S/SVTpJLJL1ukZ1lnHHX0d3xCzRy/5HqfK
3uiG22LPB5+RjNDobPAjAz2BKMfkF/+v0pzn8mqqkopQaJzEAbLbMpgQYHRCjvrUxxwjJyUF
b2Z+40UNtMF4MTK7zTGCA/MwggPvAgEBMIGWMIGBMQswCQYDVQQGEwJJVDEQMA4GA1UECAwH
QmVyZ2FtbzEZMBcGA1UEBwwQUG9udGUgU2FuIFBpZXRybzEXMBUGA1UECgwOQWN0YWxpcyBT
LnAuQS4xLDAqBgNVBAMMI0FjdGFsaXMgQ2xpZW50IEF1dGhlbnRpY2F0aW9uIENBIEczAhBt
lC9msSpKrr0rmsrvlS70MA0GCWCGSAFlAwQCAQUAoIICLTAYBgkqhkiG9w0BCQMxCwYJKoZI
hvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yMTAyMjYyMTQ1NThaMC8GCSqGSIb3DQEJBDEiBCAN
CyyMHwqUQdYXg/TV42KMu7wjAr7eMZeRdx2UuUzapDBsBgkqhkiG9w0BCQ8xXzBdMAsGCWCG
SAFlAwQBKjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwDgYIKoZIhvcNAwICAgCAMA0GCCqG
SIb3DQMCAgFAMAcGBSsOAwIHMA0GCCqGSIb3DQMCAgEoMIGnBgkrBgEEAYI3EAQxgZkwgZYw
gYExCzAJBgNVBAYTAklUMRAwDgYDVQQIDAdCZXJnYW1vMRkwFwYDVQQHDBBQb250ZSBTYW4g
UGlldHJvMRcwFQYDVQQKDA5BY3RhbGlzIFMucC5BLjEsMCoGA1UEAwwjQWN0YWxpcyBDbGll
bnQgQXV0aGVudGljYXRpb24gQ0EgRzMCEG2UL2axKkquvSuayu+VLvQwgakGCyqGSIb3DQEJ
EAILMYGZoIGWMIGBMQswCQYDVQQGEwJJVDEQMA4GA1UECAwHQmVyZ2FtbzEZMBcGA1UEBwwQ
UG9udGUgU2FuIFBpZXRybzEXMBUGA1UECgwOQWN0YWxpcyBTLnAuQS4xLDAqBgNVBAMMI0Fj
dGFsaXMgQ2xpZW50IEF1dGhlbnRpY2F0aW9uIENBIEczAhBtlC9msSpKrr0rmsrvlS70MA0G
CSqGSIb3DQEBAQUABIIBAKa/ReNlnCSkaBfqK/4bXzaMHuhWzZ5ZzYVeiKG2gaSMxIpRTCHQ
aI5FVlWMpzUZUEceBh51KBc8JgDMJP4TFG9aEk3Bf3K4b1OXpdDOzWSmJL+9YJevCXOuxo3Z
NNxsHlXEJFxU3yMM9CvXr8ZuHoAJr7MzXbhIcwZ6UANj+hSyHSIs1zAEpvhRmPsjOslf7Yam
HSORqWMl3A7cADa55JiJbAI7O6TXQf8aIDcZ/5jEY3TKN0zxsIUPJ81QXbmsNZnXERbHQ5uN
6cRE+Xqv/7FB9oul/3Rxa4ywe0vpLSiz6iSK86OsIwBPlmgHchTqm7CXPODJlB+lsf/1iY3x
8ysAAAAAAAA=
--------------ms090207080305060400050308--

