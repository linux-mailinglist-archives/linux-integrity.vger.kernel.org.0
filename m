Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA9FA449CA4
	for <lists+linux-integrity@lfdr.de>; Mon,  8 Nov 2021 20:47:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237758AbhKHTtS (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 8 Nov 2021 14:49:18 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:20892 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237645AbhKHTtR (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 8 Nov 2021 14:49:17 -0500
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1A8JJria017246;
        Mon, 8 Nov 2021 19:46:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type; s=pp1; bh=ugrcpLgKNp1pNyKquc1V5bh+mrHNUKK8s1pMfDW/df4=;
 b=BenW864/wYtLUeu1AFTAWUGQLvjz/u2xAx0RwwvgFKQITc2YOgFqHiARZTFJaIGcIvcH
 kAelOV5sr8Teb7uwWRyWZmSeJwySTnhYdABDdCuspmCyAXPLVaUJ6SUGVMHMoqSaNLyG
 W8/flqTWa5vWPIJ5Lv49hixmzDIYIlnoaWNth0mdlzxlwbwspfyegcDkY+2aEgvuEJFx
 XBC/4lJT1z1JEzzDlztNMAS5naAM/USUG+U1OLnNeXq7Ap1QFWakNVN+pY1PqlR2Y6yG
 aGIqL9jjVaVFvUnqiOWNcgVsnQcrnfLMUN8/iPyWEr3Eg3UiBKUzc4eeovcgNxR/miRP mg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3c69dn7e2j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 08 Nov 2021 19:46:23 +0000
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1A8JcvZ9000345;
        Mon, 8 Nov 2021 19:46:23 GMT
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com [169.55.85.253])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3c69dn7e23-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 08 Nov 2021 19:46:23 +0000
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
        by ppma01wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1A8JgZ60018177;
        Mon, 8 Nov 2021 19:46:22 GMT
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com [9.57.198.26])
        by ppma01wdc.us.ibm.com with ESMTP id 3c5hbac1t3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 08 Nov 2021 19:46:22 +0000
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com [9.57.199.109])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1A8JkLWr18940456
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 8 Nov 2021 19:46:21 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8593F112062;
        Mon,  8 Nov 2021 19:46:21 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 72C91112063;
        Mon,  8 Nov 2021 19:46:19 +0000 (GMT)
Received: from [9.211.130.73] (unknown [9.211.130.73])
        by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon,  8 Nov 2021 19:46:19 +0000 (GMT)
Message-ID: <36ee20b3-cdd7-e879-7c8b-235578e41628@linux.ibm.com>
Date:   Mon, 8 Nov 2021 14:46:17 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: ima-evm-utils: version 1.4 released
Content-Language: en-US
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Petr Vorel <pvorel@suse.cz>, Mimi Zohar <zohar@linux.ibm.com>
Cc:     linux-integrity <linux-integrity@vger.kernel.org>,
        Vitaly Chikunov <vt@altlinux.org>,
        "Bruno E. O. Meneguele" <bmeneg@redhat.com>
References: <9af9143c2c90f1ebae6cc34a7100673332cce1a1.camel@linux.ibm.com>
 <YYToG+8u/edIcc3u@pevik>
 <e7213f8c-a6f5-f73e-d88f-a264e6d231bb@linux.microsoft.com>
From:   Ken Goldman <kgold@linux.ibm.com>
In-Reply-To: <e7213f8c-a6f5-f73e-d88f-a264e6d231bb@linux.microsoft.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256; boundary="------------ms000808020409010109060903"
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: kcSPofleDx9KtrlLR4j3KDpvDew1_qnC
X-Proofpoint-ORIG-GUID: TXqTrWt7hHMu2jxH6mgh2aXg3nfodYiz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-08_06,2021-11-08_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 mlxscore=0
 malwarescore=0 clxscore=1011 adultscore=0 bulkscore=0 spamscore=0
 priorityscore=1501 impostorscore=0 suspectscore=0 lowpriorityscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111080115
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

This is a cryptographically signed message in MIME format.

--------------ms000808020409010109060903
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/5/2021 12:21 PM, Lakshmi Ramasubramanian wrote:
> 
> On 11/5/2021 1:15 AM, Petr Vorel wrote:
>> Hi Mimi,
>>
>>> Please refer to the NEWS file for the short summary and the git history
>>> for details of the ima-evm-utils v1.4 release.
> 
> Thanks for the info Mimi.
> 
> I checked both "master" and "next-testing" branches in the following, and I still see 1.3.2 version only.
> 
>      https://github.com/pevik/ima-evm-utils
> 
> Is there a different github url for the latest ima-evm-utils source?
> 
> I am seeing the following errors when trying to validate IMA measurement using the util. I'd like to try the latest (v1.4).
> 
> sudo ./evmctl ima_measurement
> /sys/kernel/security/ima/binary_runtime_measurements  -vv
> 
> Error messages for the above command
> ------------------------------------
> Using tsspcrread to read PCRs.
> 
> tpm2_pcr_supported:67 Found 'tsspcrread' in $PATHread_tpm_banks:1923
> Failed to read sha1 PCRs: (TSS_Socket_Open: Error on connect to
> localhost:2321)
> 
> read_tpm_banks:1923 Failed to read sha256 PCRs: (TSS_Socket_Open: Error
> on connect to localhost:2321)
> 
> Failed to read any TPM PCRs
>

This sounds like your program is trying to connect to a SW TPM,
and the SW TPM process is not running.


--------------ms000808020409010109060903
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
hvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yMTExMDgxOTQ2MTdaMC8GCSqGSIb3DQEJBDEiBCDy
00lG4CrLDklwJQrCp/HHBsRC5RhH1KgVjbA9aJV8pjBsBgkqhkiG9w0BCQ8xXzBdMAsGCWCG
SAFlAwQBKjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwDgYIKoZIhvcNAwICAgCAMA0GCCqG
SIb3DQMCAgFAMAcGBSsOAwIHMA0GCCqGSIb3DQMCAgEoMIGnBgkrBgEEAYI3EAQxgZkwgZYw
gYExCzAJBgNVBAYTAklUMRAwDgYDVQQIDAdCZXJnYW1vMRkwFwYDVQQHDBBQb250ZSBTYW4g
UGlldHJvMRcwFQYDVQQKDA5BY3RhbGlzIFMucC5BLjEsMCoGA1UEAwwjQWN0YWxpcyBDbGll
bnQgQXV0aGVudGljYXRpb24gQ0EgRzMCEG2UL2axKkquvSuayu+VLvQwgakGCyqGSIb3DQEJ
EAILMYGZoIGWMIGBMQswCQYDVQQGEwJJVDEQMA4GA1UECAwHQmVyZ2FtbzEZMBcGA1UEBwwQ
UG9udGUgU2FuIFBpZXRybzEXMBUGA1UECgwOQWN0YWxpcyBTLnAuQS4xLDAqBgNVBAMMI0Fj
dGFsaXMgQ2xpZW50IEF1dGhlbnRpY2F0aW9uIENBIEczAhBtlC9msSpKrr0rmsrvlS70MA0G
CSqGSIb3DQEBAQUABIIBADEN3e6e2gGw8Qazugh7k2TQKm8Lfb9SxCbSCSmm1RvWLWPT49tL
OtKmkWXpMuuTInC1H9hEGGHL8ao+q8fedKizbi2vQZ05hR6sbHJpa/NLjsm1WNYeb7b0ecpX
Gm31GnydiLn/l/RdIvSpxpwtxSrNNdvtGDz70IW+1LjwI63gIYS/QCsxZZa3A6AtgI/1cy7n
umiaBziPZ3NDRYDuHonWTi+pyd9O0t+O5DYFsPns3Eir+/i/HzcsqvR0SBvF7G6g2GQMNctc
Yi/vAYiGTNGRs3ii7iQ7IhwLfDiOvxdeXtwVMoOm18otP1y+e2MSbyFMH3NnGsXeOiLei9Pp
MCkAAAAAAAA=
--------------ms000808020409010109060903--

