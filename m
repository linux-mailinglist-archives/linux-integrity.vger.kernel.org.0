Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08882434156
	for <lists+linux-integrity@lfdr.de>; Wed, 20 Oct 2021 00:26:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229820AbhJSW2Z (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 19 Oct 2021 18:28:25 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:62844 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229632AbhJSW2Y (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 19 Oct 2021 18:28:24 -0400
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19JLpIlD029326;
        Tue, 19 Oct 2021 18:26:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : references : from : in-reply-to :
 content-type; s=pp1; bh=6aE4TnLYK4pD42kMRqsx7J2SSUlpzAY0vp95craxJow=;
 b=e14K4ZYEcyl4fdNnKlS5+j8WWPXWl9HNvSpfQVStVuN1sDXhFusVzYb6bEGcOMKsTgaG
 L2n+C4y2rRLuguQB8InKqvs5V99l+QBx0aCQ3MnQSMEdQdbyAXFScNr0jvqTTbIBSxLu
 5r+5Qgj6r4hGENrI1E0wWI3lJzaCnPrwPsd804i+wof+54mA4S6wzz1gGHvRCr6Qu2bQ
 zUDLp/X+/jo5FKcBofpssiS6puiu5cFe9U5p3+ydpOZQtqqc7CE2oyvdLMDIBPnQGIBN
 VHqv8sJ6BQrUmr5LZNDBauGiAv9KFd+OTxm27z+2okqc0IxNQwwYX3JWUfZstd9CNNka Tw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3bt6a50hr3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 19 Oct 2021 18:26:11 -0400
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 19JMG3Pm033973;
        Tue, 19 Oct 2021 18:26:11 -0400
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com [169.63.121.186])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3bt6a50hqs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 19 Oct 2021 18:26:11 -0400
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
        by ppma03wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 19JMI1DW003042;
        Tue, 19 Oct 2021 22:26:09 GMT
Received: from b03cxnp07027.gho.boulder.ibm.com (b03cxnp07027.gho.boulder.ibm.com [9.17.130.14])
        by ppma03wdc.us.ibm.com with ESMTP id 3bt4srtf1k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 19 Oct 2021 22:26:09 +0000
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp07027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 19JMQ99w34341348
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Oct 2021 22:26:09 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0501578063;
        Tue, 19 Oct 2021 22:26:09 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9BB257805E;
        Tue, 19 Oct 2021 22:26:08 +0000 (GMT)
Received: from [9.211.63.158] (unknown [9.211.63.158])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
        Tue, 19 Oct 2021 22:26:08 +0000 (GMT)
Message-ID: <c0768f9d-ef60-1a97-ec2d-a5e1130cbe03@linux.ibm.com>
Date:   Tue, 19 Oct 2021 18:26:07 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH 0/2] tpm: use SM3 instead of SM3_256
Content-Language: en-US
To:     Tianjia Zhang <tianjia.zhang@linux.alibaba.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
References: <20211009130828.101396-1-tianjia.zhang@linux.alibaba.com>
 <1749e7c3b528d361c09b40e5758b92c7386ffe1f.camel@linux.ibm.com>
 <c39fe737-203e-b124-db70-fce471ac6459@linux.alibaba.com>
From:   Ken Goldman <kgold@linux.ibm.com>
In-Reply-To: <c39fe737-203e-b124-db70-fce471ac6459@linux.alibaba.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256; boundary="------------ms060603050504060601060905"
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: XzjESC76d-Oh2Ip4vS5JrMVO_a5ld6Pk
X-Proofpoint-GUID: V3qivE1iCq9FMo2dlKm1Fq-1s84rCWyX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-19_02,2021-10-19_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 priorityscore=1501 suspectscore=0 mlxscore=0 adultscore=0 mlxlogscore=999
 impostorscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0
 clxscore=1011 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110190126
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

This is a cryptographically signed message in MIME format.

--------------ms060603050504060601060905
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit




On 10/11/2021 3:02 AM, Tianjia Zhang wrote:
> 
> Thanks for your attention. This is really tricky. I will contact trustedcomputinggroup first and give some suggestions, It would be best if a more standard algorithm name can be used from the source of the specification.

This was discussed in the TCG's TPM WG in February, 2020.  At the time,
someone said that there was a possibility of a 512-bit version in the
future.

For TCG members:

https://members.trustedcomputinggroup.org/wg/TPMWG/mail/thread/61442#136758

My guess is that, since it's already in many TCG specs and code, TCG
will want to leave it as is.


--------------ms060603050504060601060905
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
hvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yMTEwMTkyMjI2MDhaMC8GCSqGSIb3DQEJBDEiBCCD
L4HCMF/Se9f/UvtU/2VQUyJz4x2HWsbv6FTG3pAzxDBsBgkqhkiG9w0BCQ8xXzBdMAsGCWCG
SAFlAwQBKjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwDgYIKoZIhvcNAwICAgCAMA0GCCqG
SIb3DQMCAgFAMAcGBSsOAwIHMA0GCCqGSIb3DQMCAgEoMIGnBgkrBgEEAYI3EAQxgZkwgZYw
gYExCzAJBgNVBAYTAklUMRAwDgYDVQQIDAdCZXJnYW1vMRkwFwYDVQQHDBBQb250ZSBTYW4g
UGlldHJvMRcwFQYDVQQKDA5BY3RhbGlzIFMucC5BLjEsMCoGA1UEAwwjQWN0YWxpcyBDbGll
bnQgQXV0aGVudGljYXRpb24gQ0EgRzMCEG2UL2axKkquvSuayu+VLvQwgakGCyqGSIb3DQEJ
EAILMYGZoIGWMIGBMQswCQYDVQQGEwJJVDEQMA4GA1UECAwHQmVyZ2FtbzEZMBcGA1UEBwwQ
UG9udGUgU2FuIFBpZXRybzEXMBUGA1UECgwOQWN0YWxpcyBTLnAuQS4xLDAqBgNVBAMMI0Fj
dGFsaXMgQ2xpZW50IEF1dGhlbnRpY2F0aW9uIENBIEczAhBtlC9msSpKrr0rmsrvlS70MA0G
CSqGSIb3DQEBAQUABIIBAE2dV4Qou4VHiahyrcK6EkfE8f31X8v7FRJ1VEs7mMRiS/PT9faB
8GHtx+zBSo634esopg03kdmLEXIEDg949TSAQf+j+mdsSlJwtD3TIY7EB5pghq/w4adD9ESF
F+VR1ihDeFPWZjYcJIebBEwfTbQVCOw4kOpxnehw93kP0d2BcoBsfXSvd46d/pkWvWHnLoyt
IGFWqIRA6z05wp/O/AtcfpZASYgJ+RwIJPvCclIkQk9wMnCwx5bcaLYpOV8LfTxjpSNDKxF2
cN6fqYa5MBJUI90n4V4sWb9inPrjBeUEdGJ9BQzPR/QCWoYS2SSI50ygipd2RvqeGnDAqIrS
S7gAAAAAAAA=
--------------ms060603050504060601060905--

